Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UH2JI4005639
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 13:02:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3UH2J7R021730
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 17:02:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h3UH2IKP021727 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 17:02:18 GMT
Subject: Re: truncate(2) and setattr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200305010016.04155.russell@coker.com.au>
References: <200304301034.38073.russell@coker.com.au>
	 <200304302231.13209.russell@coker.com.au>
	 <1051708617.1118.173.camel@moss-huskers.epoch.ncsc.mil>
	 <200305010016.04155.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1051722122.1028.12.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Apr 2003 13:02:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-30 at 10:16, Russell Coker wrote:
> Yes.  I believe that using write permission checks for this is the appropriate 
> thing to do.  I think that a CTIME change does not deserve much attention, 
> and size is a direct function of write/append.

truncate sets the ATTR_SIZE and ATTR_CTIME flags before calling
notify_change; that is why ATTR_CTIME was included in the test. 
However, in thinking about this further, I think it is lacking in two
respects:  1) We should recheck write permission in
selinux_inode_setattr in the truncate case to ensure revalidation in the
ftruncate case (e.g. in case the file was relabeled or the policy was
changed after the open), and 2) We should handle utimes(p,NULL) in the
same manner, only checking write permission for it, as it merely sets
the timestamps to the current time.  For changes to the mode, uid, gid,
or explicit setting of timestamps via utimes(p,&times), we should still
check setattr permission.  We could split the utimes(p,&times) case into
a separate permission to distinguish it from changes to the DAC
protection state of the file, but this will require adding a new
permission to the file class.  The patch below does everything except
split utimes(p,&times) into a separate permission:

Index: lsm-2.4/security/selinux/hooks.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.4/security/selinux/hooks.c,v
retrieving revision 1.89
diff -u -r1.89 hooks.c
--- lsm-2.4/security/selinux/hooks.c	27 Mar 2003 20:05:18 -0000	1.89
+++ lsm-2.4/security/selinux/hooks.c	30 Apr 2003 16:49:34 -0000
@@ -2034,7 +2034,11 @@
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
-	return dentry_has_perm(current, dentry, FILE__SETATTR, NULL);
+	if (iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID | 
+			       ATTR_ATIME_SET | ATTR_MTIME_SET))
+		return dentry_has_perm(current, dentry, FILE__SETATTR, NULL);
+
+	return dentry_has_perm(current, dentry, FILE__WRITE, NULL);
 }
 
 static int selinux_inode_stat(struct inode *inode)


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
