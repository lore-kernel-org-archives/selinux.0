Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57931C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6632071A
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 15:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="d/IqQyBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbgAXPFR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:05:17 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:61379 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbgAXPFR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 10:05:17 -0500
X-EEMSG-check-017: 73058332|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="73058332"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 15:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579878292; x=1611414292;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pjHC8dlzRVErH0cT3AvJfmCKGq+CN6PGM/fnAHUajqE=;
  b=d/IqQyBAbBBeM6WrY93nPMAYuwy40dj3rjAC2qdhz/vDwl3xdh6BKEXO
   0NEeQwCO903ZfXUXoSNtzD6/INUTVzxvpm3HBMeXco/PZmsw2VKzKuprj
   /YmV22K+2Q7k3UxT45rGq4z56L2ong8M1xPIKZfE0EpJUxWt4MAIiqEYs
   60cYHKkpzFbiDhuPN3lMl+J5wgagsE+xYuj3/sLf4PccufoyKa38wT8I3
   c0h2scFYKvMlmPO8QH/wons/IF6iWrGEw1Za2dR4kdU0pFDSfAAPzdqvE
   Daqnz9TgY3KUyoLJAvZR26PlQ1vXipaG/ndtCInZ0GtTEZRip8crEdTsz
   g==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="38208007"
IronPort-PHdr: =?us-ascii?q?9a23=3AUTJDHhKF4wzF63uPvNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXL/z/rarrMEGX3/hxlliBBdydt6sYzbCK+P6wESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4NKo8xR?=
 =?us-ascii?q?TFr3pLdu9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTn?=
 =?us-ascii?q?RdUMlPSyNBA5u8b4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlGiX/s2a0xzv?=
 =?us-ascii?q?ovHwfI0gc9G94CqXTZodHwOKoUTOu7zrTHzS/bYv1Lxzn95ojGfBMvr/6CUr?=
 =?us-ascii?q?1/c9bex0Y0GgPZjFids5DpMy+b2+kPtWWQ8upuVfioi24iswx/vySvydk0io?=
 =?us-ascii?q?nJmI0VzE3P+zh8wIkvId24TFB0YN65G5ZXrCGVKpB2T9g+Q2BopCk6yroGtY?=
 =?us-ascii?q?S9fCgR0psr3RHfa/uZc4WR5B/oSeWfIS9giX54d7+yiAy+/Ei9xuHmSMW530?=
 =?us-ascii?q?hGojBYntTKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWal8r+vKp6+T6ebXqvJ6cN4l6igH5KaQhhNCwDf4kMg?=
 =?us-ascii?q?kOQ2eb+eO82Kfl/ULlW7VFkuc6kqzYsJDePcgbp6i5DBFJ0os79hqyADir3M?=
 =?us-ascii?q?4YkHUaNl5JZh2Kg5bzN13TOPz4CO2wg1WokDdl3fDGObjhD43WLnfei7fsZq?=
 =?us-ascii?q?p96k5AxwozytBT/ZRUCqobL/7pVU/xs8LYAgcjMwOo2+bnFMl91oQGVG2TGK?=
 =?us-ascii?q?CZK73dsF+T6+I0P+aMZJUauCvzK/gh+fHul2Y1lkMHcqWzwZQXb3W4FOx8I0?=
 =?us-ascii?q?qFeXrsnssBEWASswUiVuPqk0ONUD5Ja3apQ6085is0CJ+oDYfHWI+tmqeM3C?=
 =?us-ascii?q?a9Hp1KeG9GDkqAHmvvd4WBQ/0Mcj6dItd9kjwYUrisU40h1RSptA/g0bpnL/?=
 =?us-ascii?q?HU9zYetZ350dh6+ezTmQs19TxuAMSXy3uNQH1snmMUWz8227hyoUh8yleFzK?=
 =?us-ascii?q?h5jOVUFcdN6PxVTwc6L5/cz/B6CtzrXwLBecqGSEuiQtq4GjwxUN0xzMEUY0?=
 =?us-ascii?q?pnGNWtkArD3yy0DL8RjbCLA4Y08q3E1XjrO8l902rG1LUmj1Q+WctAK2mmhq?=
 =?us-ascii?q?959wjOCI/EiFuZl6m0eqQGxiLN93mMzXCIvE5GVA58S6LFXWoQZkHOt9T2+l?=
 =?us-ascii?q?vCT6OyCbQgKgZBytCNJbVRatL1ilVGQ/TjNc/CbGKxgWewAhOIxrKRbIrvYW?=
 =?us-ascii?q?kd2z/dCEccmQAJ4XmGLRQ+Bjumo2/GDjxuElLvY0X2/el8r3O7TlU7zweRb0?=
 =?us-ascii?q?J/0bq44QIaiuaaS/MU2LIEuTsupC9wHFqnw93WDN+ArRJ7fKpAedM9/EtH1W?=
 =?us-ascii?q?XBugxlIJOgKa9ihkMfcwRxpk/u1At4Cp9Gkcc0qHMn1wtyJbuc0FNGaTOXw4?=
 =?us-ascii?q?r8OqbNJWnx4RCvcbTZ1kvY0NmI4KsP6uw4oU35vA61Dkoi72ln095N3nuE/J?=
 =?us-ascii?q?rKEQ4SXInpUkkt6hh6o6jWYiw654PTz31jL7O4vSPF29IsV6MZzUOLdsxSIe?=
 =?us-ascii?q?u/Hw/7DsMeCtLmfOcjgFW4RgkPPOlP+qo5JYatfr2N36v9eK5rlSmrnCJc64?=
 =?us-ascii?q?B0z0yI+jBUS+jU0pJDyPadmkOFUjDmlla6msb+nI1FIzYIES73zSniGZ4Ufa?=
 =?us-ascii?q?B5YJwKFXbrJsq729Fzr4DiVmQe91O5AV4Cnsizdl7adFH53AtNxWwJrnG93y?=
 =?us-ascii?q?i11Tp5l3cutKXM8jbJxrHZaBcfOmNNDFJnhFPoLJn828sWR2C0fgMpk12j/k?=
 =?us-ascii?q?+8yK9F8vcsZ1LPSFtFKnClZ1ppVbG94//bPp9C?=
X-IPAS-Result: =?us-ascii?q?A2BwAgA5Bite/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBKEPIkDhnoGgRIliW+PYoFnCQEBAQEBAQEBATcBAYRAAoJGOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgnoBBSMVQRALGAICJgICVwYBDAgBAYJjP4JXJ?=
 =?us-ascii?q?axqgTKFSoM6gT6BDiqMMXmBB4E4DAOCXT6EMYMogl4ElzRGl16CQ4JMk2UGG?=
 =?us-ascii?q?4I4mESOYJ0eIoFYKwgCGAghD4MoTxgNlmUjA44GAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 Jan 2020 15:04:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OF450c257797;
        Fri, 24 Jan 2020 10:04:06 -0500
Subject: Re: [PATCH v14 00/23] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey.ref@schaufler-ca.com>
 <20200124002306.3552-1-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d1713ac1-6e87-b24a-6255-4b0dcc3ffa69@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 10:05:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/23/20 7:22 PM, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.
> 
> v14: Rebase to 5.5-rc5
>       Incorporate feedback from v13
>       - Use an array of audit rules (patch 0002)
>       - Significant change, removed Acks (patch 0002)
>       - Remove unneeded include (patch 0013)
>       - Use context.len correctly (patch 0015)
>       - Reorder code to be more sensible (patch 0016)
>       - Drop SO_PEERCONTEXT as it's not needed yet (patch 0023)

Looks like you also dropped "LSM: Use lsmcontext in 
security_dentry_init_security" entirely (was patch 16 in v13).

