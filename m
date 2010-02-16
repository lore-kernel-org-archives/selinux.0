Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Tue, 16 Feb 2010 14:38:41 -0500
Message-Id: <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-16 at 14:19 -0500, Alan Rouse wrote:
> "sestatus -v" reports the following:
> 
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 24
> Policy from config file:        refpolicy
> 
> Process contexts:
> Current context:                system_u:system_r:sysadm_t
> Init context:                   system_u:system_r:init_t
> /sbin/mingetty                  system_u:system_r:sysadm_t

Ok, so init is in the right security context, but getty is not.
refpolicy has a rule that says if init runs a shell, transition to
sysadm_t - that is for single-user mode.  But that gets disabled if
using upstart since upstart runs everything via a shell.

Try:
setsebool -P init_upstart=1
reboot

pstree -Z output might also be interesting.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
