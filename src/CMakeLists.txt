# 包含子目录
file(COPY plat_version.h DESTINATION ${CMAKE_BINARY_DIR}/../out/include)

add_subdirectory( demo )
add_subdirectory( dynamiclibdemo )
add_subdirectory( staticlibdemo )

