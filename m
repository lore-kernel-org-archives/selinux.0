Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB20C636D4
	for <selinux@archiver.kernel.org>; Wed, 15 Feb 2023 20:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjBOUu7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Feb 2023 15:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjBOUun (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Feb 2023 15:50:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78D5B92;
        Wed, 15 Feb 2023 12:47:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 577F061D92;
        Wed, 15 Feb 2023 20:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F417C4339B;
        Wed, 15 Feb 2023 20:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676494068;
        bh=x9NsaW/xZtFVUjG+JboNIoA9JNxSi3d95U8uvAAB2XM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gZj1HxZujuimUkFxi5KP14HEqb1TOkdlf9S0IrYl69IsqFJL5flgBSpFSXQwjIgbD
         h1Tb4FXM1gxx4Kv0hj8koYB1/0KQqwKptwNTAaj1x6V2PcyfyNNq/vG4mtSrhgk0z0
         YqEkJf62PVlElB7D0UDmhsuNsFy0Hwb14LZ/CLdY=
Date:   Wed, 15 Feb 2023 12:47:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sys.c: fix and improve control flow in
 __sys_setres[ug]id()
Message-Id: <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
In-Reply-To: <20230215131807.293556-1-omosnace@redhat.com>
References: <20230215131807.293556-1-omosnace@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 15 Feb 2023 14:18:07 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:

> 1. First determine if CAP_SET[UG]ID is required and only then call
>    ns_capable_setid(), to avoid bogus LSM (SELinux) denials.

Can we please have more details on the selinux failures?  Under what
circumstances?  What is the end-user impact?

Because a fix for "bogus LSM (SELinux) denials" sounds like something
which should be backported into earlier kernels, but there simply isn't
sufficient information here for others to decide on this.
