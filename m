Return-Path: <SRS0=V9Cn=C3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E98C43463
	for <selinux@archiver.kernel.org>; Fri, 18 Sep 2020 01:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46102087D
	for <selinux@archiver.kernel.org>; Fri, 18 Sep 2020 01:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIRBr5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Sep 2020 21:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgIRBr5 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 17 Sep 2020 21:47:57 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11A1B20872;
        Fri, 18 Sep 2020 01:47:55 +0000 (UTC)
Date:   Thu, 17 Sep 2020 21:47:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Paul Moore <paul@paul-moore.com>, <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [RFC PATCH] selinux: Add denied trace with permssion filter
Message-ID: <20200917214754.4242c489@rorschach.local.home>
In-Reply-To: <aa37c79f-d908-0a75-4916-6aaa21426212@sony.com>
References: <CAHC9VhRuvK55JVyHOxckThbRQ7sCwkeZsudwCaBo2f5G4g11VA@mail.gmail.com>
        <20200824132252.31261-1-peter.enderborg@sony.com>
        <20200824132252.31261-2-peter.enderborg@sony.com>
        <CAHC9VhR8PscKpA5BrgTNj8cq_eQ6svqru6UXidc=v5+Ha+PM7Q@mail.gmail.com>
        <6cbe5d27-ebb2-70a6-bad4-31c9f310eff2@sony.com>
        <CAHC9VhRGaE4FwE8iXo_zeAPdimE9ryMR+r4Jcq=ZpF_2aTJxzQ@mail.gmail.com>
        <59fa190f-37c0-79f3-ea46-8f821d820e1c@sony.com>
        <CAHC9VhRE94YVK5bTcqqbNYJu-EwjbcwjSFgqV8jkyLn9HD39Ag@mail.gmail.com>
        <abaccc15-85a8-24d2-4481-8303e3a42362@sony.com>
        <CAHC9VhRi87H2GhsKQN9iMOQeSw3g5_qwok9jpx+pfFSouQ9d5w@mail.gmail.com>
        <000e6a1b-6026-5e99-9a92-6ae9aafc07d4@sony.com>
        <CAHC9VhQiPTEarUWWA1RH8AsymhRpAa7kWTmmefTAqfouts8WGw@mail.gmail.com>
        <aa37c79f-d908-0a75-4916-6aaa21426212@sony.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

 [ Late reply due to long vacation followed by drowning in the email
   built up from said vacation! ]

On Tue, 1 Sep 2020 19:18:46 +0200
peter enderborg <peter.enderborg@sony.com> wrote:

> No. It can filter on strings. But it can not do any fuzzy matching.
> They are equal not not equal. So if you have a parameter value
> that is { open read !write } you need to specify a exact match.

That is not actually true.

It allows globing in filters.

 # trace-cmd start -e sched_switch -f 'next_comm ~ "c*"'
 # cat /etc/passwd
 # trace-cmd show
# tracer: nop
#
# entries-in-buffer/entries-written: 3/3   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
     kworker/2:1-2137  [002] d..2  9263.286132: sched_switch: prev_comm=kworker/2:1 prev_pid=2137 prev_prio=120 prev_state=I ==> next_comm=cat next_pid=2146 next_prio=120
          <idle>-0     [002] d..2  9264.390089: sched_switch: prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=cat next_pid=2146 next_prio=120
     kworker/2:1-2137  [002] d..2  9264.390440: sched_switch: prev_comm=kworker/2:1 prev_pid=2137 prev_prio=120 prev_state=I ==> next_comm=cat next_pid=2146 next_prio=120


Thus you can filter:

 "foo*" - everything that starts with foo
 "*foo" - everything that ends with foo
 "*foo*" - everything that has foo in it.

-- Steve
