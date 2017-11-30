Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAUGqUUZ014974
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 11:52:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E06961D05
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 16:52:23 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 30 Nov 2017 11:52:22 -0500
Message-ID: <151206074183.32567.881282052709289967.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux: ensure the context is NULL terminated in
 security_context_to_sid_core()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

The syzbot/syzkaller automated tests found a problem in
security_context_to_sid_core() during early boot (before we load the
SELinux policy) where we could potentially feed context strings without
NULL terminators into the strcmp() function.

We already guard against this during normal operation (after the SELinux
policy has been loaded) by making a copy of the context strings and
explicitly adding a NULL terminator to the end.  The patch extends this
protection to the early boot case (no loaded policy) by moving the context
copy earlier in security_context_to_sid_core().

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/services.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 33cfe5d3d6cb..6ec4cdc8af8f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1413,27 +1413,27 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 	if (!scontext_len)
 		return -EINVAL;
 
+	/* Copy the string to allow changes and ensure a NULL terminator */
+	scontext2 = kmalloc(scontext_len + 1, gfp_flags);
+	if (!scontext2)
+		return -ENOMEM;
+	memcpy(scontext2, scontext, scontext_len);
+	scontext2[scontext_len] = 0;
+
 	if (!ss_initialized) {
 		int i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
-			if (!strcmp(initial_sid_to_string[i], scontext)) {
+			if (!strcmp(initial_sid_to_string[i], scontext2)) {
 				*sid = i;
-				return 0;
+				goto out;
 			}
 		}
 		*sid = SECINITSID_KERNEL;
-		return 0;
+		goto out;
 	}
 	*sid = SECSID_NULL;
 
-	/* Copy the string so that we can modify the copy as we parse it. */
-	scontext2 = kmalloc(scontext_len + 1, gfp_flags);
-	if (!scontext2)
-		return -ENOMEM;
-	memcpy(scontext2, scontext, scontext_len);
-	scontext2[scontext_len] = 0;
-
 	if (force) {
 		/* Save another copy for storing in uninterpreted form */
 		rc = -ENOMEM;
