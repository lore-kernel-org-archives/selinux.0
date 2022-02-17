Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA590C433F5
	for <selinux@archiver.kernel.org>; Thu, 17 Feb 2022 14:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbiBQORG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Feb 2022 09:17:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbiBQORF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Feb 2022 09:17:05 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AD3C0867
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 06:16:50 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so6731171ooi.2
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 06:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJYrPn3rjTT9kKnTJEycbfosMRkI2EAD4D1emgWP4NY=;
        b=oaY+Mt+r+7ylerTciL0PCOYxQVYnQMB2R2LSIrYB7KOGH9kxn3VZdSsBLRo2t7SWpu
         Vnmiuz9wfJneFC//Smn+lQyddUpQOToQMrOI3//UyiRcYzM8faJMTTh5YpPNy5lRZLPC
         C0OemeAfGpr7nEdBxb1hP5C7Lrb9thP8c5wS5KO1xQ1GKG8vhbl0XrPfvBH54fRfztdX
         14Ns2+7Pvbtp9LjKN8GJuM3OYqrFRrAbQWHquKQ3CA/e/07uOgE7wy1EWM+yzSdIxsGT
         blXTSIo86A7pS69vxWeo7Rfk12blIq0Qmg1zGnYv8pCyHEB/4EMqL0LMGSM3+WSpJxjo
         EW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJYrPn3rjTT9kKnTJEycbfosMRkI2EAD4D1emgWP4NY=;
        b=vDf//8JaLNxdS0BXr//IbQ6Xeg739r/rlrnwkigLFU6zHa3C7gjggqy+4WmQbV4F4c
         HHOc3LsSerFGZ6GaPHmR1bk3/tMMYfYw6TJiicPpJ8jW9eD5lMFei4MnRWMrMGvz2pl9
         MEw/+39PZK4v5cJM8ztFwCMuvuROEnVGq5dysxmkm7lnnpU0r/XfBVH3xywv8uZ6oADW
         i5RkWHCfe+lHK+p+sa/QX4a1sUL5k+r7zu0rVxj+J6lSbtjiL4eCYUCKjuqWorSgucsv
         4S8wXnNrfkXW7x/ruLgCfyv4s6h7cMg6G3i64YOR+TuojbJizR4Ftyzm8W5dSYq9PcY9
         TqTw==
X-Gm-Message-State: AOAM532Ri06GjlTW+8knADmTkMxUK/woLWV+hpI3HMRJ4yYvFIVbIsEP
        0MDY1xrYbV1MvSn4vwIB3kNwGlRdAgu7ZI4fkcI=
X-Google-Smtp-Source: ABdhPJxPAv5tj/GbN3G5hXN9SBoEmcidlmnqIV7eJBM9gEioXY0ZirZ9/hDvTIf3MFJZEJ20anpBg8H0fbQaZfGyOyE=
X-Received: by 2002:a05:6870:772e:b0:d2:8c2a:7c75 with SMTP id
 dw46-20020a056870772e00b000d28c2a7c75mr2230600oab.202.1645107409592; Thu, 17
 Feb 2022 06:16:49 -0800 (PST)
MIME-Version: 1.0
References: <d7cf167d-1c12-5486-336e-1689c5223631@redhat.com> <20220217131415.1195383-1-vmojzis@redhat.com>
In-Reply-To: <20220217131415.1195383-1-vmojzis@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 17 Feb 2022 15:16:38 +0100
Message-ID: <CAJ2a_Df=pjCN_Cs1EN_bk1wF_XFuqUVhB_5vjH0oiqCG=xWbKw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Strip spaces before values in config
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 17 Feb 2022 at 14:14, Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Spaces before values in /etc/selinux/config should be ignored just as
> spaces after them are.
>
> E.g. "SELINUXTYPE= targeted" should be a valid value.
>
> Fixes:
>    # sed -i 's/^SELINUXTYPE=/SELINUXTYPE= /g' /etc/selinux/config
>    # dnf install <any_package>
>    ...
>    RPM: error: selabel_open: (/etc/selinux/ targeted/contexts/files/file_contexts) No such file or directory
>    RPM: error: Plugin selinux: hook tsm_pre failed
>    ...
>    Error: Could not run transaction.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>
> Sorry for the delay. I sent the fixed patch to a wrong mailing list.
>
>  libselinux/src/selinux_config.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
> index 97f81a8b..d2e49ee1 100644
> --- a/libselinux/src/selinux_config.c
> +++ b/libselinux/src/selinux_config.c
> @@ -92,6 +92,7 @@ int selinux_getenforcemode(int *enforce)
>         FILE *cfg = fopen(SELINUXCONFIG, "re");
>         if (cfg) {
>                 char *buf;
> +               char *tag;
>                 int len = sizeof(SELINUXTAG) - 1;
>                 buf = malloc(selinux_page_size);
>                 if (!buf) {
> @@ -101,21 +102,24 @@ int selinux_getenforcemode(int *enforce)
>                 while (fgets_unlocked(buf, selinux_page_size, cfg)) {
>                         if (strncmp(buf, SELINUXTAG, len))
>                                 continue;
> +                       tag = buf+len;
> +                       while (isspace(*tag))
> +                               tag++;
>                         if (!strncasecmp
> -                           (buf + len, "enforcing", sizeof("enforcing") - 1)) {
> +                           (tag, "enforcing", sizeof("enforcing") - 1)) {
>                                 *enforce = 1;
>                                 ret = 0;
>                                 break;
>                         } else
>                             if (!strncasecmp
> -                               (buf + len, "permissive",
> +                               (tag, "permissive",
>                                  sizeof("permissive") - 1)) {
>                                 *enforce = 0;
>                                 ret = 0;
>                                 break;
>                         } else
>                             if (!strncasecmp
> -                               (buf + len, "disabled",
> +                               (tag, "disabled",
>                                  sizeof("disabled") - 1)) {
>                                 *enforce = -1;
>                                 ret = 0;
> @@ -176,7 +180,10 @@ static void init_selinux_config(void)
>
>                         if (!strncasecmp(buf_p, SELINUXTYPETAG,
>                                          sizeof(SELINUXTYPETAG) - 1)) {
> -                               type = strdup(buf_p + sizeof(SELINUXTYPETAG) - 1);
> +                               buf_p += sizeof(SELINUXTYPETAG) - 1;
> +                               while (isspace(*buf_p))

Strictly speaking one should cast to unsigned char to avoid UB, see
[1], but that
seems to be not done in SElinux userspace as

    grep -REw "(isalnum|isalpha|isascii|isblank|iscntrl|isdigit|isgraph|islower|isprint|ispunct|isspace|isupper|isxdigit|toascii|toupper|tolower)"

shows 87 usages.

[1]: https://wiki.sei.cmu.edu/confluence/display/c/STR37-C.+Arguments+to+character-handling+functions+must+be+representable+as+an+unsigned+char

> +                                       buf_p++;
> +                               type = strdup(buf_p);
>                                 if (!type) {
>                                         free(line_buf);
>                                         fclose(fp);
> @@ -199,6 +206,8 @@ static void init_selinux_config(void)
>                         } else if (!strncmp(buf_p, REQUIRESEUSERS,
>                                             sizeof(REQUIRESEUSERS) - 1)) {
>                                 value = buf_p + sizeof(REQUIRESEUSERS) - 1;
> +                               while (isspace(*value))
> +                                       value++;
>                                 intptr = &require_seusers;
>                         } else {
>                                 continue;
> --
> 2.30.2
>
