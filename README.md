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
      system_a/system/lib/libc++_shared.so 0 0 0644
      system_a/system/lib/libhwacl.so 0 0 0644
      system_a/system/lib/libijkffmpeg.so 0 0 0644
      system_a/system/lib/libijkplayer.so 0 0 0644
      system_a/system/lib/libijksdl.so 0 0 0644
      system_a/system/lib/librsjni_androidx.so 0 0 0644
      system_a/system/lib/librsjni.so 0 0 0644
      system_a/system/lib/libRSSupport.so 0 0 0644
      system_a/system/lib/librtmp-jni.so 0 0 0644
      system_a/system/lib/libserial_port.so 0 0 0644
      EOF
