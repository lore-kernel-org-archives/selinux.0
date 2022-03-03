Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21CC433F5
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 18:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiCCSXa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiCCSXa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 13:23:30 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AC1F7463
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 10:22:42 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so5325294otn.2
        for <selinux@vger.kernel.org>; Thu, 03 Mar 2022 10:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1z7iqTc1CZKpqWNx/KI3jYPT1wsEQv5Cf91OnzCOtBw=;
        b=ECg2KRcOl2wtYJifktd4DUoX+BRiOEA7ggQonPUG6h/MH7kHYOaG9N7dnkv2kmwgsH
         r1zMdmhzYKNnG0JjHxQ02LEXgamkOO5ftUDWWvD1FWD8TXRktx9KXt6iPdlKtfT2CePa
         P9pJ7el9b50wibOgZmGpf2XTF5Pm0GWI5j7Y7crQmSikGiil2a5N+edBQWEujsqCciCE
         X2v45496U+EMF2+bb0eN1Tw3onFSKalO6pYCOyh6O8+ed+CqQJwd8SC5Xb0lGBJsISnO
         GrdpUjryG1jlZ+iDvunWpn+lxyaknhxMUYrvE5BMtKrguzrtJdSQbRm1rutUCHeXeQgO
         6T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1z7iqTc1CZKpqWNx/KI3jYPT1wsEQv5Cf91OnzCOtBw=;
        b=ZMzaJ3fd4E8tgZXNynXp8Q/Mil4buhx6xvwricGYyWME7Cz2dJNISFQQVGmZFkGwfI
         7rC6/Xvy6jxvNTlw+E6G7+tqSuxadrTZYeoaR+D2jTa19ZTFzIRWtVgK8sSm04Hdqm0G
         atX2whKDq26mZgvPZWgjNU0j9YvIOeICfr85d82aBYTipxy7eE8NFzOVfpTA2WHXG3IA
         zAUkFOaJUXILT8Ws7wSoeVtFs3yMbhFgUnzyIuvRh583vrYGcePkH9l7z7dXzKQgT+/K
         CGteHsADu5FpPYulPan4UtcOQk8NYqf73ZJEL8vFHyYKz+BCaEbDcemkthNG+uUzNfOe
         dCNw==
X-Gm-Message-State: AOAM531F+I0SFlIFs1yNU066MATc/S//7Jr89XcImnqiANr7r5bgBR/e
        HtbMBUIwvr81snI2fTaOE0BFTqJlWgkiPmanqXCnayyg
X-Google-Smtp-Source: ABdhPJzSHqWt3qqHtce3LCmsiPCarHXXIXM8CIDU99mdIgue3TLJTysZ4y8pa+bKrfZFjI9qcQD6/9yHqPNJcCGNivI=
X-Received: by 2002:a05:6830:2390:b0:5ac:19a3:4888 with SMTP id
 l16-20020a056830239000b005ac19a34888mr19944499ots.53.1646331762312; Thu, 03
 Mar 2022 10:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20220222135143.30602-1-cgzones@googlemail.com> <CAP+JOzT5O2XYeZ0499__f9S9mhdDRv+hB_z6syiydNgCj=+sRA@mail.gmail.com>
In-Reply-To: <CAP+JOzT5O2XYeZ0499__f9S9mhdDRv+hB_z6syiydNgCj=+sRA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Mar 2022 13:22:31 -0500
Message-ID: <CAP+JOzSLFk1gncEGYkzFT1gqOXKCSHgXW+i9syLQDncOxJCuuQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] newrole: add Makefile target to test build options
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 2, 2022 at 11:03 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Feb 23, 2022 at 2:27 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add a Makefile target which build newrole with all combinations of
> > supported build options.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

This series has been merged.
Thanks,
Jim

> > ---
> >  policycoreutils/newrole/Makefile | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole=
/Makefile
> > index 4dedb7dd..b3ccf671 100644
> > --- a/policycoreutils/newrole/Makefile
> > +++ b/policycoreutils/newrole/Makefile
> > @@ -91,3 +91,16 @@ indent:
> >
> >  relabel: install
> >         /sbin/restorecon $(DESTDIR)$(BINDIR)/newrole
> > +
> > +test-build-options:
> > +       $(MAKE) PAMH=3Dy AUDITH=3Dy AUDIT_LOG_PRIV=3Dy NAMESPACE_PRIV=
=3Dy clean newrole
> > +       $(MAKE) PAMH=3Dy AUDITH=3Dy AUDIT_LOG_PRIV=3Dy NAMESPACE_PRIV=
=3Dn clean newrole
> > +       $(MAKE) PAMH=3Dy AUDITH=3Dy AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=
=3Dy clean newrole
> > +       $(MAKE) PAMH=3Dy AUDITH=3Dy AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=
=3Dn clean newrole
> > +       $(MAKE) PAMH=3Dy AUDITH=3Dy AUDIT_LOG_PRIV=3Dy NAMESPACE_PRIV=
=3Dy clean newrole
> > +       $(MAKE) PAMH=3Dy AUDITH=3Dn AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=
=3Dy clean newrole
> > +       $(MAKE) PAMH=3Dy AUDITH=3Dn AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=
=3Dn clean newrole
> > +       $(MAKE) PAMH=3Dn AUDITH=3Dy AUDIT_LOG_PRIV=3Dy NAMESPACE_PRIV=
=3Dn clean newrole
> > +       $(MAKE) PAMH=3Dn AUDITH=3Dy AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=
=3Dn clean newrole
> > +       $(MAKE) PAMH=3Dn AUDITH=3Dn AUDIT_LOG_PRIV=3Dn NAMESPACE_PRIV=
=3Dn clean newrole
> > +       $(MAKE) clean
> > --
> > 2.35.1
> >
