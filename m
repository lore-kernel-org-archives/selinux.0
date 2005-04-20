Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3KI5T7C002927
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 14:05:29 -0400 (EDT)
Received: from vds-320151.amen-pro.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3KI0hZY023812
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 18:00:44 GMT
Subject: [RFC][PATCH 1/2] Further SELinux restrictions on mprotect
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>, drepper@redhat.com, roland@redhat.com,
   mingo@redhat.com, James Morris <jmorris@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ABGZ8F7BTzO/tMQ3Vh2x"
Date: Wed, 20 Apr 2005 19:18:00 +0200
Message-Id: <1114017480.8495.93.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ABGZ8F7BTzO/tMQ3Vh2x
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The following patch set implements additional SELinux permission checks
on making memory executable via mprotect based on prior suggestions by
Ulrich Drepper and follow-up discussions by Roland McGrath and Ingo
Molnar, and some guidance/feedback from Stephen Smalley.=20

In order to properly test the effects of this patch set (aside from
checking the return value of mprotect calls), one needs an underlying
no-execute technology, whether software-based like exec-shield or PAX or
hardware-based.=20

As paxtest performs a real test of the executability of the memory and
doesn't just bail out on a failed mprotect call, you need the NX
mechanism when testing with it.=20

The patch(es) need testing before deciding about their future regarding=20
mainline merging or whatever else that could be appropriate. This means
that we need to identify and test applications where we need
to allow execmem e.g. for runtime-code generation but can still prevent
making the stack executable or heap executable without loss in
functionality.   Note that there may be an issue with respect to the
current handling of PT_GNU_STACK for such applications, e.g. they may be
set up with an executable stack in the first place and thus the mprotect
restrictions may never come into play.=20

Example candidates for testing are Valgrind, Java (jit-like compilers), ...

I encourage those interested in these patches or just with some free
time to "waste", to make such testing and give back the results,
suggest and make any critics or comments.

I've made available a regression test suite, simplistic (doesn't do any
fixed outputting, available at
http://pearls.tuxedo-es.org/patches/selinux/execstack-regression-0.1.tar.gz=
)
which could be used, but I recommend to use a "de-sabotaged" or just fixed,
paxtest.

The patches are known to work but have been tested only on i386 (IA-32).

The first patch, included inline below, adds an execstack permission
check that controls the ability to make the main process stack
executable so that attempts to make the stack executable can still be
prevented even if the process is allowed the existing execmem
permission in order to e.g. perform runtime code generation.  Note that
this does not yet address thread stacks. Note also that unlike the
execmem check, the execstack check is only applied on mprotect calls,
not mmap calls, as the current security_file_mmap hook is not passed
the necessary information presently.

The original author of the code that makes the distinction of the stack
region, is Ingo Molnar, who wrote it within his patch for
/proc/<pid>/maps markers.
(http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D110719881508591&w=3D2)

The patches also can be found at:
http://pearls.tuxedo-es.org/patches/selinux/policy-execstack.patch
http://pearls.tuxedo-es.org/patches/selinux/kernel-execstack.patch

policy-execstack.patch is the patch that needs to be applied to the policy =
in
order to support the execstack permission and exclude it
from general_domain_access within macros/core_macros.te.

kernel-execstack.patch adds such permission to the SELinux code within
the kernel and adds the proper permission check to the selinux_file_mprotec=
t() hook.

Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
---

 linux-2.6-20050404-lorenzo/security/selinux/hooks.c                     | =
  10 ++++++++++
 linux-2.6-20050404-lorenzo/security/selinux/include/av_perm_to_string.h | =
   1 +
 linux-2.6-20050404-lorenzo/security/selinux/include/av_permissions.h    | =
   1 +
 3 files changed, 12 insertions(+)

diff -puN security/selinux/include/av_permissions.h~kernel-execstack securi=
ty/selinux/include/av_permissions.h
--- linux-2.6-20050404/security/selinux/include/av_permissions.h~kernel-exe=
cstack	2005-04-20 18:13:57.552588928 +0200
+++ linux-2.6-20050404-lorenzo/security/selinux/include/av_permissions.h	20=
05-04-20 18:13:57.563587256 +0200
@@ -465,6 +465,7 @@
 #define PROCESS__DYNTRANSITION                    0x00800000UL
 #define PROCESS__SETCURRENT                       0x01000000UL
 #define PROCESS__EXECMEM                          0x02000000UL
+#define PROCESS__EXECSTACK                        0x04000000UL
=20
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
diff -puN security/selinux/include/av_perm_to_string.h~kernel-execstack sec=
urity/selinux/include/av_perm_to_string.h
--- linux-2.6-20050404/security/selinux/include/av_perm_to_string.h~kernel-=
execstack	2005-04-20 18:13:57.554588624 +0200
+++ linux-2.6-20050404-lorenzo/security/selinux/include/av_perm_to_string.h=
	2005-04-20 18:13:57.563587256 +0200
@@ -70,6 +70,7 @@
    S_(SECCLASS_PROCESS, PROCESS__DYNTRANSITION, "dyntransition")
    S_(SECCLASS_PROCESS, PROCESS__SETCURRENT, "setcurrent")
    S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
+   S_(SECCLASS_PROCESS, PROCESS__EXECSTACK, "execstack")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
diff -puN security/selinux/hooks.c~kernel-execstack security/selinux/hooks.=
c
--- linux-2.6-20050404/security/selinux/hooks.c~kernel-execstack	2005-04-20=
 18:13:57.558588016 +0200
+++ linux-2.6-20050404-lorenzo/security/selinux/hooks.c	2005-04-20 18:14:19=
.424263928 +0200
@@ -2478,6 +2478,16 @@ static int selinux_file_mprotect(struct=20
 		if (rc)
 			return rc;
 	}
+	if (!vma->vm_file && (prot & PROT_EXEC) &&
+		vma->vm_start <=3D vma->vm_mm->start_stack &&
+		vma->vm_end >=3D vma->vm_mm->start_stack) {
+		/* Attempt to make the process stack executable.
+		 * This has an additional execstack check.
+		 */
+		rc =3D task_has_perm(current, current, PROCESS__EXECSTACK);
+		if (rc)
+			return rc;
+	}
 #endif
=20
 	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
_
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-ABGZ8F7BTzO/tMQ3Vh2x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZo7IDcEopW8rLewRAt7UAKCkuo0eSpg2JV1lAqGs30Z7CZ5ESACfZQqN
ZGu2Zz/2HC1s3fNsHk17YLg=
=QiO4
-----END PGP SIGNATURE-----

--=-ABGZ8F7BTzO/tMQ3Vh2x--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
