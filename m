Subject: Re: [PATCH] SELinux: requesting no permissions in
	avc_has_perm_noaudit is a BUG()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1205335901.5297.182.camel@localhost.localdomain>
References: <1205259574.5297.107.camel@localhost.localdomain>
	 <Xine.LNX.4.64.0803120916170.21778@us.intercode.com.au>
	 <Xine.LNX.4.64.0803120924590.26039@us.intercode.com.au>
	 <1205335901.5297.182.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 13:18:15 -0400
Message-Id: <1205342295.23866.325.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-03-12 at 11:31 -0400, Eric Paris wrote:
> On Wed, 2008-03-12 at 09:26 +1100, James Morris wrote:
> > On Wed, 12 Mar 2008, James Morris wrote:
> > 
> > > Applied to 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm
> > 
> > Just saw this during boot.
> > 
> > [    8.238863] ------------[ cut here ]------------
> > [    8.239762] kernel BUG at security/selinux/avc.c:874!
> 
> > [    8.239762]  [<ffffffff802a7e65>] ? link_path_walk+0xbd/0xcd
> > [    8.239762]  [<ffffffff8031ab34>] avc_has_perm+0x2e/0x5e
> > [    8.239762]  [<ffffffff8031b9ca>] inode_has_perm+0x6b/0x7a
> > [    8.239762]  [<ffffffff8031f242>] selinux_dentry_open+0x6a/0x73
> > [    8.239762]  [<ffffffff8031742e>] security_dentry_open+0x11/0x13
> > [    8.239762]  [<ffffffff8029c69a>] __dentry_open+0xce/0x1d3
> > [    8.239762]  [<ffffffff8029c838>] nameidata_to_filp+0x2e/0x40
> > [    8.239762]  [<ffffffff8029c880>] do_filp_open+0x36/0x46
> > [    8.239762]  [<ffffffff804a9da3>] ? _spin_unlock+0x26/0x2a
> > [    8.239762]  [<ffffffff8029c5b1>] ? get_unused_fd_flags+0x113/0x121
> > [    8.239762]  [<ffffffff8029c8e1>] do_sys_open+0x51/0xd2
> > [    8.239762]  [<ffffffff8029c98b>] sys_open+0x1b/0x1d
> > [    8.239762]  [<ffffffff8020bf7b>] system_call_after_swapgs+0x7b/0x80
> 
> Admittedly I don't understand all the code, but James, can you let me
> know if this solves the problem?  I don't see this issue on my machine
> and I don't know what opening a file with 'special' means.
> 
> /*
>  * Note that while the flag value (low two bits) for sys_open means:
>  *      00 - read-only
>  *      01 - write-only
>  *      10 - read-write
>  *      11 - special
>  * it is changed into
>  *      00 - no permissions needed
>  *      01 - read-permission
>  *      10 - write-permission
>  *      11 - read-write
>  * for the internal routines (ie open_namei()/follow_link() etc). 00 is
>  * used by symlinks.
>  */
> 
> I noticed that the conversion of flags to f_mode in __dentry_open()
> handles things a bit differently than do_filp_open().  This makes the
> __dentry_open() handling like do_filp_open() so that 'special' gets
> turned into RW instead of no permissions.
> 
> Time to go figure out what the heck 'special' means....
> 
> -Eric
> 
> ---
> 
> diff --git a/fs/open.c b/fs/open.c
> index 5419853..04a8efa 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -736,10 +736,15 @@ static struct file *__dentry_open(struct dentry *dentry, struct vfsmount *mnt,
>  {
>  	struct inode *inode;
>  	int error;
> +	mode_t f_mode;
> +
> +	if ((flags+1) & O_ACCMODE)
> +		f_mode = (flags+1) & O_ACCMODE;
> +	else
> +		f_mode = flags & O_ACCMODE;
>  
>  	f->f_flags = flags;
> -	f->f_mode = ((flags+1) & O_ACCMODE) | FMODE_LSEEK |
> -				FMODE_PREAD | FMODE_PWRITE;
> +	f->f_mode = f_mode | FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
>  	inode = dentry->d_inode;
>  	if (f->f_mode & FMODE_WRITE) {
>  		error = get_write_access(inode);

Alternatively, if this is a valid state and is used internally by the
kernel, then possibly selinux_dentry_open() should just return 0
immediately if ((file->f_mode & (FMODE_READ | FMODE_WRITE) == 0), much
as selinux_inode_permission() returns 0 if the mask is 0 (existence
test).  Not sure though why we haven't encountered this before since we
should have been getting denials even before Eric's patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
