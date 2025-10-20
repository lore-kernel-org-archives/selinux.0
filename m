Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88762F8BCB
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969271; cv=none; b=sIzSkIvZ9cG4lFanpDYUFthO67PsTbTo83Lttr4OvENH/z0eqp3s1QEDJlFXKWkRY19fhQcfCIq0om2CM0IFdS/5YCZM6DFl0686ZPMl1HQFqB8pQna0BtEsn13SdcfVrxwNmOoCDNU3X4TrFK3LxYGBCf5vOdwgCVOJb23Lf2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969271; c=relaxed/simple;
	bh=81MTcHNVXXHKpjN9Y76LRyN8xnlqcM0r+fg5rgRfKqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgtRHrRzSdhDitNxTm655uU2Pkgmd3cD0iXHHiZhtjU7Qb2qgqA534cNNkydrO2ukVh9wuHbRkwlZY9HWhTPzNqdLNDpoUEwLx5rupXaLbjvOwGpxVRfnpqi1wPJpL7VFywYSPLRAVtaZwFUtDbJf1UsnUKgvfGzXJom3G4AqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZWSUPcJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZWSUPcJ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47109187c32so20917615e9.2
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760969266; x=1761574066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5gNfg4DtNeDTEvo4IQVfV0PrZtaUNl27ptNc7RNhmQ=;
        b=DZWSUPcJeU99iBHOx13Sy/sxP3OpwUN81IloxtXr0v4S0ANyigdj5DsPSt/7dzD+O/
         jBvpRXP6t/nSYXSoPaSalYypqrRVlC0/lPLAsZzVvnBDm+CaetOq65NswJl/TtLGHRNw
         uJqR5PXNuqmCjRYU98wMgqJEXI51S1bSkHxYSJLEpWpETLio8Y2R8rD9XyhjZe9WzxLK
         Wh8G2zwopQYaJwaDudA1HIvONzKHnslvPA+FaqKY3WjkbVnuZcnM130DhoRGFepLYNNk
         LY8Zum6qLHml64gZ3oXGWHNnj0r/vvTjfximap+KzKTvQ/ytp9GdnGUMfv6LsYr5etwN
         kstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969266; x=1761574066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5gNfg4DtNeDTEvo4IQVfV0PrZtaUNl27ptNc7RNhmQ=;
        b=MeQJPmBJmxvNbhXaaHobwSTjMTT1NH0kEUPTUFnz4eNFFZQqyMeE1RSuFprv/Xdi+6
         jjNQWzx7N6ie4rLwgXkXmy63EgKyP0yJKWs5SOp59ltcH/QO60pOHMHNTG6FN/7ydRXz
         5Z/GgbWLP5RRoCuoHhHC1gfBFcUSRm1RxXwmHzM/QrewZjZ68Sw/opsV2LDLvNzh4L+L
         PM+18rIuvBO5kwV5H2WiNE461CH9NXRCORRsEDbdAqKn14V0SfNCq48gXik5xPf892Bt
         joa9RAD9RrO6KWLnPsKSBa0DQhbCd+fg9PSWzt6/5qvraqwQb+6qfFcR5lDxvMfnhuNR
         +ItQ==
X-Forwarded-Encrypted: i=1; AJvYcCUERPqcc+M/+xioHYAJD8Fos/UEgGJc7JzH5zT9JyuKI90tQz8QoxdBxsodxjXbyGaBFpm67yIG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0r9rv1vMouAAELLM6BaohLMb7ihFvy5t7vOEy+CZGvLsRsn8
	HEmDlX6tBjuCwa5fsNuGAZQsVWVaGKaaR2WJCZWbzOSNBGN4Wxg9de6l
X-Gm-Gg: ASbGncuALzhx0nxzvtrIjn4sL45ZG5xJFomON0Dv7T2bgutdqngdCQLX960v7OH9yQi
	0SLV9SZkR1rbsyz9QL05evaRtuaYgpZPfA8bJXI7Xd+WfF1uvrAuYcrf1C6DPmxyjbMc3S/tMXk
	byQfqNHl8DX++uxCIysGN54xnE4V3VpiT/RosacDwYueWC1M5IJ0Eej0sw8Fez4a4/Q4BD9vcRU
	negSLivRuZhmaX6KqMHqwddlawASCcFyti2aP0H1fGxizD/Qq5UwJ3gS+fReT0iIeoOaUi5/akv
	V3eRhjPjfjVxYXfkH9BARY1DxyGPEAwMvCcAnrjrguiFilCjSNjmOrKEvoE//qMtY3r+8oolRWR
	eNGR8UeBepFdSlmTpCR77lfVz5oD2CyQv+Asr3IzFZZQZDI9WHRf/xQwLtCuUZZdz5Y48X9t0
X-Google-Smtp-Source: AGHT+IEPA09c9sRWTSe4xwJqdUL7P/e2d82KgpMCvVIa3gxywkxc9TWYOs0bh39dDG6EN0NYAvoVJA==
X-Received: by 2002:a05:600c:1396:b0:46c:adf8:c845 with SMTP id 5b1f17b1804b1-471178aba5bmr87868795e9.16.1760969266073;
        Mon, 20 Oct 2025 07:07:46 -0700 (PDT)
Received: from graphite ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm150970305e9.1.2025.10.20.07.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:07:45 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: lautrbach@redhat.com,
	nvraxn@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH v5] treewide: add .clang-format configuration file
Date: Mon, 20 Oct 2025 15:07:32 +0100
Message-ID: <20251020140732.4703-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEjxPJ5o5fdYswHkkbVbnOt-UdKP641KRDV2J7h83Fc4D3qikQ@mail.gmail.com>
References: <CAEjxPJ5o5fdYswHkkbVbnOt-UdKP641KRDV2J7h83Fc4D3qikQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently only an RFC.

Add the .clang-format configuration file, taken from the Linux kernel
repository. We don't have any official style guidelines in tree at
present, which makes it a bit unclear how to format C code for new
contributors. As well as this, different parts of the codebase seem to
been formatted with different styles on occasion, so using an automatic
formatter should resolve this.

As well as this, replace all the existing indent targets with a single
toplevel `format` target. Managing all the source files to be formatted
is not pretty to maintain, and doesn't really give us much.

Also define a toplevel `check-format` target to verify that all code is
formatted properly. This only becomes useful in the future once we have
reformatted all existing code, but is wired up for now.

For the future:
1. Reformat all existing code. I understand this is a big change, hence
   the RFC, but we may as well get all code formatted if we go down
   this route; afterall, it's not like this will cause any breaking
   changes.
2. Add a CI target to check that all code is formatted as per the new
   clang-format configuration. The `check-format` target can be used
   for this.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 .clang-format                            | 130 +++++++++++++++++++++++
 CONTRIBUTING.md                          |   2 +
 Makefile                                 |  11 +-
 checkpolicy/Makefile                     |   3 -
 gui/Makefile                             |   2 -
 libselinux/Makefile                      |   2 +-
 libselinux/include/Makefile              |   4 -
 libselinux/man/Makefile                  |   2 +-
 libselinux/src/Makefile                  |   3 -
 libselinux/utils/Makefile                |   4 -
 libsemanage/Makefile                     |   4 -
 libsemanage/include/Makefile             |   3 -
 libsemanage/src/Makefile                 |   3 -
 libsemanage/utils/Makefile               |   3 -
 libsepol/Makefile                        |   6 --
 libsepol/include/Makefile                |   3 -
 libsepol/src/Makefile                    |   4 -
 libsepol/utils/Makefile                  |   4 -
 mcstrans/src/Makefile                    |   1 -
 mcstrans/utils/Makefile                  |   1 -
 policycoreutils/Makefile                 |   2 +-
 policycoreutils/hll/Makefile             |   2 +-
 policycoreutils/hll/pp/Makefile          |   3 -
 policycoreutils/load_policy/Makefile     |   3 -
 policycoreutils/newrole/Makefile         |   3 -
 policycoreutils/run_init/Makefile        |   3 -
 policycoreutils/scripts/Makefile         |   2 -
 policycoreutils/secon/Makefile           |   3 -
 policycoreutils/semodule/Makefile        |   4 -
 policycoreutils/sestatus/Makefile        |   3 -
 policycoreutils/setfiles/Makefile        |   3 -
 policycoreutils/setsebool/Makefile       |   4 -
 policycoreutils/unsetfiles/Makefile      |   3 -
 python/Makefile                          |   2 +-
 python/audit2allow/Makefile              |   3 -
 python/chcat/Makefile                    |   2 -
 python/semanage/Makefile                 |   2 -
 python/sepolgen/Makefile                 |   5 -
 python/sepolgen/src/Makefile             |   6 --
 restorecond/Makefile                     |   3 -
 sandbox/Makefile                         |   3 -
 scripts/Lindent                          |  18 ----
 semodule-utils/Makefile                  |   2 +-
 semodule-utils/semodule_expand/Makefile  |   4 -
 semodule-utils/semodule_link/Makefile    |   4 -
 semodule-utils/semodule_package/Makefile |   4 -
 46 files changed, 148 insertions(+), 143 deletions(-)
 create mode 100644 .clang-format
 delete mode 100755 scripts/Lindent

v2: remove linux kernel ForEachMacros and replace them with ours
v3: replace the indent target with the new format target. also remove any
    mention of `.editorconfig` from the commit message; those changes are
    better suited for another patch (they're small and self-contained enough
    that they're a smaller thing to merge).
v4: drop the subdir format targets entirely, replacing with a single toplevel
    format and check-format target.
v5: add back relabel target accidently removed.

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 00000000..35595d87
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# clang-format configuration file. Intended for clang-format >= 11.
+#
+# For more information, see:
+#
+#   Documentation/dev-tools/clang-format.rst
+#   https://clang.llvm.org/docs/ClangFormat.html
+#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
+#
+---
+AccessModifierOffset: -4
+AlignAfterOpenBracket: Align
+AlignConsecutiveAssignments: false
+AlignConsecutiveDeclarations: false
+AlignEscapedNewlines: Left
+AlignOperands: true
+AlignTrailingComments: false
+AllowAllParametersOfDeclarationOnNextLine: false
+AllowShortBlocksOnASingleLine: false
+AllowShortCaseLabelsOnASingleLine: false
+AllowShortFunctionsOnASingleLine: None
+AllowShortIfStatementsOnASingleLine: false
+AllowShortLoopsOnASingleLine: false
+AlwaysBreakAfterDefinitionReturnType: None
+AlwaysBreakAfterReturnType: None
+AlwaysBreakBeforeMultilineStrings: false
+AlwaysBreakTemplateDeclarations: false
+BinPackArguments: true
+BinPackParameters: true
+BraceWrapping:
+  AfterClass: false
+  AfterControlStatement: false
+  AfterEnum: false
+  AfterFunction: true
+  AfterNamespace: true
+  AfterObjCDeclaration: false
+  AfterStruct: false
+  AfterUnion: false
+  AfterExternBlock: false
+  BeforeCatch: false
+  BeforeElse: false
+  IndentBraces: false
+  SplitEmptyFunction: true
+  SplitEmptyRecord: true
+  SplitEmptyNamespace: true
+BreakBeforeBinaryOperators: None
+BreakBeforeBraces: Custom
+BreakBeforeInheritanceComma: false
+BreakBeforeTernaryOperators: false
+BreakConstructorInitializersBeforeComma: false
+BreakConstructorInitializers: BeforeComma
+BreakAfterJavaFieldAnnotations: false
+BreakStringLiterals: false
+ColumnLimit: 80
+CommentPragmas: '^ IWYU pragma:'
+CompactNamespaces: false
+ConstructorInitializerAllOnOneLineOrOnePerLine: false
+ConstructorInitializerIndentWidth: 8
+ContinuationIndentWidth: 8
+Cpp11BracedListStyle: false
+DerivePointerAlignment: false
+DisableFormat: false
+ExperimentalAutoDetectBinPacking: false
+FixNamespaceComments: false
+
+# Taken from:
+#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' \
+#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'," \
+#   | LC_ALL=C sort -u
+ForEachMacros:
+  - 'cil_list_for_each'
+  - 'cil_stack_for_each'
+  - 'cil_stack_for_each_starting_at'
+  - 'ebitmap_for_each_bit'
+  - 'ebitmap_for_each_positive_bit'
+
+IncludeBlocks: Preserve
+IncludeCategories:
+  - Regex: '.*'
+    Priority: 1
+IncludeIsMainRegex: '(Test)?$'
+IndentCaseLabels: false
+IndentGotoLabels: false
+IndentPPDirectives: None
+IndentWidth: 8
+IndentWrappedFunctionNames: false
+JavaScriptQuotes: Leave
+JavaScriptWrapImports: true
+KeepEmptyLinesAtTheStartOfBlocks: false
+MacroBlockBegin: ''
+MacroBlockEnd: ''
+MaxEmptyLinesToKeep: 1
+NamespaceIndentation: None
+ObjCBinPackProtocolList: Auto
+ObjCBlockIndentWidth: 8
+ObjCSpaceAfterProperty: true
+ObjCSpaceBeforeProtocolList: true
+
+# Taken from git's rules
+PenaltyBreakAssignment: 10
+PenaltyBreakBeforeFirstCallParameter: 30
+PenaltyBreakComment: 10
+PenaltyBreakFirstLessLess: 0
+PenaltyBreakString: 10
+PenaltyExcessCharacter: 100
+PenaltyReturnTypeOnItsOwnLine: 60
+
+PointerAlignment: Right
+ReflowComments: false
+SortIncludes: false
+SortUsingDeclarations: false
+SpaceAfterCStyleCast: false
+SpaceAfterTemplateKeyword: true
+SpaceBeforeAssignmentOperators: true
+SpaceBeforeCtorInitializerColon: true
+SpaceBeforeInheritanceColon: true
+SpaceBeforeParens: ControlStatementsExceptForEachMacros
+SpaceBeforeRangeBasedForLoopColon: true
+SpaceInEmptyParentheses: false
+SpacesBeforeTrailingComments: 1
+SpacesInAngles: false
+SpacesInContainerLiterals: false
+SpacesInCStyleCastParentheses: false
+SpacesInParentheses: false
+SpacesInSquareBrackets: false
+Standard: Cpp03
+TabWidth: 8
+UseTab: Always
+...
diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index c501cf84..7ec8cb0f 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -53,6 +53,8 @@ When preparing patches, please follow these guidelines:
 -   Separate large patches into logical patches
 -   Patch descriptions must end with your "Signed-off-by" line. This means your
     code meets the Developer's certificate of origin, see below.
+-   C code should be formatted using clang-format, using the .clang-format
+    configuration file at the root of this repository.
 
 When adding new, large features or tools it is best to discuss the
 design on the mailing list prior to submitting the patch.
diff --git a/Makefile b/Makefile
index 2ffba8e9..972d5525 100644
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,7 @@ ifneq ($(DESTDIR),)
 	export LIBSEPOLA
 endif
 
-all install relabel clean test indent:
+all install relabel clean test:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
@@ -50,3 +50,12 @@ distclean:
 	@for subdir in $(DISTCLEANSUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
+
+# We shouldn't have any unformatted files in the repo without an explicit exception.
+FORMAT_SOURCE_FILES := $(shell find $(SUBDIRS) -type f \( -name '*.c' -o -name '*.h' \))
+
+format:
+	clang-format -i $(FORMAT_SOURCE_FILES)
+
+check-format:
+	clang-format --dry-run -Werror $(FORMAT_SOURCE_FILES)
diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 6e8008e3..0055f495 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -77,6 +77,3 @@ relabel: install
 clean:
 	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c tests/testpol.conf tests/testpol.bin
 	$(MAKE) -C test clean
-
-indent:
-	../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
diff --git a/gui/Makefile b/gui/Makefile
index b29610d4..b1a94224 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -60,8 +60,6 @@ install: all
 clean:
 	(cd po && $(MAKE) $@)
 
-indent:
-
 relabel:
 
 test:
diff --git a/libselinux/Makefile b/libselinux/Makefile
index a50b6491..aeede2b5 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -50,7 +50,7 @@ COMPILER := clang
 endif
 export COMPILER
 
-all install relabel clean distclean indent:
+all install relabel clean distclean:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
diff --git a/libselinux/include/Makefile b/libselinux/include/Makefile
index 8ab9ce92..a1e322ac 100644
--- a/libselinux/include/Makefile
+++ b/libselinux/include/Makefile
@@ -10,9 +10,5 @@ install: all
 
 relabel:
 
-indent:
-	../../scripts/Lindent $(wildcard selinux/*.h)
-
 distclean clean:
 	-rm -f selinux/*~
-
diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
index fdc0825f..42b1662a 100644
--- a/libselinux/man/Makefile
+++ b/libselinux/man/Makefile
@@ -35,4 +35,4 @@ install: all
 
 relabel:
 
-indent distclean clean:
+format distclean clean:
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 261c22d4..f7412cd1 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -223,7 +223,4 @@ clean: clean-pywrap clean-rubywrap
 distclean: clean
 	rm -f $(GENERATED) $(SWIGFILES)
 
-indent:
-	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
-
 .PHONY: all clean clean-pywrap clean-rubywrap pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 6b1dc7c9..20dc44eb 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -72,8 +72,4 @@ clean:
 
 distclean: clean
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 relabel:
-
diff --git a/libsemanage/Makefile b/libsemanage/Makefile
index dbd240da..591ce5f2 100644
--- a/libsemanage/Makefile
+++ b/libsemanage/Makefile
@@ -29,9 +29,5 @@ clean distclean:
 	$(MAKE) -C src $@
 	$(MAKE) -C tests $@
 
-indent:
-	$(MAKE) -C src $@
-	$(MAKE) -C include $@
-
 test: all
 	$(MAKE) -C tests test
diff --git a/libsemanage/include/Makefile b/libsemanage/include/Makefile
index 6e44a28a..b08e48a0 100644
--- a/libsemanage/include/Makefile
+++ b/libsemanage/include/Makefile
@@ -7,6 +7,3 @@ all:
 install: all
 	test -d $(DESTDIR)$(INCDIR) || install -m 755 -d $(DESTDIR)$(INCDIR)
 	install -m 644 $(wildcard semanage/*.h) $(DESTDIR)$(INCDIR)
-
-indent:
-	../../scripts/Lindent $(wildcard semanage/*.h)
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index fa3449fb..8e025112 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -167,7 +167,4 @@ clean:
 distclean: clean
 	rm -f $(GENERATED) $(SWIGFILES)
 
-indent:
-	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
-
 .PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
diff --git a/libsemanage/utils/Makefile b/libsemanage/utils/Makefile
index 5b8fbb6b..0f382934 100644
--- a/libsemanage/utils/Makefile
+++ b/libsemanage/utils/Makefile
@@ -13,7 +13,4 @@ clean:
 
 distclean: clean
 
-indent:
-
 relabel:
-
diff --git a/libsepol/Makefile b/libsepol/Makefile
index 5b5d03e2..223edcec 100644
--- a/libsepol/Makefile
+++ b/libsepol/Makefile
@@ -20,11 +20,5 @@ clean:
 	$(MAKE) -C utils clean
 	$(MAKE) -C tests clean
 
-indent:
-	$(MAKE) -C src $@
-	$(MAKE) -C include $@
-	$(MAKE) -C utils $@
-
 test:
 	$(MAKE) -C tests test
-
diff --git a/libsepol/include/Makefile b/libsepol/include/Makefile
index 1ad4ecab..f49b6e19 100644
--- a/libsepol/include/Makefile
+++ b/libsepol/include/Makefile
@@ -12,6 +12,3 @@ install: all
 	install -m 644 $(wildcard sepol/*.h) $(DESTDIR)$(INCDIR)
 	install -m 644 $(wildcard sepol/policydb/*.h) $(DESTDIR)$(INCDIR)/policydb
 	install -m 644 $(wildcard $(CILDIR)/include/cil/*.h) $(DESTDIR)$(INCDIR)/cil
-
-indent:
-	../../scripts/Lindent $(wildcard sepol/*.h)
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 90aed394..bb2b7f5e 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -105,7 +105,3 @@ relabel:
 
 clean: 
 	-rm -f $(LIBPC) $(LIBMAP) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) $(CIL_GENERATED)
-
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
index 31932c11..a8bedf2e 100644
--- a/libsepol/utils/Makefile
+++ b/libsepol/utils/Makefile
@@ -18,8 +18,4 @@ install: all
 clean:
 	-rm -f $(TARGETS) *.o 
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 relabel:
-
diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index 88487068..609b2d45 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -37,4 +37,3 @@ install: all
 
 clean: 
 	-rm -f $(OBJS) $(LOBJS) $(TARGET) $(PROG) $(PROG_OBJS) *~ \#*
-
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 57a73932..1d70b4ed 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -36,4 +36,3 @@ clean:
 	rm -f $(TARGETS) *.o *~ \#*
 
 relabel:
-
diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
index 7c9706e3..9186a9ef 100644
--- a/policycoreutils/Makefile
+++ b/policycoreutils/Makefile
@@ -6,7 +6,7 @@ LIBSELINUX_LDLIBS := $(shell PKG_CONFIG_PATH="$(PKG_CONFIG_PATH):../libselinux/s
 LIBSEMANAGE_LDLIBS := $(shell PKG_CONFIG_PATH="$(PKG_CONFIG_PATH):../libsemanage/src" $(PKG_CONFIG) --libs libsemanage)
 export LIBSELINUX_LDLIBS LIBSEMANAGE_LDLIBS
 
-all install relabel clean indent:
+all install relabel clean:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
diff --git a/policycoreutils/hll/Makefile b/policycoreutils/hll/Makefile
index fe720e57..390f3a34 100644
--- a/policycoreutils/hll/Makefile
+++ b/policycoreutils/hll/Makefile
@@ -1,6 +1,6 @@
 SUBDIRS = pp
 
-all install relabel clean indent:
+all install relabel clean:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
diff --git a/policycoreutils/hll/pp/Makefile b/policycoreutils/hll/pp/Makefile
index 3c9b0efc..a0d475a3 100644
--- a/policycoreutils/hll/pp/Makefile
+++ b/policycoreutils/hll/pp/Makefile
@@ -25,6 +25,3 @@ relabel:
 
 clean:
 	-rm -f pp $(PP_OBJS)
-
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index c61fee70..7754cadc 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -28,8 +28,5 @@ install: all
 clean:
 	-rm -f $(TARGETS) *.o 
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 relabel:
 	/sbin/restorecon $(DESTDIR)$(SBINDIR)/load_policy 
diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
index df64483f..fcd2661f 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -87,9 +87,6 @@ endif
 clean:
 	rm -f newrole *.o 
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 relabel: install
 	/sbin/restorecon $(DESTDIR)$(BINDIR)/newrole
 
diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
index c89fffb9..0e904dba 100644
--- a/policycoreutils/run_init/Makefile
+++ b/policycoreutils/run_init/Makefile
@@ -53,8 +53,5 @@ endif
 clean:
 	-rm -f $(TARGETS) *.o 
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 relabel: install
 	/sbin/restorecon $(DESTDIR)$(SBINDIR)/run_init $(DESTDIR)$(SBINDIR)/open_init_pty
diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts/Makefile
index 6d8196c6..1058bbab 100644
--- a/policycoreutils/scripts/Makefile
+++ b/policycoreutils/scripts/Makefile
@@ -21,6 +21,4 @@ install: all
 
 clean:
 
-indent:
-
 relabel:
diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
index c9296f19..b2f276f9 100644
--- a/policycoreutils/secon/Makefile
+++ b/policycoreutils/secon/Makefile
@@ -35,9 +35,6 @@ relabel:
 clean:
 	rm -f *.o core* secon *~ *.bak
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 bare: clean
 
 .PHONY: clean bare
diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index 018ee2ca..47bde5f8 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -35,7 +35,3 @@ relabel:
 
 clean:
 	-rm -f semodule *.o genhomedircon
-
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index 1ce617c0..70f46956 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -41,7 +41,4 @@ install: all
 clean:
 	rm -f sestatus *.o
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 relabel:
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index dab6313c..aa3e80fc 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -43,8 +43,5 @@ install: all
 clean:
 	rm -f setfiles restorecon restorecon_xattr *.o
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 relabel: install
 	$(DESTDIR)$(SBINDIR)/restorecon $(DESTDIR)$(SBINDIR)/setfiles $(DESTDIR)$(SBINDIR)/restorecon_xattr
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index 87494c55..360e0ea0 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -35,7 +35,3 @@ relabel:
 
 clean:
 	-rm -f setsebool *.o
-
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unsetfiles/Makefile
index 9cb51494..8dbf85af 100644
--- a/policycoreutils/unsetfiles/Makefile
+++ b/policycoreutils/unsetfiles/Makefile
@@ -20,8 +20,5 @@ install: all
 clean:
 	-rm -f unsetfiles *.o
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 relabel: install
 	/sbin/restorecon $(DESTDIR)$(SBINDIR)/unsetfiles
diff --git a/python/Makefile b/python/Makefile
index 00312dbd..c4c31a17 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -1,6 +1,6 @@
 SUBDIRS = sepolicy audit2allow semanage sepolgen chcat po
 
-all install relabel clean indent test:
+all install relabel clean format test:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index 28b8f7f2..90d10d1a 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -51,7 +51,4 @@ install: all
 clean:
 	rm -f *~ *.o sepolgen-ifgen-attr-helper test_dummy_policy
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 relabel: ;
diff --git a/python/chcat/Makefile b/python/chcat/Makefile
index 7b3ee17f..334b749d 100644
--- a/python/chcat/Makefile
+++ b/python/chcat/Makefile
@@ -21,8 +21,6 @@ install: all
 
 clean:
 
-indent:
-
 relabel:
 
 test:
diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 628d135a..51208d9e 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -35,6 +35,4 @@ test:
 	@$(PYTHON) test-semanage.py -a
 clean:
 
-indent:
-
 relabel:
diff --git a/python/sepolgen/Makefile b/python/sepolgen/Makefile
index 3aed3304..2ad7b13c 100644
--- a/python/sepolgen/Makefile
+++ b/python/sepolgen/Makefile
@@ -11,10 +11,5 @@ clean:
 	rm -f *~ *.pyc
 	rm -f parser.out parsetab.py
 
-indent: ;
-
 test:
 	$(MAKE) -C tests $@
-
-
-
diff --git a/python/sepolgen/src/Makefile b/python/sepolgen/src/Makefile
index 2815a13d..a2456652 100644
--- a/python/sepolgen/src/Makefile
+++ b/python/sepolgen/src/Makefile
@@ -12,10 +12,4 @@ clean:
 	rm -f *~ *.pyc
 	rm -f parser.out parsetab.py
 
-indent: ;
-
-
 test: ;
-
-
-
diff --git a/restorecond/Makefile b/restorecond/Makefile
index b8b86eb4..51eb7608 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -59,7 +59,4 @@ relabel: install
 clean:
 	-rm -f restorecond *.o *~
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 test:
diff --git a/sandbox/Makefile b/sandbox/Makefile
index 0799ab7c..eaaad75c 100644
--- a/sandbox/Makefile
+++ b/sandbox/Makefile
@@ -50,7 +50,4 @@ clean:
 	-rm -f seunshare *.o *~
 	(cd po && $(MAKE) $@)
 
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
 relabel:
diff --git a/scripts/Lindent b/scripts/Lindent
deleted file mode 100755
index 9c4b3e2b..00000000
--- a/scripts/Lindent
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-PARAM="-npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1"
-RES=`indent --version`
-V1=`echo $RES | cut -d' ' -f3 | cut -d'.' -f1`
-V2=`echo $RES | cut -d' ' -f3 | cut -d'.' -f2`
-V3=`echo $RES | cut -d' ' -f3 | cut -d'.' -f3`
-if [ $V1 -gt 2 ]; then
-  PARAM="$PARAM -il0"
-elif [ $V1 -eq 2 ]; then
-  if [ $V2 -gt 2 ]; then
-    PARAM="$PARAM -il0";
-  elif [ $V2 -eq 2 ]; then
-    if [ $V3 -ge 10 ]; then
-      PARAM="$PARAM -il0"
-    fi
-  fi
-fi
-indent $PARAM "$@"
diff --git a/semodule-utils/Makefile b/semodule-utils/Makefile
index e0a65792..81c97af0 100644
--- a/semodule-utils/Makefile
+++ b/semodule-utils/Makefile
@@ -1,6 +1,6 @@
 SUBDIRS = semodule_package semodule_link semodule_expand
 
-all install relabel clean indent:
+all install relabel clean:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-utils/semodule_expand/Makefile
index ad776b15..72f09a46 100644
--- a/semodule-utils/semodule_expand/Makefile
+++ b/semodule-utils/semodule_expand/Makefile
@@ -27,7 +27,3 @@ relabel:
 
 clean:
 	-rm -f semodule_expand *.o
-
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
diff --git a/semodule-utils/semodule_link/Makefile b/semodule-utils/semodule_link/Makefile
index 936d161c..83590c07 100644
--- a/semodule-utils/semodule_link/Makefile
+++ b/semodule-utils/semodule_link/Makefile
@@ -27,7 +27,3 @@ relabel:
 
 clean:
 	-rm -f semodule_link *.o
-
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
diff --git a/semodule-utils/semodule_package/Makefile b/semodule-utils/semodule_package/Makefile
index 6a289f73..2465f987 100644
--- a/semodule-utils/semodule_package/Makefile
+++ b/semodule-utils/semodule_package/Makefile
@@ -29,7 +29,3 @@ relabel:
 
 clean:
 	-rm -f semodule_package semodule_unpackage *.o
-
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
-- 
2.51.0

