Return-Path: <SRS0=6AtE=B3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9C8C433DF
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 18:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0C42067C
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 18:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lftQKSW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391144AbgHQSgL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730965AbgHQP7W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 11:59:22 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1901C061389
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 08:59:21 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id q9so13793278oth.5
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=s4SOTiGmPld/0bznnXfMj+56YnruPMgGnPOy/L3P+c0=;
        b=lftQKSW5Na/xwa9M5XWmHHRObFMy7/JTXNBRUNDZIqGGjqb+matdsl/KBHNrzZ46nk
         fyl9QU/cI2ACpR3+iLE71VrdPQHrjB8JhlnnHw5HLdyEUKs+CkRr/7eEK0hFZ2N/2xp8
         JhIHh4ZJzX4bRA0hK43bLsYvqUaxW3PGG1hLqYmFhY/JmQbYg9T7/NLkPdWNbO4eix18
         3LetKY+gjU8FGBDBEWYKssojbLujzj13EAjey8Bh52DaizSoL6ew2NQNYVtwALpPSyal
         qjmsgCIJsYw34Y30nXPhkJsarXg9j9RwoDdGWA60Pd+SJQDhhjhFkwPe7wAutvOSumZu
         +Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=s4SOTiGmPld/0bznnXfMj+56YnruPMgGnPOy/L3P+c0=;
        b=Or6baUaWUhArLSEFJEZXEc89A4eKsQDMeDuUt0sMImVsUuy4h5SAjJHIh09+1cH1vH
         l0rf6tTXAiF8grKXXY/Kh9Q4ridak+/FrZw+miyeTUijhSf+2lraSjwzGw7r+2B6AFI/
         dWhNzvHi5toSVstsf//2FyeP6PxkkBuvJbuPEL4HRoM2s5QyN4y9rS1GOvBlgcDc8RYO
         D0N7gUPyuhciWP/apmhSCJMmh5TsSuigQRlbBGj5sGqbODoxS8IvK+GLuTgttl8texZi
         ar4wVN6n0YKH4n4l6gXCwN9+DGukRGH/qDX904HQaJmQfd0SFLoCAjP/RN7dHW5g+cSN
         t87g==
X-Gm-Message-State: AOAM533Ggf+p5HX6K02X+Xc0VpdRANKPkM9Xd9KV8IbGfI+9GsdrjWLs
        TZX130MDsfJqZ9VSZANbmAA1Bm6VWrN5JLCvO3VxhN/AiNo=
X-Google-Smtp-Source: ABdhPJy2JWCFO1al+5XtlrqhF3uIjU4o6vhzsvGC3IXDIpR9SNwzinXwp/SNpi7IYrs7PrpVIcqgfEUgkzKD+LDE23k=
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr12036978otq.135.1597679961110;
 Mon, 17 Aug 2020 08:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200806144946.42125-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200806144946.42125-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 17 Aug 2020 11:59:10 -0400
Message-ID: <CAEjxPJ6DcC8_3XqrpFZ9XRii7eMFFj=o-j2fJM4CRCoUF5CDiA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix build order
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 6, 2020 at 10:50 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> We need to install the include files before we try to build the source.
> Otherwise, make DESTDIR=~/obj install can fail if there are older
> headers under /usr/include.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
