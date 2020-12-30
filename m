Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE096C433E0
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 09:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5ED20791
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 09:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgL3Jbn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Dec 2020 04:31:43 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:46664 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgL3Jbn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Dec 2020 04:31:43 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8164C564C2F
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 10:30:59 +0100 (CET)
Received: by mail-oi1-f181.google.com with SMTP id x13so18172526oic.5
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 01:30:59 -0800 (PST)
X-Gm-Message-State: AOAM533/V2eQlIxEyVV15Qo8kPYhZEeaLIudNsxQMVyIoQbBp33qfmGW
        d8ef56zxvP9SQpuZtR3Po/omqr61maox3McSRZI=
X-Google-Smtp-Source: ABdhPJwceVegPrrJBdQr5Q+vUqlms0oDBC+VuZt5tCkVsWL4xI6wbOy5Z7e0TPj7dmg388wIiQrgzeI1GAGbrNN29No=
X-Received: by 2002:aca:51d8:: with SMTP id f207mr4807026oib.20.1609320658353;
 Wed, 30 Dec 2020 01:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20201218125430.245995-1-plautrba@redhat.com>
In-Reply-To: <20201218125430.245995-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 30 Dec 2020 10:30:46 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=n9cRFn-FJEhsB1ePXkK2CxyT1XaoBF6R+EFc57fpjYuw@mail.gmail.com>
Message-ID: <CAJfZ7=n9cRFn-FJEhsB1ePXkK2CxyT1XaoBF6R+EFc57fpjYuw@mail.gmail.com>
Subject: Re: [PATCH] Revert "libsemanage/genhomedircon: check usepasswd"
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Vit Mojzis <vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Dec 30 10:31:00 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 18, 2020 at 1:56 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> This reverts commit ce46daab7cc90a6b9cd3bff9f99cf40ff19c3d9a.
>
> The behavior described in the reverted commit is correct. `useradd -Z`
> creates new mapping between new created user and *unconfined_u*,
> `genhomedircon` then uses this new mapping, not /etc/passwd entries, for
> generating new homedir contexts.

I confirm this behavior. On Fedora 33 (with git master of the
userspace libraries and "usepasswd=False" in
/etc/selinux/semanage.conf):

# useradd -Z unconfined_u -d /tmp test
# matchpathcon /tmp
/tmp unconfined_u:object_r:user_home_dir_t:s0

# semanage login -l
Login Name           SELinux User         MLS/MCS Range        Service

__default__          unconfined_u         s0-s0:c0.c1023       *
root                 unconfined_u         s0-s0:c0.c1023       *
test                 unconfined_u         s0-s0:c0.c1023       *

# semanage login -d test
# matchpathcon /tmp
/tmp system_u:object_r:tmp_t:s0

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I applied the commit (as it was sent quite some time ago). Thanks!
Nicolas

>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libsemanage/src/genhomedircon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 18d3d99a1254..d08c88de99a7 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -1332,7 +1332,7 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
>                         s->fallback->home = NULL;
>                 }
>         }
> -       if ((s->usepasswd) && (user_context_tpl || username_context_tpl)) {
> +       if (user_context_tpl || username_context_tpl) {
>                 if (write_username_context(s, out, username_context_tpl,
>                                            s->fallback) != STATUS_SUCCESS) {
>                         retval = STATUS_ERR;
> --
> 2.29.2
>

