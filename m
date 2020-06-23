Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F17C433DF
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3798720723
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkICLBB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbgFWNQM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732580AbgFWNQM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 09:16:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90022C061573
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:16:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e5so16486456ote.11
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i5Q5CnZ7xY38UIzJNFU5yGru0/GWm2EU2CNL4dY0Ogg=;
        b=AkICLBB3apwoDYr/WA5tPRU6n2v2M3uz+eUIANqxUGUlxEuBH7Urfvn6j2c/NZxu+V
         rkiM9BnGJWhySGaPdY30e/x3P0pQYdL0XUdQSZSBKjas50AwUkC5u3AvAqGBPOIAA3rK
         B1xYgGOZ69keIpFBTsl+MUPwijaEVRxtdPkeUga4bZhUbncYu6G/Avva8Ac0k0lFecGw
         6sP2PZ8UanCjHfkd2toKM8AXZQNVtri7AUMUcKt17k6l8ZUBwa4dp865p2P52pjOB1Uh
         kZPnXSLiLvWY7sOk1e6HMoSsVQlNwvSPOWrmNi5acyf53KTSuKGwK7ZY6lA9dZovOXci
         m4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i5Q5CnZ7xY38UIzJNFU5yGru0/GWm2EU2CNL4dY0Ogg=;
        b=SZM1PiZ7jJux7LEGVx0sEhNpieZ9eEbZxI8jN5fr1BWAOd+g/k6d4ZgYU2Vd/sTaXl
         DEM4O3WSaacG5PLGw4YHozZ+bgHutQQxDtE5NoimNdsms8s6Bve6ew76HQu/4SmSllz/
         +IjLvxvblAe9DBZskWAz99Ilg2Sw5Q9eYwBCD7wyNwfflOXYQRbQ9kdxqUW6bPe3TQXj
         +l6m03bb/CYrhuG3d4FvpF5oL02/9OgnQR7z3Rt32NWWSJQTILEEMqta9T/VRCwOZjfx
         CgV6ozRtATAc+0MFf2XvJhmZ9s0wgF8ROhe04S4BPUc+n9Q4xWRrPED3dcpRtY45QlHW
         64Og==
X-Gm-Message-State: AOAM530bXEjN72v5fSqeYgseKeW4VasBIJGDcPset7BiGSsRMamqOofk
        nbhkRetBQfeekBQFGTc4dxcJmm4lnTL1iX4tMF+aDYOejm0=
X-Google-Smtp-Source: ABdhPJxS82xtd83sM7I5GgzJA3Fkh1S937bsu2Oacvyztcw7/UXAvMhvpSPoJmTqVp1nfCfQ8AYLCV7MpcJHqFimshI=
X-Received: by 2002:a4a:e74a:: with SMTP id n10mr18373443oov.71.1592918171049;
 Tue, 23 Jun 2020 06:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200623123702.401338-1-omosnace@redhat.com> <20200623123702.401338-5-omosnace@redhat.com>
In-Reply-To: <20200623123702.401338-5-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 23 Jun 2020 09:16:00 -0400
Message-ID: <CAEjxPJ534XTRnm0UbnC1wCeTK3n280dktH9DD0V2sDLY=6Lrwg@mail.gmail.com>
Subject: Re: [PATCH testsuite 4/4] tests: stop using deprecated security_context_t
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 23, 2020 at 8:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
>
> In Travis CI, GCC reports in several places:
>
> gcc -g -O0 -Wall -D_GNU_SOURCE -DHAVE_BPF    parent.c  -lselinux -o paren=
t
> parent.c: In function =E2=80=98main=E2=80=99:
> parent.c:25:2: warning: =E2=80=98security_context_t=E2=80=99 is deprecate=
d [-Wdeprecated-declarations]
>   security_context_t context_s;
>   ^~~~~~~~~~~~~~~~~~
>
> Fix this by using plain char * instead of security_context_t.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
