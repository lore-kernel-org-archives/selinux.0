Subject: Re: Security issues with local filesystem caching
From: Karl MacMillan <kmacmill@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
        chrisw@sous-sol.org, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <4417.1162395294@redhat.com>
References: <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 10:58:25 -0500
Message-Id: <1162396705.29617.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-01 at 15:34 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > >      (c) A security label that defines the context under which the module
> > >          operates when accessing the cache.  This allows the module, when
> > >          accessing the cache, to only operate within the bounds of the
> > >          cache.
> > 
> > Well, only if the module is well-behaved in the first place, since a
> > kernel module can naturally bypass SELinux at will.  What drives this
> > approach vs. exempting the module from SELinux checking via a task flag
> > that it raises and lowers around the access (vs. setting and resetting
> > the sid around the access to the per-cache module context)?
> 
> Christoph objected very strongly to my bypassing of vfs_mkdir() and co, and Al
> wasn't to happy about it either.  This should allow me, for example, to call
> vfs_mkdir() rather than calling the inode op directly as the reason I wasn't
> was that I was having to avoid the security checks it made.
> 
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > >  (*) The module will obtain label (c) by reading label (b) from the
> > >      cachefilesd process when it opens the cachefiles control chardev and
> > >      then passing it through security_change_sid() to ask the security
> > >      policy to for label (c).
> > 
> > Do you mean security_transition_sid()?  security_change_sid() doesn't
> > seem suited to that purpose
> 
> That's what Karl said to use.
> 

I suggested change instead of transition because, like most uses of
change, this was a manual relabel rather than automatic. Transition
probably makes more sense, though.

> > What would you use as the target SID and class?
> 
> I've no idea.  I tried to find out how to use this function from Karl, but he
> said I should ask on the list.
> 

This is all predicated on the notion that there is a need to have the
normal SELinux checks performed. Since this serves only as a sanity
check and doesn't add any real security the best option seems bypass,
but I guess that isn't an option.

Additionally, whether the security context comes from a config file or
the policy there is still a chance that we will end up with a security
context without sufficient access. Debugging this is going to be
mysterious for the policy author as it will require detailed knowledge
of the kernel mechanism.

I guess the target SID could be the kernel initial sid and the class
process - though that is basically arbitrary. This is an abuse of the
interface to avoid a config file. Any other options?

> > >      (3) current->security->sid will be set to label (c) so that
> > >          vfs_mkdir(), vfs_create() and lookup ops will check for the
> > >          correct labels.
> > 
> > I think you would want this to be a new ->fssid field instead, and
> > adjust SELinux to use it if set for permission checking (which could
> > also be leveraged by NFS later).
> 
> I could do that.  Does it actually gain anything?  Or are there good reasons
> for not altering current->security->sid?  For instance, does that affect the
> label seen on /proc/pid/ files?
> 
> > Or just use a task flag to disable checking on the module internal accesses.
> 
> I could do that too.
> 
> > >      Point (3) shouldn't cause a cross-thread race as it would appear that
> > >      the security label can only be changed on single-threaded processes.
> > >      Attempts to do so on multi-threaded processes are rejected.
> > 
> > I don't quite follow this.
> 
> Sorry, I meant that a process can only change its own security label if it's a
> single-threaded process.  A kernel module can, of course, change the security
> label at any time.
> 
> > But mutating ->sid could yield unfortunate behavior if e.g. another process
> > happens to be sending that task a signal at the same time, so if you go this
> > route, you want a ->fssid.
> 
> Okay... that seems like a good reason to do use the ->fssid approach.  How do I
> tell if ->fssid is set?  Is zero usable as 'unset'?  Alternatively, would it be
> reasonable to have ->fssid track ->sid when the latter changes?
> 

fssid seems like the wrong name, though it does match the DAC concept.
This is really more general impersonation of another domain by the
kernel and might have other uses.

Karl

> David


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
