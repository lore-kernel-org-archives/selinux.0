Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28FkER7008126
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 10:46:14 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28FkDY3016362
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 15:46:13 GMT
Message-ID: <45F02FC3.8010501@redhat.com>
Date: Thu, 08 Mar 2007 10:46:11 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: gpg needs to be able to create its keys dir
Content-Type: multipart/mixed;
 boundary="------------010802010204000806000602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010802010204000806000602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010802010204000806000602
Content-Type: text/plain;
 name="nsaserefpolicy_policy_modules_apps_gpg.if"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_apps_gpg.if"

--- nsaserefpolicy/policy/modules/apps/gpg.if	2007-01-02 12:57:22.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/apps/gpg.if	2007-03-08 08:42:36.000000000 -0500
@@ -89,6 +89,7 @@
 
 	manage_files_pattern($1_gpg_t,$1_gpg_secret_t,$1_gpg_secret_t)
 	manage_lnk_files_pattern($1_gpg_t,$1_gpg_secret_t,$1_gpg_secret_t)
+ 	userdom_user_home_dir_filetrans($1, $1_gpg_t, $1_gpg_secret_t, dir)
 
 	# transition from the userdomain to the derived domain
 	domtrans_pattern($2,gpg_exec_t,$1_gpg_t)

--------------010802010204000806000602--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
