Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230E7C433DF
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F285120656
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="yw8HskBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGXNzO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXNzO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 09:55:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC527C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 06:55:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c10so1915652ejs.5
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2+QY4UUobhGBvSSFOCx6nVkPgfj8aj4xZ1WgLjYrTQs=;
        b=yw8HskBNj5wOQJSaAsDDosZQzeLjims7JWWXKdcziXgfxwCTExxUhYTruFid5xgh8T
         7SxjC/csP73hxZuLXPZm34Iz8fw6WG7hjiR5uvQzZKsedkAWqQhR+ppw0+mjKSlibCYF
         vxQS8PsSkoA0cfWG41Gs+CWBr7oLDXmQkbUmN3a/xKyXcVL9pyRrd520M5f6KtYB67CY
         lBLeCvPY4BOFokvNqbHqorLtD2L9SEy7WyEXA2aSIQGpsDUJYj/R0KTDCovBALQhllG4
         F+Qj79J1hh/g2J5y/nc5fO0Egqqn3x2nb86zlya0t64gGFhwzm/DpC5VN787S3p6hRdL
         utMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2+QY4UUobhGBvSSFOCx6nVkPgfj8aj4xZ1WgLjYrTQs=;
        b=kXTWbPqT1QtGPD/EnOf0jKjM1TynaQB2p7++IlGj1seBRaD4dSCmt/C9SUjJNWgrsF
         z3S6w3r8f/1Hw5kw3VZw3oPYyuJSrr0tQ+YR5DbgaIJiPs69rpIgOiK7wr7prDqn0otP
         psbnaoxBRHiEl2i2xQfvgfUh+ebLGSPBWm0rEqCamktvkip6hiO8/x/De+K4iEQ3NArZ
         R3tAP3+YJH9m5qPVjPFaSK+j7W4bRYtJE6zwE6WlZTDEJcNpcbop+jAPa4YFaBzpwTnX
         eQKd5uIoWPho57ulrF13pJfxvyYrbqYY7tjFaOeXZYqA6wXQYIN38r5aLz79b39ln3xH
         E7dA==
X-Gm-Message-State: AOAM530b6z0dSBl1paFOuWhtJaZbqYJwpy63BAccgZES4Qr/xQbYUrHe
        qk0qNkDQO1qq7tQqAdPX+OutTsAYY4SQfMumpw4B
X-Google-Smtp-Source: ABdhPJxTX4nMAqNgQlVPyc+Z5BK8nuJJeXDqJEBY/FoSoIzyn9oUsZSoJGfXybNqS+CbQYYvKt1coik5DkaPdaRsOlI=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr1088054eje.431.1595598912508;
 Fri, 24 Jul 2020 06:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
In-Reply-To: <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Jul 2020 09:54:59 -0400
Message-ID: <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 9:32 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Jul 24, 2020 at 5:15 AM Thi=C3=A9baud Weksteen <tweek@google.com>=
 wrote:
> > The audit data currently captures which process and which target
> > is responsible for a denial. There is no data on where exactly in the
> > process that call occurred. Debugging can be made easier by being able =
to
> > reconstruct the unified kernel and userland stack traces [1]. Add a
> > tracepoint on the SELinux denials which can then be used by userland
> > (i.e. perf).
> >
> > Although this patch could manually be added by each OS developer to
> > trouble shoot a denial, adding it to the kernel streamlines the
> > developers workflow.
> >
> > [1] https://source.android.com/devices/tech/debug/native_stack_dump
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Signed-off-by: Joel Fernandes <joelaf@google.com>
> > ---
> >  MAINTAINERS                    |  1 +
> >  include/trace/events/selinux.h | 35 ++++++++++++++++++++++++++++++++++
> >  security/selinux/avc.c         |  6 ++++++
> >  3 files changed, 42 insertions(+)
> >  create mode 100644 include/trace/events/selinux.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e64cdde81851..6b6cd5e13537 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15358,6 +15358,7 @@ T:      git git://git.kernel.org/pub/scm/linux/=
kernel/git/pcmoore/selinux.git
> >  F:     Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
> >  F:     Documentation/ABI/obsolete/sysfs-selinux-disable
> >  F:     Documentation/admin-guide/LSM/SELinux.rst
> > +F:     include/trace/events/selinux.h
> >  F:     include/uapi/linux/selinux_netlink.h
> >  F:     scripts/selinux/
> >  F:     security/selinux/
> > diff --git a/include/trace/events/selinux.h b/include/trace/events/seli=
nux.h
> > new file mode 100644
> > index 000000000000..e247187a8135
> > --- /dev/null
> > +++ b/include/trace/events/selinux.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM selinux
> > +
> > +#if !defined(_TRACE_SELINUX_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_SELINUX_H
> > +
> > +#include <linux/ktime.h>
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(selinux_denied,
> > +
> > +       TP_PROTO(int cls, int av),
> > +
> > +       TP_ARGS(cls, av),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(int, cls)
> > +               __field(int, av)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->cls =3D cls;
> > +               __entry->av =3D av;
> > +       ),
> > +
> > +       TP_printk("denied %d %d",
> > +               __entry->cls,
> > +               __entry->av)
> > +);
>
> I would think you would want to log av as %x for easier interpretation
> especially when there are multiple permissions being checked at once
> (which can happen). Also both cls and av would properly be unsigned
> values.  Only other question I have is whether it would be beneficial
> to include other information here to help uniquely identify/correlate
> the denial with the avc: message and whether any decoding of the
> class, av, or other information could/should be done here versus in
> some userland helper.

It does seem like at the very least it would be nice to see the av as
hex values instead of integers, e.g. "%x" in the TP_printk() call.
Considering this patch is about making dev's lives easier, I tend to
agree with Stephen questioning if you should go a step further and
convert both the class and av values into string representations.

--=20
paul moore
www.paul-moore.com
