Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01837C001DC
	for <selinux@archiver.kernel.org>; Thu, 20 Jul 2023 20:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGTUWA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGTUV7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jul 2023 16:21:59 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5120271C
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 13:21:51 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-403c6a0f3aaso10743251cf.2
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689884511; x=1690489311;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4Sfe5Mrn930JlcyLKLnmbZvBMtHPPh5Pz03h2TZaeg=;
        b=ZaPf5/oFix7Sj5lQ0vH4hxMJscvWCWW54709Yk5gh0ydtAEVSbXpECo5SuzMGQDHdx
         1TyspXaDwCnt8CniVTMGts3flCl2hsETd9e1aX+cMN8HD+jZahx5QXokfDWhw+581yGH
         YcdRbqQIndZ5x7u5juWHTdp6aHonvR7Kdedf+sEub3K1P8N5JhJa3IEb709ssqzDH0m9
         EDeTomIxELUiWqVI7L7OWFo/l8Akx8vqlM5rQjeheCFWu0JYmwkQMbSbdP5kRh2wGMY7
         Ge7ApKpTMS0fej++uC2R5/zb65lRXqu6gCESmjDr6Ra7GC5MvdtHlg1R+55UGKL5OhJt
         3zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689884511; x=1690489311;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4Sfe5Mrn930JlcyLKLnmbZvBMtHPPh5Pz03h2TZaeg=;
        b=BfTRAcjdfiCJ+pNbXwXfbgkYFxrqkhRr+l8zlBpO3x1BYCyNwZw9J2OqSwZ+L32lsW
         X6A5ENHa3vS2rsSILzcKmPadyCxdmMNJ5/fQxpXATaArTzCMzaCvP3L7GZbaNi6opRZu
         zziHHQwkWz99YoQpSla9wLEOSahlQHO3eHzeDdSiL5n1ESKYOpyzirdN0NqPcjnZcLfl
         OpvytCWFDuQ8KFbQhtCuS1Zudqw35ti2YRTPmaQ9isJuam6+8HFJ1ThrGroHuHqoZ2IQ
         zgJld6q5UHq0QS6kiOcu7RH7HwPT8ALcRb5Agb24SEltCnwnXYa9fl9pLy2GPPEtukbW
         FlKQ==
X-Gm-Message-State: ABy/qLbJioAtgA4CZzWcD44MZ19pO+LpN8p5ttjZyN5NULOmB4TitD5n
        Gv/XZ7DZ929S4w4WBHnraffSqmR/IfChzrbkJA==
X-Google-Smtp-Source: APBJJlGdxvzfWNt+HLqy4TzkMKMfdoGhWK1XOT7aOU1tQHS79ei7ftEVTnWfbq19nP/NK5K75f3aMQ==
X-Received: by 2002:ac8:7dc1:0:b0:403:3048:b98 with SMTP id c1-20020ac87dc1000000b0040330480b98mr190000qte.34.1689884510991;
        Thu, 20 Jul 2023 13:21:50 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r26-20020ac8521a000000b00402ed9adfa1sm675819qtn.87.2023.07.20.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:21:50 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:21:50 -0400
Message-ID: <5ec875c70a55ac6b086cccf5a06db703.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 2/3] selinux: move debug functions into debug configuration
References: <20230718184921.112786-2-cgzones@googlemail.com>
In-Reply-To: <20230718184921.112786-2-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 18, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> avtab_hash_eval() and hashtab_stat() are only used in policydb.c when
> the configuration SECURITY_SELINUX_DEBUG is enabled.
> 
> Move the function declarations and definitions under that configuration
> as well.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c   | 2 ++
>  security/selinux/ss/avtab.h   | 3 +++
>  security/selinux/ss/hashtab.c | 3 ++-
>  security/selinux/ss/hashtab.h | 2 ++
>  4 files changed, 9 insertions(+), 1 deletion(-)

...

> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index d6742fd9c560..0ea1ee9d4dae 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -92,7 +92,10 @@ int avtab_alloc(struct avtab *, u32);
>  int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
>  struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *k);
>  void avtab_destroy(struct avtab *h);
> +
> +#ifdef CONFIG_SECURITY_SELINUX_DEBUG
>  void avtab_hash_eval(struct avtab *h, const char *tag);
> +#endif

Let's do the usual dummy function here so we don't have to use the
CONFIG_SECURITY_SELINUX_DEBUG more than we have to ...

#ifdef CONFIG_SECURITY_SELINUX_DEBUG
void avtab_hash_eval(struct avtab *h, const char *tag);
#else
void avtab_hash_eval(struct avtab *h, const char *tag)
{
	return;
}
#endif

Please do the same for symtab_hash_eval() too so we can get rid of
the #ifdef in the callers.

> diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
> index 043a773bf0b7..7836c0995871 100644
> --- a/security/selinux/ss/hashtab.h
> +++ b/security/selinux/ss/hashtab.h
> @@ -142,7 +142,9 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
>  		int (*destroy)(void *k, void *d, void *args),
>  		void *args);
>  
> +#ifdef CONFIG_SECURITY_SELINUX_DEBUG
>  /* Fill info with some hash table statistics */
>  void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
> +#endif

Same thing here.

--
paul-moore.com
