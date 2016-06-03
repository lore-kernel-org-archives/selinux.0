Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u53FIGdF016707
 for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2016 11:18:16 -0400
Received: by mail-qg0-f43.google.com with SMTP id p34so13234734qgp.1
 for <selinux@tycho.nsa.gov>; Fri, 03 Jun 2016 08:18:11 -0700 (PDT)
From: Joshua Brindle <brindle@quarksecurity.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Correctly detect unknown classes in
 sepol_string_to_security_class
Date: Fri,  3 Jun 2016 11:17:56 -0400
Message-Id: <1464967076-24170-1-git-send-email-brindle@quarksecurity.com>
In-Reply-To: <1464966566-14597-2-git-send-email-brindle@quarksecurity.com>
References: <1464966566-14597-2-git-send-email-brindle@quarksecurity.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Bail before running off the end of the class index

Change-Id: I47c4eaac3c7d789f8d85047e34e37e3f0bb38b3a
Signed-off-by: Joshua Brindle <brindle@quarksecurity.com>
---
 libsepol/src/services.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index d64a8e8..665fcaa 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1155,7 +1155,7 @@ int hidden sepol_string_to_security_class(const char *class_name,
 	char *class = NULL;
 	sepol_security_class_t id;
 
-	for (id = 1;; id++) {
+	for (id = 1; id <= policydb->p_classes.nprim; id++) {
 		class = policydb->p_class_val_to_name[id - 1];
 		if (class == NULL) {
 			ERR(NULL, "could not convert %s to class id", class_name);
@@ -1166,6 +1166,8 @@ int hidden sepol_string_to_security_class(const char *class_name,
 			return STATUS_SUCCESS;
 		}
 	}
+	ERR(NULL, "unrecognized class %s", class_name);
+	return -EINVAL;
 }
 
 /*
-- 
2.1.0
