Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589F2C35242
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6F520842
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SudTTLD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBLC3k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:29:40 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41207 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgBLC3k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 21:29:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so572617eds.8
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 18:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ck8p4d1qEnONZx3gKmLAZx2oNhBl/B1eBGPErfea504=;
        b=SudTTLD2cPvfRRLoYh0eCzIOdfBGqbIrtnzIWL3gnEmzWlQUEshx1gsWZjLDcM8bjI
         4rmQnp98joSw0nQ97RHX5Wt0tXQys/auY9de49Xg65lybsEIhupMbBtNXAslClxkAHmh
         5JUMG61OQzmsBXwXs6nsnp0mndjBEy/1hau7P22tajfWwn+6aL3LKhiCNZGnrV/6YimU
         nHN9wvU/+3t+XeKlQHZwam/TAh2kw6jyCyxZDnWy4IyBRzVajlt+3DxD2MeKovTyHiVe
         vatY4U97Lc+4IBa+ks8ha9a7xKjfiMiOWsBm22v6kV8oUfO6rB4NNSM8Kdt68ab2GcEa
         D88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ck8p4d1qEnONZx3gKmLAZx2oNhBl/B1eBGPErfea504=;
        b=SeyR8Xuuee4m/dnTnQThihkhc5OSoQ+PeaVk5tnaBf69nuXOh2raCS7YHfsaGIADbp
         QM2IXZjeBhFO3g+d0WIEemm40jad+rvYJUzucl2dccDYCvHDLYYX5YcSQfGEW7yrZnwb
         7XeX0bxmafwR3ntyM+458n6Y2TM/Ap8u+FuZuHMT2X2yUp47eBeorOFwVhz3V8SDG84Q
         n6d3or1+s5hztBs5ncfMGaR9jY1m3HQ5MfcquYyHHFOoKT8cC4unJZamQYEnLsHuDo5v
         ZeWeHaFnwz9z0W2X2KUAMD5lOgqZAYIGmYhQBSx6EggHhN3E7BLBSvd36/GzEk8EBQAi
         /ohw==
X-Gm-Message-State: APjAAAVGtlatueGV/q0f28bcmsbySIZATTghCXSA6me7wvBmwwecf1GR
        al2RWIpq0KC6C3zNZ3/czWfkQ2jIXcAX+qg51DBY
X-Google-Smtp-Source: APXvYqyxe3VmSQs37nqbFNHbkcXUny+KWvTITUCrTJ+BmzPRFx1fBUj/E6z7CB1LYmzTcrDLd2Re4a+tW7N7DRpOVn0=
X-Received: by 2002:a50:fd15:: with SMTP id i21mr8715057eds.12.1581474577414;
 Tue, 11 Feb 2020 18:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20200203112723.405341-1-omosnace@redhat.com> <20200203112723.405341-2-omosnace@redhat.com>
In-Reply-To: <20200203112723.405341-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 21:29:26 -0500
Message-ID: <CAHC9VhQ2SJvgf9ksXpBdSi-P-yLvfFmoeDL_4SqMJttNUJCjtg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] selinux: simplify evaluate_cond_node()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 3, 2020 at 6:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> It never fails, so it can just return void.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/conditional.c |  3 +--
>  security/selinux/ss/conditional.h |  2 +-
>  security/selinux/ss/services.c    | 14 ++++----------
>  3 files changed, 6 insertions(+), 13 deletions(-)

This patch was merged from the v2 patchset and is currently in selinux/next.

--
paul moore
www.paul-moore.com
