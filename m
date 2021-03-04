Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844F1C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 23:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0BE65000
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 23:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCDXaH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhCDXaH (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 4 Mar 2021 18:30:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2F1C464FFF;
        Thu,  4 Mar 2021 23:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614900607;
        bh=mYItgB5OF8Z9/8sUYGC32ZVGnESrOA82MM7IhaZdjag=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HUGXa6UPgn9A7+CT4kwKLTaEhzT0qKe/S/j2M6QDZ3amPCoYDCfwG8A+oH8RE61GB
         RKUiQ4RwqKLwpQxrEs/oT5asH7YEIvCl/0NVhqqFGAjDFjIq/Uoi4XYyM3hZTxHMXm
         7OS3LqN/kOmuFp/OXpPTnnHNhFyZoyOx/a+19dNQpCYgrmMs/rJzLUZll6t/tJIHXL
         w7dP16AxYKnSj88ywCXFIX9VK7xb57dGwAOov5seHwsDxb4IxSdQ+YfpxWWO3mJNNW
         WbnS+AV2L/fiWpFY702ic6WNEbnJoebf2AlN6QEVe6gdx+/aRXQMWTUCjfydB+sPw0
         EAYul4AukY9Tw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cipso,calipso: resolve a number of problems with the DOI
 refcounts
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161490060714.7752.4115541555811956751.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Mar 2021 23:30:07 +0000
References: <161489339182.63157.2775083878484465675.stgit@olly>
In-Reply-To: <161489339182.63157.2775083878484465675.stgit@olly>
To:     Paul Moore <paul@paul-moore.com>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, dvyukov@google.com
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Thu, 04 Mar 2021 16:29:51 -0500 you wrote:
> The current CIPSO and CALIPSO refcounting scheme for the DOI
> definitions is a bit flawed in that we:
> 
> 1. Don't correctly match gets/puts in netlbl_cipsov4_list().
> 2. Decrement the refcount on each attempt to remove the DOI from the
>    DOI list, only removing it from the list once the refcount drops
>    to zero.
> 
> [...]

Here is the summary with links:
  - cipso,calipso: resolve a number of problems with the DOI refcounts
    https://git.kernel.org/netdev/net/c/ad5d07f4a9cd

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


