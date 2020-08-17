Return-Path: <SRS0=6AtE=B3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A69DC433E1
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 20:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0332075B
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 20:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgHQU3i convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgHQU3h (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 17 Aug 2020 16:29:37 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA882072E;
        Mon, 17 Aug 2020 20:29:35 +0000 (UTC)
Date:   Mon, 17 Aug 2020 16:29:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
Message-ID: <20200817162933.79f69c66@oasis.local.home>
In-Reply-To: <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com>
References: <20200817170729.2605279-1-tweek@google.com>
        <20200817170729.2605279-4-tweek@google.com>
        <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 17 Aug 2020 16:13:29 -0400
Stephen Smalley <stephen.smalley.work@gmail.com> wrote:

> Does this require a corresponding patch to userspace?  Otherwise, I get 
> the following:
> 
> libtraceevent: No such file or directory
>    [avc:selinux_audited] function avc_trace_perm_to_name not defined

Yes, we need to add a plugin to libtraceevent that will add that
function.

I could possibly write one up real quick.

-- Steve
