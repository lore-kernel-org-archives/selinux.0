Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D91C433F5
	for <selinux@archiver.kernel.org>; Thu, 16 Sep 2021 20:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7604760F02
	for <selinux@archiver.kernel.org>; Thu, 16 Sep 2021 20:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhIPUfl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhIPUfk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Sep 2021 16:35:40 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0B9C061574
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 13:34:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y6so4126314oie.4
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 13:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5l29jokyUwqoZERVk0ifTaGDgwnmR6SSeDUEFR1IefI=;
        b=mE6Yf6CyeEHFl7OKL3nAYgbtMceZpGnoqyu8hUpBx5moFK9asjvMCugxff5I2pKbBm
         OceA2My8dUfSnW91s2DRuqKY01k/ibcMvXR6VIUnCwNu2a214AwvxC5QHKrN1eA761s4
         OM0r57zmf/n7eYLStEAWtH6eQfcQiyewa34ovBtRwZKVmaOyy8K9WI4bBpdvC6GSPT7n
         akaro3ct2wJiM1EwNZkBRPJlbYG9SwKudy0Klc4K1qYrPtuDcw/qeI5CxFo2mfmykMAK
         TlVt8Bf7AMD8YAoPSXDBsoekbmKwxeVaMDamwMm2BjyLqLa2JYLdr7PytVRcYr5bWvyU
         +R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5l29jokyUwqoZERVk0ifTaGDgwnmR6SSeDUEFR1IefI=;
        b=u0QnfpdtAcWyAqkplahGDgsyHbTqcb1gnPASj+pSqCRmp5qOCvpI6kAQBo1uL0kHOR
         WmB26L/3hgbwqM03PgqtLKbCqiT+AT3ktwnteMvYeNBtK+hCjN4KlVHa5a6yHMKlakcc
         PzJ/1Beu7AzWVP5YX8W/NIl2NSOIzWrWNkpuMrDfgqhp6q+Wd9tgIRlj9qdqM1LSOp9Q
         BtclTkujOZX3/BOnTNFUeZH+GP9uZLYGkD7lLBsenRUo0oCrKYJCfytonPkFlKWmB9SL
         tRcr902oF3wV6pi7zkEoQKR/oOW0/+alUG9q69FRdEmuIuMQu1pJr4KSsCqIixBfp4sL
         4F5g==
X-Gm-Message-State: AOAM53294zG2krpoBnx7tmYN0i6fTNn1yPL/6P7vmF6XfiGLfzII/4sf
        11VWHiQuNPdmN9PYiynE4azx/9vod/dnsv44Lk8=
X-Google-Smtp-Source: ABdhPJyDTS5CwvVqVHogiqcEqUu3nXHWI9hHaRi/ZOmd+smt718TNqCb5nfORCTzE8PQRcesy5Gcfv5E3MGMzki8h68=
X-Received: by 2002:aca:f189:: with SMTP id p131mr10964500oih.128.1631824457821;
 Thu, 16 Sep 2021 13:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210914124828.19488-1-cgzones@googlemail.com> <CAP+JOzRB4kENk2HGCQ2it-mPbY90oYaDn9w+RFmMt80v=-CcKw@mail.gmail.com>
In-Reply-To: <CAP+JOzRB4kENk2HGCQ2it-mPbY90oYaDn9w+RFmMt80v=-CcKw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 16 Sep 2021 16:34:07 -0400
Message-ID: <CAP+JOzRK7f2+14bRZS3CLiSoLrMZsxQj7r0sL-PYjXh4ECGgAg@mail.gmail.com>
Subject: Re: [PATCH 00/13] checkpolicy improvements
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 15, 2021 at 10:59 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Sep 14, 2021 at 8:51 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Miscellaneous improvements to the checkpolicy subproject, affecting the
> > traditional language compilers checkmodule(8) and checkpolicy(8).
> >
> > Avoid implicit conversions, free leaked memory, resolve several compile=
r
> > warnings, use strict integer parsing.
> >
> > The last patch is an adoption of a patch proposed by liwugang [1], with
> > the requested changes integrated.
> >
> >
> > [1]: https://patchwork.kernel.org/project/selinux/patch/20210601151704.=
2688389-1-liwugang@163.com/
> >
> > Christian G=C3=B6ttsche (13):
> >   libsepol: avoid implicit conversions
> >   libsepol: free memory after policy validation
> >   checkpolicy: enclose macro argument in parentheses
> >   checkpolicy: misc checkmodule tweaks
> >   checkpolicy: misc checkpolicy tweaks
> >   checkpolicy: mark read-only parameters in module compiler const
> >   checkpolicy: mark file local functions in policy_define static
> >   checkpolicy: add missing function declarations
> >   checkpolicy: resolve dismod memory leaks
> >   checkpolicy: avoid implicit conversion
> >   checkpolicy: error out on parsing too big integers
> >   checkpolicy: print warning on source line overflow
> >   checkpolicy: free extended permission memory
> >
> >  checkpolicy/checkmodule.c        | 18 +++----
> >  checkpolicy/checkpolicy.c        | 26 +++++-----
> >  checkpolicy/module_compiler.c    | 26 +++++-----
> >  checkpolicy/module_compiler.h    |  4 +-
> >  checkpolicy/policy_define.c      | 87 ++++++++++++++++----------------
> >  checkpolicy/policy_parse.y       | 16 +++++-
> >  checkpolicy/policy_scan.l        | 25 ++++++---
> >  checkpolicy/test/dismod.c        |  7 ++-
> >  libsepol/src/policydb_validate.c | 14 ++++-
> >  libsepol/src/util.c              |  2 +-
> >  10 files changed, 131 insertions(+), 94 deletions(-)
> >
> > --
> > 2.33.0
> >
>
> For the whole series with the v2 and v3 patches:
>
> Acked-by: James Carter <jwcart2@gmail.com>

This series has been merged.
Thanks,
Jim
