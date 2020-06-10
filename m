Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD3BC433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 19:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CEA20656
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 19:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTcb83D4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgFJTKa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgFJTK3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 15:10:29 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B68C03E96B;
        Wed, 10 Jun 2020 12:10:29 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i74so3144560oib.0;
        Wed, 10 Jun 2020 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zr/uGupFuGvMrFAVa6WiJ1h2V/NHtuxzOm0zL5k6jBM=;
        b=cTcb83D44ug2dUwS+XVrUU+yCJEYXxDYasAHrnWL8Gt4Yq7IrV+9K88RpWjjaVGUZ/
         J0pOMhK5d7tCTV7s/x+nDwvGIM/v6RhHaY69Pjw15NIhMdify9/oqAEFWoBjrXEFhPEI
         lD1aIQ8rfaE734NB9PZplKUn6bCXuUMIeHnZbcM/i9WiQedaMbWe7D4DmksV9jQJhbYY
         bi4IA21klGK3dTq/pv/q2wiIdeySVlQi/iuzyaQUfX6uYizQ4iZ1rFBgWRpFGOQESFXZ
         cB6tfg3nywhQDFz2EKR8GaBzuFGmA6++rj+DFLTqri+waeBeMO+mPeiIctTeosNe0U68
         6P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zr/uGupFuGvMrFAVa6WiJ1h2V/NHtuxzOm0zL5k6jBM=;
        b=fInML7aBUfom3Xh7Mpo3GrrgTUrkuJ4+lDS8BIjcpjLrSDW9jbC66YG8NQegAPllxx
         YJ6oyF0c+tLSbY5QyFkIFgquCyCeKVPZMlLlBpXwUOvEG+ai8qjA2eLf2Ju7PV68NqMd
         6j7QkHMhkZyprwnRqKfxsJnD8C84UsA4frGrooPbZVVNPBg6pwRvvZVxwOrV5HvXIUOq
         yQXvnbQ/HA3Ru3Gu+ABxi5XGGC+2MNfwFwTxvD8Zc2sK1aEmoI66ea7MI4qPYaTEIzvd
         YAlUKfn977M1RhygGjO00OE7xqEB7VdkvHR5QjsxP4ZTNpk+21xzTpM6zMQQbJ+KMX8L
         KmmA==
X-Gm-Message-State: AOAM532d+tcwLjLoHvlWXajvTbEMo53p1h9hZWHjWYL0XjlHNGUc7ilG
        BZRXG9qWzj/QM/Ar+vq0hBmqRfW+0seFvGdhoFM=
X-Google-Smtp-Source: ABdhPJw6N4mxNnryIirxir6EULeXyUYgAe26nOLEfqvRZ/ZNV7eLviZMzF+VGW2gCZ2DKZAE2vnd9uQYFRbKz1Kmnz0=
X-Received: by 2002:aca:a948:: with SMTP id s69mr3720382oie.140.1591816228579;
 Wed, 10 Jun 2020 12:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200610181021.19209-1-trix@redhat.com> <20200610181021.19209-2-trix@redhat.com>
In-Reply-To: <20200610181021.19209-2-trix@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 10 Jun 2020 15:10:17 -0400
Message-ID: <CAEjxPJ4uRG4FiBbyUxQdsLWsz4torr+rst1VKN_Gdk5PqT6Kpw@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux: fix double free
To:     trix@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeffrey Vander Stoep <jeffv@google.com>, rgb@redhat.com,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 10, 2020 at 2:10 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang's static analysis tool reports these double free memory errors.
>
> security/selinux/ss/services.c:2987:4: warning: Attempt to free released memory [unix.Malloc]
>                         kfree(bnames[i]);
>                         ^~~~~~~~~~~~~~~~
> security/selinux/ss/services.c:2990:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(bvalues);
>         ^~~~~~~~~~~~~~
>
> So improve the security_get_bools error handling by freeing these variables
> and setting their return pointers to NULL and the return len to 0
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  security/selinux/ss/services.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 313919bd42f8..2dffae1feaff 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2888,8 +2888,12 @@ int security_get_bools(struct selinux_state *state,
>         if (*names) {
>                 for (i = 0; i < *len; i++)
>                         kfree((*names)[i]);
> +               kfree(names);

kfree(*names)?

>         }
>         kfree(*values);
> +       *len = 0;
> +       *names = NULL;
> +       *values = NULL;
>         goto out;
>  }

Wondering if the caller handling ought to be changed too even though
this should avoid the problem.
