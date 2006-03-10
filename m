Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2AGKhkg017784
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 11:20:43 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2AGKf59007095
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 16:20:42 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k2AGKgtO017133
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 11:20:42 -0500 (EST)
Date: Fri, 10 Mar 2006 10:20:33 -0600
From: Chad Hanson <chanson@TrustedCS.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] MLS policy comment update
Message-ID: <20060310162033.GB2949@dhcp-225.il.tcs-sec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This patch adds some of the newer classes and permissions to the MLS Policy.
These are listed to show that there no MLS contraints on these actions.

-Chad


diff -Nur serefpolicy-2.2.23.orig/policy/mls serefpolicy-2.2.23/policy/mls
--- serefpolicy-2.2.23.orig/policy/mls	2006-03-04 05:06:49.000000000 +0000
+++ serefpolicy-2.2.23/policy/mls	2006-03-09 23:09:02.000000000 +0000
@@ -293,8 +293,14 @@
 #
 # { tcp_socket unix_stream_socket } { connectto newconn acceptfrom }
 #
+# tcp_socket name_connect
+#
 # { netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_xfrm_socket netlink_audit_socket netlink_ip6fw_socket } nlmsg_write
 #
+# netlink_audit_socket { nlmsg_relay nlmsg_readpriv }
+#
+# netlink_kobject_uevent_socket *
+#
 
 
 
@@ -365,7 +371,7 @@
 	(( l1 dom l2 ) and ( l1 domby h2 ));
 
 # these access vectors have no MLS restrictions
-# { netif node } { enforce_dest }
+# node enforce_dest
 
 
 
@@ -397,7 +403,7 @@
 	 ( t1 == mlsprocwrite ));
 
 # these access vectors have no MLS restrictions
-# process { fork sigchld signull noatsecure siginh setrlimit rlimitinh execmem }
+# process { fork sigchld signull noatsecure siginh setrlimit rlimitinh execmem execstack execheap }
 
 
 
@@ -663,6 +669,6 @@
 #
 
 # these access vectors have no MLS restrictions
-# association { sendto recvfrom }
+# association *
 
 ') dnl end enable_mls


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
