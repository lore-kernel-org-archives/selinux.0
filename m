Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BBDC433E0
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 19:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6955B21883
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgG3T30 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG3T30 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 30 Jul 2020 15:29:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC522083B;
        Thu, 30 Jul 2020 19:29:25 +0000 (UTC)
Date:   Thu, 30 Jul 2020 15:29:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     =?UTF-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <selinux@vger.kernel.org>
Subject: Re: [PATCH] RFC: selinux avc trace
Message-ID: <20200730152923.5101346c@oasis.local.home>
In-Reply-To: <38053623-2cc0-882d-8578-977ff3f43908@sony.com>
References: <20200724091520.880211-1-tweek@google.com>
        <20200724095232.5f9d3f17@oasis.local.home>
        <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
        <20200730110459.5bf0b0df@oasis.local.home>
        <6f1262fc-21ad-f872-5460-e78d4685c9c4@sony.com>
        <20200730120200.1367e1cd@oasis.local.home>
        <15fcdc87-5e9b-8144-5a6b-34594d1e52ef@sony.com>
        <20200730131659.7f1d21e8@oasis.local.home>
        <38053623-2cc0-882d-8578-977ff3f43908@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 30 Jul 2020 21:12:39 +0200
peter enderborg <peter.enderborg@sony.com> wrote:

> >> avc:  denied  { find } for interface=vendor.qti.hardware.perf::IPerf sid=u:r:permissioncontroller_app:s0:c230,c256,c512,c768 pid=9164 scontext=u:r:permissioncontroller_app:s0:c230,c256,c512,c768 tcontext=u:object_r:vendor_hal_perf_hwservice:s0 tclass=hwservice_manager permissive=0
> >>  avc:  denied  { execute } for  pid=13914 comm="ScionFrontendAp" path="/data/user_de/0/com.google.android.gms/app_chimera/m/00000002/oat/arm64/DynamiteLoader.odex" dev="sda77" ino=204967 scontext=u:r:platform_app:s0:c512,c768 tcontext=u:object_r:privapp_data_file:s0:c512,c768 tclass=file permissive=0 ppid=788 pcomm="main" pgid=13914 pgcomm="on.updatecenter"
> >>
> >> It omit the fields that are not used. Some parts are common some are not. So a correct format specification for trace will be problematic if there is no "optional" field indicator.  
> > That's all quite noisy. What is the object of these changes? What
> > exactly are you trying to trace and why?  
> 
> It is noisy, and it have to be. it covers a lot of different areas.  One common problem is
> to debug userspace applications regarding violations. You get the violation from the logs
> and try to figure out what you did to cause it. With a trace point you can do much better
> when combine with other traces. Having a the userspace stack is a very good way,
> unfortunately  it does not work on that many architectures within trace.
> 
> What exactly are you doing with any trace? You collect data to analyse what's
> going on. This is not different. Selinux do a specific thing, but is has lots of parameters.

Have you thought of adding multiple trace events with if statements
around them to decode each specific type of event?

Note, you can have a generic event that gets enabled by all the other
events via the "reg" and "unreg" part of TRACE_EVENT_FN(). Say its
called trace_avc, make a dummy trace_avc() call hat doesn't even need
to be called anywhere, it just needs to exist to get to the other trace
events.

Then have:

	if (trace_avc_enabled()) {
		if (event1)
			trace_avc_req_event1();
		if (event2)
			trace_avc_req_event2();
		[..]
	}

The reason for the trace_avc_enabled() is because that's a static
branch, which is a nop when not enabled. When enabled, it is a jump to
the out of band if condition block that has all the other trace events.

-- Steve
