Message-ID: <4213C115.3030703@trustedcs.com>
Date: Wed, 16 Feb 2005 15:54:29 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
CC: Chad Hanson <chanson@TrustedCS.com>
Subject: [PATCH] audit validatetrans denials
Content-Type: multipart/mixed;
 boundary="------------030302090801060202000303"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030302090801060202000303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a patch that adds the auditing of denials caused by the 
validatetrans rules in the policy.  Look good?

Thanks,

-- 

Darrel

--------------030302090801060202000303
Content-Type: text/x-patch;
 name="validtrans_audit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="validtrans_audit.patch"

diff -ruNp linux-2.6-nsa-20050215/security/selinux/ss/services.c linux-2.6-20050216/security/selinux/ss/services.c
--- linux-2.6-nsa-20050215/security/selinux/ss/services.c	2005-01-27 16:48:31.000000000 -0600
+++ linux-2.6-20050216/security/selinux/ss/services.c	2005-02-16 09:36:40.612223188 -0600
@@ -38,6 +38,13 @@
 #include "services.h"
 #include "conditional.h"
 #include "mls.h"
+#ifdef CONFIG_AUDIT
+static const char *class_to_string[] = {
+#define S_(s) s,
+#include "class_to_string.h"
+#undef S_
+};
+#endif
 
 extern void selnl_notify_policyload(u32 seqno);
 unsigned int policydb_loaded_version;
@@ -417,6 +424,43 @@ int security_validate_transition(u32 old
 
 out:
 	POLICY_RDUNLOCK;
+
+	/* audit failures */
+	if (rc) {
+		int err;
+		char *context;
+		u32 context_len;
+		struct audit_buffer *ab;
+
+		ab = audit_log_start(current->audit_context);
+		if (!ab)
+			return rc; /* audit_panic has been called */
+		audit_log_format(ab, "avc:  denied validate_transition");
+ 		err = security_sid_to_context(oldsid, &context, &context_len);
+		if (err)
+			audit_log_format(ab, " oldsid=%d", oldsid);
+		else {
+			audit_log_format(ab, " oldcontext=%s", context);
+			kfree(context);
+		}
+		err = security_sid_to_context(newsid, &context, &context_len);
+		if (err)
+			audit_log_format(ab, " newsid=%d", newsid);
+		else {
+			audit_log_format(ab, " newcontext=%s", context);
+			kfree(context);
+		}
+		err = security_sid_to_context(tasksid, &context, &context_len);
+		if (err)
+			audit_log_format(ab, " tasksid=%d", tasksid);
+		else {
+			audit_log_format(ab, " taskcontext=%s", context);
+			kfree(context);
+		}
+		audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
+		audit_log_end(ab);
+	}
+
 	return rc;
 }
 

--------------030302090801060202000303--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
