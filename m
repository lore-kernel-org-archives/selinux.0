Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77865C43461
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 15:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DE2208E4
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 15:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zFbIlQL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgIKPjo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgIKPhk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 11:37:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F06C061346
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:11:45 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c10so10112521edk.6
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiRjq6iElo/pNXkx9gj5B3VW0uBcmsxfBp7uKqwCUlc=;
        b=zFbIlQL6U31ka9sil9ZNRuQOfT86BS5nWocJbn614bMoGNsKvV1qqJC6UPk9mRI4SK
         Z6rC8b85m1cYlkbHlmEoM5NfA6NhH/T00nnhrYOOQJ1ur2UUSwTO/eAtkEB2OiV504Jq
         3uH7IqArqB+PJtW7mRBcEl0He0P2TywHUGuf63+4FMNgrwagwFOlXD/UGcF1rbKRO8lf
         xw+246B5Q8QFjKLoWcLir0li+9LMnYO2+bUphHw8Tv7i+9Y9EvZb/4tUTeV4uYE70guY
         1CvYkNcwEg+JG192y/PXImTo8MVcopvzz9FFPJBhFNg5mTX4uJb3mXovDayUhXxG6sYr
         SU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiRjq6iElo/pNXkx9gj5B3VW0uBcmsxfBp7uKqwCUlc=;
        b=mRHhLlSEMtZ7sC6ooypSdRuVesmDxdgPiFzr8xpxoKAFzSLMHjGCLJYfd96HNI7yzc
         56iW98Ee7t7axT9R0zeIA+m8HakjSg5DGCbdYa0BVlnUIP30p1ZcL0ca9RJGm+vjuPMW
         q+bhnktuSYlSnaY/b5+i4ZaIxcvQ3nVUd/qwvEd84okmVIMI9QThlrgtHRwsUcRSh333
         KKIZgJCudBtVskgqjyXJHnjwUfyRKMsmwAJaAty8iGH9EAgj3EpNg4wIPsCCaTLoI/Dh
         rTtnF79U+1jI3qDsX/BOglve6tz6/Y4fWTv+IT8P+olYIMJjkGd7lxdtZbOxptd0uwXF
         /CcA==
X-Gm-Message-State: AOAM5305EK+nEUXFeWYo+1yAsztIpWa2VVNoN7E0N2K9g0AAhyLgV9TU
        R0H1uLGk87EFzgyV0jnrHqtROp+tw7sqdUCLeYy+E0EGoQ==
X-Google-Smtp-Source: ABdhPJyE1eiuRlI7VdW7dLi5CKMDJr+fna8lseTOQgAurGL71wHs3JLveqbgcyAMtB2rJ1V7u+2XXkHpQvPU4rkWMgg=
X-Received: by 2002:a50:9b44:: with SMTP id a4mr2172133edj.12.1599833504068;
 Fri, 11 Sep 2020 07:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200910142805.20228-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200910142805.20228-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Sep 2020 10:11:33 -0400
Message-ID: <CAHC9VhSKg4=_7T=9GKgU_BbamaT8gxJjhg+7prr7RLVe_U4kdQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: access policycaps with READ_ONCE/WRITE_ONCE
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 10, 2020 at 10:28 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Use READ_ONCE/WRITE_ONCE for all accesses to the
> selinux_state.policycaps booleans to prevent compiler
> mischief.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/include/security.h | 14 +++++++-------
>  security/selinux/ss/services.c      |  3 ++-
>  2 files changed, 9 insertions(+), 8 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
