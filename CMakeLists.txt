cmake_minimum_required( VERSION 3.10 )

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


# GoogleTest requires at least C++11
set(CMAKE_CXX_STANDARD 11)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)


# 输出目录
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/out/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/out/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/out/bin)

add_subdirectory( src )
