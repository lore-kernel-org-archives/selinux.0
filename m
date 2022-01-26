Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C22CC433F5
	for <selinux@archiver.kernel.org>; Wed, 26 Jan 2022 23:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiAZXBn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jan 2022 18:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiAZXBn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jan 2022 18:01:43 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD4CC06173B
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 15:01:42 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id n10so1234103edv.2
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 15:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hrY2ypU0UcUzpuu0HvUTLlqvcOyvCuZ5uizVCmG3Y+w=;
        b=156HEm9ggPBMtKmoA1cSwYVY8LRaPIaePKKm5brqfy6Hg5Vd33JEYnRffn1YfXbjBu
         5PQzcEDO2OOp7L+L6hE8FjtNF0o+9euUc80AUFcW7DsXEZuOsgyf7fn/a2Kr+k81kO0h
         X501ZPQTRFaCNdwavx84Jv8iUjqaVQfhEI96RUn7DENBN30GVn6NnsRFBOyAAWk+KYXC
         An/BnQdJQbQlNc/xdYqaDO28aQ4WChARmRIfQZMcgbols5NU8GKsDcgem0fX8YQor+1n
         97Aa0aEfyAwAgVtcZFHN/yWwZmevAJrOHiD7oktGU3yyrHiCHwAI8/hupVG/wMRZqQ9d
         uTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hrY2ypU0UcUzpuu0HvUTLlqvcOyvCuZ5uizVCmG3Y+w=;
        b=PQvE/2BKklmLcSAY3zB9UP/jW2NbL0tthcE/W7P400aWexy2grl+AC2Ltz3CPYjEzH
         cfHU8CvQ8XFaShz7WFfCj+wZ/nb/EooCVHLj2E5m8sY4g2PjZyd84GZAfYtYRZ5z7iqD
         uDpOQkAZaocjocNaWlg63Df+bStpkoTNfUBu8IDXwEPMPyzq7jpdJEJdyCSBjpVq8SUk
         MehpLYCU06BP5TlYBzhcwhQohTDfWY29Tqwin6SWj2FKOwMaqN3iXENjklVkslPVLs9i
         LWXDicudX4itJ5wSdLwx98RBGk2ZP+WszrkB9c79tbj9uwNoJb1B+HWE/yrIfWpDsO3B
         CEoQ==
X-Gm-Message-State: AOAM530+9epas8G+sYzkq0oy6b7pAhmuPd0CHMnNcrPbJ2r+4O3nK2GL
        DW8/ZFMD2nZHHAKRctjO3kRv2LprLAVQhqKHYNFV
X-Google-Smtp-Source: ABdhPJxIKOsEIfJTFhstoFnygEcu2edsCxb/edCGSMTyG99GpPkZvv/0HQ9atKeEH1Dbj6XG8KgRPxB252BRD34Xfs0=
X-Received: by 2002:a50:ef16:: with SMTP id m22mr1130661eds.340.1643238101310;
 Wed, 26 Jan 2022 15:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20220125143304.34628-1-cgzones@googlemail.com>
In-Reply-To: <20220125143304.34628-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 18:01:30 -0500
Message-ID: <CAHC9VhSdGeZ9x-0Hvk9mE=YMXbpk-tC5Ek+uGFGq5U+51qjChw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: create security context for memfd_secret inodes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 9:33 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Create a security context for the inodes created by memfd_secret(2) via
> the LSM hook inode_init_security_anon to allow a fine grained control.
> As secret memory areas can affect hibernation and have a global shared
> limit access control might be desirable.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> An alternative way of checking memfd_secret(2) is to create a new LSM
> hook and e.g. for SELinux check via a new process class permission.
> ---
>  mm/secretmem.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

This seems reasonable to me, and I like the idea of labeling the anon
inode as opposed to creating a new set of LSM hooks.  If we want to
apply access control policy to the memfd_secret() fds we are going to
need to attach some sort of LSM state to the inode, we might as well
use the mechanism we already have instead of inventing another one.

> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 22b310adb53d..b61cd2f661bc 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -164,11 +164,20 @@ static struct file *secretmem_file_create(unsigned =
long flags)
>  {
>         struct file *file =3D ERR_PTR(-ENOMEM);
>         struct inode *inode;
> +       const char *anon_name =3D "[secretmem]";
> +       const struct qstr qname =3D QSTR_INIT(anon_name, strlen(anon_name=
));
> +       int err;
>
>         inode =3D alloc_anon_inode(secretmem_mnt->mnt_sb);
>         if (IS_ERR(inode))
>                 return ERR_CAST(inode);
>
> +       err =3D security_inode_init_security_anon(inode, &qname, NULL);
> +       if (err) {
> +               file =3D ERR_PTR(err);
> +               goto err_free_inode;
> +       }
> +
>         file =3D alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
>                                  O_RDWR, &secretmem_fops);
>         if (IS_ERR(file))
> --
> 2.34.1

--=20
paul-moore.com
