Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA85ECAAD3
	for <selinux@archiver.kernel.org>; Thu,  1 Sep 2022 19:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiIAT5e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiIAT5d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Sep 2022 15:57:33 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD7D883E0
        for <selinux@vger.kernel.org>; Thu,  1 Sep 2022 12:57:32 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id c4so15544878iof.3
        for <selinux@vger.kernel.org>; Thu, 01 Sep 2022 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/SrktoBKCcMoJDlmi3XplWnSBJmgHBnePMuKYYG+Ccs=;
        b=qCc/jAtopS8JCyAdZdH6LqPMxuY7GvFdETRyrKn9PHNDuF12gPxCgP1cFDthOYwnwm
         xX090+Wl4mt22p4BXYTUp5TftvbBPzdCgkTOQmYO+QOl71WlfAb5ShYF5wV7UGVxvGNI
         ffDseqpBiAZ0mHg9e8pAhyK3uWON7+8FbrySk/BXACnOh0FkO4D25Msb1JguF8R4I/q7
         650gii9ee37Cz9eSGOmMCy6r+Dx3QKy65q/BIR/GQLeEiDI68dZq04ARQOTdfgGEvRoD
         aVeE3hwLkJYIwRzWbohcPnyG2K+eYiGeV640TMMWIUGHd1mCd0Z90FELs7CAtI0PS4AN
         7bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/SrktoBKCcMoJDlmi3XplWnSBJmgHBnePMuKYYG+Ccs=;
        b=17kMtzPCg+0JTVtAEZbpVKGpzhlOyer/dG+qZHfkilrgWgtJBXN1bkcIJufkMBA9l1
         mXaCoRSxLSve3/Vs/hJDUrq7P3qJAi6lusD4zjoVQY1TPDmCDZh+mA3YvHSyOczAmhmi
         OXEIrN7q6YWls/PYy2Jz4clEo7KGxUHVMOMsUVOMq30itkfMtlMww0UbsKNNMAwgSYkP
         x2poA1NUWeD+LRHxbbzGueqS+BNaU/KBBo72J5h4FeIHD9GXZxoW3aMUVbD2pGXWSeY5
         gxNjOPVZNz8gyn1c2TtNTvsVKIcu0mz8dswp9QA/G6U+4P+2C9jg1E87A9mq0oaGVy+7
         dS0Q==
X-Gm-Message-State: ACgBeo1BdJh/ZpY5UiwBbsl59X1syBZWxQJ4Gjdg18vh06M08sGZIHXi
        n+m8l53m3/EROQpdccZR+r4MsfAW8xZmlvSnTNZjnOmx
X-Google-Smtp-Source: AA6agR7zAnPy9eY1WLTGbcq6pVJWtYLLRf+mEkLKQmIQf87JO/yA0eNbOjS80hDN+tkA0muhTx+mJAs5MEpxr9g5QTs=
X-Received: by 2002:a05:6602:3cc:b0:679:61e7:3928 with SMTP id
 g12-20020a05660203cc00b0067961e73928mr16071515iov.217.1662062252306; Thu, 01
 Sep 2022 12:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220825132718.jnuxg7oqkmm3dx2l@jmarcin-t14s-01> <CAP+JOzR+47kdg9G7mO59XvWYk6JkbLd6W2geW6O-W7q3dH5VCw@mail.gmail.com>
In-Reply-To: <CAP+JOzR+47kdg9G7mO59XvWYk6JkbLd6W2geW6O-W7q3dH5VCw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 1 Sep 2022 15:57:21 -0400
Message-ID: <CAP+JOzS6fsimGf4bAL6J3EeNxbHmo+6m6h_+Y6G_1DA_T+O1Pw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix missing double quotes in typetransition CIL rule
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 29, 2022 at 2:49 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Aug 25, 2022 at 9:45 AM Juraj Marcin <juraj@jurajmarcin.com> wrote:
> >
> > CIL Reference Guide defines typetransition rule with double quotes
> > around object name, but those are not present in the format string.
> >
> > This patch fixes this issue, so the CIL output produced by
> > sepol_kernel_policydb_to_cil() is in the correct format.
> >
> > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
>
> Despite what the CIL Reference Guide says, the quotes are not
> required, but it is best practice to use them.
>
>  Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  libsepol/src/kernel_to_cil.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> > index 5a1336a3..ad4121d5 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -1894,7 +1894,7 @@ static int map_filename_trans_to_str(hashtab_key_t key, void *data, void *arg)
> >                 ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
> >                         src = pdb->p_type_val_to_name[bit];
> >                         rc = strs_create_and_add(strs,
> > -                                                "(typetransition %s %s %s %s %s)",
> > +                                                "(typetransition %s %s %s \"%s\" %s)",
> >                                                  5, src, tgt, class, filename, new);
> >                         if (rc)
> >                                 return rc;
> > --
> > 2.37.1
> >
