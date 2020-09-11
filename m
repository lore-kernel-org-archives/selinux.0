Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CF1C43461
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 16:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F2A221ED
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 16:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1s7mwc3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgIKQxv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgIKPGN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 11:06:13 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFB7C06137A
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:42:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a12so10175318eds.13
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKPbI8VwqKlAE8s9yoM38wp+0CzJgjXbMuwWzyxPOcY=;
        b=1s7mwc3WdQoHFAPpzSK7V4HKrkdvt/95aN4QFkMu4SJxrDZhMSoZKLcJKfa8qtfGib
         T080djyOKpG50r60c9GWqSmi2lZseRzVL0QIuCln4jx1t8sT77Hb86qVW/AosKrvmKNI
         jSBhOeQ0WkjXCksI6uWf1IV/1ZDJ0hMg9nHs8xp7P6zeRDP5uGMwjXch6v/OnkHlhZHA
         KUeguEfuS4cxA4DoZgzGbm//lK0v3u8IlkrAukJVSa31f/sSeK2X5LoR9ALLbJIpgrzC
         xfJwwuctE2Kp85yWJis0vd/2lnDM9e/SX/zzX4MEVQSExdWbfw7/27TuFF4KblA2mj6g
         MNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKPbI8VwqKlAE8s9yoM38wp+0CzJgjXbMuwWzyxPOcY=;
        b=hwy1wjY0rgjhUxF9/d2pGkoc3HYdSxEdtXYOsvrvtSqs2sJv1H4tYkkTvL5hW/wsGX
         9gt0pMajQCXPYj340/MDexRsNtvKXaEV1ifoRaYuCabqMoTOi+vgMjOWNltRCTt2IqM4
         q9C0bKTK9RKjofdt8oKO74e28JNoZLbybYnCeIZTDQWr0+CKuUibAU1S+ggZF3jlL03t
         vTcutPycN4jjYXa5O01UuByZUGdSg9+XIHn3j3bnzzrESXCQSz/OfgSxgSjzaXPmkqfk
         zweyLebc7Qxd8mw7waTX7gKrslWmlbi5WrxS+pUSxtgvd4V7IlApvl94MvPBBJ1gOH6C
         HUXg==
X-Gm-Message-State: AOAM5335/D/p5zJfuE6ORPwEno4JSby6Cz0t9/zuSHwkyrOwmX4oaeo+
        I4CF9J8ZGQJpjKJZAzVAnjazBRMix+hYfUKH4K1vztPSQixq
X-Google-Smtp-Source: ABdhPJwwYHRTimFdxxuRNqJEUj62JzI/w0enZ9ZNkroIZMN/7hXwe/u2mwEslxdGxjZE/k4T/Bghatph2pX6EWl5bvA=
X-Received: by 2002:aa7:cd06:: with SMTP id b6mr2273734edw.196.1599835352709;
 Fri, 11 Sep 2020 07:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200909222822.23198-1-nramas@linux.microsoft.com>
 <CAHC9VhSZiuHHg+oJPcaRLoZaDhARgiJ2PN5LiMHcVk1yB0a+ng@mail.gmail.com> <a09f9a78-a8ee-5b13-c4d9-e939a4edeb5c@linux.microsoft.com>
In-Reply-To: <a09f9a78-a8ee-5b13-c4d9-e939a4edeb5c@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Sep 2020 10:42:20 -0400
Message-ID: <CAHC9VhQadF08JF5BuwbGt0r_2DKidLeb7U=sp4uj7YP+4hRE5Q@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Add helper functions to get and set checkreqprot
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 11, 2020 at 10:20 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 9/11/20 7:07 AM, Paul Moore wrote:
> >>
> >> +static inline bool checkreqprot_enabled(const struct selinux_state *state)
> >> +{
> >> +       return READ_ONCE(state->checkreqprot);
> >> +}
> >> +
> >> +static inline void checkreqprot_set(struct selinux_state *state, bool value)
> >> +{
> >> +       WRITE_ONCE(state->checkreqprot, value);
> >> +}
> >
> > This is a nitpick, and I recognize that Stephen already suggested the
> > use of "*_set()" and "*_enabled()" for names, but if we are going to
> > name the setter "*_set()" let's also name the getter "*_get()".
> >
> > Other than that, it looks fine to me.
> >
>
> Sure - I can do that.
>
> Are you expecting something like below (for checkreqprot and enforcing)?
>
> s/checkreqprot_enabled/checkreqprot_get/
>
> s/enforcing_enabled/enforcing_get/

Sorry for the confusion, I should have been more clear.  I was
thinking that the names "checkreqprot_set()" and "checkreqprot_get()"
would be nice.

-- 
paul moore
www.paul-moore.com
