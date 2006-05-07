Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k47FcPgm032253
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 11:38:25 -0400
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k47FcOTD014527
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 15:38:24 GMT
Received: from megaweapon.nightmoose.net (HELO d.namei) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 7 May 2006 15:38:10 -0000
Date: Sun, 7 May 2006 11:38:08 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: netdev@vger.kernel.org, netfilter-devel@lists.samba.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: [RFC][SECMARK 06/08] Define a relabelto permission in the SELinux
 packet class
In-Reply-To: <Pine.LNX.4.64.0605071104590.8588@d.namei>
Message-ID: <Pine.LNX.4.64.0605071137180.8588@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch defines a new permission ('relabelto') in the new SELinux 
packet object class, to be used when setting SECMARK rules for labeling 
packets.

Signed-off-by: James Morris <jmorris@namei.org>

---

 security/selinux/include/av_perm_to_string.h |    1 +
 security/selinux/include/av_permissions.h    |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff -purN -X dontdiff linux-2.6.17-rc3-git7.p/security/selinux/include/av_permissions.h linux-2.6.17-rc3-git7.w/security/selinux/include/av_permissions.h
--- linux-2.6.17-rc3-git7.p/security/selinux/include/av_permissions.h	2006-05-03 11:34:17.000000000 -0400
+++ linux-2.6.17-rc3-git7.w/security/selinux/include/av_permissions.h	2006-05-07 00:14:13.000000000 -0400
@@ -935,4 +935,4 @@
 
 #define PACKET__SEND                              0x00000001UL
 #define PACKET__RECV                              0x00000002UL
-
+#define PACKET__RELABELTO                         0x00000004UL
diff -purN -X dontdiff linux-2.6.17-rc3-git7.p/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc3-git7.w/security/selinux/include/av_perm_to_string.h
--- linux-2.6.17-rc3-git7.p/security/selinux/include/av_perm_to_string.h	2006-05-03 11:34:17.000000000 -0400
+++ linux-2.6.17-rc3-git7.w/security/selinux/include/av_perm_to_string.h	2006-05-07 00:14:34.000000000 -0400
@@ -241,3 +241,4 @@
    S_(SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, "setcontext")
    S_(SECCLASS_PACKET, PACKET__SEND, "send")
    S_(SECCLASS_PACKET, PACKET__RECV, "recv")
+   S_(SECCLASS_PACKET, PACKET__RELABELTO, "relabelto")

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
