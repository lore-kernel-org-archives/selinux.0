Return-Path: <SRS0=bkjU=SM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFEEC10F11
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 15:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F80A20818
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 15:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o4fYR4Xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbfDJPhE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:37:04 -0400
Received: from sonic309-26.consmr.mail.gq1.yahoo.com ([98.137.65.152]:46187
        "EHLO sonic309-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729962AbfDJPhE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Apr 2019 11:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554910622; bh=+ebv6oar1iQNiaxjtqy6T7qdfAsksmWwEXHg4wKoxzk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=o4fYR4Xojiml++kdiKhx4mciUqyahca1vICrb+XM/G9R6Ynb+ytrXzd2Dp/BIVYZ0UpLe4yE3KUQHTPJajXxowPtCrCAin9VsLhhu5sU+KtEftaYlP5FjaVRV0LqadenwoJxB4Eua06ZfhyikT7H3QazW6eyMSJzzRaMjqrUE5rbBc0E2DN75ZNb/IhHXiPNHDP2XZmE6et/McF6MVfwP2jeEmRxPjItKDZlQPJtY4x0vm12j/crKqvmQveJGpuncW8TuxxsMIJAXssfgPPwBRGK6i2RNueeFNtU20RrsSKuWKd79GYcAgjFUacgfJIF9BcRmk1b5bi7F5FlZbO/MA==
X-YMail-OSG: gRLzPvIVM1kU34ZJqVi7.MU4AyvmkODLKljgMWp7035QxjPMSqSoXvdvC3TT8Th
 O4D6GP1Ue3pH3BqNxY5fk9Ome2RDJWlKyrAYL58P.Uw7KOJVKUFPFIBMoLmHDfXnKOgMBM_5poSG
 qrJTZA6GF13NnxcqR0DJjy_jy0DC_y8RDxas0dl8bAkOUL3_wAVaMwoOuD_pG5fWPubxBhb3.lVX
 5YJOm5L818DN4uxKtUd2qTUSK7kHEuluU3Hctmk0zYVNwg.iDnwEkUGVw3olDXNKYrgNF7yY7HA4
 7n5DrhQE5bO5bhwPyCay2mA7d0KjP3Xm97HH.Nkh2PzXYZYpDJJommL1yp7O5bHceqcFCVU2kbWM
 FPRwpkYW9z.pNRGVoo9CXUdKoQK8U.LtK9Kf74v6M6k4.PU0quI1XTuCyYHTH2xAMycxc5dMnQSb
 elpzjcJbwtJRW7fsKeu757RZwuU3TCSlSIj93amMMukbbexpemZwXN_4EilZqOw5mIH_HtqhOtEZ
 zQVvx.PWnBlrTu1OyPDRjrlIMqsLZY0vnuZ.rt3R223Z2z3l7nxNVXUamNrgv9wRzOxeNvDo70C4
 OzKSFlwCY_bqpsnsRWM6ss9LffYo.uQ6IkJfXEsL6pYYcBMS2OmP_P37IEkv14zrCRbbhNqMahA7
 rTnzjkFfvENlOd9xCxcY5bDYttvAFUp28UxqbQpeC5wsDaXKraj4LEFOXkbXyzSxIuZQOQVrS59D
 RTBpv5vp4TgbIJMb1vzYTfIYXuveiJcuT83.ssksck7i0P3zBM4_s8zfwxk26VhB46U4ME0RCK0R
 B3oA.1wXh5szagzgtktq42mzZi1RZXbDfnaZ8tg00UnkXbojOqHbbkISK7ibf8Y6KYuhxYnEzfwW
 S8pypTGwrW_T7r750MB1wxyktgM32bMUV8J7zIXpXirRm4DDOS.QwnksRgHGImRGnB8tFcoPvoQi
 BRjaR4T5eP.b5RYa5zLK0NzyCp9xDk7SnzSnXFJuFk25QMWY30D0iVLP_66qwqnGI4ij9.PFGtfk
 KKBDMh.Q.kKr9nPbXB7Jz8a5SQrQcS_wttcEFFEfEgvBpzI8oJ_KV1grcgfSKCBLX.IbJCMZxbr7
 NhxKzsL3YQHJ1lk3vCRW1ngWKvUnMAEOEqp90_Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Wed, 10 Apr 2019 15:37:02 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 271823ae4a7e70840a3642f9879cb291;
          Wed, 10 Apr 2019 15:36:58 +0000 (UTC)
Subject: Re: [PATCH 00/59] LSM: Module stacking for AppArmor
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        casey@schaufler-ca.com
References: <20190409213946.1667-1-casey@schaufler-ca.com>
 <CAB9W1A2yUNcdsJbXC_n8xhmnQBcZvHkFzHtk1jBeTS1+cv_VVw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <77e3cbb6-cf3f-6ea7-ef35-55f9cb18437b@schaufler-ca.com>
Date:   Wed, 10 Apr 2019 08:36:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAB9W1A2yUNcdsJbXC_n8xhmnQBcZvHkFzHtk1jBeTS1+cv_VVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/10/2019 5:52 AM, Stephen Smalley wrote:
> On Tue, Apr 9, 2019 at 5:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> This patchset provides the changes required for
>> the AppArmor security module to stack safely with
>> "exclusive" security modules, those being SELinux and
>> Smack.
> What's the use case?  Who would use such support?


A device uses a Smack three domain policy for system
protection. It Uses AppArmor policy to maintain application
isolation.
   
	-------------------------------------------------------------------
	| Smack floor domain                                              |
	-------------------------------------------------------------------
	| Smack System domain                                             |
	-------------------------------------------------------------------
	| Smack User domain                                               |
	| ----------  ----------  ---------  ----------  ----------       |
	| |AppArmor|  |AppArmor|  |AppArmor| |AppArmor|  |AppArmor|       |
	| | Fred   |  | Wilma  |  |Barney  | | Betty  |  | Dino   |       |
	| ----------  ----------  ---------- ----------  ----------       |
	-------------------------------------------------------------------

Each of the security modules is used in the way it was designed. Neither
has to be stretched beyond its original goals. Yes, you can implement the
system using either Smack or AppArmor (or maybe even SELinux) but by using
each for what it is best at you make it much easier.
  

