Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949726288
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706531; cv=none; b=qGFkMWJkj3VLRLPM79nV7Hv2KdbUTWqPRL+0zItvfGqQ3NEkQUQpuu96PVitipdluzPOK5rOtq37jexjuyocH09Cy3GfFhJwf46GCvz42Q3LqLohX0LkqYJYuZ/7uAj0kjt1WRlxHfPTfbYBRGflOu1Fcyc6Xve7em4mGD6JMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706531; c=relaxed/simple;
	bh=nZk+fvWFdHvEpfbpB1j7O1SOI/pBIXWEpaU9aFdsqTs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vb3R10zR5xqRoyvgcuOzoUMF2cBN6PYHcYzRvdzZBrplIKi3gsTX1l+WJTrK/dlNleaYlMC+may9XC3qpxDZGtpPeU9Pp0NcTupkceeHU3tDdWWxhjoR8AydejSWMe6+TcLS/9XWir/m9mM7Ge1NdDuIiE2GFR29YvhoST782qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IIMMHnTR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IIMMHnTR"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso1641066a12.1
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 05:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706706528; x=1707311328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJPaQRhoZRLCsNcXGr8o9qwav1lgDGil+7YnebLCeBM=;
        b=IIMMHnTRs4Q9VDADF5xNDOhkr5qIn+J263u0AyuLgMkrUeJvsB/ykOgNOVlkbRuhAk
         1PQjuAfz3qlduEcoftpzZX5oeDAlYlsFbNfDtGJdntiLfPEEFr80pLDwDpyqrY70xEAZ
         qDMyFlYPjX693YzdOkjd+uDB5lxRYNP+S59bhdYm83Ayv0opZ9pp4/aFOKT4LVm1PblV
         n7btAui5GNszJV/HUSldxE28lPP6rNnw3U8bbebQuysTUfSosoRctyBTJxb8zadZaBSu
         cihfj0Uw5IPCmDtGqdD2yIvbkymg+BJSCWRIkT33or5gXC5xzpMAeZo7GT8Pu7l2b0RH
         vyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706528; x=1707311328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJPaQRhoZRLCsNcXGr8o9qwav1lgDGil+7YnebLCeBM=;
        b=QW1YbE5wLdruQfnzc3dp59el4tvrNPsUMfhx65CN6hu4rhegE5tkHcVb8tquf0LdUF
         9151VpC/JKPkXRLUOflAymP3n3vZxPP/vhi/qIpChVWV4MqlwsPrFp9NotzQ2GZXzr7a
         UcZJAqOOHn3AxloZmpQvOEWFCsNOqv2UUgCyGKCs8eVWPFgGeq1PeACZteDvLKzZ9O1X
         WsJA/SWgLrbCzu4VQwbvqz9BGPoW/pboS4gpsMC8HBH8cHGNkexqaH1PmPKtR9wlWn1k
         BfGK2DL3HkwbgsPsZ3KD9hJETYsjCPkBfYhJ7N9ugsCUW02O4x6iAFa09uMyqDb6Jsyc
         t5OQ==
X-Gm-Message-State: AOJu0Yyz+DY8eXr4WcTWCqqyCKrIJSbWe+L3boahzUMsh76LLoKhtoZz
	1RJrhgaKMFx/ZQlnB9+fCMNVxvttrnvzGY6uz4p7pI5Mjgsi2OMIiwWXtm04
X-Google-Smtp-Source: AGHT+IFPSo4hnSWkOBYUqNJLTnxcrZICBxMpNEDeJeIupyHZMfWw0hqnmGlzueEBlGDHlDFN4T5gyQ==
X-Received: by 2002:a17:906:4a19:b0:a36:4eb7:68ac with SMTP id w25-20020a1709064a1900b00a364eb768acmr1138835eju.36.1706706527554;
        Wed, 31 Jan 2024 05:08:47 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00a365c673251sm890351ejm.216.2024.01.31.05.08.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:08:47 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH v2 1/9] policycoreutils: introduce unsetfiles
Date: Wed, 31 Jan 2024 14:08:27 +0100
Message-ID: <20240131130840.48155-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131130840.48155-1-cgzones@googlemail.com>
References: <20240131130840.48155-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
2.43.0

