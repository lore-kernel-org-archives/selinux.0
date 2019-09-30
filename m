Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A820C32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41C020842
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmHYy+d3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfI3N6Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:58:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34462 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729738AbfI3N6Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 09:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569851903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaFVUfarRO5zGetWSwejQO6+5dfmXR8BGCYlrqKYqVY=;
        b=YmHYy+d3+hoUId3zyMP3mx475pDbRZvVpPVDVr+ybmw1aiPqlwVmMLphWOqCrzOO/bEyJm
        0pAXx+lt+Ngtc/NpeLVHimj94xt6G31HRqgdKQmqx78bVM/vOGqaOVNVJY0Bl6V6DjV99M
        /ACxxZReE+KGi3CGyfdTUV6XOKUoQbE=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-0HMWZWLJN_ytHoJkb7woeA-1; Mon, 30 Sep 2019 09:57:09 -0400
Received: by mail-oi1-f199.google.com with SMTP id 74so7246590oie.3
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2019 06:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaFVUfarRO5zGetWSwejQO6+5dfmXR8BGCYlrqKYqVY=;
        b=ihb+uxtQUuA4RNNwJ4hzlyd3iF0KwCuGJynoT8XxFeovgrSpOcx1gcY3tgaysoItbX
         KTshJ2mhJGs/THuUonje0Qo6KJiItmZVoC+RKAi6/WBRywgDy4KytaPWPkV41j9tYE1e
         yLwu3owRSgQbl416S2m9L+ApKmgW2lmz3P2Y5CllD5+JxCjsMe3wGBYaAYwTS4h4n0iq
         pK7e4pibhnHBUBgOqZxzVMEiPwd20NkdYhSNKgT5TBtooKbh0U8cbHK8w4JDRxtDGibo
         9W3z0Msqp7NRKYe01Nl0j3CQVKKdGpBbwky73BevUGn9swB9hZshzZRHf5icuY9Hxkfx
         PnCg==
X-Gm-Message-State: APjAAAWvgAyo4ojHVGOQr8fz6nxKRifygiImXB4NeaHDwxPy0bD6f0+n
        8KtyYERxo9FbuX9APiwoYgavB07djGYB10MI/taPN9H7v6/4YO05+ypOviVB5wAjzST1PGfhqDI
        9QW5B5yIHJ+dUoon5ad6XJRH+ONihPq0Mqw==
X-Received: by 2002:a9d:625a:: with SMTP id i26mr12986398otk.43.1569851828713;
        Mon, 30 Sep 2019 06:57:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNPa3pVGm11Q3TCmCqccyYgaIFkbZCQH+fxd1Y7tjzOfqKUQlST+7UJRrzVAd16r8lUNBlC99Ip5fLnBGZ4hw=
X-Received: by 2002:a9d:625a:: with SMTP id i26mr12986377otk.43.1569851828326;
 Mon, 30 Sep 2019 06:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190930104850.5482-1-omosnace@redhat.com> <20190930104850.5482-2-omosnace@redhat.com>
 <6df6dafe-56a6-7de0-0196-d2b714b453bb@tycho.nsa.gov>
In-Reply-To: <6df6dafe-56a6-7de0-0196-d2b714b453bb@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 30 Sep 2019 15:56:57 +0200
Message-ID: <CAFqZXNsKBJ6TtfgpnEVBxxN4J3i02ak7A6XaUkQNzzrMmAYFJA@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/3] policy: consolidate macros for home dirs access
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: 0HMWZWLJN_ytHoJkb7woeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 30, 2019 at 3:24 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/30/19 6:48 AM, Ondrej Mosnacek wrote:
> > Use userdom_search_generic_user_home_dirs(), which is always defined,
> > and redefine it to match what overlayfs was doing (just in case),
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   policy/test_overlayfs.te | 6 ++----
> >   policy/test_policy.if    | 9 +++++++--
> >   2 files changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
> > index 6f1756e..f56ef78 100644
> > --- a/policy/test_overlayfs.te
> > +++ b/policy/test_overlayfs.te
> > @@ -50,8 +50,7 @@ fs_mount_xattr_fs(test_overlay_mounter_t)
> >   corecmd_shell_entry_type(test_overlay_mounter_t)
> >   corecmd_exec_bin(test_overlay_mounter_t)
> >
> > -userdom_search_admin_dir(test_overlay_mounter_t)
> > -userdom_search_user_home_content(test_overlay_mounter_t)
> > +userdom_search_generic_user_home_dirs(test_overlay_mounter_t)
> >
> >   mount_exec(test_overlay_mounter_t)
> >   mount_rw_pid_files(test_overlay_mounter_t)
> > @@ -122,8 +121,7 @@ corecmd_exec_bin(test_overlay_client_t)
> >   kernel_read_system_state(test_overlay_client_t)
> >   kernel_read_proc_symlinks(test_overlay_client_t)
> >
> > -userdom_search_admin_dir(test_overlay_client_t)
> > -userdom_search_user_home_content(test_overlay_client_t)
> > +userdom_search_generic_user_home_dirs(test_overlay_client_t)
> >
> >   fs_getattr_xattr_fs(test_overlay_client_t)
> >
> > diff --git a/policy/test_policy.if b/policy/test_policy.if
> > index 5f4000f..40e7499 100644
> > --- a/policy/test_policy.if
> > +++ b/policy/test_policy.if
> > @@ -61,8 +61,13 @@ interface(`userdom_sysadm_entry_spec_domtrans_to',`
> >   ')
> >   ')
> >
> > -ifdef(`userdom_search_generic_user_home_dirs', `', ` dnl
> > +ifdef(`userdom_search_admin_dir', ` dnl
> >   interface(`userdom_search_generic_user_home_dirs', `
> > -    userdom_search_user_home_dirs($1)
> > +    userdom_search_user_home_content($1)
> > +    userdom_search_admin_dir($1)
> > +')
> > +', ` dnl
> > +interface(`userdom_search_generic_user_home_dirs', `
> > +    userdom_search_user_home_content($1)
> >   ')
> >   ')
>
> Previously, if userdom_search_generic_user_home_dirs() was defined by
> the base policy (as it used to be), we would use that definition, else
> we would use userdom_search_user_home_dirs(). After, we will always
> redefine it, and the redefinition is more expansive than just search
> access to $HOME and its ancestors in the hierarchy.  Might not affect
> the tests themselves but it seems a bit confusing.

You're right, I'm mixing up the semantics too much. Let me see if I
can handle this more nicely...

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

