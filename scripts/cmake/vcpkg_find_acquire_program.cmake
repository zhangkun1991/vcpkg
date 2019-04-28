## # vcpkg_find_acquire_program
##
## Download or find a well-known tool.
##
## ## Usage
## ```cmake
## vcpkg_find_acquire_program(<VAR>)
## ```
## ## Parameters
## ### VAR
## This variable specifies both the program to be acquired as well as the out parameter that will be set to the path of the program executable.
##
## ## Notes
## The current list of programs includes:
##
## - 7Z
## - BISON
## - FLEX
## - GASPREPROCESSOR
## - PERL
## - PYTHON2
## - PYTHON3
## - JOM
## - MESON
## - NASM
## - NINJA
## - NUGET
## - YASM
## - ARIA2 (Downloader)
##
## Note that msys2 has a dedicated helper function: [`vcpkg_acquire_msys`](vcpkg_acquire_msys.md).
##
## ## Examples
##
## * [ffmpeg](https://github.com/Microsoft/vcpkg/blob/master/ports/ffmpeg/portfile.cmake)
## * [openssl](https://github.com/Microsoft/vcpkg/blob/master/ports/openssl/portfile.cmake)
## * [qt5](https://github.com/Microsoft/vcpkg/blob/master/ports/qt5/portfile.cmake)
function(vcpkg_find_acquire_program VAR)
  set(EXPANDED_VAR ${${VAR}})
  if(EXPANDED_VAR)
    return()
  endif()

  unset(NOEXTRACT)
  unset(_vfa_RENAME)
  unset(SUBDIR)
  unset(REQUIRED_INTERPRETER)

  vcpkg_get_program_files_platform_bitness(PROGRAM_FILES_PLATFORM_BITNESS)
  vcpkg_get_program_files_32_bit(PROGRAM_FILES_32_BIT)

  if(VAR MATCHES "PERL")
    set(PROGNAME perl)
    set(PATHS ${DOWNLOADS}/tools/perl/perl/bin)
    set(BREW_PACKAGE_NAME "perl")
    set(APT_PACKAGE_NAME "perl")
    set(URL "http://strawberryperl.com/download/5.24.1.1/strawberry-perl-5.24.1.1-32bit-portable.zip")
    set(ARCHIVE "strawberry-perl-5.24.1.1-32bit-portable.zip")
    set(HASH a6e685ea24376f50db5f06c5b46075f1d3be25168fa1f27fa9b02e2ac017826cee62a2b43562f9b6c989337a231ba914416c110075457764de2d11f99d5e0f26)
  elseif(VAR MATCHES "NASM")
    set(PROGNAME nasm)
    set(PATHS ${DOWNLOADS}/tools/nasm/nasm-2.14)
    set(BREW_PACKAGE_NAME "nasm")
    set(APT_PACKAGE_NAME "nasm")
    set(URL "http://www.nasm.us/pub/nasm/releasebuilds/2.14/win32/nasm-2.14-win32.zip")
    set(ARCHIVE "nasm-2.14-win32.zip")
    set(HASH 64481b0346b83de8c9568f04a54f68e0f4c71724afa0b414f12e4080951d8c49e489bfc32117f9a489e3e49477b1cadc583c672311316d27c543af304c4b7f2a)
  elseif(VAR MATCHES "YASM")
    set(PROGNAME yasm)
    set(SUBDIR 1.3.0.6)
    set(PATHS ${DOWNLOADS}/tools/yasm/${SUBDIR})
    set(URL "https://www.tortall.net/projects/yasm/snapshots/v1.3.0.6.g1962/yasm-1.3.0.6.g1962.exe")
    set(ARCHIVE "yasm-1.3.0.6.g1962.exe")
    set(_vfa_RENAME "yasm.exe")
    set(NOEXTRACT ON)
    set(HASH c1945669d983b632a10c5ff31e86d6ecbff143c3d8b2c433c0d3d18f84356d2b351f71ac05fd44e5403651b00c31db0d14615d7f9a6ecce5750438d37105c55b)
  elseif(VAR MATCHES "PYTHON3")
    if(CMAKE_HOST_WIN32)
      set(PROGNAME python)
      set(SUBDIR "python3")
      set(PATHS ${DOWNLOADS}/tools/python/${SUBDIR})
      set(URL "https://www.python.org/ftp/python/3.5.4/python-3.5.4-embed-win32.zip")
      set(ARCHIVE "python-3.5.4-embed-win32.zip")
      set(HASH b5240fdc95088c2d7f65d2dd598650f8dd106b49589d94156bd4a078b108c6cabbe7a38ef73e2b2cf00e8312a93d2e587eac2c54ce85540d3c7a26cc60013156)
    else()
      set(PROGNAME python3)
      set(BREW_PACKAGE_NAME "python")
      set(APT_PACKAGE_NAME "python3")
    endif()
  elseif(VAR MATCHES "PYTHON2")
    set(PROGNAME python)
    set(SUBDIR "python2")
    set(PATHS ${DOWNLOADS}/tools/python/${SUBDIR})
    file(TO_NATIVE_PATH "${PATHS}" DESTINATION_NATIVE_PATH)
    set(URL "https://www.python.org/ftp/python/2.7.14/python-2.7.14.msi")
    set(ARCHIVE "python2.msi")
    set(HASH 8c3ad6e527742d99ba96dcfd1098861b14e7207b80d51a54e9b410ab2f36e44e05561ea1527d8e92b3e10808311536260bd9e82db0da3b513fb1be18e108510e)
  elseif(VAR MATCHES "RUBY")
    set(PROGNAME "ruby")
    set(PATHS ${DOWNLOADS}/tools/ruby/rubyinstaller-2.4.1-1-x86/bin)
    set(URL https://github.com/oneclick/rubyinstaller2/releases/download/2.4.1-1/rubyinstaller-2.4.1-1-x86.7z)
    set(ARCHIVE rubyinstaller-2.4.1-1-x86.7z)
    set(HASH b51112e9b58cfcbe8cec0607e8a16fff6a943d9b4e31b2a7fbf5df5f83f050bf0a4812d3dd6000ff21a3d5fd219cd0a309c58ac1c1db950a9b0072405e4b70f5)
  elseif(VAR MATCHES "JOM")
    set(PROGNAME jom)
    set(SUBDIR "jom-1.1.3")
    set(PATHS ${DOWNLOADS}/tools/jom/${SUBDIR})
    set(URL "http://download.qt.io/official_releases/jom/jom_1_1_3.zip")
    set(ARCHIVE "jom_1_1_3.zip")
    set(HASH 5b158ead86be4eb3a6780928d9163f8562372f30bde051d8c281d81027b766119a6e9241166b91de0aa6146836cea77e5121290e62e31b7a959407840fc57b33)
  elseif(VAR MATCHES "7Z")
    set(PROGNAME 7z)
    set(PATHS "${PROGRAM_FILES_PLATFORM_BITNESS}/7-Zip" "${PROGRAM_FILES_32_BIT}/7-Zip" "${DOWNLOADS}/tools/7z/Files/7-Zip")
    set(URL "http://7-zip.org/a/7z1604.msi")
    set(ARCHIVE "7z1604.msi")
    set(HASH 556f95f7566fe23704d136239e4cf5e2a26f939ab43b44145c91b70d031a088d553e5c21301f1242a2295dcde3143b356211f0108c68e65eef8572407618326d)
  elseif(VAR MATCHES "NINJA")
    set(PROGNAME ninja)
    set(SUBDIR "ninja-1.8.2")
    if(CMAKE_HOST_WIN32)
      set(PATHS "${DOWNLOADS}/tools/ninja/${SUBDIR}")
    elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
      set(PATHS "${DOWNLOADS}/tools/${SUBDIR}-osx")
    elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "FreeBSD")
      set(PATHS "${DOWNLOADS}/tools/${SUBDIR}-freebsd")
    else()
      set(PATHS "${DOWNLOADS}/tools/${SUBDIR}-linux")
    endif()
    set(BREW_PACKAGE_NAME "ninja")
    set(APT_PACKAGE_NAME "ninja-build")
    set(URL "https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-win.zip")
    set(ARCHIVE "ninja-1.8.2-win.zip")
    set(HASH 9b9ce248240665fcd6404b989f3b3c27ed9682838225e6dc9b67b551774f251e4ff8a207504f941e7c811e7a8be1945e7bcb94472a335ef15e23a0200a32e6d5)
  elseif(VAR MATCHES "NUGET")
    set(PROGNAME nuget)
    set(PATHS "${DOWNLOADS}/tools/nuget")
    set(BREW_PACKAGE_NAME "nuget")
    set(URL "https://dist.nuget.org/win-x86-commandline/v4.8.1/nuget.exe")
    set(ARCHIVE "nuget.exe")
    set(NOEXTRACT ON)
    set(HASH 42cb744338af8decc033a75bce5b4c4df28e102bafc45f9a8ba86d7bc010f5b43ebacae80d7b28c4f85ac900eefc2a349620ae65f27f6ca1c21c53b63b92924b)
  elseif(VAR MATCHES "MESON")
    set(PROGNAME meson)
    set(REQUIRED_INTERPRETER PYTHON3)
    set(BREW_PACKAGE_NAME "meson")
    set(APT_PACKAGE_NAME "meson")
    if(CMAKE_HOST_WIN32)
      set(SCRIPTNAME meson.py)
    else()
      set(SCRIPTNAME meson)
    endif()
    set(PATHS ${DOWNLOADS}/tools/meson/meson-0.50.0)
    set(URL "https://github.com/mesonbuild/meson/archive/0.50.0.zip")
    set(ARCHIVE "meson-0.50.0.zip")
    set(HASH 587cafe0cd551e3fb3507ecab904912dc3e053aa95c864b435526a20d52406536ba970a50be6c9f20d83314c5853aaefa102c5ca14623d0928b091a43e7b6d64)
  elseif(VAR MATCHES "FLEX")
    if(CMAKE_HOST_WIN32)
      set(PROGNAME win_flex)
      set(SUBDIR win_flex-2.5.16)
      set(PATHS ${DOWNLOADS}/tools/win_flex/${SUBDIR})
      set(URL "https://sourceforge.net/projects/winflexbison/files/winflexbison-2.5.16.zip/download")
      set(ARCHIVE "win_flex_bison-2.5.16.zip")
      set(HASH 0a14154bff5d998feb23903c46961528f8ccb4464375d5384db8c4a7d230c0c599da9b68e7a32f3217a0a0735742242eaf3769cb4f03e00931af8640250e9123)
      if(NOT EXISTS "${PATHS}/data/m4sugar/m4sugar.m4")
        file(REMOVE_RECURSE "${PATHS}")
      endif()
    else()
      set(PROGNAME flex)
      set(APT_PACKAGE_NAME flex)
      set(BREW_PACKAGE_NAME flex)
    endif()
  elseif(VAR MATCHES "BISON")
    if(CMAKE_HOST_WIN32)
      set(PROGNAME win_bison)
      set(SUBDIR win_bison-2.5.16)
      set(PATHS ${DOWNLOADS}/tools/win_bison/${SUBDIR})
      set(URL "https://sourceforge.net/projects/winflexbison/files/winflexbison-2.5.16.zip/download")
      set(ARCHIVE "win_flex_bison-2.5.16.zip")
      set(HASH 0a14154bff5d998feb23903c46961528f8ccb4464375d5384db8c4a7d230c0c599da9b68e7a32f3217a0a0735742242eaf3769cb4f03e00931af8640250e9123)
      if(NOT EXISTS "${PATHS}/data/m4sugar/m4sugar.m4")
        file(REMOVE_RECURSE "${PATHS}")
      endif()
    else()
      set(PROGNAME bison)
      set(APT_PACKAGE_NAME bison)
      set(BREW_PACKAGE_NAME bison)
    endif()
  elseif(VAR MATCHES "GPERF")
    set(PROGNAME gperf)
    set(PATHS ${DOWNLOADS}/tools/gperf/bin)
    set(URL "https://sourceforge.net/projects/gnuwin32/files/gperf/3.0.1/gperf-3.0.1-bin.zip/download")
    set(ARCHIVE "gperf-3.0.1-bin.zip")
    set(HASH 3f2d3418304390ecd729b85f65240a9e4d204b218345f82ea466ca3d7467789f43d0d2129fcffc18eaad3513f49963e79775b10cc223979540fa2e502fe7d4d9)
  elseif(VAR MATCHES "GASPREPROCESSOR")
    set(NOEXTRACT true)
    set(PROGNAME gas-preprocessor)
    set(REQUIRED_INTERPRETER PERL)
    set(SCRIPTNAME "gas-preprocessor.pl")
    set(PATHS ${DOWNLOADS}/tools/gas-preprocessor)
    set(URL "https://raw.githubusercontent.com/FFmpeg/gas-preprocessor/36bacb4cba27003c572e5bf7a9c4dfe3c9a8d40d/gas-preprocessor.pl")
    set(ARCHIVE "gas-preprocessor.pl")
    set(HASH a25caadccd1457a0fd2abb5a0da9aca1713b2c351d76daf87a4141e52021f51aa09e95a62942c6f0764f79cc1fa65bf71584955b09e62ee7da067b5c82baf6b3)
  elseif(VAR MATCHES "DARK")
    set(PROGNAME dark)
    set(SUBDIR "wix311-binaries")
    set(PATHS ${DOWNLOADS}/tools/dark/${SUBDIR})
    set(URL "https://github.com/wixtoolset/wix3/releases/download/wix311rtm/wix311-binaries.zip")
    set(ARCHIVE "wix311-binaries.zip")
    set(HASH 74f0fa29b5991ca655e34a9d1000d47d4272e071113fada86727ee943d913177ae96dc3d435eaf494d2158f37560cd4c2c5274176946ebdb17bf2354ced1c516)
  elseif(VAR MATCHES "SCONS")
    set(PROGNAME scons)
    set(REQUIRED_INTERPRETER PYTHON2)
    set(SCRIPTNAME "scons.py")
    set(PATHS ${DOWNLOADS}/tools/scons)
    set(URL "https://sourceforge.net/projects/scons/files/scons-local-3.0.1.zip/download")
    set(ARCHIVE "scons-local-3.0.1.zip")
    set(HASH fe121b67b979a4e9580c7f62cfdbe0c243eba62a05b560d6d513ac7f35816d439b26d92fc2d7b7d7241c9ce2a49ea7949455a17587ef53c04a5f5125ac635727)
  elseif(VAR MATCHES "DOXYGEN")
    set(PROGNAME doxygen)
    set(PATHS ${DOWNLOADS}/tools/doxygen)
    set(URL "http://ftp.stack.nl/pub/users/dimitri/doxygen-1.8.14.windows.bin.zip")
    set(ARCHIVE "doxygen-1.8.14.windows.bin.zip")
    set(HASH d0d706501e7112045b1f401f22d12a2c8d9b7728edee9ad1975a17dff914c16494ae48a70beab6f6304643779935843f268c7afed3b9da7d403b5cb11cac0c50)
  # Download Tools
  elseif(VAR MATCHES "ARIA2")
    set(PROGNAME aria2c)
    set(PATHS ${DOWNLOADS}/tools/aria2c/aria2-1.33.1-win-32bit-build1)
    set(URL "https://github.com/aria2/aria2/releases/download/release-1.33.1/aria2-1.33.1-win-32bit-build1.zip")
    set(ARCHIVE "aria2-1.33.1-win-32bit-build1.zip")
    set(HASH 2456176ba3d506a07cf0cc4f61f080e1ff8cb4106426d66f354c5bb67a9a8720b5ddb26904275e61b1f623c932355f7dcde4cd17556cc895f11293c23c3a9bf3)
  else()
    message(FATAL "unknown tool ${VAR} -- unable to acquire.")
  endif()

  macro(do_find)
    if(NOT DEFINED REQUIRED_INTERPRETER)
      find_program(${VAR} ${PROGNAME} PATHS ${PATHS})
    else()
      vcpkg_find_acquire_program(${REQUIRED_INTERPRETER})
      find_file(SCRIPT ${SCRIPTNAME} PATHS ${PATHS})
      set(${VAR} ${${REQUIRED_INTERPRETER}} ${SCRIPT})
    endif()
  endmacro()

  do_find()
  if("${${VAR}}" MATCHES "-NOTFOUND")
    if(NOT CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
      set(EXAMPLE ".")
      if(DEFINED BREW_PACKAGE_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
        set(EXAMPLE ":\n    brew install ${BREW_PACKAGE_NAME}")
      elseif(DEFINED APT_PACKAGE_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
        set(EXAMPLE ":\n    sudo apt-get install ${APT_PACKAGE_NAME}")
      endif()
      message(FATAL_ERROR "Could not find ${PROGNAME}. Please install it via your package manager${EXAMPLE}")
    endif()

    vcpkg_download_distfile(ARCHIVE_PATH
        URLS ${URL}
        SHA512 ${HASH}
        FILENAME ${ARCHIVE}
    )

    set(PROG_PATH_SUBDIR "${DOWNLOADS}/tools/${PROGNAME}/${SUBDIR}")
    file(MAKE_DIRECTORY ${PROG_PATH_SUBDIR})
    if(DEFINED NOEXTRACT)
      if(DEFINED _vfa_RENAME)
        file(INSTALL ${ARCHIVE_PATH} DESTINATION ${PROG_PATH_SUBDIR} RENAME ${_vfa_RENAME})
      else()
        file(COPY ${ARCHIVE_PATH} DESTINATION ${PROG_PATH_SUBDIR})
      endif()
    else()
      get_filename_component(ARCHIVE_EXTENSION ${ARCHIVE} EXT)
      string(TOLOWER "${ARCHIVE_EXTENSION}" ARCHIVE_EXTENSION)
      if(ARCHIVE_EXTENSION STREQUAL ".msi")
        file(TO_NATIVE_PATH "${ARCHIVE_PATH}" ARCHIVE_NATIVE_PATH)
        file(TO_NATIVE_PATH "${PROG_PATH_SUBDIR}" DESTINATION_NATIVE_PATH)
        execute_process(
          COMMAND msiexec /a ${ARCHIVE_NATIVE_PATH} /qn TARGETDIR=${DESTINATION_NATIVE_PATH}
          WORKING_DIRECTORY ${DOWNLOADS}
        )
      else()
        execute_process(
          COMMAND ${CMAKE_COMMAND} -E tar xzf ${ARCHIVE_PATH}
          WORKING_DIRECTORY ${PROG_PATH_SUBDIR}
        )
      endif()
    endif()

    do_find()
  endif()

  set(${VAR} "${${VAR}}" PARENT_SCOPE)
endfunction()
