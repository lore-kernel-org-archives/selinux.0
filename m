Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAHGafFq007781
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 11:36:42 -0500
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAHGcijP024630
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 16:38:45 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: Manoj Srivastava <srivasta@debian.org>
Subject: [PATCH] [typo-fix]: cannnot -> cannot and suport -> support
Date: Tue, 17 Nov 2009 10:27:57 -0600
Message-Id: <1258475277-10977-1-git-send-email-srivasta@golden-gryphon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Manoj Srivastava <srivasta@debian.org>

This was reported after a lintian check found this on any package
linked with libsepol.  Closes: #556390

Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 src/write.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/write.c b/src/write.c
index 9906e35..00c605f 100644
--- a/src/write.c
+++ b/src/write.c
@@ -1000,7 +1000,7 @@ static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 				buf[items++] = cpu_to_le32(typdatum->flags);
 			else if (typdatum->flags & TYPE_FLAGS_PERMISSIVE)
 				WARN(fp->handle, "Warning! Module policy "
-				     "version %d cannnot suport permissive "
+				     "version %d cannot support permissive "
 				     "types, but one was defined",
 				     p->policyvers);
 		}
-- 
1.6.5.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
