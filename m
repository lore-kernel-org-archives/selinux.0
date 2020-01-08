Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A8C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 14:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A162053B
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 14:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Tz69n1sU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgAHOsc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:48:32 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:38252 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgAHOsc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 09:48:32 -0500
X-EEMSG-check-017: 43652717|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="43652717"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2020 14:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578494908; x=1610030908;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=I7pWrcLlAe9bjATqawMYheUuQ3ulojyNKXJljDbVF2k=;
  b=Tz69n1sUstWnQZfK6M5fau1HDAR/rmmCVwg+fSLwZ5jSaIMQi114ysci
   ZguGPdPM7Sc2gieT1kBBNpFY1OGEQny4RrWCW91ZRrCfiWC9Z5WbVIgR8
   ety7eatUh3ewm842HkVRmCXFHstcmJKerInyNDa/JuF80Z0sh/f6QJcfn
   QLFJo3eS3dACCxb/37LD3Ggix6LvAvKVjqF5xo7hH5/tbtj32wBzSkowd
   5op3X4nmN4fwtbLHUZYS8ebnUlYlUkswKITYI7LGZSGA0OECVZpBw4fqg
   1QB4YyUIqShGzuJhNVqaRd7vkpSFWoK5/RSxso5djnifksQOb9W3wBzME
   w==;
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="31717791"
IronPort-PHdr: =?us-ascii?q?9a23=3A672r3xxtRdrIYsLXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u4SL/ad9pjvdHbS+e9qxAeQG9mCsLQe1rqd7f2ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBi2rgjducgbjIt/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwp18DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbKpghwrA3lp?=
 =?us-ascii?q?oIr0vMAjX6mFn2jaCKdkUk/fKk6+L7bbX9upCQLYp0igD6Mqg2m8y/B/o3Mh?=
 =?us-ascii?q?QWUmSG9umx26fv8E3kTLlQkPE7nbfVvIrHKcgDo662GQ5V0oIt6xalCDem1c?=
 =?us-ascii?q?wVnWIaI1JeYx+Hk4joNE3OIPD/F/u/hU+sny1xy/DJOb3hHI3BLmLfn7f5Yb?=
 =?us-ascii?q?Z990lcxRIrzd9F+pJUDqoMIOrpVU/ssNzUFxo5Mwuzw+b9FtpxzJ8RWWWKAq?=
 =?us-ascii?q?WBKqPdrUeI5v4zI+mLfIIVvzP9K/8+5/7ol3A2hUEScLKz3ZQJdX+4Hu5pI1?=
 =?us-ascii?q?mDbXXwhdcBFH8AvhAiQ+zylF2CTTlTam62X6I94DE7FY2nAZ7YRo+znLOBwT?=
 =?us-ascii?q?27HpxKZmFGE1yMFHDoeJiZW/cIdi2fOdFhkjMaWri7UYMh1g+htBX8y7V5Ku?=
 =?us-ascii?q?rY4CoYtYjs1NJt/e3ciQky9SBoD8Say2yNTWR0nmQSRz8s3aB/uldwylGZ3q?=
 =?us-ascii?q?h9nfNYFMZf5/RTUgc1LZTc1fB1C8juWgLdedeEUE2mTcu8ATE+UN082N8ObF?=
 =?us-ascii?q?x5G9WmjhHD2TCmDKMSl7yOHJY06L7T32DtJ8ZhzHbLzLUugEM9QsRRNWyrnb?=
 =?us-ascii?q?V/+BTTB4HTjkWZmaKqeroG3CLU6GiM13CCs11fUA51Sa/FR2wQZlPKrdTl4U?=
 =?us-ascii?q?PPV6SuBqojMgtAz86CN6RLZ8b3jVVJWvjjIs7SY2GvlGeqAxaH2LeMYJDte2?=
 =?us-ascii?q?UH0yXXEFIEnBwL/XaaKQg+AT+so2DZDDxuE1LjeUHs8e5+qHyhSE801B+Fb0?=
 =?us-ascii?q?t62rWp4BEVg/ucS/US3r0Yoighry94E0q639LTE9CAvRZufL1AYdMh51dKzW?=
 =?us-ascii?q?HZuBJjMZy7M69igVkecwdsskzy1xV3EIJAkc0rrHM3yQp+M6WY0ElOdzmAx5?=
 =?us-ascii?q?D/JqXXKnXu/BCoc6PW31be0MyK+qcI7vQ4rk7usx2pFko49HVn1thV02aZ5p?=
 =?us-ascii?q?nQCwoSS53xWF4t9xdmv7HafjU954TM2H10L6a0tDDC288oBOsj0xqgfMlQML?=
 =?us-ascii?q?mCFADsF80XHMmuJPUum1iucBILIvpe9LUuMMOlavuGwrSkMPxmnD24l2hH4p?=
 =?us-ascii?q?h9gQqw8H9EQ/PMl7MCxOuVll+fXir4pE+or8SynIdDfzxUFW26n3vKHolUM5?=
 =?us-ascii?q?ZucJ4LBGHmGMi+wtFzlta5QHJD3EKyDFMBnsmycFydaEKrjl4Y7lgevXHywX?=
 =?us-ascii?q?jw9DdziTx86/PCjSE=3D?=
X-IPAS-Result: =?us-ascii?q?A2DbBQBj6xVe/wHyM5AaAUsdAQEBCQERBQUBgXwCgXuBb?=
 =?us-ascii?q?SASKoQJiQOGZwEBAQEBAQaBN4luiiSFPYFnCQEBAQEBAQEBATcBAYRAAoIOO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMVQRALGAICJgICVwYNBgIBA?=
 =?us-ascii?q?YJfP4JTJY4dnVyBMoVPgzaBPYEOKAGMMnmBB4E4D4JdPoQxgyiCXgSQCYcVR?=
 =?us-ascii?q?pdDgkCCRZNXBhuaYi2rISKBWCsIAhgIIQ87gmxQGA2NHheOQSMDMJB7AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Jan 2020 14:48:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 008Elhbv257431;
        Wed, 8 Jan 2020 09:47:43 -0500
Subject: Re: [PATCH 2/2] security, selinux: get rid of security_delete_hooks()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20200107133154.588958-1-omosnace@redhat.com>
 <20200107133154.588958-3-omosnace@redhat.com>
 <bad81aeb-c21f-c5be-12a1-61912d04573a@tycho.nsa.gov>
 <CAHC9VhRMLJLSUY5VfdDRv=OuyLkvzsyqfpNhf_SfC9V8OALJ4g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <826c1199-80c8-419c-909a-98fe90c097bc@tycho.nsa.gov>
Date:   Wed, 8 Jan 2020 09:49:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRMLJLSUY5VfdDRv=OuyLkvzsyqfpNhf_SfC9V8OALJ4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/8/20 12:31 AM, Paul Moore wrote:
> On Tue, Jan 7, 2020 at 9:46 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 1/7/20 8:31 AM, Ondrej Mosnacek wrote:
>>> The only user is SELinux, which is hereby converted to check the
>>> disabled flag in each hook instead of removing the hooks from the list.
>>>
>>> The __lsm_ro_after_init macro is now removed and replaced with
>>> __ro_after_init directly.
>>>
>>> This fixes a race condition in SELinux runtime disable, which was
>>> introduced with the switch to hook lists in b1d9e6b0646d ("LSM: Switch
>>> to lists of hooks").
>>
>> Not opposed (naturally, since I suggested it) but my impression from the
>> earlier thread was that Paul preferred the less invasive approach of
>> your original patch (just reordering the hooks) as a short term fix with
>> an eye toward full removal of disable support in the not-too-distant future.
> 
> Unless we are seeing wide spread breakages (I don't think we are), or
> we decide we can never remove the runtime disable, I still prefer the
> hook-shuffle over the changes proposed in this patchset.

Note that the first patch is a necessary and correct cleanup regardless 
of this one.


