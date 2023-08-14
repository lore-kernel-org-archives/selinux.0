Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F125BC04FDF
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjHNNVO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjHNNUz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC310DE
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c4923195dso588535266b.2
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019246; x=1692624046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8nTYQ0/hIFZJNZrMpjQuMCmggV7Ae4denN2XBUk8J8=;
        b=VIR78ilkKepLiwf2XVEpXrmPsZxcinUnXi4vmwv+P/QJfBKTrYb+G1VRE4jFpVXdZs
         q6s5mmVMETMITv6ebVJCqq168AjAAbdOtAIfRbcBPq52wmW6rQnf7TfiH1kfNcq9h4rD
         nrPEPK7Dvc1okUjrLW8YUJDOHxQ7WJK0GzHHDF/hjDf4T2luP5Bt0Djq6NkT5YCy9PaN
         6BuFuUrPWpoenNeKYu8oX0lRvY122tPBUPQzPq9RpY8R/OG3dobjZi89FG8zAClGCUWU
         ksUH+Y3SfY04wzaDaW8Y/B1v56J0ZUS5TE6VVAzOvmAlheSFd5vb+nBLi1wiU1gz30zU
         JUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019246; x=1692624046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8nTYQ0/hIFZJNZrMpjQuMCmggV7Ae4denN2XBUk8J8=;
        b=GnnCZd0fUhIZYNhZIwU38aKVUpFzlYKSFY/GYHxtTmbDlhaprmYnX/0Nkgc0Fy+2QK
         aI3mxhDzXAEaXBEP0qaD/G6Y8twcvMWaKjDwnl/MLm41H2DsbqQdPHP1uub/bnx3OlXs
         ec+nD1amFqp7Et77GaDPbLZ4GkdXEPD5BH+PzQdLYMSpNnJVgp3UTTzVk4wiadeb1/CM
         MrQ7WGliTD6jWQjPZpG1t2nuUSl0rRZd3COdggjCvbNG1OeEoEtwCf6xHPBB8slg2wLe
         TpoYddacO0oL7A7xtFxZnLEkKuzjQnuaiUjxizjXH4ZTcU/PvT3qdbciQCstZcrWbHc3
         3fbg==
X-Gm-Message-State: AOJu0YwHP7B57B6oi2vb2g42vu2u0+3m1568qFcuNp7E4aSdXNnae+NV
        L/aiUGtWQ+TxBARNphVmUk7EwXMywhCi6AoJFyM=
X-Google-Smtp-Source: AGHT+IH5au9XceKK4sddMm1iZgoa5Pp6WcpSocKALWjJdzu5Y4fRYII3/U2gUPf5bGZVwJowQaW+bA==
X-Received: by 2002:a17:906:cc4e:b0:99c:e38d:e484 with SMTP id mm14-20020a170906cc4e00b0099ce38de484mr8090958ejb.6.1692019245830;
        Mon, 14 Aug 2023 06:20:45 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:45 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 10/27] libselinux: introduce selabel_nuke
Date:   Mon, 14 Aug 2023 15:20:08 +0200
Message-Id: <20230814132025.45364-11-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Introduce a helper to remove SELinux file contexts.

Mainly for testing label operations and only for SELinux disabled
systems, since removing file contexts is not supported by SELinux.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/.gitignore     |   1 +
 libselinux/utils/selabel_nuke.c | 134 ++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100644 libselinux/utils/selabel_nuke.c

diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index b3311360..a92e1e94 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -20,6 +20,7 @@ selabel_digest
 selabel_get_digests_all_partial_matches
 selabel_lookup
 selabel_lookup_best_match
+selabel_nuke
 selabel_partial_match
 selinux_check_securetty_context
 selinuxenabled
diff --git a/libselinux/utils/selabel_nuke.c b/libselinux/utils/selabel_nuke.c
new file mode 100644
index 00000000..b6a2df66
--- /dev/null
+++ b/libselinux/utils/selabel_nuke.c
@@ -0,0 +1,134 @@
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <linux/magic.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+#include <unistd.h>
+
+#include <selinux/selinux.h>
+
+
+#define XATTR_NAME_SELINUX "security.selinux"
+
+
+static void usage(const char *progname)
+{
+	fprintf(stderr, "usage: %s [-nrv] <path>\n", progname);
+}
+
+static void nuke(int atfd, const char *path, const char *fullpath, bool dry_run, bool recursive, bool verbose)
+{
+	ssize_t ret;
+	int fd, rc;
+	DIR *dir;
+
+	ret = lgetxattr(fullpath, XATTR_NAME_SELINUX, NULL, 0);
+	if (ret <= 0) {
+		if (errno != ENODATA && errno != ENOTSUP)
+			fprintf(stderr, "Failed to get SELinux label of %s:  %m\n", fullpath);
+		else if (verbose)
+			printf("Failed to get SELinux label of %s:  %m\n", fullpath);
+	} else {
+		if (dry_run) {
+			printf("Would remove SELinux label of %s\n", fullpath);
+		} else {
+			if (verbose)
+				printf("Removing label of %s\n", fullpath);
+
+			rc = lremovexattr(fullpath, XATTR_NAME_SELINUX);
+			if (rc < 0)
+				fprintf(stderr, "Failed to remove SELinux label of %s:  %m\n", fullpath);
+		}
+	}
+
+	if (!recursive)
+		return;
+
+	fd = openat(atfd, path, O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
+	if (fd < 0) {
+		if (errno != ENOTDIR)
+			fprintf(stderr, "Failed to open %s:  %m\n", fullpath);
+		return;
+	}
+
+	dir = fdopendir(fd);
+	if (!dir) {
+		fprintf(stderr, "Failed to open directory %s:  %m\n", fullpath);
+		close(fd);
+		return;
+	}
+
+	while (true) {
+		const struct dirent *entry;
+		char *nextfullpath;
+
+		errno = 0;
+		entry = readdir(dir);
+		if (!entry) {
+			if (errno)
+				fprintf(stderr, "Failed to iterate directory %s:  %m\n", fullpath);
+			break;
+		}
+
+		if (entry->d_name[0] == '.' && (entry->d_name[1] == '\0' || (entry->d_name[1] == '.' && entry->d_name[2] == '\0')))
+			continue;
+
+		rc = asprintf(&nextfullpath, "%s/%s", strcmp(fullpath, "/") == 0 ? "" : fullpath, entry->d_name);
+		if (rc < 0) {
+			fprintf(stderr, "Out of memory!\n");
+			closedir(dir);
+			return;
+		}
+
+		nuke(dirfd(dir), entry->d_name, nextfullpath, dry_run, recursive, verbose);
+
+		free(nextfullpath);
+	}
+
+	closedir(dir);
+}
+
+
+int main(int argc, char *argv[])
+{
+	bool dry_run = false, recursive = false, verbose = false;
+	int c;
+
+	while ((c = getopt(argc, argv, "nrv")) != -1) {
+		switch (c) {
+		case 'n':
+			dry_run = true;
+			break;
+		case 'r':
+			recursive = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (optind >= argc) {
+		usage(argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	if (is_selinux_enabled()) {
+		fprintf(stderr, "Removing SELinux attributes on a SELinux enabled system is not supported!\n");
+		return EXIT_FAILURE;
+	}
+
+	for (int index = optind; index < argc; index++)
+		nuke(AT_FDCWD, argv[index], argv[index], dry_run, recursive, verbose);
+
+	return EXIT_SUCCESS;
+}
-- 
2.40.1

