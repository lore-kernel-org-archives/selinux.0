Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2SLgbIQ030851
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 17:42:42 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 14A035646B8
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 23:42:40 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/7] libsemanage: do not close uninitialized file descriptors
Date: Tue, 28 Mar 2017 23:41:50 +0200
Message-Id: <20170328214152.17545-5-nicolas.iooss@m4x.org>
In-Reply-To: <20170328214152.17545-1-nicolas.iooss@m4x.org>
References: <20170328214152.17545-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When pipe() fails in semanage_pipe_data(), this function closes all file
descriptors in variables output_fd, err_fd and input_fd even when they
have not been initialized. Fix this by initializing the file descriptors
to -1.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/direct_api.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index c23494bb4270..568732355f54 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -705,9 +705,9 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len, int
 
 static int semanage_pipe_data(semanage_handle_t *sh, char *path, char *in_data, size_t in_data_len, char **out_data, size_t *out_data_len, char **err_data, size_t *err_data_len)
 {
-	int input_fd[2];
-	int output_fd[2];
-	int err_fd[2];
+	int input_fd[2] = {-1, -1};
+	int output_fd[2] = {-1, -1};
+	int err_fd[2] = {-1, -1};
 	pid_t pid;
 	char *data_read = NULL;
 	char *err_data_read = NULL;
-- 
2.12.0
