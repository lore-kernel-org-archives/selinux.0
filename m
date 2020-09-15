Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF9C43461
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 21:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0886F20732
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 21:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwDW8Xxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgIOVCM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgIOUng (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 16:43:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB46C06174A
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 13:43:32 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a2so4540697otr.11
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09zM8662wjSUNTRWlK0e5zAtrkA1Hx9JzInAd2I3og8=;
        b=mwDW8XxlpNVORev0+ONhZn4i/BuoO4cTD7VgxkJnY0hnTTPRTLjPUQdu/NemXlxLDo
         4zS2WNcpjauXpZ0oCcvN7hv+6Nd8jqgcMh0F+wpfIK2A+TojkFiWFL18rpcUGCndTrh0
         E93PLse3JyOGWUCz7my5jKwIcBfsPgHOOMrJbkJ8iXltzEtJi4dcgDZmuW26RLEdO79Z
         bJDOU2Nzf+SO7cFQfXJUuF0YYPcjWRGDLrBwFHrW+DifsqULsFbogqMYO3I7wRSqHWlo
         X+sSXD9lyn6vk+o1cQ+pAFW2CX7DcnCqFgy5YazROAOWTuj3EvRwGdYD3nPD/oNxR+Cp
         VDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09zM8662wjSUNTRWlK0e5zAtrkA1Hx9JzInAd2I3og8=;
        b=tW+8ziXHsWzZVWBB/LHVEphLYkc58hOPKG+a77LYjVCRIfAFyxOqrSw6r5KnU3XgG4
         tgcYJRpT1C/yqAzcYbTZvl2ANxA6SP731UcsGy2Loca79JjrsgyzOSK7H8TiI29ffTWj
         WjDb5KsPk8Xejyj/g1zpaXoNQbduECh47zZPTzSbrcpePfTy40pEsacAamrTn0HECt/x
         TnQzeXthLPBMsCu4dmK2y+dqlh4WbhgJU7zeB09mMo0DqGfMOkHs1Rq/dKs1dPjiu51R
         Zu+izaE4joPbXjMB4YKhWz1eb9iElLfRz4SA6RikKLlawaERNNXdj8L1PG4Sa+SXpEkx
         c89w==
X-Gm-Message-State: AOAM530iKX5FlNhLW+LdUvqbSrRGV6uX/aXjPYlJmGBy5EnJu8LkjJ3J
        8igT+A5J/HTtzvtsqMmfU/TdUT7DzdKKg44IVdY=
X-Google-Smtp-Source: ABdhPJzWm8FOMKvflao7kny2wldhQWnx9bOT5wEA69vrjPEfSGMNlqzUKcVGnA0+dPsXhJZqmX2qKdW1yCC38Hb5wgw=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr13488745otn.89.1600202612199;
 Tue, 15 Sep 2020 13:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200915173332.574700-1-chpebeni@linux.microsoft.com> <20200915173332.574700-2-chpebeni@linux.microsoft.com>
In-Reply-To: <20200915173332.574700-2-chpebeni@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 15 Sep 2020 16:43:21 -0400
Message-ID: <CAEjxPJ6Nobke7D+9p5vTg+t0BzW8eUXMxqLNDcS-zzSCAXCkcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: Change userspace AVC setenforce and
 policy load messages to audit format.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 15, 2020 at 1:37 PM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
