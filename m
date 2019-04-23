Return-Path: <SRS0=RjX6=SZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CB7C10F14
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 13:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C291214AE
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556026174;
	bh=P69KHxqe2HL+cbbCM5E/nCZpzYwjYyJiEgU0bvwbZdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sM4vrh7HkmAFgmmIF0XT/J4mLKAYBqicx2/WKtLpz9MouFjqym6UtEqSfRCj3HlMT
	 QhsIa3s69rTqUY0vYsbqi/2emgumwQJWZQTxb0fN6VXphaMGc56y3tRHnyiCGG3XLH
	 PhhN53/AViid5PrI+1iKPP1EhZykpP5sXSx70gqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfDWN32 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfDWN32 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 23 Apr 2019 09:29:28 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B8FF2077C;
        Tue, 23 Apr 2019 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556026167;
        bh=P69KHxqe2HL+cbbCM5E/nCZpzYwjYyJiEgU0bvwbZdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIGPY7tgQrtAxMB2Y6ks20ACpr7U7qHPb9hVE0OQfdM+XolEbA+PnES+qDVUwISs1
         u+54HfXRCZYtgr9BNOfWfwNr5YqWiu2q9DQ5E5xDtmZ7f3blKKQ8OhjX3n97G34Aa6
         9aaO3XvngAR1vF9pwaBIHXmhGa0Tn/hTCUAF5xHU=
Date:   Tue, 23 Apr 2019 09:29:26 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: scripts/selinux build error in 4.14 after glibc update
Message-ID: <20190423132926.GK17719@sasha-vm>
References: <20190422210041.GA21711@archlinux-i9>
 <CAHC9VhTtz3OA3EchaZaAeg=DxoGoz_WFdj+Mi9nd9i+cmjmuJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHC9VhTtz3OA3EchaZaAeg=DxoGoz_WFdj+Mi9nd9i+cmjmuJA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 22, 2019 at 09:59:47PM -0400, Paul Moore wrote:
>On Mon, Apr 22, 2019 at 5:00 PM Nathan Chancellor
><natechancellor@gmail.com> wrote:
>> Hi all,
>>
>> After a glibc update to 2.29, my 4.14 builds started failing like so:
>
>...
>
>>   HOSTCC  scripts/selinux/genheaders/genheaders
>> In file included from scripts/selinux/genheaders/genheaders.c:19:
>> ./security/selinux/include/classmap.h:245:2: error: #error New address family defined, please update secclass_map.
>>  #error New address family defined, please update secclass_map.
>>   ^~~~~
>
>This is a known problem that has a fix in the selinux/next branch and
>will be going up to Linus during the next merge window.  The fix is
>quite small and should be relatively easy for you to backport to your
>kernel build if you are interested; the patch can be found at the
>archive link below:
>
>https://lore.kernel.org/selinux/20190225005528.28371-1-paulo@paulo.ac

Why is it waiting for the next merge window? It fixes a build bug that
people hit.

--
Thanks,
Sasha
