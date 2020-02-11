Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E486C352A3
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E21520714
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 15:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EI9BgOeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgBKP6O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:58:14 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:10016 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgBKP6O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 10:58:14 -0500
X-EEMSG-check-017: 57887783|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="57887783"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Feb 2020 15:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581436691; x=1612972691;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AcWpz9j5istuzNbFdl8VQMg6i6cjA98SGCzSbSXS56c=;
  b=EI9BgOeWGD0igAGjtTWTWN6g7iHYgQNiOJlSg253kOX7WH0+7AR/B/cY
   CwpHipFZcgBYBiwopZp0YUTGJf+LNFp2pJBNRCQnWKEqVjd1tdXTs6+uh
   3anLO1802a6f5a+alm3CglsGCP47wgXUmTWQ7FR5JRzVpbGOTcuc2Ska4
   BQd3XiRiaPH5/6BdRvhyiPaUhA+5MOxF+he2GGZ5L9960bBcDeQID3J6N
   GAXN2UiIjdA9+3JBijsjqpIfldDZBOLW9X+EWnsdiWt/ar/VIDljzo3+K
   rgUt/ky1wAIBmkuQGbTJXwYywOXaJ+2sJkKmpg/O23Xe4IgzoHnqSfWZD
   w==;
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="32923851"
IronPort-PHdr: =?us-ascii?q?9a23=3Aqc6Bax2uOzsATY8ismDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesTKv3xwZ3uMQTl6Ol3ixeRBMOHsq4C1bGd7P6ocFdDyKjCmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfLx/IA+3oAjfucUbg4pvIbstxx?=
 =?us-ascii?q?XUpXdFZ+tZyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAmoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lp?=
 =?us-ascii?q?sVsUTNGS/2g1v5g7OMekU4+umn9+TnYrL8qp+aK4B0kR3xPr4rmsy+BeQ0Kg?=
 =?us-ascii?q?kOX26F9uSgzLDv4EL0TbpQgvA2j6XVqo7WKMsFqqKjHgNZyoMj5Ay+Dzei3t?=
 =?us-ascii?q?QYh34HLFdddRKckofpIErDIOz4DPijg1Ssly1nx/bdPrL7GJnNIX/DkKn5cb?=
 =?us-ascii?q?Zn90Fc0BYzzcxY559MCLEBJ/LzWknruNzaCR85Mxa7w+D8CNpj0IMTQn6ADb?=
 =?us-ascii?q?WfMKPVt1+I5/4gLPOIZIMPpDn9LP0l7eb0jXAlgV8dYbWp3ZwPZX+kBPtmOF?=
 =?us-ascii?q?uWYHr3j9caDWgKvhAxTPHkiF2GTzFTfW++UL4m6T0hFI2mCoLDTJi3gLOdxC?=
 =?us-ascii?q?e7AoFWZmdeB1CXFHfna5uEVuwQZyKVJs9hliYLWqOmS487zx6irhP1y71iLu?=
 =?us-ascii?q?DM4C0XqYrj1MRp5+3UjRw96SZ7D9+D3GCNVW10hX8HRz8s06Bir0x9zkmM0b?=
 =?us-ascii?q?JjjvxZE9xT++1GUgMgOZHAyOx6Dsj4WhjdcdeRVFamXtKmDCkzTtI0xN8OeV?=
 =?us-ascii?q?x9G9S5jh3Y2SqlGboVmKKKBJAu9aLcxXfxLd5ny3nazKkhk0UmQsxXOG2ih6?=
 =?us-ascii?q?5/8RXTBoHQn0WCiamlabkc3DTM9GefzWuCpURYUAltXqXYWXAQeFDbrcr25k?=
 =?us-ascii?q?zcVb+iE7cnPRVbyc6ENKRKbsfljVJcRPfsIN7eeX6+m3+sBRaUwbOBdJHqdH?=
 =?us-ascii?q?sZ3CXcDkgEjg8S8G2YNQgxGCihuXjSDD9wGlL1ZUPj7+1+pGm8Tk8uwAGAd1?=
 =?us-ascii?q?dh2Kat+h4JmfycTOse3rEatyg/sDV7AFG939XVC9ebuwVhfL9cYdQ44FdGyG?=
 =?us-ascii?q?LZshZxPpu6L6BtnlQeaRh4v1vy1xVrDYVNidAqo20szAp9NKKY0VVBeyqb3Z?=
 =?us-ascii?q?/uIL3XLHf9/BS0Zq7Xw13e1NGW+rkR5/gisFXspgKpFlc483p9ydVV1WWT6o?=
 =?us-ascii?q?/IDAoKSZjxSFo49wBmp7HGZSkw/5vU2mdxMamwqTLCw8gmBPYhyhq5etdfN6?=
 =?us-ascii?q?SEFBXsHMEAG8euL+kqyBCVaUcmO+BUvIwzP8qgbPaAkPqpO+Zm2jChjW1B+4?=
 =?us-ascii?q?17+kmF8S16S+XB29AOxPTOmkOsXizxnR+aucD+hI5AaCtaSmG20iX1LJVaZq?=
 =?us-ascii?q?Rvc4IGEyKlKou8wdAow9bWWntf8haGDG0HxNOodFLGdFn2wyVb0kATqHaggy?=
 =?us-ascii?q?L+xDtxxWIHtK2aiRfSzvzieRxPAWtCQG1vnB+4OoSvp8wLV0ivKQ4ynV2q4l?=
 =?us-ascii?q?islPsTn7h2M2SGGRQARCPxNWw3F/Lt57c=3D?=
X-IPAS-Result: =?us-ascii?q?A2DeAgBFzkJe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBKEP4kDhmgBAQEGgTeJcJFLCQEBAQEBAQEBATcBAYRAAoJrOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgwIBBSMVQRALGAICJgICVwYBDAgBAYJjP4JXJ?=
 =?us-ascii?q?atYgTKFSoM6gT6BDiqMPXmBB4E4D4IoNT6EIoM5gl4Ell9jRpdqgkSCTpN4B?=
 =?us-ascii?q?hubD45knTYigVgrCAIYCCEPgyhPGA2OKReOQSMDjFWCQwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 11 Feb 2020 15:58:09 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01BFv3qJ200606;
        Tue, 11 Feb 2020 10:57:04 -0500
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Simon McVittie <smcv@collabora.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
 <20200210115611.GA13930@horizon>
 <94aaf6c8-cc69-5804-2d45-3b8c96689331@tycho.nsa.gov>
 <04442c9f-430e-c922-b078-7cff8f36a45f@tycho.nsa.gov>
 <37fa9076-6f15-0261-3bcf-1883236f9c3f@schaufler-ca.com>
 <422e5db4-1b61-0048-b608-78881f5fa4b4@canonical.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <af6b224c-4a32-40fa-77ae-1e2a5580054f@tycho.nsa.gov>
Date:   Tue, 11 Feb 2020 10:59:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <422e5db4-1b61-0048-b608-78881f5fa4b4@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/10/20 2:00 PM, John Johansen wrote:
> On 2/10/20 10:32 AM, Casey Schaufler wrote:
>> Because attr/context (and later, SO_PEERCONTEXT) are new interfaces
>> there is no need to exactly duplicate what is in attr/current (later
>> SO_PEERSEC). I already plan to omit the "mode" component of the
>> AppArmor data in the AppArmor hook, as was discussed earlier. I would
>> prefer ASCII, but if AppArmor needs bytestrings, that's what we'll
>> have to do.
>>
> 
> sadly, to not break userspace its a byte string because that is what the 
> path based profile names are. AppArmor does support a more limited non 
> path based profile name but I can't guarantee that is what userspace is 
> using in policy.

Ok, so /proc/pid/attr/context and SO_PEERCONTEXT have to be defined as 
returning bytestrings.

So far we've talked about having AppArmor drop the trailing newline, be 
consistent with regard to whether the terminating NUL is included or 
excluded, and drop the mode field from what it returns for 
/proc/pid/attr/context and SO_PEERCONTEXT versus the current 
/proc/pid/attr/current and SO_PEERSEC.  Is that correct?

How do we envision a liblsm processing the value returned from 
/proc/pid/attr/context or SO_PEEERCONTEXT?  It can certainly split it up 
per LSM.  But can it then take the apparmor portion of the context and 
pass that to existing libapparmor interfaces without breakage?  Or will 
the changes to the format described above create issues there?



