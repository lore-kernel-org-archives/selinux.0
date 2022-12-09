Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30652C001B2
	for <selinux@archiver.kernel.org>; Fri,  9 Dec 2022 00:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLIAHi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Dec 2022 19:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLIAHg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Dec 2022 19:07:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0862F60;
        Thu,  8 Dec 2022 16:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670544454; x=1702080454;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qCofqFGCS5j7U2NTaP/Znc47BVXA3zQXJphBmGHDggQ=;
  b=bhb5q6IMAURpGWrPFykqfNtsdnPu3AiceMDjydxHnsvTVrVVs+WpSNTc
   1az0DawG7NkfYE8LZ1sobxJFRTAnHv39TzRMV75lRGJ//3HPf/hZpDqRY
   gME1yXGx5gddD0nTlMfHSuxpqYlE7rRin0DhLExIoLIuGK3bPyOqByAYR
   RRBV7sRzfoz4X3ipp8xMQYqcZ3lQxJ6c/p+ql/HAMI/vaXzW8uQbzVHXR
   C9QwqFM04kjC7sQG/HkN+bQNAqKMJ6jlsCPCBF2O7kfOhnycSNRG4Q56N
   3FX1CrVxBv8OJFs7/vCjshA//A8TBugBNxQwuxBNRfHYqLtkvxLGE6Kx6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="297691200"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="297691200"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 16:07:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="789527897"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="789527897"
Received: from cgbowman-mobl.amr.corp.intel.com ([10.212.198.234])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 16:07:16 -0800
Date:   Thu, 8 Dec 2022 16:07:16 -0800 (PST)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: fix LSM labeling for passive msk
In-Reply-To: <fc052c3c-7545-4d84-05d8-adb5659348a1@schaufler-ca.com>
Message-ID: <f84f2394-ae01-d55f-a990-9adca8f314a0@linux.intel.com>
References: <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com> <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com> <fc052c3c-7545-4d84-05d8-adb5659348a1@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 8 Dec 2022, Casey Schaufler wrote:

> On 12/7/2022 6:19 PM, Mat Martineau wrote:
>> On Wed, 7 Dec 2022, Paolo Abeni wrote:
>>
>>> MPTCP sockets created via accept() inherit their LSM label
>>> from the initial request socket, which in turn get it from the
>>> listener socket's first subflow. The latter is a kernel socket,
>>> and get the relevant labeling at creation time.
>>>
>>> Due to all the above even the accepted MPTCP socket get a kernel
>>> label, causing unexpected behaviour and failure on later LSM tests.
>>>
>>> Address the issue factoring out a socket creation helper that does
>>> not include the post-creation LSM checks. Use such helper to create
>>> mptcp subflow as in-kernel sockets and doing explicitly LSM validation:
>>> vs the current user for the first subflow, as a kernel socket otherwise.
>>>
>>> Fixes: 0c14846032f2 ("mptcp: fix security context on server socket")
>>> Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> The MPTCP content looks good to me:
>>
>> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>
>>
>> I didn't see issues with the socket.c changes but I'd like to get some
>> security community feedback before upstreaming - Paul or other
>> security reviewers, what do you think?
>
> I haven't had the opportunity to work out what impact, if any, this will
> have on Smack. I haven't seen a reproducer for the problem, is one available?
> Sorry to chime in late.
>

Hi Casey -

There's more context in the original thread started by Ondrej, including 
reproducer information:

https://lore.kernel.org/all/CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com/

For impact on Smack, also check Paul's recent reply to this specific patch 
(proposing a new LSM hook):

https://lore.kernel.org/all/CAHC9VhQzJAhNtpMnU7STEfq6QpaJo-xiie8HoHH2w3io3aXBHw@mail.gmail.com/

--
Mat Martineau
Intel
