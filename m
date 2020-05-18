Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87386C433DF
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 18:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA1F2065F
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 18:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf20tyza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgERSdr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbgERSdq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 14:33:46 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687EAC061A0C
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 11:33:46 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a68so8945362otb.10
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZnU+SPdc2vbgvHJiM5mTzgSiASqOlBEVxA3q54Q4fk=;
        b=lf20tyzaOL9sI4Fpm0N/pbljKb9h7OuyFZy/ZvXrPXzT5GFj0CiQUCq373o/a/efMm
         +IRoub2zRaY8PGiKYbjzV4p1anzsl5UqC1q1Az5C5VUtT3MnxUx4/zbQnJBdxDnvrpvB
         KKYkCdJecSMam2vmwX5PzMvXS4bm3HQJTWPWvSD0/CnRP6CtjYiHm8CO2TZDHVYIAae0
         G/zkztZL5YpgfCmqci0LNg9Iw/Dve3IZ9MjJauTOgNa0Y0S4jQCD0UT65TAxDqbV/ykU
         ZPFgOaBDZ99xxnD4tXvhElSZur/7rib4lyX35bYvpVn4kdO6cdZOKk4z6h180RNDD12U
         zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZnU+SPdc2vbgvHJiM5mTzgSiASqOlBEVxA3q54Q4fk=;
        b=Qy07T+JdZwvNk69fZ6z10HLjfQQTI0blX2EwyxSlmlrvAYbhv7Raz798ATXW+t4QoK
         8gYoBHe1v+ucO9BIOpJlfeNFyaST9CenfVA0Ewk6XzogLJZ3hUeirgEYUZjGiQfUaUKH
         vHirJLDoYm/2a5W5GWFCQMhOeRZKBmAhsav0aHmm8wcwNdKPQoZ9lMCjc7ROnN033DpD
         nuZXuS7XXswpPuATMieEzzDHX5DRvVcu/n+i0cySiEqEvqUM6+6AYwbV3ceageOeGAZt
         dVeV+3eN75fSHGnthQSQfDegGeCNTLcroEEv0iCv2FOGVUqkB47mSLD2Nu7NRah3iApA
         h5tg==
X-Gm-Message-State: AOAM5325IfEi76BkdU+czhLqbirMJB+20hHvD+yX3vJ9Nln9l4IxFJce
        nlEhO8nRJHlwFjsgwO6F/hg+SYISOUOf3B1sK3U=
X-Google-Smtp-Source: ABdhPJzmbvr0nAJReNlbD1KVae9Djij6xrfZmIPd7YkAQRkIkQs+CvNQe37bE1WNSd4011XobCqM4u2xo3QQuBHaJp0=
X-Received: by 2002:a05:6830:158b:: with SMTP id i11mr3760720otr.135.1589826825837;
 Mon, 18 May 2020 11:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200518181251.31862-1-jwcart2@gmail.com>
In-Reply-To: <20200518181251.31862-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 18 May 2020 14:33:34 -0400
Message-ID: <CAEjxPJ7tZNm71eZOOXy55Qw6X4a=HWRw6c8SnotCc6yc_odgKQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Initialize the multiple_decls field of the
 cil db
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 18, 2020 at 2:14 PM James Carter <jwcart2@gmail.com> wrote:
>
> Initialize the multiple_decls field when intializing the structure
> cil_db.
>
> Issue reported by: Topi Miettinen <toiwoton@gmail.com>
>
> Fixes: fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare
>        types[attributes]")

I guess this explains the non-deterministic behavior and valgrind
warning about uninitialized data, but what about the segfault?
Don't we still need to fix the case when multiple_decls is set to TRUE?

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
