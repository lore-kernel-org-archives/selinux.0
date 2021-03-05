Return-Path: <SRS0=hgLN=ID=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8FEC433E0
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 17:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC1B650AC
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 17:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhCER44 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCER4f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Mar 2021 12:56:35 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E97C061574
        for <selinux@vger.kernel.org>; Fri,  5 Mar 2021 09:56:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id r17so5090827ejy.13
        for <selinux@vger.kernel.org>; Fri, 05 Mar 2021 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5E6bZ6ysErUKSq3TWCTQGtLovHN6ICf2Z6DeoXuTO+I=;
        b=jpb8x+g971hT+kM4NGsQO8y1wnGbqFlY8eTWtoCMU5KOVUZciLU8kqv5G+fjtAfgx4
         L3+bjACKX59tbBTZ6OlmPFJpXeOf+zkZVYTohXIH06urTKPFDUN+EkEyrL5Utw/NdnJg
         Owv3v+FhJBKl8OdqKjhM1hdOJWV0ApuEhkFi9o5kSaT8fwsSsaXpRPl7deH3WUi9qaLa
         y1vdEM2Xy4ZzO+M/CKo7OoD2+kIntvQjtXBi1XVRNmBfo0vCXVfPCrSG9bYg1h/3K9Al
         90afP0q10nFYWXP8j/pK7RNFWAKHLX+DLB//mUP6q6EUeb6FtmInwZnAAay4TQNBeub0
         P3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5E6bZ6ysErUKSq3TWCTQGtLovHN6ICf2Z6DeoXuTO+I=;
        b=DYKYuHyXx/BF6UEWzDTc/dUERoBM8LlvpiswQeqXxdblS8z1MGzzwpPL5hpqDRaTzM
         3q4gesMv/GhS5y5qf3s3rJPuCKrnjO23QN4MkRpSmRF4I85e/PL1qdd3LJ4eqgUcJez7
         WzcF7fZds8aX5KkL6J99khvbMd6uzNe5PlbpeL3LuAK9ahddLTjtzT2B7zs1rr+OMR2c
         JqdPJHBBfVZS9H6AVhOM4mOxfJ/XGl+PHWotDK+1RdidbSJfXNMf3c6myMTGOQoJPxku
         h83oUFL2/iEx4qFkBXHqUaMxJaiWokqTWdA4ItjvFvCDfm59I2gKnqLm+5jWWmv1EWyg
         pjAg==
X-Gm-Message-State: AOAM533UkkGOB3sEIah/YpQQDh9psi5fcaVm7qT9m3wItenxskadhl/z
        maJoe2kE9LRGt1WqteXQaQCf8YDvq5yzZDVEBqV9me1/VswibIg=
X-Google-Smtp-Source: ABdhPJyE/Kpf6oM/bSVK4LDrL3A2hrFAQOEwMaO6YlkD2HFsqYJU4h1TaWbElJWif/5Xd0F9XtBUeIWmqeeNmBEunp0=
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr3451646ejd.106.1614966993911;
 Fri, 05 Mar 2021 09:56:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhTUJAD9KQyb0ibFtCZx1nRRLLRuepbMP_CS3Ni+EQMa0Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTUJAD9KQyb0ibFtCZx1nRRLLRuepbMP_CS3Ni+EQMa0Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 5 Mar 2021 12:56:22 -0500
Message-ID: <CAHC9VhQOzw2aV+kT+b_cdmnAJk21MDP7jhoVy3Y-YVrCbqxBJA@mail.gmail.com>
Subject: Re: Quick announcement on the selinux/next and audit/next branches
To:     selinux@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 4, 2021 at 9:03 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Hello all,
>
> As many of you are aware, normally with the close of the merge window
> and the release of -rc1 I typically reset the selinux/next and
> audit/next branches to Linus' -rc1 tag.  However, as you may have
> heard already, there is a nasty problem with the early v5.12 kernels,
> including -rc1, which could result in some fairly serious fs
> corruption (see the LWN article below).  With that in mind, I'm not
> going to reset the selinux/next and audit/next branches for this
> development cycle ...

That idea was spectacularly short lived :/  Assuming -rc2 fixes the
swapfile bug, I'll plan on rebasing both -next branches to -rc2 early
next week.  This should have zero impact on the audit tree (audit/next
is current empty), and a minimal impact on the selinux/next branch as
we only have one small patch in there at the moment.

If for some reason this causes anyone a problem due to merge
conflicts, you can still submit your patches (assuming they apply
cleanly to the stable-5.12 branch) and I'll take care of the conflict.

Thanks for your understanding.

-- 
paul moore
www.paul-moore.com
