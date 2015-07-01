Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t61KulYT011972
 for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2015 16:56:47 -0400
Received: by igblr2 with SMTP id lr2so106577599igb.0
 for <selinux@tycho.nsa.gov>; Wed, 01 Jul 2015 13:56:45 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2] libselinux: Fix file labels for regexes with metachars
Date: Wed,  1 Jul 2015 13:56:40 -0700
Message-Id: <1435784200-36822-1-git-send-email-jeffv@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

File labels assigned using the lookup_best_match() function do not
assign the best match if its regex contains metacharacters.

For non-exact regex matches, lookup_best_match() finds the closest match
by tracking the length of the matching prefix. Prefix match is tracked via
the prefix_len variable. This was previously calculated and set in
the spec_hasMetaChars() function. Commit 3cb6078 removed the
prefix_len calculation, this commit restores it.

v2 changes:
label_file.c - set prefix_len in load_mmap. Needed for binary file_contexts
files.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 libselinux/src/label_file.c | 2 ++
 libselinux/src/label_file.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 4faf808..05ddbe9 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -337,6 +337,8 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 			goto err;
 
 		spec->hasMetaChars = meta_chars;
+		if (spec->hasMetaChars)
+			spec->prefix_len = strlen(spec->regex_str);
 
 		/* Process regex and study_data entries */
 		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 73bcbba..30bc911 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -148,6 +148,7 @@ static inline void spec_hasMetaChars(struct spec *spec)
 	end = c + len;
 
 	spec->hasMetaChars = 0;
+	spec->prefix_len = len;
 
 	/* Look at each character in the RE specification string for a
 	 * meta character. Return when any meta character reached. */
@@ -164,6 +165,7 @@ static inline void spec_hasMetaChars(struct spec *spec)
 		case '(':
 		case '{':
 			spec->hasMetaChars = 1;
+			spec->prefix_len = c - spec->regex_str;
 			return;
 		case '\\':	/* skip the next character */
 			c++;
-- 
2.4.3.573.g4eafbef
