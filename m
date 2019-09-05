Return-Path: <SRS0=j8XY=XA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211EDC43331
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 20:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCDA2082C
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 20:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="nnR+8o6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfIEUBZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:01:25 -0400
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:2245 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfIEUBZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Sep 2019 16:01:25 -0400
X-EEMSG-check-017: 18997495|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,471,1559520000"; 
   d="scan'208";a="18997495"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Sep 2019 20:01:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567713680; x=1599249680;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fKF6en4kMaQNWSUCLkae3pHBD6L8JSNSLj29T/2g8Lg=;
  b=nnR+8o6yiI7fcXu+arVonKf6jAGtQ8zbf1UT9A8mHaM+HMYZNM7uDOew
   ZG7yYnzzgv4KorBWDybCB6hOxs+3AVN81gSqEJ7rn66+LbCrT86sMHDQx
   gLYm+0iJky0AXhyRbp2kC2PCMsfyw7c8sKGXGlv0uOL6P0tF5yfPLZZG9
   ylgxkBFgxoMnANHyZqsrlnUSxuTDAkTZHWD1Td2BxPtC9VT+oeT7ZzClD
   JWHZcUVsXmaJYsqk0Eew2cSs1TFZ9MLt22YhrIh8pT4Xugu8LL3f6x41/
   FnXbNNylODnYxGq6blRTVyBbcIgdgApZJ/t7XnRIya6j1JsV2+JFNDBX0
   w==;
X-IronPort-AV: E=Sophos;i="5.64,471,1559520000"; 
   d="scan'208";a="32446398"
IronPort-PHdr: =?us-ascii?q?9a23=3AhJc2KhdiygzlRAl3EPNdbSEdlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc27YxCN2/xhgRfzUJnB7Loc0qyK6vqmADNfqs/Y6zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrswndrNQajIlgJ6o+1x?=
 =?us-ascii?q?fFv3VFcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1BO7izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hE+EdIAsHrar9v7O6kdXu+30KbGwi7Ob+9U1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nybMGoY?=
 =?us-ascii?q?a2cDUFxZko3RLSa+GLf5KW7h/sSuqdOyp0iXR4c7ylnRmy61KvyujkW8mx11?=
 =?us-ascii?q?ZFszRKn8HXtnAIyxzT8s+HSuZh/ku52TaAyQTT6uZcLEAoj6XbMZ8hwqMrlp?=
 =?us-ascii?q?YJrUTCHjP5mEXxjKOMcEUr5vOo5Pj9brXjp5+cM5d4igD4MqswhsyyGfk0Pw?=
 =?us-ascii?q?cBUmSB+emwyafv8VP2TblUlPE6j7HVsJXAKsQaoq65DRVV0oEm6xunFDepzc?=
 =?us-ascii?q?8YkGIbLFNFZB2Hj4/pN0vIIPDjF/izmVuskDB1x/zeJL3uHo3NLmTfkLfmZb?=
 =?us-ascii?q?t981RTyBc3zd1E/5JbEKwBIPbqVk/0s9zYCQU5PBKuz+n7D9V905sUWXiTDa?=
 =?us-ascii?q?+BLKPSrViI6/osI+aSeoAVoyryK/8i5/7tlnI2hV8dfbOu3ZsSaXC4A/FmL1?=
 =?us-ascii?q?+eYXr2jdcLCX0KsRYmTOz2lF2CViZeaGqoUKIn+D46CJmrDZzfSYCtmrOBwS?=
 =?us-ascii?q?m7HplIaWBcE1yDDW3ne5+YVPcLbSKYOtVhnSAcVbi9V48h0gmjtBTkxLpjL+?=
 =?us-ascii?q?rU/DAYtJ342dhr6O3ciwsy+SZ3D8uDyWGNSX97nmcSSz8xxqB/rlR3yk2f3q?=
 =?us-ascii?q?hgn/xYCdtT6utNUgc7M57c0uN7B8npWg3fYtiJVUymQtS6ATAxV94xxtgObF?=
 =?us-ascii?q?tgG9WmkB/OxDSqA7ALmLyRHpA08bzT32L3J8ljz3bKzq4hj0MpQsFXL22pmr?=
 =?us-ascii?q?Z/9xTPB47Oi0iZlaOqdaMG3C7X9WeD1nGDvEdCXw51T6rFXGoTZkzMrdT2/k?=
 =?us-ascii?q?nCVaOhCaw7Mgtdzs6PMrZFat3ujVRIWvjjPNDeY3mqlmeqGxmH27OMY5D2e2?=
 =?us-ascii?q?kHwCrdD00EwEgv+iO+PBU6TgKmpHjTRGh2HE/rS1vl7O07rXS8VEJyxAaPOR?=
 =?us-ascii?q?5Pzb2wryUJiOScRvVb5bcNvCMsun0gB1qm987HANqH4Qx6deNTZs1rswQP7n?=
 =?us-ascii?q?7QqwEoZs/oFKtlnFNLNl0q7k4=3D?=
X-IPAS-Result: =?us-ascii?q?A2DeAADVaHFd/wHyM5BlHQEBBQEHBQGBVQYBCwGBaAUqg?=
 =?us-ascii?q?T8BMiqEIY9eAQaBNolvigeFJIF7CQEBAQEBAQEBATQBAgEBhD8CgjYjNgcOA?=
 =?us-ascii?q?gwBAQEEAQEBAQEGAwEBbIU6gjopAYJnAQUjBBFBEAsYAgImAgJXBg0GAgEBg?=
 =?us-ascii?q?l8/gXcUqzR/M4VLgzyBSYEMKAGLdxh4gQeBESeCaz6HT4JYBIxUiQGWW4Ipg?=
 =?us-ascii?q?iiJW4hfBhuYdi2oKwgpgVgrCAIYCCEPgyeCeo4pJAMwgQYBAY5EAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Sep 2019 20:01:20 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x85K1H0V010546;
        Thu, 5 Sep 2019 16:01:17 -0400
Subject: Re: [PATCH] selinux: fix residual uses of current_security() for the
 SELinux blob
To:     Paul Moore <paul@paul-moore.com>
Cc:     keescook@chromium.org, casey@schaufler-ca.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>, dhowells@redhat.com
References: <20190904143248.7003-1-sds@tycho.nsa.gov>
 <CAHC9VhTdv2C2MbNb7p-cPAW8ZeY+tmcz1c77qXmvowSxrWbw4g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b5705661-089a-cb9c-53b5-21b855937638@tycho.nsa.gov>
Date:   Thu, 5 Sep 2019 16:01:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTdv2C2MbNb7p-cPAW8ZeY+tmcz1c77qXmvowSxrWbw4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/19 6:50 PM, Paul Moore wrote:
> On Wed, Sep 4, 2019 at 10:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> We need to use selinux_cred() to fetch the SELinux cred blob instead
>> of directly using current->security or current_security().  There
>> were a couple of lingering uses of current_security() in the SELinux code
>> that were apparently missed during the earlier conversions. IIUC, this
>> would only manifest as a bug if multiple security modules including
>> SELinux are enabled and SELinux is not first in the lsm order. After
>> this change, there appear to be no other users of current_security()
>> in-tree; perhaps we should remove it altogether.
>>
>> Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   security/selinux/hooks.c          |  2 +-
>>   security/selinux/include/objsec.h | 20 ++++++++++----------
>>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> Thanks Stephen, and everyone who reviewed/commented on the patch.
> This looks fine to me too, and while it is a little late, I think
> there is value in getting this into the next merge window so I've gone
> ahead and merged this into selinux/next.
> 
> As far as removing current_security is concerned, I also agree that
> removing it is probably a good idea.  Does anyone object if I merge a
> follow-up patch via the SELinux tree (patch coming shortly)?

Obviously no objection to the follow-up patch.

I had another concern though raised by this bug that I wanted to note. 
AFAICS, no SELinux maintainer ever acked or reviewed the commit that 
introduced the bug, or the other patches in that series.  In fact that 
commit and many others in the series only have a single Reviewed-by line 
and no Acked-by lines at all.  I guess the SELinux maintainers (self 
included) could/should have been more proactive but maybe there should 
have been a final poke at each of the security module maintainers to 
provide at least an ack before it was merged or at least sent up to Linus?

I've also seen a tendency to assume that passing the selinux-testsuite 
suffices for ensuring that the patch is correct wrt SELinux.  If it 
wasn't already clear, the selinux-testsuite is by no means complete in 
its coverage (contributions welcome; known gaps captured as open issues 
in github), so passing the testsuite is no substitute for code review.

For the next and any future rounds of stacking support, I'm hoping we 
can be a bit more rigorous in our code review and testing requirements.
