Message-ID: <1497016062.26846.5.camel@tycho.nsa.gov>
Subject: Re: boot failure due to ambiguous SELinux config
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: Laurent Bigonville <bigon@debian.org>, selinux <selinux@tycho.nsa.gov>,
 864479-forwarded@bugs.debian.org
Date: Fri, 09 Jun 2017 09:47:42 -0400
In-Reply-To: <CAJ2a_DdLA+VhgO+7aSU_NmvDCiweaU_=As7hzuLorQdhid28cA@mail.gmail.com>
References: <3bc76902-e183-ef43-7528-901e579d1031@debian.org>
 <1497012308.26846.1.camel@tycho.nsa.gov>
 <CAJ2a_DdLA+VhgO+7aSU_NmvDCiweaU_=As7hzuLorQdhid28cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-06-09 at 14:52 +0200, Christian Göttsche wrote:
> 2017-06-09 14:45 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> > Kernel version and config, particularly the CONFIG_SECURITY_SELINUX
> > ones?  And are you using any other SELinux-related kernel command
> > line
> > options (e.g. enforcing=, selinux=)?
> 
> standard Debian sid kernel: Linux server02 4.9.0-3-amd64 #1 SMP
> Debian
> 4.9.30-1 (2017-06-04) x86_64 GNU/Linux
> 
> $ grep -i selinux /boot/config-4.9.0-3-amd64
> CONFIG_SECURITY_SELINUX=y
> # CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
> # CONFIG_SECURITY_SELINUX_DISABLE is not set
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
> # CONFIG_DEFAULT_SECURITY_SELINUX is not set
> 
> $ cat /proc/cmdline
> BOOT_IMAGE=/boot/vmlinuz-4.9.0-3-amd64
> root=UUID=1e528afb-83e1-489e-b2f7-1ad1d73d145c ro security=selinux
> nomodeset elevator=noop

Thanks, that makes it clear.  On the one hand, this is a case of
misconfiguration, and on the other, it is a bug/regression in
libselinux.

Your kernel configuration says "Enable SELinux, and don't allow
disabling it at boot via selinux=0 nor from userspace via
/sys/fs/selinux/disable (the latter is what is used for
/etc/selinux/config SELINUX=disabled)."  Your userspace configuration
says "Disable SELinux from userspace via /sys/fs/selinux/disable".  You
really shouldn't use that set of configurations together.

That said, libselinux could handle this situation more gracefully (and
in fact, used to do so, so this is also a regression). libselinux
selinux_init_load_policy() tries to honor your /etc/selinux/config
SELINUX=disabled setting and tries to write to /sys/fs/selinux/disable
via security_disable().  This fails since you disabled that in your
kernel configuration.  So selinux_init_load_policy() tries to fall back
to just not loading policy (and setting SELinux to permissive if not
already, in case a policy has already been loaded earlier, e.g. in the
case of a systemd switch-root from a SELinux enabled to a SELinux
disabled environment).

This used to be sufficient, since is_selinux_enabled() used to also
test whether a policy has been loaded and treat that as disabled. 
However, we reduced is_selinux_enabled() to only testing for a
selinuxfs mount in commit 685f4aeeadc0b60f3770404d4f149610d656e3c8 
since the no-policy-loaded test was a relic of the time before there
was runtime disable support and the no-policy-loaded test was creating
deadlock when using nvidia libGL,
https://bugzilla.redhat.com/show_bug.cgi?id=1195074

So selinux_init_load_policy() really ought to unmount selinuxfs after
setting SELinux permissive in this case so that is_selinux_enabled()
will still return disabled.  Then dbus and the rest of userspace will
handle things properly.
