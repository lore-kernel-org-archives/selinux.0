Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068F9C433F5
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 16:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346691AbiCKQHM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245714AbiCKQHL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 11:07:11 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D31D0869
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:06:08 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so6565529oti.5
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZqYVlwWPAh/Nc3Y4BpzH/KfF3wjQcznkpnMS/566JD4=;
        b=C+5Im0PKSVTAcDHCUy5NaEPmUK3gFPO86WSHR8m9jOgEFgBdVrIRQtcQac/jpe/EZ3
         E5pOEkBzoP3osiC6SXiShnV4wPYtASAmmO8JqG4qkRS+ajBaPWyz6uVG2R9mjLssjYcP
         uj+aW/jtc1ZyVJvOmig1gj0u2vehcM25/2QgMgVZ3ZtZceudVUN1vy3qoAqZuVV/tTLw
         IAfCnyZx5xO1nTejY2RPwyNLjvLcB7KRwGJA7BnRYAIPxO8zt+F2MDUx2+89Rd5pVcLc
         mDO9gcjNg75gmVX3zd3d4lARtPSpioy6qIkAjvZjZ4Qju3J9rdAlVzwPeoZyrnqT8loX
         01mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZqYVlwWPAh/Nc3Y4BpzH/KfF3wjQcznkpnMS/566JD4=;
        b=QZAB4WaM1XYkHUaPswH3jRpjtByddWOn6cn8IFYNDrcoK2GPMX6hr5MKvivfPatOv+
         1q4BbwW1ajgWwH4EIVXp4/GLOREaOQUpQM7rdXjepSIjEARYmvIEh3eqtZZNJ+mQG+wG
         RlQkfFCYgJk2xMmuf3CWQWsYNN6G5u4zl/5NyWHeRzECV9PWmPatnAi5+rHMnZ8IgP6p
         2z1WHEEU5jgUmTWChmf1ad7ILVMJD5J9fkr4fIwJhlpNlDw7lsOyIkt4oZw468WdAPiD
         smTAo3kjHNriuwK1Sy5okUqYW42jYW/QAlO2Xqz9vgectytpRN73Z6y5BNP/SldjZoSB
         ia9A==
X-Gm-Message-State: AOAM532EenUGOujdXlfKEB/T5qPjdOpPSx+aMeoLLYf7r7Gk605XXFvx
        Id075rrFbUYp/dYicLMIeXgYi2+v/Dop68J9ry7pmvGK
X-Google-Smtp-Source: ABdhPJxPdyyX4pgAbaKz4jvNTNAERS+gdyNeR0+f1Tzu7B9cwM2P7h/tJVUXBVTiF38oEhEKOw6EtYVSjjhFruF81M8=
X-Received: by 2002:a9d:4d94:0:b0:5b2:34b3:1057 with SMTP id
 u20-20020a9d4d94000000b005b234b31057mr5263248otk.154.1647014767859; Fri, 11
 Mar 2022 08:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20220211184650.535016-1-jwcart2@gmail.com>
In-Reply-To: <20220211184650.535016-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Mar 2022 11:05:57 -0500
Message-ID: <CAP+JOzRxithCxrWGZ-BfUsLaTV17LF4mmU=yEHNkWK9S+KidQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: Don't add constraint if there are no permissions
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 11, 2022 at 1:47 PM James Carter <jwcart2@gmail.com> wrote:
>
> Since CIL allows permission expressions, it is possible for the
> expression to evaluate to no permissions. If this is the case,
> then don't add the constraint.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

These two patches have been merged.
Jim

> ---
>  libsepol/cil/src/cil_binary.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 4ac8ce8d..468fb595 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -2823,6 +2823,12 @@ int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, s
>                 goto exit;
>         }
>
> +       if (sepol_constrain->permissions == 0) {
> +               /* No permissions, so don't insert rule. */
> +               free(sepol_constrain);
> +               return SEPOL_OK;
> +       }
> +
>         rc = __cil_constrain_expr_to_sepol_expr(pdb, db, expr, &sepol_expr);
>         if (rc != SEPOL_OK) {
>                 goto exit;
> --
> 2.34.1
>
