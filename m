Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E0EC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97642075D
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="WcFSI9aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbgAXTRs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:17:48 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:55952 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbgAXTRs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 14:17:48 -0500
X-EEMSG-check-017: 49683028|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="49683028"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 19:17:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579893465; x=1611429465;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mPB9u/uhdGu9rQ/Z5OEHbf30QUIhRwm/YqMegRKZ/zY=;
  b=WcFSI9aJVZspaaks+DmbZV2gX1GkejayEVll3tk5gYKEvvtFAKEMKBHj
   NztuGPixp6ulrJ/nTwjEKrlxMSryzZcZP7UgxovFEZWidw+mamyL/tPPh
   dikCKh3DRqW/mU6lF36eoaN1+T/x2R8i5P0KlmOjWOu7A9fHygpG5Z8jz
   tquSR25OqUjv7I027BkuCFUTpU444abeeraBBDjpWfLdIyybcAWnzCC7Z
   HM90Z2kor9em+VtBNWZ6lmizklJiRxv+v/BSQIOCxLLGrYVHjIyLlE9Xf
   dhGnKxk05x2bMjJ9IIGC94vRfOfLh1aTH5i2yY92mEwoNF4uZvVnGyHfE
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="38228349"
IronPort-PHdr: =?us-ascii?q?9a23=3Ar2D1YhPHST0k8U5ssHMl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/39ocbcNUDSrc9gkEXOFd2Cra4d16yM7+u5AzRIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrwvxh?=
 =?us-ascii?q?bGrXdEZvpayX91Ll6Xgxrw+9288ZF+/yleof4t69JMXaDndKkkULJUCygrPX?=
 =?us-ascii?q?oo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVy1jWUMs3wVrA0RC?=
 =?us-ascii?q?+t77x3Rx/yiScILCA2/WfKgcFtlq1boRahpxtiw47IZYyeKfRzcr/Bcd4cWG?=
 =?us-ascii?q?FMRdhaWTBfDYygbosPF+sBMvher4nhvFsFsB+yCRCxCO/z1jNEg3n70qMg0+?=
 =?us-ascii?q?QlDArIwgouEdwTu3jQtdn4OqMfXeWzwaLVzzvMculW1C/g5obWfBAvofKCU7?=
 =?us-ascii?q?x+fsXey0YgCwzLg06MqYHmJT6ZyvgBvmaZ4udmSOmhi3QnqwZ0ojW328kslp?=
 =?us-ascii?q?fGhpoVyl/a8yVy3Zs7JdiiR05/Zd6rDptRvDydOottX8wiWHpluDo6y7IauZ?=
 =?us-ascii?q?67ezIGyJI8xxHFcfCHfI+I4gz6WeuXPDx2h2pldaqiixu9/kWs0O3xWtSu3F?=
 =?us-ascii?q?pUoSdJjMPAum0L2hfO8MaIUOF98V2k2TuX0gDT7fxLLl4smKrALp4h3qYwlp?=
 =?us-ascii?q?0OsUTfBiP2mFv5jKuRdkg85uin8f7nYrT7pp+HLYN0iwf+MqopmsykH+s3Lh?=
 =?us-ascii?q?ICX3Sb+Oug1L3j+lf1QLNWgf0tjqbVqpXaJcUfpqKhAg9V1Jgs6wqnAju739?=
 =?us-ascii?q?kVkmMLIVJYdB6dkYTkNE/CLOrlAfunhlSjijZrx/TIPr37BZXNK2DOkKz8cr?=
 =?us-ascii?q?Zm8ENc1Aoywsxf55JTEL0BJunzVVXruNzXCR85LRS4w/z7B9VlyoMeRWWPD7?=
 =?us-ascii?q?eFP6PdsF6I4eQvLPeXZIIOtzb9LP8l5/HqjXAnnF8SZ6ip3Z8NZH+kGfRmJl?=
 =?us-ascii?q?2TYWDwjdcZDWcKog0+QfTyiFKYTD5TY22/X7om6TEmDIKqFILDRoeqgLybwi?=
 =?us-ascii?q?i3BIFZZmdDClqUC3fna52EW+sQaCKVOsJujCQEWqK7S48gzhGjrxf6xKB9Lu?=
 =?us-ascii?q?rV4S0YrZbj28Jp6OLNjx0y8iZ0D8uF2WGXU250hn8IRyMx3K1npkx9z1CD0b?=
 =?us-ascii?q?N+g/NCCdNc+ehEUh0kOpHBz+x1EczyVhjdcdeOTVasWs+mDi0pTtIt398OZF?=
 =?us-ascii?q?5wG868gRDH3iqqBaIVlrOQCZwq/aLTwWLxK9x+y3nYzqkhiUcpQs9VOW2hnK?=
 =?us-ascii?q?5/+BDZB5TVnEWBi6aqaaMc0TbJ9GeCy2qOoU5ZXBdzUarbR3AfYFXZrdDi60?=
 =?us-ascii?q?PcQL+hF64nPhFCycGcMKtKbMPmjVFcSPfkItTebDH5p2DlLhaSx6iQbYPsTE?=
 =?us-ascii?q?qDwDnGA0gJ21QY8mSBMwUlLiimpG3aATlnFFapaETpp7pQsnS+G3QowhmKYk?=
 =?us-ascii?q?sp7L+8/hoYlLTIUP8I9q4Vsycm7TNvFRCy2MyAWInInBZoYKgJOYB121xAz2?=
 =?us-ascii?q?+M8lUmb5E=3D?=
X-IPAS-Result: =?us-ascii?q?A2BtAgD0QSte/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBKJA4Z5BoE3iW+RSQkBAQEBAQEBAQE3AQGEQAKCRjgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIwQLAQVBEAsYAgImAgJXBg0GAgEBg?=
 =?us-ascii?q?mM/gksDCQUgrTV1fzOFSoJLDWKBPoEOKowxeYEHgTgPgl0+ghuCBwGDNoJeB?=
 =?us-ascii?q?JZTgSeIKo80gkOCTJNlBhuafKt+IoFYKwgCGAghD4MnUBgNiA0XjkEjAzCLE?=
 =?us-ascii?q?wEnghsBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 Jan 2020 19:17:43 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OJGw2g110896;
        Fri, 24 Jan 2020 14:17:01 -0500
Subject: Re: [PATCH] selinux: allow kernfs symlinks to inherit parent
 directory context
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200124184221.322248-1-cgzones@googlemail.com>
 <6e33cbcd-31fd-2d50-5d0f-70eb475f9811@tycho.nsa.gov>
 <CAJ2a_DcS8e8OjRRHjbYhCphsLi3u=KxX5XorCEA_=5vfN+5q8g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <259f3abe-5d15-ea8d-98b6-765f1e5959dd@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 14:18:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAJ2a_DcS8e8OjRRHjbYhCphsLi3u=KxX5XorCEA_=5vfN+5q8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/24/20 2:08 PM, Christian Göttsche wrote:
> Am Fr., 24. Jan. 2020 um 19:53 Uhr schrieb Stephen Smalley <sds@tycho.nsa.gov>:
>>
>> On 1/24/20 1:42 PM, Christian Göttsche wrote:
>>> Currently symlinks on kernel filesystems, like sysfs, are labeled on
>>> creation with the parent fs root sid.
>>>
>>> Allow symlinks to inherit the parent directory context, so fine-grained
>>> kernfs labeling can be applied to symlinks too and checking contexts
>>> doesn't complain about them.
>>>
>>> For backward-compatibility this behavior is contained in a new policy
>>> capability: kernfs_sovereign_symlinks
>>>
>>> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>>> ---

>> Not fond of the name.  1) kernfs is a kernel implementation detail,
>> shouldn't be exposed to policy; genfs is the policy construct 2)
>> sovereign doesn't seem to fit the meaning of this capability; seclabel
>> would be more appropriate.
> 
> Something like genfs_seclabel_symlinks?

Works for me.

> 
>>> +                  (sbsec->flags & SE_SBGENFS_XATTR))) {
>>
>> Why limit this to SE_SBGENFS_XATTR filesystems?  Why not just make the test:
>>          if ((sbsec->flags & SE_SBGENFS) && (!S_ISLNK(inode->i_mode) ||
>> selinux_policycap_genfs_symlinkseclabel()))
>> or similar.
> 
> I somehow thought that this functionality is limited to filesystems
> with SE_SBGENFS_XATTR;
> so I can expand the check to SE_SBGENFS.

I could be wrong but I don't see why it would need to be limited in that 
way.
