Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5792BC433E4
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A81B20791
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 20:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sJJ4ao6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHUUg2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHUUg1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 16:36:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51833C061575
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 13:36:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id g19so3901349ejc.9
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebU6ZOPrEiT4sJ2Qift4Kje6ztl3WCJTClKg9hrAqUQ=;
        b=sJJ4ao6DisZKUH3MXLhKbGf3f83SemnBmSnc0GZe4BQVf99IvFWHXrBHpqkrQwShn7
         +bYszE3x5i2zzGpUWigeoglsgJZG38A2PkRWE45g+t0D2eLzT/AOq0gLKENYlXi4TshE
         J56DB12WAL2lMl49Fw1xhilezBWV73I457CHMUBCyFBlbtrk+98CEw+fB1Rp7QYyD8vG
         yOX6mVOCzDAznOB6DirK1zDl6I8Tk7+maUeZ5Z/mqvAaHmFfXZneBwgJ7NectQn6ZqK7
         naKp7Iiq5p8U7rxj3O4iUNiNR+/bbMYJ195On09y8rSChp9UtBOWc+GnEVFvXPMaDE1w
         8aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebU6ZOPrEiT4sJ2Qift4Kje6ztl3WCJTClKg9hrAqUQ=;
        b=dj5r3lYvwq0A2f01CTgN8HGcf+MZZVdHdAj46sBFlM5kYEz67sm+6ONuGYTGsSRZ1K
         3ovvB8xZ20NMb4ALH4gBTnGdDAoEUrJBZMoqkJbazVvxSexvObyO3IUkyJKfOrNIxx8G
         2m0iIpfWjb00NzKzpeiFlKtuFv2ciQL9vaGlbe2CiVO0cxYJ3Z5VYum7xuque8kFwfWM
         AHOOW9P8FRqkvob6x7CBaFO8RFIXPvQ5RDjF+WLCemwQ/ofFqLOQD8eE5ZSh56hl8nUH
         YPBv0o5MXpzy2Aoo+sfp7CCdZrIQBRJ0AgPWfigkAdlbbRnDmKUqyx+Ni/59zBwZrp5s
         jw8g==
X-Gm-Message-State: AOAM53299NPXxpq/OmJblzRemMBdS/IVqAO6o9hEDYYRakgBdJM8obU4
        8IhVY6JMmnJZguQ5xVo+WE2xOOA5Iz67GGwyp3R5
X-Google-Smtp-Source: ABdhPJxDQil/PQ8kmBmFKvgLTSoD067CTWtz7P7sgZlRoEMyzAplC2icCm4EXb7/gBGF6eTw85Zm4lqErAh/T2no1x0=
X-Received: by 2002:a17:906:3390:: with SMTP id v16mr4569483eja.106.1598042184879;
 Fri, 21 Aug 2020 13:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <159797437409.20181.15427109610194880479.stgit@sifl> <20200821.113844.1413413632075759126.davem@davemloft.net>
In-Reply-To: <20200821.113844.1413413632075759126.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 16:36:13 -0400
Message-ID: <CAHC9VhQKRozweij6PndZbffq5uaVqkv-xnfhhNNqgLuQ6BDWeQ@mail.gmail.com>
Subject: Re: [net-next PATCH] netlabel: fix problems with mapping removal
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 21, 2020 at 2:38 PM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Thu, 20 Aug 2020 21:46:14 -0400
>
> > This patch fixes two main problems seen when removing NetLabel
> > mappings: memory leaks and potentially extra audit noise.
>
> These are bug fixes therefore this needs to target the 'net' tree
> and you must also provide appropriate "Fixes:" tags.
>
> Thank you.

Reposted as requested:

https://lore.kernel.org/selinux/159804209207.16190.14955035148979265114.stgit@sifl

-- 
paul moore
www.paul-moore.com
