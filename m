Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3ELdp7C021818
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 17:39:52 -0400 (EDT)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3ELXIIT004066
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 21:33:18 GMT
Subject: Updates to  razor [patch]
From: David Hampton <hampton-rh@rainbolthampton.net>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-crLdUP8JkKfov8VX4BOc"
Date: Thu, 14 Apr 2005 17:36:06 -0400
Message-Id: <1113514566.6056.42.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-crLdUP8JkKfov8VX4BOc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch updates the (unused) razor policy to work with the
changes in the FC strict/1.23.10-2 policy. 

David


--=-crLdUP8JkKfov8VX4BOc
Content-Disposition: attachment; filename=UDiffs.razor
Content-Type: text/x-patch; name=UDiffs.razor; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: domains/program/unused/razor.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/domains/program/unused/razor.te,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 razor.te
--- domains/program/unused/razor.te	6 Apr 2005 22:35:54 -0000	1.1.1.1
+++ domains/program/unused/razor.te	13 Apr 2005 14:29:49 -0000
@@ -48,6 +48,7 @@
 r_dir_file($1, razor_var_lib_t)
 r_dir_file($1, sysadm_razor_home_t)
 can_network_client_tcp($1, razor_port_t)
+allow $1 razor_port_t:tcp_socket name_connect;
 ')
 
 ifdef(`spamd.te', `razor_access(spamd_t)');

--=-crLdUP8JkKfov8VX4BOc--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
