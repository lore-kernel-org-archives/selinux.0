Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o52Ip3PV011278
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2010 14:51:03 -0400
Received: from columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o52IoIYR012335
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2010 18:50:18 GMT
Received: from localhost.localdomain (f12 [127.0.0.1])
	by columbia.tresys.com (Postfix) with ESMTP id 2637B36C11
	for <selinux@tycho.nsa.gov>; Wed,  2 Jun 2010 14:49:02 -0400 (EDT)
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] [PATCH] Remove duplicate slashes in paths in selabel_lookup
Date: Wed,  2 Jun 2010 14:49:01 -0400
Message-Id: <1275504541-10499-1-git-send-email-csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch simply removes duplicate slashes (meaning "//") from
pathnames passed into selabel_lookup. It does not do a full
realpath() calculation (e.g. following symlinks, etc.), as the
client should really do that before calling into libselinux.

Signed-off-by: Chad Sellers <csellers@tresys.com>
---
 libselinux/src/label_file.c |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 509b033..937e509 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -584,13 +584,34 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 	spec_t *spec_arr = data->spec_arr;
 	int i, rc, file_stem;
 	mode_t mode = (mode_t)type;
-	const char *buf = key;
+	const char *buf;
+	struct selabel_lookup_rec *ret = NULL;
+	char *clean_key = NULL;
+	const char *prev_slash, *next_slash;
+	unsigned int sofar = 0;
 
 	if (!data->nspec) {
 		errno = ENOENT;
-		return NULL;
+		goto finish;
+	}
+
+	/* Remove duplicate slashes */
+	if ((next_slash = strstr(key, "//"))) {
+		clean_key = malloc(strlen(key) + 1);
+		if (!clean_key)
+			goto finish;
+		prev_slash = key;
+		while (next_slash) {
+			memcpy(clean_key + sofar, prev_slash, next_slash - prev_slash);
+			sofar += next_slash - prev_slash;
+			prev_slash = next_slash + 1;
+			next_slash = strstr(prev_slash, "//");
+		}
+		strcpy(clean_key + sofar, prev_slash);
+		key = clean_key;
 	}
 
+	buf = key;
 	file_stem = find_stem_from_file(data, &buf);
 	mode &= S_IFMT;
 
@@ -608,7 +629,7 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 		    && (!mode || !spec_arr[i].mode
 			|| mode == spec_arr[i].mode)) {
 			if (compile_regex(data, &spec_arr[i], NULL) < 0)
-				return NULL;
+				goto finish;
 			if (spec_arr[i].stem_id == -1)
 				rc = regexec(&spec_arr[i].regex, key, 0, 0, 0);
 			else
@@ -621,17 +642,21 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 			if (rc == REG_NOMATCH)
 				continue;
 			/* else it's an error */
-			return NULL;
+			goto finish;
 		}
 	}
 
 	if (i < 0 || strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
 		/* No matching specification. */
 		errno = ENOENT;
-		return NULL;
+		goto finish;
 	}
 
-	return &spec_arr[i].lr;
+	ret = &spec_arr[i].lr;
+
+finish:
+	free(clean_key);
+	return ret;
 }
 
 static void stats(struct selabel_handle *rec)
-- 
1.6.5.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
