Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBCAC433E1
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 02:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92ED120855
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 02:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHUCbk convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgHUCbj (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 20 Aug 2020 22:31:39 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E4F20748;
        Fri, 21 Aug 2020 02:31:37 +0000 (UTC)
Date:   Thu, 20 Aug 2020 22:31:36 -0400
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
Message-ID: <20200820223136.162850ce@oasis.local.home>
In-Reply-To: <66e6d84e-20b5-1bd3-e107-322f42ce35d3@gmail.com>
References: <20200817170729.2605279-1-tweek@google.com>
        <20200817170729.2605279-4-tweek@google.com>
        <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com>
        <20200817162933.79f69c66@oasis.local.home>
        <20200818120948.1a428da9@oasis.local.home>
        <66e6d84e-20b5-1bd3-e107-322f42ce35d3@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 19 Aug 2020 09:11:08 -0400
Stephen Smalley <stephen.smalley.work@gmail.com> wrote:

> So we'll need to update this plugin whenever we modify 
> security/selinux/include/classmap.h to keep them in sync.  Is that a 
> concern?  I don't suppose the plugin could directly include classmap.h?  
> I guess we'd have to export it as a public header. It isn't considered 
> to be part of the kernel API/ABI and can change anytime (but in practice 
> changes are not that frequent, and usually just additive in nature).

Yes, it would require some stability between userspace and the plugin.
If the value indexes don't change then that would work fine. If you add
new ones, that too should be OK, just have a way to state "unknown" in
the plugin.

-- Steve
