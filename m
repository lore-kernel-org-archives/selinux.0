Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3A0C433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 20:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA67610CE
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 20:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhJMUhE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJMUhD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 16:37:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FABDC061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 13:35:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w14so15127700edv.11
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BvqC/cvxHD64GrFtVDcjnzLRPEqfqJRiGmBj8XQHDbw=;
        b=7r4sm7ej7r4CPRadO8BLqUvNcU4mtebypmAlYw+draykMSofHcpBz523XnaLRVhD6O
         T987ODh4vrUH66IcU6beasRMCkUibQupHCtQR37gg7BZLjtUOLQV2bbUGmUwmQnnR9nE
         L5slHXQK3QioDxkyptj0p5uTiFWZZ+ZXy6vuO68OiIS8hMk3z/vebFj+ClUuSbJWJkc7
         f8WrUEjPnA3nQZ8sfwgUbWx9hH7ngPKDzSG5lDmDh8Q5oJhZ+Zs//nbzpm8RaTN3g2JV
         xGskqsPTgTGN65k8HUAoA4hrJZwfq34+L1b1dcyzs3wKd/d88NFV0lHy2t68ZTFANZb1
         eqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BvqC/cvxHD64GrFtVDcjnzLRPEqfqJRiGmBj8XQHDbw=;
        b=oKFxUeuADffGKuNTykBTWpwRA9puGFSY/ZAIz8wOkUP3+ShDbudXeHRvBCRFCkd28E
         nevHVA5k9dRcgfQzERMGgzUcLqKXuRTHEDAf62vNxErkgOMf0mTVYgBlHB9W9xkV5C/e
         feaaoJN48NGXTfCPcI9gZ/5HYp97cOisQQb6XfvAYAgBqZQaBF2JBwUphefx6v11XMoW
         ZoGzgdd1oWyGK5wsSCFePfJ2NdhB72B+3wm5j5d0g7341wLYnvZlhJRB/3PFMJpZ9rhq
         tAzvFz78psceGOCnCvxBv09GJmzg3o8+JI1tpa/JZYbPrUvYV0adRRAasUtyaasmEtMl
         luYA==
X-Gm-Message-State: AOAM532X5nAftAddbIHSCjQ/Kpwarv8JVKGZUyepEpAyr178fNPmchfe
        WhYOmF8DSauz4e6dxh9esTjhyZzVJZifRfNw0ftIy2/QwQ==
X-Google-Smtp-Source: ABdhPJwjDAJcKUteehNN/QW9wuSyVn9btPQcFUgGlL6qHAyLDqnSVhnjaZz1fK2uGVWlHJ2ipu8KjQkRBwo5PxP+e3o=
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr2354856edb.209.1634157298018;
 Wed, 13 Oct 2021 13:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <163407953525.224696.4280832299519853149.stgit@olly>
In-Reply-To: <163407953525.224696.4280832299519853149.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Oct 2021 16:34:47 -0400
Message-ID: <CAHC9VhSGJ4Qq7qYdnjnDQsbjq+7oxruQZ79nkkOjzwK0FRVWkA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: make better use of the nf_hook_state passed
 to the NF hooks
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 12, 2021 at 6:58 PM Paul Moore <paul@paul-moore.com> wrote:
>
> This patch builds on a previous SELinux/netfilter patch by Florian
> Westphal and makes better use of the nf_hook_state variable passed
> into the SELinux/netfilter hooks as well as a number of other small
> cleanups in the related code.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |   51 ++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 27 deletions(-)

Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
