# spec/in_memory_file_system_spec.rb
# Design an in-memory file system to simulate the following functions:

# ls: Given a path in string format. If it is a file path, return a list that only contains this file's name. If it is a directory path, return the list of file and directory names in this directory. Your output (file and directory names together) should be in lexicographic order (a-z).
# mkdir: Given a directory path that does not exist, you should make a new directory according to the path. If the middle directories in the path don't exist either, you should create them as well. This function has void return type.
# addContentToFile: Given a file path and file content in string format. If the file doesn't exist, you need to create that file containing given content. If the file already exists, you need to append given content to original content. This function has void return type.
# readContentFromFile: Given a file path, return its content in string format.

require 'rspec'
require_relative 'file_system.rb'

RSpec.describe InMemoryFileSystem do
  let(:fs) { InMemoryFileSystem.new }

  describe '#mkdir' do
    it 'creates a directory at the root level' do
      fs.mkdir('/home')
      expect(fs.ls('/')).to eq(['home'])
    end

    it 'creates nested directories' do
      fs.mkdir('/home/users')
      expect(fs.ls('/home')).to eq(['users'])
    end

    it 'creates multiple directories at the same level' do
      fs.mkdir('/home/users/emir')
      expect(fs.ls('/home/users')).to eq(['emir'])
    end

    it 'creates directories lexicographically' do
      fs.mkdir('/home/users/emir/preda')
      fs.mkdir('/home/users/emir/spreda')
      fs.mkdir('/home/users/emir/apuu')
      expect(fs.ls('/home/users/emir')).to eq(['apuu', 'preda', 'spreda'])
    end
  end

  describe '#ls' do
    context 'when listing an empty directory' do
      it 'returns an empty list' do
        fs.mkdir('/home/users/emir/preda')
        expect(fs.ls('/home/users/emir/preda')).to eq([])
      end
    end

    context 'when path does not exist' do
      it 'raises an error for non-existent directories' do
        expect { fs.ls('/nonexistent') }.to raise_error('No such file or directory')
      end
    end
  end

  describe '#touch' do
    it 'creates a file in the root folder' do
      fs.touch('/root_file.txt')
      expect(fs.ls('/')).to eq(['root_file.txt'])
    end

    it 'creates a file in an existing folder' do
      fs.mkdir('/home')
      fs.touch('/home/file.txt')
      expect(fs.ls('/home')).to eq(['file.txt'])
    end

    it 'returns the newly created file object' do
      expect(fs.touch('file.txt').file_name).to eq('file.txt')
    end

    it 'returns the existing file object name' do
      fs.mkdir('/home')
      fs.touch('/home/file.txt')
      expect(fs.touch('/home/file.txt').file_name).to eq('file.txt')
    end
  end

  describe '#addContentToFile' do
    it 'creates a file and adds initial content' do
      fs.addContentToFile('/test.txt', 'Hello, world!')
      expect(fs.readContentFromFile('/test.txt')).to eq('Hello, world!')
    end

    it 'appends content to an existing file' do
      fs.addContentToFile('/test.txt', 'Hello, world!')
      fs.addContentToFile('/test.txt', ' Welcome to the file system!')
      expect(fs.readContentFromFile('/test.txt')).to eq('Hello, world! Welcome to the file system!')
    end
  end

  describe '#readContentFromFile' do
    context 'when file exists' do
      it 'returns the content of an existing file' do
        fs.addContentToFile('/example.txt', 'This is a test file.')
        expect(fs.readContentFromFile('/example.txt')).to eq('This is a test file.')
      end
    end

    context 'when file does not exist' do
      it 'creates the file and returns an empty string if no content is added' do
        expect(fs.readContentFromFile('/empty_file.txt')).to eq('')
      end
    end
  end
end