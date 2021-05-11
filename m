Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E15C43460
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8966162C
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhEKBoN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 21:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhEKBoL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 21:44:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FB0C06175F
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:43:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s6so20903269edu.10
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEU2XINPvxpif27cloGyU3+maD+1yosQV8skN3ngj+c=;
        b=qebFkT5WoXwc0JDSy73J/CT/GiXF0CG4nWFbLQfsalTDTv1rnAW3qQ9TfEHxAxyLpp
         iRs9hHawnTzm0KY9y908SSWxYAMQoDpMi0sxUsrWcRdBWzv6JXLV5osZniXxGxi/L3Dq
         entDR12h5kB1EJdGVx6etkzL08KkdcHJhdXH7+nJ3XxhYGu0yahZkhmLOfgMbUo4Ace6
         tvNdxwIBuoAi3EPH6+0eFzwRIEgJgSSuuK2KgfeS44NQjkkzfvYB5vV5ZhlatxBT7OT1
         av9xkMrlj3WyDgThY+3LjLD0Qdoh1mROSz7/evYHa3XtxYX0UTQadY+83mNQPAj5KfJq
         BpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEU2XINPvxpif27cloGyU3+maD+1yosQV8skN3ngj+c=;
        b=LdG+txxkVkHx/0sEUHDuKap82YlOwLVIJ9XsFWHzoYh9BVjCNHISMgSStFjR7w3AsO
         +An4MsWjYrNdLFZI227Cg8pKwQ/OYLU66m1ONlAUK9sosGng+j6RC8fIIm4MhqvdllES
         xgJ/m6dXeg4KewpsKKG0NfBNOzum87urePxNeuNe+X2TpBd11FJODzW/CQQgaM+yStFT
         ZRyVbqXLngRvEKmpq0xTI2fji0hgl/UrZ5VL2DS/LvjAMfN7W3WK87puMh5tijscahDJ
         YoLxaUqdv9TlISGtFOfTDmZ6SyruYGFUPDlMWgg2v75LVxFEPH34bSkOFcnyqPLMkHn7
         10TA==
X-Gm-Message-State: AOAM530f/wxA2XAU4AHMDIatOdT7B0v6xC8yvXyzJti7CTJcKc8inQhX
        XPoagojUwJwE4b8PEpJyc+fQ6+ZCdwF12HTuRTgO
X-Google-Smtp-Source: ABdhPJzlZfrvrng9EKXKYI2ccD1ACNjUAx6WBrA4muVbPpFgoo+d7uP3vIzMNuW/aJocugCvTLH7zJH+jLeg1BmiR0M=
X-Received: by 2002:a05:6402:b2c:: with SMTP id bo12mr33179453edb.196.1620697383831;
 Mon, 10 May 2021 18:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <1619339737-4824-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1619339737-4824-1-git-send-email-jrdr.linux@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 21:42:53 -0400
Message-ID: <CAHC9VhRs8rtCfi6jZVPZTvu0uOG5BzBHCjoeg9AXRXkt_ume7A@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Corrected comment to match kernel-doc comment
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 25, 2021 at 4:35 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Minor documentation update.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
