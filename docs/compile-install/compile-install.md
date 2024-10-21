# 应用程序的编译与安装

应用程序一般有两种方式发布：

- 二进制方式：用户无需编译，只要解压缩后设置相关环境变量等即可。如Gaussian [1]，国内用户只能购买到已经编译好的二进制可执行文件，有些国家和地区能购买到源代码。
- 源代码方式：
  - 用户需要自己编译，并且可以按照需要修改编译参数以编译成最适合自己的可执行程序，之后再设置环境变量等使用，如VASP [2]。
  - 源代码编译时经常用到的编译命令为`make`，编译配置文件为，请查看`make`命令用法及文件说明。

应用程序一般都有官方的安装说明，建议在安装前，首先仔细查看一下，比如到其主页或者查看解压缩后的目录中的类似：install*、readme*等文件。

## 二进制程序的安装

以二进制方式发布的程序，安装相对简单，一般只要解压缩后设置好环境变量即可，以Gaussian09为例：

- 将压缩包复制到某个地方，如
- 解压缩：`tar xvf gaussian09.tar.gz` [3]
- 设置环境变量：修改 `~/.bashrc` ，添加：

  ```bash
  ##Add for g09
  export g09root="/opt"
  export GAUSS_SCRDIR="/tmp"
  . $g09root/g09/bsd/g09.profile
  ##End for g09
  ```

- 刷新环境设置： `.` `~/.bashrc`  或重新登录下。

## 源代码程序的安装

以源代码发布的程序安装相对复杂，需了解所采用的编译环境，并对配置等做相应修改（主要修改编译命令、库、头文件等编译参数等）。以VASP为例：

- 解压缩文件：

  ```bash
  tar xvf vasp.5.lib.tar.gz
  tar xvf vasp.5.2.tar.gz
  ```

- 查看说明：install、readme文件等，VASP解压后的目录中未含有，可以参见上述主页文档安装。
- 生成默认配置文件：`./configure`。
  - VASP不需要`./configure`命令生成，而是提供了几个针对不同系统和编译器的makefile模板，可以复制成
  - 其它程序也许需要`./configure`生成所需要的，在运行`./configure`之前，一般可以运行`./configure -h`查看其选项。如对Open MPI 1.6.4，可以运行以下命令生成：

    ```bash
    F77=ifort FC=ifort CC=icc CXX=icpc ./configure --prefix=/opt/openmpi-1.6.4
    ```

    其中：

    - F77：编译Fortran77源文件的编译器命令
    - FC：编译Fortran90源文件的编译器命令
    - CC：编译C源文件的编译器命令
    - CXX：编译C++源文件的编译器命令
    - –prefix：安装到的目录前缀

    另外一些在Makefile中常见变量为：

    - CPP：预处理参数
    - CLAGS：C程序编译参数
    - CXXFLAGS：C程序编译参数
    - F90：编译Fortran90及以后源文件的编译器命令
    - FFLAGS：Fortran编译参数
    - OFLAG：优化参数
    - INCLUDE：头文件参数
    - LIB：库文件参数
    - LINK：链接参数

- 修改文件配置，设定编译环境等：
  - 对做如下修改：
    - 设定编译Fortran的编译器命令为Intel Fortran编译器命令：FC=ifort
  - 对做如下修改：
    - 设定BLAS库使用Intel MKL中的BLAS：BLAS=-mkl [4]
    - 打开FFT3D支持：去掉FFT3D = fft3dfurth.o fft3dlib.o前的# [5]
    - 设定MPI Fortran编译器为Intel MPI编译器：FC=mpiifort

- 编译：`make`
  - 先在目录中执行`make`
  - 如未出错，则再在目录中执行`make`

- 安装：`make install`。VASP不需要，有些程序需要执行此步。
- 设置环境变量：比如在中设置安装后的可执行程序目录在环境变量`PATH`中：

  ```bash
  export PATH=$PATH:/opt/vasp.5.2
  ```

## 参考文献

1. Gaussian主页：[http://www.gaussian.com/](http://www.gaussian.com/)
2. VASP主页：[http://www.vasp.at/](http://www.vasp.at/)
3. 当前主流Linux系统，`tar`命令已经能自动识别.gz和.bz压缩，无需再明确添加z或j参数来指定。
4. 因为2013版本的Intel编译器支持-mkl选项自动Intel MKL库，因此可以这么设置。
5. 在Makefile中#表示注释
