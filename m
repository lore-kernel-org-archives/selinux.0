From: David Howells <dhowells@redhat.com>
In-Reply-To: <1162502667.6071.66.camel@lade.trondhjem.org> 
References: <1162502667.6071.66.camel@lade.trondhjem.org>  <1162496968.6071.38.camel@lade.trondhjem.org> <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> <25037.1162487801@redhat.com> <32754.1162499917@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
        chrisw@sous-sol.org, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
Date: Fri, 03 Nov 2006 10:27:01 +0000
Message-ID: <12984.1162549621@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > Well, both Christoph and Al are of the opinion that I should be using
> > vfs_mkdir() and co rather than bypassing the security and calling inode ops
> > directly.
> 
> ...but why are you needing to call vfs_mkdir? I thought the standard
> cachefs backend just uses a pool of files, rather like the original AFS
> cache did. Are you trying to mirror the layout and the permissions of
> the NFS filesystem? That is a lot more work than it is worth...

No.

I have to have a way of mapping a netfs file onto a cache storage object.  I do
this by translating the keys the netfs gives me into a path of directory and
file names in the cache.

In NFS's case there are three keys describing a file:

 (1) "NFS"

 (2) { Server IP, Server port, NFS version }

 (3) NFS File Handle

These wind up in the filesystem looking something like:

	INDEX     INDEX      INDEX                             DATA FILES
	========= ========== ================================= ================
	cache/@4a/I03nfs/@30/Ji000000000000000--fHg8hi8400
	cache/@4a/I03nfs/@30/Ji000000000000000--fHg8hi8400/@75/Es0g000w...DB1ry
	cache/@4a/I03nfs/@30/Ji000000000000000--fHg8hi8400/@75/Es0g000w...N22ry
	cache/@4a/I03nfs/@30/Ji000000000000000--fHg8hi8400/@75/Es0g000w...FP1ry

See Documentation/filesystems/caching/cachefiles.txt for more information, in
particular the section "Cache Structure".

Anyway, it's not just vfs_mkdir(), there's also vfs_create(), vfs_rename(),
vfs_unlink(), vfs_setxattr(), vfs_getxattr(), and I'm going to need a
vfs_lookup() or something (a pathwalk to next dentry).

Yes, I'd prefer not to have to use these, but that doesn't seem to be an
option.

> > Also I should be setting security labels on the files I create.
> 
> To what end? These files shouldn't need to be made visible to userland
> at all.

But they are visible to userland and they have to be visible to userland.  They
exist in the filesystem in which the cache resides, and they need to be visible
so that cachefilesd can do the culling work.  If you were thinking of using
"deleted" files, remember that I want it to be persistent across reboots, or
even when an NFS inode is flushed from memory to make space and then reloaded
later.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
