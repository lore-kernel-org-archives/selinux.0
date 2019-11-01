Return-Path: <SRS0=ebWe=YZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F6BCA9ED1
	for <selinux@archiver.kernel.org>; Fri,  1 Nov 2019 09:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B920120862
	for <selinux@archiver.kernel.org>; Fri,  1 Nov 2019 09:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfKAJ3v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:29:51 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:52124 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfKAJ3v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Nov 2019 05:29:51 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EA1D45649B1;
        Fri,  1 Nov 2019 10:29:48 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Cc:     Michael Shigorin <mike@altlinux.org>
Subject: [PATCH 2/3] libselinux: generate Python glue code using "sed"
Date:   Fri,  1 Nov 2019 10:27:23 +0100
Message-Id: <20191101092724.7650-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101092724.7650-1-nicolas.iooss@m4x.org>
References: <20191101092724.7650-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Nov  1 10:29:49 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

libselinux currently uses "gcc -aux-info" in order to generate glue code
for its Python bindings that throws an exception when a function returns
a negative integer value. This causes issues when another compiler than
gcc is used (such as clang or icc), as option -aux-info is specific to
gcc.

Replace "gcc -aux-info" with a command that parses the content of header
files using "sed". As this is more fragile (because the declaration of
functions is not normalized), add a new target to the Makefile in order
to test that the new method does not produce different results with
"make CC=gcc test".

When reverting commit cfe487409307 ("libselinux: mark all exported
function "extern""), "make test" now fails as expected:

    bash -e exception.sh test
    Error ensuring that all exported functions that return an int are handled by exception.sh.
    Here are functions that were not found in "gcc -aux-info" but that were collected by "sed":
    Here are functions in "gcc -aux-info" that may be missing "extern" in header file:
    selinuxfs_exists
    make: *** [Makefile:202: test] Error 1

Original thread: https://lore.kernel.org/selinux/20191012172357.GB19655@imap.altlinux.org/T/#ma78bd7fe71fb5784387a8c0cebd867d6c02ee6e4

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Michael Shigorin <mike@altlinux.org>
---
 libselinux/Makefile         |  1 +
 libselinux/src/Makefile     |  5 ++++-
 libselinux/src/exception.sh | 38 +++++++++++++++++++++++++++++++------
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 16531fe95bf5..c0ae884f8ede 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -67,3 +67,4 @@ clean-rubywrap:
 	$(MAKE) -C src clean-rubywrap $@
 
 test:
+	$(MAKE) -C src test
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 63d6b0eda270..c12230a17b1d 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -198,7 +198,10 @@ clean: clean-pywrap clean-rubywrap
 distclean: clean
 	rm -f $(GENERATED) $(SWIGFILES)
 
+test:
+	bash -e exception.sh test
+
 indent:
 	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
 
-.PHONY: all clean clean-pywrap clean-rubywrap pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
+.PHONY: all clean clean-pywrap clean-rubywrap pywrap rubywrap swigify install install-pywrap install-rubywrap distclean test indent
diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
index d6c8c71713ad..adbb632c2f04 100755
--- a/libselinux/src/exception.sh
+++ b/libselinux/src/exception.sh
@@ -1,11 +1,12 @@
+#!/bin/bash -e
 function except() {
-case $1 in
+case "$1" in
     selinux_file_context_cmp) # ignore
     ;;
     *)
 echo "
 %exception $1 {
-  \$action 
+  \$action
   if (result < 0) {
      PyErr_SetFromErrno(PyExc_OSError);
      SWIG_fail;
@@ -15,10 +16,35 @@ echo "
 ;;
 esac
 }
-if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
+
+if [ $# -eq 1 ] && [ "$1" = "test" ]
 then
-    # clang does not support -aux-info so fall back to gcc
-    gcc -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
+    # Ensure that "gcc -aux-info" produces the same list of functions as the sed command.
+    # The main difference between these way of producing the list of exported
+    # functions is that "gcc -aux-info" automatically inserts "extern" to all
+    # declarations and writes each one on a single line.
+    # clang does not support -aux-info, so skip the test if generating the aux file failed.
+    if ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
+    then
+        FCT_FROM_AUX="$(awk '/<stdin>.*extern int/ { print $6 }' temp.aux | sort -u)"
+        FCT_FROM_SED="$(sed -n 's/^extern \+int \+\([0-9A-Za-z_]\+\) *(.*$/\1/p' < ../include/selinux/selinux.h | sort -u)"
+        if [ "$FCT_FROM_AUX" != "$FCT_FROM_SED" ]
+        then
+            echo >&2 'Error ensuring that all exported functions that return an int are handled by exception.sh.'
+            echo >&2 'Here are functions that were not found in "gcc -aux-info" but that were collected by "sed":'
+            comm -13 <(echo "$FCT_FROM_AUX") <(echo "$FCT_FROM_SED")
+            echo >&2 'Here are functions in "gcc -aux-info" that may be missing "extern" in header file:'
+            comm -23 <(echo "$FCT_FROM_AUX") <(echo "$FCT_FROM_SED")
+            exit 1
+        fi
+    fi
+    rm -f -- temp.aux -.o
+    exit
 fi
-for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except $i ; done 
+
+# shellcheck disable=SC2013
+for i in $(sed -n 's/^extern \+int \+\([0-9A-Za-z_]\+\) *(.*$/\1/p' < ../include/selinux/selinux.h)
+do
+    except "$i"
+done
 rm -f -- temp.aux -.o
-- 
2.23.0

