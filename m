Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9IoqIi014865
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 13:50:52 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9IotEj004569
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 18:50:55 GMT
Subject: Re: Single home directory type for all roles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <rcoker@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102616319.32175.184.camel@moss-spartans.epoch.ncsc.mil>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1102614445.4509.25.camel@aeon>
	 <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1102615951.4509.50.camel@aeon>
	 <1102616319.32175.184.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-vA81UWqDMDXsyfsWgPiY"
Message-Id: <1102617955.32175.188.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Dec 2004 13:45:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vA81UWqDMDXsyfsWgPiY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-12-09 at 13:18, Stephen Smalley wrote:
> Not sure who said that, but there are two separate LSM hooks on those
> code paths, security_inode_readlink() vs. security_inode_follow_link(). 
> They just happen to perform the same check in SELinux presently. 
> Whether or not it is legitimate to separate them in the access control
> model is another question; if you don't want the admin following the
> link, why do you want an application he runs to rely on the information
> returned by readlink?
> In any event, we could apply different permission checks - it just
> requires defining a new permission in the lnk_file class and modifying
> the selinux_inode_follow_link() hook function to use it.  Trivial patch,
> anyone could do it (but then you would need to identify all the places
> in the policy where you would need to add it).

(un-tested) Patches below should do it as far as defining the new
permission for the policy and updating the kernel.  But you would have
to audit the policy to determine when to give this permission.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-vA81UWqDMDXsyfsWgPiY
Content-Disposition: attachment; filename=sel-follow.patch
Content-Type: text/x-patch; name=sel-follow.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.141
diff -u -p -r1.141 hooks.c
--- linux-2.6/security/selinux/hooks.c	6 Dec 2004 19:57:39 -0000	1.141
+++ linux-2.6/security/selinux/hooks.c	9 Dec 2004 18:45:29 -0000
@@ -2149,7 +2149,7 @@ static int selinux_inode_follow_link(str
 	rc = secondary_ops->inode_follow_link(dentry,nameidata);
 	if (rc)
 		return rc;
-	return dentry_has_perm(current, NULL, dentry, FILE__READ);
+	return dentry_has_perm(current, NULL, dentry, LNK_FILE__FOLLOW);
 }
 
 static int selinux_inode_permission(struct inode *inode, int mask,
Index: linux-2.6/security/selinux/include/av_perm_to_string.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_perm_to_string.h,v
retrieving revision 1.19
diff -u -p -r1.19 av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	1 Dec 2004 16:47:00 -0000	1.19
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	9 Dec 2004 18:44:41 -0000
@@ -17,6 +17,7 @@
    S_(SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, "execute_no_trans")
    S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
    S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
+   S_(SECCLASS_LNK_FILE, LNK_FILE__FOLLOW, "follow")
    S_(SECCLASS_FD, FD__USE, "use")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NEWCONN, "newconn")
Index: linux-2.6/security/selinux/include/av_permissions.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_permissions.h,v
retrieving revision 1.18
diff -u -p -r1.18 av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	1 Dec 2004 16:47:00 -0000	1.18
+++ linux-2.6/security/selinux/include/av_permissions.h	9 Dec 2004 18:44:41 -0000
@@ -125,6 +125,8 @@
 #define LNK_FILE__QUOTAON                         0x00008000UL
 #define LNK_FILE__MOUNTON                         0x00010000UL
 
+#define LNK_FILE__FOLLOW                          0x00020000UL
+
 #define CHR_FILE__IOCTL                           0x00000001UL
 #define CHR_FILE__READ                            0x00000002UL
 #define CHR_FILE__WRITE                           0x00000004UL

--=-vA81UWqDMDXsyfsWgPiY
Content-Disposition: attachment; filename=policy-follow.patch
Content-Type: text/x-patch; name=policy-follow.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/flask/access_vectors
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/flask/access_vectors,v
retrieving revision 1.17
diff -u -r1.17 access_vectors
--- policy/flask/access_vectors	1 Dec 2004 16:45:37 -0000	1.17
+++ policy/flask/access_vectors	9 Dec 2004 18:44:17 -0000
@@ -123,6 +123,9 @@
 
 class lnk_file
 inherits file
+{
+	follow
+}
 
 class chr_file
 inherits file

--=-vA81UWqDMDXsyfsWgPiY--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
