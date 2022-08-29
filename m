Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93331ECAAD5
	for <selinux@archiver.kernel.org>; Mon, 29 Aug 2022 18:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiH2SuP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Aug 2022 14:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiH2SuP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Aug 2022 14:50:15 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1934E23BFA
        for <selinux@vger.kernel.org>; Mon, 29 Aug 2022 11:50:13 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id d15so4974641ilf.0
        for <selinux@vger.kernel.org>; Mon, 29 Aug 2022 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SKi7gnIYWVqUYyXQQq9z8Yaz6iouE1I4dZjwMY+XfME=;
        b=pUvJf65rDcYRGckZDMQP6+Qle93ISyiQdY+QlltcTmsnL5J6Mub9YVEeuSeYAp8zL+
         DZJzOUe8bYTd2PJQ2iXpX62ctzBrPSE2xzjStrvwcqmwszNuX3ypFbHzHe8cZDMIDmo2
         gqqzEFCv20qXsVB+8YWocRqDuI9uLNV3WCMVBJ7ksI3+QvqhXk/T+03iYLISVqZJTqFn
         2B2RxpZn7HNkdiaUIR4em5PIcTmKnk7qSTaHeRU8V0ioJA11OvgwNWZ6BzaNkQKTDdna
         AH4sEuIPOkuRLQ98EMZQI69hu1IlA9Uhgb+ynDVyRcdb9idfmA9X3RwZeuyg5kZzaEYk
         5cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SKi7gnIYWVqUYyXQQq9z8Yaz6iouE1I4dZjwMY+XfME=;
        b=qWFAmuRbQfZ9EQ1k2OvkI7Avoek8Vn348QxNVcHBkB8OCZup6FnuAlWjWqFPTF0Fji
         5T16N3AQIPvGJewyCUk2JO7Wjxl8tjX6Ux5Ovwz8GFXMI0cXDeWvU1UKXUbbI/kLys1J
         w1qOQObJBC8+OcRry2tQcqDLwv1ewGUz8Gi3rgqq95kv+9GNYu/BbjAkIWlB64s9X+FD
         V+feBVn/yt8AZu8BsENOqo/3hXF1SnPhre5p6j5hWm/eeyXdid5Ghkw2rxfKk7puv0ao
         ipPs58lif7uyFXM+OwX/CoFtnAPyZoSq3yJNB1pYLpRDCaFFykdP7axHwgSKbRkuMZsj
         kyMg==
X-Gm-Message-State: ACgBeo3/7dgM/siVb/Q1C/jOIo/ANWWtFJlKir1mJqw9haIGLz46CRwM
        STmoeYFOlQhdPifTmjm3PUPR8uUBx8UWtVnb+8M=
X-Google-Smtp-Source: AA6agR6ISxHnRicjRYjy5nAyJnXxsPRLNmyXMqFXW6y/7sdvZsymYseF1ZLqjnrlGz9JNKeZW+sZexHGLKRrx00WROw=
X-Received: by 2002:a05:6e02:214f:b0:2df:aa4c:631f with SMTP id
 d15-20020a056e02214f00b002dfaa4c631fmr10897748ilv.147.1661799013325; Mon, 29
 Aug 2022 11:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220829122840.qbxef3urreybaqxm@jmarcin-t14s-01>
In-Reply-To: <20220829122840.qbxef3urreybaqxm@jmarcin-t14s-01>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 29 Aug 2022 14:50:02 -0400
Message-ID: <CAP+JOzRV0++Dnut+HMSgrOYU0OJ81_qPunTsXdL0aKmMsRVNMw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: avoid passing NULL pointer to memset()
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 29, 2022 at 8:49 AM Juraj Marcin <juraj@jurajmarcin.com> wrote:
>
> Function `class_perm_node_init()` is called with `dest_perms` before it
> is checked that its allocation succeeded. If the allocation fails, then
> a NULL pointer is passed to `memset()` inside the
> `class_perm_node_init()` function.
>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index f3b48870..54bb304b 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2371,11 +2371,12 @@ static int avrule_cpy(avrule_t *dest, const avrule_t *src)
>         src_perms = src->perms;
>         while (src_perms) {
>                 dest_perms = (class_perm_node_t *) calloc(1, sizeof(class_perm_node_t));
> -               class_perm_node_init(dest_perms);
>                 if (!dest_perms) {
>                         yyerror("out of memory");
>                         return -1;
>                 }
> +               class_perm_node_init(dest_perms);
> +
>                 if (!dest->perms)
>                         dest->perms = dest_perms;
>                 else
> --
> 2.37.1
>
