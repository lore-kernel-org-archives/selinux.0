Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4BCC433F2
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 13:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76048206D4
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 13:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgG1NMZ convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbgG1NMX (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 28 Jul 2020 09:12:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5D2320714;
        Tue, 28 Jul 2020 13:12:21 +0000 (UTC)
Date:   Tue, 28 Jul 2020 09:12:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] selinux: add tracepoint on denials
Message-ID: <20200728091220.5769b606@oasis.local.home>
In-Reply-To: <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
References: <20200724091520.880211-1-tweek@google.com>
        <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
        <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
        <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 28 Jul 2020 14:49:24 +0200
Thiébaud Weksteen <tweek@google.com> wrote:

> Thanks for the review! I'll send a new revision of the patch with the
> %x formatter and using the TP_CONDITION macro.
> 
> On adding further information to the trace event, I would prefer
> adding the strict minimum to be able to correlate the event with the
> avc message. The reason is that tracevents have a fixed size (see
> https://www.kernel.org/doc/Documentation/trace/events.txt). For

Wait! What?

Where in that document does it say that trace events have a fixed size.
We have a lot of dynamically sized trace events.

> instance, we would need to decide on a maximum size for the string
> representation of the list of permissions. This would also duplicate
> the reporting done in the avc audit event. I'll simply add the pid as
> part of the printk, which should be sufficient for the correlation.
> 

Please take a look at samples/trace_events/trace_events_sample.h

and read the example on __print_symbolic().

I think that's what you are looking for.

-- Steve
