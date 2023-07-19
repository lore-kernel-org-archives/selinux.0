Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ABDC001B0
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 15:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGSP3w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 11:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjGSP3v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 11:29:51 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE192CC
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 08:29:50 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-57a6df91b1eso75634327b3.1
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689780590; x=1692372590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u04Eedal4JHVqrOnujGEZuDjrvzEeNSiLwtBthkgXBo=;
        b=EAFonRkquVoIadd/jwkwSEtFunlEZX8HbM8nwFnb+qvwdP478UX8+ma+N3SOIfi8Tm
         qMi4Ml39nCnDDFg3kLf/bckeSlVBfYcwKNgiwUOoEb3HUL6kcL9/MoA2R5r1sBKQnBJS
         G2CJrlO7LO1q4ggW+jUayA8uW0+IkulWRgjUx7VN/h2NWcP5xeuHtLqvJLYAXFBT6c10
         Zj1X40A06Btx4SOQorypCzBWuyYLM7P2fC3SaNhA+bmAQWI3I4tIbam98pZKLjupY13k
         3Xn8MIstxwtFmUkXeFHMGR7x3KzAHH1TrgynRrA04rzR9MQZo5KS9B2l922a6iuhSd7e
         U6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780590; x=1692372590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u04Eedal4JHVqrOnujGEZuDjrvzEeNSiLwtBthkgXBo=;
        b=ApFjmKPxgid/KERug7ket6kuGef8izfNFEXWUzLZXnQpls0CcAudMOwkfTZlIWyvho
         wsG3rieb3vFNLGKS8Z8hm8NXroXaKWNhPZHD/pg7NEFTHIgU84CM7wmC1zRk4xC/+Xrz
         hfhKWHkcsX38wVwQhMNqixFSqYOPmjAz38PSbCElHMwjksybEtQ2ij0FIzAKDSGm+D2J
         90bvW/sv/VeQ85w5IlxicGNUijhjRCJ5PAqqu5szBXu3Uf195+octBsZO3oXYtykVoAU
         acN025D6n+8zb2zoX6nEaNxAAnvoj09Qjv2bqE1/1ZHYyZgVqq1SQ2qjf0iY3K1ZyLnC
         v5Ag==
X-Gm-Message-State: ABy/qLaxDCaQLaymdaKzgqVr/BpNT3Bqz1nBZ30qtWdctc3VTbri/vIq
        GM736PeYbUGXuUSfzNmCVw03BuunbI8/38VGkmEFf0moZ41EKdM47w==
X-Google-Smtp-Source: APBJJlFem0jB69JMfBTziFa69wOH7y70/lEehy+AvuBFusD12AWbHnY0YXZqCAdcjcMib17VHF652rLp+kIo27jQENc=
X-Received: by 2002:a81:6709:0:b0:570:654f:aa42 with SMTP id
 b9-20020a816709000000b00570654faa42mr6105589ywc.40.1689780589751; Wed, 19 Jul
 2023 08:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230718190024.117662-1-cgzones@googlemail.com>
In-Reply-To: <20230718190024.117662-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Jul 2023 11:29:39 -0400
Message-ID: <CAHC9VhT9YzToyeQOZdqA2FFUWvn4wZ6fcYeeEEJH12mON_tB2w@mail.gmail.com>
Subject: Re: [PATCH] selinux: add missing newlines in print statements
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 18, 2023 at 3:00=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The kernel print statements do not append an implicit newline to format
> strings.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c       | 2 +-
>  security/selinux/ss/policydb.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
