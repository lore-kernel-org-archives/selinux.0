Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2GDNXDo006481
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 08:23:34 -0500 (EST)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2GDExbS007251
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 13:14:59 GMT
Subject: Additions to net_contexts
From: David Hampton <hampton-rh@rainbolthampton.net>
To: selinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com
Content-Type: multipart/mixed; boundary="=-+6fMDerBr/iwCyLbQuuU"
Date: Wed, 16 Mar 2005 08:17:32 -0500
Message-Id: <1110979052.20316.16.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+6fMDerBr/iwCyLbQuuU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here are some additions to net_contexts to define additional privileged
ports.  I'll be submitting policies that reference these ports over the
next week or so as I get them cleaned up.  This is based on the file
from the selinux-policy-strict-sources-1.22.1-2 rpm on my FC3 system.

David


--=-+6fMDerBr/iwCyLbQuuU
Content-Disposition: attachment; filename=net_contexts.diffs
Content-Type: text/x-patch; name=net_contexts.diffs; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: net_contexts
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/net_contexts,v
retrieving revision 1.1
diff -u -r1.1 net_contexts
--- net_contexts	10 Feb 2005 19:50:13 -0000	1.1
+++ net_contexts	15 Mar 2005 05:20:42 -0000
@@ -226,6 +226,27 @@
 ')
 ifdef(`postgrey.te', `portcon tcp 60000 system_u:object_r:postgrey_port_t')
 
+ifdef(`amavis.te', `
+portcon tcp 10024 system_u:object_r:amavisd_recv_port_t
+portcon tcp 10025 system_u:object_r:amavisd_send_port_t
+')
+ifdef(`clamav.te', `
+portcon tcp 3310 system_u:object_r:clamd_port_t
+')
+ifdef(`dcc.te', `
+portcon udp 6276 system_u:object_r:dcc_port_t
+portcon udp 6277 system_u:object_r:dcc_port_t
+')
+ifdef(`pyzor.te', `
+portcon udp 24441 system_u:object_r:pyzor_port_t
+')
+ifdef(`razor.te', `
+portcon tcp 2703 system_u:object_r:razor_port_t
+')
+ifdef(`zope.te', `
+portcon tcp 8021 system_u:object_r:zope_port_t
+')
+
 # Defaults for reserved ports.  Earlier portcon entries take precedence;
 # these entries just cover any remaining reserved ports not otherwise 
 # declared or omitted due to removal of a domain.

--=-+6fMDerBr/iwCyLbQuuU--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
