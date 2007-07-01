Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l618Qptb003188
	for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2007 04:26:52 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l618QoYt005525
	for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2007 08:26:50 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <61D1AE62-7AED-4A77-9EFC-0B56164B7F17@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: apcupsd policy addon
Date: Sun, 1 Jul 2007 10:26:45 +0200
To: "Christopher PeBenito J." <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

debian stores the apcupsd binary under /sbin not /usr/sbin

--- /usr/src/refpolicy-20070629/policy/modules/services/ 
apcupsd.fc      2007-05-07 16:55:54.000000000 +0200
+++ policy/modules/services/apcupsd.fc  2007-07-01 10:18:45.000000000  
+0200
@@ -1,4 +1,5 @@
/usr/sbin/apcupsd              --      gen_context 
(system_u:object_r:apcupsd_exec_t,s0)
+/sbin/apcupsd                  --      gen_context 
(system_u:object_r:apcupsd_exec_t,s0)
/var/log/apcupsd\.events.*     --      gen_context 
(system_u:object_r:apcupsd_log_t,s0)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
