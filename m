Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B9C433F5
	for <selinux@archiver.kernel.org>; Thu, 17 Mar 2022 16:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiCQQIf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Mar 2022 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiCQQIe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Mar 2022 12:08:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4FCE214146
        for <selinux@vger.kernel.org>; Thu, 17 Mar 2022 09:07:17 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-191-184.washdc.fios.verizon.net [173.66.191.184])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3100E20D4DF6
        for <selinux@vger.kernel.org>; Thu, 17 Mar 2022 09:07:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3100E20D4DF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1647533237;
        bh=j7JlubFuUhPMtx3ijRpHonpBswekOKpQbH5vfl1i23w=;
        h=Date:To:From:Subject:From;
        b=WycsA38gWabIYIBLJtky7ozc+3aSI46I/pYaTjn6JpnMFc2lZWVqAfy0kcZ05r4WV
         0mxMyKYfSwUtF9xzwTxpb6Wl94z/0CW6eIhAcsRpEmfQSQcRe3dctQ1snFx5DaLy0a
         wY0nSV3cKwLsmYTNoo23lBJY04X/m1TiW4FYEpgM=
Message-ID: <9dd0a3d6-26b0-4689-ee28-ff8cb8af4d46@linux.microsoft.com>
Date:   Thu, 17 Mar 2022 12:07:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     SElinux list <selinux@vger.kernel.org>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Subject: Pwnkit and SELinux
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Some on this list may in interested in this blog post I wrote up to 
discuss the ability of SELinux to mitigate against a recent high profile 
security vulnerability (CVE-2021-4043/pwnkit):

https://dburgener.github.io/2022/03/16/pwnkit-and-selinux.html

-Daniel
