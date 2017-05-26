Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4QFwwE6005397
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 11:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7E0E2B0A72
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 15:58:55 +0000 (UTC)
Subject: [RFC PATCH] tools: add perltidy to the syntax checker/fixer
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 26 May 2017 11:58:55 -0400
Message-ID: <149581433492.13821.14132385005185399089.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tools/check-syntax |   86 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 20 deletions(-)

diff --git a/tools/check-syntax b/tools/check-syntax
index 72cb06b..ee83c03 100755
--- a/tools/check-syntax
+++ b/tools/check-syntax
@@ -13,6 +13,9 @@
 CHK_C_LIST="$(find tests/ -name "*.c") $(find tests/ -name "*.h")"
 CHK_C_EXCLUDE=""
 
+CHK_PERL_LIST="$(find tests/ -name "*.pl") $(find tests/ -name "test")"
+CHK_PERL_EXCLUDE=""
+
 ####
 # functions
 
@@ -66,50 +69,92 @@ function tool_c_style() {
 }
 
 #
-# Check the formatting on a C source/header file
+# Generate a properly formatted Perl source file
 #
 # Arguments:
-#     1    File to check
+#     1    Source file
 #
-function tool_c_style_check() {
-	[[ -z "$1" || ! -r "$1" ]] && return
+function tool_perl_style() {
+	perltidy < "$1"
+}
 
-	tool_c_style "$1" | diff -pu --label="$1.orig" "$1" --label="$1" -
+#
+# Check the formatting on a file
+#
+# Arguments:
+#     1    Language
+#     2    File to check
+#
+function style_check() {
+	[[ -z "$1" ]] && return
+	[[ -z "$2" || ! -r "$2" ]] && return
+
+	case "$1" in
+	c|C)
+		tool_c_style "$2" | \
+			diff -pu --label="$2.orig" "$2" --label="$2" -
+		;;
+	perl|Perl)
+		tool_perl_style "$2" | \
+			diff -pu --label="$2.orig" "$2" --label="$2" -
+		;;
+	esac
 }
 
 #
-# Fix the formatting on a C source/header file
+# Fix the formatting on a file
 #
 # Arguments:
-#     1    File to fix
+#     1    Language
+#     2    File to check
 #
-function tool_c_style_fix() {
-	[[ -z "$1" || ! -r "$1" ]] && return
+function style_fix() {
+	[[ -z "$1" ]] && return
+	[[ -z "$2" || ! -w "$2" ]] && return
 
-	tmp="$(mktemp --tmpdir=$(dirname "$1"))"
-	tool_c_style "$1" > "$tmp"
-	mv "$tmp" "$1"
+	tmp="$(mktemp --tmpdir=$(dirname "$2"))"
+	case "$1" in
+	c|C)
+		tool_c_style "$2" > "$tmp"
+		;;
+	perl|Perl)
+		tool_perl_style "$2" > "$tmp"
+		;;
+	esac
+	mv "$tmp" "$2"
 }
 
 #
-# Perform all known syntax checks for the configured C sources/headers
+# Perform all known syntax checks for the configured files
 #
-function check_c() {
+function check() {
 	for i in $CHK_C_LIST; do
 		echo "$CHK_C_EXCLUDE" | grep -q "$i" && continue
 		echo "Differences for $i"
-		tool_c_style_check "$i"
+		style_check c "$i"
+	done
+
+	for i in $CHK_PERL_LIST; do
+		echo "$CHK_PERL_EXCLUDE" | grep -q "$i" && continue
+		echo "Differences for $i"
+		style_check perl "$i"
 	done
 }
 
 #
-# Perform all known syntax fixes for the configured C sources/headers
+# Perform all known syntax fixes for the configured files
 #
-function fix_c() {
+function fix() {
 	for i in $CHK_C_LIST; do
 		echo "$CHK_C_EXCLUDE" | grep -q "$i" && continue
 		echo "Fixing $i"
-		tool_c_style_fix "$i"
+		style_fix c "$i"
+	done
+
+	for i in $CHK_PERL_LIST; do
+		echo "$CHK_PERL_EXCLUDE" | grep -q "$i" && continue
+		echo "Fixing $i"
+		style_fix perl "$i"
 	done
 }
 
@@ -117,6 +162,7 @@ function fix_c() {
 # main
 
 verify_deps astyle
+verify_deps perltidy
 
 opt_fix=0
 
@@ -136,9 +182,9 @@ done
 echo "=============== $(date) ==============="
 echo "Code Syntax Check Results (\"check-syntax $*\")"
 if [[ $opt_fix -eq 1 ]]; then
-	fix_c
+	fix
 else
-	check_c
+	check
 fi
 echo "============================================================"
 
