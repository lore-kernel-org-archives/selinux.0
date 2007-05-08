Subject: Re: [NFS] [PATCH] introduce version field to struct nfs_clone_mount
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Paris <eparis@redhat.com>, nfs@lists.sourceforge.net,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
In-Reply-To: <20070508121406.GA16701@infradead.org>
References: <1178560513.3898.32.camel@dhcp59-235.rdu.redhat.com>
	 <20070508094120.GA11417@infradead.org>
	 <1178626229.10325.155.camel@moss-spartans.epoch.ncsc.mil>
	 <20070508121406.GA16701@infradead.org>
Content-Type: text/plain
Date: Tue, 08 May 2007 09:01:06 -0400
Message-Id: <1178629266.6056.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-08 at 13:14 +0100, Christoph Hellwig wrote:
> On Tue, May 08, 2007 at 08:10:29AM -0400, Stephen Smalley wrote:
> > The context= mount support in selinux already deals with ascii mount
> > options; it is only the binary ones that need special handling.  And
> > this isn't new functionality in selinux - it went upstream in 2004.
> > Eric's patch is just fixing this corner case, not introducing new
> > functionality.
> 
> It's still conceptually broken.  Names for ascii mount options are
> the filesystems business, and context= is a perfectly fine name for
> the file systems to use.  This kind of half-assed aspect oriented
> programming using the LSM hooks is a completely nightmare because
> it breaks this concept of a central registry of mount options valid
> for a filesystem.

Is it really better to modify all the filesystems to support a context=
mount option, particularly when they in turn just have to call into the
security module to do anything with that option?  It is somewhat similar
to the vfs fallbacks for *xattr for security attributes, which likewise
isn't entirely nice to look at, but seems better than patching all the
filesystems when the goal is to provide uniform interface across them
all and the security module has to do all of the real work anyway.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
