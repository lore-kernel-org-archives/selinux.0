Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81FoUWv012928
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 11:50:30 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k81FoArI015423
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 15:50:10 GMT
Subject: Re: Latest updates
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44F7358E.4010101@redhat.com>
References: <44F7358E.4010101@redhat.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 11:51:28 -0400
Message-Id: <1157125888.3199.157.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-31 at 15:16 -0400, Daniel J Walsh wrote:
> Amanda changes, not sure why you didn't take them last time

Sorry about that, forgot to send an email about that last patch.  As for
this bit, I'm hesitant to remove the contexts.  This policy seems to be
overengineered, and since we intend to fix it, the unused types should
be removed too.  Otherwise we start getting dead policy, and more mess
in general.

> Fixing some labels to march what actually ends up on disk  see /boot/grub

These say /boot/grup; I assume this is a typo.  Also they should be in
the files module.

> Change firstboot to create etc_runtime_t instead of firstboot_rw_t.

The type should be removed too, see above comments on
amanda.  /usr/share/firstboot is also labeled firstboot_rw_t, so that
should be resolved too.

> Please change /opt java line to match what IBM ships

I'm concerned this is too broad.  Can we get additional, more specific
regexes?

> In corecommands prelink also creates lnk_file, when it recreates 
> executables.

I assume this refers to the hunk in corecommands.if?  I don't agree with
this change.  Only the executables should be specially labeled, not the
symlinks.

> gfs supports xattr

IIRC, last time the question was if this was widely avaiable?

> Lots of domains need term_dontaudit_use_unallocated_ttys for startup 
> from a tty.

Can you clarify this?  I don't know what you mean by "startup from a
tty".

> Apache uses ldap

This reverts my change; this access is handled by auth_use_nsswitch().

> bluetooth_helper started for startx needs some more privs

This corenet addition seems out of place, since it doesn't have complete
networking perms.  Fixed the xserver_stream_connect_xdm() interface
instead of the xdm addition.

> crontab changes for setting MLS values.

The userdomain sending a sigchld to crontab doesn't make sense to me.
Also $1_tmp_t can't be referenced directly by this template, it needs to
use the userdomain interfaces.  Besides that, I think it would probably
be best for crontab to have its own $1_crontab_tmp_t type anyway, unless
there is a compelling reason for it to write the user's tmp files.

Why does system_crond_t need to create crond pid files?

> dovecot wants to read some files labeled var_t.

Moved rule down.

> ldap uses a socket to communicate

Generic socket doesn't make sense here.

> NetworkManager wants to ptrace itself

I can't reproduce this on my notebook.  Can you look more into this?  It
seems highly irregular.

> stunnel reads route table
> and connects to smtp

Is this an explicit requirement, or should it really be tcp connect to
all ports?

> X No longer needs execstack, execheap, execmem

I am setting this to !distro_redhat, as this is not necessarily the case
for other distros (incl RHEL4).

> Changes to semanage

Can't use these templates here.  The netlink addition is handled by
auth_use_nsswitch().

> /usr/lib/ia32el/ia32x_loader needs to run unconfined_execmem_t if we 
> have any hope of turning off allow_execmem

Out of curiosity, what is this program?

The ntp change shouldn't be needed, since net_bind_service is allowed by
corenet_udp_bind_ntp_port(ntpd_t).

The procmail change shouldn't be needed since udp bind to inaddr_any is
allowed by corenet_udp_bind_all_nodes(procmail_t).

The rpc change shouldn't be needed since all domains have self:file
{ getattr read };

The unconfined change should not be needed since it can do * to all
domains keys (see domain.te).

Holding off on the other new policies since you said they're still WiP.

Why are the following needed?

fsadm exec a shell

initrc write locale_t

lvm_t net_admin (!)

depmod using terms other than the ones it gets from it's run interface

udev transition to dhcpc


The remainder is merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
