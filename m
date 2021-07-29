Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D24C4338F
	for <selinux@archiver.kernel.org>; Thu, 29 Jul 2021 14:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904A160FE7
	for <selinux@archiver.kernel.org>; Thu, 29 Jul 2021 14:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhG2OaL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236733AbhG2OaL (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 29 Jul 2021 10:30:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0777E60F4A;
        Thu, 29 Jul 2021 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627569008;
        bh=g3jcX1B51LCjdrBhcu4qBOxJsWI3TBVovbVBa4YeD58=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qbincgHspzZAvQ0xQ+1dg+5noov6d/YXIWYI29MFL4SNUProtUnRLld8oSybTS7SF
         DB66mJN+xXmKo19sCydVS/HvlDlmSicLMqmECIqmvHs5ejgk8W+0YZ/oRcrQjUeuCB
         AznOYp3MYnxjpT/bDuD/pzvma8apN9J5PFeb4L3uH2Y3L904OU8CL4FTZFH93hhbzy
         LEpnclICwpqkQxb3/g3OA7D7TkBThuVFhPsu6g4pgffYxeddSIpeSNS+py9sE7uCyx
         wSa6rptIHLcmGl1ne4Ul0v0EL385nJP1qTnlpxfp71Nioabe7cH+mH8Nv0e7hdGxQC
         tu80IOpzRTQmg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/15] Add Management Component Transport Protocol
 support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162756900796.16408.17168794493714239163.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jul 2021 14:30:07 +0000
References: <20210729022053.134453-1-jk@codeconstruct.com.au>
In-Reply-To: <20210729022053.134453-1-jk@codeconstruct.com.au>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     netdev@vger.kernel.org, matt@codeconstruct.com.au, andrew@aj.id.au,
        kuba@kernel.org, davem@davemloft.net, linux-doc@vger.kernel.org,
        corbet@lwn.net, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Thu, 29 Jul 2021 10:20:38 +0800 you wrote:
> This series adds core MCTP support to the kernel. From the Kconfig
> description:
> 
>   Management Component Transport Protocol (MCTP) is an in-system
>   protocol for communicating between management controllers and
>   their managed devices (peripherals, host processors, etc.). The
>   protocol is defined by DMTF specification DSP0236.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/15] mctp: Add MCTP base
    https://git.kernel.org/netdev/net-next/c/bc49d8169aa7
  - [net-next,v4,02/15] mctp: Add base socket/protocol definitions
    https://git.kernel.org/netdev/net-next/c/8f601a1e4f8c
  - [net-next,v4,03/15] mctp: Add base packet definitions
    https://git.kernel.org/netdev/net-next/c/2c8e2e9aec79
  - [net-next,v4,04/15] mctp: Add sockaddr_mctp to uapi
    https://git.kernel.org/netdev/net-next/c/60fc63981693
  - [net-next,v4,05/15] mctp: Add initial driver infrastructure
    https://git.kernel.org/netdev/net-next/c/4b2e69305cbb
  - [net-next,v4,06/15] mctp: Add device handling and netlink interface
    https://git.kernel.org/netdev/net-next/c/583be982d934
  - [net-next,v4,07/15] mctp: Add initial routing framework
    https://git.kernel.org/netdev/net-next/c/889b7da23abf
  - [net-next,v4,08/15] mctp: Add netlink route management
    https://git.kernel.org/netdev/net-next/c/06d2f4c583a7
  - [net-next,v4,09/15] mctp: Add neighbour implementation
    https://git.kernel.org/netdev/net-next/c/4d8b9319282a
  - [net-next,v4,10/15] mctp: Add neighbour netlink interface
    https://git.kernel.org/netdev/net-next/c/831119f88781
  - [net-next,v4,11/15] mctp: Populate socket implementation
    https://git.kernel.org/netdev/net-next/c/833ef3b91de6
  - [net-next,v4,12/15] mctp: Implement message fragmentation & reassembly
    https://git.kernel.org/netdev/net-next/c/4a992bbd3650
  - [net-next,v4,13/15] mctp: Add dest neighbour lladdr to route output
    https://git.kernel.org/netdev/net-next/c/26ab3fcaf235
  - [net-next,v4,14/15] mctp: Allow per-netns default networks
    https://git.kernel.org/netdev/net-next/c/03f2bbc4ee57
  - [net-next,v4,15/15] mctp: Add MCTP overview document
    https://git.kernel.org/netdev/net-next/c/6a2d98b18900

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


