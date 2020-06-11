Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A5C433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 16:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF462078D
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 16:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qowMjbdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFKQgV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKQgV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 12:36:21 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FE1C08C5C1;
        Thu, 11 Jun 2020 09:36:20 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s21so5949591oic.9;
        Thu, 11 Jun 2020 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OIkJTnbC9/J/at4KtnWFQYW8cUJ1h1xUBzB/M6Jqjg=;
        b=qowMjbduJb4fdYh/wOL3xk4gMnMJjMX/YMpMHNHLFbFfEBc0eW0LYimV6yY4ebxQ/B
         7417HbNq5P/5arcKzbqEMfZoUAZnfuUUIho4+KJsTdmCPjp39qI5eWdD5aro5NEBc1KQ
         4GaPt+M6L+J3VaebksAMg48XwOcUY/4DS8Gtmu5Iv8u24fST8r8Usy0b/RuPSdcFBUdc
         zKCLADF1WndtRAQKGoRBUIG1s3Tl0/fZ+FMjeyr03k5gwoZNOkPYxhVl+Ov2srRl9wTG
         LSuhhPwymLv+OTK9g8hfQzvqG+AFWJPx8DeFhqbIzY6y1lVTpZaCbVaHwhNY+p/DjDpK
         raeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OIkJTnbC9/J/at4KtnWFQYW8cUJ1h1xUBzB/M6Jqjg=;
        b=f73UlNCe3vmTO0otyvb5WlwlJ3bRLppja24EQyxz6AyBguFUYvILsz1DwAIuQivU9v
         H3WjG3ApZExZSVaODu/B0KXgRZIVsLhTqMb64+zWHo/0L9VDjY1yDjlPJmrQLQunQe+z
         DgPuvf/CJWMGjY8ezkgwDVvpDOfIhXpFik0x8UmSUxwC2HdXl5DcMa51GOZzzOA/31Ah
         lQ7MkT12QX+sX5dgjUIMu/8zVxaYP7RVvgLwY+33bw5AP2q+NMGREUBltEiXtzw3Ipyu
         SH/2aqVpCHeDzOf9gYgw9+UptuQT+JpYCKf+3nSlg7tFA5hXw7eAlB8i/OIFMiETo6Sa
         NPRQ==
X-Gm-Message-State: AOAM531fu3n8iGqHuFD6umVIPNif9LbIYynegmXxFLjrVkZPmSUzlgOo
        sVgtcx0RNEuM//K1Bpr1JQSd+kJZqSViesZwKoI=
X-Google-Smtp-Source: ABdhPJwKf3Q0KMeaqx7WPXFay3dw0Vt/+Vge468W3fGcNFpeE0A006cQEQmQTsa9Q8Zf6sYJqaTlH3Ykf2UmQxxcuos=
X-Received: by 2002:aca:ec97:: with SMTP id k145mr6749390oih.92.1591893379701;
 Thu, 11 Jun 2020 09:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200611155830.8941-1-trix@redhat.com>
In-Reply-To: <20200611155830.8941-1-trix@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 11 Jun 2020 12:36:08 -0400
Message-ID: <CAEjxPJ4nz=1-eeQtU+V5r_ULvpT9Thh6TB4G=2gu2fivyo6KaA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix another double free
To:     trix@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, weiyongjun1@huawei.com,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 11, 2020 at 11:58 AM <trix@redhat.com> wrote:
>
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
> earlier nodes.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Looks like this was introduced by
60abd3181db29ea81742106cc0ac2e27fd05b418 ("selinux: convert cond_list
to array").

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
