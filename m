Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A84C433F5
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 12:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14929611C3
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 12:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhKPMEo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbhKPMEc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Nov 2021 07:04:32 -0500
Received: from forward103p.mail.yandex.net (forward103p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA359C061207
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 04:00:00 -0800 (PST)
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 3AED95A1DDE;
        Tue, 16 Nov 2021 14:59:57 +0300 (MSK)
Received: from vla1-ce2e345b2df9.qloud-c.yandex.net (vla1-ce2e345b2df9.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3609:0:640:ce2e:345b])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 37F5B13E80013;
        Tue, 16 Nov 2021 14:59:57 +0300 (MSK)
Received: from vla5-8422ddc3185d.qloud-c.yandex.net (vla5-8422ddc3185d.qloud-c.yandex.net [2a02:6b8:c18:3495:0:640:8422:ddc3])
        by vla1-ce2e345b2df9.qloud-c.yandex.net (mxback/Yandex) with ESMTP id qLnQfdiPXX-xvDiuqoJ;
        Tue, 16 Nov 2021 14:59:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1637063997;
        bh=lf9+ATzthT9HZfpMYnvbco1jFzxkHA6GXxnoasLUBf4=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=bVBlPNRKRY7HPttyBE9pbpQJK0x7DF74yoMiBOPA3Va3Qne6kQG9WNGDCa2o6TZ69
         5DwOG1hhMI7WeJBYGlH51BA9VwN41Don8nmze0bbaHFL4Z7DdvaNRNdvT+VOtpZHge
         Wyv+8nas0kuT+0rLIHXrMcrYAsZtV0KXP+wpumVM=
Authentication-Results: vla1-ce2e345b2df9.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Received: by vla5-8422ddc3185d.qloud-c.yandex.net (smtp/Yandex) with ESMTPS id P2QOEwUhYd-xuO4ICdZ;
        Tue, 16 Nov 2021 14:59:56 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Evgeny Vereshchagin <evvers@ya.ru>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, nicolas.iooss@m4x.org,
        Evgeny Vereshchagin <evvers@ya.ru>
Subject: [PATCH] ci: run the tests under ASan/UBsan on GHActions
Date:   Mon, 15 Nov 2021 18:58:29 +0000
Message-Id: <20211115185829.85614-1-evvers@ya.ru>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It was tested in https://github.com/SELinuxProject/selinux/pull/321 and
https://github.com/SELinuxProject/selinux/pull/320. In the process
it discovered a few issues all of which were fixed in
https://github.com/SELinuxProject/selinux/commit/b98d3c4c53f35cb2ab77dd5b2973591815932620
https://github.com/SELinuxProject/selinux/commit/ea539017fbbc972a8239a7944eaa5ce4960b0903
https://github.com/SELinuxProject/selinux/commit/fe01a91a79574c21712fac2c58af1b54b7f3d46b
https://github.com/SELinuxProject/selinux/commit/f95dbf2c74246f69fbdf0881434567576159e5f6

Now that all the issues are gone it should be safe to turn it on
to make it easier to automatically catch bugs like that almost as soon as
they end up in the repository.

Signed-off-by: Evgeny Vereshchagin <evvers@ya.ru>
---
 .github/workflows/run_tests.yml | 42 ++++++++++++++++++++-------------
 libsepol/tests/Makefile         | 10 ++++++--
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index ef4be8af..fd3626da 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -29,6 +29,9 @@ jobs:
             python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-bfd}
           - compiler: clang
             python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-gold}
+        include:
+          - compiler: gcc
+            python-ruby-version: {python: 3.9, ruby: 2.7, other: sanitizers}
 
     steps:
     - uses: actions/checkout@v2
@@ -88,6 +91,11 @@ jobs:
         elif [ "${{ matrix.python-ruby-version.other }}" = "test-debug" ] ; then
             # Test hat debug build works fine
             EXPLICIT_MAKE_VARS="DEBUG=1"
+        elif [ "${{ matrix.python-ruby-version.other }}" = "sanitizers" ] ; then
+            sanitizers='-fsanitize=address,undefined'
+            EXPLICIT_MAKE_VARS="CFLAGS='-g -I$DESTDIR/usr/include $sanitizers' LDFLAGS='-L$DESTDIR/usr/lib $sanitizers' LDLIBS= CPPFLAGS= OPT_SUBDIRS="
+            echo "ASAN_OPTIONS=strict_string_checks=1:detect_stack_use_after_return=1:check_initialization_order=1:strict_init_order=1" >> $GITHUB_ENV
+            echo "UBSAN_OPTIONS=print_stacktrace=1:print_summary=1:halt_on_error=1" >> $GITHUB_ENV
         else
             EXPLICIT_MAKE_VARS=
         fi
@@ -139,18 +147,18 @@ jobs:
     - name: Run tests
       run: |
         echo "::group::make install"
-        make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
+        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
         echo "::endgroup::"
         echo "::group::make install-pywrap"
-        make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
+        eval make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
         echo "::endgroup::"
         echo "::group::make install-rubywrap"
-        make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
+        eval make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
         echo "::endgroup::"
 
         # Now that everything is installed, run "make all" to build everything which may have not been built
         echo "::group::make all"
-        make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
+        eval make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
         echo "::endgroup::"
 
         # Set up environment variables for the tests and show variables (to help debugging issues)
@@ -164,19 +172,21 @@ jobs:
 
         # Run tests
         echo "::group::make test"
-        make test $EXPLICIT_MAKE_VARS
+        eval make test $EXPLICIT_MAKE_VARS
         echo "::endgroup::"
 
-        # Test Python and Ruby wrappers
-        echo "::group::Test Python and Ruby wrappers"
-        $PYTHON -c 'import selinux;import selinux.audit2why;import semanage;print(selinux.is_selinux_enabled())'
-        $RUBY -e 'require "selinux";require "semanage";puts Selinux::is_selinux_enabled()'
-        echo "::endgroup::"
-
-        # Run Python linter, but not on the downloaded refpolicy
-        echo "::group::scripts/run-flake8"
-        ./scripts/run-flake8
-        echo "::endgroup::"
+        if [ "${{ matrix.python-ruby-version.other }}" != "sanitizers" ] ; then
+            # Test Python and Ruby wrappers
+            echo "::group::Test Python and Ruby wrappers"
+            $PYTHON -c 'import selinux;import selinux.audit2why;import semanage;print(selinux.is_selinux_enabled())'
+            $RUBY -e 'require "selinux";require "semanage";puts Selinux::is_selinux_enabled()'
+            echo "::endgroup::"
+
+            # Run Python linter, but not on the downloaded refpolicy
+            echo "::group::scripts/run-flake8"
+            ./scripts/run-flake8
+            echo "::endgroup::"
+        fi
 
         echo "::group::Test .gitignore and make clean distclean"
         # Remove every installed files
@@ -184,6 +194,6 @@ jobs:
         # Test that "git status" looks clean, or print a clear error message
         git status --short | sed -n 's/^??/error: missing .gitignore entry for/p' | (! grep '^')
         # Clean up everything and show which file needs to be added to "make clean"
-        make clean distclean $EXPLICIT_MAKE_VARS
+        eval make clean distclean $EXPLICIT_MAKE_VARS
         git ls-files --ignored --others --exclude-standard | sed 's/^/error: "make clean distclean" did not remove /' | (! grep '^')
         echo "::endgroup::"
diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
index fc9bd1a3..a72c327d 100644
--- a/libsepol/tests/Makefile
+++ b/libsepol/tests/Makefile
@@ -1,3 +1,4 @@
+ENV ?= env
 M4 ?= m4
 MKDIR ?= mkdir
 EXE ?= libsepol-tests
@@ -44,10 +45,15 @@ clean:
 	rm -f $(objs) $(EXE)
 	rm -f $(policies)
 	rm -f policies/test-downgrade/policy.hi policies/test-downgrade/policy.lo
-	
 
+# mkdir is run in a clean environment created by env -i to avoid failing under ASan with:
+#
+#   ASan runtime does not come first in initial library list;
+#   you should either link runtime to your application or manually preload it with LD_PRELOAD
+#
+# when the source code is built with ASan
 test: $(EXE) $(policies)
-	$(MKDIR) -p policies/test-downgrade
+	$(ENV) -i $(MKDIR) -p policies/test-downgrade
 	../../checkpolicy/checkpolicy -M policies/test-cond/refpolicy-base.conf -o policies/test-downgrade/policy.hi	
 	./$(EXE)
 
-- 
2.31.1

