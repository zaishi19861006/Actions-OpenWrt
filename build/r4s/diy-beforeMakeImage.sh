#!/bin/bash

[ -z "$suffix" ] && source $GITHUB_ENV

if [ "$suffix" = '-full' ];then
    if [ "$repo_name" == 'lede' ];then
         rootfs_size=$( awk -F= '/^CONFIG_TARGET_ROOTFS_PARTSIZE/{print $2+74}' .config )
    fi
    if [ "$repo_name" == 'immortalwrt' ] && [ "$repo_branch" == 'openwrt-18.06-k5.4' ];then
        # full 版本加大一些容量
        # 参考 https://forum.openwrt.org/t/how-to-set-root-filesystem-partition-size-on-x86-imabebuilder/4765/4?u=zhangguanzhang
        rootfs_size=$( awk -F= '/^CONFIG_TARGET_ROOTFS_PARTSIZE/{print $2+118}' .config ) # 95 failed
    fi
    if [ "$repo_name" == 'DHDAXCW' ];then
        rootfs_size=$( awk -F= '/^CONFIG_TARGET_ROOTFS_PARTSIZE/{print $2+94}' .config )
    fi
    if [ -n "$rootfs_size" ];then
        sed -ri '/^CONFIG_TARGET_ROOTFS_PARTSIZE=/s#=[0-9]+$#='"${rootfs_size}"'#' .config
    fi
fi