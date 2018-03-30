Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2U0Hcw6029205
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 20:17:38 -0400
Received: by mail-qt0-f196.google.com with SMTP id l18so8064032qtj.1
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 17:17:33 -0700 (PDT)
Received: from localhost.localdomain (c-76-100-110-125.hsd1.md.comcast.net.
 [76.100.110.125])
 by smtp.gmail.com with ESMTPSA id i11sm5824682qtc.30.2018.03.29.17.17.31
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Mar 2018 17:17:31 -0700 (PDT)
From: Yuli Khodorkovskiy <ykhodo@gmail.com>
To: selinux@tycho.nsa.gov
Date: Thu, 29 Mar 2018 17:16:42 -0700
Message-Id: <20180330001642.2374-3-ykhodo@gmail.com>
In-Reply-To: <20180330001642.2374-1-ykhodo@gmail.com>
References: <20180330001642.2374-1-ykhodo@gmail.com>
Subject: [PATCH v3 2/2] libselinux: echo line number of bad label in
 selabel_fini()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Keep track of line numbers for each file context in
selabel_handle. If an error occurs in selabel_fini(), the
line number of an invalid file context is echoed to the user.

Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>
---
 libselinux/src/label.c          | 2 +-
 libselinux/src/label_file.h     | 1 +
 libselinux/src/label_internal.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index c510edc1..591815a7 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -142,7 +142,7 @@ static int selabel_fini(struct selabel_handle *rec,
 			    struct selabel_lookup_rec *lr,
 			    int translating)
 {
-	if (compat_validate(lr, rec->spec_file, 0))
+	if (compat_validate(lr, rec->spec_file, lr->lineno))
 		return -1;
 
 	if (translating && !lr->ctx_trans &&
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 9e52a3c4..3f9ce53b 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -472,6 +472,7 @@ static inline int process_line(struct selabel_handle *rec,
 	spec_arr[nspec].mode = 0;
 
 	spec_arr[nspec].lr.ctx_raw = context;
+	spec_arr[nspec].lr.lineno = lineno;
 
 	/*
 	 * bump data->nspecs to cause closef() to cover it in its free
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 75451858..b0d05882 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -73,6 +73,7 @@ struct selabel_lookup_rec {
 	char * ctx_raw;
 	char * ctx_trans;
 	int validated;
+	unsigned lineno;
 };
 
 struct selabel_handle {
-- 
2.14.3
