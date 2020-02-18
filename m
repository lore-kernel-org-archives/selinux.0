Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFDFC34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 15:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B3722527
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 15:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EiNgNRPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgBRPkU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:40:20 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:41582 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgBRPkU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 10:40:20 -0500
X-EEMSG-check-017: 59573363|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="59573363"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 15:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582040418; x=1613576418;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=pok7/h3lecSqPmzjnExpN1j9qHgba73kKstGrCjnNWQ=;
  b=EiNgNRPi1EAmVcJq1sHsIv3hb+4CX2TJkw7D0asxvK0nt/afF4CmVKf6
   YJeio8ZM9lRPX4oXgDRqimFyFqyhyeD5N+LcW3oYE4ABM3h/4p73WEMaC
   xvmoJpyu4yJZDsC0VSn3S/TGDdENAJDmPVNRVnnX6DDOq8mzYfeipDEfu
   Mh5GGHcm7LKeDnsj4uM1jKmpzSZXq0Bu9OWVH7RfgDFeDWoGXBAabZRAj
   E8MLRaK93ngV9vqk7Nkkr4QOxTo1YZ29KAnPJJwyz6X3p7qr70/XvjmJr
   lQbdclNcouYbHxNkZA2qvnySf6mUoIvSt6aArVJQiuKEAU6DQtQGdIOHO
   w==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="39227980"
IronPort-PHdr: =?us-ascii?q?9a23=3ANAjUGhwHS7I3EFrXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2ugQIJqq85mqBkHD//Il1AaPAdyHra0UwLWH+4nbGkU+or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCeybL9oLhi7rgrdu8sSjIB/Nqs/1x?=
 =?us-ascii?q?zFr2dHdOhR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4xkJ?=
 =?us-ascii?q?oTv0PDHjTol0rqlqOWakUl9fSo6+TgeLnmoIOTN5RohQ3kN6Qum8i/Dfw5Mg?=
 =?us-ascii?q?gIQWeb5fyx2KDs8ED2WrlHjuA6nrPHvJ3VO8gXvLO1DxdQ0ok56ha/Czmm0M?=
 =?us-ascii?q?4fnXkCNF9FYw+Ij5PyNlHSIPH3Efe/g1O2nDdt3PDJJKftAprKLnjdiLvhZ6?=
 =?us-ascii?q?py61ZAyAovytBS/5VUCrQGIPLoXE/+rsDXAQEiPgyu3enoFdV92ZkCWW6VHq?=
 =?us-ascii?q?CZN6bSu0eS5u0zO+mMeJMVuDHlJvg++fHuiX45mVkAfaimxpYXdn+4Eep8I0?=
 =?us-ascii?q?mDYnrjnM0BEWEUsQo6VuDqj0eCUTEAL0q1CoU66is2CsqDCpzFT4ugg/TV2y?=
 =?us-ascii?q?K8BZtfbW1uEF2AEX70MY6DXqFIIBm/Js5njyxMUbm6V8d1zhyqtQnn25J5Ie?=
 =?us-ascii?q?fOvC4Vr5Tu0J5y/eKFxj8o8jkhNNiQy2GASSlPm2oMQzInlPRkrVdV1kaI0a?=
 =?us-ascii?q?8+hedRU9NU+aUaAU8BKZfAwrkiWJjJUQXbc4LMEQ33Tw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ASCgA5BExe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XuBbAEgEiqEFIkDhl4DBoESJYlwj1CBegkBAQEBAQEBAQE3BAEBhEACgic7A?=
 =?us-ascii?q?w0CEAEBAQUBAQEBAQUDAQFshUOCOykBgwIBBSMVUQsOCgICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCYz+CVyWsaoEyhUqDVIE+gQ4qjD55gQeBOAwDgl0+h1uCXgSXUkaXcoJFg?=
 =?us-ascii?q?lCUAwYcmyaObZ1hAQ+BWCsIAhgIIQ+DJ1AYDY4oGI5BIwMwkGkBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Feb 2020 15:40:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IFdDZw026679;
        Tue, 18 Feb 2020 10:39:13 -0500
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200213133959.14217-1-omosnace@redhat.com>
 <CAFqZXNuxHYN_cMY1+PfUFrwu6dQyG5qc7LGPU8VbUAyTXRF_Wg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7d80365c-d2ea-f167-0757-6038becdb5fc@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 10:41:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNuxHYN_cMY1+PfUFrwu6dQyG5qc7LGPU8VbUAyTXRF_Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/18/20 10:22 AM, Ondrej Mosnacek wrote:
> On Thu, Feb 13, 2020 at 2:40 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> According to profiling of semodule -BN, ebitmap_cardinality() is called
>> quite often and contributes a lot to the total runtime. Cache its result
>> in the ebitmap struct to reduce this overhead. The cached value is
>> invalidated on most modifying operations, but ebitmap_cardinality() is
>> usually called once the ebitmap doesn't change any more.
>>
>> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
>> decreased from ~14.6s to ~12.4s (2.2s saved).
> 
> I have no idea why, but I'm now getting completely different times
> (10.9s vs. 8.9s) with the same builds on the same setup... I can no
> longer reproduce the slower times anywhere (F31/locally/...) so I have
> to assume it was some kind of glitch. Since the numbers show a similar
> magnitude of speed-up (and they depend on a bunch of HW/SW factors
> anyway), I'm not going to do another respin. The applying person (most
> likely Stephen) is free to fix the numbers when applying if they wish
> to do so.

Thanks, applied with fixed times (although I don't really think it 
matters very much).  Maybe you're also picking up the difference from 
the "libsepol/cil: remove unnecessary hash tables" change.

