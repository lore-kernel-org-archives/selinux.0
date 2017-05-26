Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4QFwOM7005345
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 11:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C34680086
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 15:58:04 +0000 (UTC)
Subject: [PATCH 1/2] tools: add a syntax checker/fixer
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 26 May 2017 11:58:03 -0400
Message-ID: <149581428365.13714.3471273055695808786.stgit@sifl>
In-Reply-To: <149581413266.13714.10451742889870299166.stgit@sifl>
References: <149581413266.13714.10451742889870299166.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Add a simple script that uses astyle to check, and optionally fix,
the syntax of the test sources.  At the moment it is limited to C
but it can easily be augmented to support Perl in the future.

We also add a new make target, 'check-syntax', to make it easier for
developers to check their changes.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 Makefile           |    9 ++-
 tools/check-syntax |  146 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 3 deletions(-)
 create mode 100755 tools/check-syntax

diff --git a/Makefile b/Makefile
index e230389..9081406 100644
--- a/Makefile
+++ b/Makefile
@@ -3,12 +3,15 @@ SUBDIRS = policy tests
 all:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i all ; done
 
-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
-
 test:
 	make -C policy load
 	make -C tests test
 	make -C policy unload
 
+check-syntax:
+	@./tools/check-syntax
+
+clean:
+	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
+
 
diff --git a/tools/check-syntax b/tools/check-syntax
new file mode 100755
index 0000000..72cb06b
--- /dev/null
+++ b/tools/check-syntax
@@ -0,0 +1,146 @@
+#!/bin/bash
+
+#
+# code syntax checking tool
+#
+# Originally taken from the libseccomp project
+# -> https://github.com/seccomp
+#
+# Copyright (c) 2013,2015 Red Hat <pmoore@redhat.com>
+# Author: Paul Moore <paul@paul-moore.com>
+#
+
+CHK_C_LIST="$(find tests/ -name "*.c") $(find tests/ -name "*.h")"
+CHK_C_EXCLUDE=""
+
+####
+# functions
+
+#
+# Dependency verification
+#
+# Arguments:
+#     1    Dependency to check for
+#
+function verify_deps() {
+	[[ -z "$1" ]] && return
+	if ! which "$1" >& /dev/null; then
+		echo "error: install \"$1\" and include it in your \$PATH"
+		exit 1
+	fi
+}
+
+#
+# Print out script usage details
+#
+function usage() {
+cat << EOF
+usage: check-syntax [-h]
+
+code syntax checking tool
+optional arguments:
+  -h             show this help message and exit
+  -f             fix the file formatting
+EOF
+}
+
+#
+# Generate a properly formatted C source/header file
+#
+# Arguments:
+#     1    Source file
+#
+function tool_c_style() {
+	astyle --options=none --lineend=linux --mode=c \
+		--style=linux \
+		--indent=force-tab=8 \
+		--indent-preprocessor \
+		--indent-col1-comments \
+		--min-conditional-indent=0 \
+		--max-instatement-indent=80 \
+		--pad-oper \
+		--align-pointer=name \
+		--align-reference=name \
+		--max-code-length=80 \
+		--break-after-logical < "$1"
+}
+
+#
+# Check the formatting on a C source/header file
+#
+# Arguments:
+#     1    File to check
+#
+function tool_c_style_check() {
+	[[ -z "$1" || ! -r "$1" ]] && return
+
+	tool_c_style "$1" | diff -pu --label="$1.orig" "$1" --label="$1" -
+}
+
+#
+# Fix the formatting on a C source/header file
+#
+# Arguments:
+#     1    File to fix
+#
+function tool_c_style_fix() {
+	[[ -z "$1" || ! -r "$1" ]] && return
+
+	tmp="$(mktemp --tmpdir=$(dirname "$1"))"
+	tool_c_style "$1" > "$tmp"
+	mv "$tmp" "$1"
+}
+
+#
+# Perform all known syntax checks for the configured C sources/headers
+#
+function check_c() {
+	for i in $CHK_C_LIST; do
+		echo "$CHK_C_EXCLUDE" | grep -q "$i" && continue
+		echo "Differences for $i"
+		tool_c_style_check "$i"
+	done
+}
+
+#
+# Perform all known syntax fixes for the configured C sources/headers
+#
+function fix_c() {
+	for i in $CHK_C_LIST; do
+		echo "$CHK_C_EXCLUDE" | grep -q "$i" && continue
+		echo "Fixing $i"
+		tool_c_style_fix "$i"
+	done
+}
+
+####
+# main
+
+verify_deps astyle
+
+opt_fix=0
+
+while getopts "fh" opt; do
+	case $opt in
+	f)
+		opt_fix=1
+		;;
+	h|*)
+		usage
+		exit 1
+		;;
+	esac
+done
+
+# display the results
+echo "=============== $(date) ==============="
+echo "Code Syntax Check Results (\"check-syntax $*\")"
+if [[ $opt_fix -eq 1 ]]; then
+	fix_c
+else
+	check_c
+fi
+echo "============================================================"
+
+# exit
+exit 0
