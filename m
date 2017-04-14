Message-ID: <1492192590.26072.5.camel@tycho.nsa.gov>
Subject: Re: let's revert e3cab998b48ab293a9962faf9779d70ca339c65d
From: Stephen Smalley <sds@tycho.nsa.gov>
To: dwalsh@redhat.com, Dominick Grift <dac.override@gmail.com>,
 selinux@tycho.nsa.gov
Date: Fri, 14 Apr 2017 13:56:30 -0400
In-Reply-To: <fdcf2bd0-6a5a-aead-ef31-59b9b2235afe@redhat.com>
References: <20170414145759.GA7980@markus>
 <1492184005.26072.3.camel@tycho.nsa.gov>
 <fdcf2bd0-6a5a-aead-ef31-59b9b2235afe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-04-14 at 13:47 -0400, Daniel Walsh wrote:
> On 04/14/2017 11:33 AM, Stephen Smalley wrote:
> > On Fri, 2017-04-14 at 16:57 +0200, Dominick Grift wrote:
> > > Bear with me please, because i might not fully grasp the issue (i
> > > received help with diagnosing this issue):
> > > 
> > > This commit causes issues (and is, i think, a lousy hack):
> > > e3cab998b48ab293a9962faf9779d70ca339c65d
> > > 
> > > The commit causes entities to "think" that SELinux is disabled
> > > after
> > > "mount -o remount,ro /sys/fs/selinux
> > > 
> > > It is "neat" to be able to make processes "think" that selinux is
> > > disabled on a selinux enabled system but not if it break anything
> > > 
> > > The above results in the following:
> > > 
> > > Systemd services that have ProtectKernelTunables=yes set in their
> > > respective service units, think that SELinux is disabled.
> > > 
> > > However we have found that some of these services actually rely
> > > on
> > > SELinux to ensure proper labeling.
> > > 
> > > So we have the option to make people aware that if you set
> > > ProtectKernelTunables=yes that then the process cannot be
> > > SELinux-
> > > aware properly, or we can just get rid of the commit above and
> > > just
> > > accept that process know that SELinux is enabled.
> > > 
> > > Actual bug that caused me to look into this: systemd-localed
> > > selinux
> > > awareness is broken due it having ProtectKernelTunables=yes in
> > > its
> > > service unit
> > 
> > If selinuxfs is mounted read-only, then they can't use most of the
> > selinuxfs interfaces, including even the ability to validate or
> > canonicalize security contexts.  That will break most SELinux-aware
> > services if we tell them that SELinux is enabled.  Are you sure
> > systemd-localed would actually work if you told it SELinux was
> > enabled
> > when selinuxfs was mounted read-only?  What SELinux interfaces is
> > it
> > using?
> > 
> > The other question is whether ProtectKernelTunables ought to be
> > mounting selinuxfs read-only.  SELinux already controls the ability
> > to
> > use its interfaces, including limiting even root, so it is unclear
> > what
> > benefit we derive from having systemd add a further restriction on
> > top.
> > 
> 
> Why is selinuxfs mounted readonly in this case?

I don't actually see this in upstream systemd unless I am just missing
it.

systemd/src/core/namespace.c:
/* ProtectKernelTunables= option and the related filesystem APIs */
static const MountEntry protect_kernel_tunables_table[] = {
        { "/proc/sys",           READONLY,     false },
        { "/proc/sysrq-trigger", READONLY,     true  },
        { "/proc/latency_stats", READONLY,     true  },
        { "/proc/mtrr",          READONLY,     true  },
        { "/proc/apm",           READONLY,     true  }, /* Obsolete
API, there's no point in permitting access to this, ever */
        { "/proc/acpi",          READONLY,     true  },
        { "/proc/timer_stats",   READONLY,     true  },
        { "/proc/asound",        READONLY,     true  },
        { "/proc/bus",           READONLY,     true  },
        { "/proc/fs",            READONLY,     true  },
        { "/proc/irq",           READONLY,     true  },
        { "/sys",                READONLY,     false },
        { "/sys/kernel/debug",   READONLY,     true  },
        { "/sys/kernel/tracing", READONLY,     true  },
        { "/sys/fs/cgroup",      READWRITE,    false }, /* READONLY is
set by ProtectControlGroups= option */
};

No mention of selinuxfs at all.  Maybe it is a Fedora patch?

> The reason we want this is so that processes inside of containers do
> not
> attempt to do SELinux stuff. 
> 
> http://danwalsh.livejournal.com/73099.html
