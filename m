Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANLBLIi015311
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 16:11:21 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANL9puA012184
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 21:09:51 GMT
Subject: Re: gentoo diff for dhcpd
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: petre rodan <kaiowas@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41A08072.5000904@gentoo.org>
References: <41A08072.5000904@gentoo.org>
Content-Type: text/plain
Message-Id: <1101244439.7273.42.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 23 Nov 2004 16:13:59 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.  I removed the '/chroot' line.  It will already be labeled with
root_t and it doesn't pertain to the dhcp stuff anyway.

--- /root/public_html/policy/nsa/file_contexts/program/dhcpd.fc 2004-11-19 10:48:10.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/dhcp/dhcpd.fc      2004-11-19 10:35:55.000000000 +0200
@@ -8,3 +8,27 @@
 /var/lib/dhcp(3)?      -d      system_u:object_r:dhcp_state_t
 define(`dhcp_defined')
 ')
+
+ifdef(`distro_gentoo', `
+/etc/dhcp                      -d      system_u:object_r:dhcp_etc_t
+/etc/dhcp(/.*)?                        --      system_u:object_r:dhcp_etc_t
+/var/lib/dhcp                  -d      system_u:object_r:dhcp_state_t
+/var/lib/dhcp/dhcpd\.leases.*  --      system_u:object_r:dhcpd_state_t
+/var/run/dhcp/dhcpd\.pid       --      system_u:object_r:dhcpd_var_run_t
+
+# for the chroot setup
+/chroot                                                -d      system_u:object_r:root_t
+/chroot/dhcp                                   -d      system_u:object_r:root_t
+/chroot/dhcp/dev                               -d      system_u:object_r:device_t
+/chroot/dhcp/etc                               -d      system_u:object_r:etc_t
+/chroot/dhcp/etc/dhcp               -d  system_u:object_r:dhcp_etc_t
+/chroot/dhcp/etc/dhcp(/.*)?         --  system_u:object_r:dhcp_etc_t
+/chroot/dhcp/usr/sbin/dhcpd         --  system_u:object_r:dhcpd_exec_t
+/chroot/dhcp/var                               -d      system_u:object_r:var_t
+/chroot/dhcp/var/run                           -d      system_u:object_r:var_run_t
+/chroot/dhcp/var/lib                           -d      system_u:object_r:var_lib_t
+/chroot/dhcp/var/lib/dhcp                      -d      system_u:object_r:dhcp_state_t
+/chroot/dhcp/var/lib/dhcp/dhcpd\.leases.*      --      system_u:object_r:dhcpd_state_t
+/chroot/dhcp/var/run/dhcp/dhcpd\.pid           --      system_u:object_r:dhcpd_state_t
+')
+

On Sun, 2004-11-21 at 06:48, petre rodan wrote:
> added needed capabilities
> sys_chroot-related file locations
> 
> bye,
> peter
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
