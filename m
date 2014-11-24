Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAOGDlRq005717
 for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2014 11:13:49 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage: close hll file descriptors
Date: Mon, 24 Nov 2014 11:13:13 -0500
Message-ID: <1416845593-2803-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stops leaking of file descriptors to things like load_policy and
setfiles.

Reported-by: Sven Vermeulen <sven.vermeulen@siphos.be>
Signed-off-by: Steve Lawrence <slawrence@tresys.com>
Reviewed-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libsemanage/src/direct_api.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index c2ac938..b0ed338 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -837,7 +837,8 @@ static int semanage_compile_hll(semanage_handle_t *sh,
 	ssize_t hll_data_len = 0;
 	ssize_t bzip_status;
 	int status = 0;
-	int i, compressed, in_fd;
+	int i, compressed;
+	int in_fd = -1;
 	size_t cil_data_len;
 	size_t err_data_len;
 
@@ -891,6 +892,9 @@ static int semanage_compile_hll(semanage_handle_t *sh,
 			goto cleanup;
 		}
 
+		if (in_fd >= 0) close(in_fd);
+		in_fd = -1;
+
 		status = semanage_pipe_data(sh, compiler_path, hll_data, (size_t)hll_data_len, &cil_data, &cil_data_len, &err_data, &err_data_len);
 		if (err_data_len > 0) {
 			for (start = end = err_data; end < err_data + err_data_len; end++) {
@@ -935,6 +939,7 @@ static int semanage_compile_hll(semanage_handle_t *sh,
 
 cleanup:
 	if (hll_data_len > 0) munmap(hll_data, hll_data_len);
+	if (in_fd >= 0) close(in_fd);
 	free(cil_data);
 	free(err_data);
 	free(compiler_path);
-- 
1.9.3
