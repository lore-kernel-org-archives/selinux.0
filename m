Message-ID: <1398871604.3576.88.camel@metroid.usersys.redhat.com>
Subject: Re: [PATCH] selinux_init_load_policy: setenforce(0) if
 security_disable() fails
From: Will Woods <wwoods@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Date: Wed, 30 Apr 2014 11:26:44 -0400
In-Reply-To: <5360FCB7.9090604@redhat.com>
References: <1398787174-20523-1-git-send-email-wwoods@redhat.com>
 <5360FCB7.9090604@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> On 04/29/2014 11:59 AM, Will Woods wrote:
> > If you run selinux_init_load_policy() after a chroot/switch-root, it's
> > possible that your *previous* root loaded policy, but your *new* root
> > wants SELinux disabled.
> >
> > We can't disable SELinux in this case, but we *do* need to make sure
> > it's permissive. Otherwise we may continue to enforce the old policy.
> >
> > So, if seconfig = -1, but security_disable() fails, we set *enforce=0,
> > and then let the existing code handle the security_{get,set}enforce
> > stuff.
> >
> > Once that's handled, exit with failure via "goto noload", as before.

On Wed, 2014-04-30 at 09:37 -0400, Daniel J Walsh wrote:
> 
> We attempted to make changes for this, and I believe it ended badly.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1046470

I'm a bit confused - the patch I sent here doesn't modify the
"SELINUX=disabled" behavior *unless* security_disable() fails.

Since that code is only reached after successfully mounting selinuxfs,
I'm pretty sure that failure can only mean we've loaded policy, and thus
SELinux can no longer be disabled.

The only behavior *this* patch changes is what happens after that; it
now tries to do security_setenforce(0) before returning.

That bug *is* relevant to the other email I sent, since it concerns the
"SELinux=disabled" check overriding the commandline - and yeah, I'm
happy to leave that check alone if you're worried about that, but I was
curious about its origin.

-w
