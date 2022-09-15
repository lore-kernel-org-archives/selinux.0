Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B3ECAAD3
	for <selinux@archiver.kernel.org>; Thu, 15 Sep 2022 13:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiION7w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiION7u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Sep 2022 09:59:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F58117A92
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 06:59:49 -0700 (PDT)
Received: from [192.168.1.107] (ip98-168-40-103.ph.ph.cox.net [98.168.40.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 970D12056DED;
        Thu, 15 Sep 2022 06:59:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 970D12056DED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663250389;
        bh=DjtccId7wCxR5ckTyxivfIEEB8mz4KgzTqb9ADg18Uk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=eEPuSNfDKKxMxHD9Uj0Uj/gO/gw/e1oRszsl+KauMs+l0045cGg3iHzXkGbfhHCy2
         ZYq05UY6zfwFwmBh1qqHydievD2YBppgGV/lLejnEBhkgjURSa/kn9U8lWB9/Ge2Bc
         X7by8mMg6Y2mofo9VGFUXBxYsZaw6T2o8tjwmA74=
Message-ID: <37dbb3a4-4df4-2437-b619-83488a2f1fa4@linux.microsoft.com>
Date:   Thu, 15 Sep 2022 06:59:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: /dev/random MLS policy
Content-Language: en-US
To:     Ted Toth <txtoth@gmail.com>, SELinux <selinux@vger.kernel.org>
References: <CAFPpqQHLat2g10YMZM7v6SCnj+fTMqXiLH_a5xjMsgF93xxtrA@mail.gmail.com>
From:   Matthew Sheets <masheets@linux.microsoft.com>
In-Reply-To: <CAFPpqQHLat2g10YMZM7v6SCnj+fTMqXiLH_a5xjMsgF93xxtrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Your plan would get things working but will be the equivalent of just 
making random_device_t an mls trusted object, since everything will 
always dominate system low and everything will always be dominated by 
system high.

This would make (( t2 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( 
h1 domby h2 )) always true.  And for read options ( l1 dom l2 ) will be 
true for the same reasons.
So path of least resistance you can just make random_device_t 
mlstrustedobject.

But you may just be able to deny and dontaudit that access.  Things only 
write to /dev/random to add more entropy, and you may be able to live 
without that.  Also since it seems to be happening on exit it's likely 
not to have impact on the actual functionality of the system.

 From a more philosophical sense if you allow access like this, it will 
appear like a transitive data flow for a static policy analysis.  But 
realize that the kernel is handling data written to /dev/random 
differently to that of a flat file.  I cannot write some bytes into 
/dev/random and get those bytes out as is.  Now with a very complicated 
attack you can effect the entropy of /dev/random and cause other 
software to behave less random, which is generally bad.

On 9/15/2022 6:35 AM, Ted Toth wrote:
> I've started writing some SELinux policy for a java app running on a
> system configured with MLS policy. I am seeing 'append' AVCs when a
> JVM running at any level above SystemLow accesses /dev/random which is
> labeled SystemLow. The AVC appears to cause the JVM to exit. Have
> others experienced this and if so how did you deal with it? I
> considered making /dev/random SystemLow-SystemHigh and adding
> mls_file_write_within_range(random_device_t) to policy but am
> concerned about the possibility of using the device as a covert
> channel. Thought?
> 
> Ted
