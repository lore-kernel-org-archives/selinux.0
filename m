Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB8BC33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 15:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E172214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 15:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="kE0SrRZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBFPuq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:50:46 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:23021 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgBFPup (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 10:50:45 -0500
X-EEMSG-check-017: 55682689|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55682689"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 15:50:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581004242; x=1612540242;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ZrBvVEp5M+ZHj9RiXC+Zk4W+aQYQ8OO818thKh4Y6wU=;
  b=kE0SrRZnwgBMUevZ2D5QQ56Z+dM/HDTbSphs2l0dTeipvOSrVFNN0gmG
   gdt6/jXhthb+qbir4gDxeHLO8ZzYw9K47q8cq7BZlmcWpqp4PpjAU0JVl
   cRuEOMuaL1zAIQYV2dN5du1Naf07fPrNo/Kg3PnZSGmoYC424H1ZsRaM6
   G/QXxqgMQcAnJ+jQ4fKw9+fJ3kUupKKU2OCaS2pz7EWgwItLdUSFDyJ8C
   289+/cAx8nQwDwmPotRI5+Uq6wr2Kx/nm3lZ3viJ33e6JjxaBNeMmWtMZ
   hRu2vk8Rh8HWL/6Pn942j+2D39dIjfgWUiVVtesR04PGIBuXZN65ZySbn
   A==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="38760229"
IronPort-PHdr: =?us-ascii?q?9a23=3AZlED6x3pKP2LDnCIsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMWI/ad9pjvdHbS+e9qxAeQG9mCt7QZ0KGJ7OigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4tvJ6g+xh?=
 =?us-ascii?q?bLoHZDZuBayX91KV6JkBvw+8m98IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7TctMAQW?=
 =?us-ascii?q?pKQ9hfWSpPDIiha4cDFuQMMOJdo4T7ulAArwaxBRO0Ce3yyjFGmHH206403e?=
 =?us-ascii?q?svHg7J3hAvEd0VvXTIr9j4LrseXfy7waTKyzjIcvNY2S366IjNah0vvO2MUq?=
 =?us-ascii?q?xoccrR10YvER7OgEiVqYP/OzOV0voCsmiG5OdnTuKglnUnphptojmv2sgsio?=
 =?us-ascii?q?7JipgTylDf7yp12ok1JdqmSENiZ9OvDZhetzmCOodrTc4vTHtktSYnxrEcp5?=
 =?us-ascii?q?K2czYGxI46yxPZdveJaZKH4gj5W+aUOTp4gXVld6+hiBuq6kigz/H8VtGz0F?=
 =?us-ascii?q?ZXsipJitnMuW4J1xzU8sWHVuFy/l2g2TaSzADf8OBEIUY6larcMJ4u3KI/mo?=
 =?us-ascii?q?APsUXDAiD2mEL2gLWQdko44ein9/7rYrDnpp+YL4N0iwf+PboymsGnHOg1PQ?=
 =?us-ascii?q?cDU3Kb9OihzrHv40L0TKtQgvEriqXZtYrVJcUfpq63GQ9V1YMj5g6kDzi7y9?=
 =?us-ascii?q?QVhmUHLVJZdxKHiIjlIVfOIOviAvuljFSslylry+jcPrL9GpXNMmTDkLD5cL?=
 =?us-ascii?q?lh5E5dyQ0zzdZB6JJPEbwBL/XzWkj+tNzcEBA5Nha7w+fjCNlnyoweXmePCL?=
 =?us-ascii?q?eDMKzOqV+I+v4vI+6UaY8Opjn9L/kl5/jzjX42glIdY6ap0oUNaHyiHfRpPV?=
 =?us-ascii?q?+ZYXzyjdcFC2sKuRA+TOO5wGGFBBVTfXepQ6M14AYUlp66FozDS8j5i7OT2y?=
 =?us-ascii?q?G2BbVZYWdJDl2JGHbsMY6DXqFIIDmfJs5njywsS7esUcki2AuouQu8zKBofc?=
 =?us-ascii?q?TO/ShNjo7uzNh44aXokBg28TFlR5CG33qlU3B/nmROQSQ/mq94vxoumR+4za?=
 =?us-ascii?q?FkjqkARpRo7PRTX1J/bs/R?=
X-IPAS-Result: =?us-ascii?q?A2A7AwCGNTxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsIRIqhBWJA4ZlAQEBBoE3iXCKJ4ckCQEBAQEBAQEBATcBAYRAAoJhOBMCE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshUOCOymDAwEFIw8BBVELGAICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CSwMJJawugTKIQg1igT6BDiqMPXmBB4E4D4JdPoIbhUCCXgSYBJdngkSCT?=
 =?us-ascii?q?pNyBhuCOJhTLY41nTQigVgrCAIYCCEPgydQGA2OKReOQSMDMI5KAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Feb 2020 15:50:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016Fnnf4111827;
        Thu, 6 Feb 2020 10:49:49 -0500
Subject: Re: [PATCH] libsepol: add support for new polcap
 genfs_seclabel_symlinks
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20200131183900.3507-1-cgzones@googlemail.com>
 <35cc375a-1c8e-5394-3ab5-55741374fa15@tycho.nsa.gov>
Message-ID: <0ce2fc62-5e17-08f5-e07e-148cd1a51582@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 10:51:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <35cc375a-1c8e-5394-3ab5-55741374fa15@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/20 8:34 AM, Stephen Smalley wrote:
> On 1/31/20 1:39 PM, Christian Göttsche wrote:
>> Add support for new SELinux policy capability genfs_seclabel_symlinks.
>> With this capability enabled symlinks on kernel filesystems will receive
>> contexts based on genfscon statements, like directories and files,
>> and not be restricted to the respective filesystem root sid.
>>
>> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Applied.
