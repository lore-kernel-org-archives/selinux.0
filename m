Subject: Re: [RFC][PATCH v2] selinux:  support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0805010853300.2731@us.intercode.com.au>
References: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805010853300.2731@us.intercode.com.au>
Content-Type: text/plain
Date: Thu, 01 May 2008 07:04:32 -0400
Message-Id: <1209639872.25678.409.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-05-01 at 09:06 +1000, James Morris wrote:
> On Wed, 30 Apr 2008, Stephen Smalley wrote:
> 
> > As discussed in:
> > http://marc.info/?t=120837952900003&r=1&w=2
> > the ability to permit package managers and similar programs to set down
> > unknown file contexts is still desired/required, not only for putting
> > policy modules in packages but also for enabling build systems to create
> > images of different distro releases with different policies w/o
> > requiring all of the types to be defined in the build host policy.
> > 
> 
> Does this solve all known issues for this case?  e.g. what if a script 
> needs to be run by RPM on a file it just created ?  Does that ever happen?

If required, I believe that can be addressed by allowing rpm_script_t
the ability to execute (along with create, read, and write) an
unlabeled_t file.  And note that this only happens when the file's type
is only defined by the policy module within the package itself (for
policy-modules-in-packages) or when the file's type is not defined by
the build host's policy (for buildsys), whereas the most common
executable types are all defined in the base policy and will typically
be present in the build host policy as well.

It isn't a perfectly general solution, of course.

An alternative approach would be for rpm to load policy at least
defining the types first before setting down the files, which was our
original preference, but that wasn't viewed as workable by the distro
folks.  It might be easier if we had a specific SELinux kernel interface
(i.e. another selinuxfs node) that permitted adding types w/o performing
a complete policy reload.

Also, as with the prior version of this patch, we could split this patch
into two logical changes, the first of which would only introduce the
support for deferred mapping of contexts but not allow userspace to set
invalid contexts, and the second of which would allow userspace to set
invalid contexts.  The first change would fix an existing problem we
have, where removing a policy module that defines a type previously set
in the filesystem (when it was defined by policy) and later re-inserting
it still leaves the inode with an invalidated SID at present (but not
after the patch).  The second change is the controversial part -
allowing userspace to explicitly set down invalid contexts in the first
place.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
