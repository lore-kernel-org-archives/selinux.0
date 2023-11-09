Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67175C4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 18:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344984AbjKIS03 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 13:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344978AbjKIS02 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 13:26:28 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7147230CF
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 10:26:26 -0800 (PST)
Received: from [192.168.254.22] (c-73-86-61-56.hsd1.md.comcast.net [73.86.61.56])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8AD9320B74C0;
        Thu,  9 Nov 2023 10:26:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AD9320B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1699554385;
        bh=2XUL1TDtL5GzZomfkyDoioUlCEVc5FqYew55LXjGVDs=;
        h=Date:From:Subject:To:From;
        b=oHN7DHGLy53VNBrAwOaUlR92U1n/lhJbx0X1ay3peK13T1N+OfBKwB8/JEUQAybsC
         9obbwTjrAwqjkUFxcSv3Y5lfgvcScxfMWDpDUSrO+viFrSl1mnk0fm5pI29M4SITGf
         m7SJd++1Jdi3weofDPhvM50Vqy6GqaomiGC1VJTo=
Message-ID: <da1d9efd-fdc1-4651-8a7a-30ae4a399926@linux.microsoft.com>
Date:   Thu, 9 Nov 2023 13:26:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
Subject: Proposed feature: fine-grained file descriptors in SELinux
To:     SElinux mailing list <selinux@vger.kernel.org>, brauner@kernel.org,
        bluca@debian.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

systemd is increasing usage of memfds, pidfds, etc.  This is resulting 
in a need for wide inheritance of fds across the system.  For example in 
a lot of systemd interfaces that have a pid field now have a comparable 
pidfd interface.  dbus-broker and polkit are similarly updated.

Some references from an All Systems Go! talk: 
https://cfp.all-systems-go.io/media/all-systems-go-2023/submissions/T3LJAM/resources/ASG_2023_PID_FD-ize_all_the_things_E98Zw9Q.pdf 
  This is from a few months ago; the switch to PIDFDs is nearly 
complete, and we're already seeing denials for this usage.


Since file descriptors are increasing use as references for various 
operations, I think it would be useful to have a finer-grained fd class, 
so we can limit file descriptor inheritance, particularly as it looks 
like systemd/pid1 will need to inherit pidfd file descriptors from 
possibly all domains.  Specifically, I propose adding new permissions to 
the fd class, such as use_pidfd and use_memfd.  Then systemd can use 
pidfds from any domain, but only use regular fds from trusted domains.

Thoughts?

-- 
Chris PeBenito
