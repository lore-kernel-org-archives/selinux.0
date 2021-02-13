Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61799C433E0
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 14:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BA764DD5
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 14:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhBMOXG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Feb 2021 09:23:06 -0500
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:51295
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhBMOXG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Feb 2021 09:23:06 -0500
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Feb 2021 09:23:05 EST
Received: from mail-wm1-f53.google.com ([209.85.128.53])
        by :SMTPAUTH: with ESMTPA
        id Avg3lKw5C2yU1Avg4lyTm6; Sat, 13 Feb 2021 07:13:40 -0700
X-CMAE-Analysis: v=2.4 cv=KaoXDSUD c=1 sm=1 tr=0 ts=6027de94
 a=pWQ66DXCvm2Ia3q8irZcxw==:117 a=IkcTkHD0fZMA:10 a=qa6Q16uM49sA:10
 a=QsYl2dacAAAA:8 a=oSqZqoiyAAAA:8 a=inLY17TL9gPSBG-ls18A:9 a=QEXdDO2ut3YA:10
 a=jVVJWZ3hHjYA:10 a=jGkiYVYK7qwcb4-OGRgL:22 a=fw9lIXHl4l3rR_lUHM3T:22
X-SECURESERVER-ACCT: peterwhittaker@sphyrnasecurity.com
Received: by mail-wm1-f53.google.com with SMTP id n10so2739823wmq.0
        for <selinux@vger.kernel.org>; Sat, 13 Feb 2021 06:13:40 -0800 (PST)
X-Gm-Message-State: AOAM532ZE9D/9f8/gpX30E+oGsypgokd7m95rAEUW1dTQRip1F6Fzlva
        qPRYGbzVVPAeZsQYDgw+eBIDO2zSbd9eaIPJwzEn7g==
X-Google-Smtp-Source: ABdhPJwC8mnzs/tFAARD5UKWzdWhq0m7GfN6F8q/dhVPuf30lhdZmc8d+lN9UGDBF1CFSHkNBdC4+M3E2g33qu2e4IU=
X-Received: by 2002:a05:600c:48a1:: with SMTP id j33mr6720658wmp.15.1613225618649;
 Sat, 13 Feb 2021 06:13:38 -0800 (PST)
MIME-Version: 1.0
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
 <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
 <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
 <ypjl35y1ot14.fsf@defensec.nl> <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
 <ypjlv9awo2iy.fsf@defensec.nl>
In-Reply-To: <ypjlv9awo2iy.fsf@defensec.nl>
From:   Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Date:   Sat, 13 Feb 2021 09:13:12 -0500
X-Gmail-Original-Message-ID: <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
Message-ID: <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4xfFG696G276YW6zpg7vBuujzlOhUCDno4ENu65nVrrzo3jZgJeWBl04kWCR3fQDii3qKja6M5Mk3B+GGZxUcfZ8vAxrJJXrpJx6HD8tvMFO4i9Af9cIP2
 FbfNWdyYANChTEsqIjW5G7pa4ADJIXGfK6bJBPdVc/EfAJicOxLvZL9r0py5BAnbn2HROpetzSdl5is4Hi6ODfgIU2grme61nsDTdJ89ypU2+ZugVc5YCilp
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 13, 2021 at 2:24 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
> > On Fri, Feb 12, 2021 at 4:52 PM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
> >> > On Fri, Feb 12, 2021 at 2:58 AM Dominick Grift
> >> > <dominick.grift@defensec.nl> wrote:
> >> >> Dominick Grift <dominick.grift@defensec.nl> writes:
> >> >> > Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
> >> >> >>     BLUF: Logging in via SSH or directly at the console results
> >> >> >>     in "Unable to get valid context...". Help! Much info included.
>
> You missed a fundamental type attribute association:
>
> type xferHigh2Local_t, CDTml_types, userdomain, process_user_target;
>
> It seems that you did not associate your process types with "domain":
>
> typeattribute xferHigh2Local_t domain;
>
> See if adding that helps

It didn't - but! The failure motivated me to dive more deeply back
into /var/log/audit/audit.log, wherein I noticed that the desired user
context has been being computed correctly since sometime yesterday
(15:29:25 EST, in fact) - but SSH logins were still failing to assign
that context. So I tried a console login and it worked (I've not made
any console related changes since you started helping me with this).

Progress: The desired context is properly computed and assigned, at
least with console (local) login. This leaves me two major items to
figure out:

    1. Of the changes I have applied over the last 1-3 days,
        what is the minimum set required to achieve this? My
        immediate future includes bisection.

     2. Why doesn't it work with SSH, when it does work with
          the console (yes, the ssh_sysadm_login is on)?

I've read that the latter may have to do with network labelling and/or
default network context, I may need to explore that.

All suggestions welcome!

Thanks! Progress restores optimism.

P
