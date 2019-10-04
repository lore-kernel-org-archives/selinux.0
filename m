Return-Path: <SRS0=giUv=X5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65944C47404
	for <selinux@archiver.kernel.org>; Fri,  4 Oct 2019 20:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3953F222BE
	for <selinux@archiver.kernel.org>; Fri,  4 Oct 2019 20:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FktHuuXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfJDUKb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:10:31 -0400
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:50699 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbfJDUKa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Oct 2019 16:10:30 -0400
X-EEMSG-check-017: 32438960|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,257,1566864000"; 
   d="scan'208";a="32438960"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Oct 2019 20:10:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570219830; x=1601755830;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=E/BTJrTWlBgJVCIIR+eLiYZLYPX9UzUQUMXPMXc4qsI=;
  b=FktHuuXIBQFmYUz8b1kflNR2SRT308r1WWkCdAs3B9/e+wBzcMW6JPjt
   BzThESe5I7ZySw+RBOnccfHeuoOMZyLU5+lLxaWenrGXnAirMms8tm9wj
   th3tZjaTlHQJWB9G2irC0TGL/hHSp5eUXYhyaJ+VulWnvHDXXnFWc7ACu
   LyW2d8HJ27jyoQ1iEvy8SarvPlK7+LWiiLoKvnsDRfOVp6PzBWfXEHqwk
   4/QetWu9RRWz9sv2v8gb/pN+KHkauM88aGyVTMrzbKNiWJXSa/Ur9Dyrb
   Ze4NPnanT6vwpe1k/IVnTvPek9mpIWV5xL9sKDlsPNsvVF1i7azObsHr9
   w==;
X-IronPort-AV: E=Sophos;i="5.67,257,1566864000"; 
   d="scan'208";a="33780982"
IronPort-PHdr: =?us-ascii?q?9a23=3AP1dAwByHxeeGSgrXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoXLfad9pjvdHbS+e9qxAeQG9mCsLQZ0qGP6PCocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalyIRmrogndq8cbjIh/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwqV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbN54gzaIwlp?=
 =?us-ascii?q?oUq0jDGDP5mF7qg6OMc0Uk++yo5/zmYrXguJCcK5d5hhzxP6khgMCyAfk0Ph?=
 =?us-ascii?q?IQU2WU5+iwzqDv8VX8QLpQj/02lqfZsIrdJcQevqO5GBJa0p045hajDzapzN?=
 =?us-ascii?q?QYnX4dIFJDYxKIlZLlO17JIPDmFfu/mUijkC93x/DaOb3sGo3NIWLekLflZr?=
 =?us-ascii?q?t981RTyBc3zdxG4pJUDbYBIOjtVUPrqNPYCRo5ORSuw+n7ENV9yp8eWWWXD6?=
 =?us-ascii?q?+bN6PSql+I5v81LOWWf4AVojf9K/446P7qk3A0gkMSfbO03ZsRdH+4HvRnLF?=
 =?us-ascii?q?iDbnrwmNgNC3sFvg07TObykl2NTSZTZ2quX6I7/jw7E5ypDYPCRoCrnbyA0z?=
 =?us-ascii?q?y2HoNZZm9YEFCAC3ToeJueW/cKdi2SJtVtkjseVbiuGMcd0kSWvRL+g59gKf?=
 =?us-ascii?q?DZsnkAvI/n/MB8+umWkBY17zEyBMOYhSXFTX5/l3kUHXdi3r90qFZhkH+fwK?=
 =?us-ascii?q?N4hLpeDtUV6PRXBENyF5nHz/FzQ/roWwTNetrBHFShWdW7CHc7VNM3z9sDS0?=
 =?us-ascii?q?1nBtOpjgHP1jajRbQSkurYKoYz9/fnw3XpJ8t7g03D3a0lgkhuFtBDLkW6l6?=
 =?us-ascii?q?V/8E7VHIePnEKHwfX5PZ8A1TLAoT/QhVGFu1tVBUspCvTI?=
X-IPAS-Result: =?us-ascii?q?A2CCBADAppdd/wHyM5BmHAEBAQQBAQwEAQGBZ4F0KoFAM?=
 =?us-ascii?q?iqEIo8uAQEBAQaBNol2kSwJAQEBAQEBAQEBNAECAQGEQAKCRyM4EwIMAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFOYI6KQGCaAEFIxVBEAsYAgImAgJXBgEMBgIBAYJfP4F3F?=
 =?us-ascii?q?K9bgTKFTYMwgUiBDCiMDhh4gQeBOII2NT6HUYJYBI0BiSCWKW6CLYIvkmMGG?=
 =?us-ascii?q?5lALY1+m0IigVgrCAIYCCEPgydQEBSQMSUDMIEGAQGQZwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Oct 2019 20:10:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x94KAQcr023647;
        Fri, 4 Oct 2019 16:10:26 -0400
Subject: Re: [PATCH v4] Add default_range glblub support
To:     Paul Moore <paul@paul-moore.com>, jwcart2 <jwcart2@tycho.nsa.gov>,
        Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     selinux@vger.kernel.org
References: <20190909180557.8093-1-joshua.brindle@crunchydata.com>
 <0ea96cc4-11bb-5c4a-5f0a-75411a58e546@tycho.nsa.gov>
 <CAHC9VhQXf=h2BhaWvnwdJkLMHUdEV8F5pL4TSqAu6UkL3_FWpg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4999edd0-7b79-bc22-80cf-b45919254528@tycho.nsa.gov>
Date:   Fri, 4 Oct 2019 16:10:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQXf=h2BhaWvnwdJkLMHUdEV8F5pL4TSqAu6UkL3_FWpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/11/19 7:52 PM, Paul Moore wrote:
> On Tue, Sep 10, 2019 at 1:27 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>> On 9/9/19 2:05 PM, Joshua Brindle wrote:
>>> Policy developers can set a default_range default to glblub and
>>> computed contexts will be the intersection of the ranges of the
>>> source and target contexts. This can be used by MLS userspace
>>> object managers to find the range of clearances that two contexts
>>> have in common. An example usage is computing a transition between
>>> the network context and the context of a user logging into an MLS
>>> application.
>>>
>>> For example, one can add a default with
>>> this cil:
>>>
>>> (defaultrange db_table glblub)
>>>
>>> or in te (base module only):
>>>
>>> default_range db_table glblub;
>>>
>>> and then test using the compute_create utility:
>>>
>>> $ ./compute_create system_u:system_r:kernel_t:s0:c1,c2,c5-s0:c1.c20 system_u:system_r:kernel_t:s0:c0.c20-s0:c0.c36 db_table
>>> system_u:object_r:kernel_t:s0:c1,c2,c5-s0:c1.c20
>>>
>>> Some example range transitions are:
>>>
>>> User Permitted Range | Network Device Label | Computed Label
>>> ---------------------|----------------------|----------------
>>> s0-s1:c0.c12         | s0                   | s0
>>> s0-s1:c0.c12         | s0-s1:c0.c1023       | s0-s1:c0.c12
>>> s0-s4:c0.c512        | s1-s1:c0.c1023       | s1-s1:c0.c512
>>> s0-s15:c0,c2         | s4-s6:c0.c128        | s4-s6:c0,c2
>>> s0-s4                | s2-s6                | s2-s4
>>> s0-s4                | s5-s8                | INVALID
>>> s5-s8                | s0-s4                | INVALID
>>>
>>> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
>>
>> Merged.
>> Thanks,
>> Jim
> 
> Thanks guys.  We're at -rc8 for the kernel right now so it's a little
> late to pull the corresponding kernel patch, but I'll do that after
> the merge window closes.

Where does this patch stand?


