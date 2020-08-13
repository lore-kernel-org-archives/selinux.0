Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C164C433DF
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 17:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD3820791
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 17:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMRir convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgHMRiq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 13 Aug 2020 13:38:46 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B172320791;
        Thu, 13 Aug 2020 17:38:44 +0000 (UTC)
Date:   Thu, 13 Aug 2020 13:38:42 -0400
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
Message-ID: <20200813133842.655aff65@oasis.local.home>
In-Reply-To: <1b40226f-d182-7ba7-a6f6-15520c3e3516@sony.com>
References: <20200813144914.737306-1-tweek@google.com>
        <20200813144914.737306-2-tweek@google.com>
        <02c193e4-008a-5c3d-75e8-9be7bbcb941c@schaufler-ca.com>
        <a82d50bd-a0ec-bd06-7a3a-c2696398c4c3@sony.com>
        <c4424850-645f-5788-fb35-922c81eace6b@gmail.com>
        <1b40226f-d182-7ba7-a6f6-15520c3e3516@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 13 Aug 2020 19:14:10 +0200
peter enderborg <peter.enderborg@sony.com> wrote:

> > To be clear, userspace tools can't use fixed secid values because
> > secids are dynamically assigned by SELinux and thus secid 42 need
> > not correspond to the same security context across different boots
> > even with the same kernel and policy.  I wouldn't include them in
> > the event unless it is common practice to include fields that can
> > only be interpreted if you can debug the running kernel.  It would
> > be akin to including kernel pointers in the event (albeit without
> > the KASLR ramifications).
> >
> >  
> Just as a reference on my fedora system; out of 1808 events 244 as a
> pointer print. I don't see that there is any obfuscating aka "%pK" as
> there is for logs.

Which is a reason why tracefs is root only.

The "%p" gets obfuscated when printed from the trace file by default
now. But they are consistent (where the same pointer shows up as the
same hash).

It's used mainly to map together events. For example, if you print the
address of a skb in the networking events, it's good to know what
events reference the same skb, and the pointer is used for that.

-- Steve
