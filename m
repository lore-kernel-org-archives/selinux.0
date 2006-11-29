Subject: Re: CentOS and SELinux refpolicy trouble
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Filip Bartmann <filbar@centrum.cz>
Cc: SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1164825158.4109.31.camel@localhost>
References: <1164819458.4109.14.camel@localhost>
	 <1164820193.23019.181.camel@moss-spartans.epoch.ncsc.mil>
	 <1164825158.4109.31.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Nov 2006 13:41:04 -0500
Message-Id: <1164825664.23019.207.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-29 at 19:32 +0100, Filip Bartmann wrote:
> Stephen Smalley píše v St 29. 11. 2006 v 12:09 -0500:
> > Please identify the precise version numbers of any SELinux-related
> > components that you updated (refpolicy, checkpolicy, anything else like
> > policycoreutils).
> I have installed 
> 
> refpolicy-20061018, 
> checkpolicy.i386-			 1.32-1(from tresys), 
> policycoreutils.i386			 1.18.1-4.9, 
> libselinux				 1.19.1-7.2, 
> libsepol.i386                            1.1.1-2
> setools.i386                             1.5.1-5

Looks fine.

> > Aside from setting the TYPE and NAME in build.conf, you also need to set
> > (or override on the make commandline) several other definitions for a
> > CentOS 4 system, e.g.:
> > OUTPUT_POLICY = 18
> > DISTRO = rhel4
> > DIRECT_INITRC=y
> Yes, I have this setting in this file:
> OUTPUT_POLICY = 18
> TYPE = targeted
> NAME = reftargeted
> DISTRO = rhel4
> DIRECT_INITRC=y
> MONOLITHIC=y
> POLY=n
> MLS_SENS=16
> MLS_CATS=256
> MCS_CATS=256
> QUIET=n

Looks fine.
(aside:  looks like one also has to run make install with
SETFILES=/usr/sbin/setfiles on RHEL 4 and derivatives)

> > Not sure about the booleans errors - what did that booleans file
> > contain?
> The booleans file contain default this values(it's almost defaults from
> tresys refpolicy):

Hmm...looks like it is generating boolean entries for booleans that are
only defined in strict policy even though you are building targeted.  I
also reproduced this issue on a RHEL 4 system, so it isn't just you.
However, these should yield non-fatal warnings, not a fatal error. 

Reproducing on a RHEL 4 system, I see the following output:
unknown boolean allow_gpg_execstack
unknown boolean allow_mplayer_execstack
unknown boolean allow_ptrace
unknown boolean allow_ssh_keysign
unknown boolean allow_user_mysql_connect
unknown boolean allow_write_xshm
unknown boolean cdrecord_read_content
unknown boolean cron_can_relabel
unknown boolean disable_evolution_trans
unknown boolean disable_games_trans
unknown boolean disable_mozilla_trans
unknown boolean disable_thunderbird_trans
unknown boolean mail_read_content
unknown boolean mozilla_read_content
unknown boolean pppd_for_user
unknown boolean read_untrusted_content
unknown boolean run_ssh_inetd
unknown boolean secure_mode
unknown boolean spamassassin_can_network
unknown boolean ssh_sysadm_login
unknown boolean staff_read_sysadm_file
unknown boolean user_direct_mouse
unknown boolean user_dmesg
unknown boolean user_net_control
unknown boolean user_ping
unknown boolean user_rw_noexattrfile
unknown boolean user_tcp_server
unknown boolean user_ttyfile_stat
unknown boolean write_untrusted_content
unknown boolean xdm_sysadm_login
Warning!  Error while reading /etc/selinux/refpolicy/booleans:  Invalid argument

However, it does not kill init or panic the kernel - it just proceeds
onward after these warnings.  Note:  I initially booted it permissive
after touching /.autorelabel to force a filesystem relabel, then
rebooted again in enforcing mode once the filesystem was correctly
labeled.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
