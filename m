Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338AFC04A95
	for <selinux@archiver.kernel.org>; Wed, 28 Sep 2022 19:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiI1TrB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Sep 2022 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiI1Tq7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Sep 2022 15:46:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B739879ECB
        for <selinux@vger.kernel.org>; Wed, 28 Sep 2022 12:46:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x1so12600510plv.5
        for <selinux@vger.kernel.org>; Wed, 28 Sep 2022 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BvJ7WchYPdgTOadz6hQHl3wtaP8MdHa1Nk2B2dPJunE=;
        b=lfxBVZAe3voo9cQHvpL/n4GmLKDCc7GUNDeKa9ExUO+AEXXcMf+zkiuj6sYVPCulfr
         hnwiJT9FETkZQfXC7k3TokNM0bUsQaJ4ldTmjFzPlYWWRS2kgXRuzklo2kTlv6avXXIE
         723Fy2ZYiNk4pcEYwQJCb8ErdO5VeLrP/vZxuaJJPmLcZ1Tqu+Q2nYqX+HyRGnUvjFr9
         0xECrC7Z/eym8xhAw55aCNR3y/sZtxPudczRj0IE+tMGjZo5U1tEdWZUCM+jATzsG8nH
         dV6ppYbWJQxTsdobuZ3H0LeyOrCb1KizZRyId82CVPaVzTk7jDh3sp/be0VeMz55y368
         OgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BvJ7WchYPdgTOadz6hQHl3wtaP8MdHa1Nk2B2dPJunE=;
        b=xpT9KqLZUSyoDdF8VLiNSp9ml6GwNcIJAM5WDFL7Lk7x3HeCfQhMCcaXzBQae9Pt6p
         kiBwz1v+6SLPByjJMa7at8gKXQ2wfDzHZkBqdE90m+XHyyGUbmSpF0k3tmMmWOPlxaqN
         lDhazXUEJlnnDx0ANxt1kHuSjzBfA3tT8CXSOUSVpyuhvFG1GlrWwTc2LBu8PQ4SR37w
         KSPw/OW7mWj1oEUO2hIJXJ6CR8tWjRgT9BopKmQOv9HqQ1uEL1mF0LYaSVCbHgnDlI1K
         nBGe29yUwptwcu0hNppAWLUGsQ6VUtUSvvaqahmUlkoXt9kibe54Psd2zhqvEoNH7XJE
         gFew==
X-Gm-Message-State: ACrzQf2noBT3+D8E1RyCezUZHwFd8QTd6W9lDFP7gsbxUPlIqPUjUine
        80IBxvwjL4Zp1U0XzD+0cDnMpASqSAZFzaNpwEA=
X-Google-Smtp-Source: AMsMyM5GNPYg+84XHpJExLlz3iSSpGlT9qAqhxFpl16VzBK092geSodKplHv+ngIZMhlVtMOjbtpCdzPb2U4EWYf0fc=
X-Received: by 2002:a17:902:c410:b0:176:e093:1371 with SMTP id
 k16-20020a170902c41000b00176e0931371mr1359029plk.67.1664394416837; Wed, 28
 Sep 2022 12:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220907160806.80382-1-vmojzis@redhat.com>
In-Reply-To: <20220907160806.80382-1-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 28 Sep 2022 15:46:45 -0400
Message-ID: <CAP+JOzQ+=3ugrg=drpV6y0nx2dpdw9w3syiqaycYvBPYussPGw@mail.gmail.com>
Subject: Re: [PATCH] Update translations
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 7, 2022 at 12:24 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Source: https://translate.fedoraproject.org/projects/selinux/
>
> Please see https://github.com/SELinuxProject/selinux/pull/369
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>

Acked-by: James Carter <jwcart2@gmail.com>
