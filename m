Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7MFTqrT013469
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 11:29:52 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7MFT5dQ006468
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 15:29:05 GMT
Message-ID: <4128BBE6.6050207@tresys.com>
Date: Sun, 22 Aug 2004 11:29:42 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
References: <200408222125.38169.russell@coker.com.au> <20040822144016.GA13842@lkcl.net>
In-Reply-To: <20040822144016.GA13842@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

None of this restorecon voodoo nor mount context is necessary when udev 
is implemented correctly.

When we were experimenting with udev it only took ramfs xattr support, 
add ramfs to fs_use as an xattr filesystem and set up udev with selinux 
support. When it runs it creates the nodes and then labels them via the 
libselinux api which reads file_contexts. Aside from the problems I've 
already mentioned there should be no problems running udev.

If the tmpfs context support is something different from this then it 
should not be used (I have not looked at tmpfs support at all but have 
personal experience that ramfs xattr works as expected).

Joshua

Luke Kenneth Casson Leighton wrote:

>On Sun, Aug 22, 2004 at 09:25:38PM +1000, Russell Coker wrote:
>  
>
>>It seems that udev is now virtually mandatory as of the latest rawhide update.
>>
>>udev uses ramfs for /tmp, ramfs (as of the latest Fedora kernel 2.6.8-1.525) 
>>has no support for file labelling and breaks everything.
>>
>>Can we get ramfs labelling working in the next few days or do we have to 
>>change things to not depend on udev?
>>    
>>
> 
> chris pebenito of gentoo/hardened i believe has written a ramfs patch
> already (2.6.6)
>
> it was what i based the shmfs one off of.
>
> or maybe that's the other way round, i dunno.  can't remember.
>
>
> remember that just getting ramfs / tmpfs working is not enough, you
> must also:
>
> - patch selinux/hooks.c to allow mount -o fscontext=system_u:object_r:device_t
>   on a tmpfs or shmfs or add an extra option to hooks.c _similar_ to
>   fscontext but without the bit that says "stop if this filesystem
>   supports xattrs".
>
> - modify /etc/init.d/udev to then mount /dev with the default context
>   of device_t which whill FAIL if you DO NOT patch hooks.c as above:
>
>    mount -n -o
>	   fscontext=system_u:object_r:device_t,size=$tmpfs_size,mode=0755
>	   -t tmpfs none /dev
>
> - add in an equivalent of my extra post-udev-and-hotplug duplicate of
>   /etc/init.d/modutils that will load things like nvidia, ppp_generic
>   and stuff that are not yet fully 2.6-compliant drivers (i.e. they
>   don't grok /sys and consequently don't generate hotplug events) .
>
>   i assume that rawhide, given that it is using udev already, is
>   perfectly capable of doing a proper and far superior job to what
>   i have hacked up.
>
> - run a restorecon on ALL DEVICE NODES CREATED PRIOR TO /etc/init.d/udev
>   RUNNING.
>
>   i got bored of doing this regularly and manually and so wrote a
>   small script (/sbin/restoredevicefiles) which does this for me.
>   badly.  it uses ls (really must use commands NOT from /usr and must
>   use commands that DO NOT a require /dev/null or access to /dev/fd/*)
>
>   i believe i had to copy cut from /usr/bin/cut to /bin/cut (!!) hey
>   there are probably people out there who could do this as c-code
>   or with sed or something more appropriate, to be honest i haven't
>   got time to DoItRight(tm) so the ItWorksForMe(tm) approach is fine
>   for me until _someone else_ does the DoItRight(tm) approach.
>
> - udev, udevd _and_ udevsend (_why_ is udev split into three separate
>   programs??????) _all_ need to be hacked up to run setfiles -q -s on a
>   pipe which udev(d?) will communicate the name of the inode to.
>
>   russell advised me that using popen would be suitable for this:
>   however i am not sure whether it should be put in udev or in
>   udevd and i haven't the TimeRightNow(tm) to focus on
>   MakingItNice(tm)
>
>   alternatively, a patch (also attached) to add selinux "restorecon"
>   stuff to udevsend is included which, although it still has a 1/4
>   second delay per inode added, at least works.
>
>   patch is against udev-0.030.  udev-0.030 has had the
>   /etc/udev.d/default/selinux script removed which is a complete pain
>   but hey, if linux-hotplug-devel say it don't work, it don't work.
>
>
> it's taken me about three maybe four weeks to get this hacked up to
> a working / reasonably acceptable (for me at least) point.
>
> i'm assuming that you would like the kernel patches: if you would like
> me to place a copy of my hacked-up policy files at hands.com/~lkcl/selinux
> please let me know because they are not very pretty but will save you a
> lot of time: because i don't know any better it has taken me somewhere
> in excess of 100 reboots to get a working udev-tmpfs-enabled policy
> plus initscripts hacks.
>
> if someone can inform me of the appropriate cvs-based diff
> command that will allow me to include fs/ramfs/xattr.c
> and fs/ramfs/xattr-security.c in the patch i would be most
> grateful, otherwise people will just have to manually blat
> those two files (attached) into the appropriate locations.
>
> i'd _really_ appreciate it if people _could_ say "hey, yes, we
> really need tmpfs-enabled udev in fc" because then i wouldn't
> have so much crap hanging around on my debian/selinux system:
> i'd far rather it had already been done and i could have
> copied or relied on the work of more experienced individuals.
>
> l.
>
>  
>
>------------------------------------------------------------------------
>
>Index: fs/Kconfig
>===================================================================
>RCS file: /cvsroot/selinux/nsa/linux-2.6/fs/Kconfig,v
>retrieving revision 1.8
>diff -u -u -r1.8 Kconfig
>--- fs/Kconfig	18 Jun 2004 20:37:21 -0000	1.8
>+++ fs/Kconfig	22 Aug 2004 14:06:10 -0000
>@@ -925,6 +925,27 @@
> 
> 	  See <file:Documentation/filesystems/tmpfs.txt> for details.
> 
>+config TMPFS_FS_XATTR
>+	bool "tmpfs Extended Attributes"
>+	help
>+	  Extended attributes are name:value pairs associated with inodes by
>+	  the kernel or by users (see the attr(5) manual page, or visit
>+	  <http://acl.bestbits.at/> for details).
>+
>+	  If unsure, say N.
>+
>+config TMPFS_FS_SECURITY
>+	bool "tmpfs Security Labels"
>+	depends on TMPFS_FS_XATTR
>+	help
>+	  Security labels support alternative access control models
>+	  implemented by security modules like SELinux.  This option
>+	  enables an extended attribute handler for file security
>+	  labels in the tmpfs filesystem.
>+
>+	  If you are not using a security module that requires using
>+	  extended attributes for file security labels, say N.
>+
> config HUGETLBFS
> 	bool "HugeTLB file system support"
> 	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || X86_64 || BROKEN
>Index: fs/ramfs/Makefile
>===================================================================
>RCS file: /cvsroot/selinux/nsa/linux-2.6/fs/ramfs/Makefile,v
>retrieving revision 1.1.1.1
>diff -u -u -r1.1.1.1 Makefile
>--- fs/ramfs/Makefile	14 Aug 2003 12:08:40 -0000	1.1.1.1
>+++ fs/ramfs/Makefile	22 Aug 2004 14:06:10 -0000
>@@ -5,3 +5,6 @@
> obj-$(CONFIG_RAMFS) += ramfs.o
> 
> ramfs-objs := inode.o
>+ramfs-$(CONFIG_RAMFS_FS_XATTR)    += xattr.o
>+ramfs-$(CONFIG_RAMFS_FS_SECURITY) += xattr_security.o
>+
>Index: fs/ramfs/inode.c
>===================================================================
>RCS file: /cvsroot/selinux/nsa/linux-2.6/fs/ramfs/inode.c,v
>retrieving revision 1.1.1.4
>diff -u -u -r1.1.1.4 inode.c
>--- fs/ramfs/inode.c	18 Jun 2004 19:30:21 -0000	1.1.1.4
>+++ fs/ramfs/inode.c	22 Aug 2004 14:06:11 -0000
>@@ -31,6 +31,7 @@
> #include <linux/string.h>
> #include <linux/smp_lock.h>
> #include <linux/backing-dev.h>
>+#include "xattr.h"
> 
> #include <asm/uaccess.h>
> 
>@@ -157,6 +158,10 @@
> 
> static struct inode_operations ramfs_file_inode_operations = {
> 	.getattr	= simple_getattr,
>+	.setxattr   = ramfs_setxattr,
>+	.getxattr   = ramfs_getxattr,
>+	.listxattr  = ramfs_listxattr,
>+	.removexattr    = ramfs_removexattr,
> };
> 
> static struct inode_operations ramfs_dir_inode_operations = {
>@@ -169,6 +174,10 @@
> 	.rmdir		= simple_rmdir,
> 	.mknod		= ramfs_mknod,
> 	.rename		= simple_rename,
>+	.setxattr   = ramfs_setxattr,
>+	.getxattr   = ramfs_getxattr,
>+	.listxattr  = ramfs_listxattr,
>+	.removexattr    = ramfs_removexattr,
> };
> 
> static struct super_operations ramfs_ops = {
>@@ -224,12 +233,17 @@
> 
> static int __init init_ramfs_fs(void)
> {
>+	int err = init_ramfs_xattr();
>+	if (err)
>+		return err;
>+
> 	return register_filesystem(&ramfs_fs_type);
> }
> 
> static void __exit exit_ramfs_fs(void)
> {
> 	unregister_filesystem(&ramfs_fs_type);
>+	exit_ramfs_xattr();
> }
> 
> module_init(init_ramfs_fs)
>Index: mm/Makefile
>===================================================================
>RCS file: /cvsroot/selinux/nsa/linux-2.6/mm/Makefile,v
>retrieving revision 1.1.1.4
>diff -u -u -r1.1.1.4 Makefile
>--- mm/Makefile	18 Jun 2004 19:31:02 -0000	1.1.1.4
>+++ mm/Makefile	22 Aug 2004 14:06:12 -0000
>@@ -15,3 +15,6 @@
> obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
> obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
> obj-$(CONFIG_NUMA) 	+= mempolicy.o
>+
>+obj-$(CONFIG_TMPFS_FS_XATTR)    += xattr.o
>+obj-$(CONFIG_TMPFS_FS_SECURITY) += xattr_security.o
>Index: mm/shmem.c
>===================================================================
>RCS file: /cvsroot/selinux/nsa/linux-2.6/mm/shmem.c,v
>retrieving revision 1.1.1.8
>diff -u -u -r1.1.1.8 shmem.c
>--- mm/shmem.c	18 Jun 2004 19:31:03 -0000	1.1.1.8
>+++ mm/shmem.c	22 Aug 2004 14:06:12 -0000
>@@ -44,6 +44,8 @@
> #include <asm/div64.h>
> #include <asm/pgtable.h>
> 
>+#include "xattr.h"
>+
> /* This magic number is used in glibc for posix shared memory */
> #define TMPFS_MAGIC	0x01021994
> 
>@@ -168,6 +170,8 @@
> static struct file_operations shmem_file_operations;
> static struct inode_operations shmem_inode_operations;
> static struct inode_operations shmem_dir_inode_operations;
>+static struct inode_operations shmfs_special_inode_operations;
>+static struct inode_operations shmem_symlink_inode_operations;
> static struct vm_operations_struct shmem_vm_ops;
> 
> static struct backing_dev_info shmem_backing_dev_info = {
>@@ -1212,6 +1216,7 @@
>  		mpol_shared_policy_init(&info->policy);
> 		switch (mode & S_IFMT) {
> 		default:
>+			inode->i_op = &shmfs_special_inode_operations;
> 			init_special_inode(inode, mode, dev);
> 			break;
> 		case S_IFREG:
>@@ -1229,6 +1234,7 @@
> 			inode->i_fop = &simple_dir_operations;
> 			break;
> 		case S_IFLNK:
>+			inode->i_op = &shmem_symlink_inode_operations;
> 			break;
> 		}
> 	}
>@@ -1261,7 +1267,6 @@
> 
> #ifdef CONFIG_TMPFS
> 
>-static struct inode_operations shmem_symlink_inode_operations;
> static struct inode_operations shmem_symlink_inline_operations;
> 
> /*
>@@ -1715,12 +1720,33 @@
> static struct inode_operations shmem_symlink_inline_operations = {
> 	.readlink	= shmem_readlink_inline,
> 	.follow_link	= shmem_follow_link_inline,
>+#ifdef CONFIG_TMPFS
>+	.setxattr   = shmfs_setxattr,
>+	.getxattr   = shmfs_getxattr,
>+	.listxattr  = shmfs_listxattr,
>+	.removexattr    = shmfs_removexattr,
>+#endif
>+};
>+
>+static struct inode_operations shmfs_special_inode_operations = {
>+#ifdef CONFIG_TMPFS
>+	.setxattr   = shmfs_setxattr,
>+	.getxattr   = shmfs_getxattr,
>+	.listxattr  = shmfs_listxattr,
>+	.removexattr    = shmfs_removexattr,
>+#endif
> };
> 
> static struct inode_operations shmem_symlink_inode_operations = {
> 	.truncate	= shmem_truncate,
> 	.readlink	= shmem_readlink,
> 	.follow_link	= shmem_follow_link,
>+#ifdef CONFIG_TMPFS
>+	.setxattr   = shmfs_setxattr,
>+	.getxattr   = shmfs_getxattr,
>+	.listxattr  = shmfs_listxattr,
>+	.removexattr    = shmfs_removexattr,
>+#endif
> };
> 
> static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes)
>@@ -1939,6 +1965,12 @@
> static struct inode_operations shmem_inode_operations = {
> 	.truncate	= shmem_truncate,
> 	.setattr	= shmem_notify_change,
>+#ifdef CONFIG_TMPFS
>+	.setxattr   = shmfs_setxattr,
>+	.getxattr   = shmfs_getxattr,
>+	.listxattr  = shmfs_listxattr,
>+	.removexattr    = shmfs_removexattr,
>+#endif
> };
> 
> static struct inode_operations shmem_dir_inode_operations = {
>@@ -1952,6 +1984,10 @@
> 	.rmdir		= shmem_rmdir,
> 	.mknod		= shmem_mknod,
> 	.rename		= shmem_rename,
>+	.setxattr   = shmfs_setxattr,
>+	.getxattr   = shmfs_getxattr,
>+	.listxattr  = shmfs_listxattr,
>+	.removexattr    = shmfs_removexattr,
> #endif
> };
> 
>@@ -1993,6 +2029,9 @@
> static int __init init_tmpfs(void)
> {
> 	int error;
>+	int err = init_shmfs_xattr();
>+	if (err)
>+		return err;
> 
> 	error = init_inodecache();
> 	if (error)
>Index: security/selinux/hooks.c
>===================================================================
>RCS file: /cvsroot/selinux/nsa/linux-2.6/security/selinux/hooks.c,v
>retrieving revision 1.15
>diff -u -u -r1.15 hooks.c
>--- security/selinux/hooks.c	27 Jul 2004 17:43:11 -0000	1.15
>+++ security/selinux/hooks.c	22 Aug 2004 14:06:13 -0000
>@@ -385,6 +385,14 @@
> 				break;
> 
> 			case Opt_fscontext:
>+				/* lkcl: allow fscontext on file systems with xattr
>+				 *       in order to be able to mount an xattr-enabled tmpfs
>+				 *       on /dev with a different fscontext.
>+				 *       reason: shmfs and tmpfs are mapped to two types
>+				 *       but we need a third (e.g. udevfs_t) in order to
>+				 *       not interfere with / have-to-add-to either tmp_t
>+				 *       or shmfs_t
>+				 *
> 				if (sbsec->behavior != SECURITY_FS_USE_XATTR) {
> 					rc = -EINVAL;
> 					printk(KERN_WARNING "SELinux:  "
>@@ -392,6 +400,7 @@
> 					       " this filesystem type\n");
> 					goto out_free;
> 				}
>+				*/
> 				if (seen & (Opt_context|Opt_fscontext)) {
> 					rc = -EINVAL;
> 					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
>  
>
>------------------------------------------------------------------------
>
>Index: security/selinux/hooks.c
>===================================================================
>RCS file: /cvsroot/selinux/nsa/linux-2.6/security/selinux/hooks.c,v
>retrieving revision 1.15
>diff -u -u -r1.15 hooks.c
>--- security/selinux/hooks.c	27 Jul 2004 17:43:11 -0000	1.15
>+++ security/selinux/hooks.c	22 Aug 2004 14:01:46 -0000
>@@ -385,6 +385,14 @@
> 				break;
> 
> 			case Opt_fscontext:
>+				/* lkcl: allow fscontext on file systems with xattr
>+				 *       in order to be able to mount an xattr-enabled tmpfs
>+				 *       on /dev with a different fscontext.
>+				 *       reason: shmfs and tmpfs are mapped to two types
>+				 *       but we need a third (e.g. udevfs_t) in order to
>+				 *       not interfere with / have-to-add-to either tmp_t
>+				 *       or shmfs_t
>+				 *
> 				if (sbsec->behavior != SECURITY_FS_USE_XATTR) {
> 					rc = -EINVAL;
> 					printk(KERN_WARNING "SELinux:  "
>@@ -392,6 +400,7 @@
> 					       " this filesystem type\n");
> 					goto out_free;
> 				}
>+				*/
> 				if (seen & (Opt_context|Opt_fscontext)) {
> 					rc = -EINVAL;
> 					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
>  
>
>------------------------------------------------------------------------
>
>/*
>  File: fs/ramfs/xattr.c
> 
>  Derived from fs/ext3/xattr.c, changed in the following ways:
>      drop everything related to persistent storage of EAs
>      pass dentry rather than inode to internal methods
>      only presently define a handler for security modules
>*/
>
>#include <linux/init.h>
>#include <linux/fs.h>
>#include <linux/slab.h>
>#include <linux/string.h>
>#include <asm/semaphore.h>
>#include "xattr.h"
>
>static struct ramfs_xattr_handler *ramfs_xattr_handlers[RAMFS_XATTR_INDEX_MAX];
>static rwlock_t ramfs_handler_lock = RW_LOCK_UNLOCKED;
>
>int
>ramfs_xattr_register(int name_index, struct ramfs_xattr_handler *handler)
>{
>	int error = -EINVAL;
>
>	if (name_index > 0 && name_index <= RAMFS_XATTR_INDEX_MAX) {
>		write_lock(&ramfs_handler_lock);
>		if (!ramfs_xattr_handlers[name_index-1]) {
>			ramfs_xattr_handlers[name_index-1] = handler;
>			error = 0;
>		}
>		write_unlock(&ramfs_handler_lock);
>	}
>	return error;
>}
>
>void
>ramfs_xattr_unregister(int name_index, struct ramfs_xattr_handler *handler)
>{
>	if (name_index > 0 || name_index <= RAMFS_XATTR_INDEX_MAX) {
>		write_lock(&ramfs_handler_lock);
>		ramfs_xattr_handlers[name_index-1] = NULL;
>		write_unlock(&ramfs_handler_lock);
>	}
>}
>
>static inline const char *
>strcmp_prefix(const char *a, const char *a_prefix)
>{
>	while (*a_prefix && *a == *a_prefix) {
>		a++;
>		a_prefix++;
>	}
>	return *a_prefix ? NULL : a;
>}
>
>/*
> * Decode the extended attribute name, and translate it into
> * the name_index and name suffix.
> */
>static inline struct ramfs_xattr_handler *
>ramfs_xattr_resolve_name(const char **name)
>{
>	struct ramfs_xattr_handler *handler = NULL;
>	int i;
>
>	if (!*name)
>		return NULL;
>	read_lock(&ramfs_handler_lock);
>	for (i=0; i<RAMFS_XATTR_INDEX_MAX; i++) {
>		if (ramfs_xattr_handlers[i]) {
>			const char *n = strcmp_prefix(*name,
>				ramfs_xattr_handlers[i]->prefix);
>			if (n) {
>				handler = ramfs_xattr_handlers[i];
>				*name = n;
>				break;
>			}
>		}
>	}
>	read_unlock(&ramfs_handler_lock);
>	return handler;
>}
>
>static inline struct ramfs_xattr_handler *
>ramfs_xattr_handler(int name_index)
>{
>	struct ramfs_xattr_handler *handler = NULL;
>	if (name_index > 0 && name_index <= RAMFS_XATTR_INDEX_MAX) {
>		read_lock(&ramfs_handler_lock);
>		handler = ramfs_xattr_handlers[name_index-1];
>		read_unlock(&ramfs_handler_lock);
>	}
>	return handler;
>}
>
>/*
> * Inode operation getxattr()
> *
> * dentry->d_inode->i_sem down
> */
>ssize_t
>ramfs_getxattr(struct dentry *dentry, const char *name,
>	      void *buffer, size_t size)
>{
>	struct ramfs_xattr_handler *handler;
>
>	handler = ramfs_xattr_resolve_name(&name);
>	if (!handler)
>		return -EOPNOTSUPP;
>	return handler->get(dentry, name, buffer, size);
>}
>
>/*
> * Inode operation listxattr()
> *
> * dentry->d_inode->i_sem down
> */
>ssize_t
>ramfs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>{
>	struct ramfs_xattr_handler *handler = NULL;
>	int i, error = 0;
>	unsigned int size = 0;
>	char *buf;
>
>	read_lock(&ramfs_handler_lock);
>
>	for (i=0; i<RAMFS_XATTR_INDEX_MAX; i++) {
>		handler = ramfs_xattr_handlers[i];
>		if (handler)
>			size += handler->list(dentry, NULL);
>	}
>
>	if (!buffer) {
>		error = size;
>		goto out;
>	} else {
>		error = -ERANGE;
>		if (size > buffer_size)
>			goto out;
>	}
>
>	buf = buffer;
>	for (i=0; i<RAMFS_XATTR_INDEX_MAX; i++) {
>		handler = ramfs_xattr_handlers[i];
>		if (handler)
>			buf += handler->list(dentry, buf);
>	}
>	error = size;
>
>out:
>	read_unlock(&ramfs_handler_lock);
>	return size;
>}
>
>/*
> * Inode operation setxattr()
> *
> * dentry->d_inode->i_sem down
> */
>int
>ramfs_setxattr(struct dentry *dentry, const char *name,
>	      const void *value, size_t size, int flags)
>{
>	struct ramfs_xattr_handler *handler;
>
>	if (size == 0)
>		value = "";  /* empty EA, do not remove */
>	handler = ramfs_xattr_resolve_name(&name);
>	if (!handler)
>		return -EOPNOTSUPP;
>	return handler->set(dentry, name, value, size, flags);
>}
>
>/*
> * Inode operation removexattr()
> *
> * dentry->d_inode->i_sem down
> */
>int
>ramfs_removexattr(struct dentry *dentry, const char *name)
>{
>	struct ramfs_xattr_handler *handler;
>
>	handler = ramfs_xattr_resolve_name(&name);
>	if (!handler)
>		return -EOPNOTSUPP;
>	return handler->set(dentry, name, NULL, 0, XATTR_REPLACE);
>}
>
>int __init
>init_ramfs_xattr(void)
>{
>#ifdef CONFIG_RAMFS_FS_SECURITY	
>	int	err;
>
>	err = ramfs_xattr_register(RAMFS_XATTR_INDEX_SECURITY,
>				    &ramfs_xattr_security_handler);
>	if (err)
>		return err;
>#endif
>
>	return 0;
>}
>
>void
>exit_ramfs_xattr(void)
>{
>#ifdef CONFIG_RAMFS_FS_SECURITY	
>	ramfs_xattr_unregister(RAMFS_XATTR_INDEX_SECURITY,
>				&ramfs_xattr_security_handler);
>#endif
>
>}
>  
>
>------------------------------------------------------------------------
>
>/*
> * File: fs/ramfs/xattr_security.c
> */
>
>#include <linux/module.h>
>#include <linux/string.h>
>#include <linux/fs.h>
>#include <linux/security.h>
>#include "xattr.h"
>
>static size_t
>ramfs_xattr_security_list(struct dentry *dentry, char *buffer)
>{
>	return security_inode_listsecurity(dentry, buffer);
>}
>
>static int
>ramfs_xattr_security_get(struct dentry *dentry, const char *name,
>			  void *buffer, size_t size)
>{
>	if (strcmp(name, "") == 0)
>		return -EINVAL;
>	return security_inode_getsecurity(dentry, name, buffer, size);
>}
>
>static int
>ramfs_xattr_security_set(struct dentry *dentry, const char *name,
>			  const void *value, size_t size, int flags)
>{
>	if (strcmp(name, "") == 0)
>		return -EINVAL;
>	return security_inode_setsecurity(dentry, name, value, size, flags);
>}
>
>struct ramfs_xattr_handler ramfs_xattr_security_handler = {
>	.prefix	= XATTR_SECURITY_PREFIX,
>	.list	= ramfs_xattr_security_list,
>	.get	= ramfs_xattr_security_get,
>	.set	= ramfs_xattr_security_set,
>};
>  
>
>------------------------------------------------------------------------
>
>#!/bin/sh
>#
># lkcl 2004aug08
>#
># restore contexts on anything in /dev which has the default device_t
># file context.
>#
># some things are meant to have device_t: hey, we set them too, makes
># no odds.
># 
># we pass all of the devs to restorecon on one line because restorecon
># caches the lookups of the filecontexts: doing a restorecon one at a
># time takes 1/4 sec per device/dir/symlink...
>
>devs=''
>#for x in `ls -altrZ /dev/ | grep -v initctl | grep device_t | grep -v "_device_t" | cut -c64-`; do
>for x in `ls -altrZ /dev/ | grep device_t | grep -v "_device_t" | cut -c64-`; do
>	echo $x
>	devs="$devs /dev/$x"
>done;
>echo $devs
>/sbin/restorecon $devs
>  
>
>------------------------------------------------------------------------
>
>--- udev-add.c.orig	2004-07-09 18:59:09.000000000 +0100
>+++ udev-add.c	2004-08-03 16:21:59.000000000 +0100
>@@ -50,6 +50,10 @@
> 
> #define LOCAL_USER "$local"
> 
>+#ifdef WITH_SELINUX
>+#include <selinux/selinux.h>
>+#endif
>+
> /* 
>  * Right now the major/minor of a device is stored in a file called
>  * "dev" in sysfs.
>@@ -92,7 +96,31 @@
> 			break;
> 		*pos = 0x00;
> 		if (stat(p, &stats)) {
>+#ifdef WITH_SELINUX
>+			int seretval = 0;
>+			security_context_t scontext;
>+		   if (is_selinux_enabled() > 0)
>+		   {
>+				seretval = matchpathcon(p, S_IFDIR, &scontext);
>+				if (seretval < 0) {
>+					dbg("matchpathcon(%s) failed\n", p);
>+				} else {
>+					seretval=setfscreatecon(scontext);
>+					if (seretval < 0)
>+						dbg("setfiles %s failed with error '%s'",
>+					p, strerror(errno));
>+				}
>+			}
>+#endif
> 			retval = mkdir(p, 0755);
>+#ifdef WITH_SELINUX
>+			if (is_selinux_enabled() > 0)
>+			{
>+			   /* after mkdir, free the context */
>+				freecon(scontext);
>+			}
>+#endif
>+									
> 			if (retval != 0) {
> 				dbg("mkdir(%s) failed with error '%s'",
> 				    p, strerror(errno));
>@@ -109,6 +137,10 @@
> {
> 	struct stat stats;
> 	int retval = 0;
>+	int seretval = 0;
>+#ifdef WITH_SELINUX
>+	security_context_t scontext;
>+#endif
> 
> 	if (stat(file, &stats) != 0)
> 		goto create;
>@@ -117,6 +149,24 @@
> 	if (((stats.st_mode & S_IFMT) == S_IFBLK || (stats.st_mode & S_IFMT) == S_IFCHR) &&
> 	    (stats.st_rdev == makedev(major, minor))) {
> 		dbg("preserve file '%s', cause it has correct dev_t", file);
>+#ifdef WITH_SELINUX
>+		/* lkcl: maybe someone would like to do the same thing with se/linux
>+		 * security contexts (check they are the same) but hey, not me!
>+		 */
>+	   if (is_selinux_enabled() > 0)
>+	   {
>+			retval = matchpathcon(file, mode, &scontext);
>+			if (retval < 0) {
>+				dbg("matchpathcon(%s) failed\n", file);
>+			} else {
>+				retval=setfilecon(scontext, file);
>+				if (retval < 0)
>+					dbg("setfiles %s failed with error '%s'",
>+				file, strerror(errno));
>+				freecon(scontext);
>+			}
>+		}
>+#endif
> 		goto perms;
> 	}
> 
>@@ -126,6 +176,21 @@
> 		dbg("already present file '%s' unlinked", file);
> 
> create:
>+#ifdef WITH_SELINUX
>+   if (is_selinux_enabled() > 0)
>+   {
>+		seretval = matchpathcon(file, mode, &scontext);
>+		if (seretval < 0) {
>+			dbg("matchpathcon(%s) failed\n", file);
>+		} else {
>+			retval=setfscreatecon(scontext);
>+			if (retval < 0)
>+				dbg("setfiles %s failed with error '%s'",
>+			file, strerror(errno));
>+		}
>+	}
>+#endif
>+						    
> 	retval = mknod(file, mode, makedev(major, minor));
> 	if (retval != 0) {
> 		dbg("mknod(%s, %#o, %u, %u) failed with error '%s'",
>@@ -133,6 +198,15 @@
> 		goto exit;
> 	}
> 
>+#ifdef WITH_SELINUX
>+   if (is_selinux_enabled() > 0)
>+   {
>+	   /* after mknod, free the context */
>+		if (seretval == 0)
>+			freecon(scontext);
>+	}
>+#endif
>+						    
> perms:
> 	dbg("chmod(%s, %#o)", file, mode);
> 	if (chmod(file, mode) != 0) {
>@@ -150,7 +224,11 @@
> 	}
> 
> exit:
>+#ifdef WITH_SELINUX
>+	return retval < 0 ? retval : seretval;
>+#else
> 	return retval;
>+#endif
> }
> 
> /* get the local logged in user */
>@@ -304,10 +382,36 @@
> 
> 		dbg("symlink(%s, %s)", linktarget, filename);
> 		if (!fake) {
>+#ifdef WITH_SELINUX
>+			int seretval = 0;
>+			security_context_t scontext;
>+		   if (is_selinux_enabled() > 0)
>+		   {
>+				seretval = matchpathcon(filename, S_IFLNK, &scontext);
>+				if (seretval < 0) {
>+					dbg("matchpathcon(%s) failed\n", filename);
>+				} else {
>+					seretval=setfscreatecon(scontext);
>+					if (seretval < 0)
>+						dbg("setfiles %s failed with error '%s'",
>+					filename, strerror(errno));
>+				}
>+			}
>+#endif
>+									
>+
> 			unlink(filename);
> 			if (symlink(linktarget, filename) != 0)
> 				dbg("symlink(%s, %s) failed with error '%s'",
> 				    linktarget, filename, strerror(errno));
>+#ifdef WITH_SELINUX
>+		   if (is_selinux_enabled() > 0)
>+		   {
>+			   /* after symlink, free the context */
>+				freecon(scontext);
>+			}
>+#endif
>+									
> 		}
> 	}
> 
>@@ -403,6 +507,11 @@
> 	char *pos;
> 	int retval;
> 
>+#ifdef WITH_SELINUX
>+	int seretval;
>+	security_context_t prev_scontext;
>+#endif
>+
> 	memset(&dev, 0x00, sizeof(dev));
> 
> 	dev.type = get_device_type(path, subsystem);
>@@ -438,6 +547,23 @@
> 
> 	dbg("name='%s'", dev.name);
> 
>+#ifdef WITH_SELINUX
>+	/* record the present security context, for file-creation
>+	 * restoration creation purposes.
>+	 *
>+	 * we're going to assume that between now and the time that
>+	 * this context is restored that the only filecreation of any
>+	 * kind to occur will be mknod, symlink and mkdirs.
>+	 */
>+
>+	if (is_selinux_enabled() > 0)
>+	{
>+		seretval = getfscreatecon(&prev_scontext);
>+		if (seretval < 0) {
>+			dbg("getfscreatecon failed\n");
>+		}
>+	}
>+#endif
> 	switch (dev.type) {
> 	case 'b':
> 	case 'c':
>@@ -474,6 +600,16 @@
> 		break;
> 	}
> 
>+#ifdef WITH_SELINUX
>+	if (is_selinux_enabled() > 0)
>+	{
>+	   /* reset the file create context to its former glory */
>+		if (seretval == 0)
>+			seretval=setfscreatecon(prev_scontext);
>+		freecon(prev_scontext);
>+	}
>+#endif
>+
> exit:
> 	sysfs_close_class_device(class_dev);
> 
>--- Makefile.orig	2004-08-02 22:23:58.000000000 +0100
>+++ Makefile	2004-08-02 22:24:01.000000000 +0100
>@@ -25,6 +25,8 @@
> # Leave this set to `false' for production use.
> DEBUG = true
> 
>+# Set this to compile with Security-Enhanced Linux support.
>+WITH_SELINUX = true
> 
> ROOT =		udev
> DAEMON =	udevd
>@@ -39,6 +41,7 @@
> LOCAL_CFG_DIR =	etc/udev
> HOTPLUG_EXEC =	$(ROOT)
> 
>+
> DESTDIR =
> 
> KERNEL_DIR = /lib/modules/${shell uname -r}/build
>@@ -172,6 +175,13 @@
> 
> CFLAGS += -I$(PWD)/libsysfs
> 
>+ifeq ($(strip $(WITH_SELINUX)),true)
>+	LIB_OBJS +=	\
>+			-lselinux
>+	CFLAGS += \
>+		-DWITH_SELINUX
>+endif
>+
> all: $(ROOT) $(SENDER) $(DAEMON) $(INFO) $(TESTER) $(STARTER)
> 	@extras="$(EXTRAS)" ; for target in $$extras ; do \
> 		echo $$target ; \
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
