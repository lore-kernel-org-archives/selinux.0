Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EB6C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 Jan 2021 17:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D1B2399A
	for <selinux@archiver.kernel.org>; Fri, 15 Jan 2021 17:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbhAORYZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Jan 2021 12:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733209AbhAORYX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Jan 2021 12:24:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14449C0613C1
        for <selinux@vger.kernel.org>; Fri, 15 Jan 2021 09:23:43 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id p22so10350301edu.11
        for <selinux@vger.kernel.org>; Fri, 15 Jan 2021 09:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJrsR9g+dyqkkVVvYtEu6xfD1Zo92dOcpjjoxvFadQo=;
        b=ge+GnUbEBLY+2evuY9Uj+uaN2jIYKWBKeP45kxv0m+2jXjz3M/6ABWkT/cxfrrGRq1
         4WNTMkLNR2uAeZ2AccElDyg/YHkMrBs/gGDoGct8UXXHPgz8PXATa6eEOBiANAdkuam1
         rp+M7bSxWpd33oqT8kvS3U/BVZaLAyBg8GWwIsNdEKl63eBd3Rn+7qjvCaDpG6I6LmIz
         ppYSC9rjrXDv9oNatkHLla47fsh0+pBergQGzDv+J33+ulldNGXUtGEltU+CgjYMpawp
         IWlLnc68w4znX2PD84B4cD1COJHGuLzY3SuktMfTPpHDLoXv9Lwn5inJdv8LgtDK3SN3
         jr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJrsR9g+dyqkkVVvYtEu6xfD1Zo92dOcpjjoxvFadQo=;
        b=Z1jTbEZrso9czDLPFXZWwsOfNg/BzqRvoVAL+kLGmyoJg97haEj4o4+686wI0v/FAr
         aJf/9fWapUiOTm2iI9svYaV82JXve7an0x/SRdCpIIDxOjjNXlfaPgoEqqQZ4sQh09sy
         ouijRt2kzKGLcil9L6N+tXa0GeSu/eO5YVlNvSKvkH0vFp73tW14IyuY1Fu5GdIpnYDI
         fLeCXAxyy+ULxBPf3HNjpC2HeoSu7rx5kcF4DyIBBnDk1KxZCDqcffm3M0nOtdwLzXre
         th1EsomSUwBgPkcr7DSVJPesdf5NpqIecYV2RxsABTOoIbcRqv9puZM6cC2gGKRRN/JJ
         dToA==
X-Gm-Message-State: AOAM530wAMTKb6Nf9r+oBoLOdsos7yjtqLzfuAS81SRpyxGEq87esahI
        TeJcbJ2+afVXGGb6g7hFwV8sNCaN1gQ1X6OUJqVB
X-Google-Smtp-Source: ABdhPJxNJ1+S8LITVO12epfE1LpA0SxxE+7Im+Q6DiX6C3VsYyEebNuKAcm5/5AsziFCv15wGpFl9G0psW/zml1Wnk0=
X-Received: by 2002:a05:6402:ca1:: with SMTP id cn1mr10426635edb.128.1610731421674;
 Fri, 15 Jan 2021 09:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20210115120342.8849-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210115120342.8849-1-lukas.bulwahn@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Jan 2021 12:23:28 -0500
Message-ID: <CAHC9VhSfn9Ux_KcDysAH_vOWhiS3TvPYcXYZLg_5pr9Vee0f2g@mail.gmail.com>
Subject: Re: [PATCH] fs: anon_inodes: rephrase to appropriate kernel-doc
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 15, 2021 at 7:03 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit e7e832ce6fa7 ("fs: add LSM-supporting anon-inode interface") adds
> more kerneldoc description, but also a few new warnings on
> anon_inode_getfd_secure() due to missing parameter descriptions.
>
> Rephrase to appropriate kernel-doc for anon_inode_getfd_secure().
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  fs/anon_inodes.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

Merged into selinux/next with the other related LSM/SELinux anon-inode
patches, thank you!

-- 
paul moore
www.paul-moore.com
