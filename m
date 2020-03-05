Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB95AC3F2CD
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 13:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDC52072A
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 13:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLfQ58KN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCENM0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:12:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39817 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCENM0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 08:12:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id x97so5586959ota.6
        for <selinux@vger.kernel.org>; Thu, 05 Mar 2020 05:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1VzmitiwJstguh/Ifdku8GfsMpR590mtjqIhHjzuCc=;
        b=BLfQ58KNTJBwaAmhXN/d++u4YLWbPoeGsox++tUlH0sj82Ww8+pUuQv6wKE/Wik5Il
         jgA1Z7n0yE1VgV9Ih0dAQ/H0ynxOslAAOQ7mFbpE8+9ymbL9k3i3yWAW50Wx3g3Dvgtv
         ealiM4sBc1zPhV2i/7x9O+IIUgx4b+fvpYTt61oI7Fyg3P6tG2oJssTUQC1075V/2FLp
         CtJLr7N92F0YyhE/M6GSL0eUhuW7/rV/Snz42hkYPYsQ3rL4mOtwMgCqAi3CR07iWXU+
         Bc05eje/UIcDAGyKz7SCl7pxyCFzrf1nGRJSwTUSM+IzTLjkd4dMhcleSAsJDwumKVNN
         TD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1VzmitiwJstguh/Ifdku8GfsMpR590mtjqIhHjzuCc=;
        b=HTT827PjELUSMUFblaWKzWJObKQbTyLXYpG+3886i+z2LueZy7AzsPRzOMXvIOQUa7
         BmPeyeboXBAylUhHNTHese/1xmrxXzZyXWvTZTS5gINjrQMxsCh7e9zWJINZwTUYl+/v
         KXXM9vPeGRQJ36zUDpm7yxEXsI8+GPHJIe+HimOHjdSneYzCXDVj50AghAbFyA5a9I+3
         7/cHX8fuGfQobqMzyYPO/gG091/qQJzEkCog1stWKyVp6hXIUsnk1Uhj7EnD7gUA9JRP
         MowsCbsR72MB+fgzio+YB7+22nSmpig8Xcp14ks85Wx1Oh1N+2CnFRHdd58+QOpPGJWo
         Gy0g==
X-Gm-Message-State: ANhLgQ1A1mZPKvAAfZfGdos1PElCUvwSVgspXhXOR8Z2ZhfuPfrsgA1W
        A71+vwGqaMZMhkgTldk/LXmUeC6WtWlw7kBATpM=
X-Google-Smtp-Source: ADFU+vuTzA6PCaApFOHAydVer0kZK7JwjS0OvcvXCJFFKoHGcSo+Y5vZysKeAXg0wTdZdLXCPw8Gxm1kecfvYsA+xNk=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr6310786otr.89.1583413945225;
 Thu, 05 Mar 2020 05:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20200304094947.181153-1-omosnace@redhat.com>
In-Reply-To: <20200304094947.181153-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 5 Mar 2020 08:13:38 -0500
Message-ID: <CAEjxPJ5z11Z+qmSrm+6i_Tti_xm_NBBY20GOmLXS1LFQp8f5iA@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol/cil: raise default attrs_expand_size to 2
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 4:50 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Tne value attrs_expand_size == 1 removes all empty attributes, but it
> also makes sense to expand all attributes that have only one type. This
> removes some redundant rules (there is sometimes the same rule for the
> type and the attribute) and reduces the number of attributes that the
> kernel has to go through when looking up rules.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  libsepol/cil/src/cil.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index d222ad3a..31380e8b 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
>         (*db)->disable_dontaudit = CIL_FALSE;
>         (*db)->disable_neverallow = CIL_FALSE;
>         (*db)->attrs_expand_generated = CIL_FALSE;
> -       (*db)->attrs_expand_size = 1;
> +       /* 2 == remove attributes that cointain none or just 1 type */

s/cointain/contain/
