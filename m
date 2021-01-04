Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC06C433E0
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 16:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1598C207BC
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 16:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhADQo0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADQo0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 11:44:26 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E994C061574
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 08:43:46 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id x13so26547930oto.8
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 08:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFbYn7QZRZBW8INAyw7JPdN/hzySgBJ081n7o36gr5Q=;
        b=iVpSXI1liyQoAJc6znhGEKdq8CkEIOpyZCGMxCelqJRHDYkL4d1ZLi6u0Qn4RZZPrU
         MLdF74DOjbr0sQyz+NDX2TjC4jHlWGb5Ck6pxe4aIKnq2KqIOTZaMglmw19V/2MYPXGJ
         rY4G8KV4JvXjDAwiiFKqZ2+9HvQUmelxanJZQ5Bh0NHchTNV62GowPkt5SwH8MGy/Bjj
         snmxuTDL2ZM3B+cJ/+KrGC/wt40Iji6nCt3apEdj+WHjE0dDmOI22ALN/q9hiZOUZfrv
         KYcv6QI4ZTKo9tKMLTr5/nXq+JIgVCMuqwjVm9ysofM8YqIhYmPL49n0c0LlOHsDpHJK
         pPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFbYn7QZRZBW8INAyw7JPdN/hzySgBJ081n7o36gr5Q=;
        b=I7ROzVA1OQ5MfINfk5Ms2OleHWNvXXrjSLkXpj6tGrCXfHtmBxGFAEjDotprG59WLP
         AwkMaSdflk3n6VTEv4mtWixU+R1rX1cEt3hh5X7BZv3sx46NATGZWmfEnBUpQMVnAt3m
         5+cXb+WoaTtA4Hb/7gegTKy7kJUGHfRjwRi4pKDdfWXRa0SOhy4WWAnNiQXnaFkN6TDy
         kEeYIarAXEnd3k6zxDoIKuygkhZ390S9iEIrTZm49LYsK0ZG4xbHCYKLW7W/ZpTuqlhD
         /LNAfs1SwK/S8B3puqMCc+o6kCivdKedI6HuIfXTnP/KATCyxuJYlR4+JpKWDW0cI/tm
         9+yQ==
X-Gm-Message-State: AOAM531Wp+TMGL+8jv+Z8SnOazuJXLiKu8OScJHr10lgoqlNSOZJf1cJ
        ZjxsQLr8WkxY86GD+x1bTMV+i4IviYdY9YbMbDY=
X-Google-Smtp-Source: ABdhPJzFV82RtG65cXqxA/CX9d2Ylh8nit032ilyNoXrlSq2/IL2NGIbFg0EjZPd0EaPD5J8Eye6IuS2pP09dm5+UuQ=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr51691599otr.196.1609778625672;
 Mon, 04 Jan 2021 08:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org> <20201230100746.2549568-4-nicolas.iooss@m4x.org>
In-Reply-To: <20201230100746.2549568-4-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Jan 2021 11:43:34 -0500
Message-ID: <CAP+JOzROWvSkvB8rYEJmJv9VGrrFkWUM7=T96hGbuBwhRNq2OA@mail.gmail.com>
Subject: Re: [PATCH 4/6] libsepol/cil: fix NULL pointer dereference when
 parsing an improper integer
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 30, 2020 at 5:09 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> OSS-Fuzz found a NULL pointer dereference when the CIL compiler tries to
> compile a policy with an invalid integer:
>
>     $ echo '(ioportcon(2())n)' > tmp.cil
>     $ secilc tmp.cil
>     Segmentation fault (core dumped)
>
> This is because strtol() is called with a NULL pointer, in
> cil_fill_integer().
>
> Fix this by checking that int_node->data is not NULL. While at it, use
> strtoul() instead of strtol() to parse an unsigned integer.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28456
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_build_ast.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 67801def0dc0..0c9015cef578 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -5566,15 +5566,15 @@ int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base
>  {
>         int rc = SEPOL_ERR;
>         char *endptr = NULL;
> -       int val;
> +       unsigned long val;
>
> -       if (int_node == NULL || integer == NULL) {
> +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
>                 goto exit;
>         }
>
>         errno = 0;
> -       val = strtol(int_node->data, &endptr, base);
> -       if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
> +       val = strtoul(int_node->data, &endptr, base);
> +       if (errno != 0 || endptr == int_node->data || *endptr != '\0' || val > UINT32_MAX) {
>                 rc = SEPOL_ERR;
>                 goto exit;
>         }
> @@ -5594,7 +5594,7 @@ int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int ba
>         char *endptr = NULL;
>         uint64_t val;
>
> -       if (int_node == NULL || integer == NULL) {
> +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
>                 goto exit;
>         }
>
> --
> 2.29.2
>
