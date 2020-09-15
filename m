Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133DAC433E2
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 14:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC6F206B7
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 14:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvpbCwmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgIOOoR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 10:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgIOOoA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 10:44:00 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197EDC06174A
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 07:43:42 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c13so4128896oiy.6
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7arfjAjZMvIAuh4Hm2xN+RxGlQA0DLlIOXYRG6/5ngM=;
        b=uvpbCwmjfAQx+Ji8kHeUm9c47KuabMJbQTAlKHU437/dN6DUTQPzhwBRnHXb+9xHbj
         VfhuNBWQPHZXHHwqBKyIQQZBIdBDLg0MXMoo4+APqhqapFb7tSlU3jG3GgKuLLTsb7Dx
         UK77Rexrezg51f7tLK75GUsxk6D9s+TMVBLpCAGWjTZHoSq/sVtIdXVDla70S/oToB73
         coUrc2U725Fz2g3qbL6e79jAPtf6H7C7oIog/QU/EayWplnOxl+3s1tgUcq3RMhjkHfW
         6ok9i3FrIwgOtRl6yt+wxaBby7hVhCqw5zF0EN8ZLo2v3FlclczIHqYlA7hLoJPsDXLT
         qOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7arfjAjZMvIAuh4Hm2xN+RxGlQA0DLlIOXYRG6/5ngM=;
        b=CJP3kwVVjKlQiKCBPIKCqYghMOgqmKWB2n0RdS1Lhl1h/NWvAjRdINkmmSuLFtc7zA
         Bk5sK4CpBbT7i2Jp8Z929ID2qsJJXTllvvU2iJ2LzGFgcjiDHEMwI5/ZpyetMmy5lo11
         K5c/tSxZSeV7lxm+Z1vafxC0f8D5+Im0vRbPrgwcPogIqU4uGR1TYqlrHTz/OXvfG9eD
         6fL/9vEMvH4xJYslt6968KFaLdEHjf27eRoGnkQgYWvswb6B7tXlDokYElOi0h3vYO+V
         HmTvxe1QDrSfxb3ZwttKxFj4TphiFe/xasuG1H3AbFcqsP8+GzmoYfcmJ4Y6Lp/0qkRE
         7R0Q==
X-Gm-Message-State: AOAM533Sk83BlMPOtz0soz911C1YlV1SmoKB7OA0UtMCyOYcROxp/1ll
        5EeuDseTf0kbZ+rT7cjIgVM/UJCd1H8wKae8aSo=
X-Google-Smtp-Source: ABdhPJzlIrqWXGHnJhbOPNUNezvn2HXZ66h7xkwyst5KP/K6cZPmTmj03GuhPkrX9CFz7mcN8RAk3mz32H0fR6mTVvc=
X-Received: by 2002:a05:6808:56f:: with SMTP id j15mr3681140oig.140.1600181021297;
 Tue, 15 Sep 2020 07:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200915130516.561693-1-chpebeni@linux.microsoft.com>
 <CAEjxPJ77s7WHqixbD60LnEOG_+WYc2mOj0cTPMoKXqk8M5zqBg@mail.gmail.com> <6bff0d2f-5e33-213f-dfe5-e3af01474860@linux.microsoft.com>
In-Reply-To: <6bff0d2f-5e33-213f-dfe5-e3af01474860@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 15 Sep 2020 10:43:30 -0400
Message-ID: <CAEjxPJ7Wj6R9y00=m1z9-qrC2+1onVOQQagD+WV0LxXpcJJCtg@mail.gmail.com>
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

On Tue, Sep 15, 2020 at 10:33 AM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> On 9/15/20 9:34 AM, Stephen Smalley wrote:
> > On Tue, Sep 15, 2020 at 9:11 AM Chris PeBenito
> > <chpebeni@linux.microsoft.com> wrote:
> >> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> >> index 572b2159..35ea59b6 100644
> >> --- a/libselinux/src/avc_internal.c
> >> +++ b/libselinux/src/avc_internal.c
> >> @@ -59,14 +59,14 @@ int avc_process_setenforce(int enforcing)
> >>          int rc = 0;
> >>
> >>          avc_log(SELINUX_SETENFORCE,
> >> -               "%s:  received setenforce notice (enforcing=%d)\n",
> >> +               "%s:  op=setenforce lsm=selinux_uavc enforcing=%d res=1",
> >>                  avc_prefix, enforcing);
> >>          if (avc_setenforce)
> >>                  goto out;
> >>          avc_enforcing = enforcing;
> >>          if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
> >>                  avc_log(SELINUX_ERROR,
> >> -                       "%s:  cache reset returned %d (errno %d)\n",
> >> +                       "%s:  op=cache_reset lsm=selinux_uavc rc=%d errno=%d res=0",
> >>                          avc_prefix, rc, errno);
> >
> > If we do this at all, I would think the op= would still be setenforce
> > and this would just be an error for it.
>
> At this point we already audited success for the setenforce operation.  Wouldn't
> it be confusing to have a op=setenforce res=1 and then immediately op=setenforce
> res=0?

Yes.  On second thought, I don't think any of the SELINUX_ERROR
messages are intended for audit and since that is already a different
type value, the callbacks can already redirect those to stderr or
syslog as appropriate instead of audit.

> > Looking at the kernel, we aren't even checking avc_ss_reset() for
> > failure and none of the kernel avc callbacks ever return an error.
>
> I'm not deeply familiar with the AVC intricacies.  If the cache fails to clear,
> then there could be wrong cache entries, no?  If so, I would argue that it's
> worthy of an audit.  If not, then I agree that it's not auditable.

The AVC reset itself can't fail, only the callbacks registered by the
application.  Original design/concept was e.g. if the object manager
could not flush all migrated permissions for some reason.  Don't think
there are any such callbacks that can fail today.
