Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5828506F
	for <selinux@vger.kernel.org>; Wed,  8 Oct 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936653; cv=none; b=dypgfxNzUhI9hfDG4sI0XPiXF2gpnA3rSLvUcfuiun43rVdDb34MEBN2CKnGOjZK1r9liepoR3Mqjx7POSHEaBVyV/CHzGc/D4vYkW82wPKm4BIOP4aU0MlScXXd12e9nOfB11ao5WDLLzSo2CPAr/DFRBOjhF8FnminG1rbOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936653; c=relaxed/simple;
	bh=5H4qtiuHbDrd3cLuN9KI5i1tqBnIz5tF8ke8vT3TNl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/9PNuZZxiFex9hB+FAHBDOnv9VDGpWwKMgq2JctlDgeo/qoxPEHPUAcJfJSxNhgwV/yixknj3OAQdVf17ddtLcFp3rrDvGfHRfbkmE6UdLzVeGaEebQnTNF+R3/L1nHlTxmhMzogK80xBp/OP0jAjATdtx7ypaJnZnU7YtVbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [IPv6:2607:fb90:d726:8a38:a53f:9a59:208e:d227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: concord@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5F2A4335D46;
	Wed, 08 Oct 2025 15:17:30 +0000 (UTC)
Date: Wed, 8 Oct 2025 11:17:25 -0400
From: Kenton Groombridge <concord@gentoo.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Rahul Sandhu <nvraxn@gmail.com>, selinux@vger.kernel.org
Subject: Re: [RFC PATCH v2] treewide: add .clang-format configuration file
Message-ID: <5nqsvejgk57z4rh7xlertod3mdebhi4j4b7tp6mnqrkl5rlehl@u5i4q6nq6fet>
Mail-Followup-To: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Rahul Sandhu <nvraxn@gmail.com>, selinux@vger.kernel.org
References: <20250928223923.1268452-1-nvraxn@gmail.com>
 <20250928224823.1269182-1-nvraxn@gmail.com>
 <CAEjxPJ5fK0HtMzn7kHsddvzC+Ku+BnK1YCe4ZJ-DG0_7WfSNwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybqe42fapydonin6"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ5fK0HtMzn7kHsddvzC+Ku+BnK1YCe4ZJ-DG0_7WfSNwg@mail.gmail.com>


--ybqe42fapydonin6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2] treewide: add .clang-format configuration file
MIME-Version: 1.0

On 25/10/06 12:52PM, Stephen Smalley wrote:
> On Sun, Sep 28, 2025 at 6:48=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Currently only an RFC.
> >
> > Add the .clang-format configuration file, taken from the Linux kernel
> > repository. We don't have any official style guidelines in tree at
> > present, which makes it a bit unclear how to format C code for new
> > contributors. As well as this, different parts of the codebase seem to
> > been formatted with different styles on occasion, so using an automatic
> > formatter should resolve this.
> >
> > .clang-format is also read by various editors and tooling for writing C
> > code. It may also be worth adding an editorconfig file in the future as
> > well?
>=20
> Can't hurt.
>=20
> > It may well also be worth adding a `format` target to the Makefiles, is
> > that something that would be useful?
>=20
> IMHO, yes.
>=20
> >
> > A few other things to consider to do in the future:
> > 1. Reformat all existing code. I understand this is a big change, hence
> >    the RFC, but we may as well get all code formatted if we go down
> >    this route; afterall, it's not like this will cause any breaking
> >    changes.
>=20
> Not opposed but will defer to the distro package maintainers on when
> they want to apply such a change since it makes back-porting future
> patches more painful for them.
>=20

No strong opinions from Gentoo. We aren't carrying any patches for C
code for SELinux userspace.

All in all I think this is a good change.

> > 2. Possibly add a CI target to check that all code is formatted as per
> >    the new clang-format configuration? The options `--dry-run` as well
> >    as `-Werror` can be passed to clang-format for this.
>=20
> Sounds reasonable too.
>=20
> >
> > Comments/feedback appreciated, thanks.
>=20
> No strong opinions; would be fine with any standardized coding style.
> For comparison, selinux-testsuite has tools/check-syntax which can be
> used to check or fix coding style problems for C and perl code, but
> I'd be fine with using clang-format here as in the kernel.
>=20
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> > ---
> >  .clang-format   | 130 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  CONTRIBUTING.md |   2 +
> >  2 files changed, 132 insertions(+)
> >  create mode 100644 .clang-format
> >
> > v2: remove linux kernel ForEachMacros and replace them with ours
> >
> > diff --git a/.clang-format b/.clang-format
> > new file mode 100644
> > index 00000000..35595d87
> > --- /dev/null
> > +++ b/.clang-format
> > @@ -0,0 +1,130 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# clang-format configuration file. Intended for clang-format >=3D 11.
> > +#
> > +# For more information, see:
> > +#
> > +#   Documentation/dev-tools/clang-format.rst
> > +#   https://clang.llvm.org/docs/ClangFormat.html
> > +#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
> > +#
> > +---
> > +AccessModifierOffset: -4
> > +AlignAfterOpenBracket: Align
> > +AlignConsecutiveAssignments: false
> > +AlignConsecutiveDeclarations: false
> > +AlignEscapedNewlines: Left
> > +AlignOperands: true
> > +AlignTrailingComments: false
> > +AllowAllParametersOfDeclarationOnNextLine: false
> > +AllowShortBlocksOnASingleLine: false
> > +AllowShortCaseLabelsOnASingleLine: false
> > +AllowShortFunctionsOnASingleLine: None
> > +AllowShortIfStatementsOnASingleLine: false
> > +AllowShortLoopsOnASingleLine: false
> > +AlwaysBreakAfterDefinitionReturnType: None
> > +AlwaysBreakAfterReturnType: None
> > +AlwaysBreakBeforeMultilineStrings: false
> > +AlwaysBreakTemplateDeclarations: false
> > +BinPackArguments: true
> > +BinPackParameters: true
> > +BraceWrapping:
> > +  AfterClass: false
> > +  AfterControlStatement: false
> > +  AfterEnum: false
> > +  AfterFunction: true
> > +  AfterNamespace: true
> > +  AfterObjCDeclaration: false
> > +  AfterStruct: false
> > +  AfterUnion: false
> > +  AfterExternBlock: false
> > +  BeforeCatch: false
> > +  BeforeElse: false
> > +  IndentBraces: false
> > +  SplitEmptyFunction: true
> > +  SplitEmptyRecord: true
> > +  SplitEmptyNamespace: true
> > +BreakBeforeBinaryOperators: None
> > +BreakBeforeBraces: Custom
> > +BreakBeforeInheritanceComma: false
> > +BreakBeforeTernaryOperators: false
> > +BreakConstructorInitializersBeforeComma: false
> > +BreakConstructorInitializers: BeforeComma
> > +BreakAfterJavaFieldAnnotations: false
> > +BreakStringLiterals: false
> > +ColumnLimit: 80
> > +CommentPragmas: '^ IWYU pragma:'
> > +CompactNamespaces: false
> > +ConstructorInitializerAllOnOneLineOrOnePerLine: false
> > +ConstructorInitializerIndentWidth: 8
> > +ContinuationIndentWidth: 8
> > +Cpp11BracedListStyle: false
> > +DerivePointerAlignment: false
> > +DisableFormat: false
> > +ExperimentalAutoDetectBinPacking: false
> > +FixNamespaceComments: false
> > +
> > +# Taken from:
> > +#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' \
> > +#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '=
\1'," \
> > +#   | LC_ALL=3DC sort -u
> > +ForEachMacros:
> > +  - 'cil_list_for_each'
> > +  - 'cil_stack_for_each'
> > +  - 'cil_stack_for_each_starting_at'
> > +  - 'ebitmap_for_each_bit'
> > +  - 'ebitmap_for_each_positive_bit'
> > +
> > +IncludeBlocks: Preserve
> > +IncludeCategories:
> > +  - Regex: '.*'
> > +    Priority: 1
> > +IncludeIsMainRegex: '(Test)?$'
> > +IndentCaseLabels: false
> > +IndentGotoLabels: false
> > +IndentPPDirectives: None
> > +IndentWidth: 8
> > +IndentWrappedFunctionNames: false
> > +JavaScriptQuotes: Leave
> > +JavaScriptWrapImports: true
> > +KeepEmptyLinesAtTheStartOfBlocks: false
> > +MacroBlockBegin: ''
> > +MacroBlockEnd: ''
> > +MaxEmptyLinesToKeep: 1
> > +NamespaceIndentation: None
> > +ObjCBinPackProtocolList: Auto
> > +ObjCBlockIndentWidth: 8
> > +ObjCSpaceAfterProperty: true
> > +ObjCSpaceBeforeProtocolList: true
> > +
> > +# Taken from git's rules
> > +PenaltyBreakAssignment: 10
> > +PenaltyBreakBeforeFirstCallParameter: 30
> > +PenaltyBreakComment: 10
> > +PenaltyBreakFirstLessLess: 0
> > +PenaltyBreakString: 10
> > +PenaltyExcessCharacter: 100
> > +PenaltyReturnTypeOnItsOwnLine: 60
> > +
> > +PointerAlignment: Right
> > +ReflowComments: false
> > +SortIncludes: false
> > +SortUsingDeclarations: false
> > +SpaceAfterCStyleCast: false
> > +SpaceAfterTemplateKeyword: true
> > +SpaceBeforeAssignmentOperators: true
> > +SpaceBeforeCtorInitializerColon: true
> > +SpaceBeforeInheritanceColon: true
> > +SpaceBeforeParens: ControlStatementsExceptForEachMacros
> > +SpaceBeforeRangeBasedForLoopColon: true
> > +SpaceInEmptyParentheses: false
> > +SpacesBeforeTrailingComments: 1
> > +SpacesInAngles: false
> > +SpacesInContainerLiterals: false
> > +SpacesInCStyleCastParentheses: false
> > +SpacesInParentheses: false
> > +SpacesInSquareBrackets: false
> > +Standard: Cpp03
> > +TabWidth: 8
> > +UseTab: Always
> > +...
> > diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> > index c501cf84..7ec8cb0f 100644
> > --- a/CONTRIBUTING.md
> > +++ b/CONTRIBUTING.md
> > @@ -53,6 +53,8 @@ When preparing patches, please follow these guideline=
s:
> >  -   Separate large patches into logical patches
> >  -   Patch descriptions must end with your "Signed-off-by" line. This m=
eans your
> >      code meets the Developer's certificate of origin, see below.
> > +-   C code should be formatted using clang-format, using the .clang-fo=
rmat
> > +    configuration file at the root of this repository.
> >
> >  When adding new, large features or tools it is best to discuss the
> >  design on the mailing list prior to submitting the patch.
> > --
> > 2.50.1
> >
> >

--=20
Kenton Groombridge
Gentoo Linux Developer, SELinux Project

--ybqe42fapydonin6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEP+u3AkfbrORB/inCFt7v5V9Ft54FAmjmgIBfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDNG
RUJCNzAyNDdEQkFDRTQ0MUZFMjlDMjE2REVFRkU1NUY0NUI3OUUACgkQFt7v5V9F
t56nQBAApfvXQuO8Bo7909Lltps4vg/Gl1kVeKT4gfSgkkW0nVJYbgS5iBq1Xypv
rmv4AZ183QCzNnViGC0xSuekxmQyc3lQVGuLSHfEyZzUzoU85/gQnTrZ4VRyrUe6
zzfXz7HQyugJ1grxovXym/8CIHHygayBo3tzyJTeF3CeO7NE2IbeR/78EeJb8AX3
NxwDvKnJd2t+0CbsjDC4MsYRWd6y+lxZroAryHbG78DsAYeDBNfNTDaBphMw8hz9
I/MV8APkKNKICx3jF0aDuue+dk20lGglQ23gAja7n0DOfGj4fJNwutpSf9q2bhtO
AIKd+Q3cSCQZ7h1jk2exdoWZ+AQlJJiKilP/IQd7iUi4xNVznsJKJLms2ONlHj1I
MSkwYSbCZStG3etk1jY718gZ1s/qOTua8Pqo6kvYAxibgNschOp6hxq5ORcOocOS
/8TFLoSD1j5bFI/fDGKR0w1Sn3jWRwYZhBl+JkmYMW6ih86pItSv+UzKWFRTyY5o
0BOX8Eopq8ON9RBJ5BLq/S0Uaq444CtxG6+S1Yz5nfavV9XSVwK/QpXpGJLnnL0D
VYt2BBeOL5Bsz+GwoGpMe7afAqVNxg5aM50rmeCnmbAAA6SWKFWO9S4T7VxqJOqr
ywyMzLQupt3EuD7AJfC/yiMTD/gR0gSe2AQR08zY3NuY2R5VTBI=
=VhXc
-----END PGP SIGNATURE-----

--ybqe42fapydonin6--
