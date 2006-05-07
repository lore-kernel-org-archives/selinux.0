Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k47FdVe0032284
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 11:39:31 -0400
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k47FdTTD014583
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 15:39:29 GMT
Received: from megaweapon.nightmoose.net (HELO d.namei) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 7 May 2006 15:39:28 -0000
Date: Sun, 7 May 2006 11:39:27 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: netdev@vger.kernel.org, netfilter-devel@lists.samba.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: [RFC][SECMARK 07/08] Add selinux_relabel_packet_permission() to
 SELinux API
In-Reply-To: <Pine.LNX.4.64.0605071104590.8588@d.namei>
Message-ID: <Pine.LNX.4.64.0605071138260.8588@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a new function to the SELinux kernel API, 
selinux_relabel_packet_permission(), which is to be invoked when labeling 
packets via SECMARK.

The security policy must allow the specified label to be set by the 
current task for the permission to be granted.

It is implicit that packets are being labeled from the default unlabeled 
type.


Signed-off-by: James Morris <jmorris@namei.org>

---

 include/linux/selinux.h    |   16 ++++++++++++++++
 security/selinux/exports.c |   11 +++++++++++
 2 files changed, 27 insertions(+)

diff -purN -X dontdiff linux-2.6.17-rc3-git7.p/include/linux/selinux.h linux-2.6.17-rc3-git7.w/include/linux/selinux.h
--- linux-2.6.17-rc3-git7.p/include/linux/selinux.h	2006-05-07 00:10:56.000000000 -0400
+++ linux-2.6.17-rc3-git7.w/include/linux/selinux.h	2006-05-07 00:33:00.000000000 -0400
@@ -129,6 +129,17 @@ void selinux_get_task_sid(struct task_st
  */
 int selinux_string_to_sid(char *str, u32 *sid);
 
+/**
+ *     selinux_relabel_packet_permission - check permission to relabel a packet
+ *     @sid: ID value to be applied to network packet (via SECMARK, most likely)
+ *
+ *     Returns 0 if the current task is allowed to label packets with the
+ *     supplied security ID.  Note that it is implicit that the packet is always
+ *     being relabeled from the default unlabled value, and that the access
+ *     control decision is made in the AVC.
+ */
+int selinux_relabel_packet_permission(u32 sid);
+
 #else
 
 static inline int selinux_audit_rule_init(u32 field, u32 op,
@@ -188,6 +199,11 @@ static inline int selinux_string_to_sid(
        return 0;
 }
 
+static inline int selinux_relabel_packet_permission(u32 sid)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY_SELINUX */
 
 #endif /* _LINUX_SELINUX_H */
diff -purN -X dontdiff linux-2.6.17-rc3-git7.p/security/selinux/exports.c linux-2.6.17-rc3-git7.w/security/selinux/exports.c
--- linux-2.6.17-rc3-git7.p/security/selinux/exports.c	2006-05-07 00:10:56.000000000 -0400
+++ linux-2.6.17-rc3-git7.w/security/selinux/exports.c	2006-05-07 00:24:22.000000000 -0400
@@ -83,3 +83,14 @@ int selinux_string_to_sid(char *str, u32
 }
 EXPORT_SYMBOL_GPL(selinux_string_to_sid);
 
+int selinux_relabel_packet_permission(u32 sid)
+{
+	if (selinux_enabled) {
+		struct task_security_struct *tsec = current->security;
+		
+		return avc_has_perm(tsec->sid, sid, SECCLASS_PACKET,
+				    PACKET__RELABELTO, NULL);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(selinux_relabel_packet_permission);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
