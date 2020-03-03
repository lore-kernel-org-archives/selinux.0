Return-Path: <SRS0=zB1t=4U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D92CC3F2C6
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 19:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151292073B
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 19:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVt9B6DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgCCTNi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:13:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41252 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgCCTNi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Mar 2020 14:13:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id v19so4155998ote.8
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2020 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WD7l9eQyaYHslHqvS/p7+H1VZjzz7mH6Mec1qIjqqnA=;
        b=gVt9B6DI0HDjMavMH6qXBjcGmvQrh6zQIctqTqAefxKkVS/YzUxqTeVO8UgXAdfKLy
         XeiuTIofUKlQE5K+LGx02m/cPZWVKZ2NHQSS1waIV0ilfnO4faMYlV/ipJ3D8I4kCRzj
         7w4w+gnPkbHAGSKMWiFzglBBKwi81IesMIBxvsvaJadCP9lD5Jv+hFKZRkbU07ZLecOW
         +z+j7DVuTN8NkgzWby4aarS17ZHoZ3hLW4UUlWcN26XU0S4KXQJlJup2g6G+FjLQeCY6
         v3v42oCf3N9jQDn9oX0g554W5flk2t9v/tHeVUustfbSHkMIX/KjmFmJn9czhDP3ZmXT
         4DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WD7l9eQyaYHslHqvS/p7+H1VZjzz7mH6Mec1qIjqqnA=;
        b=GoQJ4xPFg2cVnfMib1uqSebeVTdMsDTbpuy+cm6rKHn6PxJk5A2LmwLcsCZ9zcvAyv
         mwuHWhY+bUq8Gr9ydP+IVxSEFssUK/e76u+G9vXNGzbEHE9wZ4xwiF7nXxvM+F2f1mnh
         9TxtezbYhuAcrHVkuJuWjTp5dIvY2ErPe621Tuy31xPYU5qE4FAShlApNAoD6579MxxL
         NHG6fj1N3uFmIIbv4jsYYg1e90+6TUwj5JtYGWSRunR+Tl2Bdz7W5TH4Tu10EkdYP/i9
         9CJV3eiO1cp6kVrtsEpyr1ffLgx2eKjA1G8gk0fSAocf5KMWhGqG04Xx1yyrnwQ08FV1
         OLKQ==
X-Gm-Message-State: ANhLgQ0lLUkVlUAzF1N+7KBoCu5YYso0jiBK8nd4vobtfCpUWT6kJKRF
        PiAdQfD2FLUL+XOEsNU4aGpsR4ju/cHiZP1nV6Q=
X-Google-Smtp-Source: ADFU+vuufFiz+ckKSxgQDd6u/zsxX56HoJJmAKtSgdqN8o9kiP+epxSMcbK3DBcfu6wK8cpx9TMpFOFP0QWTLsDfY1w=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr4276875otr.89.1583262817628;
 Tue, 03 Mar 2020 11:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20200303094813.142288-1-omosnace@redhat.com>
In-Reply-To: <20200303094813.142288-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 3 Mar 2020 14:15:33 -0500
Message-ID: <CAEjxPJ5rMJZhCE=N8HzbGRUJ+X+e7zwJW=XucUpd7zvaghA=RA@mail.gmail.com>
Subject: Re: [PATCH] Revert "libsepol: cache ebitmap cardinality value"
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 3, 2020 at 4:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This reverts commit 542e878690ea1e310bed9adda6dcb28ca8cd1d53.
>
> After 6968ea977501 ("libsepol: make ebitmap_cardinality() of linear
> complexity"), the caching only saves ~0.06 % of total semodule -BN
> running time (on x86_64 without using the POPCNT instruction), so it's
> no longer worth the added complexity.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
