Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B39FC433E2
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 15:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D471320770
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzZRH+U2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgIOPVp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgIOPUw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 11:20:52 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38343C06174A
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 08:20:52 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id w25so3576930otk.8
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SX9LzBk2lFm4rgK8GN0bBTGK/i8QdgckpiaO2aDE+fk=;
        b=ZzZRH+U2yoNo2DuAdzwX3a3mVjz4M2UiknfoP8pm2kIcGkxGjxjRmpWZeCsnWwc44b
         Kf2epU2QckaJa21AKJpwVLtV6lpa4jfixnITHsN9km4UHCYgzx2AMODh5vSoZOnS1Z6q
         a4vU8ypPStO55V6Mlpouh49kvjkSYaMjTBt1LO+rEUqbkemMyVnQ0WBMnz+M58ofLuF5
         qyUfKzkJJRLTnOp2JIc5v5MNzcAdl+7N6+kdHgaJfyWIJeOjRYcPvWYVSbLksvKwLyAU
         YrU9FV7v78FxswAImUZy+emV5UmbRotOd+6VkqZENawupgjErPZlyHNUvKAHI6vjS6a6
         5IvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SX9LzBk2lFm4rgK8GN0bBTGK/i8QdgckpiaO2aDE+fk=;
        b=ho7BkZGL+WD0eBgVldNbG/5e2moxJ73w/qcsI5VjaQMKqGnjVuopgmMTJdgrQjPxVz
         35IVt71H6/xNNp/FAqN8lVQ2Qb5gdJMKqlij+XkQzYM0yt3oJXJPSJCQ2NF9UVwDWihT
         LTAyyvNhQBPFFvzcetENWWY38csQ5NumwCpNDvmnwwlCoPNYncNDo2OmTcMSUJEr7/6G
         6t9Hp6+5todEukSxntQV9j20gbGrLrGwFf1M2IF8gPWEr/SXry5xCIjxiKuzxIu3cNkl
         A6hyo6AtLVCi3PsxlNToduEDdCdIuoDbEaOW+f7xmsHo3Uo7RQ1dMbEGvtDKS57CapIz
         Q9nw==
X-Gm-Message-State: AOAM530tywlvyksB7d8oQD/IPdT5nXUOA/0PGDBk1ywQr4EEnD68s5Y5
        elJSB0ZEjzr4OYwL9E/OV/H9zBBxjGrSrzLcbr8=
X-Google-Smtp-Source: ABdhPJx4eSLvFH3uqyph7vcaew9R9qLJ4OJomVYGVdHAEk9HE9wyjiuM2Vlmyj+pN2tlcSaUFMZE4Vk2DsBD6F3w7Kk=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr12603087otn.89.1600183251522;
 Tue, 15 Sep 2020 08:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200915130516.561693-1-chpebeni@linux.microsoft.com>
 <CAEjxPJ77s7WHqixbD60LnEOG_+WYc2mOj0cTPMoKXqk8M5zqBg@mail.gmail.com>
 <6bff0d2f-5e33-213f-dfe5-e3af01474860@linux.microsoft.com>
 <CAEjxPJ7Wj6R9y00=m1z9-qrC2+1onVOQQagD+WV0LxXpcJJCtg@mail.gmail.com> <ddf77261-7fa4-9ff6-01ed-3ac0f3c9e2cc@linux.microsoft.com>
In-Reply-To: <ddf77261-7fa4-9ff6-01ed-3ac0f3c9e2cc@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 15 Sep 2020 11:20:40 -0400
Message-ID: <CAEjxPJ6=s504ZdWevGALxxksCF4tsQ46meD8iCg7sCFoV9sKSA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] libselinux: Revise userspace AVC avc_log() for
 auditable events.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 15, 2020 at 11:04 AM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> On 9/15/20 10:43 AM, Stephen Smalley wrote:
> > On Tue, Sep 15, 2020 at 10:33 AM Chris PeBenito
> > <chpebeni@linux.microsoft.com> wrote:
> >>
> >> On 9/15/20 9:34 AM, Stephen Smalley wrote:
> >>> On Tue, Sep 15, 2020 at 9:11 AM Chris PeBenito
> >>> <chpebeni@linux.microsoft.com> wrote:
> >>>> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> >>>> index 572b2159..35ea59b6 100644
> >>>> --- a/libselinux/src/avc_internal.c
> >>>> +++ b/libselinux/src/avc_internal.c
> >>>> @@ -59,14 +59,14 @@ int avc_process_setenforce(int enforcing)
> >>>>           int rc = 0;
> >>>>
> >>>>           avc_log(SELINUX_SETENFORCE,
> >>>> -               "%s:  received setenforce notice (enforcing=%d)\n",
> >>>> +               "%s:  op=setenforce lsm=selinux_uavc enforcing=%d res=1",
> >>>>                   avc_prefix, enforcing);
> >>>>           if (avc_setenforce)
> >>>>                   goto out;
> >>>>           avc_enforcing = enforcing;
> >>>>           if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
> >>>>                   avc_log(SELINUX_ERROR,
> >>>> -                       "%s:  cache reset returned %d (errno %d)\n",
> >>>> +                       "%s:  op=cache_reset lsm=selinux_uavc rc=%d errno=%d res=0",
> >>>>                           avc_prefix, rc, errno);
> >>>
> >>> If we do this at all, I would think the op= would still be setenforce
> >>> and this would just be an error for it.
> >>
> >> At this point we already audited success for the setenforce operation.  Wouldn't
> >> it be confusing to have a op=setenforce res=1 and then immediately op=setenforce
> >> res=0?
> >
> > Yes.  On second thought, I don't think any of the SELINUX_ERROR
> > messages are intended for audit and since that is already a different
> > type value, the callbacks can already redirect those to stderr or
> > syslog as appropriate instead of audit.
>
> Are the typebounds and validatetrans in UAVC passed to the kernel for
> evaluation? The kernel audits failures on those as SELINUX_ERR.  If the UAVC
> handles them itself, it seems that those failures should be audited as
> USER_SELINUX_ERR.

The userspace AVC defers all of the security_compute_av() logic to the kernel.
