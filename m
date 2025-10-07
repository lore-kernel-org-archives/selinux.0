Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612CA223DE7
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818923; cv=none; b=QRtd1XYbKyQd8jT24GFzm2CbgP1uDKAlv5Q83bGxvr6H6HGqwkTPoRnzHmyaLQRhEt+IZKEexomUgUQxtc/uHs+dUk/0/S3U9eCeLQE1ilSM55hEi33Bp6rOfRFLbwl0D7XLCou4uYp8NySkQMTYM2dWLActcSpj4uBjBkgN0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818923; c=relaxed/simple;
	bh=rDUzenjqPNKF5h/+SOBXi/+Huy5T8g5FaqzCNUcVkYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gHnmsNYMkwrMWLO9mgRAmxXS/hzYvZBegTdCj4cw71dPIGkgdfMdZCK4okC5rkc8DlJj38F8+Ch9QLF8+04nNom9vnHAQA/x2gorY5C3/V2tw0kDwyIdwVOOAfKASRiRcnVdRdVOTB/VBet/wDUEyuLrn/BCEVO7e7gR5iVDLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JeSsUl4z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeSsUl4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759818920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYjZV0YGEioE9JjmyuZHuCq8Kmg0/pIQPzmH886N9vE=;
	b=JeSsUl4zXC9hMbniU0Su3Na3hoXWqZH+LROwMDtOhkJuLhRTXOK/qAJ6aCgBRzUmVuIZFb
	Ua06pTn9dwAkQFWcD/BR+0HPe6/Q4u9Di5UwGHeHlhA/feF18PKU6kBAVYHe5LJgpiN5Sl
	mbn8v7SvU6R8DaoaslmcmauRqFi2rFc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-WPks_ftNPCOSaUl8VAZMjg-1; Tue,
 07 Oct 2025 02:35:18 -0400
X-MC-Unique: WPks_ftNPCOSaUl8VAZMjg-1
X-Mimecast-MFC-AGG-ID: WPks_ftNPCOSaUl8VAZMjg_1759818917
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C3331800451;
	Tue,  7 Oct 2025 06:35:17 +0000 (UTC)
Received: from localhost (unknown [10.44.33.122])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1340B19560A2;
	Tue,  7 Oct 2025 06:35:16 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, Rahul Sandhu
 <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [RFC PATCH v2] treewide: add .clang-format configuration file
In-Reply-To: <CAEjxPJ5fK0HtMzn7kHsddvzC+Ku+BnK1YCe4ZJ-DG0_7WfSNwg@mail.gmail.com>
References: <20250928223923.1268452-1-nvraxn@gmail.com>
 <20250928224823.1269182-1-nvraxn@gmail.com>
 <CAEjxPJ5fK0HtMzn7kHsddvzC+Ku+BnK1YCe4ZJ-DG0_7WfSNwg@mail.gmail.com>
Date: Tue, 07 Oct 2025 08:35:15 +0200
Message-ID: <87ldln43to.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Sun, Sep 28, 2025 at 6:48=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
>>
>> Currently only an RFC.
>>
>> Add the .clang-format configuration file, taken from the Linux kernel
>> repository. We don't have any official style guidelines in tree at
>> present, which makes it a bit unclear how to format C code for new
>> contributors. As well as this, different parts of the codebase seem to
>> been formatted with different styles on occasion, so using an automatic
>> formatter should resolve this.
>>
>> .clang-format is also read by various editors and tooling for writing C
>> code. It may also be worth adding an editorconfig file in the future as
>> well?
>
> Can't hurt.
>
>> It may well also be worth adding a `format` target to the Makefiles, is
>> that something that would be useful?
>
> IMHO, yes.
>
>>
>> A few other things to consider to do in the future:
>> 1. Reformat all existing code. I understand this is a big change, hence
>>    the RFC, but we may as well get all code formatted if we go down
>>    this route; afterall, it's not like this will cause any breaking
>>    changes.
>
> Not opposed but will defer to the distro package maintainers on when
> they want to apply such a change since it makes back-porting future
> patches more painful for them.


As a Fedora and RHEL maintainer, this might be annoying in the short
term, but I see it as an improvement in the long term.=20

If it's well-documented, with configuration files and a helper script
for formatting/checking available, and CI is set up, I would not be
opposed to this.=20

>> 2. Possibly add a CI target to check that all code is formatted as per
>>    the new clang-format configuration? The options `--dry-run` as well
>>    as `-Werror` can be passed to clang-format for this.
>
> Sounds reasonable too.
>
>>
>> Comments/feedback appreciated, thanks.
>
> No strong opinions; would be fine with any standardized coding style.
> For comparison, selinux-testsuite has tools/check-syntax which can be
> used to check or fix coding style problems for C and perl code, but
> I'd be fine with using clang-format here as in the kernel.
>
>> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>> ---
>>  .clang-format   | 130 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  CONTRIBUTING.md |   2 +
>>  2 files changed, 132 insertions(+)
>>  create mode 100644 .clang-format
>>
>> v2: remove linux kernel ForEachMacros and replace them with ours
>>
>> diff --git a/.clang-format b/.clang-format
>> new file mode 100644
>> index 00000000..35595d87
>> --- /dev/null
>> +++ b/.clang-format
>> @@ -0,0 +1,130 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# clang-format configuration file. Intended for clang-format >=3D 11.
>> +#
>> +# For more information, see:
>> +#
>> +#   Documentation/dev-tools/clang-format.rst
>> +#   https://clang.llvm.org/docs/ClangFormat.html
>> +#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
>> +#
>> +---
>> +AccessModifierOffset: -4
>> +AlignAfterOpenBracket: Align
>> +AlignConsecutiveAssignments: false
>> +AlignConsecutiveDeclarations: false
>> +AlignEscapedNewlines: Left
>> +AlignOperands: true
>> +AlignTrailingComments: false
>> +AllowAllParametersOfDeclarationOnNextLine: false
>> +AllowShortBlocksOnASingleLine: false
>> +AllowShortCaseLabelsOnASingleLine: false
>> +AllowShortFunctionsOnASingleLine: None
>> +AllowShortIfStatementsOnASingleLine: false
>> +AllowShortLoopsOnASingleLine: false
>> +AlwaysBreakAfterDefinitionReturnType: None
>> +AlwaysBreakAfterReturnType: None
>> +AlwaysBreakBeforeMultilineStrings: false
>> +AlwaysBreakTemplateDeclarations: false
>> +BinPackArguments: true
>> +BinPackParameters: true
>> +BraceWrapping:
>> +  AfterClass: false
>> +  AfterControlStatement: false
>> +  AfterEnum: false
>> +  AfterFunction: true
>> +  AfterNamespace: true
>> +  AfterObjCDeclaration: false
>> +  AfterStruct: false
>> +  AfterUnion: false
>> +  AfterExternBlock: false
>> +  BeforeCatch: false
>> +  BeforeElse: false
>> +  IndentBraces: false
>> +  SplitEmptyFunction: true
>> +  SplitEmptyRecord: true
>> +  SplitEmptyNamespace: true
>> +BreakBeforeBinaryOperators: None
>> +BreakBeforeBraces: Custom
>> +BreakBeforeInheritanceComma: false
>> +BreakBeforeTernaryOperators: false
>> +BreakConstructorInitializersBeforeComma: false
>> +BreakConstructorInitializers: BeforeComma
>> +BreakAfterJavaFieldAnnotations: false
>> +BreakStringLiterals: false
>> +ColumnLimit: 80
>> +CommentPragmas: '^ IWYU pragma:'
>> +CompactNamespaces: false
>> +ConstructorInitializerAllOnOneLineOrOnePerLine: false
>> +ConstructorInitializerIndentWidth: 8
>> +ContinuationIndentWidth: 8
>> +Cpp11BracedListStyle: false
>> +DerivePointerAlignment: false
>> +DisableFormat: false
>> +ExperimentalAutoDetectBinPacking: false
>> +FixNamespaceComments: false
>> +
>> +# Taken from:
>> +#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' \
>> +#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\=
1'," \
>> +#   | LC_ALL=3DC sort -u
>> +ForEachMacros:
>> +  - 'cil_list_for_each'
>> +  - 'cil_stack_for_each'
>> +  - 'cil_stack_for_each_starting_at'
>> +  - 'ebitmap_for_each_bit'
>> +  - 'ebitmap_for_each_positive_bit'
>> +
>> +IncludeBlocks: Preserve
>> +IncludeCategories:
>> +  - Regex: '.*'
>> +    Priority: 1
>> +IncludeIsMainRegex: '(Test)?$'
>> +IndentCaseLabels: false
>> +IndentGotoLabels: false
>> +IndentPPDirectives: None
>> +IndentWidth: 8
>> +IndentWrappedFunctionNames: false
>> +JavaScriptQuotes: Leave
>> +JavaScriptWrapImports: true
>> +KeepEmptyLinesAtTheStartOfBlocks: false
>> +MacroBlockBegin: ''
>> +MacroBlockEnd: ''
>> +MaxEmptyLinesToKeep: 1
>> +NamespaceIndentation: None
>> +ObjCBinPackProtocolList: Auto
>> +ObjCBlockIndentWidth: 8
>> +ObjCSpaceAfterProperty: true
>> +ObjCSpaceBeforeProtocolList: true
>> +
>> +# Taken from git's rules
>> +PenaltyBreakAssignment: 10
>> +PenaltyBreakBeforeFirstCallParameter: 30
>> +PenaltyBreakComment: 10
>> +PenaltyBreakFirstLessLess: 0
>> +PenaltyBreakString: 10
>> +PenaltyExcessCharacter: 100
>> +PenaltyReturnTypeOnItsOwnLine: 60
>> +
>> +PointerAlignment: Right
>> +ReflowComments: false
>> +SortIncludes: false
>> +SortUsingDeclarations: false
>> +SpaceAfterCStyleCast: false
>> +SpaceAfterTemplateKeyword: true
>> +SpaceBeforeAssignmentOperators: true
>> +SpaceBeforeCtorInitializerColon: true
>> +SpaceBeforeInheritanceColon: true
>> +SpaceBeforeParens: ControlStatementsExceptForEachMacros
>> +SpaceBeforeRangeBasedForLoopColon: true
>> +SpaceInEmptyParentheses: false
>> +SpacesBeforeTrailingComments: 1
>> +SpacesInAngles: false
>> +SpacesInContainerLiterals: false
>> +SpacesInCStyleCastParentheses: false
>> +SpacesInParentheses: false
>> +SpacesInSquareBrackets: false
>> +Standard: Cpp03
>> +TabWidth: 8
>> +UseTab: Always
>> +...
>> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
>> index c501cf84..7ec8cb0f 100644
>> --- a/CONTRIBUTING.md
>> +++ b/CONTRIBUTING.md
>> @@ -53,6 +53,8 @@ When preparing patches, please follow these guidelines:
>>  -   Separate large patches into logical patches
>>  -   Patch descriptions must end with your "Signed-off-by" line. This me=
ans your
>>      code meets the Developer's certificate of origin, see below.
>> +-   C code should be formatted using clang-format, using the .clang-for=
mat
>> +    configuration file at the root of this repository.
>>
>>  When adding new, large features or tools it is best to discuss the
>>  design on the mailing list prior to submitting the patch.
>> --
>> 2.50.1
>>
>>

