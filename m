Return-Path: <SRS0=zZcK=O3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D07C43387
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 19:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A70921873
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 19:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7SYsV+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeLRTDJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:03:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39016 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLRTDI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Dec 2018 14:03:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so16703849otl.6
        for <selinux@vger.kernel.org>; Tue, 18 Dec 2018 11:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Luv1w90bGIZpla0q6CHg6tLSZSaRqkZZIK2We0F6BcI=;
        b=O7SYsV+3cuGK1BJB6vcpilyD27ci2X8pODJP1ZylzS8kx2RIsC4ayhUvj57qOicAFI
         fs4gLG8NRdgK7G+FTqxUd+RbsSVP7HT1Hh8x+VO9l4r4wZiMEXbKNgXrPGwsTeUr8U0m
         bHsPdgzKOzYdGhYZguK1a5sOmgLn1cqGvHJ9Z5y7L9AdFuEfn6dk65roxABFoibR8UHH
         hiqldTeC5GrCBZrJh3RA2hGuyX1NUZ65TKJ15QwsSYvZUnhAR9Cp78Q+zoJ+S2b5xZ34
         asErU9V/8yoZWCwKQx535jV6bG/Ei9/CVjfFPqR6wQuWZuBWVZmRqWDLSPlwtC+ozYmC
         7CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Luv1w90bGIZpla0q6CHg6tLSZSaRqkZZIK2We0F6BcI=;
        b=GiTSAR6t2+MbfvQ1vdhqkEXjfhNGiI/m/y5CkUoUOpBodrPWtP3sOpjlMpOK5YsbkR
         c0JSENEERP+4+REOIwTV1btOZ9fTro9H1elmVuVDngUq8kUD6g+ACmYqS+qEtn5tmqEz
         iXdO3PEBxX3GQaRXeJu4dnwYdgJeovTzX4Mz3v8ODiyPX56l2Autv/TT0ytZXfxvMuHA
         d3+yu3kFZ9QtiJsyJVH1g4Ht/vdfa0HWWndVVT07AYnx1R08qRvdhm6YuQfixpFlqrBt
         fELdRl7PKbXcv7nMVEc7bR3ypO0u4H4h+QXwKI1DhzGkcn/eZfZ3WanWRD0nsxrVxFsn
         ExaQ==
X-Gm-Message-State: AA+aEWY29K/T6Ii6Zv39j0krfMnPUnw6q7m/4sdxNPX5ASwpt5zhIWVB
        +RiPnx/++sxgRtBw7SoKnTuH3qX19aEA2cJzAbo=
X-Google-Smtp-Source: AFSGD/X2PV717Cot/kpZU/E+0QLsbdcSJcmYZP87Mydoifo0fbIpT0qPjrnX36Vc5cqG6rFAzWCcwVEIEnR+BZMR3xk=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr13904705otl.343.1545159787217;
 Tue, 18 Dec 2018 11:03:07 -0800 (PST)
MIME-Version: 1.0
References: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
 <a31ecb59-e330-08c8-95d3-8c9fe5a4022d@tycho.nsa.gov> <877d53f9-3296-368c-979f-cf73cfc50ebb@tycho.nsa.gov>
 <CAFftDdofWyE747=fFUXj8v8bN3aipgguWVziDpOhd9_VVsasmQ@mail.gmail.com> <CAFftDdr+1zWpGeBgpfhQ02fbfhCD2F5_F0mUTB2zQobKpANg8g@mail.gmail.com>
In-Reply-To: <CAFftDdr+1zWpGeBgpfhQ02fbfhCD2F5_F0mUTB2zQobKpANg8g@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 18 Dec 2018 11:02:54 -0800
Message-ID: <CAFftDdoMFfjn=2yB-qXhwH=TonH=42pBNbczkVVwvQtr7UZn9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile: fix _FORTIFY_SOURCE redefined build error
To:     Stephen Smalley <sds@tycho.nsa.gov>, ps@pks.im,
        berrange@redhat.com, Eric Paris <eparis@parisplace.org>,
        Eric Paris <eparis@redhat.com>
Cc:     selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

+ Eric and Dan, as Stephen pointed out to me, they introduced the -Wp
portion in commit 41649ca78

On Tue, Dec 18, 2018 at 8:03 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> Patrick,
>
> Hoping you could maybe weigh in on your choice for bypassing the
> compiler driver with -Wp and not setting _FORTIFY_SOURCE to something
> like 1 or 2?
>
> I'm seeing this issue on Ubuntu 16.04.5:
> <command-line>:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]
>
> gcc version:
> gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
>
> My thought is to undef/redef _FORTIFY_SOURCE in CFLAGS and set the
> level to 2. Setting CFLAGS via the env/make arg will override this
> behavior
> and use CFLAGS as is.
>
> On Fri, Dec 14, 2018 at 8:02 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Fri, Dec 14, 2018 at 6:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >
> > > On 12/14/18 8:43 AM, Stephen Smalley wrote:
> > > > On 12/13/18 4:32 PM, bill.c.roberts@gmail.com wrote:
> > > >> From: William Roberts <william.c.roberts@intel.com>
> > > >>
> > > >> Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
> > > >> <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
> > > >> <command-line>:0:0: note: this is the location of the previous definition
> > > >>
> > > >> Correct this by undefining it first and redefining it. Also, the previous
> > > >> command line option was using -Wp which passing the value *AS IS* to the
> > > >> pre-processor rather than to the compiler driver. The C pre-processor has
> > > >> an undocumented interface subject to change per man 1 gcc. Just use the
> > > >> -D option as is.
> > > >
> > > > See commit ca07a2ad46be141dad90d885dd33a2ac31c6559a ("libselinux: avoid
> > > > redefining _FORTIFY_SOURCE") for why we don't specify a value for
> > > > _FORTIFY_SOURCE here.  Not sure about the -Wp,-D vs -D rationale.
> >
> > I'm not 100% convinced that the patch is the best solution or the commit message
> > is describing the problem correctly. I could also be understanding it
> > wrong here.
> > The man page is saying not to bypass the compiler driver via -Wp, and I don't
> > see a good reason for it either.
> >
> > See my comments below, they feed back into this.
> >
> > >
> > > I guess the issue here is that we want to provide sane defaults for
> > > building without breaking the build when others specify their own
> > > definitions and without weakening those definitions.  By undefining and
> > > re-defining, it seems like we might weaken existing builds that were
> > > specifying 2.
> >
> > We conditionally assign to CFLAGS via ?= operator. Thus, CFLAGS and the
> > corresponding addition of EXTRA_CFLAGS which contains the undef/def
> > is not appended. CFLAGS specified via the environment or as an argument to
> > make will cause this assignment not to occur (via ?= semantics) and whatever
> > they specify for CFLAGS is sent to CC.
> >
> > Here is some sample output:
> > make CFLAGS='-D_FORTIFY_SOURCE=2'
> > cc -D_FORTIFY_SOURCE=2 -I../include -D_GNU_SOURCE -DNO_ANDROID_BACKEND
> >  -fPIC -DSHARED -c -o stringrep.lo stringrep.c
> >
> > With that said, *i think its safe* to bump it back to '-D_FORTIFY_SOURCE=2'
> >
> > >
> > > >
> > > >>
> > > >> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > >> ---
> > > >>   libselinux/src/Makefile   | 2 +-
> > > >>   libselinux/utils/Makefile | 2 +-
> > > >>   2 files changed, 2 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > >> index 977b5c8cfcca..ee55bd0dbff7 100644
> > > >> --- a/libselinux/src/Makefile
> > > >> +++ b/libselinux/src/Makefile
> > > >> @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
> > > >>   EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op
> > > >> -Wpacked-bitfield-compat -Wsync-nand \
> > > >>       -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
> > > >> -Wsuggest-attribute=const \
> > > >>       -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> > > >> -Wtrampolines -Wjump-misses-init \
> > > >> -    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > > >> -Wp,-D_FORTIFY_SOURCE
> > > >> +    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > > >> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
> > > >>   else
> > > >>   EXTRA_CFLAGS = -Wunused-command-line-argument
> > > >>   endif
> > > >> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > > >> index d06ffd66893b..64ab877015c6 100644
> > > >> --- a/libselinux/utils/Makefile
> > > >> +++ b/libselinux/utils/Makefile
> > > >> @@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k
> > > >> -Wformat-security -Winit-self -Wmissi
> > > >>             -Wformat-extra-args -Wformat-zero-length -Wformat=2
> > > >> -Wmultichar \
> > > >>             -Woverflow -Wpointer-to-int-cast -Wpragmas \
> > > >>             -Wno-missing-field-initializers -Wno-sign-compare \
> > > >> -          -Wno-format-nonliteral
> > > >> -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
> > > >> +          -Wno-format-nonliteral
> > > >> -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE
> > > >> -D_FORTIFY_SOURCE=1 \
> > > >>             -fstack-protector-all --param=ssp-buffer-size=4
> > > >> -fexceptions \
> > > >>             -fasynchronous-unwind-tables -fdiagnostics-show-option
> > > >> -funit-at-a-time \
> > > >>             -Werror -Wno-aggregate-return -Wno-redundant-decls \
> > > >>
> > > >
> > >
