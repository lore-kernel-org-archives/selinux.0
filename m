Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB8FDpLh026546
	for <selinux@tycho.nsa.gov>; Sat, 8 Dec 2007 10:13:51 -0500
Received: from asterix.wonder.pl (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB8FDoP5008851
	for <selinux@tycho.nsa.gov>; Sat, 8 Dec 2007 15:13:50 GMT
Received: from localhost (localhost [127.0.0.1])
	by asterix.wonder.pl (Postfix) with ESMTP id 147A18C5F1C
	for <selinux@tycho.nsa.gov>; Sat,  8 Dec 2007 16:15:26 +0100 (CET)
Received: from asterix.wonder.pl ([127.0.0.1])
	by localhost (asterix [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27581-10 for <selinux@tycho.nsa.gov>;
	Sat, 8 Dec 2007 16:15:18 +0100 (CET)
Date: Sat, 8 Dec 2007 16:15:16 +0100
To: SELinux list <selinux@tycho.nsa.gov>
Subject: [PATCH] Debian refpolicy-trunk xen
Message-ID: <20071208151514.GA7703@asterix.wonder.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linio@wonder.pl (Litwiniec Robert)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello, patch for xen:

--- refpolicy.orig/policy/modules/system/xen.fc 2007-10-02 20:17:33.000000000 +0200
+++ refpolicy/policy/modules/system/xen.fc      2007-11-17 16:39:12.755643344 +0100
@@ -24,3 +24,10 @@
 /var/run/xenstored(/.*)?       gen_context(system_u:object_r:xenstored_var_run_t,s0)

 /xen(/.*)?                     gen_context(system_u:object_r:xen_image_t,s0)
+
+ifdef(`distro_debian',`
+/usr/lib/xen-(.*)?/bin/xenstored       --      gen_context(system_u:object_r:xenstored_exec_t,s0)
+/usr/lib/xen-(.*)?/bin/xend            --      gen_context(system_u:object_r:xend_exec_t,s0)
+/usr/lib/xen-(.*)?/bin/xenconsoled     --      gen_context(system_u:object_r:xenconsoled_exec_t,s0)
+/usr/lib/xen-(.*)?/bin/xm              --      gen_context(system_u:object_r:xm_exec_t,s0)
+')

regards,
Robert Litwiniec
LiNiO
-- 
http://debian.wonder.pl - Debian/GNU Linux wiki
http://zamosc.wonder.pl - Wonders of Zamosc - Zamosc zadziwia

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
