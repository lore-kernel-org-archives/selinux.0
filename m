Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375DC433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740FA20829
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 17:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAYIVxUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFKRNE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:13:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39902 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726379AbgFKRNE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 13:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591895582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2lc4GWkEgMW9G8vaWxd2JwQUtHL+Yw8/GWAwvra2v9I=;
        b=cAYIVxUcG/UtDI/oR8PXHEINIm7+IClhjBsNX8baR/B/FgXY84JMuRNhbdJhZDFx2/B1yR
        GWqyh10gSX/lPlNCE8MHtwN2/Wg0E5PrpHcH+Y54TRLKT+HDvcLIMPv11ZTRQo/fz2IYwt
        25EEneWtJN/sqlCqXeQ2nHqnn96fJWo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-20v1CErYN222Jss7I9jEVw-1; Thu, 11 Jun 2020 13:13:00 -0400
X-MC-Unique: 20v1CErYN222Jss7I9jEVw-1
Received: by mail-lf1-f71.google.com with SMTP id n17so1761491lfe.15
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 10:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lc4GWkEgMW9G8vaWxd2JwQUtHL+Yw8/GWAwvra2v9I=;
        b=d1AEbcaYYr9aloJVVGHCohP6CoA7lMUe1J45eP1Bysh1ghYmLPriY1QDV2AWL4KP0N
         ViqQCCuY/YsjGtjdijdUPm3+RYM/g3rIZvls6TBv1S7UTOOy371fHTv/xCelhe3C2hId
         XHRA/vapbqRbkUjppLvLKiVFUnNzLoppuRWsJBpMf7WyvZnl7pjcfwLsuM+QeANl8E9B
         57Fj0By9dnaPItR7wXqV+EC0Js1Y7nj9u+pqFVrAcQRclDXyptHAzUNHsTiwM3Yt/yda
         S3DeyyWU09ltK+I/gCrIsXVVRdF/8UQMlRI8K3X9wjYNJC9oE4/dka2WJzb8NY7u1Rkp
         PnAw==
X-Gm-Message-State: AOAM533HSrl6zwKe8Q+0uC57gTNGYq1zwkDRxvgeClP4FvGu4Ej1BMoB
        k8GYB/rcBfd25dqgLM6CJkPN58XZBlrVs4pnypfey6GeBnZNZYIAfR7R5s9rPwOTT2k9US04YEU
        OKtJFc/aLFtnPxrbekYBqGEGv9GdiL7Jtag==
X-Received: by 2002:a2e:960b:: with SMTP id v11mr4937666ljh.77.1591895579138;
        Thu, 11 Jun 2020 10:12:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywE09hDV2mOUCgj2h/z3bNYfRdprO2vQxtXhOlYbylBXyf3+ZwcppUGRcbmVCXizn5mdZaOTYbSLou8xQgFrI=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr4937654ljh.77.1591895578882;
 Thu, 11 Jun 2020 10:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200611155830.8941-1-trix@redhat.com>
In-Reply-To: <20200611155830.8941-1-trix@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 11 Jun 2020 19:12:47 +0200
Message-ID: <CAFqZXNvHpWygX16EgFa5fc2oFkRfn-RaPpqbw-JvitpDNaAWUA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix another double free
To:     Tom Rix <trix@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Tom,

On Thu, Jun 11, 2020 at 5:58 PM <trix@redhat.com> wrote:
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this double free error
>
> security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(node->expr.nodes);
>         ^~~~~~~~~~~~~~~~~~~~~~~
>
> When cond_read_node fails, it calls cond_node_destroy which frees the
> node but does not poison the entry in the node list.  So when it
> returns to its caller cond_read_list, cond_read_list deletes the
> partial list.  The latest entry in the list will be deleted twice.
>
> So instead of freeing the node in cond_read_node, let list freeing in
> code_read_list handle the freeing the problem node along with all of the the

There is an extra "the" before "freeing".

> earlier nodes.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index da94a1b4bfda..ffb31af22f4f 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -411,7 +411,6 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
>                 goto err;
>         return 0;
>  err:
> -       cond_node_destroy(node);
>         return rc;

Since there is now just "return rc" in the error path, can you please
replace all the gotos with plain return statements? And please also
add a Fixes: tag pointing to the commit that introduced the bug (see
Stephen's reply).

Thanks,

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

