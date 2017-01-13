Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0D5KsDH024575
 for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2017 00:20:54 -0500
Received: by mail-pf0-f178.google.com with SMTP id y143so25229670pfb.0
 for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2017 21:20:48 -0800 (PST)
From: Sandeep Patil <sspatil@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: replace all malloc + memset by calloc in android
 label backend.
Date: Thu, 12 Jan 2017 21:20:26 -0800
Message-Id: <20170113052026.22069-1-sspatil@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 libselinux/src/label_backends_android.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index 4d6ec86..6442104 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -200,10 +200,9 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			}
 
 			if (NULL == (data->spec_arr =
-				     malloc(sizeof(spec_t) * data->nspec)))
+				     calloc(data->nspec, sizeof(spec_t))))
 				goto finish;
 
-			memset(data->spec_arr, 0, sizeof(spec_t) * data->nspec);
 			maxnspec = data->nspec;
 			rewind(fp);
 		}
@@ -322,10 +321,9 @@ int selabel_property_init(struct selabel_handle *rec,
 {
 	struct saved_data *data;
 
-	data = (struct saved_data *)malloc(sizeof(*data));
+	data = (struct saved_data *)calloc(1, sizeof(*data));
 	if (!data)
 		return -1;
-	memset(data, 0, sizeof(*data));
 
 	rec->data = data;
 	rec->func_close = &closef;
@@ -340,10 +338,9 @@ int selabel_service_init(struct selabel_handle *rec,
 {
 	struct saved_data *data;
 
-	data = (struct saved_data *)malloc(sizeof(*data));
+	data = (struct saved_data *)calloc(1, sizeof(*data));
 	if (!data)
 		return -1;
-	memset(data, 0, sizeof(*data));
 
 	rec->data = data;
 	rec->func_close = &closef;
-- 
2.11.0.483.g087da7b7c-goog
