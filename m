Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0434C433E0
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 01:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C504522581
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 01:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbhAEBrV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 20:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbhAEBrV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 20:47:21 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C5FC061795
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 17:46:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w1so39244929ejf.11
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 17:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hrL5P+/Wig9xYysoWEcy4T3JLi4US3r4Bv0ZgQacj8=;
        b=QGvNoQsWStPPb6xdOkIN/piMqURakstCS2Mna2aXi8B3BGYb6giQsz1ColpHtxZUER
         mynXiG2MJZbId/8jzmsSH8YuN6tj9h1eb/vUE7CxYcX5fVIsiTQZh3tSiKNeN7gB0+Ks
         AmZahrZ0BixGDjz5D25t+RLbtMGYDUBXNGJp/jGZgHjQypZFT3+shjDR03oPJ7Dza85O
         Wu5TAFPKhfQT3HH9v/6lpHcdRX3vUKeb0GCO+pCjzbhNOrt4gE0coUW7ku2IVuy4RLEK
         3FHlM++UwjIzCHnIUhdhdhJf2D7ln2eKDTTVua5RsKy4eSHt+WJ7QuRoonH8hq815mzj
         R2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hrL5P+/Wig9xYysoWEcy4T3JLi4US3r4Bv0ZgQacj8=;
        b=g2zpfgOqp19xz5f2JTgyHoz87f9pg4+ni/NKF7SEN2BoKkx35279jFAMYIg2g4rGW6
         SUw2vp4tAf2+EZUC7UlkFIbfefqA3jR2yOuGt/GzJiKZUwdUhCePZwcFZDjUM95Qb5Ak
         DDIEyMrwNH26VOcfqBZWtme6FBVNC+GW+3P2o/pdgAWR/HCY+DJUVqHeL0BbS0udpJlT
         2j09RR6L9flZkiGHeaw3k8Z0YdiE13SE6HJo62nPdXZMZffS+FDCU5B5pw9FtuwYxhFP
         Iz2lt3mGAPJMyEjUoA1WH7OO2Pu1lBpXhLPR8g06uNhE5Vm512rkqCYsHagiEBFcKLvy
         BYyQ==
X-Gm-Message-State: AOAM530EToE4JdzyxalQVWRhvl/th2xvSzQ+mhkME8bOROheTzQIWswa
        +2bYLjQHkZBdegKkQhXY7+ui6wixhQafAhhZgBCy
X-Google-Smtp-Source: ABdhPJy2T7Ko01GO47eJ4gxrh0L10Y7nFSvwcvSBg6cA5ykWeWQFAX7CLMZ0Bjj1qsdAsZpVixMHl7CWXW/BWodNnB0=
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr70964123ejc.178.1609811199726;
 Mon, 04 Jan 2021 17:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20201219100527.16060-1-amir73il@gmail.com> <CAFqZXNtcX54bv2xeQ26_i-=9OkdiJQQzPOveY=aaujOWJjGWLA@mail.gmail.com>
In-Reply-To: <CAFqZXNtcX54bv2xeQ26_i-=9OkdiJQQzPOveY=aaujOWJjGWLA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Jan 2021 20:46:28 -0500
Message-ID: <CAHC9VhQfh7BH_brRZqk9OgC+93qXz=M07MZ5NVeLQ==5YQS2Kg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix inconsistency between inode_getxattr and inode_listsecurity
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Michael Labriola <michael.d.labriola@gmail.com>,
        Jonathan Lebon <jlebon@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Stable maillist <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 4, 2021 at 4:39 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sat, Dec 19, 2020 at 11:07 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > When inode has no listxattr op of its own (e.g. squashfs) vfs_listxattr
> > calls the LSM inode_listsecurity hooks to list the xattrs that LSMs will
> > intercept in inode_getxattr hooks.
> >
> > When selinux LSM is installed but not initialized, it will list the
> > security.selinux xattr in inode_listsecurity, but will not intercept it
> > in inode_getxattr.  This results in -ENODATA for a getxattr call for an
> > xattr returned by listxattr.
> >
> > This situation was manifested as overlayfs failure to copy up lower
> > files from squashfs when selinux is built-in but not initialized,
> > because ovl_copy_xattr() iterates the lower inode xattrs by
> > vfs_listxattr() and vfs_getxattr().
> >
> > Match the logic of inode_listsecurity to that of inode_getxattr and
> > do not list the security.selinux xattr if selinux is not initialized.
> >
> > Reported-by: Michael Labriola <michael.d.labriola@gmail.com>
> > Tested-by: Michael Labriola <michael.d.labriola@gmail.com>
> > Link: https://lore.kernel.org/linux-unionfs/2nv9d47zt7.fsf@aldarion.sourceruckus.org/
> > Fixes: c8e222616c7e ("selinux: allow reading labels before policy is loaded")
> > Cc: stable@vger.kernel.org#v5.9+
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  security/selinux/hooks.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6b1826fc3658..e132e082a5af 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3406,6 +3406,10 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
> >  static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
> >  {
> >         const int len = sizeof(XATTR_NAME_SELINUX);
> > +
> > +       if (!selinux_initialized(&selinux_state))
> > +               return 0;
> > +
> >         if (buffer && len <= buffer_size)
> >                 memcpy(buffer, XATTR_NAME_SELINUX, len);
> >         return len;
> > --
> > 2.25.1
>
> Looked at the logic in vfs_listxattr() and this looks reasonable.

Agreed, this looks good to me too; I'll merge it into selinux/next.
Thanks everyone!

-- 
paul moore
www.paul-moore.com
