Subject: Re: Handling labeling on filesystems that don't support SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Sean E. Millichamp" <sean@bruenor.org>, SE Linux <selinux@tycho.nsa.gov>,
        Fedora Selinux Mailing List <fedora-selinux-list@redhat.com>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
In-Reply-To: <49218381.4050509@redhat.com>
References: <1225998785.3313.5.camel@sewt>  <49218381.4050509@redhat.com>
Content-Type: text/plain
Date: Mon, 17 Nov 2008 10:26:45 -0500
Message-Id: <1226935605.25156.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-11-17 at 09:45 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Sean E. Millichamp wrote:
> > I have been working on SELinux support for Puppet.  One issue that has
> > cropped up is the behavior on filesystems which don't support SELinux.
> > 
> > They all appear to get a default label, some seem to allow changing the
> > label (VFAT) in a non-persistent manner, some seem to throw "not
> > supported" errors (NFS).
> > 
> > How can I detect if a file is on a filesystem which supports SELinux
> > without trying to update the label?
> > 
> > The best idea so far as been to parse /proc/mounts and use that to
> > determine what type of filesystem a file lives on, then check it against
> > a whitelist (which would include ext3, xfs, ?) but it seems like there
> > has to be a cleaner/simpler way.
> > 
> > What I would like would be a "getfilecon" call that returns the real
> > label, ignoring any mount-time defaults.
> > 
> > Any ideas?
> > 
> > Thanks,
> > Sean
> > 
> > 

> I have been waiting for some one else to respond to this.  I think this
> would be better sent to the nsa selinux list for better discussion.
> 
> The problem with your parsing of the /proc/mounts is that it would not
> give you an accurate idea of what supports and what does not support
> SELinux labeling.  Also this can change over time.
> 
> If I mount an ext3 file system with a context mount, then it will no
> longer allow you to set the file context.  I think the best idea is just
> attempt to assign the context and if it fails, ignore the error.  I
> guess you can report it, if in verbose mode as a warning.
> 
> Others may have different ideas.

You'd want to distinguish EOPNOTSUPP from other errors in that case.
But note that this won't catch certain filesystems (like the vfat
example he gave), as changing the in-core context of a file labeled via
genfscon rules is supported presently.  We could possibly change that to
also return EOPNOTSUPP.

The problem with using getfilecon() to probe for support is that SELinux
always assigns some security context to each file for access control
purposes, even if the underlying filesystem doesn't support storage.  If
we had separate getfilecon() vs. getxattr() kernel interface ala
FreeBSD, applications could test for support for storage separately, but
that isn't the case and is unlikely to change.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
