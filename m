From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
Reply-To: edwin@gurde.com
To: selinux@tycho.nsa.gov
Subject: [PATCH ] consistent labeling of block|character devices
Date: Mon, 1 May 2006 19:06:38 +0300
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <200604262113.01211.edwin@gurde.com> <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605011906.38351.edwin@gurde.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 April 2006 22:26, Stephen Smalley wrote:
>  However, ensuring a consistent label on devices
> irrespective of filesystem node used to access them would be nice; there
> has been some consideration of labeling the internal objects rather than
> just the filesystem nodes and applying access control at that layer to
> ensure consistent control. 
IMHO there are two approaches here: 
1) introduce a sid member in struct block_device and struct cdev
and then each time someone reads the sid of an inode of class 
SECCLASS_BLKFILE|SECCLASS_CHR_FILE, returns the sid of the associated device.
If relabeling is to be allowed, then relabeling the inode would mean 
relabeling the associated device.
But this would introduce additional overhead (the extra if to determine if we 
are dealing with device files) every time we read the sid of an inode. This 
seems not acceptable to me.

2) put a constant(invariant) label on devices, defined by policy
Policy would define what label a device with giver major/minor number.
We would then use this as the security context of the inode, no matter what 
its xattr would say.
So no matter how many device files we have pointing to the same device (same 
major/minor no.) all will have the same sid.

I tried putting an additional condition in inode_doinit_with_dentry, to 
compute the sid of block and character devices in a different way than for 
normal files. This would take care of initial labeling.
What should happen on relabeling, should the policy deny it (and we rely on 
that), or should some explicit code be added to return denied (somewhere in 
security_compute_av?) when tclass==SECCLASS_BLK_FILE||
tclass==SECCLASS_CHR_FILE, and requested==RELABEL_TO.

How time critical is inode_doinit_with_dentry, does adding an addittional if 
matter?

I am not sure how to implement map_device_to_sid, should I use 
selinux_genfs_context?

With the current policy language, what would be the easiest way of defining 
block device,character device initial sids?

And what would happen with modules that create block devices with dinamic 
major/minor numbers? How should those be labeled?

Any ideas,suggestions?

----
diff -uprN -X vanilla/linux-2.6.16/Documentation/dontdiff 
vanilla/linux-2.6.16/security/selinux/hooks.c 
linux-2.6.16/security/selinux/hooks.c
--- vanilla/linux-2.6.16/security/selinux/hooks.c	2006-03-20 
18:29:57.000000000 +0200
+++ linux-2.6.16/security/selinux/hooks.c	2006-05-01 18:27:05.000000000 +0300
@@ -731,7 +731,7 @@ static int inode_doinit_with_dentry(stru
 	hold_sem = 1;
 	if (isec->initialized)
 		goto out;
-
+   
 	sbsec = inode->i_sb->s_security;
 	if (!sbsec->initialized) {
 		/* Defer initialization until selinux_complete_init,
@@ -744,6 +744,18 @@ static int inode_doinit_with_dentry(stru
 		goto out;
 	}
 
+        int sclass = inode_mode_to_security_class(inode->i_mode);  
+        if(sclass == SECCLASS_BLK_FILE || sclass == SECCLASS_CHR_FILE)
+        {	
+	   char dev[16];
+	   isec->sclass = sclass;
+	   map_device_to_sid(inode->i_rdev,sclass,&sid);
+	   isec->sid=sid;
+	   isec->initialized=1;
+	   goto out;
+        }
+   
+
 	switch (sbsec->behavior) {
 	case SECURITY_FS_USE_XATTR:
 		if (!inode->i_op->getxattr) {
@@ -833,7 +845,7 @@ static int inode_doinit_with_dentry(stru
 		isec->sid = sbsec->sid;
 
 		/* Try to obtain a transition SID. */
-		isec->sclass = inode_mode_to_security_class(inode->i_mode);
+		isec->sclass = sclass;
 		rc = security_transition_sid(isec->task_sid,
 					     sbsec->sid,
 					     isec->sclass,
@@ -849,7 +861,7 @@ static int inode_doinit_with_dentry(stru
 		if (sbsec->proc) {
 			struct proc_inode *proci = PROC_I(inode);
 			if (proci->pde) {
-				isec->sclass = inode_mode_to_security_class(inode->i_mode);
+				isec->sclass = sclass;
 				rc = selinux_proc_get_sid(proci->pde,
 							  isec->sclass,
 							  &sid);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
