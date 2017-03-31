Message-ID: <1490966741.31110.2.camel@tycho.nsa.gov>
Subject: Re: userspace object manager confused
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Fri, 31 Mar 2017 09:25:41 -0400
In-Reply-To: <20170331120905.GA5699@t450.enp8s0.d30>
References: <20170331120905.GA5699@t450.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-03-31 at 14:09 +0200, Dominick Grift wrote:
> I vaguely recall that we discussed this issue or at least that i
> mentioned it here but i can't recall the outcome if any:
> 
> So today on my rawhide system i noticed that i somehow forgot to add
> support for the smc_socket class (i suspect that is part of the
> extended socket class patches)
> 
> I added the class (which i suppose is unordered like the othe
> extended socket classes) but as soon as I loaded up the policy with
> the new unordered smc_socket class the system became unusable.
> 
> This is because the dbus object manager became confused due to my
> adding a new (unordered) class at runtime, and that the dbus class
> was no longer working.
> 
> Modern systems heavily rely on dbus at the heart and so it is
> undesire-able that this happens.
> 
> A reboot clears this issue up but adding (unordered) classes at
> runtime should not cause these issues i suspect

dbusd doesn't use selinux_check_access() and therefore does not yet
support reordering of their classes/permissions at runtime.  The same
is true of all userspace object managers created before
selinux_check_access() was introduced - anything that directly calls
security_compute_av() or avc_has_perm(). dbusd does call
selinux_set_mapping() at startup, so it can correctly handle
reordering of classes/permissions across restarts, but not while it is
running.  Calling selinux_set_mapping() again upon policy reloads (e.g.
from policy_reload_callback() if (event == AVC_CALLBACK_RESET) before
returning) may fix this problem, but requires proper locking.  Even
better would be to rid the dbusd selinux implementation of threading
entirely, see https://bugs.freedesktop.org/show_bug.cgi?id=92831#c4

smc_socket was added by the kernel developers as part of the merge with
net-next since we now trigger a build failure in the kernel if any new
address families are introduced without adding a corresponding security
class (so that SELinux always supports a separate class per network
address family going forward). So there have been no policy patches
submitted yet to define it in refpolicy even AFAIK.

[1] https://github.com/SELinuxProject/selinux/issues/34
