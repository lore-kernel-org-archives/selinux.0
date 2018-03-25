Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2PJZUBq024019
 for <selinux@tycho.nsa.gov>; Sun, 25 Mar 2018 15:35:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID16.oob.disa.mil (Postfix) with SMTP id 408SD66t8yzQ5Wj
 for <selinux@tycho.nsa.gov>; Sun, 25 Mar 2018 19:35:18 +0000 (UTC)
Received: from USFB3CPA02_EEMSG_MP24.eemsg.mil (unknown [192.168.16.19])
 by USFBF3ID16.oob.disa.mil (Postfix) with ESMTP id 408SD65zf3zQ5Wh
 for <selinux@tycho.nsa.gov>; Sun, 25 Mar 2018 19:35:18 +0000 (UTC)
Received: by mail-qk0-f196.google.com with SMTP id h14so18005389qkj.11
 for <selinux@tycho.nsa.gov>; Sun, 25 Mar 2018 12:35:18 -0700 (PDT)
Received: from localhost.localdomain ([172.58.184.117])
 by smtp.gmail.com with ESMTPSA id d199sm6142357qke.90.2018.03.25.12.35.14
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 25 Mar 2018 12:35:16 -0700 (PDT)
From: Yuli Khodorkovskiy <ykhodo@gmail.com>
To: selinux@tycho.nsa.gov
Date: Sun, 25 Mar 2018 12:34:55 -0700
Message-Id: <20180325193455.12140-1-ykhodo@gmail.com>
Subject: [PATCH] libselinux: verify file_contexts when using
 restorecon
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

Instead of the current behavior, mimic setfiles' -c flag, and verify the labels
against the loaded policy binary.

Behavior before patch:

$ sudo -s
$ setenforce 0
$ echo '/test.txt       --      system_u:object_r:foo_bar_baz:s0' >> /etc/selinux/targeted/contexts/files/file_contexts
$ restorecon -v /test.txt
Relabeled /test.txt from system_u:object_r:etc_runtime_t:s0 to system_u:object_r:foo_bar_baz:s0

Behavior after patch:

$ sudo -s
$ setenforce 0
$ echo '/test.txt       --      system_u:object_r:foo_bar_baz:s0' >> /etc/selinux/targeted/contexts/files/file_contexts
$ restorecon -v /test.txt
restorecon: /etc/selinux/targeted/contexts/files/file_contexts: line 6123 has invalid context system_u:object_r:foo_bar_baz:s0
Invalid argument

Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>
---
 policycoreutils/setfiles/setfiles.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index bc83c27b..ce1e4324 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -217,7 +217,7 @@ int main(int argc, char **argv)
 		 * Do not abort on errors during the file tree walk,
 		 * Do not try to track inode associations for conflict detection,
 		 * Follows mounts,
-		 * Does lazy validation of contexts upon use.
+		 * Validates all file contexts at init time.
 		 */
 		if (strcmp(base, RESTORECON))
 			fprintf(stderr, "Executed with unrecognized name (%s), defaulting to %s behavior.\n",
@@ -230,7 +230,7 @@ int main(int argc, char **argv)
 		r_opts.add_assoc = 0;
 		r_opts.xdev = 0;
 		r_opts.ignore_mounts = 0;
-		ctx_validate = 0;
+		ctx_validate = 1;
 		opts = ropts;
 
 		/* restorecon only:  silent exit if no SELinux.
-- 
2.14.3
