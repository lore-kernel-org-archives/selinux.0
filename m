Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F585C4332F
	for <selinux@archiver.kernel.org>; Thu, 15 Dec 2022 22:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLOWNu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Dec 2022 17:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLOWNt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Dec 2022 17:13:49 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B623EBA
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 14:13:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gh17so1934767ejb.6
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YhkZLNhKEEn24H4OXf7a07iXlGtqmqfAx/BabrO/yws=;
        b=KWmDvPDyDZ4c26fHRSx5yatGltHvvKTR9KV5Ko9vHGB6K8Ofqu+rIrbzXTYeyf8BD3
         PrI9v+R8A79UaQnGYhO3GswgZLmH981eWxBrquEdHU88lEQZCCokkvWksbvAAl2Ff0mO
         6Wr+LfBt4r5b+ipM5zchP67u/bE1f1sUoVOkzGjwxnr/mAl8BQGdsf9tySvXTniDUV0c
         XMCurJLkT37nDIEg1T/XlxyrAEEgOiyR/HKK6ap/sEolOlF7rywKL7C8ILE2pS5sq7kB
         K+JY5uzJDrAazNm0gSifhq7YLKEJwrZTVUI0XibsaEPcq5kLehlbvPtj7Bo7iocSiGlS
         uK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhkZLNhKEEn24H4OXf7a07iXlGtqmqfAx/BabrO/yws=;
        b=PrfwiU7csMPkGATum6Ay8dZnxmo+Eb3otk+zcvlFKn3Bjnl0wuqpAAoE60aUAi9hS5
         e6xiYwHeFWdmj/rX9nd9uEcoasiE/u5LlW8O2Cfn4/jWPm9DCMfyjy+Ih23F6PVtRkhp
         dm+WAfqslm95uhk8DvY8+D9OJ493Dcj6S+PmlZcDdIkUq4dvl5O8IcDTg1D6b5i1I9Ur
         8hzdn9ptNZV8dR/VysObfWLdekHc1nDYdUBxKeJSvR3qWBu7NfNB/H5X2CaUP3f83kQw
         f4BZKgrvd9TE51VNYLouJolXu0jXqGig71XY83uLscmAM9kqV2nanUAvDZ6oEH5PNShh
         7CBg==
X-Gm-Message-State: ANoB5pnStBMZ7OR994p+LdzTkSqaFAxwu3a3t7WKCacaSeNiBYgmyWHn
        PZ0cFbb/FC1HxB3Ik2G2RsWmlaO9MMb9+MRg/4AripMEk4s=
X-Google-Smtp-Source: AA0mqf4o8WowsYvopu96pmO+UPjoLv17QoqaxIM0NNkyJ6QbvNk++Bavydf2sodBEaLgTJKDQuTT/LYwffAbI3SXmAo=
X-Received: by 2002:a17:907:6d8c:b0:7c1:675d:2620 with SMTP id
 sb12-20020a1709076d8c00b007c1675d2620mr2581120ejc.100.1671142425557; Thu, 15
 Dec 2022 14:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20221124163153.500945-1-vmojzis@redhat.com>
In-Reply-To: <20221124163153.500945-1-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Dec 2022 17:13:34 -0500
Message-ID: <CAP+JOzSGcmHHzaZOWS=wPqa-o-psgGJddLsFLJ15WDWg=KGDtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: Improve error message for type bounds
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 24, 2022 at 11:40 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Make the error message consistent with other occurrences of the
> same issue:
> https://github.com/SELinuxProject/selinux/blob/master/checkpolicy/module_compiler.c#L243
> https://github.com/SELinuxProject/selinux/blob/master/checkpolicy/module_compiler.c#L488
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 41e44631..86d57017 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1416,7 +1416,7 @@ static int define_typebounds_helper(char *bounds_id, char *type_id)
>         if (!type->bounds)
>                 type->bounds = bounds->s.value;
>         else if (type->bounds != bounds->s.value) {
> -               yyerror2("type %s has inconsistent master {%s,%s}",
> +               yyerror2("type %s has inconsistent bounds %s/%s",
>                          type_id,
>                          policydbp->p_type_val_to_name[type->bounds - 1],
>                          policydbp->p_type_val_to_name[bounds->s.value - 1]);
> --
> 2.37.3
>
