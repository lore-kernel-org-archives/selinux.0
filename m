Subject: Re: general selinux questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118433604.10190.353.camel@localhost>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 15:54:43 -0400
Message-Id: <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 21:00 +0100, antoine wrote:
> That makes sense.
> I thought a simple bash redirect would work:
> ping [whatever] >& tempfile
> But it still complained about the fifo... So I worked around it by
> executing ping within the mycron domain and giving that domain the
> privileges needed.

Likely needed to redirect stdin too.

> I use Gentoo, it does the same thing:
> # grep tmpfs_t policy.conf
> type tmpfs_t, file_type, sysadmfile, fs_type;
> allow { tmpfs_t tmp_t } tmpfs_t:filesystem associate;
> (..)

Yes, but does it restorecon /tmp or use a context mount to get it into
tmp_t rather than tmpfs_t?

> I was trying a mixed approach: not using -r and making the root of the
> chroot not root_t but specific to the domain. So I had sprinkled some
> (/chroot/[service]) in the .fc files.

Yes, that should work; named.fc in the Fedora policy is similar:
/var/named/chroot(/.*)?         system_u:object_r:named_conf_t
/var/named/chroot/dev/null   -c system_u:object_r:null_device_t
/var/named/chroot/dev/random -c system_u:object_r:random_device_t
/var/named/chroot/dev/zero -c   system_u:object_r:zero_device_t
/var/named/chroot/etc(/.*)?     system_u:object_r:named_conf_t
/var/named/chroot/etc/rndc.key  -- system_u:object_r:dnssec_t
/var/named/chroot/var/run/named.* system_u:object_r:named_var_run_t
/var/named/chroot/var/tmp(/.*)? system_u:object_r:named_cache_t
/var/named/chroot/var/named(/.*)?       system_u:object_r:named_zone_t
/var/named/chroot/var/named/slaves(/.*)? system_u:object_r:named_cache_t
/var/named/chroot/var/named/data(/.*)? system_u:object_r:named_cache_t
/var/named/chroot/var/named/named\.ca   --      system_u:object_r:named_conf_t

> It's ok now, except I've had to move a directory out of the way: I can't
> delete it, even as root in non-enforcing mode... trace included at the
> bottom of this email. In the process I noticed that the code tries to
> access '/etc/selinux' which does not exist on Gentoo systems: the
> settings are in /etc/security/selinux, and there is no file named config
> in there anyway... 
> To remove these files I guess I'll have to reboot onto another disk (or
> cdrom), fsck, mount it and remove it from there...

Are you sure you are in permissive mode (getenforce)?  If so, then
SELinux shouldn't be in your way at all.  /chroot is a local fs?
Fedora migrated to /etc/selinux and reorganized the layout in FC3, but
libselinux knows to fall back to the old locations
under /etc/security/selinux if it cannot find /etc/selinux, so that
shouldn't be a problem.

> Any snippets of code I could re-use on Gentoo?
> I looked at a FC3 system for direct_sysadm, but couldn't find it.

macros/global_macros.te.  Critical rules are:
domain_auto_trans(sysadm_t, $1_exec_t, $1_t)
role_transition sysadm_r $1_exec_t system_r;
where $1 is each daemon domain.
That's for direct execution of the daemons.
For just running init scripts, you would only need:
domain_auto_trans(sysadm_t, initrc_exec_t, initrc_t)
role_transition sysadm_r initrc_exec_t system_r;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
