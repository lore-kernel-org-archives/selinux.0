Subject: Re: Configuring kernel module for labeling ...
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: jsingh@ensim.com
Cc: Russell Coker <russell@coker.com.au>, nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1099420134.31739.250.camel@moss-spartans.epoch.ncsc.mil>
References: <1099385154.11681.3.camel@jsingh>
	 <200411030323.16648.russell@coker.com.au>
	 <1099417545.12370.21.camel@jsingh>
	 <1099420134.31739.250.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1099420972.31739.269.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 13:42:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 13:28, Stephen Smalley wrote:
> Also, stacked filesystems might be a problem in general, as SELinux is
> initializing the inode security state upon d_instantiate.  Natural
> question is when does it perform the d_instantiate upon the underlying
> inode vs. the virtual one?  And when does it copy state like the mode
> from the underlying inode to the virtual one?

Looking at mini_fo/main.c, I see that it doesn't copy the inode
attributes (e.g. mode) until after the d_instantiate.  Not good for
SELinux, as we want the mode at that time to determine the security
class.  Might want to try the patch below.

--- mini_fo/main.c.orig	2004-11-02 13:37:33.582234520 -0500
+++ mini_fo/main.c	2004-11-02 13:38:26.116248136 -0500
@@ -154,6 +154,9 @@
 		inode->i_mapping->a_ops = master_inode->i_mapping->a_ops;
 	}
 
+	/* all well, copy inode attributes */
+	fist_copy_attr_all(inode, master_inode);
+
 	/* only (our) lookup wants to do a d_add */
 	if (flag)
 		d_add(dentry, inode);
@@ -162,10 +165,6 @@
 
 
 	ASSERT(DENTRY_TO_PRIVATE(dentry) != NULL);
-
-	/* all well, copy inode attributes */
-	fist_copy_attr_all(inode, master_inode);
-
  out:
 	print_exit_status(err);
 	return err;
@@ -246,6 +245,9 @@
 		inode->i_mapping->a_ops = lower_inode->i_mapping->a_ops;
 	}
 
+	/* all well, copy inode attributes */
+	fist_copy_attr_all(inode, lower_inode);
+
 	/* only (our) lookup wants to do a d_add */
 	if (flag)
 		d_add(dentry, inode);
@@ -253,10 +255,6 @@
 		d_instantiate(dentry, inode);
 
 	ASSERT(DENTRY_TO_PRIVATE(dentry) != NULL);
-
-	/* all well, copy inode attributes */
-	fist_copy_attr_all(inode, lower_inode);
-
 out:
 	print_exit_status(err);
 	return err;

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
