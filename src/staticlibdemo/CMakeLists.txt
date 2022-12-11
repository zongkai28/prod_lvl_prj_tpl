project( staticlibdemo )

message("CMAKE_PROJECT_NAME = ${CMAKE_PROJECT_NAME}")
message("PROJECT_NAME       = ${PROJECT_NAME}")

add_definitions(-DPROJECT_NAME=\"${PROJECT_NAME}\")


file(READ "${CMAKE_BINARY_DIR}/../out/include/plat_version.h" plat_verinfo)
message("${plat_verinfo}")

file(READ "project_version.h" project_verinfo)
message("${project_verinfo}")

string(REGEX MATCH "#define PLAT_VER_MINOR            [(]([0-9]*)[)]" _ ${plat_verinfo})
set(ver_minor ${CMAKE_MATCH_1})

string(REGEX MATCH "#define PROJECT_VER_REVISION      [(]([0-9]*)[)]" _ ${project_verinfo})
set(ver_revision ${CMAKE_MATCH_1})

message("version: ${ver_minor}.${ver_revision}")


include_directories(
    ${CMAKE_BINARY_DIR}/../3rdpart/include
    ${CMAKE_BINARY_DIR}/../out/include
)

link_directories(
    ${CMAKE_BINARY_DIR}/../3rdpart/lib
    ${CMAKE_BINARY_DIR}/../out/lib
)

include_directories(inc src)

aux_source_directory(src      LIB_SRC)

ADD_LIBRARY(${PROJECT_NAME} STATIC ${LIB_SRC})


SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES CLEAN_DIRECT_OUTPUT 1)
SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES VERSION ${ver_minor}.${ver_revision})


file(COPY inc DESTINATION ${CMAKE_BINARY_DIR}/../out)


if (UT_TEST)
    include_directories(${CMAKE_BINARY_DIR}/../external/googletest/out/include)
    link_directories(${CMAKE_BINARY_DIR}/../external/googletest/out/lib)

    aux_source_directory(uttest LIB_SRC)

    add_executable(${PROJECT_NAME}_uttest ${LIB_SRC})

    target_link_libraries(${PROJECT_NAME}_uttest PRIVATE pthread rt shdds gtest gtest_main)
endif()