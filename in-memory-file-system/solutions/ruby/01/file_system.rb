require 'pry'

#####
class InMemoryFileSystem
	attr_reader :root_folder

	class File
		attr_reader :file_name
	  attr_accessor :content

		def initialize(file_name)
			@file_name = file_name
			@content = ''
		end

		def append_to_file(new_content)
			self.content += new_content
		end
	end

	class Folder
		attr_reader :folder_name, :children

		def initialize(folder_name)
			@folder_name = folder_name
			@children = {}
		end

		# add a child folder
		def add_folder(folder_name)
			@children[folder_name] = InMemoryFileSystem::Folder.new(folder_name)
		end

		def add_file(file_name)
			@children[file_name] = InMemoryFileSystem::File.new(file_name)
		end
	end

	def initialize
		@root_folder = Folder.new('/')
	end

	def addContentToFile(file_path, content)
		file = touch(file_path)
		file.append_to_file(content)
		return # to return nothing 
	end

	def readContentFromFile(file_path)
		file = touch(file_path)
		file.content
	end

	# since touch is used by addContentToFile to create a file if it exists
	# because we need to append content to a file
	# we cant throw an error if the file already exists
	def touch(file_path)
		if root_folder.folder_name == file_path
			return root_folder.children.keys.sort
		end

		path_folders = split_path(file_path)
		temp_root = root_folder

		# navigate to the directory
		path_folders.each_with_index do |name, i|
		  if i == path_folders.length - 1 # last element is the file name
		    temp_root.add_file(name) unless temp_root.children.key?(name)
		  end

		  temp_root = temp_root.children[name]
		end

		temp_root
	end

	# iterate over each array item
	# 
	# creates a new directory
	# but it doesn't do -p 
	def mkdir(path)
	  temp_root = root_folder
	  path_folders = split_path(path)

	  path_folders.each do |folder_name|

	  	unless temp_root.children.key?(folder_name)
	    	temp_root.add_folder(folder_name)
	    end

	    # Move into the newly created folder
	    temp_root = temp_root.children[folder_name]
	  end
	end

	def ls(path)
		if root_folder.folder_name == path
			return root_folder.children.keys.sort
		end

		temp_root = root_folder
		path_folders = split_path(path)

		path_folders.each_with_index do |name, i|
			raise 'No such file or directory' unless temp_root.children.key?(name)
			temp_root = temp_root.children[name]

			if i == path_folders.length - 1
				return temp_root.children.keys.sort
			end
		end
	end

	private

	def split_path(input)
	  Pathname.new(input).each_filename.to_a
	end
end








