Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA20846
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 08:39:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA07153
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 12:38:13 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA07149
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 12:38:13 GMT
Date: Thu, 26 Sep 2002 08:39:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <pasi.kivikangas@nokia.com>
cc: <selinux@tycho.nsa.gov>
Subject: RE: SELinux on UML
In-Reply-To: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8430@esebe013.ntc.nokia.com>
Message-ID: <Pine.GSO.4.33.0209260814420.12826-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 26 Sep 2002 pasi.kivikangas@nokia.com wrote:

> ...snip...
> make[3]: Entering directory `/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/security/selinux'
> gcc -D__KERNEL__ -I/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common  -g  -U__i386__ -Ui386 -DUM_FASTCALL -D__arch_um__ -DSUBARCH="i386" -D_LARGEFILE64_SOURCE -I/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/arch/um/include -Derrno=kernel_errno    -Iinclude  -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include -DKBUILD_BASENAME=syscalls  -c -o syscalls.o syscalls.c
> In file included from syscalls.c:1035:
> include/asm/flask/syscalls.c: In function `sys_security_selinux':
> include/asm/flask/syscalls.c:180: structure has no member named `ebx'
> include/asm/flask/syscalls.c:181: structure has no member named `ecx'
> include/asm/flask/syscalls.c:182: structure has no member named `edx'
> make[3]: *** [syscalls.o] Error 1
> make[3]: Leaving directory `/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/security/selinux'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/security/selinux'
> make[1]: *** [_subdir_selinux] Error 2
> make[1]: Leaving directory `/home/xxx/selinux/linux-2.4.19-lsm-sel-uml/security'
> make: *** [_dir_security] Error 2
> ...snip...

This is the entrypoint code for the new SELinux system calls.  The
execve_secure call is architecture-specific and requires access to the
registers on the stack in order to pass them to do_execve.  It isn't truly
ptrace-related, just dependent on an architecture-specific definition of
the way registers are stored on the stack during a system call in struct
pt_regs.  I presume that you'll need some corresponding
"architecture-specific" code for UML.

The SELinux user who reported on porting SELinux to the arm architecture
mentioned that he reorganized this code to more cleanly separate the
architecture-specific elements, changed the code that inserts the
SELinux-specific security call into the system call table to be portable,
fixed support for cross-compilation and added support so that the register
access code can be in assembly (particularly for arm).  He also had to fix
cross-compilation support in libsecure and setfiles.

Since he did provide a reasonably detailed description of his changes to
ease porting of SELinux, I could try to re-create his changes myself, but
I was expecting him to submit a patch.  If I don't get a patch from him
soon, I'll try to make these changes when I have some time.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com









--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
