Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5D5C43441
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 19:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259832081C
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 19:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259832081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbeK2Gho (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:37:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37088 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeK2Ghn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 01:37:43 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 11CC614E105F8;
        Wed, 28 Nov 2018 11:35:00 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:34:59 -0800 (PST)
Message-Id: <20181128.113459.2243338883107175423.davem@davemloft.net>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, netdev@vger.kernel.org, jiri@mellanox.com
Subject: Re: [PATCH] selinux: add support for RTM_NEWCHAIN, RTM_DELCHAIN,
 and RTM_GETCHAIN
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHC9VhSbqnN-brs0ssbCeAcUWGhUyRYR=FBYB1yB9uuR7_UeOQ@mail.gmail.com>
References: <154343066843.17825.12154246717874457759.stgit@chester>
        <CAHC9VhSbqnN-brs0ssbCeAcUWGhUyRYR=FBYB1yB9uuR7_UeOQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Nov 2018 11:35:00 -0800 (PST)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>
Date: Wed, 28 Nov 2018 13:47:25 -0500

> On Wed, Nov 28, 2018 at 1:44 PM Paul Moore <paul@paul-moore.com> wrote:
>> Commit 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
>> added new RTM_* definitions without properly updating SELinux, this
>> patch adds the necessary SELinux support.
>>
>> While there was a BUILD_BUG_ON() in the SELinux code to protect from
>> exactly this case, it was bypassed in the broken commit.  In order to
>> hopefully prevent this from happening in the future, add additional
>> comments which provide some instructions on how to resolve the
>> BUILD_BUG_ON() failures.
>>
>> Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
>> Cc: <stable@vger.kernel.org> # 4.19
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/selinux/nlmsgtab.c |   13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> I'm building a test kernel right now, assuming all goes well I'm going
> to send this up to Linus for v4.20.

Acked-by: David S. Miller <davem@davemloft.net>
