Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02523
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 17:29:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA21843
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 22:27:09 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id WAA21839 for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 22:27:09 GMT
Message-Id: <200210302230.RAA26019@moss-anteater.epoch.ncsc.mil>
Date: Wed, 30 Oct 2002 17:30:22 -0500 (EST)
From: James W Carter <jwcart2@epoch.ncsc.mil>
Reply-To: James W Carter <jwcart2@epoch.ncsc.mil>
Subject: SELinux Kernel Oops
To: linux-security-module@wirex.com, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Flock_of_Ostrich_721_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Flock_of_Ostrich_721_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: BOM2i1VP2sf2O1nTC6WznA==

I found a problem with SELinux on a 2.5.44 kernel generating a kernel Oops when 
running nfsd.

The problem is due to the fact that nfsd does not call 
fs/file_table.c:get_empty_filp where the file_alloc_security hook function is 
called, but instead calls fs/file_table.c:init_private_file.  So struct 
file_security_struct is never allocated or initialized.  Upon further checking, 
the only other place where init_private_file is called is in 
fs/exportfs/expfs.c:get_name.  This problem was not previously encountered 
because of the reliance file_precondition.

The attached patches add file_alloc_security calls in init_private_file, and 
file_free_security calls in init_private_file (if an error occurs), 
fs/nfsd/vfs.c:nfsd_close, and get_name.

The patches have been committed to the sourceforge selinux CVS tree.

By placing the file_alloc_security in init_private_file, we ensure that all file 
structures have allocated security fields so we will not get a kernel Oops.  We 
could still potentially have a memory leak if an out-of-tree kernel module uses 
init_private_file, but doesn't use the file_alloc_security hook.  There was the 
same potential for a memory leak when file_precondition was used.

--
Jim Carter
Information Assurance Research Group
National Security Agency

--Flock_of_Ostrich_721_000
Content-Type: TEXT/plain; name="2.4filealloc.patch"; charset=US-ASCII; x-unix-mode=0644
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Description: 2.4filealloc.patch
Content-MD5: eSvteh3Ymo0tQAlTuDtpzg==

Index: lsm-2.4/fs/file_table.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/lsm/lsm-2.4/fs/file_table.c,v
retrieving revision 1.6
diff -u -r1.6 file_table.c
--- lsm-2.4/fs/file_table.c=092002/07/08 11:18:42=091.6
+++ lsm-2.4/fs/file_table.c=092002/10/30 17:59:21
@@ -91,6 +91,7 @@
  */
 int init_private_file(struct file *filp, struct dentry *dentry, int mode)
 {
+=09int error;
 =09memset(filp, 0, sizeof(*filp));
 =09filp->f_mode   =3D mode;
 =09atomic_set(&filp->f_count, 1);
@@ -98,9 +99,15 @@
 =09filp->f_uid    =3D current->fsuid;
 =09filp->f_gid    =3D current->fsgid;
 =09filp->f_op     =3D dentry->d_inode->i_fop;
-=09if (filp->f_op->open)
-=09=09return filp->f_op->open(dentry->d_inode, filp);
-=09else
+=09error =3D security_ops->file_alloc_security(filp);
+=09if (error)
+=09=09return error;
+=09if (filp->f_op->open) {
+=09=09error =3D filp->f_op->open(dentry->d_inode, filp);
+=09=09if (error)=20
+=09=09=09security_ops->file_free_security(filp);
+=09=09return error;
+=09} else
 =09=09return 0;
 }
=20
Index: lsm-2.4/fs/nfsd/nfsfh.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/lsm/lsm-2.4/fs/nfsd/nfsfh.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 nfsfh.c
--- lsm-2.4/fs/nfsd/nfsfh.c=092002/08/05 13:41:03=091.1.1.8
+++ lsm-2.4/fs/nfsd/nfsfh.c=092002/10/30 17:59:40
@@ -115,6 +115,7 @@
 out_close:
 =09if (file.f_op->release)
 =09=09file.f_op->release(dir, &file);
+=09security_ops->file_free_security(&file);
 out:
 =09return error;
 }
Index: lsm-2.4/security/selinux/psid.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/lsm/lsm-2.4/security/selinux/psid.c,v
retrieving revision 1.12
diff -u -r1.12 psid.c
--- lsm-2.4/security/selinux/psid.c=092002/09/19 18:06:31=091.12
+++ lsm-2.4/security/selinux/psid.c=092002/10/30 17:59:40
@@ -178,6 +178,7 @@
 =09for (i =3D 0; i < PSEC_NFILES; i++) {
 =09=09if (t->files[i].f_dentry) {
 =09=09=09dput(t->files[i].f_dentry);
+=09=09=09security_ops->file_free_security(&t->files[i]);
 =09=09}
 =09}
=20

--Flock_of_Ostrich_721_000
Content-Type: TEXT/plain; name="2.5filealloc.patch"; charset=US-ASCII; x-unix-mode=0644
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Description: 2.5filealloc.patch
Content-MD5: 5M4hpxqt5KJno16Pgk3r5A==

Index: lsm-2.5/fs/file_table.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/lsm/lsm-2.5/fs/file_table.c,v
retrieving revision 1.10
diff -u -r1.10 file_table.c
--- lsm-2.5/fs/file_table.c=092002/10/16 14:22:37=091.10
+++ lsm-2.5/fs/file_table.c=092002/10/30 18:02:14
@@ -95,6 +95,7 @@
  */
 int init_private_file(struct file *filp, struct dentry *dentry, int mode)
 {
+=09int error;
 =09memset(filp, 0, sizeof(*filp));
 =09filp->f_mode   =3D mode;
 =09atomic_set(&filp->f_count, 1);
@@ -102,9 +103,15 @@
 =09filp->f_uid    =3D current->fsuid;
 =09filp->f_gid    =3D current->fsgid;
 =09filp->f_op     =3D dentry->d_inode->i_fop;
-=09if (filp->f_op->open)
-=09=09return filp->f_op->open(dentry->d_inode, filp);
-=09else
+=09error =3D security_ops->file_alloc_security(filp);
+=09if (error)
+=09=09return error;
+=09if (filp->f_op->open) {
+=09=09error =3D filp->f_op->open(dentry->d_inode, filp);
+=09=09if (error)=20
+=09=09=09security_ops->file_free_security(filp);
+=09=09return error;
+=09} else
 =09=09return 0;
 }
=20
Index: lsm-2.5/fs/nfsd/vfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/lsm/lsm-2.5/fs/nfsd/vfs.c,v
retrieving revision 1.1.1.16
diff -u -r1.1.1.16 vfs.c
--- lsm-2.5/fs/nfsd/vfs.c=092002/10/21 18:23:22=091.1.1.16
+++ lsm-2.5/fs/nfsd/vfs.c=092002/10/30 18:02:35
@@ -490,6 +490,7 @@
=20
 =09if (filp->f_op->release)
 =09=09filp->f_op->release(inode, filp);
+=09security_ops->file_free_security(filp);
 =09if (filp->f_mode & FMODE_WRITE)
 =09=09put_write_access(inode);
 }
Index: lsm-2.5/fs/exportfs/expfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/lsm/lsm-2.5/fs/exportfs/expfs.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 expfs.c
--- lsm-2.5/fs/exportfs/expfs.c=092002/10/14 12:14:46=091.1.1.8
+++ lsm-2.5/fs/exportfs/expfs.c=092002/10/30 18:02:44
@@ -383,6 +383,7 @@
 out_close:
 =09if (file.f_op->release)
 =09=09file.f_op->release(dir, &file);
+=09security_ops->file_free_security(&file);
 out:
 =09return error;
 }
Index: lsm-2.5/security/selinux/psid.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/lsm/lsm-2.5/security/selinux/psid.c,v
retrieving revision 1.14
diff -u -r1.14 psid.c
--- lsm-2.5/security/selinux/psid.c=092002/09/19 18:08:30=091.14
+++ lsm-2.5/security/selinux/psid.c=092002/10/30 18:02:44
@@ -179,6 +179,7 @@
 =09for (i =3D 0; i < PSEC_NFILES; i++) {
 =09=09if (t->files[i].f_dentry) {
 =09=09=09dput(t->files[i].f_dentry);
+=09=09=09security_ops->file_free_security(&t->files[i]);
 =09=09}
 =09}
=20

--Flock_of_Ostrich_721_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
