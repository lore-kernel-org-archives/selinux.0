Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18C8C433DB
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 16:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843BB2245C
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 16:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbhADQcX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbhADQcX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 11:32:23 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8E1C061574
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 08:31:42 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id r9so26493292otk.11
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 08:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUjrt1rNDT0BTd3E7WU/61f8DpWjW0jF9UrkkN3R7Pw=;
        b=agibqpvSByisdSA/Ii02Ovmpsow6kfti5B89KQY7G+KBRJ8MRf3CN3pDacCCTlSMYa
         fQ9+27zZguRu8yXfOkpdmmOL1Y+Swhiciu5jhSI1s7ZuE3R2pMwP4G8w/7TI0g4V3qXP
         kA40B5AEN03xPUtBpKKCOdmIvxvoVGvV5eDG+64GCJNc3G96+nfKLCyMvnzQfnnR5LrO
         KOUnn4SdqvA4ya1YUZftnFB8dk6oW1HP9x/NfImmf8dZkJtKKNCmeIS1kugB8AfYFZ8z
         xECF5zRgu/qomsXYPTRvj85HVRe+FMMH3rnjvi+92CERburi4xxbaUu0LSgd1YYMswDV
         WcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUjrt1rNDT0BTd3E7WU/61f8DpWjW0jF9UrkkN3R7Pw=;
        b=AtHNyAwtGG/zqBrJJZj1yI/cIHKClav2cMpaxFUCLbwsmI4IohxfQlzr0uyDuEIxDH
         JwgU/24VF/YlLzHCm68K8CqqpMck7U3MIUfxQIEAQvBRPPCx41Lflw31IuONvNqJnrht
         IsPiLAkSKrHgOLxMU0H+DtJ6WyMFY8f6uwdOTn0QHsrFFyiP4QL28mkpLJZSWLEbDVM2
         7dKM30zauMIjWetDGsjYyv3vXWCgE+zaz0JA+JCAEjSjyrBUIawVgRoKY3/3jlv9Dxnd
         yyoVHye9b8XJG+M+SLRpTw4MgpDMW6JD979PHbion4IinztEGhtAwZvtjho9P4/phpKH
         yDkw==
X-Gm-Message-State: AOAM530aSgziabTGiXySRW4lUy9YglBcVv8hDw2uBt+XaBRK7eh3gwVn
        QXWUWtqj6CVh5cwM/7Avhac9CqrAy+X1ePr989N6jEze
X-Google-Smtp-Source: ABdhPJzHGxxjmXXhKX+U/QpS7/7vkxPyV5u+7iVVDZfnHrlmtRLNW9o+o3G8MFx1b6FkIFZ9R9D04mdARZPAv4+Kf7o=
X-Received: by 2002:a05:6830:1385:: with SMTP id d5mr24854847otq.295.1609777902372;
 Mon, 04 Jan 2021 08:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org> <20201230100746.2549568-2-nicolas.iooss@m4x.org>
In-Reply-To: <20201230100746.2549568-2-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Jan 2021 11:31:31 -0500
Message-ID: <CAP+JOzQcM03WUJ-Fg2LuLxzCGiagJnuyJozv7ed6f34vnKEKXA@mail.gmail.com>
Subject: Re: [PATCH 2/6] libsepol: ensure that hashtab_search is not called
 with a NULL key
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 30, 2020 at 5:10 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> While fuzzing /usr/libexec/hll/pp, a policy module was generated which
> triggered a NULL result when doing:
>
>     key = pdb->sym_val_to_name[sym][i];
>
> Detect such unexpected behavior to exit with an error instead of
> crashing.
>
> This issue has been found while fuzzing hll/pp with the American Fuzzy
> Lop.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/module_to_cil.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index c99790eb76e7..99360a9afdd0 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -3459,6 +3459,10 @@ static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
>                 map = decl->required.scope[sym];
>                 ebitmap_for_each_positive_bit(&map, node, i) {
>                         key = pdb->sym_val_to_name[sym][i];
> +                       if (key == NULL) {
> +                               rc = -1;
> +                               goto exit;
> +                       }
>
>                         scope_datum = hashtab_search(pdb->scope[sym].table, key);
>                         if (scope_datum == NULL) {
> --
> 2.29.2
>

This is a similar case as the previous patch. There are other places
where a check could go, but the check really should happen when
reading the binary policy.

Jim
