Return-Path: <SRS0=r71v=SA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E4BC43381
	for <selinux@archiver.kernel.org>; Fri, 29 Mar 2019 13:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627E1217F5
	for <selinux@archiver.kernel.org>; Fri, 29 Mar 2019 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="m8WFbdHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfC2Nd3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:33:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34224 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfC2Nd3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Mar 2019 09:33:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id y18so1476380lfe.1
        for <selinux@vger.kernel.org>; Fri, 29 Mar 2019 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ICLxlDvgOXE4niicJPsCQr3ooMrxPK2Z74nUDjEIeY=;
        b=m8WFbdHW28fcxm+5UfO0FtHXYBbM/Xbf4LSBwq4Xcilq5HeIE+uyjuAxfwY7alyWc5
         +Y3RVxG6cXDj9PTz+xaVlvzN6gfdkrSS/BNXI2mCMdJrS+uyJnxhM9SH11yhd83Ge9gf
         i7bwwEjGZ4y960idznfMTm+PcrenqdPObT99v5DctG8EUZ9igOSMvUrFz4rva93t2rvM
         8NU05flTEmOjrl0gkxu1nfcfzc5rzRsaIvZhwK3dlOzv3w53IdczjLtNuUmoVi34HqKb
         rCs9x0MCi49GGs4oBekAlY/6SsOt3BeEBfh4NghOAV0fHptR5tdcmn+BUZOYfRb/4eH9
         o1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ICLxlDvgOXE4niicJPsCQr3ooMrxPK2Z74nUDjEIeY=;
        b=lGvXUcxrBY/7NgMbua7/4cZb1mSF7d+micC9ywRkYn/92g4gIpBznw2ho6JfQIDNZs
         ICOl5cl+5BiVx9x0Or6MgswJaskazU7gTFeAJ3AfXAIyu8z0ewjzVd/PetOJLpXpNwRZ
         POfdU4IPUCopiQb+JqrpQ5dYjLMB05yvPj7bN7yGSVMvUpgwiodDv20sHGpMwwgKdd6o
         /ItuEd7FSFPDGbIX2Js19QV7huVpzk4s4+1tkyJ+CM4Yxd3GKL6egTNEteAkIntSoy4o
         NAzcysHTSI/YPjJWGTdFPQROTr6Bz7z4cm63Yx5x8Mn6mW/wY2hd5YomFiDYSBPgZ9sT
         L7YA==
X-Gm-Message-State: APjAAAXig4MXjPm796yUFPRPqZ2XlTkuhiIqo5ovPIx+rh/vwjGNVMtY
        PL3UnZq6ZI541SjFlAtT9pCtgFyTD/W0C6UMfncc
X-Google-Smtp-Source: APXvYqxB583nnq5Y6ayoEtszTyM3UbDnC7mctZFHKlYt8qwRK7NU7UgIvKzooU8U2PWU3IpBtazZEsyYBCkCFNV2bww=
X-Received: by 2002:a19:c784:: with SMTP id x126mr7423601lff.91.1553866407256;
 Fri, 29 Mar 2019 06:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190325232125.1781-1-casey@schaufler-ca.com> <CAHC9VhRJUxnEyFvJQ3PR+aQTnGt=GZ+EZ-oBQihEE9WgQ9n5EA@mail.gmail.com>
In-Reply-To: <CAHC9VhRJUxnEyFvJQ3PR+aQTnGt=GZ+EZ-oBQihEE9WgQ9n5EA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 29 Mar 2019 09:33:16 -0400
Message-ID: <CAHC9VhReNxpWNg6WfCShRijO+AWC9TR8dzCP8COwz_Qe0xr4wA@mail.gmail.com>
Subject: Re: [PATCH] Bad file pattern in 'SELINUX SECURITY MODULE'
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 25, 2019 at 7:52 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Mar 25, 2019 at 7:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > The include/linux/selinux.h file has been removed.
> > Remove the entry from the MAINTAINERS file.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3e5a5d263f29..1039c34dff3c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13947,7 +13947,6 @@ W:      https://selinuxproject.org
> >  W:     https://github.com/SELinuxProject
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> >  S:     Supported
> > -F:     include/linux/selinux*
>
> This is fine with me, but if we're updating this file, we should
> probably add the following:
>
> F: include/uapi/linux/selinux_netlink.h

Are you going to update this Casey or should I?

> >  F:     security/selinux/
> >  F:     scripts/selinux/
> >  F:     Documentation/admin-guide/LSM/SELinux.rst

-- 
paul moore
www.paul-moore.com
