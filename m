Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11ADC00523
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 08:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B4A20692
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 08:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8vZ8h0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgAHIV0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:21:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726482AbgAHIV0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 03:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578471685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e7Se5RL9B0E6GFyUvxUX223EeRafTYuLsBZVuTPT7ng=;
        b=g8vZ8h0j6I7Vkr37PG6qpRylXbYSx/7ugzNfmneGQLmnlLarR23oxzDMTe7p4/5OosT6+U
        dm5kmrVC32DO1fYrxE6Z/2quIekplOWG9sPSD0Y7X8fAZeKSE1/toCCRihCJ/UNF7ygf19
        k7jFmdW7eDhxu7NOeC6PvIvc6WhEKAE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-Dm5TWAxyNKKzPzgk1FMkNA-1; Wed, 08 Jan 2020 03:21:24 -0500
X-MC-Unique: Dm5TWAxyNKKzPzgk1FMkNA-1
Received: by mail-ot1-f69.google.com with SMTP id t10so1302093otc.9
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2020 00:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7Se5RL9B0E6GFyUvxUX223EeRafTYuLsBZVuTPT7ng=;
        b=VUqwmhfPh7TqxoDJU6EtdgaHauOmNt4cUKrI7H+IeCugONTzC0ervpbhOnH6+DPmPB
         qT88VERCuaFIwi5KW2TCunpJwlSyOGUga0Yvbx8hNpIUe+Iyiwci5/ZysAMvSpQPQXNb
         Wvpcw7+G/xQExhRq26261XTLgsjFL417emcQrBEFRSR/ye6IAFgpVYwPqaiUMlcniSHc
         saU8JA6HJwVTdojDqo08FXHQXgkQb4lJWiS96f/ueYMZlxA4aoJmSdAwq2Kr7wJkcJq+
         /StyxhFDWkY5P6NZBIVzFtFikcddOpHW9ePIeXJKzuW4/RFay8B8AJJ5KRumvK5JYnDC
         42UA==
X-Gm-Message-State: APjAAAUBavfFtJNJZ/xCFqIAN7V+JGQA2tI+5aYWK3WQA6mMZeWqX8m1
        3btuqM/f3BIqTnk44IuLR1aQXM37ESe1aLGXTiaTb7W7ezBf81dr5yElleUubkYn7moGxVTDPj6
        MwPQntA8AkOpvFkkGTRUZqQBqVxp4aZ3kag==
X-Received: by 2002:aca:f555:: with SMTP id t82mr2231942oih.103.1578471683333;
        Wed, 08 Jan 2020 00:21:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwtFm6rnY9DPj7Xuqn9BiyyPOm+yWADJ3BukCZR93lpup6VdWqBAXHSS9PHX3uV2wfSRhv9U51eGj2vCeEciQE=
X-Received: by 2002:aca:f555:: with SMTP id t82mr2231921oih.103.1578471683094;
 Wed, 08 Jan 2020 00:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-3-omosnace@redhat.com>
 <alpine.LRH.2.21.2001080653220.575@namei.org>
In-Reply-To: <alpine.LRH.2.21.2001080653220.575@namei.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Jan 2020 09:21:11 +0100
Message-ID: <CAFqZXNvbNqrTJWxdQU4P-7O-kLRcGW+QcL7LY5Ca8rULLm2ScA@mail.gmail.com>
Subject: Re: [PATCH 2/2] security,selinux: get rid of security_delete_hooks()
To:     James Morris <jmorris@namei.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 7, 2020 at 9:00 PM James Morris <jmorris@namei.org> wrote:
> On Tue, 7 Jan 2020, Ondrej Mosnacek wrote:
>
> > The only user is SELinux, which is hereby converted to check the
> > disabled flag in each hook instead of removing the hooks from the list.
> >
> > The __lsm_ro_after_init macro is now removed and replaced with
> > __ro_after_init directly.
> >
> > This fixes a race condition in SELinux runtime disable, which was
> > introduced with the switch to hook lists in b1d9e6b0646d ("LSM: Switch
> > to lists of hooks").
> >
> > Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  include/linux/lsm_hooks.h    |  31 --
> >  security/Kconfig             |   5 -
> >  security/apparmor/lsm.c      |   6 +-
> >  security/commoncap.c         |   2 +-
> >  security/loadpin/loadpin.c   |   2 +-
> >  security/lockdown/lockdown.c |   2 +-
> >  security/security.c          |   5 +-
> >  security/selinux/Kconfig     |   6 -
> >  security/selinux/hooks.c     | 742 ++++++++++++++++++++++++++++++-----
> >  security/smack/smack_lsm.c   |   4 +-
> >  security/tomoyo/tomoyo.c     |   6 +-
> >  security/yama/yama_lsm.c     |   2 +-
> >  12 files changed, 654 insertions(+), 159 deletions(-)
>
> Please separate the changes for each LSM into separate patches (the
> __lsm_ro_after_init removal patch can be last).
>
> >  config SECURITY_SELINUX_DEVELOP
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 47ad4db925cf..9ac2b6b69ff9 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -650,13 +650,15 @@ static int selinux_set_mnt_opts(struct super_block *sb,
> >  {
> >       const struct cred *cred = current_cred();
> >       struct superblock_security_struct *sbsec = sb->s_security;
> > -     struct dentry *root = sbsec->sb->s_root;
> >       struct selinux_mnt_opts *opts = mnt_opts;
>
> Seems like there are a bunch of unrelated cleanups mixed in here.

These are not unrelated - we need to avoid dereferencing the security
structs before checking selinux_disabled(), because they may be NULL
or uninitialized when SELinux has been diabled.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

