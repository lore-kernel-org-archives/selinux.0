Return-Path: <SRS0=GDzX=AG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2976C433DF
	for <selinux@archiver.kernel.org>; Thu, 25 Jun 2020 17:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFAA20789
	for <selinux@archiver.kernel.org>; Thu, 25 Jun 2020 17:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ9zRoTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405100AbgFYReV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404938AbgFYReV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Jun 2020 13:34:21 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F130DC08C5C1
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2020 10:34:20 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 18so6024380otv.6
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2020 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PYIrxKIr2k+1olx4ilCffUSrLcnm0Sa0ZplUrwLWn0=;
        b=AQ9zRoTSDAY0B+sh37w57pq2E4s/5qM/W72CFyW0O7AdR/zHRCEeWKjlyq2dpk0uYS
         ADEwmlTAnYxdJnuLeoBP3DVDolgV/GufNI+jPj9hDeY5EQjtaWzCSnyhFa/HqFThOLZl
         WYmGjpXP52RhYWVhL8i27xOepC5OzSE7y2393u5OIcpQ1A/Z7w8fqeBQTyDUF+s1Now+
         d6K2++wr7ym+TSXLdcWv7Rj8iGfxWKhE9T2IsPwU6497c3AOFSH5BaIzsCrc7AG4gzBT
         rHeN/N/Uydsa1JtHZore1QUC25F6Z9A1Z7bAbFP8xZ3WY+SnS+GUkzn/saOc5afbgD42
         HLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PYIrxKIr2k+1olx4ilCffUSrLcnm0Sa0ZplUrwLWn0=;
        b=uUXX4J5gg901HysRXZDYDlum8NHqPVY+mWfeJq0MORxE+qvTSI8XChQvylg7OS0Tbj
         dRRduTTgClkHE34LP+yTPr2iKj9pJUuQfFclsiflGoFXH3EF0nFBwbzuiQnmtF87/TYH
         ZNQKfwOuaqJ+cwh41tK6PKfE+QHcyKUoYdWqwoCXqEGU8ie2uvuPoD/oGzCyxqY/eO0J
         Po/KeRoVhpxl6kRJHHU+t3H/TKD6vL4DCjU69GtkNsjifR4nVcfCaHIOZKRPYDjPQsbk
         XNG9SbhhOSRZkN4JS7NC6y5MaVGEISD6N6DcQ5xq/VViGPGHWmRwqPVxknpkHyjHDgM4
         DzTA==
X-Gm-Message-State: AOAM533uoqmwy//XlTPl1q8wZZmdgHOS7wI60uZC3YLgYwLikVXyCxcY
        mmCbbWBAcrEp3A/r23r9f1ynxRFAADQuL5mKGr54RRC1
X-Google-Smtp-Source: ABdhPJwCpzL3fLmSVyEI/THS5pR6eSEOYbBWmnmIIqHhOScNkkuAb3Er4GlGqRnrIbPF/NnFLMjsixeyU1rD946gCYI=
X-Received: by 2002:a05:6830:2003:: with SMTP id e3mr26397311otp.89.1593106460350;
 Thu, 25 Jun 2020 10:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200623123702.401338-1-omosnace@redhat.com>
In-Reply-To: <20200623123702.401338-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 25 Jun 2020 13:34:09 -0400
Message-ID: <CAEjxPJ59sEELJGoS_GO9P+fAiWtp3QX_zrF9onbs8bZN78djcA@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/4] Various CI-related testsuite fixes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 23, 2020 at 8:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> There are some warnings and non-fatal errors reported during CI runs.
> Additionally, the CI gets stuck when there is a force-push on some
> upstream repo that is cached. This series fixes these issues.
>
> Testing Travis run:
> https://travis-ci.org/github/WOnder93/selinux-testsuite/builds/698848141
>
> Ondrej Mosnacek (4):
>   Makefiles: remove bashisms
>   travis: add missing node to fake selinuxfs
>   travis: fix git/cache handling
>   tests: stop using deprecated security_context_t

Applied.
