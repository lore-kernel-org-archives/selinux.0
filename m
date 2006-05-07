Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k47FYKcR032098
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 11:34:20 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k47FYJiA004331
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 15:34:19 GMT
Received: from megaweapon.nightmoose.net (HELO d.namei) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail1.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 7 May 2006 15:34:18 -0000
Date: Sun, 7 May 2006 11:34:17 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: netdev@vger.kernel.org, netfilter-devel@lists.samba.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: [RFC][SECMARK 02/08] Export selinux_string_to_sid from SELinux
In-Reply-To: <Pine.LNX.4.64.0605071104590.8588@d.namei>
Message-ID: <Pine.LNX.4.64.0605071133170.8588@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch exports adds a new function to the in-kernel
SELinux API: selinux_string_to_sid().  It maps a text
security context to an SELiux security ID (SID).


Signed-off-by: James Morris <jmorris@namei.org>

---

 include/linux/selinux.h    |   16 ++++++++++++++++
 security/selinux/exports.c |   11 +++++++++++
 2 files changed, 27 insertions(+)

diff -purN -X dontdiff linux-2.6.17-rc2-mm1.p/include/linux/selinux.h linux-2.6.17-rc2-mm1.w/include/linux/selinux.h
--- linux-2.6.17-rc2-mm1.p/include/linux/selinux.h	2006-04-27 10:44:26.000000000 -0400
+++ linux-2.6.17-rc2-mm1.w/include/linux/selinux.h	2006-04-28 00:53:27.000000000 -0400
@@ -118,6 +118,16 @@ void selinux_get_ipc_sid(const struct ke
  */
 void selinux_get_task_sid(struct task_struct *tsk, u32 *sid);
 
+/**
+ *     selinux_string_to_sid - map a security context string to a security ID
+ *     @str: the security context string to be mapped
+ *     @sid: ID value returned via this.
+ *
+ *     Returns 0 if successful, with the SID stored in sid.  A value
+ *     of zero for sid indicates no SID could be determined (but no error
+ *     occurred).
+ */
+int selinux_string_to_sid(char *str, u32 *sid);
 
 #else
 
@@ -172,6 +182,12 @@ static inline void selinux_get_task_sid(
 	*sid = 0;
 }
 
+static inline int selinux_string_to_sid(const char *str, u32 *sid)
+{
+       *sid = 0;
+       return 0;
+}
+
 #endif	/* CONFIG_SECURITY_SELINUX */
 
 #endif /* _LINUX_SELINUX_H */
diff -purN -X dontdiff linux-2.6.17-rc2-mm1.p/security/selinux/exports.c linux-2.6.17-rc2-mm1.w/security/selinux/exports.c
--- linux-2.6.17-rc2-mm1.p/security/selinux/exports.c	2006-04-27 10:44:26.000000000 -0400
+++ linux-2.6.17-rc2-mm1.w/security/selinux/exports.c	2006-04-28 00:51:25.000000000 -0400
@@ -72,3 +72,14 @@ void selinux_get_task_sid(struct task_st
 	*sid = 0;
 }
 
+int selinux_string_to_sid(char *str, u32 *sid)
+{
+	if (selinux_enabled)
+		return security_context_to_sid(str, strlen(str), sid);
+	else {
+		*sid = 0;
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(selinux_string_to_sid);
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
