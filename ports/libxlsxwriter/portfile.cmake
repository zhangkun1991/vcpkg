include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jmcnamara/libxlsxwriter
    REF RELEASE_0.8.6
    SHA512 60822dc5f87531edc97cf774e234f25229a605d4430061c24b95c387318e6e05dde1b0f2f433cea14c6f84ee901c1dffe0d174bfd7e2a8459f59bcee900097db
    HEAD_REF master
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(STATIC OFF)
else()
    set(STATIC ON)
endif()

set(VCPKG_CXX_FLAGS "${VCPKG_CXX_FLAGS} -utf-8")
set(VCPKG_C_FLAGS "${VCPKG_C_FLAGS} -utf-8")

file(REMOVE ${SOURCE_PATH}/cmake/Findzlib.cmake)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS 
	    -DBUILD_TESTS=OFF 
		-DBUILD_EXAMPLES=OFF 
		-DUSE_STATIC_MSVC_RUNTIME=${STATIC} 
		-DCMAKE_DEBUG_POSTFIX=d
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/libxlsxwriter RENAME copyright)

vcpkg_copy_pdbs()
