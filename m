MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: libsecure fails to compile
Date: Tue, 8 Jul 2003 11:04:53 -0500
Message-ID: <B3B3B1C9A024D511B52C00D0B7201BDB07703D@ca-ex-remote1.na.nai.com>
From: <Jonathan_Axisa@nai.com>
To: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
I am trying to compile libsecure (with the latest version of the SE Linux code, just downloaded from nsa.gov yesterday) but it fails with the following error:

make -C src
make[1]: Entering directory `/home/jaxisa/work/nsa/selinux/libsecure/src'
cc -o fstat_secure.o -c -I../include -I/usr/local/selinux/include fstat_secure.c
In file included from fstat_secure.c:4:
kernel_stat.h:18: warning: no semicolon at end of struct or union
kernel_stat.h:18: parse error before '.' token
kernel_stat.h:21: parse error before '.' token
kernel_stat.h:24: parse error before '.' token
kernel_stat.h:31: parse error before '}' token
In file included from fstat_secure.c:5:
xstat_conv.h: In function `xstat_conv':
xstat_conv.h:29: dereferencing pointer to incomplete type
xstat_conv.h:29: dereferencing pointer to incomplete type
xstat_conv.h:37: dereferencing pointer to incomplete type
xstat_conv.h:41: dereferencing pointer to incomplete type
xstat_conv.h:42: dereferencing pointer to incomplete type
xstat_conv.h:43: dereferencing pointer to incomplete type
xstat_conv.h:44: dereferencing pointer to incomplete type
xstat_conv.h:45: dereferencing pointer to incomplete type
xstat_conv.h:46: dereferencing pointer to incomplete type
xstat_conv.h:50: dereferencing pointer to incomplete type
xstat_conv.h:51: dereferencing pointer to incomplete type
xstat_conv.h:52: dereferencing pointer to incomplete type
xstat_conv.h:53: dereferencing pointer to incomplete type
xstat_conv.h:55: structure has no member named `__unused1'
xstat_conv.h:57: dereferencing pointer to incomplete type
xstat_conv.h:59: structure has no member named `__unused2'
xstat_conv.h:61: dereferencing pointer to incomplete type
xstat_conv.h:63: structure has no member named `__unused3'
fstat_secure.c: In function `fstat_secure':
fstat_secure.c:12: storage size of `kbuf' isn't known
make[1]: *** [fstat_secure.o] Error 1
make[1]: Leaving directory `/home/jaxisa/work/nsa/selinux/libsecure/src'
make: *** [all] Error 2



In kernel_stat.h, there are no .'s on the lines indicated, and there are semicolons in every place that needs a semicolon.

Thanks for your help in advance,
Jon


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
