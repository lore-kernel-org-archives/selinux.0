Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A79BC38A2D
	for <selinux@archiver.kernel.org>; Mon, 24 Oct 2022 09:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJXJSk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Oct 2022 05:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiJXJSH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Oct 2022 05:18:07 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DE5E665
        for <selinux@vger.kernel.org>; Mon, 24 Oct 2022 02:17:32 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s9so916095ilu.1
        for <selinux@vger.kernel.org>; Mon, 24 Oct 2022 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t68NQ+3hHAUlwTa6RIPlbYc/x4lJOcqa8kQt3qKhwQw=;
        b=Aib2y7QXTzVV281FblLHg+ARcwFyAbNraAiytxMTraRRWJ5RRh3kAfTtx6ytGxi1BW
         NZCrT11J6s9vxhU9L3GdfAflCpdsDu/sx7RF/9UMXnSQabQY+ddx8wbgERTakvhEUgg+
         PVfTrXzFKURzs7Q3sKZpUIOT/UhpOOQy7W74dAnGILiS+d7e+4FuTL1qZvqi1ltokwB1
         gRUYjoJGK5dFzDWVH8tXPNjk10+RcTOvE7WNUXX9OnbXSuoTvKU1b1REUb3wL+bKVOtu
         NQAJPAuGvO+6UzcE+wGkN2GLpGtQH4gMa0CbwWq0wXbG4jc5PxsRsEn5fRdVqkQ7kS7H
         uJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t68NQ+3hHAUlwTa6RIPlbYc/x4lJOcqa8kQt3qKhwQw=;
        b=0rDpphm5KxIY/SMspORyZqHkHi0QP91z24HEmcjNWtMx96YnOIhDe9Z2bzvusF3W/D
         kV6AYiIZdM/q26wCTEenbfiBOWBlSljzf4z06NxBfMz8XjZdsLGDncTanBPkrmtBWXPv
         6hyeILi/OaNMB2i+AeyDz9G1pGxXwEuyk2+HiHuy1nhTy4tERjKEbYje47wR9nbZqHxg
         +6Tgj3Ncv27mdkXjys7XMd5J2rmespb6/paz8LtRksYBh4bdqsosEf21qnJ+Ka6iaI7U
         Pqz8qsF5Ry2Yw4PMzeEQCHuNfTWZTeGFKmCODMTJ/Lj6Y0pLVoUnpw5JzPOtsOwk2L5P
         AaIg==
X-Gm-Message-State: ACrzQf3hsP0J37v05msDT1Dg2DtwZCfh5+RvwIEvk7PVyW7u2UctbBhg
        Pslt0dKRbbBScLdxuKKnz6wARXPj/bGQ/DZlOChrkUKQJJE=
X-Google-Smtp-Source: AMsMyM7hzp+WQgpzqItoHbkuLdFmDDr6cDfWYIhAexuAtVNejhzw42tOHPq34m++Hy8PpMRBVak8aZdVnzkrewBqX70=
X-Received: by 2002:a05:6e02:1546:b0:2fd:1a72:8825 with SMTP id
 j6-20020a056e02154600b002fd1a728825mr21119321ilu.83.1666603050945; Mon, 24
 Oct 2022 02:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221024091354.2253669-1-tweek@google.com>
In-Reply-To: <20221024091354.2253669-1-tweek@google.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Mon, 24 Oct 2022 20:17:15 +1100
Message-ID: <CA+zpnLeRpRVsqaQnYDed1yZQvLuqym2TYj2_XgHxvmX8Meg9Yw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: ignore invalid class name lookup
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>, Paul Moore <paul@paul-moore.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An alternative to this patch is to implement stricter input validation
on the class name. I could not find any explicit restriction on the
characters of a class. Empirically, it seems that [A-Za-z0-9_] would
be sufficient to cover the refpolicy and Android classes. A regex
matching would have a performance impact here, this is why the strchr
solution was sent. Let me know if you=E2=80=99d prefer to explore the regex
alternative.

Thanks
