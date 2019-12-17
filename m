Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4A4C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 16:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B437B21D7D
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 16:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Nq1TQMlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfLQQsu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:48:50 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:42492 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfLQQsu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 11:48:50 -0500
X-EEMSG-check-017: 58200897|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="58200897"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 16:48:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576601328; x=1608137328;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=gfFjUVLfV1tQXAREmAwe6zzxMsJo/IhpXtdMM7M/LCE=;
  b=Nq1TQMlOT9i9oHuoagMbz2RcEOsHl7Zdkdo2x9BsrQcZklsLLDuTqCvR
   TAKV4EKL/tzBjLk6KZVk12zWGOf3atY+NBF1jd6bJu9G2a+8PItIsXjSk
   ODuYRWlnWaNVLoo8BV8kubslWOoKCihpuha358SMR6DBH5xPBjrdS39AR
   G0WKpgOSwuXzXxeUVOZdFW2ON6WKikKtoExA6F/gRvuPAwtmUqV0EQOFt
   lth8NmX+AN2kNHuatsJFRuQp+CohpsosTIMfmLFT2Cr93HlIN9WnnjL9I
   lQBOXZEOWrrDRER2q1/DpggSpZaLblFFuTyBrAcLdEkdpk9OxHHfm8ML1
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31192539"
IronPort-PHdr: =?us-ascii?q?9a23=3ApSXHmheUz3LG1tlMJJHrR3BWlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26ZxeN2/xhgRfzUJnB7Loc0qyK6vumAzRfqsfY+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUanYlvJqk1xx?=
 =?us-ascii?q?fUv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAeoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lp?=
 =?us-ascii?q?sVsUTNGS/2g1v5g7OMekU4+umn9+TnYrL8qp+aK4B0kR3xPr4rmsy+BeQ0Kg?=
 =?us-ascii?q?kOX26F9uSgzLDv4EL0TbpQgvA2j6XVqo7WKMsFqqKjHgNZyoMj5Ay+Dzei3t?=
 =?us-ascii?q?QYh34HLFdddRKckofpIErDIOz4DPijg1Ssly1nx/bdPrL7GJnNIX/DkKn5cb?=
 =?us-ascii?q?Zn90Fc0BYzzcxY559MELEBIe78Wk/ru9zCExA2KxC7zP7nCNpn14MeX3yAAr?=
 =?us-ascii?q?SCPazJrV+I5+QvI/WSa48PvjbyNeQl6+Tygn8+nF8XZbOp0ocPaHCkAvRmJF?=
 =?us-ascii?q?2UYWHyjdcFEGcKuBc+TePxhV2cXj5ceWyyU7g/5j4lEoKmC5nMRoS3jLyGxi?=
 =?us-ascii?q?e7EYVcZnpaBVCUDXfoa4KEVu8LaCKXJc9hiToEWqK9RIA/zhyurhH1xKdnLu?=
 =?us-ascii?q?XO5i0Ur47s1N9w576bqRZnzz1/D82H3ymtRmByk3hAEyU316B2u0BKwWCD2K?=
 =?us-ascii?q?l+judwH8BS4e9ESAE3KdjXyOksT5jpVwbAeMqZYEipT8/gAjwrSN81hdgUbA?=
 =?us-ascii?q?I1PNOulB3Blw+tGLkcnLGITMgz96XH2XH6Ku5nxnrG3bVnhF4jFJhhL2qj05?=
 =?us-ascii?q?Vj+hDTCoiBqECQk6KnZOxIxyLW3HuSxmqJ+kdDWUh/VruTDiNXXVffsdmsvh?=
 =?us-ascii?q?CKdLSpE7lyd1IamMM=3D?=
X-IPAS-Result: =?us-ascii?q?A2ASAABwBvld/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFtAgEBAQELAYFzgW0gEiqEBIkDhnMEBoE3iWqRRQkBAQEBAQEBA?=
 =?us-ascii?q?QE3AQGEQAKCPDcGDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIxVRCxgCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBF4JIP4JHAwklrGwaNXWBMoVPgziBSIEOKAGMMXmBB4E4D?=
 =?us-ascii?q?4JdPoIbhT6CPCIElwxGlzOCPoJCk0gGG5pJjk2cXSOBWCsIAhgIIQ+DJ1ARF?=
 =?us-ascii?q?Jt2IwMwkgABAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 16:48:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHGmRac123351;
        Tue, 17 Dec 2019 11:48:29 -0500
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
References: <20191215170620.73506-1-richard_c_haines@btinternet.com>
 <20191215170620.73506-2-richard_c_haines@btinternet.com>
 <ace92ec4-2276-9af8-bb52-c942d0be7605@tycho.nsa.gov>
 <d72ecf26-152d-2642-6f1a-8bebe9d1eb69@tycho.nsa.gov>
 <ca2340581dafaca79860d249bd048bbb6ffe0593.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cf9921c8-47e0-d384-b732-fd017a587d54@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 11:49:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ca2340581dafaca79860d249bd048bbb6ffe0593.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/17/19 11:38 AM, Richard Haines wrote:
> On Tue, 2019-12-17 at 10:36 -0500, Stephen Smalley wrote:
>> On 12/16/19 9:09 AM, Stephen Smalley wrote:
>>> On 12/15/19 12:06 PM, Richard Haines wrote:
>>>> Test filesystem permissions using mount(2)/umount(2).
>>>>
>>>>   From kernels 5.5 filesystem { watch } is also tested.
>>>>
>>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>>
>>> This didn't pass travis-ci, looks like a combination of failing
>>> check-syntax and FAN_MARK_FILESYSTEM not being defined (maybe the
>>> kernel
>>> headers are too old in the base distro?).
>>
>> Possibly we need to install our own kernel headers for the testsuite?
> I assume this is on the travis system (that I don't use).

Yes, the build/test environment is specified by the .travis.yml file in 
the selinux-testsuite repo.  Currently uses a bionic Ubuntu distro as 
the base (sadly Fedora isn't an option).  In other situations where we 
have had dependency problems, we have explicitly had it download the 
desired upstream sources and install them, e.g. for perl tidy, libbpf, 
keytuils, etc.  Should be possible to do the same with the kernel 
headers instead of just using the distro-provided ones.  Or your test 
code could have #ifndef FAN_MARK_FILESYSTEM...#define 
FAN_MARK_FILESYSTEM...#endif; we have some instances of that already for 
SO_PEERSEC, SCM_SECURITY, MAP_HUGETLB, AF_KCM, etc.  That's probably the 
easiest solution.


