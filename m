Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB55C433DF
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 19:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494CF2076B
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 19:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7Tnj3V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgHKTQO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTQN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 15:16:13 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2BC06174A
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 12:16:13 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c4so10984970otf.12
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbIw98MudyG9+GMFBBw5zhC5u/A4RSA0VHj0o7CKIRE=;
        b=Y7Tnj3V4ip4HmqsWSTi0pPKp+wWsNvpCRlxh5/WaX+7hS/w++R9Yn+bpl8nnossXvm
         7xtA3cLQfNZpzk6g2XzFU/pZi0sLG/xIk6uLIaAmwZrGPZLWNd8Wot1ON/gIUqaIOKu9
         /TbMmsCUVLNIJqV2KmK8jkNSWp96uw5iU6tcKOgDnTscdRNhzJkR/GBwzrKSTYaWtzdp
         kOwPDWyeKfzNOlZpVcnRl+lkIlMeO4CfRucT7aGEdh8y5kxkYuGaRrFeelx0g3L3tu1O
         bPqw4TQltdftTVbuTTwSQL2fTQpJ5nWvlO35dDhJWDedCNcU1hT0P2hS9wqis+5bMl2k
         /CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbIw98MudyG9+GMFBBw5zhC5u/A4RSA0VHj0o7CKIRE=;
        b=EUooESvU3PvgYaFyMkz1xtdK+16L7xpJiY7IOvgif3UxEYyXTWs1LaXHqHOg+czDGR
         sT/M2WZpKLdlrfEZeBwyRSYiOZIIUYO+NKgjxqDwpdWxrBcvqFVPttrubMonBgkpKGwF
         vyhP7/R0DuBp4tur/oO4zGT9hG2Ro35HiRnpGPnnWDrrWYKqlhJtC4uIe5Yj87vKHGmA
         nXyXSHe8taw4jXrjEymb0VWsptZHQMzFiqnCr1GCTk2ltLjVRrtTQCfflCA6YUXr2GqD
         XESgOWU99xOYKnw4OAo67HPmJXjusjt4dQXPyjz0jAgWFqkhx9naXN2m0tOrsquh1AtR
         YMdw==
X-Gm-Message-State: AOAM530Jvj88AENGF0S+5gNJi+IPWKMlbN0+X6655liAHB5A14AFTsoB
        fkBqFk3OOWe2dm4gufJNfRmeIWJMdf5FUBAWpiXkw70N
X-Google-Smtp-Source: ABdhPJwsYNIdWV2BVhjOHlDlp1tOHDppR7Hr4SMM/WfeGn1n3vjYWXq5sCi1FNGx0PSM/4w0/1FL1JN4SpPCgGWOKnE=
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr6529719otq.135.1597173372695;
 Tue, 11 Aug 2020 12:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200811191035.13948-1-william.c.roberts@intel.com>
In-Reply-To: <20200811191035.13948-1-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 11 Aug 2020 15:16:01 -0400
Message-ID: <CAEjxPJ6sLaiVrh59AYonbDNi2jsY6YTGd5ygYx=QBGaTC7rdSg@mail.gmail.com>
Subject: Re: [PATCH] ci: fix stall on git log -1
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 11, 2020 at 3:11 PM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> git log -1 may use a pager to output long messages, and when the pager
> is invoked, leads to stalls on the ci system waiting for user input.
> Use --oneline to print the short part of the commit message and
> the digest. This information is for debug/informational purposes only,
> so truncating the output is sufficient.
>
> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
