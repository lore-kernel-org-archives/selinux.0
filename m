Subject: Re: [PATCH] Security/sysfs: v2 - Enable security xattrs to be set
 on sysfs files, directories, and symlinks.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        gregkh@suse.de, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <4A8AB6B0.8010800@schaufler-ca.com>
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <4A84EF1D.8060408@schaufler-ca.com> <m1my62xde6.fsf@fess.ebiederm.org>
	 <4A861291.1030404@schaufler-ca.com> <m1tz09j00q.fsf@fess.ebiederm.org>
	 <4A864008.50907@schaufler-ca.com> <m1my61sjie.fsf@fess.ebiederm.org>
	 <4A8A2616.8020809@schaufler-ca.com>
	 <1250597660.3629.204.camel@moss-pluto.epoch.ncsc.mil>
	 <4A8AB6B0.8010800@schaufler-ca.com>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 10:23:06 -0400
Message-Id: <1250605386.3629.236.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-08-18 at 07:12 -0700, Casey Schaufler wrote:
> Stephen Smalley wrote:
> > On Mon, 2009-08-17 at 20:55 -0700, Casey Schaufler wrote:
> >   
> >> From: Casey Schaufler <casey@schaufler-ca.com>
> >>
> >> Another approach to limited xattr support in sysfs.
> >>
> >> I tried to listen to the objections to a linked list representation
> >> and I think that I understand that there isn't really any interest
> >> in supporting xattrs for real, only for those maintained by LSMs.
> >> I also looked carefully into the claims that memory usage is
> >> critical and that the code I had before was duplicating effort.
> >>
> >> This version lets the surrounding code do as much of the work as
> >> possible. Unlike the initial proposal for sysfs xattrs, it does not
> >> introduce any new LSM hooks, it uses hooks that already exist. It
> >> does not support any attributes on its own, it only provides for
> >> the attribute advertised by security_inode_listsecurity(). It could
> >> easily be used by other filesystems to provide the same LSM xattr
> >> support. It could also be extended to do the list based support for
> >> arbitrary xattrs without too much effort.
> >>
> >> Probably the oddest bit is that the inode_getsecurity hooks need to
> >> check to see if they are getting called before the inode is instantiated
> >> and return -ENODATA in that event. It would be possible to do a
> >> filesystem specific check instead, but this way provides for generally
> >> correct behavior at small cost.
> >>
> >> This has been tested with Smack, but not SELinux. I think that
> >> SELinux will work correctly, but it could be that a labeling
> >> behavior that is different than the "usual" instantiation labeling
> >> is actually desired. That would be an easy change.
> >>
> >> As always, let me know if I missed something obvious or if there's a
> >> fatal flaw in the scheme.
> >>     
> >
> > The point of the David's patch was to provide a way to save the security
> > xattr in the backing data structure for sysfs entries when an attribute
> > value is set from userspace so that the value can be preserved if the
> > inode is evicted from memory and later re-instantiated.  AFAICS, your
> > patch completely misses the problem.  How about we just go back to
> > David's patch?
> >   
> Oh no, that would use too much memory!
> 
> Either you care about the value the user set, in which case you
> want to save the value the user set, or you don't. If you do, you
> have to save that value, not an LSM's interpretation of that value.
> No secids. No new hooks.

As the security module is the only component of the kernel that
uses/interprets that value, it isn't unreasonable for the security
module's interpretation of that value to be considered canonical.  In
fact, that is already the case - the hooks within vfs_getxattr() enable
the security module to override/replace the actual security xattr value
returned to userspace.

In the case of Smack, Smack could just provide a pointer to its own
internal copy of the string, and that could be stored in the wrapped
iattr.  In the case of SELinux, we could provide a secid that could be
stored in the wrapped iattr.  The hook interface could just handle it as
a blob if you prefer.  But either way we don't need extra storage aside
from a pointer-size field in the wrapped iattr.

> I'll have another go. Thank you for the clarification.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
