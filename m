Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2CFMnRi006535
	for <selinux@tycho.nsa.gov>; Mon, 12 Mar 2007 11:22:49 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2CFMle2019867
	for <selinux@tycho.nsa.gov>; Mon, 12 Mar 2007 15:22:47 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l2CFKaf0030604
	for <selinux@tycho.nsa.gov>; Mon, 12 Mar 2007 11:20:36 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l2CFKaJe030603
	for selinux@tycho.nsa.gov; Mon, 12 Mar 2007 11:20:36 -0400
Date: Fri, 9 Mar 2007 16:07:07 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200703092207.l29M77Bn023464@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: additional change to ipsec policy
Cc: cpebenito@tresys.com, dwalsh@redhat.com, paul.moore@hp.com,
        sds@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


One more ipsec policy change.
I don't think setkey, a trusted and sysadm utility should read it's 
config files from regular user's home directories.
 

Joy


~~
diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/ipsec.te serefpolicy-2.4.6/policy/modules/system/ipsec.te
--- serefpolicy-2.4.6.orig/policy/modules/system/ipsec.te	2007-03-09 16:14:30.000000000 -0600
+++ serefpolicy-2.4.6/policy/modules/system/ipsec.te	2007-03-09 16:15:26.000000000 -0600
@@ -309,7 +309,6 @@ domain_setcontext(setkey_t)
 
 # allow setkey to read a config files in any directory.
 userdom_read_sysadm_home_content_files(setkey_t)
-userdom_read_all_users_home_content_files(setkey_t)
 
 # setkey will be run by sysadm, thus setkey needs access to sysadm ttys.
 userdom_use_sysadm_ttys(setkey_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
