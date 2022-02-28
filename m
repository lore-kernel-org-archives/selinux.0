Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA53AC433F5
	for <selinux@archiver.kernel.org>; Mon, 28 Feb 2022 20:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiB1UXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Feb 2022 15:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB1UXu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Feb 2022 15:23:50 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21F855BE8
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 12:23:10 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id k2so14334980oia.2
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 12:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bsOf8VtTkyahwEj0mXr8eO9j4D2bGDWUSjxgSLi9OM=;
        b=HqVXuLy+zIcTZJ4x66kkOCG1YbqwJspdBuKwaxmU1HJYi7Xx7M7sREsNMkowg6RwvG
         G6gRLBexIIHg3KuTVEmHt84J6gM2MlMUXZ+jIpcUglFIcY1PW+OW3uQbmM7o+uFmCyws
         D7VxBsbO4LcmrEldHSuK1fguWmSGn26QE+kwjCuUH3yYXcQhMH2d++ksqB7rXBu/rZ2N
         NUmu2Cbj6aNEuughPcvYrf4iHE6/3ZCZH4S5DBBDr3ebr1iH4EajfCUC5j6rHm6pI12O
         Mh2ok98QAxv8ytNhS8QhcraGPc70VuP1x/4vRMwMPz1v/zDSG6XScgqolClkXuHVEf7E
         qH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bsOf8VtTkyahwEj0mXr8eO9j4D2bGDWUSjxgSLi9OM=;
        b=qotR+rTj0DwysXBNxsJqsPcJVqMhPBKJ1W+F32UbiWQagYaFvBaN+KtFZzVL0RQTBS
         5j5yeWNgJSXfI2723WDixr/T0Kdl0lXYuNb7YXtvk5Bz+i1D+NWcJP+27FDEdom7yzS3
         dbnX17Yd179qgvqdgqb/vCI9hYKpFDmx6KKcbVZV5/AdXyS5QAasOW4MJ91LysQI14nD
         Fmma23NY62bhMyb0HX5bxGwC4Cai8Huk0yxq+PhB0kSrpd69DtxDf+fUlw0P0g2MNelA
         HVoU0qok437grGsklwmNdXkoyhbjnd99mkOT2rJ1Yi0VWoRZnlQXQI4mRvBKixJzZTNH
         gV8A==
X-Gm-Message-State: AOAM5333LLgdJB1v8V7RYbI8SWyRjCGm+AaYQoC/WN9zQRY8D6EBB/wb
        63xoSF7mqHQQkHn9QgHxtP0FD4R/uuE2Yr30RCpdNrHo8AY=
X-Google-Smtp-Source: ABdhPJzMzf0zQK8npDVpZmxp8JOrdNHqTTypBIP98RpIn1kjxBH04e9ZDQ5Qss92+R/usyNTJp6CYlD+F1e9kVfkXyo=
X-Received: by 2002:a05:6808:150e:b0:2d4:d2a5:85ff with SMTP id
 u14-20020a056808150e00b002d4d2a585ffmr10190402oiw.16.1646079790195; Mon, 28
 Feb 2022 12:23:10 -0800 (PST)
MIME-Version: 1.0
References: <d7cf167d-1c12-5486-336e-1689c5223631@redhat.com> <20220217131415.1195383-1-vmojzis@redhat.com>
In-Reply-To: <20220217131415.1195383-1-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 28 Feb 2022 15:22:59 -0500
Message-ID: <CAP+JOzSX3iLRQgOEwzt1uXEV=--r77n4bUFLT6uPHeFTp=vGjQ@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Strip spaces before values in config
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 17, 2022 at 1:24 PM Vit Mojzis <vmojzis@redhat.com> wrote:
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

Acked-by: James Carter <jwcart2@gmail.com>

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
