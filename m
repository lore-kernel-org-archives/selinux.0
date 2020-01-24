Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36FDC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 15:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E0D20709
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 15:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="SlLeoFVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAXPLQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:11:16 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:2486 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAXPLP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 10:11:15 -0500
X-EEMSG-check-017: 48253838|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="48253838"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 15:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579878674; x=1611414674;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=cjPGe0wzjMvDQQTrov04uETnp8SaAhl1HQ570JHetp8=;
  b=SlLeoFVARgLabg6aBhNM35ArmNmE0bFmvET7Vd9PNM7aMydKr7RIVd8j
   uAm+3o0z4RcGtsDTDM6ycoxsg70elg+ORAmanlJFjxXgx6o0z5QDjrtJV
   oqYF5ZoZZLaCDiBOEpAlHhJmqpwWxA3pmnGaMRSCE3iL099X6KtcdUg3M
   N2WPzuzeV1olzbYLYNAtW4zugjzgXN9LLCT/FLaU+5el7827p8WMFGKeu
   IrBrad26rkTX5MagTK/BFiyXr2j3bcB/QTtGOqfACO1+alNnd8OvxHLHK
   AvLFoHQ/eLMXdewSLXzI4gxF0T4+I9QXJVskFQqeKU6R8OIVeCl6w0bGt
   A==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="38208602"
IronPort-PHdr: =?us-ascii?q?9a23=3ADnapEh3V1W0JeKQGsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMRKfad9pjvdHbS+e9qxAeQG9mCt7Qe16GJ6uigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam5VuJ6k+xh?=
 =?us-ascii?q?bLv3dDZuBayX91KV6JkBvw+8m98IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sAvXnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwHIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/gWuaJOTp0mX1odb2lixuy7ESs0PPwW8aq3F?=
 =?us-ascii?q?pQsyZIlMTHuGoX2BzJ8MeHT+Nw/kKm2TmSyQ/e8vpEIUUolarDLJ4h36Iwmo?=
 =?us-ascii?q?ITsUvdGi/2n137jLOMeUU+++io9v/nbq/npp+aOY90jRr+PboylcClHeQ5Mh?=
 =?us-ascii?q?QBX2ic+eim0r3s4Vb5T6lQgv0zk6nZtIjWJcUdpqGnHw9Yypsv5hmwAju80N?=
 =?us-ascii?q?kUgGMLIExKdR6ZlYTlJknCIPXiAve+h1Ssni1rx/fDPrD5GZXCM2PDnaz9fb?=
 =?us-ascii?q?d990FcyA0zwcpZ55JPEL4NOv3zWkjvtNDAFB82LxS0w/r7CNV6zo4eQ2OPDb?=
 =?us-ascii?q?OZMKzIq1+H+/ogLPWUa48Vojn9Kv4l6OD1jXIiglAdYaip3Z0LaH+mBPRmJV?=
 =?us-ascii?q?uWYWb2jtgdFmcKuxI0TPb2h12aTT5Te3GyUron5j4lDIKmDIHDRp2igbGawi?=
 =?us-ascii?q?e7EYNZZnpcBlCPD3jobYOEVOkIaC6IJc9hiDMEBvCdTNob1BquvRX2g5puL+?=
 =?us-ascii?q?zZ4WVMr5Po1NFv69rYohE79Dp5FOyXz2CLU2xumG4UATQx2fY76VdwzlaFzL?=
 =?us-ascii?q?hQnfNVD5pQ6ulPXwN8MoTTnMJgDNWnYR7MZteETh6dR9yiBTwgBoYqz8Qmf1?=
 =?us-ascii?q?d2G9LkiAvKmSWtHelGxPSwGJUo//eEjDDKLMFnxiODjfJwgg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CCAwBBCCte/wHyM5BlHQEBAQkBEQUFAYF7gX2BGFUgE?=
 =?us-ascii?q?iqEEokDhnoGgTeJb4VZi3AJAQEBAQEBAQEBIxQBAYRAAoJGOBMCEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshTcMgjspAYJ6AQUjFVELGAICJgICVwYBDAYCAQGCYz8BgkoDC?=
 =?us-ascii?q?SWsdIEyhUqDNIE+gQ4qjDF5gQeBOA+CXT6CG4U+gl4EjVgEiVhGl16CQ4JMh?=
 =?us-ascii?q?HaObwYbgjgQeJc8jmCBSptUIoFYKwgCGAghD4MnCUcYDZE8hSkjAzCNVgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 Jan 2020 15:11:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OFAUuA260783;
        Fri, 24 Jan 2020 10:10:30 -0500
Subject: Re: [PATCH 1/2] selinux-testsuite: Prepare for adding fs*(2) API
 tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200120111113.23349-1-richard_c_haines@btinternet.com>
 <20200120111113.23349-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fa1d08e2-5cfe-7b62-885b-8df55ec2ce17@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 10:12:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120111113.23349-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/20/20 6:11 AM, Richard Haines wrote:
> Update the current tests/filesystem to share code and perl subroutines.
> Also update tools/check-syntax to handle *.pm files.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   policy/test_filesystem.te      |  18 ++-
>   tests/filesystem/Filesystem.pm | 166 +++++++++++++++++++++++++
>   tests/filesystem/test          | 219 ++++++---------------------------
>   tools/check-syntax             |   2 +-
>   4 files changed, 222 insertions(+), 183 deletions(-)
>   create mode 100644 tests/filesystem/Filesystem.pm

[...]
