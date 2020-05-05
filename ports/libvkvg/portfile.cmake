include(vcpkg_common_functions)
vcpkg_find_acquire_program(GIT)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jpbruyere/vkvg
    REF be60129002c1912528d0f6c9758379742f3cab12
    SHA512 7ad9f11dc65cc1da506a40c5b3652cb8740850b342392c70f69c21d4a45e674147282f5b6567b9204b2bd3e8d69e989c04bd7d276996726355bcd127e7c5a77e 
    HEAD_REF master
)
IF(NOT EXISTS "${SOURCE_PATH}/vkh/vkh.pc.in")
    vcpkg_download_distfile(
        VKH_ARCHIVE
        URLS https://github.com/jpbruyere/vkhelpers/archive/1fcee8223df65d87742bfe5ec36562bfaccecc11.zip
        FILENAME vkh.zip
        SHA512 328f40b8a00deb6ddecf5882bba1e029dbb22065ab4a1a20e0736c48cc1434b68b6f764e2bf425d25ebfe5c8f34467a1c86b3a69687a3d2dcb904c05c5f0413e
    )
    vcpkg_extract_source_archive(
        ${VKH_ARCHIVE} ${SOURCE_PATH}
    )
    file(GLOB VKH_DIR "${SOURCE_PATH}/vkhelper*")
    file(RENAME ${VKH_DIR} ${SOURCE_PATH}/vkh)
ENDIF()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DINSTALL_DOCS=0 -DINSTALL_PKG_CONFIG_MODULE=0
)

vcpkg_install_cmake()

#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/Ogg TARGET_PATH share/ogg)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

vcpkg_copy_pdbs()

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
	file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
endif()

file(INSTALL ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

