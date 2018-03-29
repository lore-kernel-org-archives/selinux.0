Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2T3eMdF011820
 for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2018 23:40:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 40BVrN4kqbz1pFTb
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 03:40:20 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 40BVrN3rdnz1pFV5
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 03:40:20 +0000 (UTC)
Received: by mail-qt0-f194.google.com with SMTP id w12so4924523qti.4
 for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2018 20:40:19 -0700 (PDT)
Received: from localhost.localdomain (c-76-100-110-125.hsd1.md.comcast.net.
 [76.100.110.125])
 by smtp.gmail.com with ESMTPSA id b10sm3745189qtg.78.2018.03.28.20.40.18
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 28 Mar 2018 20:40:18 -0700 (PDT)
From: Yuli Khodorkovskiy <ykhodo@gmail.com>
To: selinux@tycho.nsa.gov
Date: Wed, 28 Mar 2018 20:40:03 -0700
Message-Id: <20180329034003.2231-3-ykhodo@gmail.com>
In-Reply-To: <20180329034003.2231-1-ykhodo@gmail.com>
References: <20180329034003.2231-1-ykhodo@gmail.com>
Subject: [PATCH v2 2/2] libselinux: echo line number of bad label in
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
index e642a97b..d9a58ce9 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -143,7 +143,7 @@ static int selabel_fini(struct selabel_handle *rec,
 			    struct selabel_lookup_rec *lr,
 			    int translating)
 {
-	if (compat_validate(rec, lr, rec->spec_file, 0))
+	if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
 		return -1;
 
 	if (translating && !lr->ctx_trans &&
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index aa576d8e..4780ae48 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -472,6 +472,7 @@ static inline int process_line(struct selabel_handle *rec,
 	spec_arr[nspec].mode = 0;
 
 	spec_arr[nspec].lr.ctx_raw = context;
+	spec_arr[nspec].lr.lineno = lineno;
 
 	/*
 	 * bump data->nspecs to cause closef() to cover it in its free
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index c55efb75..0e020557 100644
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
