Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB24AC282DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 18:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5AD20678
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 18:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OJx05ldw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgAISEC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:04:02 -0500
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:22650 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgAISEC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jan 2020 13:04:02 -0500
X-EEMSG-check-017: 64456253|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="64456253"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2020 18:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578593039; x=1610129039;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KH9CxvzWSzCfrOqX6QTdwP/QJy2Fkw5A2wGFWe6b958=;
  b=OJx05ldwroKFVa31grHhF+8w/l6nRz1JnqjwYdAYLeBcSvEems3PKFm/
   4I6JuF3jO73XhK1w0XAAipOfntMyDUhszhdErUsq7/DDU1Rkv9ebRh2fI
   5cveULlJw0SrzqUEH9rOCFF8gF9nY5GZ51l2lmJjuVum5DIZqZ8LKcdLX
   LIUD+G2UPMb+QEEDOcLKEsGXAhXUPQ7bxt8XAPs/+LSWC4SaHK2SswQvn
   KrE/pVmlqHMTZzDtE3guTUaSgB8PnGe/6lAQMpp4PLHu6WxSkKvIoQ3+H
   I6KUU+sSDeqRpp8qC4RIo+ACyU6X3E55+Ugo4ygcWzXIdovRChIMVDOoE
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="37564573"
IronPort-PHdr: =?us-ascii?q?9a23=3Agydpoh+eoCWYwf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B22u4cTK2v8tzYMVDF4r011RmVBN6dsawdwLWM+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanf79/LQi6oQrTu8UInIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?VPRMZRUzFKDJ26YYUBEuENOf9Uoon5qlcLqxa1GAuiC/71yjJQm3H4w6M63e?=
 =?us-ascii?q?QiHw/I0gMvENABv2jbotjuKKcfU/q4wLXUwTjNbf5b3yr25ojSchAmpPGBRa?=
 =?us-ascii?q?9+cdbPxkk3FwPKkFOQopH4MTOQzOsNt2yb4PRgVOmyjGMnsBx+oiO0y8cwio?=
 =?us-ascii?q?jGmoIVylfe+SV/24Y6P8e0SEF8Yd66CZZdsTyROYhuQs46Xm1ltyk3xqcGtJ?=
 =?us-ascii?q?KmZiQG1psqywDFZ/CadYWD/wjtW/yLIThigXJoYLe/hxGv/ke+0uD8Tcy00E?=
 =?us-ascii?q?pSripCj9nMqmgB1xzN5ciDTftw5luh1iyV1wDS9+FEOlo4lavdK54vxb4wjY?=
 =?us-ascii?q?QcvljZEi/qmET5kK+WdkI+9uiu9+vneanpqoWZN491jgHyKqUumsqhDuQkKg?=
 =?us-ascii?q?UCQmeW9Oum2LDj4EH1WqtGg/IonqXDrZzWPcEbqbS4Aw9R3IYj8RG/DzK+3d?=
 =?us-ascii?q?QDgHYHN0lIeA6Hjof1O1HOJ+r0DfGkg1u2ijtryPfGPqP5DpXXMnfDiKvhfa?=
 =?us-ascii?q?p660NE0gozzMxQ55JOBbEbPf38QlP+u8TYDhAjMgy0xfjoCM5m24wFRWKPA6?=
 =?us-ascii?q?mZML/Mvl+S4OIgPfWMaJUJtzb6Lvgv/+TugmMhmV8BYamp2oMaaGumEfRiIk?=
 =?us-ascii?q?WZZ2fsg9gaHGcUsQoxUvbqhEeBUTFNfXayWbwz5jUhBIKhF4fDSZingKad0y?=
 =?us-ascii?q?ejAp1WemdGB0iLEXftcIWEQPEMZziOLcB/iTEET6auRJIh1R60qA/20aZoLu?=
 =?us-ascii?q?3R+n5QiZW27tl+5+TJmVkS/D1yAt/Vh3uMRGF9hG8/TAg21aF5rFdVwEuC17?=
 =?us-ascii?q?R1mfpVCZpY4PYfFk8hOJrdyfFqI879VxiHfdqTTluiBNK8DmIfVNU0luQSbl?=
 =?us-ascii?q?59FtPqtRXK2y6nEvdBjLCQLIAl+aLbmX7qLoByzGiQh/pptEUvXsYabT7uva?=
 =?us-ascii?q?V47QWGQteUwkg=3D?=
X-IPAS-Result: =?us-ascii?q?A2AZAQClahde/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF9gWwBIBKEM4kDhmEBAQEBAQEGgTeJbpFICQEBAQEBAQEBATcBAYRAA?=
 =?us-ascii?q?oITOBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMVQRALGAICJgICVwYBD?=
 =?us-ascii?q?AgBAYJjP4JXJatxgTKFT4NBgT2BDiiMM3mBB4E4D4JdPodZgjwiBI0+ColXR?=
 =?us-ascii?q?niWT4JAgkWTXAYbmmSOWJx9IoFYKwgCGAghD4MoTxgNV5sfIwORRQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 Jan 2020 18:03:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 009I33Wn239948;
        Thu, 9 Jan 2020 13:03:04 -0500
Subject: Re: [PATCH V2 0/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7281d970-cd5d-aee9-c790-fbf5951273d6@tycho.nsa.gov>
Date:   Thu, 9 Jan 2020 13:04:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109150709.360345-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/20 10:07 AM, Richard Haines wrote:
> These tests should cover all the areas in selinux/hooks.c that touch
> the 'filesystem' class. Each hooks.c function is listed in the 'test'
> script as there are some permissions that are checked in multiple places.
> 
> Tested on Fedora 31 and Rawhide (5.5 for the new watch perm).
> 
> V2 Changes:
> 1) If udisks(8) daemon is running, stop then restart after tests. The tests
>     run faster and stops the annoying habit of adding mounts to the 'files'
>     app on the desktop. Supports /usr/bin/systemctl or /usr/sbin/service
>     More importantly it stops interferance with the '*context=' tests as it
>     can cause intermittent failures. Tested by running 'test' in a continuous
>     loop with udisks enabled, and then again disabled.
>     Loop 200 times, with udisks failed between 1 to 70 iterations, without
>     udisks, no failures.

Wondering why udisks is causing failures - that seems like another bug.
