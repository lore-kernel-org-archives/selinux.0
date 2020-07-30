Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15021C433E0
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 17:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73C3208A9
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 17:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgG3RRC convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbgG3RRC (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 30 Jul 2020 13:17:02 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC7B2082E;
        Thu, 30 Jul 2020 17:17:00 +0000 (UTC)
Date:   Thu, 30 Jul 2020 13:16:59 -0400
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
Message-ID: <20200730131659.7f1d21e8@oasis.local.home>
In-Reply-To: <15fcdc87-5e9b-8144-5a6b-34594d1e52ef@sony.com>
References: <20200724091520.880211-1-tweek@google.com>
        <20200724095232.5f9d3f17@oasis.local.home>
        <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
        <20200730110459.5bf0b0df@oasis.local.home>
        <6f1262fc-21ad-f872-5460-e78d4685c9c4@sony.com>
        <20200730120200.1367e1cd@oasis.local.home>
        <15fcdc87-5e9b-8144-5a6b-34594d1e52ef@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 30 Jul 2020 19:05:49 +0200
peter enderborg <peter.enderborg@sony.com> wrote:

> >> It should be a full structure with a lot of sub strings.  But that make is even more relevant.  
> > So one event instance can have a list of strings recorded?  
> 
> Yes, it is a list very similar to a normal trace. But it is more generic.
> 
> For example ino= is for filesystems that have inode, but for a
> violation that send a signal that make no sense at all.  Network
> addresses is in many cases not applicable. laddr= is only exist for
> for IP.
> 
> So if you just print them it will look like:
> 
> avc:  denied  { find } for interface=vendor.qti.hardware.perf::IPerf sid=u:r:permissioncontroller_app:s0:c230,c256,c512,c768 pid=9164 scontext=u:r:permissioncontroller_app:s0:c230,c256,c512,c768 tcontext=u:object_r:vendor_hal_perf_hwservice:s0 tclass=hwservice_manager permissive=0
>  avc:  denied  { execute } for  pid=13914 comm="ScionFrontendAp" path="/data/user_de/0/com.google.android.gms/app_chimera/m/00000002/oat/arm64/DynamiteLoader.odex" dev="sda77" ino=204967 scontext=u:r:platform_app:s0:c512,c768 tcontext=u:object_r:privapp_data_file:s0:c512,c768 tclass=file permissive=0 ppid=788 pcomm="main" pgid=13914 pgcomm="on.updatecenter"
> 
> It omit the fields that are not used. Some parts are common some are not. So a correct format specification for trace will be problematic if there is no "optional" field indicator.

That's all quite noisy. What is the object of these changes? What
exactly are you trying to trace and why?

-- Steve
