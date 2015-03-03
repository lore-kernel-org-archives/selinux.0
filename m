Message-ID: <54F61BCC.80909@tycho.nsa.gov>
Date: Tue, 03 Mar 2015 15:38:36 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Emre Can Kucukoglu <eckucukoglu@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Cross-compile for arm architecture
References: <CA+2y117Qsyy1EVqioo6e1r44mOBK5GiEDRAQczngkhQpRgmD9Q@mail.gmail.com>
 <54EE138A.8010009@tycho.nsa.gov>
 <CA+2y1172GwSBiqY8KZrSY6FV7g5xsSGp726MN_xikgJCSNnXsw@mail.gmail.com>
 <54F614A9.3090800@tycho.nsa.gov>
In-Reply-To: <54F614A9.3090800@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/03/2015 03:08 PM, Stephen Smalley wrote:
> On 03/03/2015 10:03 AM, Emre Can Kucukoglu wrote:
>> Now, I'm working with Fedora 21. However another error exists now:
>>
>> Toolchain: gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux
>>
>> export
>> PATH=$PATH:/home/ecank/1511/toolchain/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin
>> export CC=arm-linux-gnueabihf-gcc
>> export CROSS_COMPILE=arm-linux-gnueabihf-
>> export CFLAGS=-D__thread= 
>> export EMBEDDED=y
>> export DESTDIR=~/obj
>> make install install-pywrap
>>
>> arm-linux-gnueabihf-gcc: error: unrecognized command line option
>> ‘-mno-tls-direct-seg-refs’
>> Makefile:130: recipe for target 'is_customizable_type.o' failed
>> make[2]: *** [is_customizable_type.o] Error 1
>> make[2]: Leaving directory '/home/ecank/1511/selinux/libselinux/src'
>> Makefile:28: recipe for target 'install' failed
>>
>> all output: http://pastebin.com/U03hhtJJ
>>
>> moreover:
>> $ arm-linux-gnueabihf-gcc --version
>> arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro
>> GCC 4.9-2014.09) 4.9.2 20140904 (prerelease)
>> Copyright (C) 2014 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>
>> Then after deletion of
>> TLSFLAGS += -mno-tls-direct-seg-refs
>> (i deleted that flag, since it was related with x86-64 and i386) 
>> (https://gcc.gnu.org/onlinedocs/gcc-4.9.2/gcc/i386-and-x86-64-Options.html)
>>
>> New error is related with pcre library.
>>
>> arm-linux-gnueabihf-gcc -D__thread= -I../include
>> -I/home/ecank/obj/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
>> -DDISABLE_AVC -DDISABLE_BOOL -DDISABLE_RPM -DDISABLE_SETRANS  -c -o
>> label_file.o label_file.c
>> label_file.c:21:18: fatal error: pcre.h: No such file or directory
>>  #include <pcre.h>
>>                   ^
>> compilation terminated.
>> Makefile:130: recipe for target 'label_file.o' failed
>>
>> all output: http://pastebin.com/9rxKFvLL
>>
>> Really need help about compiling SELinux for an arm.
> 
> Looks like you just don't have pcre-devel installed?
> 
> There have been various ports of SELinux to ARM in the past, but I think
> they always involved modifications of some sort.  Most notably the port
> of SELinux to Android, see:
> http://seandroid.bitbucket.org/index.html

There is also the meta-selinux layer for the Yocto project,
That was created by others and does reuse the upstream selinux userspace
and refpolicy, unlike the port to Android which took a much more
minimalist, nativized approach.
