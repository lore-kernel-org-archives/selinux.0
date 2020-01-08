Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0327C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 15:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A142220678
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 15:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HNYYxQ4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgAHPFt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:05:49 -0500
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:14161 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHPFt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 10:05:49 -0500
X-EEMSG-check-017: 69824333|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="69824333"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2020 15:05:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578495941; x=1610031941;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WgyvnqCmZH/jAUO4QdNLOjA93B+TqrQPqTeY1KuFgmg=;
  b=HNYYxQ4u17Qy26LCy9OgsF0dh8ToE9VkF4gV2cT2UV2j2OukEl585Z3v
   KjY9iWKvZgFS6S7XTkuLO49bsKF2UA5G3rQOmN725pL3sVIO/NOZSiRwv
   BEDTJNO5+ZikBpbQjgQN6QB++ymDtDDURpXBRkJsRi91tS4jUAVDOo+N1
   BckKx7cx8St2B/klY/J+oR0SER55swGaG0FSdvVfyRQ5X1d5Dj9rG4aWg
   BKu0XH+75+/sAVbWyFTpmZkHV/MsD1SnbLI8Aq0NH2L1oVs9A8LkMEwGi
   Jy+gqBle0oPHTuTA3I2YzOTIgx+RqNeD8agYJPpCSYICo/ebBRe583+QL
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="37488529"
IronPort-PHdr: =?us-ascii?q?9a23=3A+5Zy6RFqkCdMdIHSzqtoxp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yr8mwAkXT6L1XgUPTWs2DsrQY0rGQ6f2wEjNYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswnctsobjYRgJ6ot1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzi/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTWJwuCsi17ELtp?=
 =?us-ascii?q?G2cDIKxZg63RLTdfOKf5aS7h7+UuuaPC12i2h/eL2lgha/6U2gyurhWcaqyF?=
 =?us-ascii?q?tKtS9FksXUtnAKyhzT9tCLSvtj8Uel3jaCzxzT5fteIUA1iKrbMIQtwr82lp?=
 =?us-ascii?q?odtkTDBTH5l1nsgK+KdkQr5uio6+P9brXgupCcLJN7hhv7MqQvnsyzGeU4Mg?=
 =?us-ascii?q?4QUGiH4emwybLu8ELjTLhKk/E6iLfVvZ/EKcgBu6K1GwpV3Zwi6xa7ATemyt?=
 =?us-ascii?q?MYnXwfIVJeZR2HlJPkO03OIf/kDfe/hE6gkDFwx//cJLHhDZLNLmbbnLf7Yb?=
 =?us-ascii?q?l981JcyBY0zd1H4JJUD7YBIOn1WkDrqNPXEAQ0MxaqzOn6CNVyzJ8eVXiTDa?=
 =?us-ascii?q?+eNaPYqUWI6f43I+mQeI8Vvy7wJOQq5//vin85n0ESfbKy0JsYb3C4GftmI0?=
 =?us-ascii?q?GHbnrpmNgBEGMKshAiQ+ztjV2ISSRTaGqqX6Ig+jE7D5qrDZzdSYCpgbyB2j?=
 =?us-ascii?q?q7H5JNa2BYBVCDD23oe5+HW/gSciKSJNFukjgeWbimUY8h2kLmiAiv7LxrNO?=
 =?us-ascii?q?fWsggfrpTq39V2r7nUkBYp8zV/AuyH3m2NRn0ylWQNEXt+96BloFdhy16F5o?=
 =?us-ascii?q?fmn+BDHtxer6dCXRU9M5PH5+N9DN/2VwfIf9PPQ1GjFIaIGzY0G+ktzscObk?=
 =?us-ascii?q?A1INCrihTOzmL+GLMOv6CaD5wztKTH1j7+INgrmCWO77Uok1RzGpgHDmahnK?=
 =?us-ascii?q?MqslGIVoM=3D?=
X-IPAS-Result: =?us-ascii?q?A2C3AgDP7hVe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXyBf?=
 =?us-ascii?q?YFtIBIqhAmJA4ZnAQEBAQEBBoE3iW6PYYFnCQEBAQEBAQEBATcBAYRAAoIOO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMECwEFQRALDgoCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/gkcDCSWrdn8zhU+CSg1jgT2BDiiMM3mBB4ERJw+CXT6CG4IWg?=
 =?us-ascii?q?yiCXgSNLYo3l0OCQIJFk1cGG5pijlWceSKBWCsIAhgIIQ+DJ1AYDY0eF45BI?=
 =?us-ascii?q?wMwkHsBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 08 Jan 2020 15:05:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 008F56w3260460;
        Wed, 8 Jan 2020 10:05:06 -0500
Subject: Re: incorrect sysfs contexts
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
 <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov>
 <CAJ2a_DcEnxg4w92ayqg7y76_5AvkGnzFBU32FpV_qzcxuUN_Pg@mail.gmail.com>
 <CAFqZXNsOJMS_pi80O1+-57dBgwGJ0oHS=v2b1X9SR2rU1u0=dg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ddfa2b0d-3b7c-b1cd-4af9-581913fc1d94@tycho.nsa.gov>
Date:   Wed, 8 Jan 2020 10:06:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsOJMS_pi80O1+-57dBgwGJ0oHS=v2b1X9SR2rU1u0=dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/8/20 8:41 AM, Ondrej Mosnacek wrote:
> On Thu, Dec 19, 2019 at 3:16 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
>> Default Debian sid kernel:
>> Linux debian-test 5.3.0-3-amd64 #1 SMP Debian 5.3.15-1 (2019-12-07)
>> x86_64 GNU/Linux
>>
>> Somehow symlinks do not inherit their parent label.
>> They all have the root-sysfs label.
>>
>> Remounting sysfs with `mount -o remount -t sysfs /sys` leaves all
>> symlinks with the root-sysfs label.
> 
> Hm... this seems to happen due to the !S_ISLNK(inode->i_mode)
> condition in inode_doinit_with_dentry() introduced in ea6b184f7d521
> ("selinux: use default proc sid on symlinks"). Since the condition was
> apparently only intended for procfs at that time, I think we can
> change the condition to !((sbsec->flags & SE_SBPROC) &&
> S_ISLNK(inode->i_mode)) to fix this for sysfs (et al.). Stephen, do
> you agree? Or could the condition even be removed completely?

IIRC, it was to avoid a compatibility break and we didn't consider it 
useful to support fine-grained labeling of symlinks in proc since the 
only operation is readlink.


