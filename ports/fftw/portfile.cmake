include(vcpkg_common_functions)

set(VERSION 3.3.8)

vcpkg_download_distfile(ARCHIVE_FILE
    URLS "http://www.fftw.org/fftw-${VERSION}.tar.gz"
    FILENAME "fftw-${VERSION}.tar.gz"
    SHA512 ab918b742a7c7dcb56390a0a0014f517a6dff9a2e4b4591060deeb2c652bf3c6868aa74559a422a276b853289b4b701bdcbd3d4d8c08943acf29167a7be81a38
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE_FILE}
    REF ${VERSION}
)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES "${CMAKE_CURRENT_LIST_DIR}/0001-fix-cmake-prec-suffix.patch"
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(SHARED_LIB OFF)
else()
    set(SHARED_LIB ON)
endif()

if (TRIPLET_SYSTEM_ARCH MATCHES "x86" OR TRIPLET_SYSTEM_ARCH MATCHES "x64")
    set(ENABLE_AVX_SSE ON)
else()
    set(ENABLE_AVX_SSE OFF)
endif()

#single precision
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
	  PREFER_NINJA
    OPTIONS
      -DENABLE_FLOAT=ON
      -DENABLE_LONG_DOUBLE=OFF
	    -DENABLE_AVX=${ENABLE_AVX_SSE}
      -DENABLE_AVX2=${ENABLE_AVX_SSE}
	    -DENABLE_SSE=${ENABLE_AVX_SSE}
	    -DENABLE_SSE2=${ENABLE_AVX_SSE}
	    -DBUILD_TESTS=OFF
	    -DBUILD_SHARED_LIBS=${SHARED_LIB}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3f/FFTW3fConfig.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)
file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3f/FFTW3fConfigVersion.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)

file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3f/FFTW3fLibraryDepends.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)
file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3f/FFTW3fLibraryDepends-release.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)
file(COPY ${CURRENT_PACKAGES_DIR}/debug/lib/cmake/fftw3f/FFTW3fLibraryDepends-debug.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)

#file(RENAME ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3LibraryDepends.cmake   ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3fLibraryDepends.cmake)
#file(RENAME ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3LibraryDepends-release.cmake   ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3fLibraryDepends-release.cmake)
#file(RENAME ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3LibraryDepends-debug.cmake   ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3fLibraryDepends-release.cmake)

#long double precision
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
	  PREFER_NINJA
    OPTIONS
      -DENABLE_FLOAT=OFF
      -DENABLE_LONG_DOUBLE=ON
#AVX only works in single or double precision
	    -DENABLE_AVX=OFF
      -DENABLE_AVX2=OFF
	    -DENABLE_SSE=${ENABLE_AVX_SSE}
	    -DENABLE_SSE2=${ENABLE_AVX_SSE}
	    -DBUILD_TESTS=OFF
	    -DBUILD_SHARED_LIBS=${SHARED_LIB}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3l/FFTW3lConfig.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)
file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3l/FFTW3lConfigVersion.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)

file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3l/FFTW3lLibraryDepends.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)
file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3l/FFTW3lLibraryDepends-release.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)
file(COPY ${CURRENT_PACKAGES_DIR}/debug/lib/cmake/fftw3l/FFTW3lLibraryDepends-debug.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)

#file(RENAME ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3LibraryDepends.cmake   ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3lLibraryDepends.cmake)
#file(RENAME ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3LibraryDepends-release.cmake   ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3lLibraryDepends-release.cmake)
#file(RENAME ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3LibraryDepends-debug.cmake   ${CURRENT_PACKAGES_DIR}/share/fftw/FFTW3lLibraryDepends-release.cmake)

#double precision
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
	  PREFER_NINJA
    OPTIONS
      -DENABLE_FLOAT=OFF
      -DENABLE_LONG_DOUBLE=OFF
	    -DENABLE_AVX=${ENABLE_AVX_SSE}
      -DENABLE_AVX2=${ENABLE_AVX_SSE}
	    -DENABLE_SSE=${ENABLE_AVX_SSE}
	    -DENABLE_SSE2=${ENABLE_AVX_SSE}
	    -DBUILD_TESTS=OFF
	    -DBUILD_SHARED_LIBS=${SHARED_LIB}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3/FFTW3Config.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)
file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3/FFTW3ConfigVersion.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)

file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3/FFTW3LibraryDepends.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)
file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake/fftw3/FFTW3LibraryDepends-release.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)
file(COPY ${CURRENT_PACKAGES_DIR}/debug/lib/cmake/fftw3/FFTW3LibraryDepends-debug.cmake  DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw)



file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/cmake)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/cmake)

file(INSTALL ${SOURCE_PATH}/COPYRIGHT DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw RENAME copyright)


