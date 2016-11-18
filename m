Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAILw9BP031575
 for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2016 16:58:09 -0500
Received: by mail-pg0-f43.google.com with SMTP id x23so104150507pgx.1
 for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2016 13:58:08 -0800 (PST)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] label_file.h: actually use the results of compat_validate
Date: Fri, 18 Nov 2016 13:58:01 -0800
Message-Id: <1479506281-69690-1-git-send-email-nnk@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

process_line called compat_validate, but never actually looked at the
return value. When an invalid entry is found, a warning is printed, but
since the upper layers of the code don't see the error, validation
appears to succeed.

Steps to reproduce on Android:

1) Edit system/sepolicy/private/file_contexts and create an entry with
an invalid label.
2) Recompile Android, which executes out/host/linux-x86/bin/checkfc to
check if file_contexts is valid.

Expected: Compile failure.
Actual: Compile succeeds with warnings.

Change-Id: I20fa18c7b11b5ffdd243c3274bedc4518431e1fb
---
 libselinux/src/label_file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 00c0a5c..4ac64d5 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -467,7 +467,7 @@ static inline int process_line(struct selabel_handle *rec,
 	spec_hasMetaChars(&spec_arr[nspec]);
 
 	if (strcmp(context, "<<none>>") && rec->validating)
-		compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
+		return compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
 
 	return 0;
 }
-- 
2.8.0.rc3.226.g39d4020
