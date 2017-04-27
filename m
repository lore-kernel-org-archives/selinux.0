Message-ID: <1493298251.2524.3.camel@tycho.nsa.gov>
Subject: Re: is_selinux_enabled() always returns 0 after
 selinux_set_policy_root()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Date: Thu, 27 Apr 2017 09:04:11 -0400
In-Reply-To: <1493240908.1837173.957437120.416E6DD8@webmail.messagingengine.com>
References: <1493237420.1820719.957368808.08E54C5A@webmail.messagingengine.com>
 <1493238298.32540.13.camel@tycho.nsa.gov>
 <1493239388.1829342.957407608.3C297B30@webmail.messagingengine.com>
 <1493240908.1837173.957437120.416E6DD8@webmail.messagingengine.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-04-26 at 17:08 -0400, Colin Walters wrote:
> 
> On Wed, Apr 26, 2017, at 04:43 PM, Colin Walters wrote:
> > On Wed, Apr 26, 2017, at 04:24 PM, Stephen Smalley wrote:
> > > 
> > > Your analysis and proposed fix sound correct to me.  I blame Dan
> > > ;)
> > 
> > Thanks.  I tested the patch and confirmed it fixed ostree as it
> > stands today,
> > but I'm going to change ostree to cache the result of
> > `is_selinux_enabled()`
> > itself to work around this, since for our use cases it should never
> > really
> > change dynamically.
> 
> Although as I was working on the workaround, which I just put up as:
> https://github.com/ostreedev/ostree/pull/815
> 
> I was thinking about this a bit more and I realized (maybe) why
> Dan added that call.  
> 
> Right now (ignoring #ifdef ANDROID):
> int is_selinux_enabled()
> {
> return (selinux_mnt && has_selinux_config);
> }
> 
> And conceptually "has_selinux_config" derives from the policy root.
> But in practice it doesn't today - that variable is also only
> initialized
> in the constructor.   Should it?  I'm not sure.
> 
> The way libostree uses the policy root is basically for the regexp
> labeling
> database.   We're using `is_selinux_enabled()` to determine whether
> or not we should call `setfscreatecon()`. 
> 
> Eh.  My inclination is not think too much more about this.  The patch
> is unlikely to break anything, it does fix a bug, and I'm not aware
> of a
> case where someone would be using e.g. a host system with SELinux
> fully disabled to do anything related to ostree, so we don't
> need to care about trying to disentangle those cases.  Hopefully!

1. The has_selinux_config test was added long after the introduction of
 selinux_set_policy_root(), and only to avoid a regression due to
removal of the test to see if policy is loaded.  See commits
c08c4eacab8d55598b9e5caaef8a871a7a476cab and
685f4aeeadc0b60f3770404d4f149610d656e3c8.

2. The test for has_selinux_config wouldn't actually be affected by
selinux_set_policy_root() even if we were to re-evaluate it. 
selinux_set_policy_root() sets the prefix for the policy files (e.g.
from /etc/selinux/targeted to /etc/selinux/mls), it does not affect the
path for /etc/selinux/config.  We don't presently provide any way to
redirect libselinux to a different config file.

3. Originally, is_selinux_enabled() returned 1 if selinuxfs was
registered (in /proc/filesystems), even if not mounted. This was
dropped by commit e3cab998b48ab293a9962faf9779d70ca339c65d, which
changed the test to only return 1 if selinuxfs was mounted and only if
it is mounted rw, so that a ro mount could be used in mock and other
tools to make SELinux appear disabled.  Recent discussions on the list
(subject: "let's revert e3cab998b48ab293a9962faf9779d70ca339c65d") have
 proposed removing the ro check and only considering it disabled if
selinuxfs is not mounted at all because systemd is remounting
everything under /sys as ro for ProtectKernelTunables=yes and this is
leading services to conclude that SELinux is disabled and then failing
to label files correctly.  However, my impression is that systemd will
alter its behavior and I don't think we can in the near term change
libselinux in this regard as it will break various chroot and container
implementations.
