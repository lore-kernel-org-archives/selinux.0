Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96FC433E1
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9872074F
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttonpQaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGXNc7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgGXNc6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 09:32:58 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C54C0619D3;
        Fri, 24 Jul 2020 06:32:58 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h13so7003933otr.0;
        Fri, 24 Jul 2020 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bww+MwS7WFdPyo5nQxQojl2bZYcgBq0GLMCk//cMKg0=;
        b=ttonpQaVQ8wKenxkYFBNRTBKnc5v77ZAtJB7ssctMILDFY0HBxmhB5UASdnXIZY7MO
         7Ewxtj0KFj5djUNty/mwa9SGLF+lU4N+mQnU35pBtqXM8E/RCFWTib5DFrHDrkPHbEQp
         nOZNMXFl/XqSDAKV7yxbVz1FsTqClAsOi9A3c3iwX/RUi4rdRuUOCzs4L0qUZX+pcQk6
         ecJSO6KIN5t/eSfUFNN5+cETbINsrGnlPEObKkkMhtDgI87Sz4ThjHOCwsyr3JKmkk2Q
         wVRSbOzJWeKl3cpQpgjDCQ8Y+B/ilcGLQquSNVUOUaN1TewCly/rieLgpeUtA7QmYR3i
         +/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bww+MwS7WFdPyo5nQxQojl2bZYcgBq0GLMCk//cMKg0=;
        b=avmE+2SavmmZCV6EgNjPPSD18Qa0aG0gPegoe+3qEvrQLCFczWMwr8J0QRyY/goYAX
         W1D2c0T6vlKCam5tGfDXdJySxpfTlH0jFmz76j76v0ZqQS9A7k5G3Ln/dcZ0AmGJCY5R
         nuDz/wi0qsJsIIPnY89NL8OmSw3k9fy8x3URV7mVwRx46rFH22A5XYcHGyw3NJ6vW8ST
         AOJ1EuP3v9JUgZ781otSYrT3BDmB4xweJjvyCMJD812dnRde/lky5zUDqpgcF7NfP9WM
         p4G5HsZRbS60g4YtibNMZ3/PSiBHGZvgjoHsVLIzYGUjhT7Qto62RXQN1gK0wUdHFNsq
         oNLA==
X-Gm-Message-State: AOAM532rwbWIsZWVIZ/pjPU6AzFt4fIeKYlgf0FyvcH1W3ubR3jBEumz
        Dnmpru/eZJ1w/dVTNFBfmyjbO/Yl/zoZreK2x7bAwg==
X-Google-Smtp-Source: ABdhPJzPu54cUA91+k3fvU77BW4juirj9eoyapZd89zI1PXw9ZOz21FKQWUPLR86MgCPCfmzyoxRD6bqcro0r2XBkbk=
X-Received: by 2002:a9d:6e14:: with SMTP id e20mr8450619otr.89.1595597577624;
 Fri, 24 Jul 2020 06:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com>
In-Reply-To: <20200724091520.880211-1-tweek@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Jul 2020 09:32:46 -0400
Message-ID: <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Paul Moore <paul@paul-moore.com>, Nick Kralevich <nnk@google.com>,
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

On Fri, Jul 24, 2020 at 5:15 AM Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
>
> The audit data currently captures which process and which target
> is responsible for a denial. There is no data on where exactly in the
> process that call occurred. Debugging can be made easier by being able to
> reconstruct the unified kernel and userland stack traces [1]. Add a
> tracepoint on the SELinux denials which can then be used by userland
> (i.e. perf).
>
> Although this patch could manually be added by each OS developer to
> trouble shoot a denial, adding it to the kernel streamlines the
> developers workflow.
>
> [1] https://source.android.com/devices/tech/debug/native_stack_dump
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  MAINTAINERS                    |  1 +
>  include/trace/events/selinux.h | 35 ++++++++++++++++++++++++++++++++++
>  security/selinux/avc.c         |  6 ++++++
>  3 files changed, 42 insertions(+)
>  create mode 100644 include/trace/events/selinux.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64cdde81851..6b6cd5e13537 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15358,6 +15358,7 @@ T:      git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/pcmoore/selinux.git
>  F:     Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
>  F:     Documentation/ABI/obsolete/sysfs-selinux-disable
>  F:     Documentation/admin-guide/LSM/SELinux.rst
> +F:     include/trace/events/selinux.h
>  F:     include/uapi/linux/selinux_netlink.h
>  F:     scripts/selinux/
>  F:     security/selinux/
> diff --git a/include/trace/events/selinux.h b/include/trace/events/selinu=
x.h
> new file mode 100644
> index 000000000000..e247187a8135
> --- /dev/null
> +++ b/include/trace/events/selinux.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM selinux
> +
> +#if !defined(_TRACE_SELINUX_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_SELINUX_H
> +
> +#include <linux/ktime.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(selinux_denied,
> +
> +       TP_PROTO(int cls, int av),
> +
> +       TP_ARGS(cls, av),
> +
> +       TP_STRUCT__entry(
> +               __field(int, cls)
> +               __field(int, av)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->cls =3D cls;
> +               __entry->av =3D av;
> +       ),
> +
> +       TP_printk("denied %d %d",
> +               __entry->cls,
> +               __entry->av)
> +);

I would think you would want to log av as %x for easier interpretation
especially when there are multiple permissions being checked at once
(which can happen). Also both cls and av would properly be unsigned
values.  Only other question I have is whether it would be beneficial
to include other information here to help uniquely identify/correlate
the denial with the avc: message and whether any decoding of the
class, av, or other information could/should be done here versus in
some userland helper.
