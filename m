Subject: Re: Redhat 9
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1061830219.18210.50.camel@colossus.columbia.tresys.com>
References: <1061830219.18210.50.camel@colossus.columbia.tresys.com>
Content-Type: multipart/mixed; boundary="=-yXNae7fB5m7KvzhTJkRb"
Message-Id: <1061832549.28086.538.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 25 Aug 2003 13:29:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-yXNae7fB5m7KvzhTJkRb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-08-25 at 12:50, Karl MacMillan wrote:
> I have been setting up an SELinux system using the current 2.6 SELinux
> release (2.6.0-test3) on Redhat 9. Everything seems to be working well
> with 2 exceptions:
> 
> - Using ext2 as the filesystem seems to have some problems with extended
> attributes and sockets. Doing a make relabel failed for any sockets
> (/dev/log for example). This seems to be a general problem with ext2,
> however, as the standard extended attribute tools failed to get/set
> attributes on these files with 'operation not supported'.

This appears to be a typo in ext2/namei.c; try rebuilding your kernel
after applying the attached patch.  Or use ext3.

> - The glibc srpm compiles correctly but causes any program linked to
> glibc to segfault after installation. I did very little to track down
> this problem, but I can easily provide more debugging information on
> request (this is using VMWare so it is not a problem to install the rpm
> and do some more testing because I can revert it later).

Build two glibc rpms, one with --target=i386 and one with
--target=i686.  Then install the i686 "glibc" binary RPM along with the
other RPMs from the i386 build, excluding the i386 "glibc" binary RPM.

You might also be able to use the rawhide RPMs, as I think that the
AT_SECURE support has shown up in them.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-yXNae7fB5m7KvzhTJkRb
Content-Disposition: attachment; filename=ext2-xattr.patch
Content-Type: text/x-patch; name=ext2-xattr.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.5/fs/ext2/namei.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.5/fs/ext2/namei.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 namei.c
--- linux-2.5/fs/ext2/namei.c	11 Jul 2003 14:20:17 -0000	1.1.1.2
+++ linux-2.5/fs/ext2/namei.c	25 Aug 2003 16:57:27 -0000
@@ -143,7 +143,7 @@
 	int err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, inode->i_mode, rdev);
-#ifdef CONFIG_EXT2_FS_EXT_ATTR
+#ifdef CONFIG_EXT2_FS_XATTR
 		inode->i_op = &ext2_special_inode_operations;
 #endif
 		mark_inode_dirty(inode);

--=-yXNae7fB5m7KvzhTJkRb--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
