Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12202C388F9
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 21:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9F620825
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 21:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKKVT5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:19:57 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:43186 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKVT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 16:19:57 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 62F895612D2
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 22:19:54 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id n15so3522722otl.8
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 13:19:54 -0800 (PST)
X-Gm-Message-State: AOAM531z9UTxDczQYE7JsGb5lQiK04ttaV469/qwhOpaH7ks7MsI380W
        +gPaePyTL9F5Y+YfsToCim+npeSXstEOWzK+utc=
X-Google-Smtp-Source: ABdhPJx0kpSnN2MXiYcjBKYRVR9ScTBAibnZUuMpQbGh9Hg1YLOnt6fZg8M7dnB2Vl6Pk+uWZjMwHmKLY99MnTPQvCc=
X-Received: by 2002:a05:6830:1dc4:: with SMTP id a4mr18263087otj.361.1605129593444;
 Wed, 11 Nov 2020 13:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20201111162340.527105-1-omosnace@redhat.com> <20201111162340.527105-4-omosnace@redhat.com>
In-Reply-To: <20201111162340.527105-4-omosnace@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 11 Nov 2020 22:19:42 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==T9MSFWb5x8fT93mD0ytSa__a_7t=PVWv0nxvFQta2Dw@mail.gmail.com>
Message-ID: <CAJfZ7==T9MSFWb5x8fT93mD0ytSa__a_7t=PVWv0nxvFQta2Dw@mail.gmail.com>
Subject: Re: [PATCH userspace v2 3/3] selinux_config(5): add a note that
 runtime disable is deprecated
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Nov 11 22:19:55 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 11, 2020 at 5:23 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> ...and refer to selinux(8), which explains it further.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policycoreutils/man/man5/selinux_config.5 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/man/man5/selinux_config.5 b/policycoreutils/man/man5/selinux_config.5
> index 1ffade15..8d56a559 100644
> --- a/policycoreutils/man/man5/selinux_config.5
> +++ b/policycoreutils/man/man5/selinux_config.5
> @@ -48,7 +48,7 @@ SELinux security policy is enforced.
>  .IP \fIpermissive\fR 4
>  SELinux security policy is not enforced but logs the warnings (i.e. the action is allowed to proceed).
>  .IP \fIdisabled\fR
> -SELinux is disabled and no policy is loaded.
> +No SELinux policy is loaded.  This option was used to disable SELinux completely, which is now deprected.  Use the \fBselinux=0\fR kernel boot option instead (see \fBselinux\fR(8)).

Hi, there is a misspelling here: deprected -> deprecated. Otherwise
the 3 patches look good to me, thanks!

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Nicolas

