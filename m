Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74Cp5mh015262
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:51:05 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Cp47E013908
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:51:04 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 446A341C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:51:03 +0200 (CEST)
Message-Id: <20080804123738.054090534@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:17 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 21/35] kismet policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

kismet is a network sniffer so net_raw seems quite reasonable...

Index: refpolicy/policy/modules/admin/kismet.te
===================================================================
--- refpolicy.orig/policy/modules/admin/kismet.te	2008-08-03 18:30:11.000000000 +0200
+++ refpolicy/policy/modules/admin/kismet.te	2008-08-03 18:30:32.000000000 +0200
@@ -25,7 +25,7 @@
 # kismet local policy
 #
 
-allow kismet_t self:capability { net_admin setuid setgid };
+allow kismet_t self:capability { net_admin net_raw setuid setgid };
 allow kismet_t self:packet_socket create_socket_perms;
 
 manage_files_pattern(kismet_t, kismet_log_t, kismet_log_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
