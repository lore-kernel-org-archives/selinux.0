Return-Path: <SRS0=aJPZ=DV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA66C433DF
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 07:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B466120878
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 07:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxpKSozY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJNHmB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Oct 2020 03:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgJNHmB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Oct 2020 03:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602661319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S4laDf2PqVEYxJcDoH9gFUhGvHkW4Fe/9N2Odpd0TC4=;
        b=FxpKSozYpbY0pDUavA+AUXzA8OMksiLRh9v7Npl97SDfyqKX0F0CxNNxu7/YhVL3gi2/hq
        m24MX7XXdwhcC2BEVtED7nEBmUEuFJ7N64GTiBBP75tnVMZcMeBamaXxroVCD4szUzk74U
        QEa6rCJtfH22WAFdXsndqEnsSm9E7XA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-bgL1eXh8OEmJeGvis9RG2Q-1; Wed, 14 Oct 2020 03:41:58 -0400
X-MC-Unique: bgL1eXh8OEmJeGvis9RG2Q-1
Received: by mail-lj1-f200.google.com with SMTP id s11so989104ljh.8
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2020 00:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=S4laDf2PqVEYxJcDoH9gFUhGvHkW4Fe/9N2Odpd0TC4=;
        b=eW0+h3tU4ahhWVBDPG2bdMjn0sFfYuHbzG8/b1RB+JHuD/OuWqNb4de4ZhWS4TTZiL
         jyyq+QXUyKxT+FV3IlBDJaGlkHz0q7ENgt8Uv6jF7VW18vrkGQPgQHNEaOg2FX4sI66G
         HLANo5lifHO/mGgLV9iQt7oY8ETNSdOIYPI8etYxhByPlVzNW1OK7PYy20jdOBKHt0TX
         X6nFwYpNdXdoZPDPqqXJvDxszxPmdFJl/5ZiKloItdJdgK/jOEb+7go2XqA0e6VoEw8d
         56nO25i8xvBcco8qptsSUhiHqTKMabhs1CAomquZwJcKFjrUONOs0Q0Hz4CrKUiEwBMd
         XZ0Q==
X-Gm-Message-State: AOAM531jaP/57UsUoDqn/UXHsOed2pfNmOGmHCw3BcgrenB1QfBpckEx
        FsvFZmshyGDBRtzF2sXlVAIxOWVYqKI6GosWzZT3DQ34EE1gxR2tyHhxhfyPL0l0PBtrJeHTLeX
        XnCewCT7RlwY1EVHFAJiv/7Hn+M534N2+Mw==
X-Received: by 2002:a05:6512:20ca:: with SMTP id u10mr937517lfr.247.1602661316320;
        Wed, 14 Oct 2020 00:41:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW3+UNeDAWcEmDJ429IkoWonYuH7mVVFVAoevkh72EYCWuOTMq6MCbs9RFLXFLEi29nonumW4l181cmvz68+k=
X-Received: by 2002:a05:6512:20ca:: with SMTP id u10mr937513lfr.247.1602661316115;
 Wed, 14 Oct 2020 00:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201014073721.392783-1-omosnace@redhat.com>
In-Reply-To: <20201014073721.392783-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 14 Oct 2020 09:41:45 +0200
Message-ID: <CAFqZXNtHyjYf5QaZr49pghpoeHSC+pFEA3dEbUxVievuvWG_Xw@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/1]
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 14, 2020 at 9:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
>  tests/keys/keyctl.c          |  8 ++++----
>  tests/keys/keyring_service.c |  8 ++++----
>  tests/keys/keys_common.h     | 28 +++++++++++++++++++++++++---
>  3 files changed, 33 insertions(+), 11 deletions(-)
>
> --
> 2.26.2

Apologies, I accidentally sent the patch with an empty cover letter.
Please ignore it (but not the patch itself - I did intend to send it
:).

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

