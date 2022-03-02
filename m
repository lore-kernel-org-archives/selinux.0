Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C37FC433EF
	for <selinux@archiver.kernel.org>; Wed,  2 Mar 2022 16:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiCBQEc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiCBQEc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Mar 2022 11:04:32 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046EA35DEE
        for <selinux@vger.kernel.org>; Wed,  2 Mar 2022 08:03:49 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id l25so2075546oic.13
        for <selinux@vger.kernel.org>; Wed, 02 Mar 2022 08:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+mO/5KgZeD187GjMXUJ+aSGUNV1alt2r7CTezjj/gYw=;
        b=F1PpP2gVBrYkGnkye4pYsZhj3QfEIH3QF8bg6L0Tj+RWS3m3e9A6LdjniG5wZwPFas
         VTEGUgz7rVCVOA9v70+d8XpVE/yarcda3lnZNiXGY2iQJ73gcb7bkduF3V/5HWtgf7t4
         fL+DluyukAjHwOnwC2XMrb/x/G+F+GRZdCRW2zr48wEAQgtzIwt9fZwIoJ4zec0kGiQm
         qInKBMQU3Yqz0eVaGgR6y6iyzGLoTzK1qF3EE92fbCxnRGG4Yahv37w/OWGJXTvuguaX
         cQXqw0Bk0HFXTpvGPt6xK6eMRI0g+NkT4xxEipz2j35FG6pKwwo4S9ZxlhAAzuzmvrW9
         76mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+mO/5KgZeD187GjMXUJ+aSGUNV1alt2r7CTezjj/gYw=;
        b=5CmF1Pfqnjvm7m74hJ5ZilKITCn3BDbmspfHrEOKFR28P962RmTWBoJjo0styZ0EoO
         HNfLU1OZxJ/vves5f8093YiE+sIq989tpF/u2JVQxD9lyLCu4f2H2152nRD9bCSO1ir5
         bbYsY/HKwalMaLzpQOYesqJQtzUNDHCPlcrr01bEIKxZgoo/+LYYyrcv2jJ2XUyoxh1i
         zLVvp+doI7/bbu8IHxANlVj0dqDW7S/8rBROVVD73FhzlovKdZQcXtCZrg1uNe7PaIIW
         tFamFmaaSHl+kVK02rakL3Evvt9YM22aq4v0HsrxbKXsBDsuOo9xTxpoRvQKCKnc33gc
         MnOA==
X-Gm-Message-State: AOAM530E/ebf8eHY0+aSAflijKzXS5lajOrczXuup5ja3Ft8eV+hDMMf
        cHm0lcVumDfCpFCI3ZwSANDezDcwV/vUfkpw64dZozOHqjU=
X-Google-Smtp-Source: ABdhPJxx9DoJDg3bmavaOupHO6TRjiFERhF7PdCfOpNeH2Ow7wxH6drziIvdukLO7b09ibw3+LZoEVDWnXmXyHHA79Y=
X-Received: by 2002:a05:6808:1644:b0:2cd:6d80:9af1 with SMTP id
 az4-20020a056808164400b002cd6d809af1mr453761oib.138.1646237028242; Wed, 02
 Mar 2022 08:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20220222135143.30602-1-cgzones@googlemail.com>
In-Reply-To: <20220222135143.30602-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 2 Mar 2022 11:03:37 -0500
Message-ID: <CAP+JOzT5O2XYeZ0499__f9S9mhdDRv+hB_z6syiydNgCj=+sRA@mail.gmail.com>
Subject: Re: [PATCH 1/4] newrole: add Makefile target to test build options
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 23, 2022 at 2:27 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a Makefile target which build newrole with all combinations of
> supported build options.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/newrole/Makefile | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/M=
akefile
> index 4dedb7dd..b3ccf671 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -91,3 +91,16 @@ indent:
>
>  relabel: install
>         /sbin/restorecon $(DESTDIR)$(BINDIR)/newrole
> +
> +test-build-options:
> +       $(MAKE) PAMH=3Dy AUDITH=3Dy AUDIT_LOG_PRIV=3Dy NAMESPACE_PRIV=3Dy=
 clean newrole
> +       $(MAKE) PAMH=3Dy AUDITH=3Dy AUDIT_LOG_PRIV=3Dy NAMESPACE_PRIV=3Dn=
 clean newrole
> +       $(MAKE) PAMH=3Dy AUDITH=3Dy AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=3Dy=
 clean newrole
> +       $(MAKE) PAMH=3Dy AUDITH=3Dy AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=3Dn=
 clean newrole
> +       $(MAKE) PAMH=3Dy AUDITH=3Dy AUDIT_LOG_PRIV=3Dy NAMESPACE_PRIV=3Dy=
 clean newrole
> +       $(MAKE) PAMH=3Dy AUDITH=3Dn AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=3Dy=
 clean newrole
> +       $(MAKE) PAMH=3Dy AUDITH=3Dn AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=3Dn=
 clean newrole
> +       $(MAKE) PAMH=3Dn AUDITH=3Dy AUDIT_LOG_PRIV=3Dy NAMESPACE_PRIV=3Dn=
 clean newrole
> +       $(MAKE) PAMH=3Dn AUDITH=3Dy AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=3Dn=
 clean newrole
> +       $(MAKE) PAMH=3Dn AUDITH=3Dn AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=3Dn=
 clean newrole
> +       $(MAKE) clean
> --
> 2.35.1
>
