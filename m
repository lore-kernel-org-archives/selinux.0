Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5QAU7Yr030359
 for <selinux@tycho.nsa.gov>; Fri, 26 Jun 2015 06:30:07 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Fix if file_contexts not '\n' terminated
Date: Fri, 26 Jun 2015 11:29:56 +0100
Message-Id: <1435314596-14501-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If the last line of a file_contexts file is not '\n' terminated
it failed to read the entry and gave an invalid file type error.
read_spec_entries now handles this situation.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label_support.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index cf91dfa..e67d89a 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -57,6 +57,11 @@ int hidden read_spec_entries(char *line_buf, int num_args, ...)
 	len = strlen(line_buf);
 	if (line_buf[len - 1] == '\n')
 		line_buf[len - 1] = '\0';
+	else
+		/* Handle case if line not \n terminated by bumping
+		 * the len for the check below (as the line is NUL
+		 * terminated by getline(3)) */
+		len++;
 
 	buf_p = line_buf;
 	while (isspace(*buf_p))
-- 
2.1.0
