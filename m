Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06991C433E0
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D066520714
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgGXNwf convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXNwf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 24 Jul 2020 09:52:35 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA32F20656;
        Fri, 24 Jul 2020 13:52:33 +0000 (UTC)
Date:   Fri, 24 Jul 2020 09:52:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "=?UTF-8?B?VGhpw6liYXVk?= Weksteen" <tweek@google.com>
Cc:     Paul Moore <paul@paul-moore.com>, Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: add tracepoint on denials
Message-ID: <20200724095232.5f9d3f17@oasis.local.home>
In-Reply-To: <20200724091520.880211-1-tweek@google.com>
References: <20200724091520.880211-1-tweek@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 24 Jul 2020 11:15:03 +0200
"Thiébaud Weksteen" <tweek@google.com> wrote:
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index d18cb32a242a..85d2e22ab656 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -31,6 +31,9 @@
>  #include "avc_ss.h"
>  #include "classmap.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/selinux.h>
> +
>  #define AVC_CACHE_SLOTS			512
>  #define AVC_DEF_CACHE_THRESHOLD		512
>  #define AVC_CACHE_RECLAIM		16
> @@ -672,6 +675,9 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>  		return;
>  	}
>  
> +	if (sad->denied)

First, I would like to deny sadness as well ;-)

Now, there is a way to add that branch within the "nop" area of the
trace event, and remove the conditional branch from the main code.

> +		trace_selinux_denied(sad->tclass, av);
> +

Instead have this:

	trace_selinux_denied(sad, av);

>  	perms = secclass_map[sad->tclass-1].perms;
>  
>  	audit_log_format(ab, " {");

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

TRACE_EVENT_CONDITION(selinux_denied,

> +
> +	TP_PROTO(int cls, int av),

	TP_PROTO(struct selinux_audit_data sad, int av)

> +
> +	TP_ARGS(cls, av),
> +

	TP_CONDITION(sad->denied),

The above condition will be tested before calling the tracepoint. But
only if the trace event is enabled.

> +	TP_STRUCT__entry(
> +		__field(int, cls)
> +		__field(int, av)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cls = cls;

		__entry->cls = sad->tclass;

> +		__entry->av = av;
> +	),
> +
> +	TP_printk("denied %d %d",
> +		__entry->cls,
> +		__entry->av)
> +);
> +
> +#endif
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

-- Steve
