Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA08991
	for <selinux@tycho.nsa.gov>; Mon, 18 Nov 2002 19:32:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA10836
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 00:30:09 GMT
Received: from prserv.net (asmtp2.prserv.net [32.97.166.52])
	by jazzswing.ncsc.mil  with ESMTP id AAA10832
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 00:30:09 GMT
Message-Id: <200211190030.AAA10832@jazzswing.ncsc.mil>
Date: Mon, 18 Nov 2002 19:28:58 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: Kerry Thompson <kerry@crypt.gen.nz>, selinux <selinux@tycho.nsa.gov>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Re: SELinux compile errors
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you for replying.

The gcc version on my system is 2.95.3

The errors I listed showed up when I compiled in the EXPERIMENTAL modules.  When I removed them, the compile went thru fine.

One other question, is PAM required for compiling SELinux?

Subba Rao
sailorn@attglobal.net
2002-11-18


======= At 2002-11-18, 11:04:00 you wrote: =======

>The same problem was raised a few weeks ago, it comes from ip_warn() in 
>selopt_core.c having two arguments, while the macro definition in selopt.h 
>has 3 arguments. Namely :
>
>
>
>Can you please identify which GCC compiler you're using ( 'gcc --version' ) ?
>
>Kerry
>
>
>On Sun, 17 Nov 2002 04:58, Subba Rao wrote:
>> Hi
>>
>> I am trying to compile SELinux on Slackware 8.1
>> The LSM tree is LSM-2.4-selinux-2002102211.tgz.  I have downloaded the
>> complete source tree.
>>
>> Towards the end of the kernel compilation I got the following error
>> messages:
>>
>> ===========================================================
>> make[3]: Entering directory `/usr/src/lsm-2.4/security/selinux/flask'
>> make[3]: Nothing to be done for `all'.
>> make[3]: Leaving directory `/usr/src/lsm-2.4/security/selinux/flask'
>> make -C selopt
>> make[3]: Entering directory `/usr/src/lsm-2.4/security/selinux/selopt'
>> gcc -D__KERNEL__ -I/usr/src/lsm-2.4/include -Wall -Wstrict-prototypes
>> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-commo -fomit-frame-pointer
>> -pipe -mpreferred-stack-boundary=2 -march=k6    -I../include -I.. -nostdinc
>> -I /usr/lib/gcc-lib/i3 6-slackware-linux/2.95.3/include
>> -DKBUILD_BASENAME=selopt_core  -c -o selopt_core.o selopt_core.c
>> selopt_core.c: In function `selopt_ip_label_output':
>> selopt_core.c:299: parse error before `)'
>> selopt_core.c: In function `selopt_ip_map_input':
>> selopt_core.c:355: parse error before `)'
>> selopt_core.c:363: parse error before `)'
>> selopt_core.c: In function `selopt_ip_defragment':
>> selopt_core.c:549: parse error before `)'
>> make[3]: *** [selopt_core.o] Error 1
>> make[3]: Leaving directory `/usr/src/lsm-2.4/security/selinux/selopt'
>> make[2]: *** [_subdir_selopt] Error 2
>> make[2]: Leaving directory `/usr/src/lsm-2.4/security/selinux'
>> make[1]: *** [_subdir_selinux] Error 2
>> make[1]: Leaving directory `/usr/src/lsm-2.4/security'
>> make: *** [_dir_security] Error 2
>> ===========================================================
>>
>> Did anyone here on the list compile SELinux on Slackware 8.x successfully?
>>

= = = = = = = = = = = = = = = = = = = =
			





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
