Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2T3eMdE011820
 for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2018 23:40:23 -0400
Received: by mail-qt0-f195.google.com with SMTP id j26so4898430qtl.11
 for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2018 20:40:18 -0700 (PDT)
Received: from localhost.localdomain (c-76-100-110-125.hsd1.md.comcast.net.
 [76.100.110.125])
 by smtp.gmail.com with ESMTPSA id b10sm3745189qtg.78.2018.03.28.20.40.17
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 28 Mar 2018 20:40:17 -0700 (PDT)
From: Yuli Khodorkovskiy <ykhodo@gmail.com>
To: selinux@tycho.nsa.gov
Date: Wed, 28 Mar 2018 20:40:02 -0700
Message-Id: <20180329034003.2231-2-ykhodo@gmail.com>
In-Reply-To: <20180329034003.2231-1-ykhodo@gmail.com>
References: <20180329034003.2231-1-ykhodo@gmail.com>
Subject: [PATCH v2 1/2] libselinux: verify file_contexts when using restorecon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In permissive mode, calling restorecon with a bad label in file_contexts
does not verify the label's existence in the loaded policy. This
results in any label successfully applying to a file, as long as the
file exists.

This issue has two assumptions:

1) file_contexts must be manually updated with the invalid label.
Running `semanage fcontext` will error when attempting to add
an invalid label to file_contexts.
2) the system must be in permissive. Although applying an invalid label
in enforcing gives an error and fails, successfully labeling a file with a
bad label could cause issues during policy development in permissive.

Instead, as each context is used, verify it is valid before blindly
applying the label. If an error with validation occurs in restorecon,
application of remaining valid labels will be uninterrupted as before.

Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>
---
 libselinux/src/label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 48f4d2d6..e642a97b 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -126,7 +126,7 @@ int selabel_validate(struct selabel_handle *rec,
 {
 	int rc = 0;
 
-	if (!rec->validating || contexts->validated)
+	if (contexts->validated)
 		goto out;
 
 	rc = selinux_validate(&contexts->ctx_raw);
-- 
2.14.3
