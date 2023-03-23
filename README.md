# 下载工具
    # git clone http://gitlab.stars-mine.com/hardware_v2/amlogic_tools.git
    
# 解包
    # 解包文件按需修改
    # cd amlogic_tools
    # mkdir in
    # cp update-YS-A98-AP6212-11.0-20230310.img in
    # unpack.sh

# 打包
    # 第一次打包需要先执行解包操作，生成基础文件
    # pack.sh
# 生成包路径
    # amlogic_tools/out 目录


# 添加so文件 以system_a为例
    # cat >> level2/config/system_a_fs_config << EOF
      system_a/system/app/t982prod/lib 0 0 0755
      system_a/system/app/t982prod/lib/arm 0 0 0755
      system_a/system/app/t982prod/lib/arm/libfilament-jni.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/libfilament-utils-jni.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/libgltfio-jni.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/libc++_shared.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/libhwacl.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/libijkffmpeg.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/libijkplayer.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/libijksdl.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/librsjni_androidx.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/librsjni.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/libRSSupport.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/librtmp-jni.so 0 0 0644
      system_a/system/app/t982prod/lib/arm/libserial_port.so 0 0 0644
      EOF
