From: Sebastien Buisson <sbuisson.ddn@gmail.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Cc: serge@hallyn.com, james.l.morris@oracle.com, eparis@parisplace.org,
 sds@tycho.nsa.gov, paul@paul-moore.com,
 Sebastien Buisson <sbuisson@ddn.com>
Subject: [PATCH] selinux: add selinux_status_get_seq() function
Date: Wed, 12 Apr 2017 18:12:15 +0900
Message-Id: <1491988335-4181-1-git-send-email-sbuisson@ddn.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add selinux_status_get_seq() function to give access to sequence
number of current SELinux policy loaded to the rest of the kernel.

Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
---
 include/linux/selinux.h      |  7 +++++++
 security/selinux/ss/status.c | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index 44f4596..926f9f0 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -24,12 +24,19 @@
  * selinux_is_enabled - is SELinux enabled?
  */
 bool selinux_is_enabled(void);
+u32 selinux_status_get_seq(void);
 #else
 
 static inline bool selinux_is_enabled(void)
 {
 	return false;
 }
+
+static inline u32 selinux_status_get_seq(void)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY_SELINUX */
 
 #endif /* _LINUX_SELINUX_H */
diff --git a/security/selinux/ss/status.c b/security/selinux/ss/status.c
index d982365..a0670d3 100644
--- a/security/selinux/ss/status.c
+++ b/security/selinux/ss/status.c
@@ -124,3 +124,24 @@ void selinux_status_update_policyload(int seqno)
 	}
 	mutex_unlock(&selinux_status_lock);
 }
+
+/*
+ * selinux_status_get_seq
+ *
+ * It gets current sequence of policy loaded.
+ */
+u32 selinux_status_get_seq(void)
+{
+	struct selinux_kernel_status   *status;
+	u32				seq = 0;
+
+	mutex_lock(&selinux_status_lock);
+	if (selinux_status_page) {
+		status = page_address(selinux_status_page);
+		seq = status->sequence;
+	}
+	mutex_unlock(&selinux_status_lock);
+
+	return seq;
+}
+EXPORT_SYMBOL_GPL(selinux_status_get_seq);
-- 
1.8.3.1
