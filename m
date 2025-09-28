Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948F35950
	for <selinux@vger.kernel.org>; Sun, 28 Sep 2025 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759099723; cv=none; b=sY6SGOvpR5ntXA2qO+bAq0s6XVBSW+z9ltDlCf/GEvuwsuFbNAMORWC4jjwKIBQtDeg48tpzkg8+ImeTbwLcPG3/theyXNIk/ZM+RsX6GStlRhxYT7w95ofwNv/6SNZTOB98muiNYlJOm2e73kufsudNc+R27CWEJ487Kq4NRRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759099723; c=relaxed/simple;
	bh=moPdnLZ8nm8opCkhe/YgcuOitU0At151U+5q46vI1QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8BLbdc9GD4wAEfKfIF6RWH7TYDPtfayCJmT0nSfvmWP9B1LrnNFsMa04v0GMUet1t2e4M6cigt5u7meyNGt0lK9kjNNeDGJrNT0aLJogKDfQBvFMEUABQnf1YUspSXmLVSavtTcQwxTt20qo2nMt0KZWeEthpx/mpO7djLcNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpvxMnwM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpvxMnwM"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso19916515e9.2
        for <selinux@vger.kernel.org>; Sun, 28 Sep 2025 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759099719; x=1759704519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8ewdA8+1Ydm2QswJ30P7SMxs2KiL5N+Mdt+AOYleoE=;
        b=BpvxMnwM0IqFCqK/tKy6uSiRCuosh382PgnNrIWMkYTy9vYVRnnWbzs6GTfcuhHhMJ
         4GONkD0xb3jQrLLH1Sx4VsLEQ6oewhJZrBYvhXb82CqK18c+S+y+uqjm/rtHpnhJLzNA
         flnMPlEW+4wJsN6eO7g3eR9h5o1AfAvoPkHXNKum3Z0Ezi3fOf/2E3Ip58pBYyLa6qD5
         /rJKV1bHC9im7fTY+xUE0dj2rNXIC3dGUcCgK3gqI3Mkn4IoPADUHwmnQZH378MJR5mF
         YQ4J4UfPRG/eWXeYufguDfYv4hgoKPm/I/SqAfxPZDRD0CglNzT6iaWV4qZYhoJg+uuu
         ifgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759099719; x=1759704519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8ewdA8+1Ydm2QswJ30P7SMxs2KiL5N+Mdt+AOYleoE=;
        b=gAS4JUN+b/V+7heXTTwdgixB5yd7QOx10EasWztLNoaG2UZA09PDeCRvIN4AuxJk3s
         1cx7Pzoip4semsLbzaSh2/jq1WCc6FMZpwm06OtS3aB9lFH2C0l9w42d+00W5VtJXpYJ
         xsvRiJmkA84CGxbIG9FIcjVsIpXbg5noo9S6SHIkqaAlqrnkuOrGB524kC3NB+xI3/p8
         vQ5UmsXVIGmIZR1JnHJL9o7t9KkYOy3U4b5msx2joZdcevi5nihN5jy98UEdsw4T6CZR
         wW+4bEfc8UPfQU0DDNtchVdRtGfX5AaWG/VRfYKi0w0GI+/knEoDA+ZzreB1TdBFqPik
         OZlA==
X-Gm-Message-State: AOJu0YxpFfIGMoSw3dm20PssjC/aCD0Ehfg0X4f0MD/1qH9TzsU6Eswq
	E1yJzuqE1ELle55CCef58v/nxw4VBOwA5zIo6hP1Il9fXFV/hw8Jlooln27o5Q==
X-Gm-Gg: ASbGncs12Bs1NrS1+dbQy7qyofDHbX6uGnuBXNdSEmNzaNxYe3YiLfd2c1LzlY8L4sw
	DOzgUPXxfOL1oS28L2+OJ6ulJgjz+jwDbKEjgmO6NmoYR4AyUFhys/yaxBsLMLNSup4VlB6tFHV
	RoLEit/GGg+bFReg4LRYYhHbFqI8+yef6XPS+fqZj2NPhjndQy/cv5wN/PZwnMzfxCkcr3zhFpw
	+J2DrmJitIi8WksscRe6c03PYwAwzaeyZ5G6VqJ+Kk0rugo54Skg/ejQxA/xk5mLazy/X7kR9mK
	Bc6UmxKDbKGaAgIkEAu0DSb+mw+H3sLQnSilFUhfJLLJcXeGyd90tppaGHXRb9eJL4CkpBgFMaK
	fT2dX37KBAI4aueBq2g==
X-Google-Smtp-Source: AGHT+IG4KpZjQfi8zzYY4gXq5eb4cDGQe7rYVHy5VjmLSsBZyXahYYWT66BatRPgwEkwTl5jTCy9fQ==
X-Received: by 2002:a05:6000:4282:b0:3dd:981d:43a5 with SMTP id ffacd0b85a97d-40e4b294eacmr12253527f8f.47.1759099719367;
        Sun, 28 Sep 2025 15:48:39 -0700 (PDT)
Received: from sierra ([81.79.59.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9768bdesm15968230f8f.23.2025.09.28.15.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:48:38 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: nvraxn@gmail.com
Cc: selinux@vger.kernel.org
Subject: [RFC PATCH v2] treewide: add .clang-format configuration file
Date: Sun, 28 Sep 2025 23:48:23 +0100
Message-ID: <20250928224823.1269182-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250928223923.1268452-1-nvraxn@gmail.com>
References: <20250928223923.1268452-1-nvraxn@gmail.com>
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

.clang-format is also read by various editors and tooling for writing C
code. It may also be worth adding an editorconfig file in the future as
well?

It may well also be worth adding a `format` target to the Makefiles, is
that something that would be useful?

A few other things to consider to do in the future:
1. Reformat all existing code. I understand this is a big change, hence
   the RFC, but we may as well get all code formatted if we go down
   this route; afterall, it's not like this will cause any breaking
   changes.
2. Possibly add a CI target to check that all code is formatted as per
   the new clang-format configuration? The options `--dry-run` as well
   as `-Werror` can be passed to clang-format for this.

Comments/feedback appreciated, thanks.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 .clang-format   | 130 ++++++++++++++++++++++++++++++++++++++++++++++++
 CONTRIBUTING.md |   2 +
 2 files changed, 132 insertions(+)
 create mode 100644 .clang-format

v2: remove linux kernel ForEachMacros and replace them with ours

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
-- 
2.50.1

