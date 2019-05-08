Return-Path: <SRS0=Lq8N=TI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E9AC04A6B
	for <selinux@archiver.kernel.org>; Wed,  8 May 2019 21:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05F4216C4
	for <selinux@archiver.kernel.org>; Wed,  8 May 2019 21:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="s8EKkXL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfEHVvj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 May 2019 17:51:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40119 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEHVvj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 May 2019 17:51:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id h13so20905lfc.7
        for <selinux@vger.kernel.org>; Wed, 08 May 2019 14:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGx6KHIdvVgAosWSvFXiq3p9X8Kwru6KrU5FeTp7SP4=;
        b=s8EKkXL+OVJPSGeb3y4ECb8qw4M1ABliDuHy9IzwqnOnv0SNFRt338KxzArLk874Ns
         0dYU547Wr4IeZY4Da6MmJd+fTAVnrkXMMVt2cvGh6TpUDzaPi1PRMRK/e7L4SY2wm/fx
         KsLZx0q1wm7UMTVabyXACNnnSq+ZHWL692/O22gAq2Sq4DR2W2IpRcFFn1Yg31hLkCTT
         tweeHSxvLQ0B2b0bbXsGQImV13WeYJRb5UNdDpbni+rVDuDa7/fayym3mHOVytX/YURQ
         2Oh38mVd/Ajy2MVncCL9g9S2XMpfSVQiebvqRvqz9B2cr7ZIquLc12CpGnr51/A0Xv09
         zg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGx6KHIdvVgAosWSvFXiq3p9X8Kwru6KrU5FeTp7SP4=;
        b=h238f/G9LbjOpS6dOFanG7iUaFy/pJidwHYXsDvaxaHnUtKmsJ97ZI2id4VtAsrq/2
         9mvXUbFBrHrKEupYIXQL6IXrS7zotdzJ+ckyVf2DspYALzM3sncT/FXtuYsRfTOrPylr
         a2WSsPt/xGAzHFeQ9eVrjRH5Lzi+LHJsFZ8o6M5eLGdAb8SCNgMReCnSNNZKs0ZVDMMX
         +geV5LjjPeLt4uWt3w0YeFGylltt2gezPpgxBx5UMWpdVDrf3Y9e2CtmXJfr75XOLPPw
         YTvqThXlaDOG6lobEugG3vszU4xUHpq8SpsH8kIrth9rzyVqzn0BuuaBsJV8+uDucI+W
         WOCg==
X-Gm-Message-State: APjAAAV4ZDoW+Qt7z33BnmZrf1OGpPoIQ8i2AdEZ7qlpj+6rg+kKc5jq
        jU1i+fAOohLcYrkapYCiQb+1mTDmLU0O3AEL6PO1DJieAw==
X-Google-Smtp-Source: APXvYqxCe/oYScohU9pkYV5cSR+URxqAqWwolH0LYkpc5ik1Ony8lNEjGGDZB/+RXIltIyvTJQb0i13pg3qI7c2yj9E=
X-Received: by 2002:a19:9e47:: with SMTP id h68mr196145lfe.91.1557352296899;
 Wed, 08 May 2019 14:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190504195906.8146-1-omosnace@redhat.com>
In-Reply-To: <20190504195906.8146-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 May 2019 17:51:25 -0400
Message-ID: <CAHC9VhRwsNuDhN6y8Lx38TYPFW3WDr7TP3J2t5XAy9jqgFq=gw@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove some no-op BUG_ONs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 4, 2019 at 3:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since acdf52d97f82 ("selinux: convert to kvmalloc"), these check whether
> an address-of value is NULL, which is pointless.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/services.c | 4 ----
>  1 file changed, 4 deletions(-)

This looks fine to me, I'll queue this up for after the merge window closes.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index cc043bc8fd4c..20a089d0aca8 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -651,9 +651,7 @@ static void context_struct_compute_av(struct policydb *policydb,
>         avkey.target_class = tclass;
>         avkey.specified = AVTAB_AV | AVTAB_XPERMS;
>         sattr = &policydb->type_attr_map_array[scontext->type - 1];
> -       BUG_ON(!sattr);
>         tattr = &policydb->type_attr_map_array[tcontext->type - 1];
> -       BUG_ON(!tattr);
>         ebitmap_for_each_positive_bit(sattr, snode, i) {
>                 ebitmap_for_each_positive_bit(tattr, tnode, j) {
>                         avkey.source_type = i + 1;
> @@ -1059,9 +1057,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
>         avkey.target_class = tclass;
>         avkey.specified = AVTAB_XPERMS;
>         sattr = &policydb->type_attr_map_array[scontext->type - 1];
> -       BUG_ON(!sattr);
>         tattr = &policydb->type_attr_map_array[tcontext->type - 1];
> -       BUG_ON(!tattr);
>         ebitmap_for_each_positive_bit(sattr, snode, i) {
>                 ebitmap_for_each_positive_bit(tattr, tnode, j) {
>                         avkey.source_type = i + 1;
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
