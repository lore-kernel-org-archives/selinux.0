Message-ID: <1C693F61F78ADA449B9FDAE7737665E001A0157C@fskrsm41.hill.af.mil>
From: Michael Alexander S Contr OO-ALC/YPVS
	 <Alexander.Michael@HILL.af.mil>
To: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: Errors in SELinux compile
Date: Mon, 2 Dec 2002 11:51:14 -0700 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While trying to build the SELinux kernel (2.4.19) I have a couple of errors
pop up.  Here were the steps I used to install the kernel:

make menuconfig (fine)
make dep (fine)
make

errors:
<snip>
make[2]: Entering directory '/home/Alex/lsm-2.4/fs'
gcc -D__KERNEL__ -I/home/Alex/lsm-2.4/include -Wall -Wstrict-prototypes
-Wno-trigraphs -02 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i686    -nostdinc -I
/usr/lib/gcc-lib/i386-redhat-linux/3.2/include -DKBUILD_BASENAME=namei   -c
-o namei.o namei.c
namei.c: In function 'getname':
namei.c: 142: (Each undeclared identifier is reported only once
namei.c: 142: for each function is appears in.)
namei.c: 142: warning: passing arg 2 of pointer to function from
incompatible pointer type
make[2]: *** [namei.o] Error1
make[2]: Leaving directory '/home/Alex/lsm-2.4/fs'
make[1]: *** [first_rule] Error2
make[1]: *** Leaving directory '/home/Alex/lsm-2.4/fs'
make: *** [_dir_fs] Error2


Are these errors critical to the install?  I just wanted to make sure before
I finished the install and found out I needed to change some other option in
one of my files.

Also, as I am installing on RedHat 8.0, what option do I need to set my
LOGROTATE_VAR definition to?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
