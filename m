Return-Path: <SRS0=MRHa=BY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777A2C433DF
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 18:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D8C20791
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 18:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHNS4t convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgHNS4s (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 14 Aug 2020 14:56:48 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14DF120771;
        Fri, 14 Aug 2020 18:56:47 +0000 (UTC)
Date:   Fri, 14 Aug 2020 14:56:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?B?VGhpw6li?= =?UTF-8?B?YXVk?= Weksteen 
        <tweek@google.com>, Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] selinux: add tracepoint on denials
Message-ID: <20200814145645.1ce518dd@oasis.local.home>
In-Reply-To: <96ee2444-56c9-5e74-7bb6-0a0d5541216b@sony.com>
References: <20200813144914.737306-1-tweek@google.com>
        <15e2e26d-fe4b-679c-b5c0-c96d56e09853@gmail.com>
        <CA+zpnLcf94HGmE=CGH6nT8ya0oax5orXc5nP1qToUgaca6FeQg@mail.gmail.com>
        <CAEjxPJ50vrauP7dd-ek15vwnMN1kvAyvYSc0fhR4xwCJEQSFxQ@mail.gmail.com>
        <ad64b5af-93de-e84e-17ca-40d8dd3cfe44@sony.com>
        <CAEjxPJ67G24T1a5WitmMqL4RUpjOgQFwpQ8unO1-OXSS=35V4Q@mail.gmail.com>
        <3518887d-9083-2836-a8db-c7c27a70c990@sony.com>
        <20200814134653.0ba7f64e@oasis.local.home>
        <6e36d3ca-ba2b-d80d-dffd-205521f39573@sony.com>
        <20200814143050.2bda2830@oasis.local.home>
        <96ee2444-56c9-5e74-7bb6-0a0d5541216b@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 14 Aug 2020 20:50:47 +0200
peter enderborg <peter.enderborg@sony.com> wrote:

> On 8/14/20 8:30 PM, Steven Rostedt wrote:
> > On Fri, 14 Aug 2020 20:06:34 +0200
> > peter enderborg <peter.enderborg@sony.com> wrote:
> >  
> >> Im find with that, but then you  can not do filtering? I would be
> >> pretty neat with a filter saying tclass=file permission=write.
> >>  
> > Well, if the mapping is stable, you could do:
> >
> > 	(tclass == 6) && (audited & 0x4)  
> 
> It does not happen to exist a hook for translate strings to numeric values when inserting filter?
> 

How would you imagine such a hook existing?

Something that would be specific to each trace event class, where you
can register at boot up a mapping of names to values? Or a function
that would translate it?

-- Steve
