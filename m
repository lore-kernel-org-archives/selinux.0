Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA20682
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 08:11:47 -0400 (EDT)
From: pasi.kivikangas@nokia.com
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA10778
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 12:09:59 GMT
Received: from mgw-x1.nokia.com (mgw-x1.nokia.com [131.228.20.21])
        by jazzband.ncsc.mil  with ESMTP id MAA10750 for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 12:09:27 GMT
Received: from esvir05nok.ntc.nokia.com (esvir05nokt.ntc.nokia.com [172.21.143.37])
	by mgw-x1.nokia.com (Switch-2.2.1/Switch-2.2.0) with ESMTP id g8QCB5522785
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 15:11:05 +0300 (EET DST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SELinux on UML
Date: Thu, 26 Sep 2002 15:11:10 +0300
Message-ID: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8430@esebe013.ntc.nokia.com>
To: <sds@tislabs.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: ext Stephen Smalley [mailto:sds@tislabs.com] Sent: 26 September, 2002 14:34
> 
> Could you provide the actual output from the failed kernel compilation?
> I'd like to see the specific error.  Is the real issue the new SELinux
> system calls?

I think the real issue is UML ptrace support but I'm not sure about it.

...snip...
make[3]: Entering directory `/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/security/selinux'
gcc -D__KERNEL__ -I/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common  -g  -U__i386__ -Ui386 -DUM_FASTCALL -D__arch_um__ -DSUBARCH="i386" -D_LARGEFILE64_SOURCE -I/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/arch/um/include -Derrno=kernel_errno    -Iinclude  -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include -DKBUILD_BASENAME=syscalls  -c -o syscalls.o syscalls.c
In file included from syscalls.c:1035:
include/asm/flask/syscalls.c: In function `sys_security_selinux':
include/asm/flask/syscalls.c:180: structure has no member named `ebx'
include/asm/flask/syscalls.c:181: structure has no member named `ecx'
include/asm/flask/syscalls.c:182: structure has no member named `edx'
make[3]: *** [syscalls.o] Error 1
make[3]: Leaving directory `/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/security/selinux'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/security/selinux'
make[1]: *** [_subdir_selinux] Error 2
make[1]: Leaving directory `/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/security'
make: *** [_dir_security] Error 2
...snip...

> As a side note, one SELinux user has privately reported that 
> in order to port SELinux to the arm architecture, he restructured the 
> SELinux code to ease porting to other architectures, which might also help 
> with UML.  I'm still waiting for him to actually submit patches with his changes.

Sounds like a good contribution if it shows up.


	- Pasi

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
