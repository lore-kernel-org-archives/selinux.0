Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F24C433EF
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 14:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371C36124F
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 14:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhJDOYs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhJDOYr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Oct 2021 10:24:47 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BDEC061745
        for <selinux@vger.kernel.org>; Mon,  4 Oct 2021 07:22:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso21709473ota.8
        for <selinux@vger.kernel.org>; Mon, 04 Oct 2021 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqvJM3ApQKHrlI7wgXvyCZeY34Kx0FGN4Xt9Z35w8q4=;
        b=aZowrt6YNqcoXsPJHtpiD4b7iKPIXgDeOavIGMEMDN/f1ncMTV0EEbDjNI7MK0VT8z
         dSCX/SesO69/Erfm/JIZIY4r0ClIyN6vvy/xJ6Qz5EHRhB/z/Dipw4HSFQ2hreqSubrG
         m4DfrpF7nI1kIf73qqOartRdATdiDHIVAu2sg2Ho2W8e10/OhFqIgveFjy0JoGrjJCf/
         5y+LZwjvxplGsrfwwuFSWmdn7Du13UuIU3+j9+st+Gtz5lIfw6IO/MNjQZCQ2ewpYwCm
         ASmvSHwC0TvKCBxQFnoNj5WztTp/vIvrpKo21BarOUMwXbAd1cxW06/EUayN6J2Iqv9e
         3sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqvJM3ApQKHrlI7wgXvyCZeY34Kx0FGN4Xt9Z35w8q4=;
        b=AT8pVhN7ADUULFT9Hjlj4Gne8Syyvp8cE64fw+pzyaCAOfUiJLCR0SOTeKDNs+4y2R
         T00e5MXuTDRR3Qs0kNEPHCEw7s4PpI2To5e/TCgASV5FrZ0J/uytdatGHSzSMF2A/43b
         Wxl2TeRVyBqHtTzyFFDvuJs2LOlCBP3ZIW0PNRstypjE0rCM0AnjLBDGfYgIdJD5ALPd
         VdSpLbwjauViveRPNfY/fkfnqWglszELYN/KyEnayCpTFxKp0s4s0aJ74bPQe/m30o26
         Ffr3tpqD5ahmxdYZfwRwsAqnqJ2jqsuFLGSM9Qc3heZ7CKR/rqvOvOFV3+t+twiAhWKh
         X9VQ==
X-Gm-Message-State: AOAM533AyWXg23vvJqetgfgGwyAlqqu2TEmmGSk4SCehDQAAZsSYzUed
        /sLCVIMRZaXq19RI0Q2PdOHTJymv7fTzUGt9oBA=
X-Google-Smtp-Source: ABdhPJzZbcVOFirbZeQt62JlH1H0FA9KL6tP84cR0XYHtlo0GnrBM0dyCBvJLrAnjtNz4SfsXOxT7uD1UbwTkyr694k=
X-Received: by 2002:a05:6830:1acc:: with SMTP id r12mr9934248otc.154.1633357377651;
 Mon, 04 Oct 2021 07:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211004125719.1155053-1-plautrba@redhat.com>
In-Reply-To: <20211004125719.1155053-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Oct 2021 10:22:46 -0400
Message-ID: <CAP+JOzQM1SCb+CMP-tgqsAwOna64i-Q_DOF4hprtkC20VhOz6g@mail.gmail.com>
Subject: Re: [PATCH] libselinux/semodule: Improve extracting message
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 4, 2021 at 8:59 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> The code doesn't check the default priority, it just looks for the
> highest.
>
> Fixes:
>
>     # semodule -E testmodule
>     Module 'testmodule' does not exist at the default priority '400'. Extracting at highest existing priority '400'.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/semodule/semodule.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index bf9eec02a050..66ea06624eda 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -672,8 +672,7 @@ int main(int argc, char *argv[])
>                                         }
>
>                                         semanage_module_info_get_priority(sh, extract_info, &curr_priority);
> -                                       printf("Module '%s' does not exist at the default priority '%d'. "
> -                                                       "Extracting at highest existing priority '%d'.\n", mode_arg, priority, curr_priority);
> +                                       printf("Extracting at highest existing priority '%d'.\n", curr_priority);
>                                         priority = curr_priority;
>                                 }
>
> --
> 2.32.0
>
