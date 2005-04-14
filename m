Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3EMJT7C022228
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 18:19:29 -0400 (EDT)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3EMFhJd021718
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 22:15:43 GMT
Subject: Webalizer [patch]
From: David Hampton <hampton-rh@rainbolthampton.net>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-RdxjakCdoliD58DFcjM9"
Date: Thu, 14 Apr 2005 18:15:34 -0400
Message-Id: <1113516934.6056.44.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-RdxjakCdoliD58DFcjM9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Webalizer seems to have lost its fc file somewhere along the way.  The
attached patch supplies a file context that works on
FC3/strict/1.23.10-2, and also allows access to the nscd service.

David


--=-RdxjakCdoliD58DFcjM9
Content-Disposition: attachment; filename=UDiffs.webalizer
Content-Type: text/x-patch; name=UDiffs.webalizer; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: domains/program/webalizer.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/domains/program/webalizer.te,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 webalizer.te
--- domains/program/webalizer.te	6 Apr 2005 22:33:28 -0000	1.1.1.1
+++ domains/program/webalizer.te	13 Apr 2005 14:28:28 -0000
@@ -4,7 +4,7 @@
 #
 # Depends: apache.te
 
-application_domain(webalizer)
+application_domain(webalizer, `, nscd_client_domain')
 # to use from cron
 system_crond_entry(webalizer_exec_t,webalizer_t)
 role system_r types webalizer_t;
Index: file_contexts/program/webalizer.fc
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/file_contexts/program/webalizer.fc,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 webalizer.fc
--- file_contexts/program/webalizer.fc	6 Apr 2005 22:33:28 -0000	1.1.1.1
+++ file_contexts/program/webalizer.fc	6 Apr 2005 22:56:45 -0000
@@ -1 +1,3 @@
 #
+/usr/bin/webalizer	--	system_u:object_r:webalizer_exec_t
+/var/lib/webalizer(/.*)		system_u:object_r:webalizer_var_lib_t

--=-RdxjakCdoliD58DFcjM9--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
