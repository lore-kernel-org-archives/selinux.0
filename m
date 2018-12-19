Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EB4C43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 15:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E9920449
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcRfLpXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeLSPsg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:48:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43123 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbeLSPsg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Dec 2018 10:48:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so1950112oie.10
        for <selinux@vger.kernel.org>; Wed, 19 Dec 2018 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wF6sKvlRJaJ8ugBJHW0tL7w7eMFVOiouOT5qaPbAUtw=;
        b=YcRfLpXL/5e3VhlWwXXY/DdbFfsoe9iPtQKosd13xaxtBXcGXVIs/DM3W67q9o/cd2
         1g0J6A564CJb68p1Dk+6aZv9JUFgjVNIDN0YK7Y538DAxVo2L9Q/OqvIPUQyUuVw3DuH
         /ixJjGzcnervZYhQP4XMy5XFpre+byy4IbqIqd2WGTFgTiaZI9zJRT5JTCe7VPemcgAK
         cjnR7EroqgXxfrJP2sIAucF0xT2ymmH4i1UxVT8LMmqRbfg5hxPu0I0KIFJsAfNiOaer
         NQuJG7iSoTXROoRG8XA+4nRRmtKbgElfRPUqyRgL/zHFJJ8qG6ATxY7n3XIPiZ4Qwokz
         Q8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wF6sKvlRJaJ8ugBJHW0tL7w7eMFVOiouOT5qaPbAUtw=;
        b=kDYXBEsVD5RhFrafGR/aGtQ+8PuYNFKwnxW3fpZidL3lCqGm6ap2UKyqsNaM+K9TPs
         A1GDxASaxiqNQ7SMINa2uM2CIsrpWTU7efvFIMDdpkXDjAbkT1tLv086s0YKDWuj1Min
         R40qm4OCXLH84og2BO9k/VekREnnMt/dCNbNyskYXbBb1PsOIuYpxs+IJRgJdzckCLr7
         3E7tztofmc5F3hUBGUslZ0/v1J0z/w5KFju8EKwMD7xE5QvFRHEJxFahQlwAVicmm7FX
         uq8LLbGUhFd3DPNXJDlSJR0YnaSaTBuDdCxZPOey9IzGz6m3EDbSQgj3rSEGxgV4SKzQ
         42jA==
X-Gm-Message-State: AA+aEWZGWyrsQJjMBoyT39rsvXqAh+IrE8gHn/pSys0VhhUTf1FWSyMT
        QsvoeyhWB5KJAb8SMKdZBnRhYr08Ft0bceCKRFQ=
X-Google-Smtp-Source: AFSGD/WIseC5APPzBiw3urNiOGUzzYs/8istB4zbwFmGanHTTXFAz2aK/2f7OYhRvmqPxw8Bed8QZHQUDNpwNT1ZSoA=
X-Received: by 2002:a05:6808:21a:: with SMTP id l26mr1124924oie.312.1545234515021;
 Wed, 19 Dec 2018 07:48:35 -0800 (PST)
MIME-Version: 1.0
References: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
 <a31ecb59-e330-08c8-95d3-8c9fe5a4022d@tycho.nsa.gov> <877d53f9-3296-368c-979f-cf73cfc50ebb@tycho.nsa.gov>
 <CAFftDdofWyE747=fFUXj8v8bN3aipgguWVziDpOhd9_VVsasmQ@mail.gmail.com>
 <CAFftDdr+1zWpGeBgpfhQ02fbfhCD2F5_F0mUTB2zQobKpANg8g@mail.gmail.com>
 <20181219091224.GA1887@ncase> <CAFftDdpvykcTgD=-QMBf9==3BgQpAhgfjcfRA5u8HpYNEJLYEg@mail.gmail.com>
 <53afe8e8-3f96-e36e-341b-2c8a71f02ebf@tycho.nsa.gov>
In-Reply-To: <53afe8e8-3f96-e36e-341b-2c8a71f02ebf@tycho.nsa.gov>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 19 Dec 2018 07:48:23 -0800
Message-ID: <CAFftDdruY_UsGQZit=L2dSUi94dCLtFDTRr2oS8KWc4730dcrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile: fix _FORTIFY_SOURCE redefined build error
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Patrick Steinhardt <ps@pks.im>, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 19, 2018 at 7:44 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 12/19/18 10:42 AM, William Roberts wrote:
> > On Wed, Dec 19, 2018 at 1:12 AM Patrick Steinhardt <ps@pks.im> wrote:
> >>
> >> Hi,
> >>
> >> On Tue, Dec 18, 2018 at 08:03:54AM -0800, William Roberts wrote:
> >>> Patrick,
> >>>
> >>> Hoping you could maybe weigh in on your choice for bypassing the
> >>> compiler driver with -Wp and not setting _FORTIFY_SOURCE to something
> >>> like 1 or 2?
> >>>
> >>> I'm seeing this issue on Ubuntu 16.04.5:
> >>> <command-line>:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]
> >>>
> >>> gcc version:
> >>> gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
> >>>
> >>> My thought is to undef/redef _FORTIFY_SOURCE in CFLAGS and set the
> >>> level to 2. Setting CFLAGS via the env/make arg will override this
> >>> behavior
> >>> and use CFLAGS as is.
> >>
> >> I used "-Wp" simply because it was existing previously, so I just
> >> stuck to what was there already. The original issue I had was
> >> that Gentoo Hardened, as Jason notes, already defines
> >> _FORTIFY_SOURCE as part of the compiler spec. Due to that, I was
> >> seeing a lot of warnings.
> >>
> >> So I set the flag to a simple define without setting a specific
> >> value, which _seemed_ to let the issue go away. But going back to
> >> the initial issue, this didn't seem to have solved it correctly.
> >> Dunno what I've been doing back then to not see the warnings
> >> after my change anymore, but I noticed that they have resurface
> >> recently.
> >>
> >> So I guess the real fix would be to redefine the value by first
> >> undef'ing it and then redefining it to the desired value. And I
> >> do agree that in that case, we should simply revert to
> >> _FORTIFY_SOURCE=2.
> >>
> >> Patrick
> >>
> >>> On Fri, Dec 14, 2018 at 8:02 AM William Roberts
> >>> <bill.c.roberts@gmail.com> wrote:
> >>>>
> >>>> On Fri, Dec 14, 2018 at 6:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>>>>
> >>>>> On 12/14/18 8:43 AM, Stephen Smalley wrote:
> >>>>>> On 12/13/18 4:32 PM, bill.c.roberts@gmail.com wrote:
> >>>>>>> From: William Roberts <william.c.roberts@intel.com>
> >>>>>>>
> >>>>>>> Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
> >>>>>>> <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
> >>>>>>> <command-line>:0:0: note: this is the location of the previous definition
> >>>>>>>
> >>>>>>> Correct this by undefining it first and redefining it. Also, the previous
> >>>>>>> command line option was using -Wp which passing the value *AS IS* to the
> >>>>>>> pre-processor rather than to the compiler driver. The C pre-processor has
> >>>>>>> an undocumented interface subject to change per man 1 gcc. Just use the
> >>>>>>> -D option as is.
> >>>>>>
> >>>>>> See commit ca07a2ad46be141dad90d885dd33a2ac31c6559a ("libselinux: avoid
> >>>>>> redefining _FORTIFY_SOURCE") for why we don't specify a value for
> >>>>>> _FORTIFY_SOURCE here.  Not sure about the -Wp,-D vs -D rationale.
> >>>>
> >>>> I'm not 100% convinced that the patch is the best solution or the commit message
> >>>> is describing the problem correctly. I could also be understanding it
> >>>> wrong here.
> >>>> The man page is saying not to bypass the compiler driver via -Wp, and I don't
> >>>> see a good reason for it either.
> >>>>
> >>>> See my comments below, they feed back into this.
> >>>>
> >>>>>
> >>>>> I guess the issue here is that we want to provide sane defaults for
> >>>>> building without breaking the build when others specify their own
> >>>>> definitions and without weakening those definitions.  By undefining and
> >>>>> re-defining, it seems like we might weaken existing builds that were
> >>>>> specifying 2.
> >>>>
> >>>> We conditionally assign to CFLAGS via ?= operator. Thus, CFLAGS and the
> >>>> corresponding addition of EXTRA_CFLAGS which contains the undef/def
> >>>> is not appended. CFLAGS specified via the environment or as an argument to
> >>>> make will cause this assignment not to occur (via ?= semantics) and whatever
> >>>> they specify for CFLAGS is sent to CC.
> >>>>
> >>>> Here is some sample output:
> >>>> make CFLAGS='-D_FORTIFY_SOURCE=2'
> >>>> cc -D_FORTIFY_SOURCE=2 -I../include -D_GNU_SOURCE -DNO_ANDROID_BACKEND
> >>>>   -fPIC -DSHARED -c -o stringrep.lo stringrep.c
> >>>>
> >>>> With that said, *i think its safe* to bump it back to '-D_FORTIFY_SOURCE=2'
> >
> > I agree that 2 is the better value. I'll re-roll these to use 2. No
> > one seems to be complaining
> > on using the -D/-U options.
>
> The only alternative that I could see would be to just drop
> FORTIFY_SOURCE altogether from the upstream Makefile and defer setting
> of it entirely to the packagers...

I like having a sane set of defaults and I think _FORTIFY_SOURCE=2 is
inline with it.
I guess we can try moving back to 2, and if someone complains, just
stop setting it.

>
> >
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> >>>>>>> ---
> >>>>>>>    libselinux/src/Makefile   | 2 +-
> >>>>>>>    libselinux/utils/Makefile | 2 +-
> >>>>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> >>>>>>> index 977b5c8cfcca..ee55bd0dbff7 100644
> >>>>>>> --- a/libselinux/src/Makefile
> >>>>>>> +++ b/libselinux/src/Makefile
> >>>>>>> @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
> >>>>>>>    EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op
> >>>>>>> -Wpacked-bitfield-compat -Wsync-nand \
> >>>>>>>        -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
> >>>>>>> -Wsuggest-attribute=const \
> >>>>>>>        -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> >>>>>>> -Wtrampolines -Wjump-misses-init \
> >>>>>>> -    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> >>>>>>> -Wp,-D_FORTIFY_SOURCE
> >>>>>>> +    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> >>>>>>> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
> >>>>>>>    else
> >>>>>>>    EXTRA_CFLAGS = -Wunused-command-line-argument
> >>>>>>>    endif
> >>>>>>> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> >>>>>>> index d06ffd66893b..64ab877015c6 100644
> >>>>>>> --- a/libselinux/utils/Makefile
> >>>>>>> +++ b/libselinux/utils/Makefile
> >>>>>>> @@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k
> >>>>>>> -Wformat-security -Winit-self -Wmissi
> >>>>>>>              -Wformat-extra-args -Wformat-zero-length -Wformat=2
> >>>>>>> -Wmultichar \
> >>>>>>>              -Woverflow -Wpointer-to-int-cast -Wpragmas \
> >>>>>>>              -Wno-missing-field-initializers -Wno-sign-compare \
> >>>>>>> -          -Wno-format-nonliteral
> >>>>>>> -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
> >>>>>>> +          -Wno-format-nonliteral
> >>>>>>> -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE
> >>>>>>> -D_FORTIFY_SOURCE=1 \
> >>>>>>>              -fstack-protector-all --param=ssp-buffer-size=4
> >>>>>>> -fexceptions \
> >>>>>>>              -fasynchronous-unwind-tables -fdiagnostics-show-option
> >>>>>>> -funit-at-a-time \
> >>>>>>>              -Werror -Wno-aggregate-return -Wno-redundant-decls \
>
