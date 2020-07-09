Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A69C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB5E206DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="dUnlv7Co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGIAfy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGIAfy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 20:35:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A7AC061A0B
        for <selinux@vger.kernel.org>; Wed,  8 Jul 2020 17:35:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so376146ejq.6
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2020 17:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z5j7F5HBPalYnTbZ3R6FCR8nT5FQJTZinI3mHoYgl+Y=;
        b=dUnlv7Co9d6+n6qcKnR/S4Pd99qTwxsIXn6MUCVw/jAeCkztoj/k11L3dLrvPMGpRK
         ALdmlml9dDXddOL/ocAG+gYp55XTrhPY90Bwpfi+vwoFyh/3QgWDhq17PAeSrgFJlsbQ
         W+mS6Pl53yfd8DC4tsQbONAz3W2cGCU3ZVTntZrhjV2eUgPC4zDGguwQQiAKHu+KHOST
         fTMaucOxJkYmV1Yrva8WkFxfmNPQwayDtlJDv1dJbsNTYUEIreMGm9FdPyStaC0uclDw
         caES66HkLveomTr9+XJe7Op01Q+fIA1tlLOT82+8ZirlZLbcjsm+P0RoKBlM2JaDvKbh
         cHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5j7F5HBPalYnTbZ3R6FCR8nT5FQJTZinI3mHoYgl+Y=;
        b=oNhZldTpglSOaMt0K3vhp+lfpv9zN+CeGKl6MK674vmNv8scQr9TeWMRvvOmDlWI2j
         2WkTIGuYeZ0Hweld3m0utIJy57DXED0cLM1rulOECf9zXRZ5guODGC/0dJYkHX+31jm5
         aMRsUOUVTQ+Qk926tLCqx7o/O0s3qGpTZ7dAkj/AHhOtwRw9DEBndmmeQxHxlugafEgg
         4zE85I5o+iF7eaJSurMlvLXKIXjmQ+WJzNyAVlTwuiU6UQ8wBGDzzT35DLolBbeq5A94
         NjGf376mRTxZu6BY9K0V5FUu4wPlaC7udaD8KTa8NAr6UhIVWgIx/XRRTlU63BIVt5Vp
         SItA==
X-Gm-Message-State: AOAM533+VA860sOafsPKPGTMbC8K8WIZEXxjUZPR/gghwe6qxXboeCWX
        iZoE9Tg49Gwhtl/0VtNGAhxM+vd9zZ5ZT6KXnGiA
X-Google-Smtp-Source: ABdhPJwceHdKn0h1vxNKSqjqzy3/uvvkhYXNDiQhLcD+UrcybCZE6wDiL3ACpABps6zm524c4B3JxPXEvOJhYd4xSvc=
X-Received: by 2002:a17:906:1a59:: with SMTP id j25mr51286545ejf.398.1594254952853;
 Wed, 08 Jul 2020 17:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200708112447.292321-1-omosnace@redhat.com> <20200708112447.292321-3-omosnace@redhat.com>
 <CAEjxPJ6HptedbTxrSKi3sYk+7PZ7-JHiNqa9eti86+BWm=Z6pg@mail.gmail.com> <CAFqZXNv9k76BP5Qb0WHsJwMipfkB_Ukc6YpDHV=PAu=jkROuqw@mail.gmail.com>
In-Reply-To: <CAFqZXNv9k76BP5Qb0WHsJwMipfkB_Ukc6YpDHV=PAu=jkROuqw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Jul 2020 20:35:41 -0400
Message-ID: <CAHC9VhQ+CTR=Vp_1SKJYeWzCEDHVCtwfdhrgePMxLjTLczRcXQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] selinux: prepare for inlining of hashtab functions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 8, 2020 at 10:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Jul 8, 2020 at 3:38 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Jul 8, 2020 at 7:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Refactor searching and inserting into hashtabs to pave the way for
> > > converting hashtab_search() and hashtab_insert() to inline functions in
> > > the next patch. This will avoid indirect calls and allow the compiler to
> > > better optimize individual callers, leading to a significant performance
> > > improvement.
> > >
> > > In order to avoid the indirect calls, the key hashing and comparison
> > > callbacks need to be extracted from the hashtab struct and passed
> > > directly to hashtab_search()/_insert() by the callers so that the
> > > callback address is always known at compile time. The kernel's
> > > rhashtable library (<linux/rhashtable*.h>) does the same thing.
> > >
> > > This of course makes the hashtab functions slightly easier to misuse by
> > > passing a wrong callback set, but unfortunately there is no better way
> > > to implement a hash table that is both generic and efficient in C. This
> > > patch tries to somewhat mitigate this by only calling the hashtab
> > > functions in the same file where the corresponding callbacks are
> > > defined (wrapping them into more specialized functions as needed).
> > >
> > > Note that this patch doesn't bring any benefit without also moving the
> > > definitions of hashtab_search() and -_insert() to the header file, which
> > > is done in a follow-up patch for easier review of the hashtab.c changes
> > > in this patch.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > > index 02b722c5c189d..ae78f66e85d29 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -1888,7 +1920,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
> > >         otype = le32_to_cpu(buf[3]);
> > >
> > >         last = NULL;
> > > -       datum = hashtab_search(&p->filename_trans, &key);
> > > +       datum = hashtab_search(&p->filename_trans, &key, filenametr_key_params);
> >
> > Why aren't you using the helper/wrapper function here?
>
> Oversight on my part, thanks for spotting it! I'll wait for Paul's
> feedback and send a fixed v4 if needed.

I remain not overly excited about these patches as I fear they make
the code more prone to error, but they are in a reasonably important
code path so I'll turn a deaf ear to my objections once you make the
changes Stephen is requesting.

-- 
paul moore
www.paul-moore.com
