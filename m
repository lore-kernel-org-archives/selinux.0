Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72IPm3g013135
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:25:48 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72IPkev008783
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:25:46 GMT
Message-ID: <46B221A7.4040000@redhat.com>
Date: Thu, 02 Aug 2007 14:25:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: [PATCH] refpolicy: system_miscfiles changes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Additional fonts directory

--- nsaserefpolicy/policy/modules/system/miscfiles.fc	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.4/policy/modules/system/miscfiles.fc	2007-07-25 12:07:25.000000000 -0400
@@ -66,6 +66,7 @@
 /var/lib/texmf(/.*)?		gen_context(system_u:object_r:tetex_data_t,s0)
 
 /var/cache/fonts(/.*)?		gen_context(system_u:object_r:tetex_data_t,s0)
+/var/cache/fontconfig(/.*)?	gen_context(system_u:object_r:fonts_t,s0)
 /var/cache/man(/.*)?		gen_context(system_u:object_r:man_t,s0)
 
 /var/spool/texmf(/.*)?		gen_context(system_u:object_r:tetex_data_t,s0)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
