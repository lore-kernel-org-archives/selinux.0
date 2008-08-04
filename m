Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CeChh012480
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:40:12 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Ce6pq014733
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:40:07 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id B5FF01AB
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:40:09 +0200 (CEST)
Message-Id: <20080804123738.902590483@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:22 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 26/35] stunnel policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Changes to the stunnel module which shouldn't be controversial, the interface
is used by later RH patches to the inetd module.
Index: refpolicy/policy/modules/services/stunnel.if
===================================================================
--- refpolicy.orig/policy/modules/services/stunnel.if	2008-07-19 19:15:41.000000000 +0200
+++ refpolicy/policy/modules/services/stunnel.if	2008-08-03 21:21:31.000000000 +0200
@@ -1 +1,25 @@
 ## <summary>SSL Tunneling Proxy</summary>
+
+########################################
+## <summary>
+##	Define the specified domain as a stunnel inetd service.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type associated with the stunnel inetd service process.
+##	</summary>
+## </param>
+## <param name="entrypoint">
+##	<summary>
+##	The type associated with the process program.
+##	</summary>
+## </param>
+#
+interface(`stunnel_service_domain',`
+	gen_require(`
+		type stunnel_t;
+	')
+
+	domtrans_pattern(stunnel_t,$2,$1)
+	allow $1 stunnel_t:tcp_socket rw_socket_perms;
+')
Index: refpolicy/policy/modules/services/stunnel.te
===================================================================
--- refpolicy.orig/policy/modules/services/stunnel.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/services/stunnel.te	2008-08-03 21:21:31.000000000 +0200
@@ -20,7 +20,7 @@
 ')
 
 type stunnel_etc_t;
-files_type(stunnel_etc_t)
+files_config_file(stunnel_etc_t)
 
 type stunnel_tmp_t;
 files_tmp_file(stunnel_tmp_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
