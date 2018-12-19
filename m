Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FD9C43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E0A20449
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j63Gn2l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbeLSPmw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:42:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36058 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbeLSPmw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Dec 2018 10:42:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so19503360otk.3
        for <selinux@vger.kernel.org>; Wed, 19 Dec 2018 07:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWnRzvW4psFPteidosePoiiMR9ds84EA7gzyRM6GOdc=;
        b=j63Gn2l2ao7etptiekM9aTaVO630uoAgQRJJOWBO101RWLN9DkoebS1cb4E6fWdgYR
         Gn52lhOj2ukc/zgvwabznBEtHoLSlnx78QoI9zE3UQ/j+hDLYLuAYm+SxXaxPCcgeNqk
         CoQ1P5HYdO0WrGe0SdhvuH3N5qAkSORVGZJ4RUg7danObIrrFoon3D7H20OgSiXhPdnF
         o0Q5miBIJ3yO+GuAlTKK+SrBIfUtvvXx/p3GeCH1aqQiXpKQmdemvQ+yq0og0qtTO4bh
         mMO2rMpEHNLf3qUZcQfSLZPAFA1uqQfIwKal5AmG72ZGL4NY5y7Q8kB686G0BnlIU1A0
         cLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWnRzvW4psFPteidosePoiiMR9ds84EA7gzyRM6GOdc=;
        b=F3/wuqR5aJfyqahLd8yAHie1Hmi1DbOW/HbBcT85i6GLmTiEV6T7kJruk9GVC7qVRK
         AndJksRgsZ4f47MTE2rhyZBIqfYKoAE/iMcpubSFH8ydQEgnivjh0SnV08p2mroTFdr4
         UZuBFGlgWLtd0nJzBM0eDddVGL+VPQ1UCSKCCiqhlEHHZyF3PSlwa8Dj/Zl+SJmJlNmD
         pZisD9zrasjxf0LECL1UA6y+7oT6rZCJJQH2RysBelx8ypiYPP0MlfyEsaa5LDolfvzW
         kpUGiWlPuAvf2gbljBeQ1AE8O3nu8MrwFCs0ij4hOYv4OY+6/A5xcHaHIzi3WTBYwjBy
         irlA==
X-Gm-Message-State: AA+aEWb0Loacep7nvjeA0lyUMUGP+YLe+PU9b9rGb2FxCkUTBUt5OKye
        bd7AQ2rWPFhKNLdEAI8iJUPowRDCiTYWGfhdK4Bglw==
X-Google-Smtp-Source: AFSGD/XO8QkM3oYdrQZr8PaZdmx+9mp5QbzKx6SMhJsi7R/4EjDz4HjMscYCeu4Pn/sX/mSWY4BymfEcQNWz/uFH+qA=
X-Received: by 2002:a9d:1ea7:: with SMTP id n36mr15517940otn.217.1545234170669;
 Wed, 19 Dec 2018 07:42:50 -0800 (PST)
MIME-Version: 1.0
References: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
 <a31ecb59-e330-08c8-95d3-8c9fe5a4022d@tycho.nsa.gov> <877d53f9-3296-368c-979f-cf73cfc50ebb@tycho.nsa.gov>
 <CAFftDdofWyE747=fFUXj8v8bN3aipgguWVziDpOhd9_VVsasmQ@mail.gmail.com>
 <CAFftDdr+1zWpGeBgpfhQ02fbfhCD2F5_F0mUTB2zQobKpANg8g@mail.gmail.com> <20181219091224.GA1887@ncase>
In-Reply-To: <20181219091224.GA1887@ncase>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 19 Dec 2018 07:42:39 -0800
Message-ID: <CAFftDdpvykcTgD=-QMBf9==3BgQpAhgfjcfRA5u8HpYNEJLYEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile: fix _FORTIFY_SOURCE redefined build error
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 19, 2018 at 1:12 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> Hi,
>
> On Tue, Dec 18, 2018 at 08:03:54AM -0800, William Roberts wrote:
> > Patrick,
> >
> > Hoping you could maybe weigh in on your choice for bypassing the
> > compiler driver with -Wp and not setting _FORTIFY_SOURCE to something
> > like 1 or 2?
> >
> > I'm seeing this issue on Ubuntu 16.04.5:
> > <command-line>:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]
> >
> > gcc version:
> > gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
> >
> > My thought is to undef/redef _FORTIFY_SOURCE in CFLAGS and set the
> > level to 2. Setting CFLAGS via the env/make arg will override this
> > behavior
> > and use CFLAGS as is.
>
> I used "-Wp" simply because it was existing previously, so I just
> stuck to what was there already. The original issue I had was
> that Gentoo Hardened, as Jason notes, already defines
> _FORTIFY_SOURCE as part of the compiler spec. Due to that, I was
> seeing a lot of warnings.
>
> So I set the flag to a simple define without setting a specific
> value, which _seemed_ to let the issue go away. But going back to
> the initial issue, this didn't seem to have solved it correctly.
> Dunno what I've been doing back then to not see the warnings
> after my change anymore, but I noticed that they have resurface
> recently.
>
> So I guess the real fix would be to redefine the value by first
> undef'ing it and then redefining it to the desired value. And I
> do agree that in that case, we should simply revert to
> _FORTIFY_SOURCE=2.
>
> Patrick
>
> > On Fri, Dec 14, 2018 at 8:02 AM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > On Fri, Dec 14, 2018 at 6:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >
> > > > On 12/14/18 8:43 AM, Stephen Smalley wrote:
> > > > > On 12/13/18 4:32 PM, bill.c.roberts@gmail.com wrote:
> > > > >> From: William Roberts <william.c.roberts@intel.com>
> > > > >>
> > > > >> Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
> > > > >> <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
> > > > >> <command-line>:0:0: note: this is the location of the previous definition
> > > > >>
> > > > >> Correct this by undefining it first and redefining it. Also, the previous
> > > > >> command line option was using -Wp which passing the value *AS IS* to the
> > > > >> pre-processor rather than to the compiler driver. The C pre-processor has
> > > > >> an undocumented interface subject to change per man 1 gcc. Just use the
> > > > >> -D option as is.
> > > > >
> > > > > See commit ca07a2ad46be141dad90d885dd33a2ac31c6559a ("libselinux: avoid
> > > > > redefining _FORTIFY_SOURCE") for why we don't specify a value for
> > > > > _FORTIFY_SOURCE here.  Not sure about the -Wp,-D vs -D rationale.
> > >
> > > I'm not 100% convinced that the patch is the best solution or the commit message
> > > is describing the problem correctly. I could also be understanding it
> > > wrong here.
> > > The man page is saying not to bypass the compiler driver via -Wp, and I don't
> > > see a good reason for it either.
> > >
> > > See my comments below, they feed back into this.
> > >
> > > >
> > > > I guess the issue here is that we want to provide sane defaults for
> > > > building without breaking the build when others specify their own
> > > > definitions and without weakening those definitions.  By undefining and
> > > > re-defining, it seems like we might weaken existing builds that were
> > > > specifying 2.
> > >
> > > We conditionally assign to CFLAGS via ?= operator. Thus, CFLAGS and the
> > > corresponding addition of EXTRA_CFLAGS which contains the undef/def
> > > is not appended. CFLAGS specified via the environment or as an argument to
> > > make will cause this assignment not to occur (via ?= semantics) and whatever
> > > they specify for CFLAGS is sent to CC.
> > >
> > > Here is some sample output:
> > > make CFLAGS='-D_FORTIFY_SOURCE=2'
> > > cc -D_FORTIFY_SOURCE=2 -I../include -D_GNU_SOURCE -DNO_ANDROID_BACKEND
> > >  -fPIC -DSHARED -c -o stringrep.lo stringrep.c
> > >
> > > With that said, *i think its safe* to bump it back to '-D_FORTIFY_SOURCE=2'

I agree that 2 is the better value. I'll re-roll these to use 2. No
one seems to be complaining
on using the -D/-U options.

> > >
> > > >
> > > > >
> > > > >>
> > > > >> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > >> ---
> > > > >>   libselinux/src/Makefile   | 2 +-
> > > > >>   libselinux/utils/Makefile | 2 +-
> > > > >>   2 files changed, 2 insertions(+), 2 deletions(-)
> > > > >>
> > > > >> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > > >> index 977b5c8cfcca..ee55bd0dbff7 100644
> > > > >> --- a/libselinux/src/Makefile
> > > > >> +++ b/libselinux/src/Makefile
> > > > >> @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
> > > > >>   EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op
> > > > >> -Wpacked-bitfield-compat -Wsync-nand \
> > > > >>       -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
> > > > >> -Wsuggest-attribute=const \
> > > > >>       -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> > > > >> -Wtrampolines -Wjump-misses-init \
> > > > >> -    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > > > >> -Wp,-D_FORTIFY_SOURCE
> > > > >> +    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > > > >> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
> > > > >>   else
> > > > >>   EXTRA_CFLAGS = -Wunused-command-line-argument
> > > > >>   endif
> > > > >> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > > > >> index d06ffd66893b..64ab877015c6 100644
> > > > >> --- a/libselinux/utils/Makefile
> > > > >> +++ b/libselinux/utils/Makefile
> > > > >> @@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k
> > > > >> -Wformat-security -Winit-self -Wmissi
> > > > >>             -Wformat-extra-args -Wformat-zero-length -Wformat=2
> > > > >> -Wmultichar \
> > > > >>             -Woverflow -Wpointer-to-int-cast -Wpragmas \
> > > > >>             -Wno-missing-field-initializers -Wno-sign-compare \
> > > > >> -          -Wno-format-nonliteral
> > > > >> -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
> > > > >> +          -Wno-format-nonliteral
> > > > >> -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE
> > > > >> -D_FORTIFY_SOURCE=1 \
> > > > >>             -fstack-protector-all --param=ssp-buffer-size=4
> > > > >> -fexceptions \
> > > > >>             -fasynchronous-unwind-tables -fdiagnostics-show-option
> > > > >> -funit-at-a-time \
> > > > >>             -Werror -Wno-aggregate-return -Wno-redundant-decls \
