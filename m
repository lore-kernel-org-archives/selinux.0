Return-Path: <SRS0=4+dM=3K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71382C2D0DB
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 16:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46842206A2
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 16:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="nXrpgU5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUQc6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:32:58 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:51504 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUQc6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jan 2020 11:32:58 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2020 11:32:57 EST
X-EEMSG-check-017: 48074954|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="48074954"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Jan 2020 16:25:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579623945; x=1611159945;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=BqRl8JGp4Sklw/7dooHDKqI8ERjysC+kAU83UcTc8Z8=;
  b=nXrpgU5Aly9wmwtn6eVsrhrPpj6641G8zIDQVURcEs6j2JyLAbCztKx+
   1MoiOCXkhFwAfeu+QNCA1Wuufu3z5/PbH87yNZZ6avGZHxc+kO9tFioDe
   v7DhbX7K7aewm8GsYcKrncoHpvZoRJ7NKmmww2X5mJW2Z4UujHiOIj6FU
   teR80/5fq0iu699X5uj8pDNDSN2cXe6Rrikd1pv2AtCLjd37WpDvxCoP0
   5HbwMVIKFOk8QRmfp+BrL+OliBy6eloNLt+yhN/XeLPXco8Oj13hli8FN
   UKCzx4s95PZtdkBkC0EjnO+Q+lte3rVzoIDByWn0xiiLkqYvfpAc1+MhE
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="32154823"
IronPort-PHdr: =?us-ascii?q?9a23=3AOk1/FhZ1zpxi1XAxql/6SGP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsm+bnLW6fgltlLVR4KTs6sC17OK9fmwEjxdqdbZ6TZeKccKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZtJ6or1x?=
 =?us-ascii?q?fEoXREdudWyGh1IV6fgwvw6t2/8ZJ+/Slcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWH?=
 =?us-ascii?q?FMVdhNWSNfHoy8bpMPD+sfMuZes4n9vEYFoR+nCQWxGO/j1jpEi3n40q0g1+?=
 =?us-ascii?q?QqDB/I0gouEdkTtHjYtdX4OaMXXe2z0aLGzyjMb+lO1Dng9obIfBAvr/KCU7?=
 =?us-ascii?q?1+fsXey1UgGQzeg1WMq4HoJS+Z2vgDvmWZ6edrSOKhi3QgqwF0ujWvxMkthZ?=
 =?us-ascii?q?XTiYIP1lDI6zhyzYE3Jdy2VEF0e8SkEIdOuyyBK4t3Qt8tQ2FvuCogzL0Goo?=
 =?us-ascii?q?S0cDIFyJQg2R7ScvqKeJWL7BL7TOudPDh1iX1/dL+/mhq+61asx+LiWsWuzV?=
 =?us-ascii?q?pHqDdOnMPWuXAXzRPT79CKSv56/ki8xzmCzxvT6uRYIUAskqrbNoIhzqYwlp?=
 =?us-ascii?q?UNtUTDGTf7mFnsg6+Md0Uk5/Oo5/7mYrXgqJ+cMJR0hR/iPag0hsy+Afg3Mg?=
 =?us-ascii?q?gJX2SB/+SzyKbj8lHjTLVPj/02lrHVsJHcJcsFuq60GxJZ34ks5hqlDzqqzc?=
 =?us-ascii?q?4UkWcIIV5bYh6LkpDlO1TUL/D5Cfe/jU6skDBux/3ePL3gDInCIWLZkLf9Y7?=
 =?us-ascii?q?pw8FJcyQovwtBf4JJYELcBIOnpVUPru9zYCQE5PxSuw+n7ENV9yp8eWWWXD6?=
 =?us-ascii?q?CEN6PStF6I5uQuI+aQZ48Zojn9K+Ik5/7gkX80gkIScren3ZQJbnC4BeppLF?=
 =?us-ascii?q?mDbXrqhtcLCX0KsRYmTOz2lF2CViZeZ22sUKI45zE7Dp+mDIjYS4Czj7yOwj?=
 =?us-ascii?q?27EodVZm9YEFCMF2nnd4GeV/cLciKSLZwprjtReb+kSokg3hLmmxX7xaYveu?=
 =?us-ascii?q?bT/ywetJngktdv5uPPvR0/+zFyFMmWlWeJGSU8hW4MRjkrzIhhrkFnjFSOy6?=
 =?us-ascii?q?51h7pfD9MAyelOV1I4KpXV1fAgQ4TwRQnIZMvTYEq3SdWhRzcqR5Q+xMFYMB?=
 =?us-ascii?q?U1IMmrkh2Wh3niOLQSjbHeQcVpo68=3D?=
X-IPAS-Result: =?us-ascii?q?A2DqAwBuJSde/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQSiQOIAiWbNwkBAQEBAQEBAQE3AQGCE4ItAoI2OBMCEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOykBgnkBAQEBAgEjFUYLCwkPAgImAgJXBgEMBgIBAYJjP?=
 =?us-ascii?q?4JcIK1GdYEyhUqDMoE+gQ4qjW5AgTgMA4JdPodZgl4EgT8BjBKJYEZ6lWp2B?=
 =?us-ascii?q?oI9lisGG5p3jl6XIIV3IoFYKwpBgWiBTlAYDYg5jiwjAzCOEQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 21 Jan 2020 16:25:34 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00LGOrTs075222;
        Tue, 21 Jan 2020 11:24:53 -0500
Subject: Re: [Non-DoD Source] Re: any reason why a class mapping is not able
 to solve permissionx?
To:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
References: <20200117173448.GA166208@brutus.lan>
 <20200117182405.GA182181@brutus.lan>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <904dcd8e-9b0b-b444-4931-4dc165e4fb1f@tycho.nsa.gov>
Date:   Tue, 21 Jan 2020 11:26:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117182405.GA182181@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/20 1:24 PM, Dominick Grift wrote:
> On Fri, Jan 17, 2020 at 06:34:48PM +0100, Dominick Grift wrote:
>> For example this:
>>
>> (permissionx alg_socket_ioctl_except_SIOCGIFHWADDR (ioctl alg_socket (and (all) (not (0x8927)))))
>> (classmap all_sockets (ioctl_except_SIOCGIFHWADDR))
>> (classmapping all_sockets ioctl_except_SIOCGIFHWADDR alg_socket_ioctl_except_SIOCGIFHWADDR)
>>
>> (allowx a self (all_sockets (ioctl_except_SIOCGIFHWADDR)))
>>
>> Say's:
>>
>> <snip>
>> Building AST from Parse Tree
>> Destroying Parse Tree
>> Resolving AST
>> Failed to resolve classmapping statement at policy/base/class_maps.cil:994
>> Problem at policy/base/class_maps.cil:994
>> Pass 14 of resolution failed
>> Failed to resolve ast
>> Failed to compile cildb: -2
>> make: *** [Makefile:30: policy.32] Error 254
>>
>> Am i doing something wrong or is this unsupported?
> 
> Are we supposed to be able to use allowx rules in macros?
> 

Yes, allowx rules can be used in macros.

> This works when the tunable is set false:
> 
> (tunable no_mac_addr true)
> 
> (block bla1
>          (blockinherit system_agent_template)
> 
>          (macro stuff ((type ARG1))
>                  (tunableif no_mac_addr
>                    (true
>                        (allow ARG1 self create_except_ioctl_tcp_stream_socket_perms)
>                        (allowx ARG1 self tcp_socket_ioctl_except_SIOCGIFHWADDR))
>                    (false
>                        (allow ARG1 self create_tcp_stream_socket_perms)))))
> 
> (block blah2
>          (blockinherit system_agent_template)
> 
>          (call bla1.stuff (subj)))
> 
> But when the tunable is set true:
> <snip>
> Building AST from Parse Tree
> Destroying Parse Tree
> Resolving AST
> make: *** [Makefile:30: policy.32] Segmentation fault (core dumped)
> 

Still trying to figure out the exact issue, but it is the use of the named 
permissionx that is causing the seg fault.

Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
