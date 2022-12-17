project( demo )

message("CMAKE_PROJECT_NAME = ${CMAKE_PROJECT_NAME}")
message("PROJECT_NAME       = ${PROJECT_NAME}")

add_definitions(-DPROJECT_NAME=\"${PROJECT_NAME}\")

include_directories(
    ${CMAKE_BINARY_DIR}/../3rdpart/include
    ${CMAKE_BINARY_DIR}/../out/include
)

link_directories(
    ${CMAKE_BINARY_DIR}/../3rdpart/lib
    ${CMAKE_BINARY_DIR}/../out/lib
)


include_directories(module)

aux_source_directory(module   ALL_SRC)

add_executable(${PROJECT_NAME} main.cpp  ${ALL_SRC})

target_link_libraries(${PROJECT_NAME} PRIVATE pthread rt)

if (UT_TEST)
    aux_source_directory(uttest ALL_SRC)

    add_executable(${PROJECT_NAME}_uttest ${ALL_SRC})

    target_link_libraries(${PROJECT_NAME}_uttest PRIVATE pthread rt gtest gtest_main)
endif()