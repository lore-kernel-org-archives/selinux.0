Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UDHII4004160
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 09:17:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3UDH67R006864
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 13:17:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h3UDH6KP006861 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 13:17:06 GMT
Subject: Re: truncate(2) and setattr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200304302231.13209.russell@coker.com.au>
References: <200304301034.38073.russell@coker.com.au>
	 <1051703388.1118.119.camel@moss-huskers.epoch.ncsc.mil>
	 <200304302231.13209.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1051708617.1118.173.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Apr 2003 09:16:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-30 at 08:31, Russell Coker wrote:
> This issue was first raised on the SE Linux IRC channel.  It was pointed out 
> that rw_file_perms does not permit truncating a file, which is not the 
> expected behavior.
> 
> I don't think that changing this would require any additional complexity in 
> the policy.  IMHO truncate() access should be determined by the write 
> permission (and possibly append permission for truncate() being used to 
> increase the size of a file).
> 
> I suspect that the end result of such a change is that we would be able to 
> remove many instances of setattr permission from various domains that only 
> really need truncate() access.

So you want something like the below patch, which omits the file setattr
permission check in the truncate case.

Index: lsm-2.4/security/selinux/hooks.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.4/security/selinux/hooks.c,v
retrieving revision 1.89
diff -u -r1.89 hooks.c
--- lsm-2.4/security/selinux/hooks.c	27 Mar 2003 20:05:18 -0000	1.89
+++ lsm-2.4/security/selinux/hooks.c	30 Apr 2003 13:09:39 -0000
@@ -2034,6 +2034,10 @@
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
+	if (iattr->ia_valid == (ATTR_SIZE | ATTR_CTIME)) {
+		/* truncate covered by write permission check */
+		return 0;
+	}
 	return dentry_has_perm(current, dentry, FILE__SETATTR, NULL);
 }
 

  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
