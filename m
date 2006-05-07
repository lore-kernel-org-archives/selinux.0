Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k47FaCgi032176
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 11:36:12 -0400
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k47FaATD013944
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 15:36:11 GMT
Received: from megaweapon.nightmoose.net (HELO d.namei) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 7 May 2006 15:36:06 -0000
Date: Sun, 7 May 2006 11:36:03 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: netdev@vger.kernel.org, netfilter-devel@lists.samba.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: [RFC][SECMARK 04/08] Add new flask definitions to SELinux
In-Reply-To: <Pine.LNX.4.64.0605071104590.8588@d.namei>
Message-ID: <Pine.LNX.4.64.0605071135240.8588@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support for a new object class ('packet'),
and two associated permissions ('send', 'recv').  These
are used to enforce security policy for network packets
labeled with SECMARK.


Signed-off-by: James Morris <jmorris@namei.org>

---

diff -purN -X dontdiff linux-2.6.17-rc2-mm1.p/security/selinux/include/av_permissions.h linux-2.6.17-rc2-mm1.w/security/selinux/include/av_permissions.h
--- linux-2.6.17-rc2-mm1.p/security/selinux/include/av_permissions.h	2006-05-01 16:51:36.000000000 -0400
+++ linux-2.6.17-rc2-mm1.w/security/selinux/include/av_permissions.h	2006-05-01 16:52:14.000000000 -0400
@@ -933,3 +933,6 @@
 #define NETLINK_KOBJECT_UEVENT_SOCKET__SEND_MSG   0x00100000UL
 #define NETLINK_KOBJECT_UEVENT_SOCKET__NAME_BIND  0x00200000UL
 
+#define PACKET__SEND                              0x00000001UL
+#define PACKET__RECV                              0x00000002UL
+
diff -purN -X dontdiff linux-2.6.17-rc2-mm1.p/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc2-mm1.w/security/selinux/include/av_perm_to_string.h
--- linux-2.6.17-rc2-mm1.p/security/selinux/include/av_perm_to_string.h	2006-05-01 16:51:36.000000000 -0400
+++ linux-2.6.17-rc2-mm1.w/security/selinux/include/av_perm_to_string.h	2006-05-01 16:52:14.000000000 -0400
@@ -239,3 +239,5 @@
    S_(SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, "sendto")
    S_(SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, "recvfrom")
    S_(SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, "setcontext")
+   S_(SECCLASS_PACKET, PACKET__SEND, "send")
+   S_(SECCLASS_PACKET, PACKET__RECV, "recv")
diff -purN -X dontdiff linux-2.6.17-rc2-mm1.p/security/selinux/include/class_to_string.h linux-2.6.17-rc2-mm1.w/security/selinux/include/class_to_string.h
--- linux-2.6.17-rc2-mm1.p/security/selinux/include/class_to_string.h	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc2-mm1.w/security/selinux/include/class_to_string.h	2006-05-01 16:52:14.000000000 -0400
@@ -58,3 +58,4 @@
     S_("nscd")
     S_("association")
     S_("netlink_kobject_uevent_socket")
+    S_("packet")
diff -purN -X dontdiff linux-2.6.17-rc2-mm1.p/security/selinux/include/flask.h linux-2.6.17-rc2-mm1.w/security/selinux/include/flask.h
--- linux-2.6.17-rc2-mm1.p/security/selinux/include/flask.h	2006-05-01 16:51:36.000000000 -0400
+++ linux-2.6.17-rc2-mm1.w/security/selinux/include/flask.h	2006-05-01 16:52:14.000000000 -0400
@@ -60,6 +60,7 @@
 #define SECCLASS_NSCD                                    53
 #define SECCLASS_ASSOCIATION                             54
 #define SECCLASS_NETLINK_KOBJECT_UEVENT_SOCKET           55
+#define SECCLASS_PACKET                                  56
 
 /*
  * Security identifier indices for initial entities

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
