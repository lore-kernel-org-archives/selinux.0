From: gdsmarshall@hushmail.com
Message-Id: <200206251543.g5PFhg451838@mailserver4.hushmail.com>
To: SELinux@tycho.nsa.gov
Subject: libsecure fails to compile
Date: Tue, 25 Jun 2002 08:43:42 -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


 
Hello,

I am trying to compile libsecure, but it fails with the below error.

make -C src 
make[1]: Entering directory `/root/selinux/selinux/libsecure/src'
cc -o arch/i386/fstat64_secure.o -c -I../include -I/usr/local/selinux/include arch/i386/fstat64_secure.c
In file included from arch/i386/fstat64_secure.c:6:
arch/i386/xstat64_conv.h: In function `xstat64_conv':
arch/i386/xstat64_conv.h:38: structure has no member named `__st_ino'
make[1]: *** [arch/i386/fstat64_secure.o] Error 1
make[1]: Leaving directory `/root/selinux/selinux/libsecure/src'
make: *** [all] Error 2
gatekeeper:~/selinux/selinux/libsecure#

I understand xstat64_conv.h is missing __st_ino, what should this be please?

I had no problems compiling the kernel which is now running quite happily,
Linux gatekeeper 2.4.18-selinux #4 Mon Jun 24 18:18:25 BST 2002 i486 unknown

I am using debian (stable)  I know Russell Coker has done lots of work with SELinux on debian, but I can not get to the stage of compiling the utilities yet.

Many thanks for your help in advance,

Spencer



Communicate in total privacy.
Get your free encrypted email at https://www.hushmail.com/?l=2

Looking for a good deal on a domain name? http://www.hush.com/partners/offers.cgi?id=domainpeople


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
