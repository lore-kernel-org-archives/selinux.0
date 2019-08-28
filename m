Return-Path: <SRS0=2AUq=WY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F71C3A5A1
	for <selinux@archiver.kernel.org>; Wed, 28 Aug 2019 22:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3270D22CF8
	for <selinux@archiver.kernel.org>; Wed, 28 Aug 2019 22:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="v9rwH2eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfH1Wbd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:31:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40334 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfH1Wbd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Aug 2019 18:31:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id u29so855125lfk.7
        for <selinux@vger.kernel.org>; Wed, 28 Aug 2019 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfD39eMhahq5RPIxbtwrHbWm+T2yhY7dOwxrsfCVrLE=;
        b=v9rwH2eBFW261b7b8BJUXi4C6eXYM0joLh+Vtf3nq9InZd2tIyODHV1MHLF76Yti8Y
         D2wGXQw/czNOSichfzJpLnvK/f/oRY/kxCZyi1IecbxUHp4LPy0euE5OzS9R3cn3Fowk
         zkIm8IbnUe0QD45FjYiP+Agu1mJIjZU1IPnnNwYTxDpJ5da+qrlduO4CksJU7SCveS2u
         k27aRmDo51uexTj+sKYcLqnLztwAPk4tEriIG8YpQaNBbFEg4tW5AKoa93Sz3oVLFFWu
         LUZ/qZCybRh1hhcTAhOHY0zW0AIAHI1FRDCP2JdTS1J+fDJAKbp59olaSVCkyWxIXP8C
         Jv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfD39eMhahq5RPIxbtwrHbWm+T2yhY7dOwxrsfCVrLE=;
        b=N9ipVTdoNN6OzS+GI0JN8vNO40FINt4J7uldxMV2ZBBfONUayYyvjq/IxTkvmiB3sc
         t5/xmFgFnFOGhN8iBTqt8V3qst8rNDWtpwvjtu30qGrhtsu+XUh2lZu2GMh2j69VlQ9O
         dpWFPIHN/q5rIOdMFLvduXORLFV8LrU1rkNxxDmyl7dc++i9KaNZU6yUX2aHRVdyoLVN
         YSTg+enbg6VkqKEJz4rrNJTmOUQqvBoF4gP/CzT2Ogv2ogq7+2N7GLbGkC3b/IIGdlDV
         SEfdAE+xM2/1CtdvfT8qdzGSvJXz7tRXcLWWzOjPqeYSkGjk9Wey+rfWUd+MTew16ugw
         iayg==
X-Gm-Message-State: APjAAAUG1OK/bW4zxF0uRReI1ymGOKZm7waZJUtYJ/nLZDiJljQdoRbt
        ItSJiFwHnF2kf3TgzmO60GGeFRPYORp4iSbPT2HF
X-Google-Smtp-Source: APXvYqwlI7rPVcCYY8YsaJcFXCB3tZtbWJ3JRqq8Wze2H4yCOQP5WGTIhcQMsQmKUjbE3HXJS4S0phl1HWIvzIurEew=
X-Received: by 2002:a19:ed17:: with SMTP id y23mr2649489lfy.175.1567031491518;
 Wed, 28 Aug 2019 15:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190828204259.23160-1-joshua.brindle@crunchydata.com>
In-Reply-To: <20190828204259.23160-1-joshua.brindle@crunchydata.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Aug 2019 18:31:20 -0400
Message-ID: <CAHC9VhQVeSvqFYA9tgVZi9p5B6mDWdnsREJUYfP-oSGi17YhUQ@mail.gmail.com>
Subject: Re: [PATCH v2] default_range glblub implementation
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 28, 2019 at 4:43 PM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
>
> A policy developer can now specify glblub as a default_range default and
> the computed transition will be the intersection of the mls range of
> the two contexts.
>
> The glb (greatest lower bound) lub (lowest upper bound) of a range is calculated
> as the greater of the low sensitivities and the lower of the high sensitivities
> and the and of each category bitmap.
>
> This can be used by MLS solution developers to compute a context that satisfies,
> for example, the range of a network interface and the range of a user logging in.
>
> Some examples are:
>
> User Permitted Range | Network Device Label | Computed Label
> ---------------------|----------------------|----------------
> S0-S1:c0.c12         | S0                   | S0
> S0-S1:c0.c12         | S0-S1:c0.c1024       | S0-S1:c0.c12
> S0-S4:c0.c512        | S1-S1:c0.c1024       | S1-S1:c0.c512
> S0-S16:c0,c2         | S4-S6:c0.c128        | S4-S6:c0,c2
> S0-S4                | S2-S6                | S2-S4
> S0-S4                | S5-S8                | INVALID
> S5-S8                | S0-S4                | INVALID
> S6:c0,c2-S7:c4,c5    | S0:c2,c4-S6:c5.c100  | S6:c2-S6:c5
>
> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> ---
>  security/selinux/include/security.h |  3 ++-
>  security/selinux/ss/context.h       | 28 ++++++++++++++++++++++++++++
>  security/selinux/ss/ebitmap.c       | 18 ++++++++++++++++++
>  security/selinux/ss/ebitmap.h       |  1 +
>  security/selinux/ss/mls.c           |  2 ++
>  security/selinux/ss/policydb.c      |  5 +++++
>  security/selinux/ss/policydb.h      |  1 +
>  7 files changed, 57 insertions(+), 1 deletion(-)

You incorporated some feedback from the v1 patch, but you ignored
some, can you explain why?

For reference, here are my comments on your first patch:
* https://lore.kernel.org/selinux/CAHC9VhRXyRDjj3KJDHvA4ruJg6H+1kzFPzfA-PLZ-NqBicsLrw@mail.gmail.com/

-- 
paul moore
www.paul-moore.com
