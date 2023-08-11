Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF89C04E69
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjHKQ16 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjHKQ1z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921C2D70
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99357737980so297358866b.2
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771274; x=1692376074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8nTYQ0/hIFZJNZrMpjQuMCmggV7Ae4denN2XBUk8J8=;
        b=COhe1I5UFs/Ajbm0OxQ/SWInt+m/8BHQhcweiH7171vHvitXrfewbxFEPlDN+OE4Wm
         oq0Va5u+7I5Ye4aPZja5SEDrgneZeMIR9blfUYhsmc64Fvc+WSmrWEy+B/IVKOPN0Rpa
         FODwW+XaRg9ybr2nXzfmTUja9Eusp881slWzSPoLX+w3Hd+miLVhvzhgHe6+MzB95022
         TpPUO9BBSkwEm+BatAAYJqUF1YNg6v74wZHJAiiSBPaoR3Y2A3PHmVwEdL1ywYhGaI4b
         VucliLs9wxe42liy12uw3p2YpNHUxpMrQMLSFF4jZadjCUMAicUlUFozwK04ESXWbTow
         bxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771274; x=1692376074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8nTYQ0/hIFZJNZrMpjQuMCmggV7Ae4denN2XBUk8J8=;
        b=fXu14GCTtqP9xaWli+L7dYRBjMmqNNoQ1DZrOW26Aj891+/W4sGc7KlOh4buVH2odM
         k7+cFfbLx/vJCO9/oWlJ9gGzKQA/zPomwXJS58O4Ydf0Pd/5O5cQ0kErNlmkmfnmB7Es
         ACLZsyS1uq3f9NG+GO6Dziyy5Bywh8ux51UK8WWliLD+sOmCpd91FUTekM0nq0dvAGkT
         3bb0p58MRkx8R1I5/ahMgCVVUrJjAA/wLZpwdd4vTWuohNsHEebqs2eCg2RhfsOGkL+N
         5MHpAlW4fanp0/xMDCZ301zcwOleEJQ9slUWeGJPJT6dD7DoFHJgDbout9qCxfvZNsxW
         X15g==
X-Gm-Message-State: AOJu0YweJljYIlVfvQ9b6c+SK7IniGz01gWqSajqgDRswm+d6iiCUGxn
        0cgdtEUL4JBJdykQk1GmnVvkV8s2iH0xJQ==
X-Google-Smtp-Source: AGHT+IHYvD62Me5xiKEfHRzILmP9JPOUaRQS6SwIHucgr5K1KHxUbiyQ23lr1Mtj5GaIycKHQ+hnaA==
X-Received: by 2002:a17:906:32c6:b0:99c:ae01:a6d0 with SMTP id k6-20020a17090632c600b0099cae01a6d0mr2269192ejk.68.1691771273765;
        Fri, 11 Aug 2023 09:27:53 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 10/24] libselinux: introduce selabel_nuke
Date:   Fri, 11 Aug 2023 18:27:17 +0200
Message-Id: <20230811162731.50697-11-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
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

