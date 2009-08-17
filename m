Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on
 sysfs files, directories, and symlinks.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        Greg Kroah-Hartman <greg@kroah.com>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
In-Reply-To: <4A860D0F.7020205@schaufler-ca.com>
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <4A84EF1D.8060408@schaufler-ca.com>
	 <1250252411.2422.177.camel@moss-pluto.epoch.ncsc.mil>
	 <4A860D0F.7020205@schaufler-ca.com>
Content-Type: text/plain
Date: Mon, 17 Aug 2009 07:53:13 -0400
Message-Id: <1250509993.3629.93.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-08-14 at 18:19 -0700, Casey Schaufler wrote:
> Stephen Smalley wrote:
> > On Thu, 2009-08-13 at 21:59 -0700, Casey Schaufler wrote:
> >   
> >> From: Casey Schaufler <casey@schaufler-ca.com>
> >>
> >> This patch is in response to David P. Quigley's proposal from
> >> July of this year. That patch provided special case handling of
> >> LSM xattrs in the security name space.
> >>
> >> This patch provides an in memory representation of general
> >> xattrs. It currently only allows xattrs in the security namespace,
> >> but that is only because the support of ACLs is beyond the
> >> day's needs. The list of xattrs for a given file is created on
> >> demand and a system that does not use xattrs should be pretty
> >> well oblivious to the changes. On the down side, this requires
> >> an unpleasant locking scheme. Improvements would of course be
> >> welcome.
> >>
> >> This scheme should generalize to any memory based file system,
> >> although I have not attempted to create a generic implementation
> >> here.
> >>     
> >
> > I don't understand the benefits of this scheme compared to David's patch
> > - can you explain?
> 
> Sure, you bet. David's scheme requires as LSM and is only capable
> of supporting security namespace attributes. It is further not a
> reasonable model for other memory based filesystems. If all you
> ever want to support is SELinux, it would be fine, but an LSM
> that uses multiple xattrs (Smack only uses multiple xattrs on
> sockets, but it does use them) would be hard pressed to work off
> of a secid. This is a swag at real xattr support, which is the
> right thing to do for any filesystem. Special purpose interfaces
> to solve a single instance of a problem are for squares.

I don't see that one particularly wants full xattr support on sysfs
nodes (or other in-memory filesystems).  Why would one support e.g.
user.* attributes on such nodes?  Why would one support filesystem
capabilities on such nodes (careful - last thing we want is a repeat of
suid bit on proc nodes)?  And if you want ACL support, you'll need code
to actually enforce those ACLs within the filesystem, not just generic
xattr handler code - see the tmpfs code in mm/shmem.c for an example of
ACL support for in-memory filesystems.

> >   It seems worse in terms of locking,
> 
> I'll buy that, and happily incorporate improvements. The
> crude locking is an artifact of keeping memory usage down.

But you don't need any extra locking if you just directly use the
existing memory storage provided by the security module.

> >  memory use,
> 
> There are less than 12,000 entries in /sys on my machine.
> Is that really an issue?
> 
> >  and
> > is no more general than David's patch.
> 
> Except that one could (fix the locking and) port this code to
> other memory based file systems, such as smackfs or selinuxfs
> without much bother. You'd have to implement new LSM hooks for
> each file system you ported the other approach for. It
> can be used without an LSM, it could support multiple security
> xattrs and it can support other namespaces.

The hooks proposed by David would work with other in-memory filesystems
that likewise need to save the attribute in a backing data structure -
only the particular backing data structure and placement of the hooks
would be specific to the filesystem, and that is unavoidable.

For in-memory filesystems that pin the inodes, we already have all the
support we require by virtue of the existing vfs fallbacks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
