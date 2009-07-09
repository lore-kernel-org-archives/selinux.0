Subject: [PATCH 3/3] Wrap SMACK and SELINUX audit data structs in ifdefs
From: Thomas Liu <tliu@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: chrisw@sous-sol.org, sds@tycho.nsa.gov, eparis@parisplace.org,
        jmorris@namei.org, etienne.basset@numericable.fr,
        casey@schaufler-ca.com
Content-Type: text/plain
Date: Thu, 09 Jul 2009 10:00:31 -0400
Message-Id: <1247148031.2276.11.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Wrapped the smack_audit_data and selinux_audit_data
structs in include/linux/lsm_audit.h in ifdefs so that the
union will always be the correct size.

Signed-off-by: Thomas Liu <tliu@redhat.com>
---

 include/linux/lsm_audit.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 40d1b84..a5514a3 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -68,6 +68,7 @@ struct common_audit_data {
 	} u;
 	/* this union contains LSM specific data */
 	union {
+#ifdef CONFIG_SECURITY_SMACK
 		/* SMACK data */
 		struct smack_audit_data {
 			const char *function;
@@ -76,6 +77,8 @@ struct common_audit_data {
 			char *request;
 			int result;
 		} smack_audit_data;
+#endif
+#ifdef CONFIG_SECURITY_SELINUX
 		/* SELinux data */
 		struct {
 			u32 ssid;
@@ -86,6 +89,7 @@ struct common_audit_data {
 			struct av_decision *avd;
 			int result;
 		} selinux_audit_data;
+#endif
 	};
 	/* these callback will be implemented by a specific LSM */
 	void (*lsm_pre_audit)(struct audit_buffer *, void *);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
