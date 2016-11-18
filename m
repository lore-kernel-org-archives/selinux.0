From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: normalize enforce values from the kernel
Date: Fri, 18 Nov 2016 09:52:06 -0500
Message-Id: <1479480726-2898-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Normalize enforce values received from the kernel via
/sys/fs/selinux/enforce or netlink selinux notifications
to ensure that we always return a 0 or 1 to userspace code.
selinux_status_getenforce(), which reads the enforce value
via the SELinux kernel status page (/sys/fs/selinux/status)
already normalizes its result, so we do not need to update it.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/avc_internal.c | 1 +
 libselinux/src/getenforce.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 26f3360..49cecc9 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -176,6 +176,7 @@ static int avc_netlink_process(void *buf)
 
 	case SELNL_MSG_SETENFORCE:{
 		struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
+		msg->val = !!msg->val;
 		avc_log(SELINUX_INFO,
 			"%s:  received setenforce notice (enforcing=%d)\n",
 			avc_prefix, msg->val);
diff --git a/libselinux/src/getenforce.c b/libselinux/src/getenforce.c
index 4fb516a..03d3abc 100644
--- a/libselinux/src/getenforce.c
+++ b/libselinux/src/getenforce.c
@@ -34,7 +34,7 @@ int security_getenforce(void)
 	if (sscanf(buf, "%d", &enforce) != 1)
 		return -1;
 
-	return enforce;
+	return !!enforce;
 }
 
 hidden_def(security_getenforce)
-- 
2.7.4
