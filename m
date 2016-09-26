Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8QFUetw000706
 for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2016 11:30:42 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] policycoreutils: setfiles - Utility to find
 security.restorecon_last entries
Date: Mon, 26 Sep 2016 16:30:30 +0100
Message-Id: <1474903830-5042-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch adds restorecon_xattr(8) to find and/or remove
security.restorecon_last entries added by setfiles(8) or
restorecon(8). Uses the services of selinux_restorecon_xattr(3).

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policycoreutils/setfiles/Makefile           |  10 +-
 policycoreutils/setfiles/restore.h          |   1 +
 policycoreutils/setfiles/restorecon_xattr.8 | 119 +++++++++++++++
 policycoreutils/setfiles/restorecon_xattr.c | 221 ++++++++++++++++++++++++++++
 4 files changed, 348 insertions(+), 3 deletions(-)
 create mode 100644 policycoreutils/setfiles/restorecon_xattr.8
 create mode 100644 policycoreutils/setfiles/restorecon_xattr.c

diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index 98f4f7d..43364f9 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -17,13 +17,15 @@ ifeq ($(AUDITH), /usr/include/libaudit.h)
 	LDLIBS += -laudit
 endif
 
-all: setfiles restorecon man
+all: setfiles restorecon restorecon_xattr man
 
 setfiles:  setfiles.o restore.o
 
 restorecon: setfiles
 	ln -sf setfiles restorecon
 
+restorecon_xattr:  restorecon_xattr.o restore.o
+
 man:
 	@cp -af setfiles.8 setfiles.8.man
 	@cp -af restorecon.8 restorecon.8.man
@@ -35,14 +37,16 @@ install: all
 	-mkdir -p $(SBINDIR)
 	install -m 755 setfiles $(SBINDIR)
 	(cd $(SBINDIR) && ln -sf setfiles restorecon)
+	install -m 755 restorecon_xattr $(SBINDIR)
 	install -m 644 setfiles.8.man $(MANDIR)/man8/setfiles.8
 	install -m 644 restorecon.8.man $(MANDIR)/man8/restorecon.8
+	install -m 644 restorecon_xattr.8 $(MANDIR)/man8/restorecon_xattr.8
 
 clean:
-	rm -f setfiles restorecon *.o setfiles.8.man restorecon.8.man
+	rm -f setfiles restorecon restorecon_xattr *.o setfiles.8.man restorecon.8.man
 
 indent:
 	../../scripts/Lindent $(wildcard *.[ch])
 
 relabel: install
-	$(SBINDIR)/restorecon $(SBINDIR)/setfiles
+	$(SBINDIR)/restorecon $(SBINDIR)/setfiles $(SBINDIR)/restorecon_xattr
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index bafb662..97fbdf4 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -56,5 +56,6 @@ void restore_init(struct restore_opts *opts);
 void restore_finish(void);
 void add_exclude(const char *directory);
 int process_glob(char *name, struct restore_opts *opts);
+extern char **exclude_list;
 
 #endif
diff --git a/policycoreutils/setfiles/restorecon_xattr.8 b/policycoreutils/setfiles/restorecon_xattr.8
new file mode 100644
index 0000000..65b28ea
--- /dev/null
+++ b/policycoreutils/setfiles/restorecon_xattr.8
@@ -0,0 +1,119 @@
+.TH "restorecon_xattr" "8" "24 Sept 2016" "" "SELinux User Command"
+.SH "NAME"
+restorecon_xattr \- manage
+.I security.restorecon_last
+extended attribute entries added by
+.BR setfiles (8)
+or
+.BR restorecon (8).
+
+.SH "SYNOPSIS"
+.B restorecon_xattr
+.RB [ \-d ]
+.RB [ \-D ]
+.RB [ \-m ]
+.RB [ \-n ]
+.RB [ \-r ]
+.RB [ \-v ]
+.RB [ \-e
+.IR directory ]
+.RB [ \-f
+.IR specfile ]
+.I pathname
+
+.SH "DESCRIPTION"
+.B restorecon_xattr
+will display the SHA1 digests added to extended attributes
+.I security.restorecon_last
+or delete the attribute completely. These attributes are set by
+.BR restorecon (8)
+or
+.BR setfiles (8)
+to specified directories when relabeling recursively.
+.sp
+.B restorecon_xattr
+is useful for managing the extended attribute entries particularly when
+users forget what directories they ran
+.BR restorecon (8)
+or
+.BR setfiles (8)
+from.
+.sp
+.B RAMFS
+and
+.B TMPFS
+filesystems do not support the
+.I security.restorecon_last
+extended attribute and are automatically excluded from searches.
+.sp
+By default
+.B restorecon_xattr
+will display the SHA1 digests with "Match" appended if they match the default
+specfile set or the
+.I specfile
+set used with the
+.B \-f
+option. Non-matching SHA1 digests will be displayed with "No Match" appended.
+This feature can be disabled by the
+.B \-n
+option.
+
+.SH "OPTIONS"
+.TP
+.B \-d
+delete all non-matching
+.I security.restorecon_last
+directory digest entries.
+.TP
+.B \-D
+delete all
+.I security.restorecon_last
+directory digest entries.
+.TP
+.B \-m
+do not read
+.B /proc/mounts
+to obtain a list of non-seclabel mounts to be excluded from relabeling checks.
+.br
+Setting
+.B \-m
+is useful where there is a non-seclabel fs mounted with a seclabel fs mounted
+on a directory below this.
+.TP
+.B \-n
+Do not append "Match" or "No Match" to displayed digests.
+.TP
+.B \-r
+recursively descend directories.
+.TP
+.B \-v
+display SHA1 digest generated by specfile set.
+.TP
+.B \-e
+.I directory
+.br
+directory to exclude (repeat option for more than one directory).
+.TP
+.B \-f
+.I specfile
+.br
+an optional
+.I specfile
+containing file context entries as described in
+.BR file_contexts (5).
+This will be used by
+.BR selabel_open (3)
+to retrieve the set of labeling entries, with the SHA1 digest being
+retrieved by
+.BR selabel_digest (3).
+If the option is not specified, then the default file_contexts will be used.
+
+.SH "ARGUMENTS"
+.TP
+.I pathname
+.br
+the pathname of the directory tree to be searched.
+
+.SH "SEE ALSO"
+.BR restorecon (8),
+.BR setfiles (8)
diff --git a/policycoreutils/setfiles/restorecon_xattr.c b/policycoreutils/setfiles/restorecon_xattr.c
new file mode 100644
index 0000000..1c39efe
--- /dev/null
+++ b/policycoreutils/setfiles/restorecon_xattr.c
@@ -0,0 +1,221 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <sys/xattr.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#include <selinux/restorecon.h>
+
+#include "restore.h"
+
+static void usage(const char *progname)
+{
+	fprintf(stderr,
+		"\nusage: %s [-vnrmdD] [-e directory] [-f specfile] pathname\n"
+		"\nWhere:\n\t"
+		"-v  Display digest generated by specfile set.\n\t"
+		"-n  Do not append \"Match\" or \"No Match\" to displayed digests.\n\t"
+		"-r  Recursively descend directories.\n\t"
+		"-m  Do not read /proc/mounts for entries to be excluded.\n\t"
+		"-d  Delete non-matching digest entries.\n\t"
+		"-D  Delete all digest entries.\n\t"
+		"-e  Directory to exclude (repeat option for more than one directory).\n\t"
+		"-f  Optional specfile for calculating the digest.\n\t"
+		"pathname  Path to search for xattr \"security.restorecon_last\" entries.\n\n",
+		progname);
+	exit(-1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, rc;
+	unsigned int xattr_flags = 0, delete_digest = 0, recurse = 0;
+	unsigned int delete_all_digests = 0, ignore_mounts = 0;
+	bool display_digest = false;
+	char *sha1_buf, **specfiles, *fc_file = NULL;
+	unsigned char *fc_digest = NULL;
+	size_t i, fc_digest_len = 0, num_specfiles;
+
+	struct stat sb;
+	struct selabel_handle *hnd = NULL;
+	struct dir_xattr *current, *next, **xattr_list = NULL;
+
+	bool no_comment = true;
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	if (is_selinux_enabled() <= 0) {
+		fprintf(stderr,
+		    "SELinux must be enabled to perform this operation.\n");
+		exit(-1);
+	}
+
+	exclude_list = NULL;
+
+	while ((opt = getopt(argc, argv, "vnrmdDe:f:")) > 0) {
+		switch (opt) {
+		case 'v':
+			display_digest = true;
+			break;
+		case 'n':
+			no_comment = false;
+			break;
+		case 'r':
+			recurse = SELINUX_RESTORECON_XATTR_RECURSE;
+			break;
+		case 'm':
+			ignore_mounts = SELINUX_RESTORECON_XATTR_IGNORE_MOUNTS;
+			break;
+		case 'd':
+			delete_digest =
+			    SELINUX_RESTORECON_XATTR_DELETE_NONMATCH_DIGESTS;
+			break;
+		case 'D':
+			delete_all_digests =
+			    SELINUX_RESTORECON_XATTR_DELETE_ALL_DIGESTS;
+			break;
+		case 'e':
+			if (lstat(optarg, &sb) < 0 && errno != EACCES) {
+				fprintf(stderr, "Can't stat exclude path \"%s\", %s - ignoring.\n",
+					optarg, strerror(errno));
+				break;
+			}
+			add_exclude(optarg);
+			break;
+		case 'f':
+			fc_file = optarg;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No pathname specified\n");
+		exit(-1);
+	}
+
+	struct selinux_opt selinux_opts[] = {
+		{ SELABEL_OPT_PATH, fc_file },
+		{ SELABEL_OPT_DIGEST, (char *)1 }
+	};
+
+	hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 2);
+	if (!hnd) {
+		switch (errno) {
+		case EOVERFLOW:
+			fprintf(stderr, "Error: Number of specfiles or"
+				 " specfile buffer caused an overflow.\n");
+			break;
+		default:
+			fprintf(stderr, "Error: selabel_open: %s\n",
+							    strerror(errno));
+		}
+		exit(-1);
+	}
+
+	/* Use own handle as need to allow different file_contexts. */
+	selinux_restorecon_set_sehandle(hnd);
+
+	if (display_digest) {
+		if (selabel_digest(hnd, &fc_digest, &fc_digest_len,
+				   &specfiles, &num_specfiles) < 0) {
+			fprintf(stderr,
+				"Error: selabel_digest: Digest not available.\n");
+			selabel_close(hnd);
+			exit(-1);
+		}
+
+		sha1_buf = malloc(fc_digest_len * 2 + 1);
+		if (!sha1_buf) {
+			fprintf(stderr,
+				"Error allocating digest buffer: %s\n",
+							    strerror(errno));
+			selabel_close(hnd);
+			exit(-1);
+		}
+
+		for (i = 0; i < fc_digest_len; i++)
+			sprintf((&sha1_buf[i * 2]), "%02x", fc_digest[i]);
+
+		printf("specfiles SHA1 digest: %s\n", sha1_buf);
+
+		printf("calculated using the following specfile(s):\n");
+		if (specfiles) {
+			for (i = 0; i < num_specfiles; i++)
+				printf("%s\n", specfiles[i]);
+		}
+		free(sha1_buf);
+		printf("\n");
+	}
+
+	if (exclude_list)
+		selinux_restorecon_set_exclude_list
+						 ((const char **)exclude_list);
+
+	xattr_flags = delete_digest | delete_all_digests |
+		      ignore_mounts | recurse;
+
+	if (selinux_restorecon_xattr(argv[optind], xattr_flags, &xattr_list)) {
+		fprintf(stderr,
+			"Error selinux_restorecon_xattr: %s\n",
+			strerror(errno));
+		rc = -1;
+		goto out;
+	}
+
+	if (xattr_list) {
+		current = *xattr_list;
+		while (current) {
+			next = current->next;
+			printf("%s ", current->directory);
+
+			switch (current->result) {
+			case MATCH:
+				printf("Digest: %s%s", current->digest,
+				       no_comment ? " Match\n" : "\n");
+				break;
+			case NOMATCH:
+				printf("Digest: %s%s", current->digest,
+				       no_comment ? " No Match\n" : "\n");
+				break;
+			case DELETED_MATCH:
+				printf("Deleted Digest: %s%s", current->digest,
+				       no_comment ? " Match\n" : "\n");
+				break;
+			case DELETED_NOMATCH:
+				printf("Deleted Digest: %s%s",
+				       current->digest,
+				       no_comment ? " No Match\n" : "\n");
+				break;
+			case ERROR:
+				printf("Digest: %s Error removing xattr\n",
+				       current->digest);
+				break;
+			}
+			current = next;
+		}
+		/* Free memory */
+		current = *xattr_list;
+		while (current) {
+			next = current->next;
+			free(current->directory);
+			free(current->digest);
+			free(current);
+			current = next;
+		}
+	}
+
+	rc = 0;
+out:
+	selabel_close(hnd);
+	restore_finish();
+	return rc;
+}
-- 
2.7.4
