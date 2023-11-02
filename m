Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658E5C4332F
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 19:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjKBT2h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBT2g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 15:28:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C2612D
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 12:28:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c6ed1b9a1cso17501961fa.3
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698953312; x=1699558112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/pWN9JXHSpfb8u7XBPTnpxvDlvZlRLjgjQP5UCm9rs=;
        b=WYD+mYI04SZvRgUrWBHwgO1IlOiIwxUblKn1R50GfEMF5lVUccEul4bMs5Dl5OUk8J
         AghdeaLdyPRWIuaHogwTZB241e4K1sENSl27Qg7VB62G1TWACXVVrGMwGGhkWAn9LKiC
         fSRVMwdKD8v9kBz2SaX3zJaqU4uD8m42wPwoEE68D37hjlEFaDOeV3QANDuk4KJRvRZI
         Ky7ftpxSLvSSBPdUc/TCf8V1fMilM5roF8QiW37cPgTPosJx90xFWkWgXcqznV7hv0z/
         e5Yn9fftN8T17gnipQqlOHYy+wZRzxO/EAarQnevDQW75UsJ51wx8vGpCy8VkjzlFrWh
         yiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953312; x=1699558112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/pWN9JXHSpfb8u7XBPTnpxvDlvZlRLjgjQP5UCm9rs=;
        b=GyglbowFpPnJGHi9H9gx3dkC/2yxSGjIT9d+euazoaKQLI06jbRkLUZjgLpNF0DpkI
         ni7aMwFV+EMptwtxiohjR2C9jmph/iPz37CXM/cEAjhQksYV6h74En+QaTFBHyQg9A3U
         Stn24XnzrkHMmlZQ9xaP1uW9AqUoBI1JWQ3bgw4uUVnAh/k7tbmmeZBj/YD4+KRW9rpm
         bavEPMg+oE0G63CmgirwjlJiRKdBF20RysMErD6OtmqDwKlL406ror+w8FPrJkYoFJ+I
         HXl+o1u93033Ww/EFxo0UC6/lrEP3lGBLlxl5gt1bd086YmyuwUOMCzJc1IrZzZg2+2l
         F+Ug==
X-Gm-Message-State: AOJu0YzOUP5J1fxtDDeMaPrnGzD0CNblzqaFkdfhWeqKhMWIJJxTGd5s
        nFatrTIokrNiJNjWd7yRiFyVoXuegQdYHAQZTcQ=
X-Google-Smtp-Source: AGHT+IG3GeWQwMcl+pOqsGI1DZvlkK0NNMjIjWL/91iATjS1F9pzoSX/z5bxBZYk15bFPEzWsycmXlKvRTSek/BTai8=
X-Received: by 2002:a05:6512:b87:b0:509:4424:2e13 with SMTP id
 b7-20020a0565120b8700b0050944242e13mr4389070lfv.65.1698953311927; Thu, 02 Nov
 2023 12:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231101163830.177769-1-cgzones@googlemail.com>
In-Reply-To: <20231101163830.177769-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Nov 2023 15:28:20 -0400
Message-ID: <CAP+JOzRyn_+SK1ENRuV5yJmrtAH_uBs7GAw_VpHsYUks7ybPmA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: validate default type of transition is not
 an attribute
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 12:39=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The default type of a type transition must be a regular type, not an
> attribute.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 892a0ffd..d214bf09 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1105,7 +1105,7 @@ static int validate_filename_trans(hashtab_key_t k,=
 hashtab_datum_t d, void *arg
>         for (; ftd; ftd =3D ftd->next) {
>                 if (validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES]))
>                         goto bad;
> -               if (validate_value(ftd->otype, &flavors[SYM_TYPES]))
> +               if (validate_simpletype(ftd->otype, &flavors[SYM_TYPES]))

You are missing an argument. validate_simpletype() takes three
arguments. The 2nd one should be the policydb.
Making the policydb available here is going to take a bit of work.

Jim



>                         goto bad;
>         }
>
> --
> 2.42.0
>
