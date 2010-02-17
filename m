From: Alan Rouse <alan.rouse@ericsson.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Justin P. mattock" <justinmattock@gmail.com>,
        Dominick Grift
	<domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Wed, 17 Feb 2010 15:17:01 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A78029C@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7C47DB.40602@gmail.com>
	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780280@EUSAACMS0703.eamcs.ericsson.se>
 <1266437939.4945.132.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266437939.4945.132.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Ok.  And sestatus -v and pstree -Z output?  Looks like you still have processes 
> running in the wrong context.\
sestatus -v:

SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 24
Policy from config file:        refpolicy-standard

Process contexts:
Current context:                system_u:system_r:sysadm_t
Init context:                   system_u:system_r:init_t
/sbin/mingetty                  system_u:system_r:sysadm_t

File contexts:
Controlling term:               system_u:object_r:tty_device_t
/etc/passwd                     system_u:object_r:etc_t
/etc/shadow                     system_u:object_r:shadow_t
/bin/bash                       system_u:object_r:shell_exec_t
/bin/login                      system_u:object_r:login_exec_t
/bin/sh                         system_u:object_r:bin_t -> system_u:object_r:shell_exec_t
/sbin/agetty                    system_u:object_r:getty_exec_t
/sbin/init                      system_u:object_r:init_exec_t
/sbin/mingetty                  system_u:object_r:getty_exec_t
/usr/sbin/sshd                  system_u:object_r:sshd_exec_t
/lib/libc.so.6                  system_u:object_r:lib_t -> system_u:object_r:lib_t
/lib/ld-linux.so.2              system_u:object_r:lib_t -> system_u:object_r:ld_so_t

pstree -Z:

init(`system_u:system_r:init_t')
 |-acpid(`system_u:system_r:sysadm_t')
 |-auditd(`system_u:system_r:sysadm_t')
 |  |-audispd(`system_u:system_r:sysadm_t')
 |  |  `-{audispd}(`system_u:system_r:sysadm_t')
 |  `-{auditd}(`system_u:system_r:sysadm_t')
 |-cron(`system_u:system_r:sysadm_t')
 |-cupsd(`system_u:system_r:sysadm_t')
 |-dbus-daemon(`system_u:system_r:sysadm_dbusd_t')
 |  `-{dbus-daemon}(`system_u:system_r:sysadm_dbusd_t')
 |-dhcpcd(`system_u:system_r:dhcpc_t')
 |-login(`system_u:system_r:sysadm_t')
 |  `-bash(`system_u:system_r:sysadm_t')
 |     `-pstree(`system_u:system_r:sysadm_t')
 |-master(`system_u:system_r:sysadm_t')
 |  |-pickup(`system_u:system_r:sysadm_t')
 |  `-qmgr(`system_u:system_r:sysadm_t')
 |-mingetty(`system_u:system_r:sysadm_t')
 |-mingetty(`system_u:system_r:sysadm_t')
 |-mingetty(`system_u:system_r:sysadm_t')
 |-mingetty(`system_u:system_r:sysadm_t')
 |-mingetty(`system_u:system_r:sysadm_t')
 |-nscd(`system_u:system_r:sysadm_t')
 |-rpcbind(`system_u:system_r:sysadm_t')
 |-rsyslogd(`system_u:system_r:sysadm_t')
 |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
 |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
 |  `-{rsyslogd}(`system_u:system_r:sysadm_t')
 |-startpar(`system_u:system_r:sysadm_t')
 |-udevd(`system_u:system_r:sysadm_t')
 |  |-udevd(`system_u:system_r:sysadm_t')
 |  `-udevd(`system_u:system_r:sysadm_t')
 `-vmtoolsd(`system_u:system_r:sysadm_t')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
