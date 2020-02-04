Return-Path: <SRS0=kuBz=3Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE8C2D0B1
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 13:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF0E20661
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 13:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ehkeWYEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBDNgZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:36:25 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:42586 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgBDNgY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Feb 2020 08:36:24 -0500
X-EEMSG-check-017: 54254229|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,401,1574121600"; 
   d="scan'208";a="54254229"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Feb 2020 13:36:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580823381; x=1612359381;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SEZbeFkKrkV8OwDu/vPGTpZ7EZ7v018hG0irrPr6shM=;
  b=ehkeWYEn/MqokUfjSw4U8S6X8WVwAeZ1NJdKM0hh+3bWjvBeQFBAHUVK
   KLICY2QJnKBtNV7+yVcl5BLX/u/ABm9kIcdkkrp059FvB3eo9Mu2WhfAL
   8AMeCa3kcR4Bu57+UdU0i9LCDdmSR8KziJS8lUFWlhaK+EWMay2wPSM+0
   pVZjfLHvmX2qJ/E8tN78gPinBl8YmJtT8AuPYYq43RrEtyckYA5DINaNv
   BuAfR2CBeSJW3FXNnhSgfUUhbLCIvE+fyBKnq/Mud/88ug14gfiia+LSM
   nW5OSbG9nnaPy1AVlmEWG1LE9soWhM4IhmmVHmDacoOl0pY4SqYNhe41I
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,401,1574121600"; 
   d="scan'208";a="32649903"
IronPort-PHdr: =?us-ascii?q?9a23=3ASU6HtBHO9O6YLXZhBN3Th51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76osy+bnLW6fgltlLVR4KTs6sC17OK9fyxEjFbqdbZ6TZeKccKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZtJ6orxR?=
 =?us-ascii?q?bEpnREduRYyGh1IV6fgwvw6t2/8ZJ+/Slcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWH?=
 =?us-ascii?q?FMVdhNWSNfHoy8bpMPD+sfMuZes4n9vEYFoR+nCQWxGO/j1jpEi3n40q0g1+?=
 =?us-ascii?q?QqDB/I0gouEdkTtHjYtdX4OaMXXe2z0aLGzyjMb+lO1Dng9obIfBAvr/KCU7?=
 =?us-ascii?q?1+fsXey1UgGQzeg1WMq4HoJS+Z2vgDvmWZ6edrSOKhi3QgqwF0ujWh29sshZ?=
 =?us-ascii?q?fRhoIV1F/E8zhyzpswJdKiTE57ZcCrEZtNvCydLIt5X9giTnp0uCc61rIGuZ?=
 =?us-ascii?q?m7cDIMyJQ83RHTcfOHc4+W4h/6UuuaPDR2hGp9db6iiBu//lKsx+3hWsWuzl?=
 =?us-ascii?q?pHoTRJnsPRun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk5vKn6/7mYrX7vZ+QLY50igfwMqQpgcywH/g3Ph?=
 =?us-ascii?q?ISX2mb5eu81Lrj8Vf/QLpWlf05jrPVsJXbJcQfvqK5AglV3Zg/6xunEjur39?=
 =?us-ascii?q?sVkWMHIV5YYh6LkYfkN0/ULPzlFfu/hk6jkDZvx/DIJL3hBZDNI2DYkLj8Zr?=
 =?us-ascii?q?Zw8FJcyQovwtBf4JJYELcBIOnpVUPru9zYCQE5PxSuw+n7ENV9yp8eWWWXD6?=
 =?us-ascii?q?CFKqzSqkGH5+I0LumXeIAVuCzyK+Ur5/7qk3A5g0YRcrWz0pcNdH+4GfFmKV?=
 =?us-ascii?q?2DYXXwmtcBDXsKvg0mQeP2klKCSiBcZnaoU6In+j47CJipDZrNRoCpnrOBxj?=
 =?us-ascii?q?y2HpxQZmBaFF+MFW3keJmDW/cJcCiSONNukiQYVbi9TI8szROutAr9y7p9NO?=
 =?us-ascii?q?rU+zYYuInl1Ndv4u3cixAy+SZzD8SH3GGHV3t0kX8QRz8qwKB/plRwylOC0a?=
 =?us-ascii?q?h+nvxZGsVf5+hXXQgmKJ7c1e16C8zyWw7Ye9eJT0upQsiiAT4vVd8x3dAObF?=
 =?us-ascii?q?hnG9m4jRDMwTCqA7kLmLyPHpA09bjc33fpLcZn13nGzLUhj0UhQsZXLm2pmK?=
 =?us-ascii?q?p/9wnVB47UnESUjLiqdasC0y7X7muDznSBvFteUAFuVaXJR3cfZlHZrd7h/E?=
 =?us-ascii?q?PNU6euCag7MgtG0cOCKbVFZcPyjVpaQ/fjP9febnmtlGewHxaIwbaMbIv3e2?=
 =?us-ascii?q?UYxindD1IEkw8L93acKQc+Hjuho37ZDDF2F1LvZEPs8e9kpHO5SU80zxuFb0?=
 =?us-ascii?q?t617Wr/B4YnuCTROkV3rIDvichqil7E0y5397MF9WAoA9hdr1GYdwh+FdHyX?=
 =?us-ascii?q?7ZtwtlM5y4Ma9igFEecxl2v0Pozhl3CZtPkdIsrHw0yAp/MqOY3EpFdzOfw5?=
 =?us-ascii?q?D/JKfbKnLo8xCsdq7WwEvR3MyQ+qgR8vg4qU3jthmzFkU+63Vnz8VV03yE65?=
 =?us-ascii?q?XSFgUSTJbxX10v9xdgurHaZjAx54bT1X1rK6m7rCXO1M4uBOsgmV6ceIJ0Ob?=
 =?us-ascii?q?iJBUfJGM0TGsaqJfZiz1OgdR8VFPtZ9KcpMcerbb6N0eigO+M22HqthH9K8c?=
 =?us-ascii?q?Zm2UKF6iR4R/Tg3pAZzvXe1QyCE3/+iVC7qMHssYZNYDwTWG2lxmysAI9Xe7?=
 =?us-ascii?q?03ZosAFH2vP9zyw9Jymprgc2BX+UTlBF4c3sKtPx2IYBi1xgBU1EIKsVS5li?=
 =?us-ascii?q?aiiT95iTckquyYxiOd7f7lcU88JmNTRGRkxWzpKIywgsFSCFOkdCA1hRCl4g?=
 =?us-ascii?q?D83KEdq6NheTqACXxUdjT7ejkxGpC7saCPNosWtcIl?=
X-IPAS-Result: =?us-ascii?q?A2B1AgCpcTle/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBewKBe4FsIRKEPokDhmUGgTeJb49PgXoJAQEBAQEBAQEBNwEBhEACgls6B?=
 =?us-ascii?q?A0CEAEBAQQBAQEBAQUDAQFshUOCOykBgwEBAQEBAgEjFUEFCwsYAgImAgJXB?=
 =?us-ascii?q?gEMCAEBgmM/glcFIKtrdYEyhUqDQ4E+gQ4qAYw7eYEHgTgPgl0+h1uCXgSXO?=
 =?us-ascii?q?UaXZIJFgk6TbwYbmwiOYZ0uDhGBWCsIAhgIIQ+DKE8YDY4pF45BIwOPPQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Feb 2020 13:36:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 014DZNDv113713;
        Tue, 4 Feb 2020 08:35:25 -0500
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
 <cdb0ba7f-2863-d721-7ec2-1e01464e2b41@tycho.nsa.gov>
 <7ac0fa7d-225a-a554-bc1f-78d4d07b8adc@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9a07bf65-c0a8-6295-a3a5-ac1817385891@tycho.nsa.gov>
Date:   Tue, 4 Feb 2020 08:37:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7ac0fa7d-225a-a554-bc1f-78d4d07b8adc@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/20 4:39 PM, Casey Schaufler wrote:
> On 2/3/2020 11:37 AM, Stephen Smalley wrote:
>> BTW, I think the above guarantees with the exception of no trailing whitespace and whether the NUL byte is included or excluded from length are in reality also required for "current" (and SO_PEERSEC) or existing userspace will break.
> 
> The behavior of interfaces (e.g. "current", "exec") that are module defined
> is only of concern with respect to to "display" behavior. If a security module
> wants to provide a variable size binary blob in "current" I would object on
> principle, but policy as I understand it has long been that if the authors want
> to do that, it's their call.

Doing so would break existing userspace (not just LSM-specific 
userspace), so I think it would be a deal breaker even for new security 
modules to move away from those guarantees for "current" at least. 
procps-ng (and I think procps before it) directly reads 
/proc/pid/attr/current and truncates at the first unprintable character. 
  systemd's sd-bus reads /proc/pid/attr/current directly and treats \n, 
\r, or \0 byte as terminators and truncated on first occurrence.  A 
variety of userspace code uses the value obtained from 
/proc/pid/attr/current and/or SO_PEERSEC as something that it can pass 
to printf-like functions using a %s specifier for inclusion in logs and 
audit messages.

> The "context" has a defined format, and it would
> be up to the authors to come up with a printable ASCII representation of the
> binary blob. If they care. They're not required to provide a "context".


