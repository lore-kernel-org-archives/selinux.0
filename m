Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034E4C433DB
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 10:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA83965257
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 10:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhCIKIZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 05:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhCIKIQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 05:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615284496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SYm0kgjRA7W0E7Yr2IJisxrxfRrnBadUrxfwPSBbTRk=;
        b=Xl9rx7+F3uzCjbdpJENAo+aTEemJ1bHqrM4JDQfbl7qck9JSyR4+2F0/JNMw0MZoP2a0N8
        SXQ/UPNp7I8WT7mWK9xvss0MmAjihObGgiCzqhoj6uezrxO+MrFXggtzITpEN16mQXsqtc
        W7VeBVJGqLiLsum3PTbiXGLBFtYOotQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-mC3xyaOcOSimMaXkSu_uCg-1; Tue, 09 Mar 2021 05:08:13 -0500
X-MC-Unique: mC3xyaOcOSimMaXkSu_uCg-1
Received: by mail-yb1-f197.google.com with SMTP id a186so16493492ybg.1
        for <selinux@vger.kernel.org>; Tue, 09 Mar 2021 02:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYm0kgjRA7W0E7Yr2IJisxrxfRrnBadUrxfwPSBbTRk=;
        b=faULmv0uxtwUwUq189uqny+n6N4h41B2fG/+CWrr+h8GHHTJS6OQZFimza13sWSYNV
         7z7oy7cSTUASA8n+WuwkJx+nHHW1q/5sJcePRJM9YLOz837t84SBPEyMm7K3l/BwCZ1V
         MocATsj6FlMhIl+h/ETwrzQUBfe6Mj7Xhu1MOrAfqrVo3qq/H0VOhkoDxPWdpY4u+uvB
         1A8Gzfu1Sm6e4A1//Sn/yMJ40wlalGYMCpNsnNY0Oj5qyyPdBOqNX8jy0J5l8EdPnODr
         ydpC2Uh9b/Y5UWXupNW81RDQ/HzU5gWyq+oBpQ4GJJumBF+ZeQkttQi1K0wPZTmK6b7Y
         HSOA==
X-Gm-Message-State: AOAM5309/7E/+kb86q/IeoMkzic/w1s+1ZdJmgTmTlhhmd/DWPA82mdx
        YtQtbb27SyPCv//MyEcNCG0NV8Lthm5QwFaxQU3UHQ73SIITCkP9INeBP+7kLYkAwbo3ElKrCox
        rcVF76xCtG5LmN+UJv+8VQYiWYjIL7MNehw==
X-Received: by 2002:a25:ad67:: with SMTP id l39mr40282821ybe.172.1615284492512;
        Tue, 09 Mar 2021 02:08:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOdXiOr+CcTEln+8TZ0CZvuB0W0M+aAg2Wavc5dcrB2nfJuV742vWVQiWOrCjwyEKAIQngbWmatIoZcEM8YyI=
X-Received: by 2002:a25:ad67:: with SMTP id l39mr40282799ybe.172.1615284492300;
 Tue, 09 Mar 2021 02:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20210115174356.408688-1-omosnace@redhat.com>
In-Reply-To: <20210115174356.408688-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 9 Mar 2021 11:08:01 +0100
Message-ID: <CAFqZXNtssgDmhMS+p6+F2zC=ka3=bM22GpNQLO2NbSLWQroYFg@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: fix return value of _nfs4_get_security_label()
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        David Quigley <dpquigl@davequigley.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 15, 2021 at 6:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> An xattr 'get' handler is expected to return the length of the value on
> success, yet _nfs4_get_security_label() (and consequently also
> nfs4_xattr_get_nfs4_label(), which is used as an xattr handler) returns
> just 0 on success.
>
> Fix this by returning label.len instead, which contains the length of
> the result.
>
> Fixes: aa9c2669626c ("NFS: Client implementation of Labeled-NFS")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/nfs/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 2f4679a62712a..28465d8aada64 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5971,7 +5971,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
>                 return ret;
>         if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
>                 return -ENOENT;
> -       return 0;
> +       return label.len;
>  }
>
>  static int nfs4_get_security_label(struct inode *inode, void *buf,
> --
> 2.29.2
>

Ping. It's been almost 2 months now, and I can't see the patch applied
anywhere, nor has it received any feedback from the NFS maintainers...
Trond? Anna?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

