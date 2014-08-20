Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7KEQmVY012098
 for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2014 10:26:50 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7KEQrs5009830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2014 10:26:53 -0400
Received: from redsox.boston.devel.redhat.com (redsox.boston.devel.redhat.com
 [10.19.60.53])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 s7KEQqpN017316
 for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2014 10:26:53 -0400
Message-ID: <53F4B02C.90701@redhat.com>
Date: Wed, 20 Aug 2014 10:26:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Currently we can end up with different permissions on the compiled
 file_context regex files than the original.
Content-Type: multipart/mixed; boundary="------------080404010003060006080408"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------080404010003060006080408
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



--------------080404010003060006080408
Content-Type: text/x-patch;
 name="0001-Compiled-file-context-files-and-the-original-should-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Compiled-file-context-files-and-the-original-should-.pa";
 filename*1="tch"

>From dc822395634647dfc25c611261fd74f30962e668 Mon Sep 17 00:00:00 2001
From: Dan Walsh <dwalsh@redhat.com>
Date: Sat, 16 Aug 2014 07:37:42 -0400
Subject: [PATCH] Compiled file context files and the original should have the
 same permissions

Currently the compiled file context files can end up with different
permissions then the original.  This can lead to non priv users
not being able to read the compiled versions.
---
 libselinux/utils/sefcontext_compile.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 0adc968..9618989 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -4,6 +4,9 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 
 #include <linux/limits.h>
 
@@ -323,6 +326,7 @@ int main(int argc, char *argv[])
 	int rc;
 	char *tmp= NULL;
 	int fd;
+	struct stat buf;
 
 	if (argc != 2) {
 		fprintf(stderr, "usage: %s input_file\n", argv[0]);
@@ -333,6 +337,11 @@ int main(int argc, char *argv[])
 
 	path = argv[1];
 
+	if (stat(path, &buf) < 0) {
+		fprintf(stderr, "Can not stat: %s: %m\n", argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
 	rc = process_file(&data, path);
 	if (rc < 0)
 		return rc;
@@ -352,6 +361,12 @@ int main(int argc, char *argv[])
 	if (fd < 0)
 		goto err;
 
+	rc = fchmod(fd, buf.st_mode);
+	if (rc < 0) {
+		perror("fchmod failed to set permission on compiled regexs");
+		goto err;
+	}
+
 	rc = write_binary_file(&data, fd);
 
 	if (rc < 0)
-- 
2.0.4


--------------080404010003060006080408--
