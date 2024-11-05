Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F41E3DF2
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831610; cv=none; b=rgosynOn+IhbLz5nLb6cyIZq0rgKcVeya7BQ0OQZ44OLZ9vbSC8LPbJiledaLpbwOzkHlIMxEr3eXW0oCQs6+vOWpKWo36DmURuBro/cdNG+QNWG97QEU4oWNpeA77CFK7xVj4Ub+N7yZth9acz6z44P3tLJzpTy0702kQi32uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831610; c=relaxed/simple;
	bh=uLVdzQW/0v4TGk8v4Jg7fZUiaQ+pxKAMDvHQvQMSqBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAg+G7YH0v1GwwZdWc+mwupkwWWGV81lCoos7oHgB6d2/vlX7xmF5RcOjX7REN9TIuACItPNrx5N3A7If+oQXOGi7WfZdnunrSdQdSIXet2S+Ln/+CN7cPyE4g0h3fyT5Wczg4UULqF9PXoCtiUSl8os6XGjMrRXemxNnuS/xew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=BCSxY2vg; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="BCSxY2vg"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831605;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+fs/fsH3HimYMEipqaiE/QE1sZeQrkIHbN/PDg+n9I=;
	b=BCSxY2vgbmJEXgLmGhunIZePxaPkCgVq0fyfrSR2KuJR6oCMXUD+0Su/3xGfB+YZsz9SF3
	cVPkmWYz1dSlf8lKizmg4uyFQim3ijWzzMUGCVh/G3cBnpVS1Ek+7/wk34HYZ2MKN3mh3r
	Q5ZS3LK2+irYUDwZ26csd7fQ/Nm1/PtfwbUsiutiaBoKbP33M4DNlH+htDAVuKy0B8C2GG
	WMQIOyL1Y9T/fjONl7m3YTyBku2RkD0ekOlS8XyVsN1sTieZcPumY9nxm/enk25TGDgeRQ
	xEiOqXX9IAFClHG9CMCUbCqigBLFVhSXWpDmRIw7UTrrnFUYnZk8qse8W1AZYQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 1/9] policycoreutils: introduce unsetfiles
Date: Tue,  5 Nov 2024 19:33:11 +0100
Message-ID: <20241105183319.250410-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241105183319.250410-1-cgoettsche@seltendoof.de>
References: <20241105183319.250410-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Introduce a helper to remove SELinux file security contexts.

Mainly for testing label operations, and only for SELinux disabled
systems, since removing file contexts is not supported by SELinux.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   move from libselinux/utils to policycoreutils and rename
---
 policycoreutils/.gitignore              |   1 +
 policycoreutils/Makefile                |   2 +-
 policycoreutils/unsetfiles/Makefile     |  26 ++++
 policycoreutils/unsetfiles/unsetfiles.1 |  46 ++++++
 policycoreutils/unsetfiles/unsetfiles.c | 183 ++++++++++++++++++++++++
 5 files changed, 257 insertions(+), 1 deletion(-)
 create mode 100644 policycoreutils/unsetfiles/Makefile
 create mode 100644 policycoreutils/unsetfiles/unsetfiles.1
 create mode 100644 policycoreutils/unsetfiles/unsetfiles.c

diff --git a/policycoreutils/.gitignore b/policycoreutils/.gitignore
index 47c9cc52..33e7414c 100644
--- a/policycoreutils/.gitignore
+++ b/policycoreutils/.gitignore
@@ -9,4 +9,5 @@ setfiles/restorecon
 setfiles/restorecon_xattr
 setfiles/setfiles
 setsebool/setsebool
+unsetfiles/unsetfiles
 hll/pp/pp
diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
index b930b297..32ad0201 100644
--- a/policycoreutils/Makefile
+++ b/policycoreutils/Makefile
@@ -1,4 +1,4 @@
-SUBDIRS = setfiles load_policy newrole run_init secon sestatus semodule setsebool scripts po man hll
+SUBDIRS = setfiles load_policy newrole run_init secon sestatus semodule setsebool scripts po man hll unsetfiles
 
 all install relabel clean indent:
 	@for subdir in $(SUBDIRS); do \
diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unsetfiles/Makefile
new file mode 100644
index 00000000..9e5edc04
--- /dev/null
+++ b/policycoreutils/unsetfiles/Makefile
@@ -0,0 +1,26 @@
+PREFIX ?= /usr
+SBINDIR ?= $(PREFIX)/sbin
+MANDIR ?= $(PREFIX)/share/man
+
+override CFLAGS += -D_GNU_SOURCE
+override LDLIBS += -lselinux
+
+
+all: unsetfiles
+
+unsetfiles: unsetfiles.o
+
+install: all
+	test -d $(DESTDIR)$(SBINDIR)     || install -m 755 -d $(DESTDIR)$(SBINDIR)
+	test -d $(DESTDIR)$(MANDIR)/man1 || install -m 755 -d $(DESTDIR)$(MANDIR)/man1
+	install -m 755 unsetfiles $(DESTDIR)$(SBINDIR)
+	install -m 644 unsetfiles.1 $(DESTDIR)$(MANDIR)/man1/
+
+clean:
+	-rm -f unsetfiles *.o
+
+indent:
+	../../scripts/Lindent $(wildcard *.[ch])
+
+relabel: install
+	/sbin/restorecon $(DESTDIR)$(SBINDIR)/unsetfiles
diff --git a/policycoreutils/unsetfiles/unsetfiles.1 b/policycoreutils/unsetfiles/unsetfiles.1
new file mode 100644
index 00000000..49d0c821
--- /dev/null
+++ b/policycoreutils/unsetfiles/unsetfiles.1
@@ -0,0 +1,46 @@
+.TH UNSETFILES "1" "December 2023" "Security Enhanced Linux"
+.SH NAME
+unsetfiles \- Remove SELinux file security contexts.
+.SH SYNOPSIS
+.B unsetfiles
+.RB [ \-hnrvx ]
+.IR pathname \ ...
+
+.SH DESCRIPTION
+.P
+This program removes the SELinux file security contexts of files.  It can help
+cleaning extended file attributes after disabling SELinux.
+.P
+.B unsetfiles
+will only work on SELinux disabled systems, since removing file security
+contexts is not supported by SELinux.
+
+.SH OPTIONS
+.TP
+.B \-h
+Show usage information and exit.
+.TP
+.B \-n
+Do not actually remove any SELinux file security contexts.
+.TP
+.B \-r
+Remove SELinux file security contexts recursive.
+.TP
+.B \-v
+Be verbose about performed actions.
+.TP
+.B \-x
+Do not cross filesystem boundaries.
+
+.SH ARGUMENTS
+.TP
+.IR pathname \ ...
+One or more path names to operate on.
+
+.SH SEE ALSO
+.BR restorecon (8),
+.BR setfiles (8)
+
+.SH AUTHORS
+.nf
+Christian Göttsche (cgzones@googlemail.com)
diff --git a/policycoreutils/unsetfiles/unsetfiles.c b/policycoreutils/unsetfiles/unsetfiles.c
new file mode 100644
index 00000000..6293d00f
--- /dev/null
+++ b/policycoreutils/unsetfiles/unsetfiles.c
@@ -0,0 +1,183 @@
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <linux/magic.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
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
+	fprintf(stderr, "usage: %s [-nrvx] <path>\n\n"
+	                "Options:\n"
+	                "\t-n\tdon't remove any file labels\n"
+	                "\t-r\tremove labels recursive\n"
+	                "\t-v\tbe verbose\n"
+	                "\t-x\tdo not cross filesystem boundaries\n",
+	                progname);
+}
+
+static void unset(int atfd, const char *path, const char *fullpath,
+                  bool dry_run, bool recursive, bool verbose,
+                  dev_t root_dev)
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
+	if (root_dev != (dev_t)-1) {
+		struct stat sb;
+
+		rc = fstat(fd, &sb);
+		if (rc == -1) {
+			fprintf(stderr, "Failed to stat directory %s:  %m\n", fullpath);
+			close(fd);
+			return;
+		}
+
+		if (sb.st_dev != root_dev) {
+			if (verbose)
+				printf("Skipping directory %s due to filesystem boundary\n", fullpath);
+
+			close(fd);
+			return;
+		}
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
+		unset(dirfd(dir), entry->d_name, nextfullpath, dry_run, recursive, verbose, root_dev);
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
+	bool dry_run = false, recursive = false, verbose = false, same_dev = false;
+	int c;
+
+	while ((c = getopt(argc, argv, "hnrvx")) != -1) {
+		switch (c) {
+		case 'h':
+			usage(argv[0]);
+			return EXIT_SUCCESS;
+		case 'n':
+			dry_run = true;
+			break;
+		case 'r':
+			recursive = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		case 'x':
+			same_dev = true;
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
+	for (int index = optind; index < argc; index++) {
+		dev_t root_dev = (dev_t)-1;
+
+		if (same_dev) {
+			struct stat sb;
+			int rc;
+
+			rc = stat(argv[index], &sb);
+			if (rc == -1) {
+				fprintf(stderr, "Failed to stat %s:  %m\n", argv[index]);
+				continue;
+			}
+
+			root_dev = sb.st_dev;
+		}
+		unset(AT_FDCWD, argv[index], argv[index], dry_run, recursive, verbose, root_dev);
+	}
+
+	return EXIT_SUCCESS;
+}
-- 
2.45.2

