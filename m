Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7SKl7Yj017073
 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2014 16:47:07 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] policycoreutils: mcstrans: use string_to_av_perm() to
 calculate permission access vector
Date: Thu, 28 Aug 2014 16:47:03 -0400
Message-ID: <1409258823-19823-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

mcstrans still uses CONTEXT__CONTAINS from av_permissions.h to calculate
a permission access vector. However, av_permissions.h was deprecated, so
it does not have access to the constant. This updates mcstrans to use
string_to_av_perm() to get the value for context contains.

Reported-by: Sven Vermeulen <sven.vermeulen@siphos.be>
Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 policycoreutils/mcstrans/src/mcscolor.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/mcstrans/src/mcscolor.c b/policycoreutils/mcstrans/src/mcscolor.c
index fdb7048..66f99d2 100644
--- a/policycoreutils/mcstrans/src/mcscolor.c
+++ b/policycoreutils/mcstrans/src/mcscolor.c
@@ -78,11 +78,12 @@ void finish_context_colors(void) {
 static int check_dominance(const char *pattern, const char *raw) {
 	security_context_t ctx;
 	context_t con;
-	unsigned int bit = CONTEXT__CONTAINS;
 	struct av_decision avd;
 	int rc = -1;
 	context_t my_tmp;
 	const char *raw_range;
+	security_class_t context_class = string_to_security_class("context");
+	access_vector_t context_contains_perm = string_to_av_perm(context_class, "contains");
 
 	con = context_new(raw);
 	if (!con)
@@ -108,11 +109,11 @@ static int check_dominance(const char *pattern, const char *raw) {
 	if (!raw)
 		goto out;
 
-	rc = security_compute_av_raw(ctx, (security_context_t)raw, string_to_security_class("context"), bit, &avd);
+	rc = security_compute_av_raw(ctx, (security_context_t)raw, context_class, context_contains_perm, &avd);
 	if (rc)
 		goto out;
 
-	rc = (bit & avd.allowed) != bit;
+	rc = (context_contains_perm & avd.allowed) != context_contains_perm;
 out:
 	free(ctx);
 	context_free(my_tmp);
-- 
1.9.3
