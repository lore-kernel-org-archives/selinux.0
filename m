Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC715C352A3
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 13:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E446208C4
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 13:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Q3c2Wms5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgBJNYj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:24:39 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:59027 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbgBJNYi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 08:24:38 -0500
X-EEMSG-check-017: 54808643|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="54808643"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Feb 2020 13:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581341076; x=1612877076;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bd9eybyEGeDG5x2g0hqTg32+GAmHGXOrcK0wyv0eP74=;
  b=Q3c2Wms5sWeEnWAGHDdJq5XARav52sAZfjRoijoe61Qu+CTxHCk8mEpM
   h/BucltKxdlOgmf1yamxfLMQjt8HFPwvx8hcK2gBtw4PDNxqT+nWB1pma
   LuglpT4RksmcOz8+1BeIucic9j3EElJsQfxgfzmAs+6IFe8Pqxhk3mZ1L
   1wjuDSvJN9QEOCh6zLmsVZQbCl8cwlItlXoTCS/AOpEg0sbziqPr8PwfN
   dQq67HALQEw/OWLUIyXgyITxTJL7ARQ0hiIkMMRMAdEBMr4UkrPgoVQek
   9lEmHXLItuJJ8NUsuFgeQPADzF8FzTgaJ9WsHYSTxO2kgOlMVoGdVPoqg
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="32862742"
IronPort-PHdr: =?us-ascii?q?9a23=3AbxKEmRwD24iKRZjXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u4SK/ad9pjvdHbS+e9qxAeQG9mCt7Qa0qGK4uigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4pvJrs+xh?=
 =?us-ascii?q?bGpnZDZuBayX91KV6JkBvw+8m98IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sOvXnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwHIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/gWuaJOTp0mX1odb2lixuy7ESs0PPwW8aq3F?=
 =?us-ascii?q?pQsyZIlMTHuGoX2BzJ8MeHT+Nw/kKm2TmSyQ/e8vpEIUUolarDLJ4h36Iwmo?=
 =?us-ascii?q?ITsUvdGi/2n137jLOMeUU+++io9v/nbq/npp+aOY90jRr+PboylcClHeQ5Mh?=
 =?us-ascii?q?QBX2ic+eim0r3s4Vb5T6lQgv0zk6nZtIjWJcUdpqGnHw9Yypsv5hmwAju80N?=
 =?us-ascii?q?kUgGMLIExKdR6ZlYTlJknCIPXiAve+h1Ssni1rx/fDPrD5GZXCM2PDnaz9fb?=
 =?us-ascii?q?d990FcyA0zwcpZ55JPEL4NOv3zWkjvtNDAFB82LxS0w/r7CNV6zo4eQmePDb?=
 =?us-ascii?q?OHMK7JrVCI4eYvI+2Wa4AOvzb9MeIq6+Tygn8+nF8XZbOp0ocPaHCkAvRmJF?=
 =?us-ascii?q?2Ubmb2jdcaD2gLvhEzTPf2h12CSzFTeniyX6Yi6TEhEY6pEZ3MSpqxj7yG2S?=
 =?us-ascii?q?exBodWaXxeClCQDXfocJ2JVOsWZyKJPMBgkiYIVaO9RI8hzx6uqQH6y755Ie?=
 =?us-ascii?q?rO4SAYtJTj1MRr6O3Xjx096Tt0D8GF2WGXU250hn8IRyMx3K1no0x9z1CD0b?=
 =?us-ascii?q?Jig/xZDtxe/PVJXR0/NZHCzux2EdfyWhjOft2RUlapXs2mAS0tTtI229IOZ0?=
 =?us-ascii?q?d9G9O/jhHMxiaqGKEamKCWBJwu86Lcw3jwK994y3bByaYhkl0mTdVUOG24ia?=
 =?us-ascii?q?5w6RLTC5TKk0qHjaaqc7oT3CrX+GeE12qOs1lSUBRsXqXdQXAfekzWoMzi5k?=
 =?us-ascii?q?zcS7+uCLInMhZOyMOZNKtKZcPmjU9cSPfgJtveeWSxlHm0BRqSwbOMdoXqcX?=
 =?us-ascii?q?0H3CrBEEgEjxwT/XGeOAg9GCiuvXneAyBpFVLoYEPh6vVxqHOhTk8zygGKbl?=
 =?us-ascii?q?Bh17+v9h4Sn/ycROsZ3qgYtyc5tzV0AFG90srUC9qHpwpher9QYdE64FdHz2?=
 =?us-ascii?q?3ZsRd9MYKmL615mlERaQJ3v0To1xV2FopPi8wqoGk2wwp1LKKSyElBeC+A3Z?=
 =?us-ascii?q?DsJr3XLXH//AixZK7Q1VHezdeW+qEW5PQ7tVrjpgepGVQm83h80tlZyn+c5p?=
 =?us-ascii?q?LUDAUMS57xSVw49xtnp7HAeCYx/YXU2mN2Pam2qj/Iw8gpC/c9yha8Y9dfN7?=
 =?us-ascii?q?uJFBfoHM0HA8ijM/QqlEK0bhIAJexS8ak0P8S8d/SYwqKkIOFgnDf1xVhAtb?=
 =?us-ascii?q?t810WKvw93dO/Uw5cIi6WD2wCZfzz7iFOouMftkMZPYjRETUSlzi2xP5Jcfq?=
 =?us-ascii?q?1/e84wDG6qJ8CmjoFli4XFR29T9FnlAUgPnsCuZ0zBPBTGwQRM2BFP8jScki?=
 =?us-ascii?q?yiwmkxymx4ow=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2D6AgB+WEFe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBKEP4kDhmMBAQEGgRIliXCRSwkBAQEBAQEBAQE3AQGEQAKCaTgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYMBAQEBAQIBIwQRQQULCxgCAiYCAlcGDQgBA?=
 =?us-ascii?q?YJjP4JXBSClfHV/M4VKgySBPoEOKow9eYEHgTgMA4Fffj6HW4JeBJdCRpdqg?=
 =?us-ascii?q?kSCTpN4BhubD6waIoFYKwgCGAghD4MoTxgNjiYajkEjA48YAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Feb 2020 13:24:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01ADNPcg225355;
        Mon, 10 Feb 2020 08:23:29 -0500
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Simon McVittie <smcv@collabora.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
 <20200210115611.GA13930@horizon>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <94aaf6c8-cc69-5804-2d45-3b8c96689331@tycho.nsa.gov>
Date:   Mon, 10 Feb 2020 08:25:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210115611.GA13930@horizon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/10/20 6:56 AM, Simon McVittie wrote:
> On Mon, 03 Feb 2020 at 13:54:45 -0500, Stephen Smalley wrote:
>> The printable ASCII bit is based on what the dbus maintainer requested in
>> previous discussions.
> 
> I thought in previous discussions, we had come to the conclusion that
> I can't assume it's 7-bit ASCII. (If I *can* assume that for this new
> API, that's even better.)
> 
> To be clear, when I say ASCII I mean a sequence of bytes != '\0' with
> their high bit unset (x & 0x7f == x) and the obvious mapping to/from
> Unicode (bytes '\1' to '\x7f' represent codepoints U+0001 to U+007F). Is
> that the same thing you mean?

I mean the subset of 7-bit ASCII that satisfies isprint() using the "C" 
locale.  That is already true for SELinux with the existing interfaces. 
I can't necessarily speak for the others.

> I thought the conclusion we had come to in previous conversations was
> that the LSM context is what GLib calls a "bytestring", the same as
> filenames and environment variables - an opaque sequence of bytes != '\0',
> with no further guarantees, and no specified encoding or mapping to/from
> Unicode (most likely some superset of ASCII like UTF-8 or Latin-1,
> but nobody knows which one, and they could equally well be some binary
> encoding with no Unicode meaning, as long as it avoids '\0').
> 
> If I can safely assume that a new kernel <-> user-space API is constrained
> to UTF-8 or a UTF-8 subset like ASCII, then I can provide more friendly
> APIs for user-space features built over it. If that isn't possible, the
> next best thing is a "bytestring" like filenames, environment variables,
> and most kernel <-> user-space strings in general.
> 
>      smcv
> 

