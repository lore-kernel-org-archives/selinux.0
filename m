Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47959E784BB
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 14:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbjJBO6o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbjJBO6n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 10:58:43 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8654E8
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 07:58:39 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c4b9e09521so9246043a34.3
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696258719; x=1696863519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vZ+yqj5xq3wAYansvU0EXY6axrOXaj8DSoKvpjecW4=;
        b=LBVEgLvG6hPY3kM8Of/zBNuV10WnRKIzZdZdYGINA0z46n8QkcZ/Cw6dLXi9U8X1uG
         zoP5uO4csBtPBl2+yZQ/BWoEgZd/6j59cqPvXjQ3LPvXFgA0Py3eNUOiZwQjtEcga7bs
         VzdW9nzrog78pMtuvjoRjRGDCC5ZjJhEoRbNR+aiRe8aQR+Q+oyEvmNVBrrfirlKPG1F
         vkpLaCxqx+9ysjZgunBNG/zI+xGZa8tNGKTakHzrOZdMrHjR3I7QZAykMtupspCgku5/
         zFRpyGYFDp7lHPm53o3bQsUtxGVdQG+rcAvC5xsbgvzP20BZ5+SyauAsTrl46sPwb1VB
         FAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696258719; x=1696863519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vZ+yqj5xq3wAYansvU0EXY6axrOXaj8DSoKvpjecW4=;
        b=Dxnb/W1egcE117P064QfMIGqprytyApd/1bF9PjKmVV8POwbfn4wArpEVAvrq1aFQz
         NXg81J2Uy6IQhWpEgi7tDyuw1EyZz2fiiKuY52o8CUR1zG+6WjKuvE3xosopvG3k2I5t
         SY5KHorMjEl5MFLA2PEw6XgUytLIo9QC/bmMCdlcTxi0nIxYFcBmc/3BToTnitg/bV6M
         yPhOAL95XwDBSGY+TtipN904U4Qo75GvJElMwt5y4PVMy2mpICDGM5yqsuh+wSuezeM1
         GyhD4GHNO8yRF6eH0CcScgZnfi2Zyn8EzGPAJvQW2e3kvt7Ir4wz0sm0VqMTyahKDOA1
         EtfQ==
X-Gm-Message-State: AOJu0Yy6TRE6UeuQk1QroR6aOzm9mCN/rh+x2y6R4mJNXNo8LKTNVlPZ
        9Bsv8JqLlhpNp9pctPhbqFwOOPJzG66lKmpax0Y=
X-Google-Smtp-Source: AGHT+IFcRrzMsrbjrzRxW+P6uk2ow7WGhDqsE3HlSBkiqH8BcfD239K6+N2zcLm2F/s93cZmrTwhPd9EHpMCJ7O+EF8=
X-Received: by 2002:a9d:7c83:0:b0:6b9:b0f6:eab8 with SMTP id
 q3-20020a9d7c83000000b006b9b0f6eab8mr12945557otn.5.1696258718994; Mon, 02 Oct
 2023 07:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230929195617.65120-1-jsatterfield.linux@gmail.com> <20230929195617.65120-4-jsatterfield.linux@gmail.com>
In-Reply-To: <20230929195617.65120-4-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Oct 2023 10:58:28 -0400
Message-ID: <CAEjxPJ6Coi8y3xjNiP4GJ2YMOqAn8zHjet9F6LLuJJah9E1zZw@mail.gmail.com>
Subject: Re: [PATCH 3/4] selinux: avtab iteration macros
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 29, 2023 at 3:56=E2=80=AFPM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> Similar to the list_for_each macros in list.h, this patch adds two
> macros that iterates an avtab_node linked list (avtab_chain_for_each and
> avtab_chain_for_each_prev). This has two benefits: it reduces the amount
> of duplicative code for iteration and it makes changes to the underlying
> hashtable data structure easier as there are fewer places to update.

You will need/want an equivalent to list_for_each_safe() or open-code
it to handle avtab_destroy() below.

>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> ---
>  security/selinux/ss/avtab.c | 40 ++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 1cd4fed30bf7..e8046eda7140 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -223,20 +223,17 @@ avtab_search_node_next(struct avtab_node *node, u16=
 specified)
>  void avtab_destroy(struct avtab *h)
>  {
>         u32 i;
> -       struct avtab_node *cur, *temp;
> +       struct avtab_node *cur;
>
>         if (!h)
>                 return;
>
>         for (i =3D 0; i < h->nslot; i++) {
> -               cur =3D h->htable[i];
> -               while (cur) {
> -                       temp =3D cur;
> -                       cur =3D cur->next;
> -                       if (temp->key.specified & AVTAB_XPERMS)
> +               avtab_chain_for_each(cur, h, i) {
> +                       if (cur->key.specified & AVTAB_XPERMS)
>                                 kmem_cache_free(avtab_xperms_cachep,
> -                                               temp->datum.u.xperms);
> -                       kmem_cache_free(avtab_node_cachep, temp);
> +                                               cur->datum.u.xperms);
> +                       kmem_cache_free(avtab_node_cachep, cur);
>                 }
>         }
>         kvfree(h->htable);

This requires an avtab_chain_for_each_safe() or similar since it frees the =
node.
