Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F079C433FE
	for <selinux@archiver.kernel.org>; Wed,  5 Oct 2022 14:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJEOkH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJEOkG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Oct 2022 10:40:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326B917E2B
        for <selinux@vger.kernel.org>; Wed,  5 Oct 2022 07:40:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l1so2749865pld.13
        for <selinux@vger.kernel.org>; Wed, 05 Oct 2022 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JhShjdkfYjJu1kaYqd1yzj/KW+jWy5HzLdc/EtELs+Q=;
        b=NFrpDKzR98UOvVcHunr5HTRniOjRtyGtkmKurkw9SRp47nUWZt1P4ugu4NoJ6StIKP
         +cAc7MuWJAETWYubJ+C6VGjLsnTwYUYXgYF/eFhgAqAM2oz+62luUBj6mjJ17Ygdiza9
         lq/hCwCQVRU5WRyPT1kRGDdrh2AaxXd3C5cFj21N02ViGMln4AJIA0mxe9E2vWQzOiDK
         mksYWkzyiUkAgEcOJ+M0zYQiIvCOwZ5ypCtwDG6SaXN3lw/sKJ0Olnt4HxTijQouR5T7
         eWM4/42DQqaBJAuhNtfq+e9Y10/HHE3K5cb36qnlFvTzhHv+pHJbuy0Lrj1sK7azljdL
         20NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JhShjdkfYjJu1kaYqd1yzj/KW+jWy5HzLdc/EtELs+Q=;
        b=4JgXPfuEOCAWg27OO6jh/+uv2p2ZZVKUCctYU6iT0Z+yOlscEQT4uPuPYSYEbiWRUH
         wgTVFOirU17d+Ui3JBt+2x43CmFzTudql8nW1hF3H3P7zxbBi2Csqs0wurO4av67urTr
         cYcm/IR5p6A9/xJG4q1eSwO6J7w6PK39TQlw0TdIcVrCRD7n+OtWpcJQ7g3yQtDb2ECr
         0AO9SNMSBsqulMHiSi5tOrw5hmQlmYCt/so8f7Vkfcpz2bXSVQ4PtfE72bTIYWH9h2Oz
         +xXnzAqFxceaBgSXZkiwawQvz73XXNUjBTs288fkL8KnfsAStXrXpaP9H6IGxtAmIloi
         dPxA==
X-Gm-Message-State: ACrzQf3pq7Tt0+pVR9CWsk6ui5bvHgCD+DHNEavmf5cwVp65RTOHluVF
        Y8l7gM/UvS/QqPC1esWPjunqYGeifTCaowwn4J9tI29y
X-Google-Smtp-Source: AMsMyM7tTm4LpXAXLeZzR/prsLI4a0rGyeQfdEV4dNJVQMfoYYwrJCKvL/AhudzN2lFjz2V8id2wjTMpHXmsjNzcrxw=
X-Received: by 2002:a17:90b:400f:b0:20a:9965:ef08 with SMTP id
 ie15-20020a17090b400f00b0020a9965ef08mr53876pjb.155.1664980804738; Wed, 05
 Oct 2022 07:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220907160806.80382-1-vmojzis@redhat.com> <CAP+JOzQ+=3ugrg=drpV6y0nx2dpdw9w3syiqaycYvBPYussPGw@mail.gmail.com>
In-Reply-To: <CAP+JOzQ+=3ugrg=drpV6y0nx2dpdw9w3syiqaycYvBPYussPGw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 5 Oct 2022 10:39:53 -0400
Message-ID: <CAP+JOzRC=tOS25X0ORWM0fxmDjyfD5Qj2zy0sF2nnnyR3O3Wvw@mail.gmail.com>
Subject: Re: [PATCH] Update translations
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 28, 2022 at 3:46 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Sep 7, 2022 at 12:24 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > Source: https://translate.fedoraproject.org/projects/selinux/
> >
> > Please see https://github.com/SELinuxProject/selinux/pull/369
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim
