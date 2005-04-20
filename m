Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3KI5e7C002950
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 14:05:40 -0400 (EDT)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3KHw1JK024685
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 17:58:02 GMT
Subject: [RFC][PATCH 2/2] Further SELinux restrictions on mprotect
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>, drepper@redhat.com, roland@redhat.com,
   mingo@redhat.com, James Morris <jmorris@redhat.com>
In-Reply-To: <1114003716.8495.16.camel@localhost.localdomain>
References: <1114003716.8495.16.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D71SKyLLRBYxrgz01FHj"
Date: Wed, 20 Apr 2005 19:18:08 +0200
Message-Id: <1114017488.8495.94.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-D71SKyLLRBYxrgz01FHj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


This patch,based on sample code by Roland McGrath, adds an execheap
permission check that controls the ability to make the heap executable
so that this can be prevented in almost all cases (the X server is
presently an exception, but this will hopefully be resolved in the future)
so that even programs with execmem permission will need to have the anonymo=
us
memory mapped in order to make it executable.=20
The only reason that we use a permission check for such restriction
(vs. making it unconditional) is that the X module loader presently
needs it; it could possibly be made unconditional in the future when
X is changed.

The policy patch for the execheap permission is available at:
http://pearls.tuxedo-es.org/patches/selinux/policy-execheap.patch

Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
---

 linux-2.6-20050404-lorenzo/security/selinux/hooks.c                     | =
  11 ++++++++++
 linux-2.6-20050404-lorenzo/security/selinux/include/av_perm_to_string.h | =
   1=20
 linux-2.6-20050404-lorenzo/security/selinux/include/av_permissions.h    | =
   1=20
 3 files changed, 13 insertions(+)

diff -puN security/selinux/include/av_permissions.h~kernel-execheap securit=
y/selinux/include/av_permissions.h
--- linux-2.6-20050404/security/selinux/include/av_permissions.h~kernel-exe=
cheap	2005-04-20 19:02:37.743652408 +0200
+++ linux-2.6-20050404-lorenzo/security/selinux/include/av_permissions.h	20=
05-04-20 19:02:37.754650736 +0200
@@ -466,6 +466,7 @@
 #define PROCESS__SETCURRENT                       0x01000000UL
 #define PROCESS__EXECMEM                          0x02000000UL
 #define PROCESS__EXECSTACK                        0x04000000UL
+#define PROCESS__EXECHEAP                         0x08000000UL
=20
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
diff -puN security/selinux/include/av_perm_to_string.h~kernel-execheap secu=
rity/selinux/include/av_perm_to_string.h
--- linux-2.6-20050404/security/selinux/include/av_perm_to_string.h~kernel-=
execheap	2005-04-20 19:02:37.745652104 +0200
+++ linux-2.6-20050404-lorenzo/security/selinux/include/av_perm_to_string.h=
	2005-04-20 19:02:37.754650736 +0200
@@ -71,6 +71,7 @@
    S_(SECCLASS_PROCESS, PROCESS__SETCURRENT, "setcurrent")
    S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
    S_(SECCLASS_PROCESS, PROCESS__EXECSTACK, "execstack")
+   S_(SECCLASS_PROCESS, PROCESS__EXECHEAP, "execheap")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
diff -puN security/selinux/hooks.c~kernel-execheap security/selinux/hooks.c
--- linux-2.6-20050404/security/selinux/hooks.c~kernel-execheap	2005-04-20 =
19:02:37.749651496 +0200
+++ linux-2.6-20050404-lorenzo/security/selinux/hooks.c	2005-04-20 19:02:37=
.756650432 +0200
@@ -2467,6 +2467,17 @@ static int selinux_file_mprotect(struct=20
 		prot =3D reqprot;
=20
 #ifndef CONFIG_PPC32
+	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXECUTABLE) &&
+	   (vma->vm_start >=3D vma->vm_mm->start_brk &&
+	    vma->vm_end <=3D vma->vm_mm->brk)) {
+	    	/*
+		 * We are making an executable mapping in the brk region.
+		 * This has an additional execheap check.
+		 */
+		rc =3D task_has_perm(current, current, PROCESS__EXECHEAP);
+		if (rc)
+			return rc;
+	}
 	if (vma->vm_file !=3D NULL && vma->anon_vma !=3D NULL && (prot & PROT_EXE=
C)) {
 		/*
 		 * We are making executable a file mapping that has
_
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-D71SKyLLRBYxrgz01FHj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZo7QDcEopW8rLewRAthfAJ4xNVUEgMfqkLl+HKtdWs13d3kMWACeJNq4
+4rDXW9dUQMdc1tsgeJAe88=
=69Nb
-----END PGP SIGNATURE-----

--=-D71SKyLLRBYxrgz01FHj--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
