Message-ID: <1492202486.26072.8.camel@tycho.nsa.gov>
Subject: Re: let's revert e3cab998b48ab293a9962faf9779d70ca339c65d
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>,
 Daniel J Walsh <dwalsh@redhat.com>, Dominick Grift <dac.override@gmail.com>
Date: Fri, 14 Apr 2017 16:41:26 -0400
In-Reply-To: <CAJfZ7==rsOexenE+76YX0fbgX9_eXGjygmNzaHL1G8azKk8EMw@mail.gmail.com>
References: <20170414145759.GA7980@markus>
 <1492184005.26072.3.camel@tycho.nsa.gov>
 <fdcf2bd0-6a5a-aead-ef31-59b9b2235afe@redhat.com>
 <1492192590.26072.5.camel@tycho.nsa.gov> <20170414184946.GB16153@markus>
 <CAJfZ7==rsOexenE+76YX0fbgX9_eXGjygmNzaHL1G8azKk8EMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-04-14 at 21:43 +0200, Nicolas Iooss wrote:
> On Fri, Apr 14, 2017 at 8:49 PM, Dominick Grift <dac.override@gmail.c
> om> wrote:
> > On Fri, Apr 14, 2017 at 01:56:30PM -0400, Stephen Smalley wrote:
> > > On Fri, 2017-04-14 at 13:47 -0400, Daniel Walsh wrote:
> > > > On 04/14/2017 11:33 AM, Stephen Smalley wrote:
> > > > > On Fri, 2017-04-14 at 16:57 +0200, Dominick Grift wrote:
> > > > > > Bear with me please, because i might not fully grasp the
> > > > > > issue (i
> > > > > > received help with diagnosing this issue):
> > > > > > 
> > > > > > This commit causes issues (and is, i think, a lousy hack):
> > > > > > e3cab998b48ab293a9962faf9779d70ca339c65d
> > > > > > 
> > > > > > The commit causes entities to "think" that SELinux is
> > > > > > disabled
> > > > > > after
> > > > > > "mount -o remount,ro /sys/fs/selinux
> > > > > > 
> > > > > > It is "neat" to be able to make processes "think" that
> > > > > > selinux is
> > > > > > disabled on a selinux enabled system but not if it break
> > > > > > anything
> > > > > > 
> > > > > > The above results in the following:
> > > > > > 
> > > > > > Systemd services that have ProtectKernelTunables=yes set in
> > > > > > their
> > > > > > respective service units, think that SELinux is disabled.
> > > > > > 
> > > > > > However we have found that some of these services actually
> > > > > > rely
> > > > > > on
> > > > > > SELinux to ensure proper labeling.
> > > > > > 
> > > > > > So we have the option to make people aware that if you set
> > > > > > ProtectKernelTunables=yes that then the process cannot be
> > > > > > SELinux-
> > > > > > aware properly, or we can just get rid of the commit above
> > > > > > and
> > > > > > just
> > > > > > accept that process know that SELinux is enabled.
> > > > > > 
> > > > > > Actual bug that caused me to look into this: systemd-
> > > > > > localed
> > > > > > selinux
> > > > > > awareness is broken due it having ProtectKernelTunables=yes
> > > > > > in
> > > > > > its
> > > > > > service unit
> > > > > 
> > > > > If selinuxfs is mounted read-only, then they can't use most
> > > > > of the
> > > > > selinuxfs interfaces, including even the ability to validate
> > > > > or
> > > > > canonicalize security contexts.  That will break most
> > > > > SELinux-aware
> > > > > services if we tell them that SELinux is enabled.  Are you
> > > > > sure
> > > > > systemd-localed would actually work if you told it SELinux
> > > > > was
> > > > > enabled
> > > > > when selinuxfs was mounted read-only?  What SELinux
> > > > > interfaces is
> > > > > it
> > > > > using?
> > > > > 
> > > > > The other question is whether ProtectKernelTunables ought to
> > > > > be
> > > > > mounting selinuxfs read-only.  SELinux already controls the
> > > > > ability
> > > > > to
> > > > > use its interfaces, including limiting even root, so it is
> > > > > unclear
> > > > > what
> > > > > benefit we derive from having systemd add a further
> > > > > restriction on
> > > > > top.
> > > > > 
> > > > 
> > > > Why is selinuxfs mounted readonly in this case?
> > > 
> > > I don't actually see this in upstream systemd unless I am just
> > > missing
> > > it.
> > > 
> > > systemd/src/core/namespace.c:
> > > /* ProtectKernelTunables= option and the related filesystem APIs
> > > */
> > > static const MountEntry protect_kernel_tunables_table[] = {
> > >         { "/proc/sys",           READONLY,     false },
> > >         { "/proc/sysrq-trigger", READONLY,     true  },
> > >         { "/proc/latency_stats", READONLY,     true  },
> > >         { "/proc/mtrr",          READONLY,     true  },
> > >         { "/proc/apm",           READONLY,     true  }, /*
> > > Obsolete
> > > API, there's no point in permitting access to this, ever */
> > >         { "/proc/acpi",          READONLY,     true  },
> > >         { "/proc/timer_stats",   READONLY,     true  },
> > >         { "/proc/asound",        READONLY,     true  },
> > >         { "/proc/bus",           READONLY,     true  },
> > >         { "/proc/fs",            READONLY,     true  },
> > >         { "/proc/irq",           READONLY,     true  },
> > >         { "/sys",                READONLY,     false },
> > >         { "/sys/kernel/debug",   READONLY,     true  },
> > >         { "/sys/kernel/tracing", READONLY,     true  },
> > >         { "/sys/fs/cgroup",      READWRITE,    false }, /*
> > > READONLY is
> > > set by ProtectControlGroups= option */
> > > };
> > > 
> > > No mention of selinuxfs at all.  Maybe it is a Fedora patch?
> > > 
> > > > The reason we want this is so that processes inside of
> > > > containers do
> > > > not
> > > > attempt to do SELinux stuff.
> > > > 
> > > > http://danwalsh.livejournal.com/73099.html
> > 
> > Before one dismisses my concern (8 minute proof):
> > 
> > https://www.youtube.com/watch?v=YqiM1MlOG0w
> 
> Hello,
> I see this on Arch Linux as well, where there is no
> distribution-specific patch which is applied to systemd (the only
> patches which are applied are backported commits). A simple way to
> see
> that the selinuxfs is mounted read-only is the following command:
> "localectl && findmnt --task $(pgrep systemd-localed)". It will
> display the mountpoints of systemd-localed.service, which (with
> systemd 232 [1]) contains:
> 
> ├─/sys                           sys                      sysfs
> ro,nosuid,nodev,noexec,relatime,seclabel
> │ ├─/sys/firmware/efi/efivars    efivarfs                 efivarfs
> ro,nosuid,nodev,noexec,relatime
> │ ├─/sys/kernel/security         securityfs               securityfs
> ro,nosuid,nodev,noexec,relatime
> │ ├─/sys/fs/selinux              selinuxfs                selinuxfs
> ro,relatime
> │ ├─/sys/fs/cgroup               tmpfs                    tmpfs
> ro,nosuid,nodev,noexec,seclabel,mode=755
> │ │ ├─/sys/fs/cgroup/systemd     cgroup                   cgroup
> ro,nosuid,nodev,noexec,relatime,xattr,release_agent=/usr/lib/systemd/
> systemd-cgroups-agent,name=
> │ │ ├─/sys/fs/cgroup/net_cls     cgroup                   cgroup
> ro,nosuid,nodev,noexec,relatime,net_cls
> │ │ ├─/sys/fs/cgroup/perf_event  cgroup                   cgroup
> ro,nosuid,nodev,noexec,relatime,perf_event
> │ │ ├─/sys/fs/cgroup/pids        cgroup                   cgroup
> ro,nosuid,nodev,noexec,relatime,pids
> │ │ ├─/sys/fs/cgroup/blkio       cgroup                   cgroup
> ro,nosuid,nodev,noexec,relatime,blkio
> │ │ ├─/sys/fs/cgroup/freezer     cgroup                   cgroup
> ro,nosuid,nodev,noexec,relatime,freezer
> │ │ ├─/sys/fs/cgroup/cpu,cpuacct cgroup                   cgroup
> ro,nosuid,nodev,noexec,relatime,cpu,cpuacct
> │ │ ├─/sys/fs/cgroup/cpuset      cgroup                   cgroup
> ro,nosuid,nodev,noexec,relatime,cpuset
> │ │ ├─/sys/fs/cgroup/devices     cgroup                   cgroup
> ro,nosuid,nodev,noexec,relatime,devices
> │ │ └─/sys/fs/cgroup/memory      cgroup                   cgroup
> ro,nosuid,nodev,noexec,relatime,memory
> │ ├─/sys/fs/pstore               pstore                   pstore
> ro,nosuid,nodev,noexec,relatime,seclabel
> │ ├─/sys/kernel/debug            debugfs                  debugfs
> ro,relatime,seclabel
> │ ├─/sys/kernel/config           configfs                 configfs
> ro,relatime
> │ └─/sys/fs/fuse/connections     fusectl                  fusectl
> ro,relatime
> 
> /sys/fs/selinux is mounted read-only. Moreover when I run "strace -f
> -p 1 -e mount" while starting systemd-localed.service, I get:
> 
> 3401  mount(NULL, "/sys/fs/cgroup/perf_event", NULL,
> MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) = 0
> 3401  mount(NULL, "/sys/fs/cgroup/blkio", NULL,
> MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) = 0
> 3401  mount(NULL, "/sys/fs/cgroup/pids", NULL,
> MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) = 0
> 3401  mount(NULL, "/sys/fs/selinux", NULL,
> MS_RDONLY|MS_REMOUNT|MS_BIND, NULL) = 0
> 3401  mount(NULL, "/sys/fs/cgroup", NULL,
> MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) = 0
> 3401  mount(NULL, "/sys/kernel/debug", NULL,
> MS_RDONLY|MS_REMOUNT|MS_BIND, NULL) = 0
> ...
> 
> So /sys/fs/selinux *is* remounted read-only by systemd. When I remove
> "ProtectKernelTunables=yes" from the unit file, /sys/fs/selinux is
> not
> remounted and is kept RW in the namespace of the service.

Hmmm...so is systemd just recursively bind mounting everything under
/sys as read-only? If so, why does it separately list /sys/kernel/debug
and /sys/kernel/tracing in protect_kernel_tunables_table[]? 

> About containers, in http://danwalsh.livejournal.com/73099.html there
> is: "In containers we don't mount these file systems by default or we
> mount it read/only causing libselinux to report that it is
> disabled.".
> Why does /sys/fs/selinux need to be mounted read-only instead of not
> been mounted at all?

I'll defer that one to Dan.

> About systemd-localed, its use of namespaces makes it "look like" a
> container, but it needs to be SELinux-aware in order to use
> /proc/thread-self/attr/fscreate. The use-case is to atomically create
> files like /etc/vconsole.conf with the right context. In order to do
> so, the service:
> * loads the file context database,
> * requests the expected context of /etc/vconsole.conf
> (selabel_lookup_raw),
> * configures the fscreate context (setfscreatecon_raw)
> * creates a temporary file with this context named for example
> "/etc/.#vconsole.confiYiPml",
> * writes data to it and closes it,
> * and finally renames it to /etc/vconsole.conf (with the rename
> syscall)
> 
> I am not aware of a way of making /etc/vconsole.conf have the right
> file context in the end without making the program use libselinux's
> API (named type_transition does not support patterns suitable for
> temporary files). Did I miss something?

Hmm...this is fragile.  Suppose for instance that systemd were to start
passing SELABEL_OPT_VALIDATE to selabel_open().  That would trigger
failures because it wouldn't be able to write the context to
/sys/fs/selinux/context to validate them.  Or if it were using
matchpathcon(), which writes the context to /sys/fs/selinux/context and
reads back the canonicalized context for use (not sure why we stopped
doing that in selabel_lookup; maybe that's a bug). 

> Anyway, there is a bug in vanilla code (it is not specific to Fedora)
> and it is not clear whether it is a bug in libselinux code or in
> systemd's one. Is it's libselinux, I have prepared a patch for it
> (attached). Otherwise, what does systemd did wrong in its use of the
> SELinux API?

With regard to the patch, Dan or others would have to assess the
compatibility implications, since there are userspace components now
relying on is_selinux_enabled() to return 0 if selinuxfs is read-only.

With regard to use of the SELinux API, we've never guaranteed that a
subset of the API will work if selinuxfs is not available or is read-
only.  Obviously parts of it are usable, but that seems fragile.  I
don't really think systemd ought to be remounting it read-only, but
maybe that's just me.

> Nicolas
> 
> [1] ProtectKernelTunables=yes has actually been introduced in systemd
> 232 with https://github.com/systemd/systemd/commit/0c28d51ac84973904e
> 5f780b024adf8108e69fa1
