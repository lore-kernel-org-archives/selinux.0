Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7698C433E0
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A4A221E3
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgHFRpX convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Thu, 6 Aug 2020 13:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbgHFQih (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 6 Aug 2020 12:38:37 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F012204FD;
        Thu,  6 Aug 2020 16:37:50 +0000 (UTC)
Date:   Thu, 6 Aug 2020 12:37:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     peter enderborg <peter.enderborg@sony.com>,
        =?UTF-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 2/2] selinux: add attributes to avc tracepoint
Message-ID: <20200806123748.2285944b@oasis.local.home>
In-Reply-To: <971592b6-5d5f-05d8-d243-b521fe65577d@gmail.com>
References: <20200806080358.3124505-1-tweek@google.com>
        <20200806080358.3124505-2-tweek@google.com>
        <89d23362-39b9-79e5-84f1-d7b89204ef38@gmail.com>
        <8627d780-0e19-6755-0de5-c686deb0f5de@sony.com>
        <971592b6-5d5f-05d8-d243-b521fe65577d@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 6 Aug 2020 08:32:38 -0400
Stephen Smalley <stephen.smalley.work@gmail.com> wrote:

> >
> > In the commit message or in a Documentation/trace/events-avc.rst ?  
> 
> I was just asking for it in the commit message / patch description.  I 
> don't know what is typical for Documentation/trace.

No, the Documentation/trace is for generic tracing documentation. Not
for individual events.

-- Steve
