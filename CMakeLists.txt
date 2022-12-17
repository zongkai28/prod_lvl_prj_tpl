# need at least 3.11 version to support FetchContent
cmake_minimum_required( VERSION 3.11 )

# warning free
project(Project)

# Print some standard CMake variables
message(STATUS "CMake version: ${CMAKE_VERSION}")


# 获取当前git仓库的tag log信息 GIT_BR_VERSION GIT_CMID_VERSION
execute_process(
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMAND bash "-c" "git branch --contain HEAD | grep '*' | head -n1 | cut -d' ' -f 2-" 
    TIMEOUT 5
    OUTPUT_VARIABLE GIT_BR_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
message(STATUS "building from git tag ${GIT_BR_VERSION}")
add_definitions(-DGIT_BR_VERSION=\"${GIT_BR_VERSION}\")

execute_process(
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMAND git log -1 --pretty=format:%h
    TIMEOUT 5
    OUTPUT_VARIABLE GIT_CMID_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
message(STATUS "building from git log ${GIT_CMID_VERSION}")
add_definitions(-DGIT_CMID_VERSION=\"${GIT_CMID_VERSION}\")


# 输出目录
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/out/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/out/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/out/bin)


# external dependency
include(FetchContent)
FetchContent_Declare(
  googletest
  # Specify the commit you depend on and update it regularly.
  #URL https://github.com/google/googletest/archive/refs/tags/release-1.12.1.zip
  URL  ${PROJECT_SOURCE_DIR}/tool/googletest/release-1.12.1.zip
  DOWNLOAD_EXTRACT_TIMESTAMP FALSE
)
FetchContent_MakeAvailable(googletest)


add_subdirectory( src )
