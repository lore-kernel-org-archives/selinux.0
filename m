Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6G0M4rT026317
	for <selinux@tycho.nsa.gov>; Thu, 15 Jul 2004 20:22:04 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6G0LeEp014737
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 00:21:41 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 6CFA3C4C094
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 02:21:54 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 29579-02 for <selinux@tycho.nsa.gov>;
	Fri, 16 Jul 2004 02:21:53 +0200 (CEST)
Received: from wintermute.xmldesign.de (pD958FCB9.dip.t-dialin.net [217.88.252.185])
	by legolas.drinsama.de (Postfix) with ESMTP id 73924C4C090
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 02:21:52 +0200 (CEST)
Date: Fri, 16 Jul 2004 02:22:10 +0200
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
Subject: SELinux Policy patches
Message-ID: <20040716002210.GA1081@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
heres a couple of diffs from my SELinux installation for the policy
files. I'm not sure in every case if this is the correct thing to do.

Some are local installation things (=3D Debian default usually) where
programs are allowed to read a dir/file, but not a link.

----
# can be a link, too - maybe dontaudit, since this is the "build" link
# in my case, which it does not need to read...
allow initrc_t modules_object_t:lnk_file read;
# spamd going for a link in the perl dirs (5.8 -> 5.8.1 or so)
allow spamd_t usr_t:lnk_file read;
# not sure if this is still needed with the recent path changes:
allow load_policy_t policy_src_t:lnk_file read;

# I also added (don't remember what that was needed for):
can_exec(logrotate_t, logrotate_exec_t)

# Newer versions of pppd can update the utmp file:
allow pppd_t initrc_var_run_t:file rw_file_perms;
----

Then a small change for the file_contexts/program/named.fc
-/etc/bind/rndc\.key    --  system_u:object_r:rndc_conf_t
+/etc/bind/rndc.*   --  system_u:object_r:rndc_conf_t
(debian default installation included rndc.conf i think)


Attached is a set of rule files i've written. Please correct the obvious
errors i made, i'm new to SELinux...
It contains: swapon, pptpd and nsupdate
(probably to come: famd, maildrop, dracd)


I have a couple of access violation with applications of
  foo var_lib_t:dir search;
  foo var_lib_t:lnk_file read;
for example syslogd, inetd, postfix_masteri, staff_ssh_t.
Should i allow these or use dontaudit, and should i submit patches for
such? Is there a known reason for such behaviour?


/bin/mountpoint gets access violations for "tmpfs_t", "devpts_t".
Should i add these to fsadm_t or make a new mountpoint_t?


Any idea what this is "good" for, what is modprobe trying to do:
denied  { write } for  pid=3D281 exe=3D/sbin/modprobe name=3D8390.ko
scontext=3Dsystem_u:system_r:insmod_t
tcontext=3Dsystem_u:object_r:modules_object_t tclass=3Dfile


"amavis.te" is causing two violations (consider dontaudit)
# allow amavis to search clamd socket in /var/run/clamav
allow amavisd_t clamd_var_run_t:dir search;
# cron job trying to search /var/lib/amavis
allow crond_t amavisd_lib_t:dir search;


"spamd.te" similar:
-allow spamd_t { etc_t etc_runtime_t }:file { getattr read };
+allow spamd_t { etc_t etc_runtime_t }:file { getattr read ioctl };
-allow spamd_t usr_t:file { getattr ioctl read };
+allow spamd_t usr_t:{ lnk_file file } { getattr ioctl read };

"clamav.te" needs log file support here:
+# for log files
+log_domain(clamd)
+rw_dir_file(clamd_t, clamd_log_t)

"clamav.fc" needs the following:
+/var/log/clamav(/.*)? --       system_u:object_r:clamd_log_t
+/var/run/clamav(/.*)?          system_u:object_r:clamd_var_run_t

Another question:
I added "nsupdate" support to my local pppd using a small script.
I use dhcpd failover, thus requring dhcp to bind to additional ports.
I have split logfiles for named.

Should i keep such rules in my local.te file, or should i also publish
them somehow? Some things like the dhcpd-failover or named-log thing
could be of general interest.

Greetings,
Erich Schubert
--=20
    erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C    (o_
     Go away or i'll replace you with a very small shell script.    //\
    Wer keinen Mut zum Tr=E4umen hat, hat keine Kraft zum K=E4mpfen!    V=
_/_

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nsupdate.fc"

/usr/bin/nsupdate      	--	system_u:object_r:nsupdate_exec_t

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nsupdate.te"

#DESC NSUPDATE - dynamic zone updates for bind
#
# Authors:  Erich Schubert
# X-Debian-Packages: bind bind9
# 

user_application_domain(nsupdate)

# to access keys stored there
allow nsupdate_t named_zone_t:dir { search };
allow nsupdate_t named_zone_t:file r_file_perms;

can_network(nsupdate_t)
allow nsupdate_t self:netlink_socket create_socket_perms;
# allow UDP transfer to/from any program
can_udp_send(named_t, nsupdate_t)
can_udp_send(nsupdate_t, named_t)
can_tcp_connect(nsupdate_t, named_t)

read_locale(nsupdate_t)

# read basic config files
allow nsupdate_t etc_t:file { getattr read };

allow nsupdate_t self:process { fork signal };
allow nsupdate_t self:capability { net_admin };
allow nsupdate_t self:fifo_file rw_file_perms;

# allow a _local_ named to write its zone files
# needed for dynamic updates
# a better solution would be to make a new time
# for example in a subdir "dynamic"
ifdef(`named.te',`
rw_dir_create_file(named_t, named_zone_t)
')

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pptp.fc"

# pptpd
/usr/sbin/pptpd		--	system_u:object_r:pptpd_exec_t
/usr/sbin/pptpctrl	--	system_u:object_r:pptpd_exec_t
/usr/sbin/bcrelay	--	system_u:object_r:pptpd_exec_t
/etc/pptpd.conf		--	system_u:object_r:pptpd_etc_t
/var/run/pptpd.pid	--	system_u:object_r:pptpd_var_run_t

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pptp.te"

#DESC poptop - PPTP daemon
#
# Author:  Erich Schubert
# X-Debian-Packages: pptp
#

#################################
#
# Rules for the pptpd_t domain, et al.
#
# pptpd_t is the domain for the pppd program.
# pptpd_exec_t is the type of the pppd executable.
#
daemon_domain(pptpd)
etc_domain(pptpd)

# can execute own apps (pptpctrl)
can_exec(pptpd_t, pptpd_exec_t)

# Use the network.
can_network(pptpd_t)
allow pptpd_t self:capability { net_raw };
allow pptpd_t pptpd_t:unix_dgram_socket create_socket_perms;
allow pptpd_t { node_t pptpd_t }:rawip_socket { create_socket_perms node_bind };
allow pptpd_t { pptpd_t port_t}:tcp_socket { create_socket_perms name_bind };

can_create_pty(pptpd)

# find and execute pppd
allow pptpd_t sbin_t:dir { search };
can_exec(pptpd_t, pppd_exec_t)
domain_auto_trans(pptpd_t, pppd_exec_t, pppd_t)
allow pptpd_t pppd_t:process signal;

# allow pppd to access the pptp ptys
allow pppd_t pptpd_devpts_t:chr_file rw_file_perms;

# allow to read pppd options file
allow pptpd_t { pppd_etc_rw_t pppd_etc_t }:file { read getattr };
allow pptpd_t pppd_etc_t:dir { search };

# search /var/lib (what for?)
allow pptpd_t var_lib_t:dir { search };

# allow reading of nsswitch.conf etc.
allow pptpd_t etc_t:dir search;
allow pptpd_t etc_t:file r_file_perms;

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="swapon.fc"

# Swapon
/bin/swapon			--	system_u:object_r:swap_exec_t
/bin/swapoff			--	system_u:object_r:swap_exec_t

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="swapon.te"

#DESC Swapon, Swapoff - Swap partition management
#
# Author:  Erich Schubert
# X-Debian-Packages: mount
#
type swap_t, domain, privlog , fs_domain;
type swap_exec_t, file_type, sysadmfile, exec_type;
role sysadm_r types swap_t;
role system_r types swap_t;

allow swap_t { initrc_devpts_t console_device_t }:chr_file { read write };

domain_auto_trans(initrc_t, swap_exec_t, swap_t)
allow swap_t init_t:fd use;
allow swap_t privfd:fd use;

allow swap_t self:capability { ipc_lock dac_override };

allow swap_t file_type:dir search;

# Access disk devices.
allow swap_t fixed_disk_device_t:devfile_class_set rw_file_perms;
allow swap_t removable_device_t:devfile_class_set rw_file_perms;

--EeQfGwPcQSOJBaQU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
