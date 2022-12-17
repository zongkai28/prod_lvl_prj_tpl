project( staticlibdemo )

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


include_directories(include module)

aux_source_directory(module      LIB_SRC)

ADD_LIBRARY(${PROJECT_NAME} STATIC ${LIB_SRC})


SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES CLEAN_DIRECT_OUTPUT 1)


file(COPY include/sub.hpp DESTINATION ${CMAKE_BINARY_DIR}/../out/include/staticlibdemo)

if (UT_TEST)
    aux_source_directory(uttest LIB_SRC)

    add_executable(${PROJECT_NAME}_uttest ${LIB_SRC})

    target_link_libraries(${PROJECT_NAME}_uttest PRIVATE pthread rt gtest_main)
endif()
