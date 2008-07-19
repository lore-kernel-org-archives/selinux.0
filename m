Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL2wG2024253
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:02:58 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL2t5T024797
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:02:56 GMT
Message-Id: <20080719210251.406319184@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:04 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 02/23] anaconda policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Anaconda is a RH installation program, RH should know their own program and
the changes are quite trivial

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/anaconda.te serefpolicy-3.5.0/policy/modules/admin/anaconda.te
--- nsaserefpolicy/policy/modules/admin/anaconda.te	2008-07-10 11:38:46.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/admin/anaconda.te	2008-07-15 14:05:12.000000000 -0400
@@ -31,16 +31,11 @@
 modutils_domtrans_insmod(anaconda_t)
 
 seutil_domtrans_semanage(anaconda_t)
-
-unconfined_domain(anaconda_t)
+seutil_domtrans_setsebool(anaconda_t)
 
 unprivuser_home_dir_filetrans_home_content(anaconda_t,{ dir file lnk_file fifo_file sock_file })
 
 optional_policy(`
-	dmesg_domtrans(anaconda_t)
-')
-
-optional_policy(`
 	kudzu_domtrans(anaconda_t)
 ')
 
@@ -58,5 +53,9 @@
 ')
 
 optional_policy(`
+	unconfined_domain(anaconda_t)
+')
+
+optional_policy(`
 	usermanage_domtrans_admin_passwd(anaconda_t)
 ')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
