From: Alan Rouse <alan.rouse@ericsson.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
        "Justin P. mattock"
	<justinmattock@gmail.com>
CC: Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'"
	<selinux@tycho.nsa.gov>
Date: Wed, 17 Feb 2010 15:03:12 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A780280@EUSAACMS0703.eamcs.ericsson.se>
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
In-Reply-To: <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here are the AVC messages from reboot after relabel:

type=DAEMON_START msg=audit(1266436045.285:1584): auditd start, ver=1.7.13 format=raw kernel=2.6.31.5-0.1-desktop auid=4294967295 pid=2191 subj=system_u:system_r:sysadm_t res=success
type=AVC msg=audit(1266436045.288:170): avc:  denied  { nlmsg_read } for  pid=2191 comm="auditd" scontext=system_u:system_r:sysadm_t tcontext=system_u:system_r:sysadm_t tclass=netlink_audit_socket
type=AVC msg=audit(1266436045.394:171): avc:  denied  { ioctl } for  pid=2206 comm="rcsmbfs" path="/etc/samba/smbfstab" dev=sda2 ino=110898 scontext=system_u:system_r:dhcpc_t tcontext=system_u:object_r:samba_etc_t tclass=file
type=AVC msg=audit(1266436045.400:172): avc:  denied  { write } for  pid=2211 comm="touch" name="smbfs" dev=sda2 ino=129640 scontext=system_u:system_r:dhcpc_t tcontext=system_u:object_r:var_lock_t tclass=file
type=AVC msg=audit(1266436045.400:173): avc:  denied  { open } for  pid=2211 comm="touch" name="smbfs" dev=sda2 ino=129640 scontext=system_u:system_r:dhcpc_t tcontext=system_u:object_r:var_lock_t tclass=file
type=AVC msg=audit(1266436045.438:174): avc:  denied  { getattr } for  pid=2220 comm="SuSEfirewall2" path="/usr/sbin/iptables" dev=sda2 ino=10435 scontext=system_u:system_r:dhcpc_t tcontext=system_u:object_r:iptables_exec_t tclass=file
type=AVC msg=audit(1266436045.439:175): avc:  denied  { execute } for  pid=2220 comm="SuSEfirewall2" name="iptables" dev=sda2 ino=10435 scontext=system_u:system_r:dhcpc_t tcontext=system_u:object_r:iptables_exec_t tclass=file
type=AVC msg=audit(1266436045.439:176): avc:  denied  { read } for  pid=2220 comm="SuSEfirewall2" name="iptables" dev=sda2 ino=10435 scontext=system_u:system_r:dhcpc_t tcontext=system_u:object_r:iptables_exec_t tclass=file
type=AVC msg=audit(1266436045.441:177): avc:  denied  { open } for  pid=2221 comm="SuSEfirewall2" name="iptables" dev=sda2 ino=10435 scontext=system_u:system_r:dhcpc_t tcontext=system_u:object_r:iptables_exec_t tclass=file
type=AVC msg=audit(1266436045.441:178): avc:  denied  { execute_no_trans } for  pid=2221 comm="SuSEfirewall2" path="/usr/sbin/iptables" dev=sda2 ino=10435 scontext=system_u:system_r:dhcpc_t tcontext=system_u:object_r:iptables_exec_t tclass=file
type=AVC msg=audit(1266436045.444:179): avc:  denied  { create } for  pid=2221 comm="iptables" scontext=system_u:system_r:dhcpc_t tcontext=system_u:system_r:dhcpc_t tclass=rawip_socket
type=AVC msg=audit(1266436045.444:180): avc:  denied  { getopt } for  pid=2221 comm="iptables" lport=255 scontext=system_u:system_r:dhcpc_t tcontext=system_u:system_r:dhcpc_t tclass=rawip_socket
type=AVC msg=audit(1266436045.501:181): avc:  denied  { getattr } for  pid=2222 comm="SuSEfirewall2" path="/var/lock/SuSEfirewall2.booting" dev=sda2 ino=129622 scontext=system_u:system_r:dhcpc_t tcontext=system_u:object_r:var_lock_t tclass=file
type=AVC msg=audit(1266436280.459:182): avc:  denied  { associate } for  pid=2263 comm="kbd" name="vcs2" scontext=system_u:object_r:unlabeled_t tcontext=system_u:object_r:unlabeled_t tclass=filesystem
type=AVC msg=audit(1266436280.725:183): avc:  denied  { read } for  pid=2293 comm="hwinfo" name="mem" dev=tmpfs ino=1053 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:memory_device_t tclass=chr_file
type=AVC msg=audit(1266436280.725:184): avc:  denied  { open } for  pid=2293 comm="hwinfo" name="mem" dev=tmpfs ino=1053 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:memory_device_t tclass=chr_file
type=AVC msg=audit(1266436281.245:185): avc:  denied  { execstack } for  pid=2372 comm="cupsd" scontext=system_u:system_r:sysadm_t tcontext=system_u:system_r:sysadm_t tclass=process
type=AVC msg=audit(1266436281.255:186): avc:  denied  { execmem } for  pid=2372 comm="cupsd" scontext=system_u:system_r:sysadm_t tcontext=system_u:system_r:sysadm_t tclass=process
type=AVC msg=audit(1266436281.423:187): avc:  denied  { node_bind } for  pid=2380 comm="cupsd" saddr=0000:0000:0000:0000:0000:0000:0000:0001 src=631 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:compat_ipv4_node_t tclass=tcp_socket
type=AVC msg=audit(1266436281.423:188): avc:  denied  { node_bind } for  pid=2380 comm="cupsd" saddr=127.0.0.1 src=631 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:lo_node_t tclass=tcp_socket
type=AVC msg=audit(1266436281.688:189): avc:  denied  { read write } for  pid=2439 comm="smartd" name="sda" dev=tmpfs ino=1743 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:fixed_disk_device_t tclass=blk_file
type=AVC msg=audit(1266436281.688:190): avc:  denied  { open } for  pid=2439 comm="smartd" name="sda" dev=tmpfs ino=1743 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:fixed_disk_device_t tclass=blk_file
type=AVC msg=audit(1266436281.689:191): avc:  denied  { ioctl } for  pid=2439 comm="smartd" path="/dev/sda" dev=tmpfs ino=1743 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:fixed_disk_device_t tclass=blk_file
type=AVC msg=audit(1266436282.004:192): avc:  denied  { read } for  pid=2101 comm="rsyslogd" path="/proc/kmsg" dev=proc ino=4026531989 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:proc_kmsg_t tclass=file
type=AVC msg=audit(1266436317.516:193): avc:  denied  { node_bind } for  pid=2700 comm="master" src=25 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:inaddr_any_node_t tclass=tcp_socket
type=AVC msg=audit(1266436317.522:194): avc:  denied  { node_bind } for  pid=2700 comm="master" src=25 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:unspec_node_t tclass=tcp_socket
type=AVC msg=audit(1266436317.812:195): avc:  denied  { write } for  pid=2761 comm="ip6tables" path="/tmp/SuSEfirewall2_iptables.ME3rv0dJ" dev=sda2 ino=129882 scontext=system_u:system_r:iptables_t tcontext=system_u:object_r:user_tmp_t tclass=file
type=AVC msg=audit(1266436317.813:196): avc:  denied  { read } for  pid=2191 comm="auditd" scontext=system_u:system_r:sysadm_t tcontext=system_u:system_r:sysadm_t tclass=netlink_audit_socket
type=AVC msg=audit(1266436317.840:197): avc:  denied  { write } for  pid=2767 comm="modprobe" path="/tmp/SuSEfirewall2_iptables.ME3rv0dJ" dev=sda2 ino=129882 scontext=system_u:system_r:insmod_t tcontext=system_u:object_r:user_tmp_t tclass=file
type=AVC msg=audit(1266436318.030:198): avc:  denied  { read } for  pid=2806 comm="iptables-batch" name="SuSEfirewall2_iptables.ME3rv0dJ" dev=sda2 ino=129882 scontext=system_u:system_r:iptables_t tcontext=system_u:object_r:user_tmp_t tclass=file
type=AVC msg=audit(1266436318.030:199): avc:  denied  { open } for  pid=2806 comm="iptables-batch" name="SuSEfirewall2_iptables.ME3rv0dJ" dev=sda2 ino=129882 scontext=system_u:system_r:iptables_t tcontext=system_u:object_r:user_tmp_t tclass=file
type=AVC msg=audit(1266436318.031:200): avc:  denied  { getattr } for  pid=2806 comm="iptables-batch" path="/tmp/SuSEfirewall2_iptables.ME3rv0dJ" dev=sda2 ino=129882 scontext=system_u:system_r:iptables_t tcontext=system_u:object_r:user_tmp_t tclass=file
type=AVC msg=audit(1266436318.066:201): avc:  denied  { read } for  pid=286 comm="udevd" scontext=system_u:system_r:sysadm_t tcontext=system_u:system_r:sysadm_t tclass=netlink_kobject_uevent_socket
type=AVC msg=audit(1266436318.067:202): avc:  denied  { write } for  pid=286 comm="udevd" scontext=system_u:system_r:sysadm_t tcontext=system_u:system_r:sysadm_t tclass=netlink_kobject_uevent_socket
type=AVC msg=audit(1266436318.335:203): avc:  denied  { setattr } for  pid=2841 comm="mingetty" name="tty1" dev=tmpfs ino=3835 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:tty_device_t tclass=chr_file
type=AVC msg=audit(1266436744.301:204): avc:  denied  { setattr } for  pid=2841 comm="login" name="tty1" dev=tmpfs ino=3835 scontext=system_u:system_r:sysadm_t tcontext=system_u:object_r:tty_device_t tclass=chr_file
type=AVC msg=audit(1266436745.371:205): avc:  denied  { create } for  pid=2841 comm="login" scontext=system_u:system_r:sysadm_t tcontext=system_u:system_r:sysadm_t tclass=netlink_audit_socket
type=AVC msg=audit(1266436745.371:206): avc:  denied  { write } for  pid=2841 comm="login" scontext=system_u:system_r:sysadm_t tcontext=system_u:system_r:sysadm_t tclass=netlink_audit_socket
type=AVC msg=audit(1266436745.371:207): avc:  denied  { nlmsg_relay } for  pid=2841 comm="login" scontext=system_u:system_r:sysadm_t tcontext=system_u:system_r:sysadm_t tclass=netlink_audit_socket
type=AVC msg=audit(1266436745.371:208): avc:  denied  { audit_write } for  pid=2841 comm="login" capability=29 scontext=system_u:system_r:sysadm_t tcontext=system_u:system_r:sysadm_t tclass=capability

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
