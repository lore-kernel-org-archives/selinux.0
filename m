Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A214FC433B4
	for <selinux@archiver.kernel.org>; Fri, 23 Apr 2021 16:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA660FE6
	for <selinux@archiver.kernel.org>; Fri, 23 Apr 2021 16:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhDWQzb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Apr 2021 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhDWQz3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Apr 2021 12:55:29 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBCBC061574
        for <selinux@vger.kernel.org>; Fri, 23 Apr 2021 09:54:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u25so18078574ljg.7
        for <selinux@vger.kernel.org>; Fri, 23 Apr 2021 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hRN7WoQ7nhgEaFcnyZFfKzEZdlwt3uW1mwU/l9lE7Fg=;
        b=iAc+HLJA4dqUVd/WvS0//zdfDB1Ilgx6jbzrwqpV+B/JVXXoGrY/AgHQR9luUHE/sf
         YYrOVtJ39l4ECJy+/YDBFL+6Zi5YuHqANGb9IJJf5ernZNMGILNRQtBHc/lZmSUlmplN
         rpiqCADhbl7vTJZJ+O8zozPmY1OUqh4n6Xr5M/jtluU/WMt5cNP89vo0mEAhYgk/8DgY
         0nelP9dodNjTVDNBZYXCkmm4BAMuUbrB/rFoXO4U8hPMIP3fFPehWc0V2CIsjof5fAdy
         nHhZsZLtK8mhuGlJ9e32FeKPmGis47z2RnzqWMCWtzEjGK2qVBrYqAFONpPD4gcvgX7E
         BNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hRN7WoQ7nhgEaFcnyZFfKzEZdlwt3uW1mwU/l9lE7Fg=;
        b=fWJe/rm5gKyJV874t9+ceDrt1s4rjU3CH46RinS+5Z9BzJQgEmdyIf4XYHziHkTJuf
         pyNG4agFYOlxDXniZeoNFt5me56owQBqAw/l49bvEia1m9rGR923l85ncNFvzfI7HF1J
         bR8QozM3vNtXC1ybuH5ZxIw0Ig61Xl094QAzjfJs1iyD5Klph+VOOOems0sq720rndil
         Pz/QtLxb7JrzxT9zbp4pDiQGp/gQWnFImdgz8hZRezknjhgsQfRHCfoBxUFh5RBKhQ6v
         5eH07uvREI/AwJGNjtNMUNEpCVvDVwQ/8U8a1aF0C2tdr+9XViuH+ziOx2xLPKh2KqZK
         p9Jw==
X-Gm-Message-State: AOAM532Urus+fZ0cVcEDJHnEikdqK87POqaEYd1Jl8oGtanT4PJXlw+s
        uJyESuCGRytth9XIcljj1o1TBBRs4NEB1ym/KuD+eT9Sp/c=
X-Google-Smtp-Source: ABdhPJwQVjZxo4ufwk0WcueK/5tCgjkDCaX8l3zvi3S4NzAFunFgaGP0cBvRsJqkvuEz8LaHsETXXgTquwsBk1MQrso=
X-Received: by 2002:a2e:9b50:: with SMTP id o16mr3414051ljj.8.1619196889477;
 Fri, 23 Apr 2021 09:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210423164209.482593-1-jeffv@google.com>
In-Reply-To: <20210423164209.482593-1-jeffv@google.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Fri, 23 Apr 2021 18:54:38 +0200
Message-ID: <CABXk95CdHm2RgqJZFQaZD+3ci22c=JpRX4Chs9AMSqdGDJKLWw@mail.gmail.com>
Subject: Re: [PATCH] libselinux android: Add keystore2_key label module.
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

NAK.

Apologies for the spam. I thought this was a clean cherry-pick, but it's not.


On Fri, Apr 23, 2021 at 6:42 PM Jeff Vander Stoep <jeffv@google.com> wrote:
>
> This patch adds a new Android specific module for keystore2 key
> namespace lookup. It assumes the presence of keystore_contexts files
> mapping numeric namespace identifiers to SELinux labels. Keystore 2.0
> uses this module to exert more granular access control and allow system
> and vendor components to share explicit key namespaces.
>
> Note that this patch was originally accepted July 30, 2020 into AOSP.
> https://android-review.googlesource.com/c/platform/external/selinux/+/1329357
>
> Original author: Kunal Shindea <shindek@google.com>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  libselinux/include/selinux/label.h      | 2 ++
>  libselinux/src/label.c                  | 3 ++-
>  libselinux/src/label_backends_android.c | 6 +++---
>  libselinux/src/label_internal.h         | 2 +-
>  libselinux/utils/selabel_lookup.c       | 2 ++
>  5 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
> index e8983606..95e9a9b0 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -37,6 +37,8 @@ struct selabel_handle;
>  #define SELABEL_CTX_ANDROID_PROP 4
>  /* Android service contexts */
>  #define SELABEL_CTX_ANDROID_SERVICE 5
> +/* Android keystore key contexts */
> +#define SELABEL_CTX_ANDROID_KEYSTORE2_KEY 6
>
>  /*
>   * Available options
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index a03192e5..dfc4e0bf 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -51,7 +51,8 @@ static selabel_initfunc initfuncs[] = {
>         CONFIG_X_BACKEND(selabel_x_init),
>         CONFIG_DB_BACKEND(selabel_db_init),
>         CONFIG_ANDROID_BACKEND(selabel_property_init),
> -       CONFIG_ANDROID_BACKEND(selabel_service_init),
> +       CONFIG_ANDROID_BACKEND(selabel_exact_match_init),//service init
> +       CONFIG_ANDROID_BACKEND(selabel_exact_match_init),//keyStore key init
>  };
>
>  static inline struct selabel_digest *selabel_is_digest_set
> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
> index cb8aae26..1cb83008 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -278,7 +278,7 @@ finish:
>         return ret;
>  }
>
> -static struct selabel_lookup_rec *service_lookup(struct selabel_handle *rec,
> +static struct selabel_lookup_rec *lookup_exact_match(struct selabel_handle *rec,
>                 const char *key, int __attribute__((unused)) type)
>  {
>         struct saved_data *data = (struct saved_data *)rec->data;
> @@ -333,7 +333,7 @@ int selabel_property_init(struct selabel_handle *rec,
>         return init(rec, opts, nopts);
>  }
>
> -int selabel_service_init(struct selabel_handle *rec,
> +int selabel_exact_match_init(struct selabel_handle *rec,
>                 const struct selinux_opt *opts, unsigned nopts)
>  {
>         struct saved_data *data;
> @@ -345,7 +345,7 @@ int selabel_service_init(struct selabel_handle *rec,
>         rec->data = data;
>         rec->func_close = &closef;
>         rec->func_stats = &stats;
> -       rec->func_lookup = &service_lookup;
> +       rec->func_lookup = &lookup_exact_match;
>
>         return init(rec, opts, nopts);
>  }
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> index 361b443c..fde55484 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -38,7 +38,7 @@ int selabel_db_init(struct selabel_handle *rec,
>  int selabel_property_init(struct selabel_handle *rec,
>                             const struct selinux_opt *opts,
>                             unsigned nopts) ;
> -int selabel_service_init(struct selabel_handle *rec,
> +int selabel_exact_match_init(struct selabel_handle *rec,
>                             const struct selinux_opt *opts,
>                             unsigned nopts) ;
>
> diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selabel_lookup.c
> index 1aef64de..b18e5fc6 100644
> --- a/libselinux/utils/selabel_lookup.c
> +++ b/libselinux/utils/selabel_lookup.c
> @@ -59,6 +59,8 @@ int main(int argc, char **argv)
>                                 backend = SELABEL_CTX_ANDROID_PROP;
>                         } else if (!strcmp(optarg, "service")) {
>                                 backend = SELABEL_CTX_ANDROID_SERVICE;
> +                       } else if (!strcmp(optarg, "keystore2_key")) {
> +                               backend = SELABEL_CTX_ANDROID_KEYSTORE2_KEY;
>                         } else {
>                                 fprintf(stderr, "Unknown backend: %s\n",
>                                                                     optarg);
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
