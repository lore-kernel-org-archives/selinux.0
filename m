Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA00937
	for <selinux@tycho.nsa.gov>; Sun, 17 Nov 2002 17:37:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA26831
	for <selinux@tycho.nsa.gov>; Sun, 17 Nov 2002 22:35:37 GMT
Received: from edmond.crypt.gen.nz (203-79-124-72.adsl.paradise.net.nz [203.79.124.72])
        by jazzband.ncsc.mil  with ESMTP id WAA26827 for <selinux@tycho.nsa.gov>; Sun, 17 Nov 2002 22:35:35 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Kerry Thompson <kerry@crypt.gen.nz>
To: "Subba Rao" <sailorn@attglobal.net>, selinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux compile errors
Date: Mon, 18 Nov 2002 11:37:32 +1300
References: <200211161559.PAA06301@jazzband.ncsc.mil>
In-Reply-To: <200211161559.PAA06301@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200211181137.32658.kerry@crypt.gen.nz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Aaarg. Sorry about the previous broken message, it seems that CTRL-V in KMail 
is 'Send', and not 'Paste bit of useful code'.

The same problem was raised a few weeks ago, it comes from ip_warn() in 
selopt_core.c having two arguments, while the macro definition in selopt.h 
has 3 arguments. Namely :

in selopt.h :

  #define ip_warn(iph, fmt, args...)                                     \
       do { printk(KERN_WARNING "%s: " fmt, __FUNCTION__, ##args);     \
            printk(" [%u.%u.%u.%u->%u.%u.%u.%u]\n",                    \
            NIPQUAD(iph->saddr), NIPQUAD(iph->daddr));                 \
       } while (0);

while the lines in selopt_core.c with compiler warnings are like :

    ip_warn(iph, "out of memory expanding skb\n");

... and your compiler is having a nasty reaction to it. You could try adding 
an extra parameter to the ip_warn() calls, like adding a NULL argument. Or, 
you could avoid the issue by building without labelled network support in 
your kernel config and avoiding selopt altogether.

Can you please identify which GCC compiler you're using ( 'gcc --version' ) ?

Kerry


On Sun, 17 Nov 2002 04:58, Subba Rao wrote:
> Hi
>
> I am trying to compile SELinux on Slackware 8.1
> The LSM tree is LSM-2.4-selinux-2002102211.tgz.  I have downloaded the
> complete source tree.
>
> Towards the end of the kernel compilation I got the following error
> messages:
>
> ===========================================================
> make[3]: Entering directory `/usr/src/lsm-2.4/security/selinux/flask'
> make[3]: Nothing to be done for `all'.
> make[3]: Leaving directory `/usr/src/lsm-2.4/security/selinux/flask'
> make -C selopt
> make[3]: Entering directory `/usr/src/lsm-2.4/security/selinux/selopt'
> gcc -D__KERNEL__ -I/usr/src/lsm-2.4/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-commo -fomit-frame-pointer
> -pipe -mpreferred-stack-boundary=2 -march=k6    -I../include -I.. -nostdinc
> -I /usr/lib/gcc-lib/i3 6-slackware-linux/2.95.3/include
> -DKBUILD_BASENAME=selopt_core  -c -o selopt_core.o selopt_core.c
> selopt_core.c: In function `selopt_ip_label_output':
> selopt_core.c:299: parse error before `)'
> selopt_core.c: In function `selopt_ip_map_input':
> selopt_core.c:355: parse error before `)'
> selopt_core.c:363: parse error before `)'
> selopt_core.c: In function `selopt_ip_defragment':
> selopt_core.c:549: parse error before `)'
> make[3]: *** [selopt_core.o] Error 1
> make[3]: Leaving directory `/usr/src/lsm-2.4/security/selinux/selopt'
> make[2]: *** [_subdir_selopt] Error 2
> make[2]: Leaving directory `/usr/src/lsm-2.4/security/selinux'
> make[1]: *** [_subdir_selinux] Error 2
> make[1]: Leaving directory `/usr/src/lsm-2.4/security'
> make: *** [_dir_security] Error 2
> ===========================================================
>
> Did anyone here on the list compile SELinux on Slackware 8.x successfully?
>
> Subba Rao
> sailorn@attglobal.net
> 2002-11-16


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
