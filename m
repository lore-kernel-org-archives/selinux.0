Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58433C433EF
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 16:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiGSQ3v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiGSQ3v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 12:29:51 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D95564F0
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 09:29:50 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so9408135otn.2
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kNd1GmVTxoW3go/QgvE+2Ko2+IPNNhQNqEu5sADJO3U=;
        b=P9FNP3sBuske+WoBdn/kcshFPV26iqgIMrSEG39yFgMrADY9RMlFoCQ+8DXLcSUHh/
         ji9RtR89MRkd4NPOhuiwN5k0+0DndW2bHWtgCQoEWiP+aGLRvrmWAtrEUaK14lz8h7oV
         bbeY6syM8q44qWx4AKgtdJxrpOLmPABEZ6aypV8mPCtG8E/XDY2awaJRIiGGiw1Oq5Q7
         UjYyB3jqOzVJwBW65d0v14KEj92Ab2/QIX3UMJjhLcXnCYvJgiMqTGdUYJPj4jhioPW4
         Y8M67mlgmxXo6BOAGYhHKe7fFSY9BkhLta5cRnI98X4N+6oWTOWSPsSMQlOWZ2zoKEr3
         PerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kNd1GmVTxoW3go/QgvE+2Ko2+IPNNhQNqEu5sADJO3U=;
        b=GHlo/zRCHtuchK6h5wRhg85+MQvm3H6znTezq/qFDs0Qqmwn7DVFt2DCIMHuBOIpDX
         HzzliqQL9sLQEE77GBZqZJ83J67e3CZeSZdKbRL9tXWIMerOwRHHr0+s71gqGBiUkT7C
         kjptmRF838eUXFgfsYDCI6X7uh+mvTfTxtOz178U0QR0hKuUel6SxepzTzMs8XZxDJ0b
         TaOu5ihnewXN5HBqClQU1YBl4MwnE/08ykWfDEbW+DgUCBTC0ITcRALp95DLXmYU+L9M
         Hqbk89s3CM4jqL6Y/5ch5mqg6G4Bflu6JYNTqAyqRJgPyrahzgyKNpKGRROlKO+R9brS
         B1TQ==
X-Gm-Message-State: AJIora8bLj42Tt8ILwsm1u7kNy4PSoQqpZWqkaq2Sz/rM+7Y4CdKHsIt
        dAErtGXA8qi3WaIS//GXGhQ+fY+kFHRTuQdOA+1LJo5gZU8=
X-Google-Smtp-Source: AGRyM1s7Y03vWrjiUkPya/Q4JYyRJsddq4sXWdNbB7GudFGCRetV3+SP4gYpgGGmhUTcFhGP/opXeL6NiJVaeyyZngg=
X-Received: by 2002:a05:6830:61cd:b0:618:d560:b787 with SMTP id
 cc13-20020a05683061cd00b00618d560b787mr14209089otb.154.1658248189658; Tue, 19
 Jul 2022 09:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220713134343.19811-1-cgzones@googlemail.com>
In-Reply-To: <20220713134343.19811-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 19 Jul 2022 12:29:33 -0400
Message-ID: <CAP+JOzSFzXmTTXBevMra4d6isCCW8uRP_Q0V8neHEA+Yeq=QFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: break circular include
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 13, 2022 at 9:50 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Since `struct type_set` is forward declared including
> policydb/policydb.h is not necessary and creates a circular include.
>
> Also drop the unnecessary forward declaration of `struct policydb`.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/policydb/constraint.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/constraint.h b/libsepol/incl=
ude/sepol/policydb/constraint.h
> index b91fc4e9..82335e21 100644
> --- a/libsepol/include/sepol/policydb/constraint.h
> +++ b/libsepol/include/sepol/policydb/constraint.h
> @@ -18,7 +18,6 @@
>  #ifndef _SEPOL_POLICYDB_CONSTRAINT_H_
>  #define _SEPOL_POLICYDB_CONSTRAINT_H_
>
> -#include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/ebitmap.h>
>  #include <sepol/policydb/flask_types.h>
>
> @@ -70,8 +69,6 @@ typedef struct constraint_node {
>         struct constraint_node *next;   /* next constraint */
>  } constraint_node_t;
>
> -struct policydb;
> -
>  extern int constraint_expr_init(constraint_expr_t * expr);
>  extern void constraint_expr_destroy(constraint_expr_t * expr);
>
> --
> 2.36.1
>
