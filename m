Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88605C2BB1D
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 15:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C2C206BE
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 15:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0xoqEs2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCLPBe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:01:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40996 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgCLPBd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 11:01:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id m25so7784426edq.8
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2020 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKoaPQev/MRWLO0G4hKp+pGK6Th2Ntn2OaPXZ3kTqOk=;
        b=0xoqEs2k7Y06PEHkLVm6FG7TsdfFdzAjMN3ApP482qXwMtovzGiKqb8X2z+wyWueqK
         De7RKcUF4c+hbIQdcqrUND7aOcJePcVP30XTO9Mce594q8KQMi5T9jC61v1YdmZfLU0H
         U5xfRQu1Ir1MTKAKyzut3iyG+NHJkxInt415MDsZVr4VHwVZMm2IKOXi75SmmAOVujEw
         JCgXuIAbyZblEQ7zKdjckXN8htm1VggwKTgXJOKCNAXm88xmwJQGg8bSOlytvGCZ3v3G
         JeiEJUJmE6ol6GUgaMi64GJMp5LBexkCnGYVOmAul2vsrFmWF+sNMvwElgD62FfNH0Y8
         ae6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKoaPQev/MRWLO0G4hKp+pGK6Th2Ntn2OaPXZ3kTqOk=;
        b=mYfnu7oGbhR8sMh/UNzlQl0J4Jb10J/SjXveKwt2dAEMZcxz4TUydyXooBHf9blovW
         8Wc7lIuqBv/F6mTk3zEkPhY/006kkmB7aHLZRe+YIxSexMFmBVOTvd3fphSCoMFrndFJ
         sawS1zOdsfzBHINwEABU4HrNfEvUPCQ0vZ6JlwejlJ56hOeI9nNaBSPObp/KM+9CeRu+
         p0q15Gr/1FtblwTjJjW1PlYuUilUNOzUhNq3/FEvC5c0+NUUe1YCh4PfJFhC1PWqfoXs
         ujtm3EVk93+Yu3yczyLV4c2CMHtBl4GsvGEd89gqrU3DF6TGAr/G5bWg/pepIPFwEeve
         7UxQ==
X-Gm-Message-State: ANhLgQ267ROad7y0cD/KMcNDEPmnLdHCH+N4/5/2JaRNCLKZetPBQsuY
        AkTTnSz0MZNZQoX6lIpmTzx2SkusCC1juVmcxa37
X-Google-Smtp-Source: ADFU+vu3LQZGvzr1DGVxzMxkoIm0bjosn76smAUryMroTJfTzuwXhTIdK7dLwEh07NvxVSGiLfrkmd74LfZf2lnZkyQ=
X-Received: by 2002:a05:6402:282:: with SMTP id l2mr8243909edv.269.1584025292144;
 Thu, 12 Mar 2020 08:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200311200551.9306-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200311200551.9306-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Mar 2020 11:01:21 -0400
Message-ID: <CAHC9VhSozFswmubx916UtgJyv1o1njC9j-4L90bb714t-on27g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update my email address
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 11, 2020 at 4:06 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Stephen Smalley <sds@tycho.nsa.gov>
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks Stephen.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0b370797e8a6..e343b2c75fbc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14974,7 +14974,7 @@ X:      security/selinux/
>
>  SELINUX SECURITY MODULE
>  M:     Paul Moore <paul@paul-moore.com>
> -M:     Stephen Smalley <sds@tycho.nsa.gov>
> +M:     Stephen Smalley <stephen.smalley.work@gmail.com>
>  M:     Eric Paris <eparis@parisplace.org>
>  L:     selinux@vger.kernel.org
>  W:     https://selinuxproject.org
> --
> 2.17.1

-- 
paul moore
www.paul-moore.com
