Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB40C433E0
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058BC206D5
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/zhvq+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgEZPl1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgEZPl1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 11:41:27 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D5C03E96D
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 08:41:27 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z9so14169376oid.2
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvUYwnveoWgEDDYOalsL9Sbv677ZddVi4g7EpS3Onhw=;
        b=L/zhvq+KefHpWiI+hZECsZ17cmXM0UfEufaedq4psBWAt6ZLzNBTFXOSb49Kt9VRC3
         OayNvyKYsDdLGukdGa7QeXyBQcr0vAiLg7r3cKBF1mxm2VEUH3PSdHnHyi1OQ2WqzJ1r
         Z6U+zIDrGM/O5re5m3OLXvucz1WwBQ7TA6WUz4r71aM+/UPvRMjX+XC8JBZVwJrBPOlC
         tZgCSnqEF2b5Ril25csF3zn+O66HJzlzXJ3GZLubzBo7yPqH4ZqVb9PgZomHVSVKKO0W
         YRU1kuWkccXlxcZCOWtZcVAGy6l4SQk60mT7sElZQxO+/08S9WCnoqRuLOANHgTGGbYI
         hMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvUYwnveoWgEDDYOalsL9Sbv677ZddVi4g7EpS3Onhw=;
        b=ZtXbUEq7wOr4aOEtG1oJ21ZeqPD4oNp7VVUvj+1unD4/GHI6LnHvpDG9d81XRNLuCg
         qa4WEoSE6fM4oTpbjhf91q7xXnC+oe4uO1SkvCtR/L1xoLNDS5JB83HFEZ/181xk0PbU
         534WpjBcoCH8OLPpbqad0Mv5oC88tgE7/lMaeqcQo4ycL3bqwett5llgX8wxq+O9sdKI
         XL3LzfOGCY0YicfR6GqNDUR4osRDa5iE5WgY5i9/CU/IKHTWhV1ib7GdkvqFUfDByh6J
         sNJB6C3q+WW27Kef7pr3gcBtOscayKrkkLb0M65T0k3b2eMyhGMn8bKfTq+iAgVWtKZt
         FtyQ==
X-Gm-Message-State: AOAM533uIo3PikOuiWgYOjBoiYSZSGjyLTO5sEihKM114T0KmKlSCxzG
        63nDuhAJr6v6XxHietWJc1bwrid7de+lddZtAm8=
X-Google-Smtp-Source: ABdhPJy0aJ3xd92fkvNdsceWW1lx2T6PPBCcWDxv+nhVINmWOPxL1LGPcfGEM1ujohU/zYFfYmoEERY3apEtosAuF2c=
X-Received: by 2002:aca:c704:: with SMTP id x4mr14035659oif.92.1590507686684;
 Tue, 26 May 2020 08:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200519142946.76861-1-jwcart2@gmail.com>
In-Reply-To: <20200519142946.76861-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 26 May 2020 11:41:15 -0400
Message-ID: <CAEjxPJ4T0aLUSRhcyTCVL=s0E01o6LMJBg3P0fP3MSE62Yep=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libsepol/cil: Initialize the multiple_decls field
 of the cil db
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 19, 2020 at 10:30 AM James Carter <jwcart2@gmail.com> wrote:
>
> Initialize the multiple_decls field when intializing the structure
> cil_db.
>
> Issue reported by: Topi Miettinen <toiwoton@gmail.com>

Conventionally this is just Reported-by: ...

Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> Fixes: fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare
>        types[attributes]")
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 4a77aa9c..a3c6a293 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -459,6 +459,7 @@ void cil_db_init(struct cil_db **db)
>         (*db)->preserve_tunables = CIL_FALSE;
>         (*db)->handle_unknown = -1;
>         (*db)->mls = -1;
> +       (*db)->multiple_decls = CIL_FALSE;
>         (*db)->target_platform = SEPOL_TARGET_SELINUX;
>         (*db)->policy_version = POLICYDB_VERSION_MAX;
>  }
> --
> 2.25.4
>
