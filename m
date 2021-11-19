Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7D3C433F5
	for <selinux@archiver.kernel.org>; Fri, 19 Nov 2021 21:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhKSV2E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Nov 2021 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbhKSV2D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Nov 2021 16:28:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E96C061574
        for <selinux@vger.kernel.org>; Fri, 19 Nov 2021 13:25:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so47908280edd.9
        for <selinux@vger.kernel.org>; Fri, 19 Nov 2021 13:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rje8BmDru5kudqyAFkEz0MIlHbqgW9o+iVmrxwPyp44=;
        b=AIBpuwGmJErC8D5Ne1gjihe4OHhZ3JakHHhRSVUjEEqeYE2B7HeklkNSvkRnuiL0to
         Yysee6WSrmJfcsTB1yza2VMcYiRaiQULJOP+x8FmnIgDT4EX8HLci/27l1LI4U/GYs5P
         UPUlv2+AlFqKmUY7+yrTASoWTWy445OnTxmsY1LtuvJbjKjCEzLsPCuLSgJBJmJy014j
         qTY5wuySMM+7OsEi6k52s6AxdnuoBcVDu5A89MbTmWdwQn4Po9v/48kAnMAfkzRnru65
         QuLCn6+aGDnHq1srl2NsiFjuKXf2696BYrOVzBQFQcpW7cKKW002SIuhYO4XwcjRB0LH
         KV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rje8BmDru5kudqyAFkEz0MIlHbqgW9o+iVmrxwPyp44=;
        b=ZRsfV1ONB+2GTzIQEyJ8OCSerwBEn8t2P3eDueZ2NgY3FCEBRpKZItVf6i5jRNfqDq
         q/e9o972TroLvYPUj86Rfe/wUTKE4rL/hJUMLwaA000vK7L3/+JugEVKoOsFfaHa9jVQ
         yCiUlmDLSCD0VSQxi6jTGQ4OTAU/TDjvUxjkfDypW1IjeJ3QhE0OXNqCgtFtfyUDNA7K
         URHOJtIGs2092575nvTTm7uvTpn6DmPDmHsi/LPgOZDLri6SGDK0duXskxU29ycsOPZT
         gcF02LlCUcA6YJMa3z/lSuDZ8kxlqc+O44KF1dnlEPoLtkGXf6BEiTd4kxPDZlXRLj/q
         P1CQ==
X-Gm-Message-State: AOAM531x50/MNHp6RzCA2uBVFSiZIycrYw4HhSK9mwEOYwwIxUOqE0Vx
        JZG1kzNlGV6DBl/8NgIZcFxw+xCIXX9PBPZmyMmVhZCtHQ==
X-Google-Smtp-Source: ABdhPJyPBgpAHS5SPq6BZL6FuUJDCjqZJSryk+wf8mZNnPgWLq4H7fqLCNtfEl3tchNkHXukSqmMM6r5P54NI2sy/lg=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr11988475ejc.126.1637357099742;
 Fri, 19 Nov 2021 13:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20211119134520.943504-1-omosnace@redhat.com>
In-Reply-To: <20211119134520.943504-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Nov 2021 16:24:48 -0500
Message-ID: <CAHC9VhRb97JLiyWm5qUQa31yjV-WmV6bjOv+bk=-9S83jvCafQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix NULL-pointer dereference when hashtab
 allocation fails
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 19, 2021 at 8:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> When the hash table slot array allocation fails in hashtab_init(),
> h->size is left initialized with a non-zero value, but the h->htable
> pointer is NULL. This may then cause a NULL pointer dereference, since
> the policydb code relies on the assumption that even after a failed
> hashtab_init(), hashtab_map() and hashtab_destroy() can be safely called
> on it. Yet, these detect an empty hashtab only by looking at the size.
>
> Fix this by making sure that hashtab_init() always leaves behind a valid
> empty hashtab when the allocation fails.
>
> Fixes: 03414a49ad5f ("selinux: do not allocate hashtabs dynamically")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/hashtab.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Looks good to me, merged into selinux/stable-5.16.  However, as it is
Friday, I'm going to hold of on sending this to Linus until early next
week.

-- 
paul moore
www.paul-moore.com
