Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E12C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 22:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7967223B17
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 22:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbhAVTvf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbhAVTYM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 14:24:12 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110CFC06178B
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 11:23:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g1so7842064edu.4
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 11:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHkKA0SOvAxdor7YGNW/4jTUyWoPWoOOdjiWjrjEynY=;
        b=GRr8xUycUe99wQjmbNBJk/Gn6bETCDEAn/FtKH99rKcnycQZQgyQsJ5uSkacTIYyc7
         MmK7yKSMWBR2f9/JrxeEylL4yhbf0p2HZard6U2gv+wN9bWnaArSc2//lY4NDj5NippY
         zmyYzI/NnLDTKu5aWTcliRuKQgsj7iUFS2dT0NyJPkFPLkoXMdef1WrXKsu83pYsC24E
         RqA9uc49Pa/2iDdZ67XoNLYI5L87lkTUabcW5DWCtv5EgcLopChGFN+8uMKZBCi8fdXt
         IqI9dA8rRxObtDUlJA6vTfxClo080Ogh5FeNp7haSdkcczr0OjcSNKvunn1gqn0987FR
         7OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHkKA0SOvAxdor7YGNW/4jTUyWoPWoOOdjiWjrjEynY=;
        b=Vh/+Qh1TEzI7VN0v5/Pt3CEguylScO5KOqEXGsVNOqiJDdRm/IaSopli8bcLX8d4CN
         82I9L8euN0qIFJTL9tBNnegk/dIWpPEvdYL1FR0pw7KMMf7nJuIkb7JHBk2u4Sk2Ki7b
         b06yD9z10YiwD9jkuUn+4xm5ZfK9fM810rbn9tlql/3nTYUC1d0KguZQX3Ln1OV0HOJu
         cHI1oo2+O79NYyRUXIS5gq6FZOYATr0KMn0+lwcuvjVWeJY9hWiLgArOQt9ADwf1ofAm
         ljNqlc0uRs2I/KQi3r4afRFPj+RKgyuJrYyFErYctVzx+jAgp11u0MF+BUYzU9BkMNgJ
         EnSQ==
X-Gm-Message-State: AOAM533ASceTe4tZKE2l6dtpgWRLCPXODUOGWF70vBhcy4AdDSV2nfIp
        ZYnR4LsjKSlnGU0wTlxkQHd3GJLsMsEDDUe8m6RA
X-Google-Smtp-Source: ABdhPJzT10q1bu1UPFwSuzjQxK3sjeXcPvz3DG75lRloWm85Qrqipie1IDcEOrq/CVmI6bnHaC5GvT0v7KUxd8BRx+k=
X-Received: by 2002:a05:6402:4391:: with SMTP id o17mr4433163edc.196.1611343410639;
 Fri, 22 Jan 2021 11:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20210115174356.408688-1-omosnace@redhat.com>
In-Reply-To: <20210115174356.408688-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jan 2021 14:23:19 -0500
Message-ID: <CAHC9VhQV6k3LhgyvGmWSn+rQpuFY1wK4K-5p=xk-mVdUK6eDnQ@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: fix return value of _nfs4_get_security_label()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        David Quigley <dpquigl@davequigley.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 15, 2021 at 12:47 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
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

Reviewed-by: Paul Moore <paul@paul-moore.com>

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

-- 
paul moore
www.paul-moore.com
