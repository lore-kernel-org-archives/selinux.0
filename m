Message-Id: <200305182358.AA00703@ilios104.ori.hitachi-sk.co.jp>
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Date: Mon, 19 May 2003 08:58:23 +0900
To: SELinux@tycho.nsa.gov
Cc: ynakam@ori.hitachi-sk.co.jp
Subject: Compile Error of libsecure on Redhat9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.
I'm researching SELinux in Japan.

I tried to install SELinux(lsm2.4) on Redhat 9.0.
But the compile of libsecure failed in fstat_secure.c.
-------------------------------------
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
make[2]: *** [fstat_secure.o] Error 1
--------------------------------

It seems that Redhat9.0's struct stat in /usr/include/bits/stat.h has changed from that of Redhat 8.0.
"# define st_atime st_atim.tv_sec
# define st_mtime st_mtim.tv_sec
# define st_ctime st_ctim.tv_sec" in /usr/include/bits/stat.h
conflict with struct kernel_stat in kernel_stat.h
and  
__unused1,__unused2,__unused3 don't exists in "struct stat".

Thank you.

--------------------
Yuichi Nakamura
Research&Development Department
Hitachi Software Engineering Co.,Ltd.
ynakam@ori.hitachi-sk.co.jp
SELinux Policy Editor:http://www.selinux.hitachi-sk.co.jp/en/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
