Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i958NgrT024396
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 04:23:43 -0400 (EDT)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i958Nf7h015248
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 08:23:42 GMT
Message-ID: <41625A62.7080609@gentoo.org>
Date: Tue, 05 Oct 2004 11:25:06 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo diff for ntpd
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3588E2CBFBABA9F31B853AC3"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3588E2CBFBABA9F31B853AC3
Content-Type: multipart/mixed;
 boundary="------------000102070906010608070005"

This is a multi-part message in MIME format.
--------------000102070906010608070005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

This is a very small diff that would make the gentoo community happy :)

reference:
http://bugs.gentoo.org/show_bug.cgi?id=59633

many thanks,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------000102070906010608070005
Content-Type: text/plain;
 name="ntpd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ntpd.diff"

--- /root/public_html/policy/nsa/file_contexts/program/ntpd.fc	2004-06-25 23:02:43.000000000 +0300
+++ /etc/security/selinux/src/policy/file_contexts/program/ntpd.fc	2004-10-05 10:20:01.034334096 +0300
@@ -10,3 +10,11 @@
 /var/run/ntpd.pid		--	system_u:object_r:ntpd_var_run_t
 /etc/cron\.(daily|weekly)/ntp-simple -- system_u:object_r:ntpd_exec_t
 /etc/cron\.(daily|weekly)/ntp-server -- system_u:object_r:ntpd_exec_t
+
+ifdef(`distro_gentoo', `
+/usr/bin/ntpd			--	system_u:object_r:ntpd_exec_t
+/usr/bin/ntpdate		--	system_u:object_r:ntpd_exec_t
+
+# for net-misc/openntpd
+/etc/ntpd\.conf			--	system_u:object_r:net_conf_t
+')
--- /root/public_html/policy/nsa/domains/program/unused/ntpd.te	2004-10-02 01:38:20.000000000 +0300
+++ /etc/security/selinux/src/policy/domains/program/ntpd.te	2004-10-05 04:23:53.935260872 +0300
@@ -69,3 +69,8 @@
 ifdef(`firstboot.te', `
 dontaudit ntpd_t firstboot_t:fd { use };
 ')
+
+ifdef(`distro_gentoo', `
+allow ntpd_t self:capability { sys_chroot kill };
+')
+

--------------000102070906010608070005--

--------------enig3588E2CBFBABA9F31B853AC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBYlpiGSBEIeh4AEYRApfaAKCO1zX3bXMWFpJnbxghMWWH5H5WHgCfXATr
Deu5VtMmIit4jsb4foF57i8=
=OwTs
-----END PGP SIGNATURE-----

--------------enig3588E2CBFBABA9F31B853AC3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
