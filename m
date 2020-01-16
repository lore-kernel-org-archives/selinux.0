Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8276C33CAF
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE4020730
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="W0eS7hD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbgAPUgT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:36:19 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:35453 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgAPUgS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 15:36:18 -0500
X-EEMSG-check-017: 46668547|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,327,1574121600"; 
   d="scan'208";a="46668547"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2020 20:36:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579206975; x=1610742975;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZqNGzYR0V6pt26dywnTkUEFduA7t+EYYb3KXJmQVS6E=;
  b=W0eS7hD5D8aR8Ag4T9HKibGWwFx7lXoYrpHyBLj3Hs0AZKhgZQgOzEa+
   VXq4HBuw2QxnLKoXxG+ZowoDUZYDFxsP/tYvfAR8hXmJJIqn682/f6tH7
   kRb3hWMy6fZ4ubHD0UOLpXvlzpA+bmjkHE2nBuYzkcSYFrKxUAdKwDPD0
   z6bPUpCxFaG0PypvnOxtiICqj518Pv+hMpGWDrPPMlaHXFwGu00hX+oLN
   2PXXx2SMkngII3Bl3385cGLLht+nF10YKTNPYsU8dVWvzZxsxFoLAAHNm
   H2SQMht+P4hpO7/2DU0BFr+Oxhn5UAc1+dw+4mMt8B/d3nFfro5o08Jjy
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,327,1574121600"; 
   d="scan'208";a="32051727"
IronPort-PHdr: =?us-ascii?q?9a23=3A6KpGDxapUUct28qmwyBkRnX/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8y9bnLW6fgltlLVR4KTs6sC17OK9fi9EjVbvN7B6ClELMUXEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/Jas90A?=
 =?us-ascii?q?fFr3tHd+hLy25lJU+YkxLg6sut5pJu/Dlctvw7+8JcTan2erkzQKBFAjghL2?=
 =?us-ascii?q?07/tDguwPZTQuI6HscU2EWnQRNDgPY8hz0XYr/vzXjuOZl1yaUIcP5TbYvWT?=
 =?us-ascii?q?S/9KhrUwPniD0GNzEi7m7ajNF7gb9BrxKgoxx/xJPUYJ2QOfFjcK7RYc8WSG?=
 =?us-ascii?q?xcVclfTSxBBp63YZUJAeQPIO1Uq5DxqlsKoBe7AwSnGeHhxSJShnLuwKM00/?=
 =?us-ascii?q?ovEQ/F0gIuEd0Bv3bbo8n6OqoJTeC4z7PFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK58nwr4+kZ?=
 =?us-ascii?q?oTqlrMETPslEXqjK6ZakUk+u+y5+ThfrrmvYOTO5VxigH/NqQigs2/AeImPQ?=
 =?us-ascii?q?gSR2WX5Oux2bL58UD5XblGlOM6n6bHvJzAOMgXvqu5DBVU0oYn5Ra/FTCm0N?=
 =?us-ascii?q?EAkHkcMV1FYwmKj5TpOl7SIPD4Cu2zg1K3kDhx3fzGMbrhAovVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcr1tBQ+ZZUCrAHIPLuVU78r8LYDhAnPAyu2ernC8ty1pkYWW2RBq?=
 =?us-ascii?q?+VKqTSsUWH5rFnH+7Zf4IRuTDgO9A76PP0y3w0g1kQee+ux5RERmq/G6FdP0?=
 =?us-ascii?q?iBYXfqyuwEGGMOsxt2GPfmk3WeQDVTYDC0RKt66TYlXtH1RbzfT5yg1eTSlB?=
 =?us-ascii?q?ywGYdbMyUbW10=3D?=
X-IPAS-Result: =?us-ascii?q?A2AgCABPyCBe/wHyM5BlHQEBAQkBEQUFAYF7gX2BbSASK?=
 =?us-ascii?q?oQQiQOGXgEBAQaBEiWJbpFJCQEBAQEBAQEBATcBAYRAAoImOBMCEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOymCewEFIw8BBS8SEAsYAgImAgJXEwYCAQGCYz+CVyWsW?=
 =?us-ascii?q?IEyiRmBPoEOKIw2eYEHgTgMA4JdPoQzY4JDgl4EjTaKQJdWgkOCSZNhBhuac?=
 =?us-ascii?q?KtxIoFYKwgCGAghD4MnUBgNiA0XjkEjAzCNbAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Jan 2020 20:36:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00GKZX9H141508;
        Thu, 16 Jan 2020 15:35:34 -0500
Subject: Re: [PATCH] libsepol,checkpolicy: remove use of hardcoded security
 class values
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov
References: <20200116200136.19687-1-sds@tycho.nsa.gov>
 <81187899-b56a-1b97-4dc5-e1d09e78320b@tycho.nsa.gov>
Message-ID: <f27dc451-ea30-cdd2-8784-80448318fedb@tycho.nsa.gov>
Date:   Thu, 16 Jan 2020 15:36:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <81187899-b56a-1b97-4dc5-e1d09e78320b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/20 3:34 PM, Stephen Smalley wrote:
> On 1/16/20 3:01 PM, Stephen Smalley wrote:
>> libsepol carried its own (outdated) copy of flask.h with the generated
>> security class and initial SID values for use by the policy
>> compiler and the forked copy of the security server code
>> leveraged by tools such as audit2why.  Convert libsepol and
>> checkpolicy entirely to looking up class values from the policy,
>> remove the SECCLASS_* definitions from its flask.h header, and move
>> the header with its remaining initial SID definitions private to
>> libsepol.  While we are here, fix the sepol_compute_sid() logic to
>> properly support features long since added to the policy and kernel,
>> although there are no users of it other than checkpolicy -d (debug)
>> and it is not exported to users of the shared library.  There
>> are still some residual differences between the kernel logic and
>> libsepol.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
> I see that this fails travis-ci; looks like the problem is that it 
> trades using hardcoded values for SECCLASS_PROCESS and _DIR and the 
> PROCESS__TRANSITION/DYNTRANSITION permissions for requiring the strings 
> to be present in the policy and that isn't true of some test policies. 
> The kernel does require at least the process class and perms to be 
> present or it will reject the policy at load time presently (when it was 
> likewise converted long ago as part of dynamic class/perm support). 
> Options:
> - Weaken the restrictions in libsepol's policydb_read and accept the 
> fact that the class/perm values may be zero subsequently within libsepol.
> - Change the test policies to at least provide this minimal set.
> 
> The "dir" class isn't currently mapped at load time by the kernel but it 
> unmaps it for genfs_sid() matching so it still expects it to be present.

I guess if nothing else it ought to be conditional on 
SEPOL_TARGET_SELINUX to avoid breaking Xen policies.

