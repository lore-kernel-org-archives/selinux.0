Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B1C433E3
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 12:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3604B206D7
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 12:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktZjHIcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgG1Mtm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgG1Mtm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 08:49:42 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A85C061794
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 05:49:42 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id m18so4527722vkk.7
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZNiMEHuT8+pdMAqptzZeWT7zj1wFIC1aVPAo0nMoMBw=;
        b=ktZjHIcSKPi6h78SKzXBq/EtIpvMrLjjjqSHlPVylZbx2YJgbjQdUh9vVGIDT2E5MH
         PJ0WXIaDGYaqe8cuv0Xdp1sABdQwSzrCmhlCj6dnkVflP5kMOXzBRwvwUynSuktljIF5
         qOwhBHPzf2pEClZygy7VrFZyQYCpjvVjzn60OmSaqPikXjoSloTMe9H9od2/Rjxj5y6J
         XCovimwj00i5CsKpJONKcvb/4iPAVR45I8fN5IerQWetJs2If1NpqPmCGGJJUZc6Vlmv
         sGVbMJ52fSNmBfiEf9CrHEQpiaZi/jBeHa8j4Kge+aKBw+p8+mNmJG7HTDtjFl3g49oC
         foQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZNiMEHuT8+pdMAqptzZeWT7zj1wFIC1aVPAo0nMoMBw=;
        b=owBgApyL1Js38BcyZNuRDc4OpzJcsoMsuzn8Q1HboPc0/PhQyc6NVs+WeNPhYCpvtm
         3SmRcSpNa+Flm+kFtEtPDgXYnmobGa8rzZJUXU3T/CeqTwTADwzmZ/fuQWGRrDdqoGPy
         6iJ4IsmQPuwzNpM4TbsqAGlbyoe/cghCGRG677C9CGGzdUrL5Z0ZLepMkTUQgv2NQLnq
         ckmqDgJV1+PjCBzXUPf8Mq7j5rHwAxKTs00squg0UfcmT/xpYmQzKgW/9wp1b41u+8EO
         ZtWYRd88Wr509+lsQTkR748jR/piBrW5F54yNWih2MJdSdv9zzGoslaJFjhveIcCMmn8
         TZGw==
X-Gm-Message-State: AOAM530f1Kq7zV/JsGE+Ilc/IyTjZiFUxVmjyoh512UOrvYVEEQUcFnk
        MO0VBr9259wr6CIkqHTE3vpIJYzH4NsSvr61oINhHA==
X-Google-Smtp-Source: ABdhPJzwTW2xZn0tGCPfUw7SANUU1RLHBQG0L0PQcaYpCrQ5D8gDCWNSYISy8i6qPVZ1d532Mpw/maXbJOc/pFNAApo=
X-Received: by 2002:a1f:a816:: with SMTP id r22mr8678960vke.99.1595940580992;
 Tue, 28 Jul 2020 05:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
 <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
In-Reply-To: <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Tue, 28 Jul 2020 14:49:24 +0200
Message-ID: <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     Paul Moore <paul@paul-moore.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
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

Thanks for the review! I'll send a new revision of the patch with the
%x formatter and using the TP_CONDITION macro.

On adding further information to the trace event, I would prefer
adding the strict minimum to be able to correlate the event with the
avc message. The reason is that tracevents have a fixed size (see
https://www.kernel.org/doc/Documentation/trace/events.txt). For
instance, we would need to decide on a maximum size for the string
representation of the list of permissions. This would also duplicate
the reporting done in the avc audit event. I'll simply add the pid as
part of the printk, which should be sufficient for the correlation.


On Fri, Jul 24, 2020 at 3:55 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Jul 24, 2020 at 9:32 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, Jul 24, 2020 at 5:15 AM Thi=C3=A9baud Weksteen <tweek@google.co=
m> wrote:
> > > The audit data currently captures which process and which target
> > > is responsible for a denial. There is no data on where exactly in the
> > > process that call occurred. Debugging can be made easier by being abl=
e to
> > > reconstruct the unified kernel and userland stack traces [1]. Add a
> > > tracepoint on the SELinux denials which can then be used by userland
> > > (i.e. perf).
> > >
> > > Although this patch could manually be added by each OS developer to
> > > trouble shoot a denial, adding it to the kernel streamlines the
> > > developers workflow.
> > >
> > > [1] https://source.android.com/devices/tech/debug/native_stack_dump
> > >
> > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > Signed-off-by: Joel Fernandes <joelaf@google.com>
> > > ---
> > >  MAINTAINERS                    |  1 +
> > >  include/trace/events/selinux.h | 35 ++++++++++++++++++++++++++++++++=
++
> > >  security/selinux/avc.c         |  6 ++++++
> > >  3 files changed, 42 insertions(+)
> > >  create mode 100644 include/trace/events/selinux.h
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e64cdde81851..6b6cd5e13537 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -15358,6 +15358,7 @@ T:      git git://git.kernel.org/pub/scm/linu=
x/kernel/git/pcmoore/selinux.git
> > >  F:     Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
> > >  F:     Documentation/ABI/obsolete/sysfs-selinux-disable
> > >  F:     Documentation/admin-guide/LSM/SELinux.rst
> > > +F:     include/trace/events/selinux.h
> > >  F:     include/uapi/linux/selinux_netlink.h
> > >  F:     scripts/selinux/
> > >  F:     security/selinux/
> > > diff --git a/include/trace/events/selinux.h b/include/trace/events/se=
linux.h
> > > new file mode 100644
> > > index 000000000000..e247187a8135
> > > --- /dev/null
> > > +++ b/include/trace/events/selinux.h
> > > @@ -0,0 +1,35 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM selinux
> > > +
> > > +#if !defined(_TRACE_SELINUX_H) || defined(TRACE_HEADER_MULTI_READ)
> > > +#define _TRACE_SELINUX_H
> > > +
> > > +#include <linux/ktime.h>
> > > +#include <linux/tracepoint.h>
> > > +
> > > +TRACE_EVENT(selinux_denied,
> > > +
> > > +       TP_PROTO(int cls, int av),
> > > +
> > > +       TP_ARGS(cls, av),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(int, cls)
> > > +               __field(int, av)
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->cls =3D cls;
> > > +               __entry->av =3D av;
> > > +       ),
> > > +
> > > +       TP_printk("denied %d %d",
> > > +               __entry->cls,
> > > +               __entry->av)
> > > +);
> >
> > I would think you would want to log av as %x for easier interpretation
> > especially when there are multiple permissions being checked at once
> > (which can happen). Also both cls and av would properly be unsigned
> > values.  Only other question I have is whether it would be beneficial
> > to include other information here to help uniquely identify/correlate
> > the denial with the avc: message and whether any decoding of the
> > class, av, or other information could/should be done here versus in
> > some userland helper.
>
> It does seem like at the very least it would be nice to see the av as
> hex values instead of integers, e.g. "%x" in the TP_printk() call.
> Considering this patch is about making dev's lives easier, I tend to
> agree with Stephen questioning if you should go a step further and
> convert both the class and av values into string representations.
>
> --
> paul moore
> www.paul-moore.com
