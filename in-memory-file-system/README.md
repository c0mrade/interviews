# In-Memory File System

Design an in-memory file system to simulate the following functions:

- **ls**: Given a path in string format. If it is a file path, return a list that only contains this file's name. If it is a directory path, return the list of file and directory names in this directory. Your output (file and directory names together) should be in lexicographic order (a-z).

- **mkdir**: Given a directory path that does not exist, you should make a new directory according to the path. If the middle directories in the path don't exist either, you should create them as well. This function has void return type.

- **addContentToFile**: Given a file path and file content in string format. If the file doesn't exist, you need to create that file containing given content. If the file already exists, you need to append given content to the original content. This function has void return type.

- **readContentFromFile**: Given a file path, return its content in string format.