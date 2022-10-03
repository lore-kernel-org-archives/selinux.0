Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02249C433FE
	for <selinux@archiver.kernel.org>; Mon,  3 Oct 2022 14:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJCO7m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Oct 2022 10:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJCO7j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Oct 2022 10:59:39 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DDFD9A
        for <selinux@vger.kernel.org>; Mon,  3 Oct 2022 07:59:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 78so9865948pgb.13
        for <selinux@vger.kernel.org>; Mon, 03 Oct 2022 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=taj6P/J9KmMw5jgIMRVK9x94QodYmUzqMcaCrk13lM8=;
        b=p+kGL9O6ugo8RMiGZll/6yVBbbLXILD1zRAyYxVdcuKxSFW9R/lMPifbZWadIIUDf9
         9EzRpbzZsPtB32WIoa2bBefKUz87z+iV2bEqxGH4ElgtjCc8/XIHha6ikgrlBCQcHf1s
         sy+pH5JGCJcGO3Fs/Pt6ondIlMAx9TU+qk/g8eUyg9lgy8QMQge0dwhQZ6QwiaAAmzfA
         0n8bUAwsFMZo0/BDQOmDBEVSYAxwsNw62sTQXoV1f+4YL6DdszgU72PgZ/bjlc/uyiT/
         9QR+L+B2NHxgPHyIfuMdcQACOzbexht8uqL1slWVcY8Z9Lwv3QE5FjTKmZaDJMVaArGK
         R01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=taj6P/J9KmMw5jgIMRVK9x94QodYmUzqMcaCrk13lM8=;
        b=HjUK2i8N1+b/QnqBq1pu/uK18/wo+gbnof/JMSS9+5RgZ7VVYS04/dGMVoDuDHH8XJ
         MRG/vr743SxOS+PAb66tktOfLs1RHbdQrgFhuEarUlT/SzKzwFE8jz1oiw8ssA0EAKkd
         vCOd0agn2R+wo8lTnEpPrJanKisv5mafim/lYNvVb3mOSHNspU0j+/on8Q6+JRzzzZNF
         dlCFjXrnsUU9Tew6CczkcAsAfwrCDbY8AIsPBjIpngnxkfphj2CrmWv9upb3GTRgkEaS
         GoEz4Dz9s/jq75ZBQNWXK/WIn1WSSt49e7l2d88/Yo0Qnrt5xWg7Qb78p6SB8MXobF9R
         hxpQ==
X-Gm-Message-State: ACrzQf2p07Ca7s8joeKGc8dZbAB4awlgBPhTtw9XSWNTOubTBPUgz7OC
        5NrG4MZFX419w8K2zJzBSCCmDsRh3x0RfWDb9r1RvKtf5fA=
X-Google-Smtp-Source: AMsMyM65WsrBNH7+Y8HbvJqBVfWCNmZ/V9nKGLnbgR83LrIPebBIv1l4HBuzcx66CDuAK5mPQP7FZN44hUOrqkK0LAU=
X-Received: by 2002:a63:191d:0:b0:434:4bb3:e016 with SMTP id
 z29-20020a63191d000000b004344bb3e016mr19356832pgl.133.1664809176370; Mon, 03
 Oct 2022 07:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRNJjzGSbQgcTeP=GcUyAHTn__KDz-r02zSs-xcQFO-gg@mail.gmail.com>
In-Reply-To: <CAHC9VhRNJjzGSbQgcTeP=GcUyAHTn__KDz-r02zSs-xcQFO-gg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 3 Oct 2022 10:59:25 -0400
Message-ID: <CAP+JOzS-tit_5wLgYGBGBgWSzLvx8zDsb8mts76GsP673x9Xvw@mail.gmail.com>
Subject: Re: [PATCH] docs: provide a top level LICENSE file
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 30, 2022 at 11:05 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Okay, so this email isn't really a patch, but it does point to one :)
>
> * https://github.com/SELinuxProject/selinux/pull/370
>
> While the PR referenced above is quite large, too large for email in
> fact, it is that size because of the number of renamed files
> (COPYING->LICENSE).  The only new addition, a top level LICENSE file,
> is quite small.
>
> Please review and merge into the SELinux userspace repo.
>
> --
> paul-moore.com

Acked-by: James Carter <jwcart2@gmail.com>
