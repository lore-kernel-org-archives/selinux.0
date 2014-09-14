Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sC009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:06 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so3077443wgg.9
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:13 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.11
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:12 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 01/20] libsepol: fix potential free of uninitialized pointer
Date: Sun, 14 Sep 2014 23:41:32 +0200
Message-Id: <1410730911-14512-2-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When using "gcc -O2 -Wall -Werror" to compile libsepol, the following
error happens:

  services.c: In function 'constraint_expr_eval_reason':
  services.c:820:2: error: 'answer_list' may be used uninitialized in this
  function [-Werror=maybe-uninitialized]
    free(answer_list);
    ^

Indeed, because of a goto statement in constraint_expr_eval_reason
function, "free(answer_list)" can be called before answer_list has been
initialized.

Fix this error by moving the definition of answer_list to the beginning
of constraint_expr_eval_reason.
---
 libsepol/src/services.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 44aa4972a5e3..a1a0b98c73da 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -417,6 +417,12 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
 	int rc = 0, x;
 	char *class_buf = NULL;
 
+	/*
+	 * The array of expression answer buffer pointers and counter.
+	 */
+	char **answer_list = NULL;
+	int answer_counter = 0;
+
 	class_buf = get_class_info(tclass, constraint, xcontext);
 	if (!class_buf) {
 		ERR(NULL, "failed to allocate class buffer");
@@ -686,13 +692,9 @@ mls_ops:
 	expr_counter = 0;
 
 	/*
-	 * The array of expression answer buffer pointers and counter.
 	 * Generate the same number of answer buffer entries as expression
 	 * buffers (as there will never be more).
 	 */
-	char **answer_list;
-	int answer_counter = 0;
-
 	answer_list = malloc(expr_count * sizeof(*answer_list));
 	if (!answer_list) {
 		ERR(NULL, "failed to allocate answer stack");
-- 
2.1.0
