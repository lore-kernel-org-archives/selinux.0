Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9QEDXXZ012488
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 10:13:33 -0400 (EDT)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9QECFC0020762
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 14:12:15 GMT
Received: (from smmsp@localhost)
	by tcsfw2.tcs-sec.com (8.12.2/8.12.2) id i9QEDXsS024401
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 10:13:33 -0400 (EDT)
Message-ID: <417E5BB5.1010300@trustedcs.com>
Date: Tue, 26 Oct 2004 09:14:13 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: [PATCH] devpts xattr support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is a patch (against the SourceForge CVS) that will give xattr 
support to directories in a devpts filesystem.  This will allow the 
context of the root node to be retrieved and modified.  Note that there 
are other filesystems using the simple_dir_inode_operations that may 
need to be changed later as xattr support is spread to more filesystems 
(devpts is the only one causing a problem right now), so a more general 
fix may be wanted/needed later.  Any comments are appreciated.

Darrel Goeddel
Senior Secure Systems Engineer

Trusted Computer Solutions             E: dgoeddel@trustedcs.com
121 West Goose Alley                   V: 217.384.0028 x19
Urbana, IL  61801                      F: 217.384.0288


--- inode.c     12 Oct 2004 18:07:40 -0000      1.1.1.3
+++ inode.c     25 Oct 2004 17:41:43 -0000      1.2
@@ -40,6 +40,16 @@
  #endif
  };

+struct inode_operations devpts_dir_inode_operations = {
+       .lookup         = simple_lookup,
+#ifdef CONFIG_DEVPTS_FS_XATTR
+       .setxattr       = generic_setxattr,
+       .getxattr       = generic_getxattr,
+       .listxattr      = generic_listxattr,
+       .removexattr    = generic_removexattr,
+#endif /* CONFIG_DEVPTS_FS_XATTR */
+};
+
  static struct vfsmount *devpts_mnt;
  static struct dentry *devpts_root;

@@ -113,7 +123,7 @@
         inode->i_blksize = 1024;
         inode->i_uid = inode->i_gid = 0;
         inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
-       inode->i_op = &simple_dir_inode_operations;
+       inode->i_op = &devpts_dir_inode_operations;
         inode->i_fop = &simple_dir_operations;
         inode->i_nlink = 2;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
