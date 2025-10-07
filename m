Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811BB165F16
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835254; cv=none; b=fXnJb0p2K/JZU9CuHCRkPKP6R3nbhwIDqFueLtJPNFNlCGXl7UnwjJWKKxzZsI/4P9QLDG0ko5JgkylXABFKfHKd2q3/uuCQcw8ZzD4ZftcVRdmXrjFqf6gOVfzlvj3IG+yiEj+1VQt7p6bktQs1Cap5yGLuHsu8EB34nD1A3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835254; c=relaxed/simple;
	bh=KRzIfDwHdHVkEUOCQUbW16gL3mkHJiP1KBsbe4ziWf0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 In-Reply-To; b=t9AkhNXxowwTZtYVeU1EFceyqO5Id3AvtwvFqQPp0sX8LFCViTZbg469JDG6B+TAgTuYrs6PF3yUrIZqOlJzHo8CXcdRM6V4znch3RFM1Jv0qy4j+z2b0hsjK1SNSzcUDNHo3S+Pf2LvxMffr5C7HAcwma6pqOievOFDzKqMPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLZhy94r; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLZhy94r"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-330d1565844so3970358fac.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 04:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759835250; x=1760440050; darn=vger.kernel.org;
        h=in-reply-to:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIyJ3/dEmBU4jfoUbZ3qvnXvhM7oKgBBmzSDi1yaD7c=;
        b=hLZhy94ri4C1lFLVnzxOzFWncUPrDsWzOeZ4B1woHis0IuiEb8beub0ylLcKyY5sBK
         3pZDk0zEF0Y+kH1NotatafaBcu/xvFgFkTN2B4ddYEtBa4C5oh3qP2bVu4OmEGm69RYc
         vj/oZgMR8CuQ6lHaEw5QlliRNlCZApjZnUzcaML46X00WVgG/Cw1Gm8FURrpl6OUSULu
         DRGCid+1OXO/uQcNxY2vCk8gaExvkkktjDrAsJSS9LjqadsZ6kAq3fooSBOna8GCFv1a
         Bobv+leMROArEVXxC115PhrCV0YnE48ruG/bWQWAT4X+Q3XKgNP6G/JZs3zsx+2c3xOg
         My3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759835250; x=1760440050;
        h=in-reply-to:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fIyJ3/dEmBU4jfoUbZ3qvnXvhM7oKgBBmzSDi1yaD7c=;
        b=FdET95R8eStHWRN+vHmSQwC5rr/br5Ujc5HqpKvN3K3LqZ9n6GcpHtFozepD0RDMXO
         kwIg48QhqJ4eTzcZgg9YQj7tILHO8j27eQ5Qx9ryFin+cj8RgDKqc8x0k9ekRTn2iktB
         RFopMChC1NYyGOkscrJ96H+EJ8MFdyVSJ2ZWd186xDoJbzqwOfd2yrQExtwsYGPjuLpW
         sK0ETW6gKlSxnsItpplouE+eLKd1KmXdljZbNHgNySJ41KiFQdjSF3cEtGvwdx20jpiG
         q/T444pIJN6USc+3m4e36MgwQgEVzSPChqqD2Le8z388Ot+4VG/V+Ann9t/SFUY+TzH0
         GjFA==
X-Forwarded-Encrypted: i=1; AJvYcCWUl1gBWRE0s2ZlzD4m8A+nLDGydOGvU2Jb3YdMtz2TUVkbagCOq61JrXdXj6T032hYK3xVz0cO@vger.kernel.org
X-Gm-Message-State: AOJu0YzZf5uYg1YWrgW21OLoADDjrvZ4v+IZ6gkkZQv2dYVuVjwqoRcA
	FQum8NsDiGNWrGMlcvb0Q3V4yelRIzLt0GvgyVmhcLPdZReVT3w3QDBq
X-Gm-Gg: ASbGncvSJ0KDXNDHGuiC2Ma++VNF6YQr6ge3ZYvSYmvWEqHja3HcsGOpXHtUk7VCSgu
	cKWEbcXf5k8XXsUiBUGQHmFvbK5lUukgrsCV8ifgXTaeNSiR2boA1oVEZljzbzKwL6PdhhxB5Je
	37VidTpOQ6yZFhbZztbUfIGd4oWCNMMBfyVJdHx3mFPcc7LtAH2kdeqs1j91kmsmD5Lhp4pc3RR
	UEAtMVrk8HgvVn0gnWI4Z+Nmy8LNIQuzaIC+QGy2YTnBsv1vnSZyVDfO7ihaBUzlFZe7rwDT9eD
	Jw6X/5c8I5S5LcAuAZpXzKMBwEj1Epn5ol/4i2DEkkGJqvx8as8CeMEBvyIf/ZFWzZxNxrE=
X-Google-Smtp-Source: AGHT+IH5P+DMNVS8yhCE3w2ye4XcN6T9vn8pSYChhDWr8nPh1PaEA/wdhM/wIJ+1mww5OYK8/e4ePQ==
X-Received: by 2002:a05:6870:459f:b0:35b:a4be:c076 with SMTP id 586e51a60fabf-3b0fbe75f1bmr7173044fac.3.1759835250384;
        Tue, 07 Oct 2025 04:07:30 -0700 (PDT)
Received: from localhost ([95.173.217.66])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ab8df1429fsm4825613fac.15.2025.10.07.04.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 04:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Oct 2025 12:07:18 +0100
Message-Id: <DDC1IZN24NIU.YAASI575IJPX@gmail.com>
To: <nvraxn@gmail.com>
Cc: <lautrbach@redhat.com>, <selinux@vger.kernel.org>,
 <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3] treewide: add .clang-format configuration file
From: "Rahul Sandhu" <nvraxn@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <20251007104656.479127-1-nvraxn@gmail.com>

On Tue Oct 7, 2025 at 11:46 AM, Rahul Sandhu wrote:
>
>Currently only an RFC.
>
>Add the .clang-format configuration file, taken from the Linux kernel
>repository. We don't have any official style guidelines in tree at
>present, which makes it a bit unclear how to format C code for new
>contributors. As well as this, different parts of the codebase seem to
>been formatted with different styles on occasion, so using an automatic
>formatter should resolve this.
>
>As well as this, replace all the existing indent targets with format
>targets. Commands used to find and replace those targets:
>
>git grep -l -E '(\.\./)*scripts/Lindent' | xargs sed -i -E 's@(\.\./)*scri=
pts/Lindent@clang-format -i@g'
>git grep -l 'indent' -- '*Makefile' | xargs sed -i 's/indent/format/g'
>
>Also add some empty format targets to Makefiles that previously were
>missing an indent target so that `make format` does not error.
>
>A few other things to consider to do in the future:
>1. Reformat all existing code. I understand this is a big change, hence
>   the RFC, but we may as well get all code formatted if we go down
>   this route; afterall, it's not like this will cause any breaking
>   changes.
>2. Possibly add a CI target to check that all code is formatted as per
>   the new clang-format configuration? The options `--dry-run` as well
>   as `-Werror` can be passed to clang-format for this.
>
>Comments/feedback appreciated, thanks.
>
>Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>---
> .clang-format                            | 130 +++++++++++++++++++++++
> CONTRIBUTING.md                          |   2 +
> Makefile                                 |   2 +-
> checkpolicy/Makefile                     |   4 +-
> dbus/Makefile                            |   2 +
> gui/Makefile                             |   2 +-
> libselinux/Makefile                      |   2 +-
> libselinux/include/Makefile              |   4 +-
> libselinux/man/Makefile                  |   2 +-
> libselinux/src/Makefile                  |   4 +-
> libselinux/utils/Makefile                |   4 +-
> libsemanage/Makefile                     |   2 +-
> libsemanage/include/Makefile             |   4 +-
> libsemanage/src/Makefile                 |   4 +-
> libsemanage/utils/Makefile               |   2 +-
> libsepol/Makefile                        |   2 +-
> libsepol/include/Makefile                |   4 +-
> libsepol/src/Makefile                    |   4 +-
> libsepol/utils/Makefile                  |   4 +-
> mcstrans/Makefile                        |   2 +
> policycoreutils/Makefile                 |   2 +-
> policycoreutils/hll/Makefile             |   2 +-
> policycoreutils/hll/pp/Makefile          |   4 +-
> policycoreutils/load_policy/Makefile     |   4 +-
> policycoreutils/man/Makefile             |   2 +
> policycoreutils/newrole/Makefile         |   4 +-
> policycoreutils/po/Makefile              |   2 +
> policycoreutils/run_init/Makefile        |   4 +-
> policycoreutils/scripts/Makefile         |   2 +-
> policycoreutils/secon/Makefile           |   4 +-
> policycoreutils/semodule/Makefile        |   4 +-
> policycoreutils/sestatus/Makefile        |   4 +-
> policycoreutils/setfiles/Makefile        |   4 +-
> policycoreutils/setsebool/Makefile       |   4 +-
> policycoreutils/unsetfiles/Makefile      |   4 +-
> python/Makefile                          |   2 +-
> python/audit2allow/Makefile              |   4 +-
> python/chcat/Makefile                    |   2 +-
> python/po/Makefile                       |   2 +
> python/semanage/Makefile                 |   2 +-
> python/sepolgen/Makefile                 |   2 +-
> python/sepolgen/src/Makefile             |   2 +-
> python/sepolicy/Makefile                 |   2 +
> restorecond/Makefile                     |   4 +-
> sandbox/Makefile                         |   4 +-
> scripts/Lindent                          |  18 ----
> secilc/Makefile                          |   2 +
> semodule-utils/Makefile                  |   2 +-
> semodule-utils/semodule_expand/Makefile  |   4 +-
> semodule-utils/semodule_link/Makefile    |   4 +-
> semodule-utils/semodule_package/Makefile |   4 +-
> 51 files changed, 212 insertions(+), 84 deletions(-)
> create mode 100644 .clang-format
> delete mode 100755 scripts/Lindent
>
>v2: remove linux kernel ForEachMacros and replace them with ours
>v3: replace the indent target with the new format target. also remove any
>    mention of `.editorconfig` from the commit message; those changes are
>    better suited for another patch (they're small and self-contained enou=
gh
>    that they're a smaller thing to merge).
>
>diff --git a/.clang-format b/.clang-format
>new file mode 100644
>index 00000000..35595d87
>--- /dev/null
>+++ b/.clang-format
>@@ -0,0 +1,130 @@
>+# SPDX-License-Identifier: GPL-2.0
>+#
>+# clang-format configuration file. Intended for clang-format >=3D 11.
>+#
>+# For more information, see:
>+#
>+#   Documentation/dev-tools/clang-format.rst
>+#   https://clang.llvm.org/docs/ClangFormat.html
>+#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
>+#
>+---
>+AccessModifierOffset: -4
>+AlignAfterOpenBracket: Align
>+AlignConsecutiveAssignments: false
>+AlignConsecutiveDeclarations: false
>+AlignEscapedNewlines: Left
>+AlignOperands: true
>+AlignTrailingComments: false
>+AllowAllParametersOfDeclarationOnNextLine: false
>+AllowShortBlocksOnASingleLine: false
>+AllowShortCaseLabelsOnASingleLine: false
>+AllowShortFunctionsOnASingleLine: None
>+AllowShortIfStatementsOnASingleLine: false
>+AllowShortLoopsOnASingleLine: false
>+AlwaysBreakAfterDefinitionReturnType: None
>+AlwaysBreakAfterReturnType: None
>+AlwaysBreakBeforeMultilineStrings: false
>+AlwaysBreakTemplateDeclarations: false
>+BinPackArguments: true
>+BinPackParameters: true
>+BraceWrapping:
>+  AfterClass: false
>+  AfterControlStatement: false
>+  AfterEnum: false
>+  AfterFunction: true
>+  AfterNamespace: true
>+  AfterObjCDeclaration: false
>+  AfterStruct: false
>+  AfterUnion: false
>+  AfterExternBlock: false
>+  BeforeCatch: false
>+  BeforeElse: false
>+  IndentBraces: false
>+  SplitEmptyFunction: true
>+  SplitEmptyRecord: true
>+  SplitEmptyNamespace: true
>+BreakBeforeBinaryOperators: None
>+BreakBeforeBraces: Custom
>+BreakBeforeInheritanceComma: false
>+BreakBeforeTernaryOperators: false
>+BreakConstructorInitializersBeforeComma: false
>+BreakConstructorInitializers: BeforeComma
>+BreakAfterJavaFieldAnnotations: false
>+BreakStringLiterals: false
>+ColumnLimit: 80
>+CommentPragmas: '^ IWYU pragma:'
>+CompactNamespaces: false
>+ConstructorInitializerAllOnOneLineOrOnePerLine: false
>+ConstructorInitializerIndentWidth: 8
>+ContinuationIndentWidth: 8
>+Cpp11BracedListStyle: false
>+DerivePointerAlignment: false
>+DisableFormat: false
>+ExperimentalAutoDetectBinPacking: false
>+FixNamespaceComments: false
>+
>+# Taken from:
>+#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' \
>+#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'=
," \
>+#   | LC_ALL=3DC sort -u
>+ForEachMacros:
>+  - 'cil_list_for_each'
>+  - 'cil_stack_for_each'
>+  - 'cil_stack_for_each_starting_at'
>+  - 'ebitmap_for_each_bit'
>+  - 'ebitmap_for_each_positive_bit'
>+
>+IncludeBlocks: Preserve
>+IncludeCategories:
>+  - Regex: '.*'
>+    Priority: 1
>+IncludeIsMainRegex: '(Test)?$'
>+IndentCaseLabels: false
>+IndentGotoLabels: false
>+IndentPPDirectives: None
>+IndentWidth: 8
>+IndentWrappedFunctionNames: false
>+JavaScriptQuotes: Leave
>+JavaScriptWrapImports: true
>+KeepEmptyLinesAtTheStartOfBlocks: false
>+MacroBlockBegin: ''
>+MacroBlockEnd: ''
>+MaxEmptyLinesToKeep: 1
>+NamespaceIndentation: None
>+ObjCBinPackProtocolList: Auto
>+ObjCBlockIndentWidth: 8
>+ObjCSpaceAfterProperty: true
>+ObjCSpaceBeforeProtocolList: true
>+
>+# Taken from git's rules
>+PenaltyBreakAssignment: 10
>+PenaltyBreakBeforeFirstCallParameter: 30
>+PenaltyBreakComment: 10
>+PenaltyBreakFirstLessLess: 0
>+PenaltyBreakString: 10
>+PenaltyExcessCharacter: 100
>+PenaltyReturnTypeOnItsOwnLine: 60
>+
>+PointerAlignment: Right
>+ReflowComments: false
>+SortIncludes: false
>+SortUsingDeclarations: false
>+SpaceAfterCStyleCast: false
>+SpaceAfterTemplateKeyword: true
>+SpaceBeforeAssignmentOperators: true
>+SpaceBeforeCtorInitializerColon: true
>+SpaceBeforeInheritanceColon: true
>+SpaceBeforeParens: ControlStatementsExceptForEachMacros
>+SpaceBeforeRangeBasedForLoopColon: true
>+SpaceInEmptyParentheses: false
>+SpacesBeforeTrailingComments: 1
>+SpacesInAngles: false
>+SpacesInContainerLiterals: false
>+SpacesInCStyleCastParentheses: false
>+SpacesInParentheses: false
>+SpacesInSquareBrackets: false
>+Standard: Cpp03
>+TabWidth: 8
>+UseTab: Always
>+...
>diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
>index c501cf84..7ec8cb0f 100644
>--- a/CONTRIBUTING.md
>+++ b/CONTRIBUTING.md
>@@ -53,6 +53,8 @@ When preparing patches, please follow these guidelines:
> -   Separate large patches into logical patches
> -   Patch descriptions must end with your "Signed-off-by" line. This mean=
s your
>     code meets the Developer's certificate of origin, see below.
>+-   C code should be formatted using clang-format, using the .clang-forma=
t
>+    configuration file at the root of this repository.
>=20
> When adding new, large features or tools it is best to discuss the
> design on the mailing list prior to submitting the patch.
>diff --git a/Makefile b/Makefile
>index 2ffba8e9..db065aa4 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -36,7 +36,7 @@ ifneq ($(DESTDIR),)
> 	export LIBSEPOLA
> endif
>=20
>-all install relabel clean test indent:
>+all install relabel clean test format:
> 	@for subdir in $(SUBDIRS); do \
> 		(cd $$subdir && $(MAKE) $@) || exit 1; \
> 	done
>diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
>index 6e8008e3..edc5a30e 100644
>--- a/checkpolicy/Makefile
>+++ b/checkpolicy/Makefile
>@@ -78,5 +78,5 @@ clean:
> 	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy=
.c tests/testpol.conf tests/testpol.bin
> 	$(MAKE) -C test clean
>=20
>-indent:
>-	../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
>+format:
>+	clang-format -i $(filter-out $(GENERATED),$(wildcard *.[ch]))
>diff --git a/dbus/Makefile b/dbus/Makefile
>index 53143aff..a6d77d6e 100644
>--- a/dbus/Makefile
>+++ b/dbus/Makefile
>@@ -16,4 +16,6 @@ install:
>=20
> relabel:
>=20
>+format:
>+
> test:
>diff --git a/gui/Makefile b/gui/Makefile
>index b29610d4..9ffa3604 100644
>--- a/gui/Makefile
>+++ b/gui/Makefile
>@@ -60,7 +60,7 @@ install: all
> clean:
> 	(cd po && $(MAKE) $@)
>=20
>-indent:
>+format:
>=20
> relabel:
>=20
>diff --git a/libselinux/Makefile b/libselinux/Makefile
>index a50b6491..e863e2e5 100644
>--- a/libselinux/Makefile
>+++ b/libselinux/Makefile
>@@ -50,7 +50,7 @@ COMPILER :=3D clang
> endif
> export COMPILER
>=20
>-all install relabel clean distclean indent:
>+all install relabel clean distclean format:
> 	@for subdir in $(SUBDIRS); do \
> 		(cd $$subdir && $(MAKE) $@) || exit 1; \
> 	done
>diff --git a/libselinux/include/Makefile b/libselinux/include/Makefile
>index 8ab9ce92..0ff28d1d 100644
>--- a/libselinux/include/Makefile
>+++ b/libselinux/include/Makefile
>@@ -10,8 +10,8 @@ install: all
>=20
> relabel:
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard selinux/*.h)
>+format:
>+	clang-format -i $(wildcard selinux/*.h)
>=20
> distclean clean:
> 	-rm -f selinux/*~
>diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
>index fdc0825f..42b1662a 100644
>--- a/libselinux/man/Makefile
>+++ b/libselinux/man/Makefile
>@@ -35,4 +35,4 @@ install: all
>=20
> relabel:
>=20
>-indent distclean clean:
>+format distclean clean:
>diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>index 261c22d4..55520025 100644
>--- a/libselinux/src/Makefile
>+++ b/libselinux/src/Makefile
>@@ -223,7 +223,7 @@ clean: clean-pywrap clean-rubywrap
> distclean: clean
> 	rm -f $(GENERATED) $(SWIGFILES)
>=20
>-indent:
>-	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
>+format:
>+	clang-format -i $(filter-out $(GENERATED),$(wildcard *.[ch]))
>=20
> .PHONY: all clean clean-pywrap clean-rubywrap pywrap rubywrap swigify ins=
tall install-pywrap install-rubywrap distclean
>diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
>index 6b1dc7c9..5213de8e 100644
>--- a/libselinux/utils/Makefile
>+++ b/libselinux/utils/Makefile
>@@ -72,8 +72,8 @@ clean:
>=20
> distclean: clean
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> relabel:
>=20
>diff --git a/libsemanage/Makefile b/libsemanage/Makefile
>index dbd240da..e363cdde 100644
>--- a/libsemanage/Makefile
>+++ b/libsemanage/Makefile
>@@ -29,7 +29,7 @@ clean distclean:
> 	$(MAKE) -C src $@
> 	$(MAKE) -C tests $@
>=20
>-indent:
>+format:
> 	$(MAKE) -C src $@
> 	$(MAKE) -C include $@
>=20
>diff --git a/libsemanage/include/Makefile b/libsemanage/include/Makefile
>index 6e44a28a..b2c195c5 100644
>--- a/libsemanage/include/Makefile
>+++ b/libsemanage/include/Makefile
>@@ -8,5 +8,5 @@ install: all
> 	test -d $(DESTDIR)$(INCDIR) || install -m 755 -d $(DESTDIR)$(INCDIR)
> 	install -m 644 $(wildcard semanage/*.h) $(DESTDIR)$(INCDIR)
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard semanage/*.h)
>+format:
>+	clang-format -i $(wildcard semanage/*.h)
>diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
>index fa3449fb..f2d8e634 100644
>--- a/libsemanage/src/Makefile
>+++ b/libsemanage/src/Makefile
>@@ -167,7 +167,7 @@ clean:
> distclean: clean
> 	rm -f $(GENERATED) $(SWIGFILES)
>=20
>-indent:
>-	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
>+format:
>+	clang-format -i $(filter-out $(GENERATED),$(wildcard *.[ch]))
>=20
> .PHONY: all clean pywrap rubywrap swigify install install-pywrap install-=
rubywrap distclean
>diff --git a/libsemanage/utils/Makefile b/libsemanage/utils/Makefile
>index 5b8fbb6b..94d576d9 100644
>--- a/libsemanage/utils/Makefile
>+++ b/libsemanage/utils/Makefile
>@@ -13,7 +13,7 @@ clean:
>=20
> distclean: clean
>=20
>-indent:
>+format:
>=20
> relabel:
>=20
>diff --git a/libsepol/Makefile b/libsepol/Makefile
>index 5b5d03e2..2af93ace 100644
>--- a/libsepol/Makefile
>+++ b/libsepol/Makefile
>@@ -20,7 +20,7 @@ clean:
> 	$(MAKE) -C utils clean
> 	$(MAKE) -C tests clean
>=20
>-indent:
>+format:
> 	$(MAKE) -C src $@
> 	$(MAKE) -C include $@
> 	$(MAKE) -C utils $@
>diff --git a/libsepol/include/Makefile b/libsepol/include/Makefile
>index 1ad4ecab..fa8a96d6 100644
>--- a/libsepol/include/Makefile
>+++ b/libsepol/include/Makefile
>@@ -13,5 +13,5 @@ install: all
> 	install -m 644 $(wildcard sepol/policydb/*.h) $(DESTDIR)$(INCDIR)/policy=
db
> 	install -m 644 $(wildcard $(CILDIR)/include/cil/*.h) $(DESTDIR)$(INCDIR)=
/cil
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard sepol/*.h)
>+format:
>+	clang-format -i $(wildcard sepol/*.h)
>diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
>index a1aed072..86404f4b 100644
>--- a/libsepol/src/Makefile
>+++ b/libsepol/src/Makefile
>@@ -104,6 +104,6 @@ relabel:
> clean:=20
> 	-rm -f $(LIBPC) $(LIBMAP) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) $(=
CIL_GENERATED)
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
>diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
>index 31932c11..0824f64f 100644
>--- a/libsepol/utils/Makefile
>+++ b/libsepol/utils/Makefile
>@@ -18,8 +18,8 @@ install: all
> clean:
> 	-rm -f $(TARGETS) *.o=20
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> relabel:
>=20
>diff --git a/mcstrans/Makefile b/mcstrans/Makefile
>index b20279ab..28d8c7bc 100644
>--- a/mcstrans/Makefile
>+++ b/mcstrans/Makefile
>@@ -21,4 +21,6 @@ clean:
>=20
> relabel:
>=20
>+format:
>+
> test:
>diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
>index 7c9706e3..212fbf22 100644
>--- a/policycoreutils/Makefile
>+++ b/policycoreutils/Makefile
>@@ -6,7 +6,7 @@ LIBSELINUX_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D"$(PKG_CO=
NFIG_PATH):../libselinux/s
> LIBSEMANAGE_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D"$(PKG_CONFIG_PATH):../=
libsemanage/src" $(PKG_CONFIG) --libs libsemanage)
> export LIBSELINUX_LDLIBS LIBSEMANAGE_LDLIBS
>=20
>-all install relabel clean indent:
>+all install relabel clean format:
> 	@for subdir in $(SUBDIRS); do \
> 		(cd $$subdir && $(MAKE) $@) || exit 1; \
> 	done
>diff --git a/policycoreutils/hll/Makefile b/policycoreutils/hll/Makefile
>index fe720e57..fc3f54db 100644
>--- a/policycoreutils/hll/Makefile
>+++ b/policycoreutils/hll/Makefile
>@@ -1,6 +1,6 @@
> SUBDIRS =3D pp
>=20
>-all install relabel clean indent:
>+all install relabel clean format:
> 	@for subdir in $(SUBDIRS); do \
> 		(cd $$subdir && $(MAKE) $@) || exit 1; \
> 	done
>diff --git a/policycoreutils/hll/pp/Makefile b/policycoreutils/hll/pp/Make=
file
>index 3c9b0efc..2aed5ffa 100644
>--- a/policycoreutils/hll/pp/Makefile
>+++ b/policycoreutils/hll/pp/Makefile
>@@ -26,5 +26,5 @@ relabel:
> clean:
> 	-rm -f pp $(PP_OBJS)
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_p=
olicy/Makefile
>index c61fee70..0359719e 100644
>--- a/policycoreutils/load_policy/Makefile
>+++ b/policycoreutils/load_policy/Makefile
>@@ -28,8 +28,8 @@ install: all
> clean:
> 	-rm -f $(TARGETS) *.o=20
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> relabel:
> 	/sbin/restorecon $(DESTDIR)$(SBINDIR)/load_policy=20
>diff --git a/policycoreutils/man/Makefile b/policycoreutils/man/Makefile
>index a4539f24..1f4ae9c7 100644
>--- a/policycoreutils/man/Makefile
>+++ b/policycoreutils/man/Makefile
>@@ -19,3 +19,5 @@ install: all
> 	done
>=20
> relabel:
>+
>+format:
>diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Ma=
kefile
>index df64483f..6081da3f 100644
>--- a/policycoreutils/newrole/Makefile
>+++ b/policycoreutils/newrole/Makefile
>@@ -87,8 +87,8 @@ endif
> clean:
> 	rm -f newrole *.o=20
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> relabel: install
> 	/sbin/restorecon $(DESTDIR)$(BINDIR)/newrole
>diff --git a/policycoreutils/po/Makefile b/policycoreutils/po/Makefile
>index 5ff92bff..14e711db 100644
>--- a/policycoreutils/po/Makefile
>+++ b/policycoreutils/po/Makefile
>@@ -81,4 +81,6 @@ report:
>=20
> relabel:
>=20
>+format:
>+
> test:
>diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/=
Makefile
>index c89fffb9..f22e6c24 100644
>--- a/policycoreutils/run_init/Makefile
>+++ b/policycoreutils/run_init/Makefile
>@@ -53,8 +53,8 @@ endif
> clean:
> 	-rm -f $(TARGETS) *.o=20
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> relabel: install
> 	/sbin/restorecon $(DESTDIR)$(SBINDIR)/run_init $(DESTDIR)$(SBINDIR)/open=
_init_pty
>diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts/Ma=
kefile
>index 6d8196c6..01957b5e 100644
>--- a/policycoreutils/scripts/Makefile
>+++ b/policycoreutils/scripts/Makefile
>@@ -21,6 +21,6 @@ install: all
>=20
> clean:
>=20
>-indent:
>+format:
>=20
> relabel:
>diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefi=
le
>index c9296f19..ac978a1d 100644
>--- a/policycoreutils/secon/Makefile
>+++ b/policycoreutils/secon/Makefile
>@@ -35,8 +35,8 @@ relabel:
> clean:
> 	rm -f *.o core* secon *~ *.bak
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> bare: clean
>=20
>diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/=
Makefile
>index 018ee2ca..372e8647 100644
>--- a/policycoreutils/semodule/Makefile
>+++ b/policycoreutils/semodule/Makefile
>@@ -36,6 +36,6 @@ relabel:
> clean:
> 	-rm -f semodule *.o genhomedircon
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
>diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/=
Makefile
>index 1ce617c0..0f3c2b83 100644
>--- a/policycoreutils/sestatus/Makefile
>+++ b/policycoreutils/sestatus/Makefile
>@@ -41,7 +41,7 @@ install: all
> clean:
> 	rm -f sestatus *.o
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> relabel:
>diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/=
Makefile
>index dab6313c..1029c4b7 100644
>--- a/policycoreutils/setfiles/Makefile
>+++ b/policycoreutils/setfiles/Makefile
>@@ -43,8 +43,8 @@ install: all
> clean:
> 	rm -f setfiles restorecon restorecon_xattr *.o
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> relabel: install
> 	$(DESTDIR)$(SBINDIR)/restorecon $(DESTDIR)$(SBINDIR)/setfiles $(DESTDIR)=
$(SBINDIR)/restorecon_xattr
>diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setseboo=
l/Makefile
>index 87494c55..5283b788 100644
>--- a/policycoreutils/setsebool/Makefile
>+++ b/policycoreutils/setsebool/Makefile
>@@ -36,6 +36,6 @@ relabel:
> clean:
> 	-rm -f setsebool *.o
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
>diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unsetfi=
les/Makefile
>index 9cb51494..714fa4dd 100644
>--- a/policycoreutils/unsetfiles/Makefile
>+++ b/policycoreutils/unsetfiles/Makefile
>@@ -20,8 +20,8 @@ install: all
> clean:
> 	-rm -f unsetfiles *.o
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> relabel: install
> 	/sbin/restorecon $(DESTDIR)$(SBINDIR)/unsetfiles
>diff --git a/python/Makefile b/python/Makefile
>index 00312dbd..c4c31a17 100644
>--- a/python/Makefile
>+++ b/python/Makefile
>@@ -1,6 +1,6 @@
> SUBDIRS =3D sepolicy audit2allow semanage sepolgen chcat po
>=20
>-all install relabel clean indent test:
>+all install relabel clean format test:
> 	@for subdir in $(SUBDIRS); do \
> 		(cd $$subdir && $(MAKE) $@) || exit 1; \
> 	done
>diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
>index 28b8f7f2..427007b6 100644
>--- a/python/audit2allow/Makefile
>+++ b/python/audit2allow/Makefile
>@@ -51,7 +51,7 @@ install: all
> clean:
> 	rm -f *~ *.o sepolgen-ifgen-attr-helper test_dummy_policy
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> relabel: ;
>diff --git a/python/chcat/Makefile b/python/chcat/Makefile
>index 7b3ee17f..376c1978 100644
>--- a/python/chcat/Makefile
>+++ b/python/chcat/Makefile
>@@ -21,7 +21,7 @@ install: all
>=20
> clean:
>=20
>-indent:
>+format:
>=20
> relabel:
>=20
>diff --git a/python/po/Makefile b/python/po/Makefile
>index 3ff9a47d..ca62356f 100644
>--- a/python/po/Makefile
>+++ b/python/po/Makefile
>@@ -82,4 +82,6 @@ report:
>=20
> relabel:
>=20
>+format:
>+
> test:
>diff --git a/python/semanage/Makefile b/python/semanage/Makefile
>index 628d135a..54fa8146 100644
>--- a/python/semanage/Makefile
>+++ b/python/semanage/Makefile
>@@ -35,6 +35,6 @@ test:
> 	@$(PYTHON) test-semanage.py -a
> clean:
>=20
>-indent:
>+format:
>=20
> relabel:
>diff --git a/python/sepolgen/Makefile b/python/sepolgen/Makefile
>index 3aed3304..a4a3b99e 100644
>--- a/python/sepolgen/Makefile
>+++ b/python/sepolgen/Makefile
>@@ -11,7 +11,7 @@ clean:
> 	rm -f *~ *.pyc
> 	rm -f parser.out parsetab.py
>=20
>-indent: ;
>+format: ;
>=20
> test:
> 	$(MAKE) -C tests $@
>diff --git a/python/sepolgen/src/Makefile b/python/sepolgen/src/Makefile
>index 2815a13d..72e8b356 100644
>--- a/python/sepolgen/src/Makefile
>+++ b/python/sepolgen/src/Makefile
>@@ -12,7 +12,7 @@ clean:
> 	rm -f *~ *.pyc
> 	rm -f parser.out parsetab.py
>=20
>-indent: ;
>+format: ;
>=20
>=20
> test: ;
>diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
>index 1a26cfdc..8147d423 100644
>--- a/python/sepolicy/Makefile
>+++ b/python/sepolicy/Makefile
>@@ -43,3 +43,5 @@ install:
> 	install -m 644 $(BASHCOMPLETIONS) $(DESTDIR)$(BASHCOMPLETIONDIR)/sepolic=
y
>=20
> relabel:
>+
>+format:
>diff --git a/restorecond/Makefile b/restorecond/Makefile
>index b8b86eb4..573535c6 100644
>--- a/restorecond/Makefile
>+++ b/restorecond/Makefile
>@@ -59,7 +59,7 @@ relabel: install
> clean:
> 	-rm -f restorecond *.o *~
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> test:
>diff --git a/sandbox/Makefile b/sandbox/Makefile
>index 0799ab7c..2737e532 100644
>--- a/sandbox/Makefile
>+++ b/sandbox/Makefile
>@@ -50,7 +50,7 @@ clean:
> 	-rm -f seunshare *.o *~
> 	(cd po && $(MAKE) $@)
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
> relabel:
>diff --git a/scripts/Lindent b/scripts/Lindent
>deleted file mode 100755
>index 9c4b3e2b..00000000
>--- a/scripts/Lindent
>+++ /dev/null
>@@ -1,18 +0,0 @@
>-#!/bin/sh
>-PARAM=3D"-npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1"
>-RES=3D`indent --version`
>-V1=3D`echo $RES | cut -d' ' -f3 | cut -d'.' -f1`
>-V2=3D`echo $RES | cut -d' ' -f3 | cut -d'.' -f2`
>-V3=3D`echo $RES | cut -d' ' -f3 | cut -d'.' -f3`
>-if [ $V1 -gt 2 ]; then
>-  PARAM=3D"$PARAM -il0"
>-elif [ $V1 -eq 2 ]; then
>-  if [ $V2 -gt 2 ]; then
>-    PARAM=3D"$PARAM -il0";
>-  elif [ $V2 -eq 2 ]; then
>-    if [ $V3 -ge 10 ]; then
>-      PARAM=3D"$PARAM -il0"
>-    fi
>-  fi
>-fi
>-indent $PARAM "$@"
>diff --git a/secilc/Makefile b/secilc/Makefile
>index ef7bc8cd..2518933f 100644
>--- a/secilc/Makefile
>+++ b/secilc/Makefile
>@@ -87,4 +87,6 @@ clean:
>=20
> relabel:
>=20
>+format:
>+
> .PHONY: all clean test install doc relabel man
>diff --git a/semodule-utils/Makefile b/semodule-utils/Makefile
>index e0a65792..0ab7d0dc 100644
>--- a/semodule-utils/Makefile
>+++ b/semodule-utils/Makefile
>@@ -1,6 +1,6 @@
> SUBDIRS =3D semodule_package semodule_link semodule_expand
>=20
>-all install relabel clean indent:
>+all install relabel clean format:
> 	@for subdir in $(SUBDIRS); do \
> 		(cd $$subdir && $(MAKE) $@) || exit 1; \
> 	done
>diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-utils/semo=
dule_expand/Makefile
>index ad776b15..1e5f836d 100644
>--- a/semodule-utils/semodule_expand/Makefile
>+++ b/semodule-utils/semodule_expand/Makefile
>@@ -28,6 +28,6 @@ relabel:
> clean:
> 	-rm -f semodule_expand *.o
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
>diff --git a/semodule-utils/semodule_link/Makefile b/semodule-utils/semodu=
le_link/Makefile
>index 936d161c..6c603b7c 100644
>--- a/semodule-utils/semodule_link/Makefile
>+++ b/semodule-utils/semodule_link/Makefile
>@@ -28,6 +28,6 @@ relabel:
> clean:
> 	-rm -f semodule_link *.o
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
>diff --git a/semodule-utils/semodule_package/Makefile b/semodule-utils/sem=
odule_package/Makefile
>index 6a289f73..c5823cc0 100644
>--- a/semodule-utils/semodule_package/Makefile
>+++ b/semodule-utils/semodule_package/Makefile
>@@ -30,6 +30,6 @@ relabel:
> clean:
> 	-rm -f semodule_package semodule_unpackage *.o
>=20
>-indent:
>-	../../scripts/Lindent $(wildcard *.[ch])
>+format:
>+	clang-format -i $(wildcard *.[ch])
>=20
>--=20
>2.50.1
>
>

Oops, I forgot to send this as an RFC, apologies - it still is one! I'll
sent the next patch as an RFC again.

While we're still talking about code style/formatting, I think it also
would be nice to add some clarification about usage of braces. Right
now, the usage of bracing is somewhat mixed: there are many places where
one line statements don't have braces, and vice versa. It would be good
to decide what the style regarding braces would be here and add it to
the CONTRIBUTING guide.

Regarding my own personal opinion, I think it would be best off to have
braces surrounding all statements (if/for/while, etc). It adds
consistency to all of those kinds of statements, and it also helps avoid
bugs such as the infamous `goto fail;` vulnerability[1]. It's a fairly
small trade off for a bit of added safety. However, maintainer opinions
are of course very much welcome here.

Regards,
Rahul
