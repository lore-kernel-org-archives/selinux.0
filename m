Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA00783
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 07:10:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA19446
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 12:08:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA19442
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 12:08:01 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 690FB92668
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 23:10:12 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 1BB02A772
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 13:10:02 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: 2.4.20
Date: Fri, 29 Nov 2002 13:10:01 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_P47C1V3NBFMTEUNEPHYR"
Message-Id: <200211291310.01502.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_P47C1V3NBFMTEUNEPHYR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have applied the 2.4.19 patch to the newly released kernel 2.4.20.  It seems 
to work fine, I have a machine up and running on the net with KDE using it.

However there is a problem that I suspect to be a bug in the 2.4.20 kernel.  
It seems to allow a file handle for the root directory of the initrd to be 
inherited to all processes.

I've attached a log of the avc messages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_P47C1V3NBFMTEUNEPHYR
Content-Type: text/plain;
  charset="us-ascii";
  name="avc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="avc"

avc:  denied  { read } for  pid=192 exe=/sbin/iptables path=/ dev=00:00 ino=1 scontext=system_u:system_r:ipchains_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { read } for  pid=1208 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1211 exe=/sbin/syslogd path=/ dev=00:00 ino=1 scontext=system_u:system_r:syslogd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1211 exe=/sbin/syslogd path=/ dev=00:00 ino=1 scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { read } for  pid=1214 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:hotplug_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1243 exe=/usr/sbin/usbmodules path=/ dev=00:00 ino=1 scontext=system_u:system_r:usbmodules_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1243 exe=/usr/sbin/usbmodules path=/ dev=00:00 ino=1 scontext=system_u:system_r:usbmodules_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1256 exe=/sbin/klogd path=/ dev=00:00 ino=1 scontext=system_u:system_r:klogd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1256 exe=/sbin/klogd path=/ dev=00:00 ino=1 scontext=system_u:system_r:klogd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1277 exe=/sbin/cardmgr path=/ dev=00:00 ino=1 scontext=system_u:system_r:cardmgr_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1277 exe=/sbin/cardmgr path=/ dev=00:00 ino=1 scontext=system_u:system_r:cardmgr_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1289 exe=/sbin/portmap path=/ dev=00:00 ino=1 scontext=system_u:system_r:portmap_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1289 exe=/sbin/portmap path=/ dev=00:00 ino=1 scontext=system_u:system_r:portmap_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1297 exe=/usr/sbin/nscd path=/ dev=00:00 ino=1 scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1297 exe=/usr/sbin/nscd path=/ dev=00:00 ino=1 scontext=system_u:system_r:nscd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1313 exe=/usr/sbin/accton path=/ dev=00:00 ino=1 scontext=system_u:system_r:acct_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1313 exe=/usr/sbin/accton path=/ dev=00:00 ino=1 scontext=system_u:system_r:acct_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1316 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:update_modules_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1316 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:update_modules_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1399 exe=/sbin/depmod path=/ dev=00:00 ino=1 scontext=system_u:system_r:depmod_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1399 exe=/sbin/depmod path=/ dev=00:00 ino=1 scontext=system_u:system_r:depmod_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1490 exe=/usr/sbin/apmd path=/ dev=00:00 ino=1 scontext=system_u:system_r:apmd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1490 exe=/usr/sbin/apmd path=/ dev=00:00 ino=1 scontext=system_u:system_r:apmd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1529 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:automount_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1529 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:automount_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1530 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:cardmgr_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1530 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:cardmgr_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1544 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:courier_authdaemon_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1544 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:courier_authdaemon_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1548 exe=/bin/mount path=/ dev=00:00 ino=1 scontext=system_u:system_r:mount_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1548 exe=/bin/mount path=/ dev=00:00 ino=1 scontext=system_u:system_r:mount_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1565 exe=/usr/sbin/couriertcpd path=/ dev=00:00 ino=1 scontext=system_u:system_r:courier_tcpd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1565 exe=/usr/sbin/couriertcpd path=/ dev=00:00 ino=1 scontext=system_u:system_r:courier_tcpd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1573 exe=/usr/lib/courier/courier/pcpd path=/ dev=00:00 ino=1 scontext=system_u:system_r:courier_pcp_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1573 exe=/usr/lib/courier/courier/pcpd path=/ dev=00:00 ino=1 scontext=system_u:system_r:courier_pcp_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { read } for  pid=1591 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:automount_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { read } for  pid=1599 exe=/usr/sbin/couriertcpd path=/ dev=00:00 ino=1 scontext=system_u:system_r:courier_tcpd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1618 exe=/usr/sbin/cupsd path=/ dev=00:00 ino=1 scontext=system_u:system_r:cupsd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1618 exe=/usr/sbin/cupsd path=/ dev=00:00 ino=1 scontext=system_u:system_r:cupsd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { read } for  pid=1626 exe=/sbin/insmod path=/ dev=00:00 ino=1 scontext=system_u:system_r:insmod_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1781 exe=/usr/sbin/dancer-ircd path=/ dev=00:00 ino=1 scontext=system_u:system_r:ircd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1781 exe=/usr/sbin/dancer-ircd path=/ dev=00:00 ino=1 scontext=system_u:system_r:ircd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1784 exe=/usr/sbin/dictd path=/ dev=00:00 ino=1 scontext=system_u:system_r:dictd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1784 exe=/usr/sbin/dictd path=/ dev=00:00 ino=1 scontext=system_u:system_r:dictd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1790 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:devfsd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { use } for  pid=1804 exe=/usr/sbin/exportfs path=/ dev=00:00 ino=1 scontext=system_u:system_r:rpcd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1804 exe=/usr/sbin/exportfs path=/ dev=00:00 ino=1 scontext=system_u:system_r:rpcd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1821 exe=/usr/sbin/nsd path=/ dev=00:00 ino=1 scontext=system_u:system_r:nsd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1821 exe=/usr/sbin/nsd path=/ dev=00:00 ino=1 scontext=system_u:system_r:nsd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { chown } for  pid=1822 comm=nsd capability=0 scontext=system_u:system_r:nsd_t tcontext=system_u:system_r:nsd_t tclass=capability
avc:  denied  { name_bind } for  pid=1829 exe=/usr/sbin/perdition port=110 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:pop_port_t tclass=tcp_socket
avc:  denied  { use } for  pid=1843 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:postgresql_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1843 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:postgresql_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1877 exe=/usr/sbin/rlinetd path=/ dev=00:00 ino=1 scontext=system_u:system_r:inetd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1877 exe=/usr/sbin/rlinetd path=/ dev=00:00 ino=1 scontext=system_u:system_r:inetd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1886 exe=/usr/sbin/slapd path=/ dev=00:00 ino=1 scontext=system_u:system_r:slapd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1886 exe=/usr/sbin/slapd path=/ dev=00:00 ino=1 scontext=system_u:system_r:slapd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1889 exe=/usr/sbin/smartd path=/ dev=00:00 ino=1 scontext=system_u:system_r:fsadm_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1889 exe=/usr/sbin/smartd path=/ dev=00:00 ino=1 scontext=system_u:system_r:fsadm_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1893 exe=/usr/sbin/snmpd path=/ dev=00:00 ino=1 scontext=system_u:system_r:snmpd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1893 exe=/usr/sbin/snmpd path=/ dev=00:00 ino=1 scontext=system_u:system_r:snmpd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1900 exe=/usr/sbin/sshd path=/ dev=00:00 ino=1 scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1900 exe=/usr/sbin/sshd path=/ dev=00:00 ino=1 scontext=system_u:system_r:sshd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1907 exe=/usr/lib/sysstat/sadc path=/ dev=00:00 ino=1 scontext=system_u:system_r:sysstat_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1907 exe=/usr/lib/sysstat/sadc path=/ dev=00:00 ino=1 scontext=system_u:system_r:sysstat_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1925 exe=/sbin/rpc.statd path=/ dev=00:00 ino=1 scontext=system_u:system_r:rpcd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { use } for  pid=1935 exe=/usr/sbin/radiusd path=/ dev=00:00 ino=1 scontext=system_u:system_r:radiusd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1935 exe=/usr/sbin/radiusd path=/ dev=00:00 ino=1 scontext=system_u:system_r:radiusd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1977 exe=/usr/sbin/atd path=/ dev=00:00 ino=1 scontext=system_u:system_r:atd_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1977 exe=/usr/sbin/atd path=/ dev=00:00 ino=1 scontext=system_u:system_r:atd_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1980 exe=/usr/sbin/cron path=/ dev=00:00 ino=1 scontext=system_u:system_r:crond_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1980 exe=/usr/sbin/cron path=/ dev=00:00 ino=1 scontext=system_u:system_r:crond_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { recvfrom } for  pid=1895 exe=/usr/sbin/slapd saddr=127.0.0.1 source=32771 daddr=127.0.0.1 dest=53 netif=lo scontext=system_u:system_r:nsd_t tcontext=system_u:system_r:slapd_t tclass=udp_socket
avc:  denied  { recvfrom } for  pid=1822 exe=/usr/sbin/nsd saddr=127.0.0.1 source=53 daddr=127.0.0.1 dest=32771 netif=lo scontext=system_u:system_r:slapd_t tcontext=system_u:system_r:nsd_t tclass=udp_socket
avc:  denied  { read } for  pid=1984 exe=/usr/sbin/fcron path=/ dev=00:00 ino=1 scontext=system_u:system_r:crond_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1995 exe=/sbin/fbgetty path=/ dev=00:00 ino=1 scontext=system_u:system_r:getty_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1995 exe=/sbin/fbgetty path=/ dev=00:00 ino=1 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1999 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:system_crond_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { use } for  pid=2004 exe=/usr/lib/atsar/atsadc path=/ dev=00:00 ino=1 scontext=system_u:system_r:sysstat_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=2004 exe=/usr/lib/atsar/atsadc path=/ dev=00:00 ino=1 scontext=system_u:system_r:sysstat_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=2005 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:logrotate_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=2005 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:logrotate_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=2366 exe=/usr/sbin/sendmail path=/ dev=00:00 ino=1 scontext=system_u:system_r:system_mail_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=2366 exe=/usr/sbin/sendmail path=/ dev=00:00 ino=1 scontext=system_u:system_r:system_mail_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1995 exe=/bin/login path=/ dev=00:00 ino=1 scontext=system_u:system_r:local_login_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=1995 exe=/bin/login path=/ dev=00:00 ino=1 scontext=system_u:system_r:local_login_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { use } for  pid=1995 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=root:sysadm_r:sysadm_t tcontext=system_u:system_r:kernel_t tclass=fd
avc:  denied  { read } for  pid=2387 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:logrotate_t tcontext=system_u:object_r:unlabeled_t tclass=dir
avc:  denied  { read } for  pid=2732 exe=/usr/sbin/sendmail path=/ dev=00:00 ino=1 scontext=system_u:system_r:system_mail_t tcontext=system_u:object_r:unlabeled_t tclass=dir

--------------Boundary-00=_P47C1V3NBFMTEUNEPHYR--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
