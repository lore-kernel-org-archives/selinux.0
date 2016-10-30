Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9ULRh6U004344
 for <selinux@tycho.nsa.gov>; Sun, 30 Oct 2016 17:27:43 -0400
Received: from eversmanni.numericable.fr (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E92EF564864
 for <selinux@tycho.nsa.gov>; Sun, 30 Oct 2016 22:27:40 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] policycoreutils: semodule_package: do not fail with an
 empty fc file
Date: Sun, 30 Oct 2016 22:27:22 +0100
Message-Id: <20161030212722.24743-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When running sepolgen tests on a Linux 4.7 kernel, one test fails with
the following message:

    /usr/bin/semodule_package:  Failed to mmap
    tmp/module_compile_test.mod.fc:  Invalid argument

The .fc file is empty, which is why it cannot be used with mmap().
Anyway the current code supports empty files (with if() conditions in
main()) so do not try to mmap an empty file in file_to_data().

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---

While at it, it seems that neither seusersdata nor user_extradata are
unmapped at the end of main(). As this does not cause a test to fail
I will not send a patch to fix this.

 policycoreutils/semodule_package/semodule_package.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/policycoreutils/semodule_package/semodule_package.c b/policycoreutils/semodule_package/semodule_package.c
index d2a5fd07bd71..e472054826a3 100644
--- a/policycoreutils/semodule_package/semodule_package.c
+++ b/policycoreutils/semodule_package/semodule_package.c
@@ -72,6 +72,10 @@ static int file_to_data(const char *path, char **data, size_t * len)
 			path, strerror(errno));
 		goto err;
 	}
+	if (!sb.st_size) {
+		*len = 0;
+		return 0;
+	}
 
 	*data = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (*data == MAP_FAILED) {
-- 
2.10.1
