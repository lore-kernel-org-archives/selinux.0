Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0BGeXIi008316
	for <selinux@tycho.nsa.gov>; Tue, 11 Jan 2005 11:40:35 -0500 (EST)
Received: from host138.ipowerweb.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j0BGeZ1A013108
	for <selinux@tycho.nsa.gov>; Tue, 11 Jan 2005 16:40:36 GMT
Message-ID: <41E40180.9020500@darkhonor.com>
Date: Tue, 11 Jan 2005 11:40:32 -0500
From: Alex Ackerman <alex@darkhonor.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: pppd Patch for PPTPClient
Content-Type: multipart/mixed;
 boundary="------------080004090305060303000209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080004090305060303000209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is a patch to enable PPTPClient to run, create PPTP tunnels and
connect to the remote VPN networks.

I am running Fedora Core Rawhide with selinux-policy-strict-1.19.17-2
installed.

Comments?
Alex Ackerman
http://www.darkhonor.com

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB5AGAPhyWKHn+SnQRAm2VAJ4heVs9nsY0Ppbv6rFB4BrJkPkZoACghZ98
jGjWZMKNn4Zrz1DKtEOuYzk=
=2UcX
-----END PGP SIGNATURE-----

--------------080004090305060303000209
Content-Type: text/x-patch;
 name="pppd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pppd.patch"

--- nsa/pppd.te	2005-01-11 11:35:28.933974056 -0500
+++ pptp/pppd.te	2005-01-11 11:30:52.627978952 -0500
@@ -97,3 +97,10 @@
 
 file_type_auto_trans(pppd_t, etc_t, net_conf_t, file)
 tmp_domain(pppd)
+
+# Added for pptpclient
+allow pppd_t initrc_var_run_t:file { lock read write };
+allow pppd_t self:rawip_socket { connect create read write };
+allow pppd_t self:tcp_socket connect;
+allow pppd_t self:unix_stream_socket { accept connectto listen };
+allow pppd_t var_run_t:sock_file { create setattr unlink write };

--------------080004090305060303000209--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
