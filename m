Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02F6C433E1
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 19:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5752087C
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 19:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMTQu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMTQt (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 13 Aug 2020 15:16:49 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D03C20774;
        Thu, 13 Aug 2020 19:16:48 +0000 (UTC)
Date:   Thu, 13 Aug 2020 15:16:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] selinux: add basic filtering for audit trace
 events
Message-ID: <20200813151646.513423a3@oasis.local.home>
In-Reply-To: <c1f8c9a9-d123-df96-4918-890355db0301@sony.com>
References: <20200813144914.737306-1-tweek@google.com>
        <20200813144914.737306-2-tweek@google.com>
        <02c193e4-008a-5c3d-75e8-9be7bbcb941c@schaufler-ca.com>
        <a82d50bd-a0ec-bd06-7a3a-c2696398c4c3@sony.com>
        <c4424850-645f-5788-fb35-922c81eace6b@gmail.com>
        <1b40226f-d182-7ba7-a6f6-15520c3e3516@sony.com>
        <20200813133842.655aff65@oasis.local.home>
        <c1f8c9a9-d123-df96-4918-890355db0301@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 13 Aug 2020 20:18:55 +0200
peter enderborg <peter.enderborg@sony.com> wrote:

> > The "%p" gets obfuscated when printed from the trace file by default
> > now. But they are consistent (where the same pointer shows up as the
> > same hash).
> >
> > It's used mainly to map together events. For example, if you print the
> > address of a skb in the networking events, it's good to know what
> > events reference the same skb, and the pointer is used for that.  
> 
> So what is your opinion on ssid? I dont mind removing them
> now since people dont like it and the strong use-case is not
> strong (yet). Is there any problem to put getting them back
> later if useful? And then before the strings so the evaluation
> of filter first come on number before stings Or is there already
> some mechanism that optimize for that?

It's up to the owner of the trace event. I only replied to why pointers
in general are useful, but they are mostly just "ids" to map to other
trace events.

We have the libtraceevent that should be used for parsing raw trace
events in binary form. The library (which currently lives in the
kernel's tools/lib/traceeevnt directory) I'm trying to get to have its
own home that distros can package. It should never be an issue adding
another field to an event, as the library gives the tools the ability
to find a field of an event regardless of where it is positioned, and
also let the tools know if the field exists or not.

If that's what you are asking.

-- Steve
