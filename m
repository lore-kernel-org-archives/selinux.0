Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA10677
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 15:01:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA03892
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 19:58:56 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id TAA03888
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 19:58:56 GMT
Message-Id: <200212032008.PAA26482@moss-shockers.ncsc.mil>
Date: Tue, 3 Dec 2002 15:08:28 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Kernel Oops from afsd under the selinux kernel
To: selinux@tycho.nsa.gov, fw@fwsystems.com
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Gam_of_Porpoises_172_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Gam_of_Porpoises_172_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: wFrcAlaB3ilc380NhrybQg==


> I'm getting the following Oops running on a redhat 7.1 system with the
> LSM/selinux patches. kernel 2.4.19. The system runs well in enforcing
> mode (however this test is in non-enforcing mode because I can't really 
> do the policy changes until I have a working afsd.

You might try the attached patch to see if it helps.  The AFS code might
bypass alloc_inode() when allocating inodes, in which case the inode
would not have an allocated security structure upon entry to inode_doinit.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--Gam_of_Porpoises_172_000
Content-Type: TEXT/plain; name="inode.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: inode.patch
Content-MD5: wFS3ooXZ3QhP2MoTB25SdQ==

Index: lsm-2.4/security/selinux/hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/security/selinux/hooks.c,v
retrieving revision 1.22
diff -u -r1.22 hooks.c
--- lsm-2.4/security/selinux/hooks.c	23 Oct 2002 19:09:35 -0000	1.22
+++ lsm-2.4/security/selinux/hooks.c	3 Dec 2002 19:33:20 -0000
@@ -652,14 +652,12 @@
 	struct dentry *dentry;
 	int rc;
 
-#ifndef _SELINUX_KERNEL_PATCH_
 	if (!isec) {
 		rc = inode_alloc_security(inode);
 		if (rc)
 			return rc;
 		isec = inode->i_security;
 	}
-#endif
 
 	if (isec->initialized) {
 		/* Already initialized. */

--Gam_of_Porpoises_172_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
