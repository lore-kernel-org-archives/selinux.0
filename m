From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 07/18] libselinux: label_file: drop useless ncomp field from label_file data
Date: Fri, 31 Aug 2012 10:49:43 -0700
Message-Id: <1346435394-1954-7-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The libselinux label_file backend counted the number of regexes which
had been compiled.  We didn't use it and it wasn't useful information.
Stop doing it.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 3 ---
 libselinux/src/label_file.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 9c0bfa0..0dc0332 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -148,8 +148,6 @@ static int compile_regex(struct saved_data *data, struct spec *spec, const char
 	if (spec->regcomp)
 		return 0; /* already done */
 
-	data->ncomp++; /* how many compiled regexes required */
-
 	/* Skip the fixed stem. */
 	reg_buf = spec->regex_str;
 	if (spec->stem_id >= 0)
@@ -377,7 +375,6 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	maxnspec = UINT_MAX / sizeof(struct spec);
 	for (pass = 0; pass < 2; pass++) {
 		data->nspec = 0;
-		data->ncomp = 0;
 
 		lineno = 0;
 		while (getline(&line_buf, &line_len, fp) > 0) {
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index de58d1e..560035d 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -33,7 +33,6 @@ struct saved_data {
 	 */
 	struct spec *spec_arr;
 	unsigned int nspec;
-	unsigned int ncomp;
 
 	/*
 	 * The array of regular expression stems.
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
