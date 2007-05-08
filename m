Subject: Re: [NFS] [PATCH] introduce version field to struct nfs_clone_mount
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Paris <eparis@redhat.com>, nfs@lists.sourceforge.net,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
In-Reply-To: <20070508094120.GA11417@infradead.org>
References: <1178560513.3898.32.camel@dhcp59-235.rdu.redhat.com>
	 <20070508094120.GA11417@infradead.org>
Content-Type: text/plain
Date: Tue, 08 May 2007 08:10:29 -0400
Message-Id: <1178626229.10325.155.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-08 at 10:41 +0100, Christoph Hellwig wrote:
> On Mon, May 07, 2007 at 01:55:13PM -0400, Eric Paris wrote:
> > When selinux attempts to do its part of mounting a new FS it checks the
> > mount data for selinux context information.  For most FS's this is a
> > text string but for NFS this is a data blob (struct nfs_mount_data)
> > Version 6 and later of this struct have a context field which selinux
> > can use to pass context information from userspace to where it is used
> > by selinux (security/selinux/hooks.c:try_context_mount())
> 
> selinux has no business sniffing mount data at all, so the proper fix
> is to remove this code entirely.  If selinux wants to have it's own
> mount options it needs either:
> 
>  - get a mount option at the vfs level.  These are only bit flags, so
>    it's probably not useful for what selinux is currently doing
>  - hook into every filesystem, which is the part of the kernel controlling
>    the text (or in a few cases binary) options.
> 
> > The code in try_context_mount then casts the data to a struct
> > nfs_mount_data.
> 
> Note that this will soon stop to work completely because nfs is moving
> towards proper ascii mount options.

The context= mount support in selinux already deals with ascii mount
options; it is only the binary ones that need special handling.  And
this isn't new functionality in selinux - it went upstream in 2004.
Eric's patch is just fixing this corner case, not introducing new
functionality.

http://marc.info/?l=git-commits-head&m=107695907809907&w=2
http://marc.info/?l=git-commits-head&m=107695907911284&w=2
http://marc.info/?l=git-commits-head&m=107695950928758&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
