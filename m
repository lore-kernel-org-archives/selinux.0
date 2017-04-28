Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3SD5TXU031942
 for <selinux@tycho.nsa.gov>; Fri, 28 Apr 2017 09:05:29 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH V2] libselinux: Add permissive= entry to avc audit log
Date: Fri, 28 Apr 2017 14:05:16 +0100
Message-Id: <20170428130516.4021-1-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add audit log entry to specify whether the decision was made in
permissive mode/permissive domain or enforcing mode.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 changes: Remove utilities and follow the kernel way of detecting
whether permissive or not.

 libselinux/src/avc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index b1ec57f..96b2678 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -723,6 +723,10 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
 
 	log_append(avc_audit_buf, " ");
 	avc_dump_query(ssid, tsid, tclass);
+
+	if (denied)
+		log_append(avc_audit_buf, " permissive=%u", result ? 0 : 1);
+
 	log_append(avc_audit_buf, "\n");
 	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
 
-- 
2.9.3
