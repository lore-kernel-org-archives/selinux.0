Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77FdsO4030392
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 11:39:54 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m77Fdrl6028955
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 15:39:53 GMT
Message-ID: <489B1709.4030102@redhat.com>
Date: Thu, 07 Aug 2008 11:38:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: ipsec patch
Content-Type: multipart/mixed;
 boundary="------------070102020404090208010701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070102020404090208010701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Allow ifconfig_t to write to files in /var/run/ipsec
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkibFwkACgkQrlYvE4MpobPsNwCeIGWI+PsOndYFq5pBpey14Lyx
2aAAoKADa/n/FNj15fs45vUgGSaTZJZQ
=Ur2n
-----END PGP SIGNATURE-----

--------------070102020404090208010701
Content-Type: text/plain;
 name="system_ipsec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="system_ipsec.patch"

--- nsaserefpolicy/policy/modules/system/ipsec.if	2008-08-07 11:15:12.000000000 -0400
+++ serefpolicy-3.5.2/policy/modules/system/ipsec.if	2008-08-06 16:19:00.000000000 -0400
@@ -150,6 +150,26 @@
 	manage_files_pattern($1,ipsec_var_run_t,ipsec_var_run_t)
 ')
 
+
+########################################
+## <summary>
+##	write the ipsec_var_run_t files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`ipsec_write_pid',`
+	gen_require(`
+		type ipsec_var_run_t;
+	')
+
+	files_search_pids($1)
+	write_files_pattern($1, ipsec_var_run_t, ipsec_var_run_t)
+')
+
 ########################################
 ## <summary>
 ##	Execute racoon in the racoon domain.
--- nsaserefpolicy/policy/modules/system/ipsec.te	2008-08-07 11:15:12.000000000 -0400
+++ serefpolicy-3.5.2/policy/modules/system/ipsec.te	2008-08-06 16:19:00.000000000 -0400
@@ -69,8 +69,8 @@
 read_files_pattern(ipsec_t,ipsec_key_file_t,ipsec_key_file_t)
 read_lnk_files_pattern(ipsec_t,ipsec_key_file_t,ipsec_key_file_t)
 
-allow ipsec_t ipsec_var_run_t:file manage_file_perms;
-allow ipsec_t ipsec_var_run_t:sock_file manage_sock_file_perms;
+manage_files_pattern(ipsec_t, ipsec_var_run_t,  ipsec_var_run_t)
+manage_sock_files_pattern(ipsec_t, ipsec_var_run_t,  ipsec_var_run_t)
 files_pid_filetrans(ipsec_t,ipsec_var_run_t,{ file sock_file })
 
 can_exec(ipsec_t, ipsec_mgmt_exec_t)
--- nsaserefpolicy/policy/modules/system/sysnetwork.te	2008-08-07 11:15:12.000000000 -0400
+++ serefpolicy-3.5.2/policy/modules/system/sysnetwork.te	2008-08-06 16:19:00.000000000 -0400
@@ -324,6 +337,10 @@
 ')
 
 optional_policy(`
+	ipsec_write_pid(ifconfig_t)
+')
+
+optional_policy(`
 	nis_use_ypbind(ifconfig_t)
 ')
 

--------------070102020404090208010701
Content-Type: application/octet-stream;
 name="system_ipsec.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="system_ipsec.patch.sig"

iEYEABECAAYFAkibFwkACgkQrlYvE4MpobOXpACcCDFG8c0vHAdtAH+ddWPIT/ilEPMAoMA2
Ufwmi7/Bt4q38ZZfcMUV/zcb
--------------070102020404090208010701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
