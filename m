Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E59FC433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 01:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDEE20738
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 01:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Hy3OsB9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHUBRK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgHUBRJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 21:17:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A647AC061385
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 18:17:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ba10so151433edb.3
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/06ynpDFd53F+NAHE9QxHy+bt24uVI5H5sHT11qi2I=;
        b=Hy3OsB9UZgN6SqDiBi1brmQLaWDSxugk0gDQYqndYIioPuAY432r5IdooJHRM8cVXD
         BiZvIVR7fcYD7Fr3F4Y9z2bf4msYJHLLIWtkK5RFxEEsxK4v4Uo984mwnxZOjT4In0gl
         aqQxaptbh7z0rgjCfCn2Lt+0CTmsee7PXjnYgBI24JHoJPSRZkH4csrM+hNvr8BOyRt3
         oTSDcW/7LwzGA6rnl0H1XjdVXHRkollczSnWZHJCSmTsVq7RztQxRtMF8eWi90lV/zeT
         8lzoRCaj/hSPReo1Dzdjy71+ac4zPdp5rQeusLshDjavrShf3OiZGUnrKBRewS8UA3cU
         lahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/06ynpDFd53F+NAHE9QxHy+bt24uVI5H5sHT11qi2I=;
        b=oZQiPsqURL01J+RbeVH8cS/LVWNhWrg8xowydDM2wjGo/yKFchR36BVAdxJFXwYdP3
         vqboIq6BNVvGZ5BDrKmzTqUFbFhR1ej+HKCXqyVpPyOM5+Tj/FyR3DmntYrx6IgC+cA8
         oHyZecMo8Gq0SfpYUrdqwwF959jHSEL0U21hZBHPfErw0JejH2xEO5D7p1UzlxX3lrx6
         7ZO/op20c1LRwusAA/DY7WlxVmvr4swJlx3vXSNIvCpuzqLADnbMMQeheVl605F62O3/
         0pbe1rmvAixyEkCjoGL/4tWDLaRiXemcbAg3yedb+Y38dDkfww5np4FovgWFUfR9rRKY
         yUTw==
X-Gm-Message-State: AOAM5314+Tvw2paWcqPfdePDxpvbQJZOxeYolJPuxnvY/YehuAawhklt
        KHcQHo6ItWnSQkqF6gBCP8pPq4YslLWXqvMv0cjh
X-Google-Smtp-Source: ABdhPJzoRS/6UJiT2RFcu82snuRhWUle4ukoyvnTmj9DrlDx19Zw6oHCEcII7UihdO7y253VY8zLUKnq+FBgwKUrCHA=
X-Received: by 2002:a05:6402:3070:: with SMTP id bs16mr452804edb.269.1597972627047;
 Thu, 20 Aug 2020 18:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6s0AgwoMqP=YCweRGpkC5wsvtusmNO235_S=97NmvSeA@mail.gmail.com>
 <CAHC9VhTbOfFxtjWYytX4qC9hqeNuUV5dnfcES2qUtYzpuUnBuA@mail.gmail.com> <CAEjxPJ5cRbCogQ17aakpnMp_0nwDHbMQTqC69SXBA3JcmP1nuQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5cRbCogQ17aakpnMp_0nwDHbMQTqC69SXBA3JcmP1nuQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Aug 2020 21:16:55 -0400
Message-ID: <CAHC9VhSm2qKkhUK7dnn6_aPPY4LsVqeQwD2Xf6k7EvV9xJg_sQ@mail.gmail.com>
Subject: Re: working-selinuxns rebase
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 8:10 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Unfortunately I need to re-base it again and manually fix conflicts
> with my patch to avoid deferencing the policy prior to initialization.
> And I'll need to do it again when/if the patch to convert the policy
> rwlock to rcu lands.  So you might want to wait. I'm starting to
> wonder if the first patch in the series to rename selinux_state/state
> to selinux_ns/ns throughout is a mistake because it produces a lot of
> unnecessary conflicts.  Originally I did it because that was the
> original naming since the encapsulation started to support namespacing
> and then I did a mass rename to selinux_state/state for upstreaming
> since I wasn't yet upstreaming the actual namespace support. Renaming
> it back again reduces conflicts in the later patches but makes the
> first one a pain.  But if I just do a mass rename on all the later
> patches then I can drop the first one and avoid these unnecessary
> conflicts.  Thoughts?

I agree, the first patch is the one that always causes me the most
pain; considering the work-in-progress state of the patches I think it
would make the most sense to drop that initial cosmetic patch for now
and we can always reinstate it at the end when this work finally
lands.

-- 
paul moore
www.paul-moore.com
