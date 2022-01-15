Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BED2C433EF
	for <selinux@archiver.kernel.org>; Sat, 15 Jan 2022 17:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiAOR2N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Jan 2022 12:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiAOR2M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Jan 2022 12:28:12 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2ECC061574
        for <selinux@vger.kernel.org>; Sat, 15 Jan 2022 09:28:12 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id e81so17053760oia.6
        for <selinux@vger.kernel.org>; Sat, 15 Jan 2022 09:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXphx/FDvN0pXhVVpWiATFl+SmC4lLy7qMeswfFYNVI=;
        b=bBIR5AOwGUwNP+5+jr9q2QceJyzHuInZTM5VGswwlaDpBhVzp05apJwVTC1fXxj4r8
         KSKb/y31kQeYUKhceEQiaSutTfLCU6Hd4bsfqI/MJGF0iSlzhzxGnF6gyw2Zq/OO4pCG
         dXK+tdvKeB8+P3RF/GzjcGKjaiteHzseugDO2/VYj6SpnXn250fzzOo5Y7Vh3szuY1Wv
         EjgWBE21E0zifNh4RXIjpd0l6UwgqXuq5yMrBOuAGExyLiQK0K5Z5vis9i1QpPGG2Sg6
         FkLElrOe2VmpH6s8tp6cdbLuvIO8JNJwgAAmftIS+83Vn0MqIFnCMCyE9J1rZIvpQu0p
         eIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXphx/FDvN0pXhVVpWiATFl+SmC4lLy7qMeswfFYNVI=;
        b=I3Y4yuggQXdCf71hndLZCa/82+crcnjrOCIn8Wo2nf4sVsGz6rWiKnBvFvbd0x+YC1
         x5P6bkMCdKqtIkSfgMYhyQZ8jsFZZ5N3Cx8pT7d/fVzEv6Sa4pCyDNKBMxzFa+NSIg1+
         edx4QDOoPtaBrj7DO3Y0/4rbx7ZaCHgdFmgdEr1ImeznMngr31y20zRxlubRPdYCdhcd
         Pj1msoxH0KWdbZaHVy7Bm14qgrljznq5a+Jc293ikKqEwmaszYT3TOmUUmiTPwdcfEHQ
         lVSc4RjvZfund3sUcaWXh0rn8iTaVMdOQB6cuV7JGxkOyxQoH2fYCu60kGSa+OBOo5r6
         GCrA==
X-Gm-Message-State: AOAM530c3MNCOFSYEISL4TtVbuMeSdgjL+bo9m0QdXvMOHl0pT4UPKni
        2aVwkwodPoBmb+ZNESVSJhAp/MQi3rKYSwcon+r5uvMG
X-Google-Smtp-Source: ABdhPJxgXroXLVsy54onEiXzSg/PE7rjS9DhgnQSyJoJbp6KapAphKRheBHnqLHM1lUeNUhKQHmJNRcUtEtqf0q5lOw=
X-Received: by 2002:a05:6808:130a:: with SMTP id y10mr11969598oiv.32.1642267691397;
 Sat, 15 Jan 2022 09:28:11 -0800 (PST)
MIME-Version: 1.0
References: <20220113204353.185947-1-vmojzis@redhat.com>
In-Reply-To: <20220113204353.185947-1-vmojzis@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 15 Jan 2022 18:28:00 +0100
Message-ID: <CAJ2a_Ddp1jfsHSZq9FSOUL83yBmnuiWP2SOweFa=KRj5KL9w_A@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Strip spaces before values in config
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 13 Jan 2022 at 21:44, Vit Mojzis <vmojzis@redhat.com> wrote:
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
>  libselinux/src/selinux_config.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
> index 97f81a8b..99cd6124 100644
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
> +                                       buf_p++;

This looks wrong.

>                                 intptr = &require_seusers;
>                         } else {
>                                 continue;
> --
> 2.34.1
>
