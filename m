Return-Path: <SRS0=dl6L=A4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1152C433E1
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 06:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFDD20704
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 06:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="qaX95zg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgGQGmA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGQGmA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jul 2020 02:42:00 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 379E8C061755
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 23:42:00 -0700 (PDT)
Received: from [IPv6:2001:985:d55d::438] (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 45C702A1278;
        Fri, 17 Jul 2020 08:41:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 45C702A1278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1594968119;
        bh=TW8/ejeyIuDzkfR6F+0Zg84cR5zyceElErt1ku85OwE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qaX95zg/qUtAHIw58LmfPx0/vKgwPdfI3HdNAbTLMzFswshv+NQjz/X2lRbsP7WO4
         yEX9H09Uyb8A0YtJ0RzwKqyi6t4tc6okhFhehk3d0wKQLrTZ0wX39yBTBW/6yqipZk
         xaeHrol4nA+VmVhVvU/ONKJgt8Hqoe+AFwGLyDpE=
Subject: Re: [SELinux-notebook PATCH v4] objects.md: some clarifications
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20200716111825.953813-1-dominick.grift@defensec.nl>
 <20200716121729.962241-1-dominick.grift@defensec.nl>
 <CAHC9VhS1d_=gotE6eau2hmxM+OjujY=u8sMQE10gNKOJ1z87dQ@mail.gmail.com>
From:   Dominick Grift <dominick.grift@defensec.nl>
Message-ID: <86bb1ebd-8edc-7ab1-7315-ded3ba8eb1bd@defensec.nl>
Date:   Fri, 17 Jul 2020 08:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhS1d_=gotE6eau2hmxM+OjujY=u8sMQE10gNKOJ1z87dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 7/17/20 3:36 AM, Paul Moore wrote:
> On Thu, Jul 16, 2020 at 8:18 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Elaborate on labeling. Touch on the significance of the default statement, on various av permissions related to labeling using the libselinux API, and on how the kernel and unlabeled initial security identifiers are used to address labeling challenges in special cases such as initialization and failover respectively.
>>

<snip>

> The same holds true
> for the "kernel" isid as a subject label, in cases where you see the
> "kernel" isid as a subject, it is actually the kernel acting on
> something.
> 

Thanks

In my experience, processes other than kernel threads can end up
associated with the kernel sid.

One notable example is plymouthd which is run from the initramfs and
will still be there for a short while after systemd/init loads policy.
But AFAIK any process that is started from the initramfs and that
persists after policy is loaded essentially ends up with the kernel isid.

So even though practically it is generally the kernel threads that
remain visibly associated with kernel sid to the naked eye, In actuality
it in my experience boils down to "subjects that were left unlabeled due
to system initialization", whether its the kernel or some long running
process started before SELinux was initializaed.
