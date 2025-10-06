Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C942248AE
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769558; cv=none; b=NIpgDtbE1KstNNgbeGHCnTt+2Ls0uxO0VV80CtNeXr06wEFEGPTq+Qqdyx/ea3ty0O6OR1+0z0RNLgaWB1l/AFapqe20WfW84gJ6SzDvpKDF7lEsAC9WCjrvTowYHaqNsSwZrn8CzeanrZH3ZO03ir/uHjy9hgFqCXcTY4dXrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769558; c=relaxed/simple;
	bh=KFGjKEE4dos+lXRlXEgem1kEA0TQLfzQ1O2ueJEpS4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmvBkEwIyYku6ZjQUDezSoeGBDBS9Ics/jMOODVbuZhpq/fintJy76PzfgBFkU/85/eoR1q57BnDjsJ6gNcY0XmYCdBGMgZwD7IxwrS2p0Oe/lajQvXEff4S+vMUzzZex4v8yrmzAv/+1UMoE/oeVo5VAmHRhKHdOu7fy4KWuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYPxdrpa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYPxdrpa"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330631e534eso5712510a91.0
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759769556; x=1760374356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFqtLZ/jAaKzJkQGWLIAF6hIz5zgdJEMOq36fd0jE8w=;
        b=CYPxdrpalnlR/F1nEvN8RBXUxWYY7srGGhI0klYuA13fnWpWxgFf0pffP4kRCDEdrh
         wTCFDLCTmn6UDvczFOxfTYw6rOjtYDRE+xa1i4aZ8Z6yNRX0D6ukSI0ky0Uh8jTpbewN
         j50YzRXwzlQb1IAyIUZcnxpM84S++p1Cb7Hm2HG8sfr8JWy4SwuqP2nvUGVdaK+eZcOB
         fPadn3ujGlROp0nulcxDgw21JkzhUZAWBtSW78veKyH/GqBstoz+11JbogduE9gSE25Y
         dAQBGKxoHpmWwc0AzUA8yyDly2ISwqGOYmGXcYAYgQQPDX5irbbp2XsILSNO81iijVSi
         7fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769556; x=1760374356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFqtLZ/jAaKzJkQGWLIAF6hIz5zgdJEMOq36fd0jE8w=;
        b=LB8oEvGxuOrGgyBFtiURFtvXtSDv93W+uyBna5YlKjUI0lofwlQxLCtwWGGQjmmpcC
         WcBzSlZiWcPQRd88mzML6EHr3t721H5bS+GudW5gyaP4WSCZLSZsLeSc8nzY8VCxxCxP
         jrQ0SMcqJz6rHO+Bkn4hjjmCs3AZXcTwWBvVheIbH1MwxA74+qvz1IqQUDRZE9S6CIRN
         +dVzglL9/bpWq/VyULfc+0Kibq3FrQEkJNbFnENSazSwqXEMDP6AM2LDg1xuLOMBy46o
         c0yflIS+TlUDROyZLE7QQ4DxV3Ff72yEGfCgOt9kRv2nzAwLmBaYQVNysrwGxAXPqimz
         rYOQ==
X-Gm-Message-State: AOJu0YwCdBY/Gpt2v9IALs3EV3n+IUnk6dh1pHJbbNY7M/7v13CYbhlx
	wweYTR+AJjL8y+rQ3Kyq5pUl+cYOLP7i/M49AWHnDO9pPX7jGUN++LCxl6kiZwzZR1vJvq1YT3+
	RtRruFdiHWDcw4cbN1tP30RaJGLJQcC0VLw==
X-Gm-Gg: ASbGncsI+nuqjuUf1p4WMcCiLMsJB4xyFACvhNAKXvNY8vSJC8e/RexHbumPnwlZkQd
	x78JSDL+fHklKA/cAnLnHkR1Lpur6mFJgcF9o9oQC8rh10RgEAMR5S0YkoVyjqM65VnAGhZdt6/
	u0Yp7IUuQsxKcjpcKyoqMUI59CvL66QwAa/VajTJCQRyJ2NvCQygrIl7LFkBWvugwu3pTVN3+96
	gygNKPs15YOV+RgfXlunii79d7iTPyD7O3AKy7PRQ==
X-Google-Smtp-Source: AGHT+IHkjcgURgfFBiTtDxdhO/hCz5hxe3wy6WnzJDyiP0dAPYacJz4yfsL3suaOJnHQkXQfQU1exzQYtysYTHGOqso=
X-Received: by 2002:a17:90b:180d:b0:32b:c5a9:7be9 with SMTP id
 98e67ed59e1d1-339c27b98eemr16880587a91.25.1759769555757; Mon, 06 Oct 2025
 09:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928223923.1268452-1-nvraxn@gmail.com> <20250928224823.1269182-1-nvraxn@gmail.com>
In-Reply-To: <20250928224823.1269182-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 12:52:24 -0400
X-Gm-Features: AS18NWB2nuagAaLIHM2ns88qMlnvhQtEYFblSOyavy_b-1l3BQjyAqkjGKuvSi8
Message-ID: <CAEjxPJ5fK0HtMzn7kHsddvzC+Ku+BnK1YCe4ZJ-DG0_7WfSNwg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] treewide: add .clang-format configuration file
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 6:48=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Currently only an RFC.
>
> Add the .clang-format configuration file, taken from the Linux kernel
> repository. We don't have any official style guidelines in tree at
> present, which makes it a bit unclear how to format C code for new
> contributors. As well as this, different parts of the codebase seem to
> been formatted with different styles on occasion, so using an automatic
> formatter should resolve this.
>
> .clang-format is also read by various editors and tooling for writing C
> code. It may also be worth adding an editorconfig file in the future as
> well?

Can't hurt.

> It may well also be worth adding a `format` target to the Makefiles, is
> that something that would be useful?

IMHO, yes.

>
> A few other things to consider to do in the future:
> 1. Reformat all existing code. I understand this is a big change, hence
>    the RFC, but we may as well get all code formatted if we go down
>    this route; afterall, it's not like this will cause any breaking
>    changes.

Not opposed but will defer to the distro package maintainers on when
they want to apply such a change since it makes back-porting future
patches more painful for them.

> 2. Possibly add a CI target to check that all code is formatted as per
>    the new clang-format configuration? The options `--dry-run` as well
>    as `-Werror` can be passed to clang-format for this.

Sounds reasonable too.

>
> Comments/feedback appreciated, thanks.

No strong opinions; would be fine with any standardized coding style.
For comparison, selinux-testsuite has tools/check-syntax which can be
used to check or fix coding style problems for C and perl code, but
I'd be fine with using clang-format here as in the kernel.

> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  .clang-format   | 130 ++++++++++++++++++++++++++++++++++++++++++++++++
>  CONTRIBUTING.md |   2 +
>  2 files changed, 132 insertions(+)
>  create mode 100644 .clang-format
>
> v2: remove linux kernel ForEachMacros and replace them with ours
>
> diff --git a/.clang-format b/.clang-format
> new file mode 100644
> index 00000000..35595d87
> --- /dev/null
> +++ b/.clang-format
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# clang-format configuration file. Intended for clang-format >=3D 11.
> +#
> +# For more information, see:
> +#
> +#   Documentation/dev-tools/clang-format.rst
> +#   https://clang.llvm.org/docs/ClangFormat.html
> +#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
> +#
> +---
> +AccessModifierOffset: -4
> +AlignAfterOpenBracket: Align
> +AlignConsecutiveAssignments: false
> +AlignConsecutiveDeclarations: false
> +AlignEscapedNewlines: Left
> +AlignOperands: true
> +AlignTrailingComments: false
> +AllowAllParametersOfDeclarationOnNextLine: false
> +AllowShortBlocksOnASingleLine: false
> +AllowShortCaseLabelsOnASingleLine: false
> +AllowShortFunctionsOnASingleLine: None
> +AllowShortIfStatementsOnASingleLine: false
> +AllowShortLoopsOnASingleLine: false
> +AlwaysBreakAfterDefinitionReturnType: None
> +AlwaysBreakAfterReturnType: None
> +AlwaysBreakBeforeMultilineStrings: false
> +AlwaysBreakTemplateDeclarations: false
> +BinPackArguments: true
> +BinPackParameters: true
> +BraceWrapping:
> +  AfterClass: false
> +  AfterControlStatement: false
> +  AfterEnum: false
> +  AfterFunction: true
> +  AfterNamespace: true
> +  AfterObjCDeclaration: false
> +  AfterStruct: false
> +  AfterUnion: false
> +  AfterExternBlock: false
> +  BeforeCatch: false
> +  BeforeElse: false
> +  IndentBraces: false
> +  SplitEmptyFunction: true
> +  SplitEmptyRecord: true
> +  SplitEmptyNamespace: true
> +BreakBeforeBinaryOperators: None
> +BreakBeforeBraces: Custom
> +BreakBeforeInheritanceComma: false
> +BreakBeforeTernaryOperators: false
> +BreakConstructorInitializersBeforeComma: false
> +BreakConstructorInitializers: BeforeComma
> +BreakAfterJavaFieldAnnotations: false
> +BreakStringLiterals: false
> +ColumnLimit: 80
> +CommentPragmas: '^ IWYU pragma:'
> +CompactNamespaces: false
> +ConstructorInitializerAllOnOneLineOrOnePerLine: false
> +ConstructorInitializerIndentWidth: 8
> +ContinuationIndentWidth: 8
> +Cpp11BracedListStyle: false
> +DerivePointerAlignment: false
> +DisableFormat: false
> +ExperimentalAutoDetectBinPacking: false
> +FixNamespaceComments: false
> +
> +# Taken from:
> +#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' \
> +#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1=
'," \
> +#   | LC_ALL=3DC sort -u
> +ForEachMacros:
> +  - 'cil_list_for_each'
> +  - 'cil_stack_for_each'
> +  - 'cil_stack_for_each_starting_at'
> +  - 'ebitmap_for_each_bit'
> +  - 'ebitmap_for_each_positive_bit'
> +
> +IncludeBlocks: Preserve
> +IncludeCategories:
> +  - Regex: '.*'
> +    Priority: 1
> +IncludeIsMainRegex: '(Test)?$'
> +IndentCaseLabels: false
> +IndentGotoLabels: false
> +IndentPPDirectives: None
> +IndentWidth: 8
> +IndentWrappedFunctionNames: false
> +JavaScriptQuotes: Leave
> +JavaScriptWrapImports: true
> +KeepEmptyLinesAtTheStartOfBlocks: false
> +MacroBlockBegin: ''
> +MacroBlockEnd: ''
> +MaxEmptyLinesToKeep: 1
> +NamespaceIndentation: None
> +ObjCBinPackProtocolList: Auto
> +ObjCBlockIndentWidth: 8
> +ObjCSpaceAfterProperty: true
> +ObjCSpaceBeforeProtocolList: true
> +
> +# Taken from git's rules
> +PenaltyBreakAssignment: 10
> +PenaltyBreakBeforeFirstCallParameter: 30
> +PenaltyBreakComment: 10
> +PenaltyBreakFirstLessLess: 0
> +PenaltyBreakString: 10
> +PenaltyExcessCharacter: 100
> +PenaltyReturnTypeOnItsOwnLine: 60
> +
> +PointerAlignment: Right
> +ReflowComments: false
> +SortIncludes: false
> +SortUsingDeclarations: false
> +SpaceAfterCStyleCast: false
> +SpaceAfterTemplateKeyword: true
> +SpaceBeforeAssignmentOperators: true
> +SpaceBeforeCtorInitializerColon: true
> +SpaceBeforeInheritanceColon: true
> +SpaceBeforeParens: ControlStatementsExceptForEachMacros
> +SpaceBeforeRangeBasedForLoopColon: true
> +SpaceInEmptyParentheses: false
> +SpacesBeforeTrailingComments: 1
> +SpacesInAngles: false
> +SpacesInContainerLiterals: false
> +SpacesInCStyleCastParentheses: false
> +SpacesInParentheses: false
> +SpacesInSquareBrackets: false
> +Standard: Cpp03
> +TabWidth: 8
> +UseTab: Always
> +...
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> index c501cf84..7ec8cb0f 100644
> --- a/CONTRIBUTING.md
> +++ b/CONTRIBUTING.md
> @@ -53,6 +53,8 @@ When preparing patches, please follow these guidelines:
>  -   Separate large patches into logical patches
>  -   Patch descriptions must end with your "Signed-off-by" line. This mea=
ns your
>      code meets the Developer's certificate of origin, see below.
> +-   C code should be formatted using clang-format, using the .clang-form=
at
> +    configuration file at the root of this repository.
>
>  When adding new, large features or tools it is best to discuss the
>  design on the mailing list prior to submitting the patch.
> --
> 2.50.1
>
>
