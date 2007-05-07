Subject: [PATCH] introduce version field to struct nfs_clone_mount
From: Eric Paris <eparis@redhat.com>
To: nfs@lists.sourceforge.net, selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 07 May 2007 13:55:13 -0400
Message-Id: <1178560513.3898.32.camel@dhcp59-235.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When selinux attempts to do its part of mounting a new FS it checks the
mount data for selinux context information.  For most FS's this is a
text string but for NFS this is a data blob (struct nfs_mount_data)
Version 6 and later of this struct have a context field which selinux
can use to pass context information from userspace to where it is used
by selinux (security/selinux/hooks.c:try_context_mount())

The problem here is that we have found that exports with the 'nohide'
option actually get mounted from fs/nfs/namespace.c:nfs_do_submount()
which uses a struct nfs_clone_mount for its data.  This gets passed down
into the selinux code 

nfs_do_submount()
 nfs_do_clone_mount()
  vfs_kern_mount()
   security_sb_kern_mount()
    selinux_sb_kern_mount()
     superblock_doinit()
      try_context_mount()

which finds that the fs being mounted is nfs based on:

strcmp(sb->s_type->name, "nfs")

The code in try_context_mount then casts the data to a struct
nfs_mount_data.  Notice I just said the code cast a nfs_clone_mount to a
nfs_mount_data.  Next it checks the version to make sure it should have
the context field.  If so it uses the value in the context field if not
it goes on.  The problem comes that the first entry in the
nfs_mount_data is the version but the first entry in the nfs_clone_mount
is a pointer.  Since the pointer is always bigger than the version we
need we then try to dereference ->context which is outside of the data
blob.  Since nfs_clone_data is smaller in size than nfs_mount_data we
are just getting some stuff off of the stack.  If that data happens to
be 0 (has been that way on all of my x86ish systems) everything works
just fine.  If that data is not 0 the selinux code gets angry and
refuses to mount the FS (which happens for me on other arches).

I could only think of 2 ways to solve this issue given the information
which gets passed into the LSM hook from vfs_kern_mount.  One way would
be to change the 'name' on the superblock when it comes from one of
these non-standard code paths.  The other way was to simply add a new
version field to the nfs_clone_mount structure that would line up with
the version in nfs_mount_data.  That way the selinux code could do the
cast between the two data types and still be able to tell when it had
something it could use and when it couldn't.

I tested this patch on a number of arches and everything seems to be
working happily.  Although I admit that the only code path I know how to
exercise is through nfs_do_submount and I don't have any idea how to
exercise the nfs_follow_referal code path or even exactly what
implications referals have on this issue today.

-Eric

--- linux-2.6.21.x86_64/fs/nfs/internal.h.pre.version	2007-05-03 17:13:33.000000000 -0400
+++ linux-2.6.21.x86_64/fs/nfs/internal.h	2007-05-03 17:15:36.000000000 -0400
@@ -17,6 +17,12 @@ struct nfs4_mount_data;
 #define NFS_MAX_READAHEAD	(RPC_DEF_SLOT_TABLE - 1)
 
 struct nfs_clone_mount {
+	/* 
+	 * This flag lines up bit wise with the version in nfs_mount_data and 
+	 * will always be set to -1 to indicate this is an nfs_clone_mount 
+	 * struct
+	 */
+	int version;
 	const struct super_block *sb;
 	const struct dentry *dentry;
 	struct nfs_fh *fh;
--- linux-2.6.21.x86_64/fs/nfs/namespace.c.pre.version	2007-05-03 17:16:01.000000000 -0400
+++ linux-2.6.21.x86_64/fs/nfs/namespace.c	2007-05-03 17:16:13.000000000 -0400
@@ -218,6 +218,7 @@ static struct vfsmount *nfs_do_submount(
 					struct nfs_fattr *fattr)
 {
 	struct nfs_clone_mount mountdata = {
+		.version = -1,
 		.sb = mnt_parent->mnt_sb,
 		.dentry = dentry,
 		.fh = fh,
--- linux-2.6.21.x86_64/fs/nfs/nfs4namespace.c.pre.version	2007-05-03 17:16:25.000000000 -0400
+++ linux-2.6.21.x86_64/fs/nfs/nfs4namespace.c	2007-05-03 17:16:35.000000000 -0400
@@ -126,6 +126,7 @@ static struct vfsmount *nfs_follow_refer
 {
 	struct vfsmount *mnt = ERR_PTR(-ENOENT);
 	struct nfs_clone_mount mountdata = {
+		.version = -1,
 		.sb = mnt_parent->mnt_sb,
 		.dentry = dentry,
 		.authflavor = NFS_SB(mnt_parent->mnt_sb)->client->cl_auth->au_flavor,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
