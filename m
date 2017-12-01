Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB1LVosT000981
 for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2017 16:31:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 3ypSC86kC5z19Z3m
 for <selinux@tycho.nsa.gov>; Fri,  1 Dec 2017 21:31:48 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 3ypSC85Sszz19Z3j
 for <selinux@tycho.nsa.gov>; Fri,  1 Dec 2017 21:31:48 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5839161479
 for <selinux@tycho.nsa.gov>; Fri,  1 Dec 2017 21:31:41 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 01 Dec 2017 16:31:40 -0500
Message-ID: <151216389973.29858.4790300595820219259.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH v2] selinux: ensure the context is NUL terminated in
 security_context_to_sid_core()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

The syzbot/syzkaller automated tests found a problem in
security_context_to_sid_core() during early boot (before we load the
SELinux policy) where we could potentially feed context strings without
NUL terminators into the strcmp() function.

We already guard against this during normal operation (after the SELinux
policy has been loaded) by making a copy of the context strings and
explicitly adding a NUL terminator to the end.  The patch extends this
protection to the early boot case (no loaded policy) by moving the context
copy earlier in security_context_to_sid_core().

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/services.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 33cfe5d3d6cb..d05496deb229 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1413,27 +1413,25 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 	if (!scontext_len)
 		return -EINVAL;
 
+	/* Copy the string to allow changes and ensure a NUL terminator */
+	scontext2 = kmemdup_nul(scontext, scontext_len, gfp_flags);
+	if (!scontext2)
+		return -ENOMEM;
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
