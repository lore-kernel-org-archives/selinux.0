Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8601C433EF
	for <selinux@archiver.kernel.org>; Fri, 22 Apr 2022 07:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbiDVHv2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Apr 2022 03:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445030AbiDVHv2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Apr 2022 03:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66F91517F3
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 00:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650613714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SC50zM3hDqVHmtMYvJu/fDTOMcb6ujc/lYidPhwD9Ug=;
        b=c+qDQJbssJQBsBiBULXRCVxKA5EjTTIhO316QCaezFLyZn9RgohMnkWqYMIfUg6QB3nQjl
        qLbDQtqJtzdTq6fDe7wTeHltY+ZR22xpnh+pxDkfq6Y0tdNHlOSl/8NHCHNd7wBRxf3JKR
        KcJtjhPjni2AKHbc5yKGyXJMJmqwTfg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-zhJCa1HEP52_3qiSrjgs3g-1; Fri, 22 Apr 2022 03:48:33 -0400
X-MC-Unique: zhJCa1HEP52_3qiSrjgs3g-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-2f4d9e92a0aso33482227b3.9
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 00:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SC50zM3hDqVHmtMYvJu/fDTOMcb6ujc/lYidPhwD9Ug=;
        b=tCGVliTRGW9/C0EteoqFt7Bwq9P2y8Fl9w/FhURwUsLqqlCY9Q+HsZS7oehWYsddeN
         ld9jS+oKiyoKxlsGycDc9KEYRk9a+jFgxnaogQmqIOiehcetjzHwj0Dk8HzxRIMNr7Yj
         4ExpLoSAE04nv1WNK4s/F7FfjDEHdV+jtFU5ErNId4fCM0Qi61BqcGbZCI+7T8+4veC2
         j5W11n5FnGVZ7RA782B9MOocWwBXXkz2+Qtk3GL+8tHkzT3MOwEuMrIqYcMgE+msPhWi
         X1POj95e3zA4lqBkhorflyQb6KaIB182x5nW24UOs4rMw6kkLTnzT6crEWq8aBjrxKWw
         cbTw==
X-Gm-Message-State: AOAM532vvfry7k0+vvz8eJEhfBr6CKQsswj6qfLcULRYA8suqxhD5Eib
        AbZpeCIHToAVtCS/fphSO7seWWOh+wXtHLlrK8jrJVksWKSF0DBz9LRXqh4XJPtWq5m8oKyOenj
        1V7pVjJ8hmbIWegz2jmZTyPyBJ3V3Hw5lPg==
X-Received: by 2002:a5b:247:0:b0:624:4d24:94ee with SMTP id g7-20020a5b0247000000b006244d2494eemr3124249ybp.197.1650613712815;
        Fri, 22 Apr 2022 00:48:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjgs0174KEUi7Gv9D/1zygQEhUZynO/xfLhwaqTWDWS+c108qTfCjcRDqqETVTk6KMF9MttXrmhd4UsR9O/FQ=
X-Received: by 2002:a5b:247:0:b0:624:4d24:94ee with SMTP id
 g7-20020a5b0247000000b006244d2494eemr3124243ybp.197.1650613712635; Fri, 22
 Apr 2022 00:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220421081720.744534-1-omosnace@redhat.com>
In-Reply-To: <20220421081720.744534-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 22 Apr 2022 09:48:21 +0200
Message-ID: <CAFqZXNtWf_VFfqCvFWL-=g-=svju6iccynA_9eu1Qbw+HBjMxg@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/2] FIOQSIZE followup fixes
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 21, 2022 at 10:17 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Two small fixes for the recently merged switch to FIOQSIZE. One was
> found when the testsuite was run on ppc64le and s390x arches, the other
> one when looking at the code.
>
> Ondrej Mosnacek (2):
>   policy/test_ioctl_xperms.te: add ioctl numbers for other arches
>   tests/ioctl: adjust size of variable passed to ioctl(2)
>
>  policy/test_ioctl_xperms.te | 3 ++-
>  tests/ioctl/test_ioctl.c    | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> --
> 2.35.1

Both patches merged (the first one with a minor uppercase vs.
lowercase consistency correction).

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

