Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D100C433ED
	for <selinux@archiver.kernel.org>; Tue, 27 Apr 2021 20:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF63613ED
	for <selinux@archiver.kernel.org>; Tue, 27 Apr 2021 20:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhD0UHq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Apr 2021 16:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbhD0UHp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Apr 2021 16:07:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0676C061574
        for <selinux@vger.kernel.org>; Tue, 27 Apr 2021 13:07:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h10so71434267edt.13
        for <selinux@vger.kernel.org>; Tue, 27 Apr 2021 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4zI6LsRpIA3ArtBX8ALU0STp81kxL89GVnW2vZhefU=;
        b=v+mxNSyeOWGx118MXJSSxAxT4BdnRFLkDY2UNYSPuUOw5VVvO6skPiZ4Hkh81aD3eN
         HIVgsJ1XUvaOumXO97eIUiPef9+8sz8HoKThpxa3GFBqU7EYrsZqWHzczU92b3hytOBY
         MOOamiia1YInVSlE4bC1tGP1pa8RdrVLxLStHHSovlpaGNovS0/hkLJ/dbxY2hYfa5PS
         UEvJIjAnl2rU/db+2Rltw0WYqbbeAUTbN2O/F0XkXa1eO3+LtJ6NBzJ7gApttSYoBQc6
         FXo7z4kJZ8Cd7wloLAXiPMSGgWlYcMCf25+AiRj02fhOZuAo0ILUAevz88tgjeXRf0l6
         accQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4zI6LsRpIA3ArtBX8ALU0STp81kxL89GVnW2vZhefU=;
        b=JrcA3W4Az5sQscO7z82DaehysocZhMY/3zKJr7F6NKbl0SBjdFTpmI3Q+IOgtdL1xR
         JxrbzL9wk+v0eTblJG9eZkkHErsfxJTWIf6GcxiVAcxQ67/MT2i7aefRBnG4jW7MIuR2
         E6QwaYcdzT/epQdMp56eaTlzP0WMOgzW2X1mSGCNRzTwenmcB8Fn5+BT0+6PMcsFw5Ga
         Sv5gCGiSAkeb3OaEw+oIpKgclos+16Ff7AE1ooEYP7oQEIk2USYiE43jZkuAiR2Fy30g
         hgU1LpuD6LhWlS9hSlYqjFI09fQJBZfHXM0V3IAoQsTIsXPHK0DiLFXxg6bHVB0WLSSZ
         L3bw==
X-Gm-Message-State: AOAM5338ZUvr4BjnGMM+mTnzktme8xeM+dv2bsbKfnJmncfzUVfYP8wv
        RxCvTT6oCAgqoWhrNfOJtnK2x7VJqDjeq4NFx4n2xOcBZw==
X-Google-Smtp-Source: ABdhPJyM7GKmA4a0erk/M1O0+veXn39oT7K2m3hVriPrHF9ycRMFzgQPACjm0i6lE/jsQwS8A1GZi7dPdB0HYYW48KU=
X-Received: by 2002:aa7:d30b:: with SMTP id p11mr6418798edq.325.1619554020434;
 Tue, 27 Apr 2021 13:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <161947648054.55076.7300753011213416749.stgit@olly> <CAFqZXNvHe094zpnfM0eBA8Y=HjwgzVpCkuA9SNfLPdJ4Th-LTQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvHe094zpnfM0eBA8Y=HjwgzVpCkuA9SNfLPdJ4Th-LTQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Apr 2021 16:06:49 -0400
Message-ID: <CAHC9VhST6bJ=9=6-EUj4=zv-G0py-GX+gG99Fr==nku6_xCrkg@mail.gmail.com>
Subject: Re: [PATCH] testsuite: fix cap_userns for kernels >= v5.12
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 27, 2021 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Apr 27, 2021 at 12:34 AM Paul Moore <paul@paul-moore.com> wrote:
> > diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
> > index ab74325..052afea 100644
> > --- a/policy/test_cap_userns.te
> > +++ b/policy/test_cap_userns.te
> > @@ -14,6 +14,7 @@ typeattribute test_cap_userns_t capusernsdomain;
> >
> >  # This domain is allowed sys_admin on non-init userns for mount.
> >  allow test_cap_userns_t self:cap_userns sys_admin;
> > +allow test_cap_userns_t self:capability setfcap;
>
> I think we should allow the capability to both domains (i.e. to
> capusernsdomain). We are testing cap_userns::sys_admin here and if the
> tested operation is not denied for a domain that has only
> capability::setfcap, we want the test to fail.
>
> Also, a comment with a sentence explaining why CAP_SETFCAP is needed
> would be nice :)

Fair enough, v2 will be out shortly.

-- 
paul moore
www.paul-moore.com
