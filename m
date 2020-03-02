Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026C5C3F2CD
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEB820848
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 15:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTUOiF4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCBPW6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:22:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36592 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCBPW6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 10:22:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id t24so3434327oij.3
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 07:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xp/uLrrgRVGO7gmrrB9qCKUicclcS/7AP9EzQpXOw3g=;
        b=UTUOiF4SaQ3oxdqfZbeiQOp3M3o1wBd37zPRM+0gLe/Jon7NPYffA5piwa+8t6GAWF
         C3PHm0XYD4zAohjwgJEJQz82X4FZizyiaMClQqMUIpXkD8T1S5fDOmMg/hmPeCQD+kjh
         r7c54vFx7u+AUW0k+Ju0Tus2Hzcjtp4JLvLMJS+Ihj/LjYKuKuaVK7hQ2AUFn3ZfIZOz
         0EVyGH2LQTJVriUkI+1z9EQ4NeHjPj3j+j3UCk8h2UT5Tfa4z4dvlVmnG2Xk5yLMUdP6
         HM90l90uB/Pt8sVQtZvT/cXU1hq9Q4kOhx04OVjB1OzUGBKC7d7By6hL0OtmHEpQ65P+
         q7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xp/uLrrgRVGO7gmrrB9qCKUicclcS/7AP9EzQpXOw3g=;
        b=uGOsCWswgtpAXPynt3MaOP0I+Cpc2NURKdr2vHO/Omq6GvfMHorGGfA8uaVu+wlDuU
         hMC0ixLdZTtT44/Px18ZOOUQWQV+Zu7s1jjxAfHLQ3RB+ZKNDpZIPnPMpyJhFh8jdHhq
         8y0r7MwyD1LXtFtzotDtK+lzWUvkJ7uk78PP1H898KzU2aIbo8NqSmFX2fSnaoCvN85t
         aSC7ecM6ggUZ2jOhK4jQfKqlVPRcRkEakz0dAEE3uVTKidxtBRt82rI/z0rCqbUsYKxa
         GvENku2KcZ8FCVRt4++1EYMNQ7Z/j+7Sy8TMqsCYadtCuUjLmzGkcbFeP4FsOUNsXucc
         q3YA==
X-Gm-Message-State: ANhLgQ2n9Y9ZXX3qAQ+2zWgJ2yfrXEI/Ap2xI0Dlq179v2XhilvoFMO+
        8mdNqCrZnr53dqO9g0sMIwoIBcUJL0yYvnX54u0=
X-Google-Smtp-Source: ADFU+vtk0SOVehTd+3ak3iiSEgswOeHIP2CpQS1ZxU9jw1BjZ+ivs7Ibf7Ex+Up6Ao2dW4IEs3UNjfBWnVD7RRkqi9M=
X-Received: by 2002:a54:4396:: with SMTP id u22mr23080oiv.128.1583162577690;
 Mon, 02 Mar 2020 07:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <20200227160257.340737-3-omosnace@redhat.com>
In-Reply-To: <20200227160257.340737-3-omosnace@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Mar 2020 10:24:25 -0500
Message-ID: <CAP+JOzSRMFHF0FXOtkfjAsignPhX0UyEzyWAQiM-8LPQii-ULw@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: optimize inner loop in build_type_map()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Only attributes can be a superset of another attribute, so we can skip
> non-attributes right away.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  libsepol/src/optimize.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> index 4d835d47..2b5102af 100644
> --- a/libsepol/src/optimize.c
> +++ b/libsepol/src/optimize.c
> @@ -50,6 +50,9 @@ static ebitmap_t *build_type_map(const policydb_t *p)
>                         for (k = 0; k < p->p_types.nprim; k++) {
>                                 ebitmap_t *types_k = &p->attr_type_map[k];
>
> +                               if (p->type_val_to_struct[k]->flavor != TYPE_ATTRIB)
> +                                       continue;
> +

I haven't tested this yet, but I suspect that this is what is causing
the difference noted by Stephen. A type is a superset of itself.

Jim


>                                 if (ebitmap_contains(types_k, types_i)) {
>                                         if (ebitmap_set_bit(&map[i], k, 1))
>                                                 goto err;
> --
> 2.24.1
>
