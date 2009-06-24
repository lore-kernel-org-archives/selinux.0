Subject: [PATCH -v2] selinux: clean up avc node cache when disabling selinux
From: Thomas Liu <tliu@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
In-Reply-To: <1245880456.26725.5.camel@Ares>
References: <1245880456.26725.5.camel@Ares>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 17:58:05 -0400
Message-Id: <1245880685.27271.2.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added a call to free the avc_node_cache when inside selinux_disable because
it should not waste resources allocated during avc_init if SELinux is disabled
and the cache will never be used.

Signed-off-by: Thomas Liu <tliu@redhat.com>
---
diff -uprN -X kernel-vanilla/Documentation/dontdiff kernel-vanilla/security/selinux/avc.c kernel/security/selinux/avc.c
--- kernel-vanilla/security/selinux/avc.c	2009-06-24 15:51:29.227941185 -0400
+++ kernel/security/selinux/avc.c	2009-06-24 17:46:30.292941891 -0400
@@ -970,3 +970,9 @@ u32 avc_policy_seqno(void)
 {
 	return avc_cache.latest_notif;
 }
+
+void avc_disable(void)
+{
+	if (avc_node_cachep)
+		kmem_cache_destroy(avc_node_cachep);
+}
diff -uprN -X kernel-vanilla/Documentation/dontdiff kernel-vanilla/security/selinux/hooks.c kernel/security/selinux/hooks.c
--- kernel-vanilla/security/selinux/hooks.c	2009-06-24 15:51:29.229939614 -0400
+++ kernel/security/selinux/hooks.c	2009-06-24 16:13:14.828941026 -0400
@@ -5678,6 +5678,9 @@ int selinux_disable(void)
 	selinux_disabled = 1;
 	selinux_enabled = 0;
 
+	/* Try to destroy the avc node cache */
+	avc_disable();
+
 	/* Reset security_ops to the secondary module, dummy or capability. */
 	security_ops = secondary_ops;
 
diff -uprN -X kernel-vanilla/Documentation/dontdiff kernel-vanilla/security/selinux/include/avc.h kernel/security/selinux/include/avc.h
--- kernel-vanilla/security/selinux/include/avc.h	2009-06-24 15:51:29.230938689 -0400
+++ kernel/security/selinux/include/avc.h	2009-06-24 17:46:42.540941620 -0400
@@ -134,6 +134,9 @@ void avc_dump_av(struct audit_buffer *ab
 int avc_get_hash_stats(char *page);
 extern unsigned int avc_cache_threshold;
 
+/* Attempt to free avc node cache */
+void avc_disable(void);
+
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
 DECLARE_PER_CPU(struct avc_cache_stats, avc_cache_stats);
 #endif



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
