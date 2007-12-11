Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM
	settings for task actions [try #2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <25965.1197329769@redhat.com>
References: <1197322068.18120.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil>
	 <20071205193818.24617.79771.stgit@warthog.procyon.org.uk>
	 <20071205193859.24617.36392.stgit@warthog.procyon.org.uk>
	 <25037.1197306473@redhat.com> <25572.1197320887@redhat.com>
	 <25965.1197329769@redhat.com>
Content-Type: text/plain
Date: Tue, 11 Dec 2007 14:37:03 -0500
Message-Id: <1197401823.28006.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-10 at 23:36 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > From a config file whose pathname would be provided by libselinux (ala
> > the way in which dbusd imports contexts), or directly as a context
> > returned by a libselinux function.
> 
> That sounds too SELinux specific.  How do I do it so that it works for any
> LSM?

You can't.  There is no LSM for userspace; LSM specifically disavowed
any common userspace API, and that was one of our original
objections/concerns about it.

> Is linking against libselinux is a viable option if it's not available under
> all LSM models?  Is it available under all LSM models?  Perhaps Casey can
> answer this one.

Nope, they would all have their own libraries, if they have a library at
all.  But that isn't your problem - your kernel interface should be
generic, and your LSM hooks should be generic, but your userspace isn't
required to be.  Have a look at how many programs in the distribution
currently link against libselinux, whether directly or by dlopen'ing it.

> > > I use to do that, but someone objected...  Possibly Karl MacMillan.
> > 
> > Yes, but I think I disagreed then too.
> 
> So, who's right?

Karl isn't a maintainer of the SELinux kernel code.  And I had thought
that even he had reconsidered this idea after further discussion.

> > It doesn't fit with how other users of security_kernel_act_as() will
> > likely want to work (they will want to just set the context to a
> > specified value, whether one obtained from the client or from some local
> > source), nor with how type transitions normally work (exec, with the
> > program type as the second type field).  I think it will just cause
> > confusion and subtle breakage.
> 
> It's causing me lots of confusion as it is.  I have been / am being told by
> different people to do different things just in dealing with SELinux, and
> various people are raising extra requirements or restrictions beyond that.
> There doesn't seem to be a consensus.
> 
> It sounds like the best option is just to have the kernel nick the userspace
> daemon's security context and use that as is, and junk all the restrictions on
> what the daemon can do so that the kernel isn't too restricted.

Well, you could do that, if that meets your needs, but it doesn't sound
very optimal either.  Why are you opposed to having userspace determine
the context and write it to a cachefiles interface, and just have the
kernel authorize it (invoke a hook to check permissions between the
daemon's context and the specified label), and make it the acting
context when appropriate (invoke a different hook to set it as the
acting context)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
