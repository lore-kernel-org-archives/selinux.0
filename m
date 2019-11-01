Return-Path: <SRS0=ebWe=YZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE0ACA9ED0
	for <selinux@archiver.kernel.org>; Fri,  1 Nov 2019 09:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC9B20862
	for <selinux@archiver.kernel.org>; Fri,  1 Nov 2019 09:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfKAJ3w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:29:52 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:38506 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfKAJ3w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Nov 2019 05:29:52 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 228E45649B5;
        Fri,  1 Nov 2019 10:29:50 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Cc:     Michael Shigorin <mike@altlinux.org>
Subject: [PATCH 3/3] libsemanage: generate Python glue code using "sed"
Date:   Fri,  1 Nov 2019 10:27:24 +0100
Message-Id: <20191101092724.7650-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101092724.7650-1-nicolas.iooss@m4x.org>
References: <20191101092724.7650-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Nov  1 10:29:50 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

libsemanage currently uses "gcc -aux-info" in order to generate glue
code for its Python bindings that throws an exception when a function
returns a negative integer value. This causes issues when another
compiler than gcc is used (such as clang or icc), as option -aux-info is
specific to gcc.

Replace "gcc -aux-info" with a command that parses the content of header
files using "sed". As this is more fragile (because the declaration of
functions is not normalized), add a new target to the Makefile in order
to test that the new method does not produce different results with
"make CC=gcc test".

When reverting commit b915c7a9d330 ("libsemanage: mark all exported
function "extern""), "make test" now fails as expected:

    bash -e exception.sh test
    Error ensuring that all exported functions that return an int are handled by exception.sh.
    Here are functions that were not found in "gcc -aux-info" but that were collected by "sed":
    Here are functions in "gcc -aux-info" that may be missing "extern" in header file:
    semanage_access_check
    semanage_begin_transaction
    semanage_commit
    semanage_connect
    semanage_disconnect
    semanage_get_disable_dontaudit
    semanage_get_hll_compiler_path
    ...
    make: *** [Makefile:202: test] Error 1

Original thread: https://lore.kernel.org/selinux/20191012172357.GB19655@imap.altlinux.org/T/#ma78bd7fe71fb5784387a8c0cebd867d6c02ee6e4

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Michael Shigorin <mike@altlinux.org>
---
 libsemanage/Makefile         |  1 +
 libsemanage/src/Makefile     |  5 ++++-
 libsemanage/src/exception.sh | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/libsemanage/Makefile b/libsemanage/Makefile
index 390176fee7fb..e24b9ae55adc 100644
--- a/libsemanage/Makefile
+++ b/libsemanage/Makefile
@@ -34,4 +34,5 @@ indent:
 	$(MAKE) -C include $@
 
 test: all
+	$(MAKE) -C src test
 	$(MAKE) -C tests test
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 7dcf4715878e..b21ff219aef3 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -160,7 +160,10 @@ clean:
 distclean: clean
 	rm -f $(GENERATED) $(SWIGFILES)
 
+test:
+	bash -e exception.sh test
+
 indent:
 	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
 
-.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
+.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean test indent
diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
index 97bc2ae879f2..f1e8aa2f7033 100644
--- a/libsemanage/src/exception.sh
+++ b/libsemanage/src/exception.sh
@@ -1,3 +1,4 @@
+#!/bin/bash -e
 function except() {
 echo "
 %exception $1 {
@@ -9,10 +10,35 @@ echo "
 }
 "
 }
-if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
+
+if [ $# -eq 1 ] && [ "$1" = "test" ]
 then
-    # clang does not support -aux-info so fall back to gcc
-    gcc -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
+    # Ensure that "gcc -aux-info" produces the same list of functions as the sed command.
+    # The main difference between these way of producing the list of exported
+    # functions is that "gcc -aux-info" automatically inserts "extern" to all
+    # declarations and writes each one on a single line.
+    # clang does not support -aux-info, so skip the test if generating the aux file failed.
+    if ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
+    then
+        FCT_FROM_AUX="$(awk '/include\/semanage\/.*extern int/ { print $6 }' temp.aux | sort -u)"
+        FCT_FROM_SED="$(cat ../include/semanage/*.h | sed -n 's/^extern \+int \+\([0-9A-Za-z_]\+\) *(.*$/\1/p' | sort -u)"
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
-for i in `awk '/extern int/ { print $6 }' temp.aux`; do except $i ; done
+
+# shellcheck disable=SC2013
+for i in $(cat ../include/semanage/*.h | sed -n 's/^extern \+int \+\([0-9A-Za-z_]\+\) *(.*$/\1/p')
+do
+    except "$i"
+done
 rm -f -- temp.aux -.o
-- 
2.23.0

