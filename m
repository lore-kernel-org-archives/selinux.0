Subject: Re: Which packages should I build to boot SELinux system?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: AlannY <m@alanny.ru>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20100129100521.GA18889@alanny-pc.lcl.starlink.ru>
References: <20100129100521.GA18889@alanny-pc.lcl.starlink.ru>
Content-Type: text/plain
Date: Fri, 29 Jan 2010 09:04:34 -0500
Message-Id: <1264773874.16815.47.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-01-29 at 13:05 +0300, AlannY wrote:
> Hi there. I'm still trying to install SELinux and boot in enforcing.
> 
> Another question: which packages must be built with SELinux support to boot
> SELinux system? I'm not talking about SELinux's packages like checkpolicy or
> policycoreutils.
> 
> I know about PAM, UDEV, SYSVINIT, COREUTILS. Maybe more?

The early set of SELinux-modified packages is listed at:
http://userspace.selinuxproject.org/trac/wiki/Userland

However, note that:
1) Not all of those modifications are required for basic operation of
SELinux, and
2) The set of userland packages with SELinux support has grown over time
since that list.

login, openssh, gdm, and cron all need to set the security context for
user sessions or cron jobs.  Some of this is done via direct support and
some via pam_selinux in their /etc/pam.d configurations, and the details
have changed over time (e.g. gdm went from direct support to using
pam_selinux after the rewrite).

dbus, nscd, and xorg can be built with selinux support to enforce
SELinux policy over their operations.  However, that is not required for
basic operation of SELinux.

On Fedora rawhide, I get:
$ repoquery --arch=`arch` --whatrequires --alldeps -s libselinux   | wc -l
123

So 123 packages that link with libselinux in some manner.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
