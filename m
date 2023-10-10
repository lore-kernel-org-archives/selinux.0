Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8421CD8CB4
	for <selinux@archiver.kernel.org>; Tue, 10 Oct 2023 19:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjJJTQD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJTQD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Oct 2023 15:16:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CE09E
        for <selinux@vger.kernel.org>; Tue, 10 Oct 2023 12:16:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5056ca2b6d1so194046e87.1
        for <selinux@vger.kernel.org>; Tue, 10 Oct 2023 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696965359; x=1697570159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq9AOrTO2gvb/P89CTQwaz0GBthP1ibMWgGJ7aJYwYM=;
        b=KTRPa+OsLke2TQ/w3nIZetJETQ6sx8u6dR+EF/5++Z1cENpNf88rHzOeU0nsO4GesN
         B3ZWLTQdpglHT6WI4Ci51yLr2Wz6pQ3IvRoj+pO8+ZtMsh7KiJ44nld7j2ncauxJ597H
         sUHjFZRGiMTlJ23Ura1mFZGfturMyCmzJcjI9+JEJl8U61OpqnMt5eBOQljF1K5VOGKD
         JjTvngygZqNOlW2H3CkvCdP1TcJs9K16kMiLNzJvdxVLND8cvDu2/xMZ4szvqnB5uc9D
         88Dbn/XKaSxdmrFQq/UIPyS00iIVMiC2nq61pVT46wef0m3/JBEncW/KXniDA19L7lvv
         kBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965359; x=1697570159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq9AOrTO2gvb/P89CTQwaz0GBthP1ibMWgGJ7aJYwYM=;
        b=nuf7BUETAYOHlLbegm97WU5HheKAgVbJcJXWp+WXauWcDrE0QQqVN3CMje6vl7MT+g
         DQLNX2Uf6tBjQ+Rwo6oxKnjhUlVvECGVvDZufvLCefY6J4Z816u76IO6OlkkR/GVzFPn
         C6JKGFXO2/1cJNEubSM9FTqvn1yRhp6ie8coF//ZfaA9wLoPGao325y3sNj/OgyF6Ch7
         SXMP4CHjhZt0eqNHv9XfrfZ6vHmOfL40kJqIUTrHOOEwRXlA0ou/ghJ7Z1sD+MKSzazq
         fsnfs9m0TfAe54IFZ7tOYYg5Q4nxLOo3SA2b8ZPt7/4ZLhFf4O+O6VN0UY/Rwre2zcC8
         EEEw==
X-Gm-Message-State: AOJu0YyPoh8qsoIiVj0CqB2F6y5/AyVzp/7IvHIz45o4N4wgXQjUxGCP
        koFgLcvY5IC3zfaIEPZpFu6Av4NqNvQZehEGs8Tli/3Oh8g=
X-Google-Smtp-Source: AGHT+IGO/x8of5gSNxCuzsyaUuI8H4WvDZI6ZkBtH2q6ppo/cZTueS7eXyUjZf5QRBUi1kdVJSGgmmekpjMSkWOmQmg=
X-Received: by 2002:a05:6512:3caa:b0:500:af82:7ddc with SMTP id
 h42-20020a0565123caa00b00500af827ddcmr11034321lfv.28.1696965359109; Tue, 10
 Oct 2023 12:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-20-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-20-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Oct 2023 15:15:47 -0400
Message-ID: <CAP+JOzSaSUuZJjEv0HC+SC_ZJMr=GRqOMa87QhFaRjp=ZHY-5g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 19/27] libselinux: avoid unused function
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Define selabel_subs_init() only if its call-sites are enabled.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_file.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index f9f4648a..471fd56b 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -674,6 +674,7 @@ static char *selabel_sub(struct selabel_sub *ptr, con=
st char *src)
>         return NULL;
>  }
>
> +#if !defined(BUILD_HOST) && !defined(ANDROID)
>  static int selabel_subs_init(const char *path, struct selabel_digest *di=
gest,
>                        struct selabel_sub **out_subs)
>  {
> @@ -756,6 +757,7 @@ err:
>         }
>         goto out;
>  }
> +#endif
>
>  static char *selabel_sub_key(struct saved_data *data, const char *key)
>  {
> --
> 2.40.1
>
