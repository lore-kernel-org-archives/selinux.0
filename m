Return-Path: <SRS0=zZcK=O3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B41C43387
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 16:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE6F21873
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 16:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha5qp2ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeLRQEI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:04:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36626 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeLRQEI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Dec 2018 11:04:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so16151889otk.3
        for <selinux@vger.kernel.org>; Tue, 18 Dec 2018 08:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCyLZ1UMOD+FmpIyDJdx9OXV1DdKIA5azwg0uLC0MEU=;
        b=Ha5qp2MLa3rvBm29u/PzXi6f3oC9JVrFX9gJTCRuqRlm70H07mvhn8y3jvfj04yPDK
         IZ5M1NicNQ9su4t8nAvLNNBYY6GhZdkb+EFNeuoP1Kw/JXlfizqUltkyA9yPmqcMPDCe
         cb9QREfDZchjtlAZAhlT43eet2wW2WC41z/qi/aUpJ0ZbMl3gDbkGPArHQEaifP5rTrn
         HFKYGXzXyOVGt+wHCaok48uyyI3zD0NhK4BA79dGZO3Tly7exkHgWt8TLuSTqXp3FFLP
         EpHfCuIRB4HMX0rSF8gCzlszBRPO6y0Rt68mARaHs+N97TfVqDTCFwujYdiDl+GVndCS
         LZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCyLZ1UMOD+FmpIyDJdx9OXV1DdKIA5azwg0uLC0MEU=;
        b=Lg3aYiFnmGLVjm0Iyez2tjZsuS9KVzDTlZ3O9JsYA0FNTJmrfq/clHsIQflueOMdM9
         MneiVeP5V3MrPec5aPo2dAzGT0HWOC4+k1vR/TpzmYMkavDcL5sj18ISEoLCt33qT4HV
         LPIHjt+cBg8Ir3j1pMr53637d6kUCxPOKgtz36eBwDNN8V9K/N6pxf/q8idqla0KlKwH
         7Twdi1fS5aoOb1Ln0fFonZzCZcuAh2WE912C19PkSAFpqUF6RTy9xMnckA0D3Yh5MuNp
         lWfid9m46PegrOI3Mt2lEoYT/BZWfkIvMqTWpEFPD9K7EbyGc3Zef1wIgHiNM9shGUPT
         A5Zw==
X-Gm-Message-State: AA+aEWbhbvf9U3zKfvoTOpMxi8yFwZodmfkOLhc7H7N8mxrirt4bY31i
        sAclssF3DPeTeYUyjR3htXofqTa67gvbUZ8pUiA=
X-Google-Smtp-Source: AFSGD/Xd2aPMMGhYW7x8KzAITLcKx7ZESdDzYRVFuTFrTAuG/ghGpLtFe7VqyNON5JeNg6iTRZ68GRyHgY+gvhApqWo=
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr13454840otg.74.1545149046251;
 Tue, 18 Dec 2018 08:04:06 -0800 (PST)
MIME-Version: 1.0
References: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
 <a31ecb59-e330-08c8-95d3-8c9fe5a4022d@tycho.nsa.gov> <877d53f9-3296-368c-979f-cf73cfc50ebb@tycho.nsa.gov>
 <CAFftDdofWyE747=fFUXj8v8bN3aipgguWVziDpOhd9_VVsasmQ@mail.gmail.com>
In-Reply-To: <CAFftDdofWyE747=fFUXj8v8bN3aipgguWVziDpOhd9_VVsasmQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 18 Dec 2018 08:03:54 -0800
Message-ID: <CAFftDdr+1zWpGeBgpfhQ02fbfhCD2F5_F0mUTB2zQobKpANg8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile: fix _FORTIFY_SOURCE redefined build error
To:     Stephen Smalley <sds@tycho.nsa.gov>, ps@pks.im
Cc:     selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Patrick,

Hoping you could maybe weigh in on your choice for bypassing the
compiler driver with -Wp and not setting _FORTIFY_SOURCE to something
like 1 or 2?

I'm seeing this issue on Ubuntu 16.04.5:
<command-line>:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]

gcc version:
gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609

My thought is to undef/redef _FORTIFY_SOURCE in CFLAGS and set the
level to 2. Setting CFLAGS via the env/make arg will override this
behavior
and use CFLAGS as is.

On Fri, Dec 14, 2018 at 8:02 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, Dec 14, 2018 at 6:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > On 12/14/18 8:43 AM, Stephen Smalley wrote:
> > > On 12/13/18 4:32 PM, bill.c.roberts@gmail.com wrote:
> > >> From: William Roberts <william.c.roberts@intel.com>
> > >>
> > >> Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
> > >> <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
> > >> <command-line>:0:0: note: this is the location of the previous definition
> > >>
> > >> Correct this by undefining it first and redefining it. Also, the previous
> > >> command line option was using -Wp which passing the value *AS IS* to the
> > >> pre-processor rather than to the compiler driver. The C pre-processor has
> > >> an undocumented interface subject to change per man 1 gcc. Just use the
> > >> -D option as is.
> > >
> > > See commit ca07a2ad46be141dad90d885dd33a2ac31c6559a ("libselinux: avoid
> > > redefining _FORTIFY_SOURCE") for why we don't specify a value for
> > > _FORTIFY_SOURCE here.  Not sure about the -Wp,-D vs -D rationale.
>
> I'm not 100% convinced that the patch is the best solution or the commit message
> is describing the problem correctly. I could also be understanding it
> wrong here.
> The man page is saying not to bypass the compiler driver via -Wp, and I don't
> see a good reason for it either.
>
> See my comments below, they feed back into this.
>
> >
> > I guess the issue here is that we want to provide sane defaults for
> > building without breaking the build when others specify their own
> > definitions and without weakening those definitions.  By undefining and
> > re-defining, it seems like we might weaken existing builds that were
> > specifying 2.
>
> We conditionally assign to CFLAGS via ?= operator. Thus, CFLAGS and the
> corresponding addition of EXTRA_CFLAGS which contains the undef/def
> is not appended. CFLAGS specified via the environment or as an argument to
> make will cause this assignment not to occur (via ?= semantics) and whatever
> they specify for CFLAGS is sent to CC.
>
> Here is some sample output:
> make CFLAGS='-D_FORTIFY_SOURCE=2'
> cc -D_FORTIFY_SOURCE=2 -I../include -D_GNU_SOURCE -DNO_ANDROID_BACKEND
>  -fPIC -DSHARED -c -o stringrep.lo stringrep.c
>
> With that said, *i think its safe* to bump it back to '-D_FORTIFY_SOURCE=2'
>
> >
> > >
> > >>
> > >> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > >> ---
> > >>   libselinux/src/Makefile   | 2 +-
> > >>   libselinux/utils/Makefile | 2 +-
> > >>   2 files changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > >> index 977b5c8cfcca..ee55bd0dbff7 100644
> > >> --- a/libselinux/src/Makefile
> > >> +++ b/libselinux/src/Makefile
> > >> @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
> > >>   EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op
> > >> -Wpacked-bitfield-compat -Wsync-nand \
> > >>       -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
> > >> -Wsuggest-attribute=const \
> > >>       -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> > >> -Wtrampolines -Wjump-misses-init \
> > >> -    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > >> -Wp,-D_FORTIFY_SOURCE
> > >> +    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > >> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
> > >>   else
> > >>   EXTRA_CFLAGS = -Wunused-command-line-argument
> > >>   endif
> > >> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > >> index d06ffd66893b..64ab877015c6 100644
> > >> --- a/libselinux/utils/Makefile
> > >> +++ b/libselinux/utils/Makefile
> > >> @@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k
> > >> -Wformat-security -Winit-self -Wmissi
> > >>             -Wformat-extra-args -Wformat-zero-length -Wformat=2
> > >> -Wmultichar \
> > >>             -Woverflow -Wpointer-to-int-cast -Wpragmas \
> > >>             -Wno-missing-field-initializers -Wno-sign-compare \
> > >> -          -Wno-format-nonliteral
> > >> -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
> > >> +          -Wno-format-nonliteral
> > >> -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE
> > >> -D_FORTIFY_SOURCE=1 \
> > >>             -fstack-protector-all --param=ssp-buffer-size=4
> > >> -fexceptions \
> > >>             -fasynchronous-unwind-tables -fdiagnostics-show-option
> > >> -funit-at-a-time \
> > >>             -Werror -Wno-aggregate-return -Wno-redundant-decls \
> > >>
> > >
> >
