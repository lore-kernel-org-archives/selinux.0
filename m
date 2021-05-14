Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056EAC433B4
	for <selinux@archiver.kernel.org>; Fri, 14 May 2021 20:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D784B61444
	for <selinux@archiver.kernel.org>; Fri, 14 May 2021 20:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhENUln (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 May 2021 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhENUll (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 May 2021 16:41:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D096EC061574
        for <selinux@vger.kernel.org>; Fri, 14 May 2021 13:40:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so12017580edt.13
        for <selinux@vger.kernel.org>; Fri, 14 May 2021 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UH94CMUexxxb2GnhV2IcDNbl5yCAFHIeVj33yfzsRtk=;
        b=x0CydHS+lmwvtnJRy9oz7hwByZze+1SYw9riBU5XPNhs/AlJBPJWo0VdXDdC+VFZeE
         Vke/jG7L/+sipRRwyq1mBAMIu3dHw7W/Ev5S+GPlCVBGQmQCxFzNCyBdUzJfmWSBqPn9
         PEnjNjDjalozmmh8q2FYCwl4P59Gxl6Nc21YWegYTpCt7p0N1pn/jRoh+r+Llz7B5BmI
         CG8FY+ij28q0HOFBRXLFrMU8dX/0u4iur+AxJS1hRLRu1ObHJ2UKxHi/ovRA5o9Nama9
         k937bjzln5lju37WhtpTHd9V2UfS6I8cyin5zH0OtV3K9sJC1C4SwMYRY3WQ3CNO4zkr
         yc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UH94CMUexxxb2GnhV2IcDNbl5yCAFHIeVj33yfzsRtk=;
        b=BrPSKg4se/V5zbIAZz7o6BmGQu78G+FxuWupc675eQma47oUuXOmnMR1rhWjQFE45s
         fPXK10GckWP1aKxQuNjaUrrOqh7HdQ4mSDwfJAOrUoDiTdqVofQ0XYFTAAQ4h3F7xT+/
         EbT7oliZ/wOTudc1u3zUf+lZklM15vGbxLoCl1WftnJSBxDxjCTiWNQQCVIEtmJXB3f7
         HJ2iUNT9jfWjntrafnmHdgdp7Jt/yDiDWcwlmSkzNrBvC0KDm3G+9bHE8oFVUvSsBv6n
         cD1liCxY9AonCKW/gtggp/3AbrYiAqXisIYlbX8+mI+f2mjNbIbjM+zUlNpyi6y27/FM
         hMKQ==
X-Gm-Message-State: AOAM532l5sEtVT7KYprOZbPe3mfJzCvzf8kWnTHduzjJeDeNIMwHCV98
        aAM/5jveJ6fAmSyXQh2a4QlrrqTauQU1Dz6JScP6
X-Google-Smtp-Source: ABdhPJytalFwYiWmmZwVSLBpgN7SBgChL5XpW0pw0AtR1YrusUFm6Lrs1dr/qX2IqPILZklt2M1XpVHjjiM0waD5bhc=
X-Received: by 2002:a05:6402:378:: with SMTP id s24mr23390377edw.164.1621024828420;
 Fri, 14 May 2021 13:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210512143210.248684-1-omosnace@redhat.com>
In-Reply-To: <20210512143210.248684-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 14 May 2021 16:40:17 -0400
Message-ID: <CAHC9VhQNg=Cf1-+mD41dnR4O3Wi-9D1NO2Vq=56XZv37Qx_How@mail.gmail.com>
Subject: Re: [PATCH v2] lsm_audit,selinux: pass IB device name by reference
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 12, 2021 at 10:32 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> While trying to address a Coverity warning that the dev_name string
> might end up unterminated when strcpy'ing it in
> selinux_ib_endport_manage_subnet(), I realized that it is possible (and
> simpler) to just pass the dev_name pointer directly, rather than copying
> the string to a buffer.
>
> The ibendport variable goes out of scope at the end of the function
> anyway, so the lifetime of the dev_name pointer will never be shorter
> than that of ibendport, thus we can safely just pass the dev_name
> pointer and be done with it.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_audit.h | 8 ++++----
>  security/selinux/hooks.c  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

Much better, merged into selinux/next.  Thanks.

-- 
paul moore
www.paul-moore.com
