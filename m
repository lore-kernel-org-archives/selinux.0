Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96AnlrT003281
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 06:49:47 -0400 (EDT)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96AnjKB003830
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 10:49:46 GMT
Message-ID: <4163CDD3.3@gentoo.org>
Date: Wed, 06 Oct 2004 13:49:55 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Joshua Brindle <method@gentoo.org>
CC: selinux@tycho.nsa.gov
Subject: Re: gentoo diff for ntpd
References: <41625A62.7080609@gentoo.org> <41629E45.8050107@gentoo.org>
In-Reply-To: <41629E45.8050107@gentoo.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig229124EC7B27DFD8580BB085"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig229124EC7B27DFD8580BB085
Content-Type: multipart/mixed;
 boundary="------------010308010100050909030601"

This is a multi-part message in MIME format.
--------------010308010100050909030601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi!

Joshua Brindle wrote:
> Since peter forgot to introduce himself :) he just started with gentoo 
> to give us some badly needed policy help which will hopefully allow us 
> to start sending more policy upstream. Thanks peter
> 
> Also, this diff is to make openntpd work with the current ntp policy, so 
>  a tunable other than distro_gentoo might be appropriate, or none at all.
> 
> Joshua Brindle

this is a new diff with distro_gentoo ifdefs dropped.
also, logrotate is not part of the gentoo base-policy and it shouldn't be a dependency for ntpd, so I'm also ifdef-ing that.

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------010308010100050909030601
Content-Type: text/plain;
 name="ntpd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ntpd.diff"

--- /root/public_html/policy/nsa/domains/program/unused/ntpd.te	2004-10-02 01:38:20.000000000 +0300
+++ /etc/security/selinux/src/policy/domains/program/ntpd.te	2004-10-06 04:37:19.999115040 +0300
@@ -22,7 +22,7 @@
 # for SSP
 allow ntpd_t urandom_device_t:chr_file read;
 
-allow ntpd_t self:capability { setgid setuid sys_time net_bind_service ipc_lock };
+allow ntpd_t self:capability { setgid setuid sys_time net_bind_service ipc_lock sys_chroot kill };
 allow ntpd_t self:process { setcap setsched };
 # ntpdate wants sys_nice
 dontaudit ntpd_t self:capability { fsetid sys_nice };
@@ -50,7 +50,7 @@
 can_exec(ntpd_t, initrc_exec_t)
 allow ntpd_t self:fifo_file { read write getattr };
 allow ntpd_t etc_runtime_t:file r_file_perms;
-can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t logrotate_exec_t ntpd_exec_t })
+can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t ntpd_exec_t })
 allow ntpd_t { sbin_t bin_t }:dir search;
 allow ntpd_t bin_t:lnk_file read;
 allow ntpd_t sysctl_kernel_t:dir search;
@@ -59,6 +59,7 @@
 allow ntpd_t sysadm_home_dir_t:dir r_dir_perms;
 allow ntpd_t self:file { getattr read };
 dontaudit ntpd_t domain:dir search;
+ifdef(`logrotate.te', `can_exec(ntpd_t,logrotate_exec_t)')
 ')
 
 allow ntpd_t devtty_t:chr_file rw_file_perms;
--- /root/public_html/policy/nsa/file_contexts/program/ntpd.fc	2004-06-25 23:02:43.000000000 +0300
+++ /etc/security/selinux/src/policy/file_contexts/program/ntpd.fc	2004-10-06 04:39:01.740647976 +0300
@@ -1,9 +1,9 @@
 /var/lib/ntp(/.*)?			system_u:object_r:ntp_drift_t
 /etc/ntp/data(/.*)?			system_u:object_r:ntp_drift_t
-/etc/ntp\.conf			--	system_u:object_r:net_conf_t
+/etc/ntp(d)?\.conf		--	system_u:object_r:net_conf_t
 /etc/ntp/step-tickers		--	system_u:object_r:net_conf_t
-/usr/sbin/ntpd			--	system_u:object_r:ntpd_exec_t
-/usr/sbin/ntpdate		--	system_u:object_r:ntpd_exec_t
+/usr/(s)?bin/ntpd		--	system_u:object_r:ntpd_exec_t
+/usr/(s)?bin/ntpdate		--	system_u:object_r:ntpd_exec_t
 /var/log/ntpstats(/.*)?			system_u:object_r:ntpd_log_t
 /var/log/ntpd.*			--	system_u:object_r:ntpd_log_t
 /var/log/xntpd.*		--	system_u:object_r:ntpd_log_t

--------------010308010100050909030601--

--------------enig229124EC7B27DFD8580BB085
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBY83dGSBEIeh4AEYRAr2oAJ0SjBbk4VdrWHP5NuNcrUaGDngpZgCfeVkT
yk+sELwKPA5xUA6gQUFHOUk=
=pMZi
-----END PGP SIGNATURE-----

--------------enig229124EC7B27DFD8580BB085--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
