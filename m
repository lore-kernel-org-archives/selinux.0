Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1994C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 16:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE7821775
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 16:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="p06uxb4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBFQK4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:10:56 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:41400 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFQKz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 11:10:55 -0500
X-EEMSG-check-017: 55563002|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55563002"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 16:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581005446; x=1612541446;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+ojRFYKT7YNH4xZ7d/hDlDIr2dUe/e16dlsanCcqxoU=;
  b=p06uxb4xLir6OCkJE2U5jbBnOEGk/P+4OmDAq7GI03kDcA/T6kyuxL9h
   BYTPL09sRoo+et7qdzTIp5lDaqOG/c6NI7egxPkDDtN1ZacdWz/gouEYk
   36+GxQ4kyrDHhvmalkf34ANAUl+iKTKhI36VX5DIQHyW4F6QUEIMK9t9Z
   WvBCK1o3slZHa85rCdw1MUNGmJQwCOGuUusAKXAuznnpd/6XPuwwM+x/I
   bAY+ZXMr8ekzO7XkoXowJ20sor9W3xGgUgB9T8hgVNzXr8Y8xPoDaIjFU
   l/g4QXLmctivrGNc1fSLJclYeUIldL/gEZQ7+TE8m0wXB8+KgpKuVrf2C
   w==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="32766272"
IronPort-PHdr: =?us-ascii?q?9a23=3A1wOI+R1kwVnY6cv/smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKPvxwZ3uMQTl6Ol3ixeRBMOHsq4C1rGd4/moGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZFiJ6s/xR?=
 =?us-ascii?q?fEoWZEcPlSyW90OF6fhRnx6tq+8ZJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
 =?us-ascii?q?Av483ruxjDTQ+R6XYZT24bjBlGDRXb4R/jRpv+vTf0ueR72CmBIM35Vqs0Vi?=
 =?us-ascii?q?i476dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3?=
 =?us-ascii?q?ZPUdhNWCxAGoO8bpUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izDFHhmXy3aYnze?=
 =?us-ascii?q?ovFw/I1xEkE94XvnnZqND5OaEPWu630abI1y3OYe5I1zfz6IbGcR4vrv+DUr?=
 =?us-ascii?q?1ybcXfxlIiFx/Hg1iKtYDpIz2Y2+YLvmOG7+RgT+Wvi2s/pg9svjig2N8sio?=
 =?us-ascii?q?nXiYIT11vK6CB5z5wxJd28VkF6YcOvHZxLty6HLIt7Wd8iQmF0tyY6zb0Ko5?=
 =?us-ascii?q?i7fDMQx5g9yB7fbOKHfpGO7xn+V+iROS91iG9qdb+wnRq/8VWsxvfiWsS7zl?=
 =?us-ascii?q?pGtDdJn9/RvX4XzRPT8NKISv5l80ek3jaAyh7c5/lfIUAxiarbM5khwqMslp?=
 =?us-ascii?q?YLsUTMACv2mELuga+KbEok4Omo6/n8Yrn8p5+cMYF0igblMqswhsOzG/g4Mw?=
 =?us-ascii?q?gSUGib/uSwzrvj8lHiQLpWlPE2l6jZsJTCKcQaoK62HRNV354+5xuwADqqyt?=
 =?us-ascii?q?QVkWQdIF5bdx+LkZLlN0zWLPD9F/i/glCskDlxx/DBO73sGo7NIWXYkLr6Yb?=
 =?us-ascii?q?Z861JTyAo0zdxF4ZJUEasOLOj8Wk/2qtzUFgU5PBCsw+b7FNV90ZsTWXiOAq?=
 =?us-ascii?q?CFMKPdq0WI6f83LOaQfIAVuCzyK/kj5/Hwln80gkQSfbWo3ZsRdHC3AO5mI0?=
 =?us-ascii?q?OHbnrwmNsODWAKvg8mRuzwlFKCSSJTZ2q1X68k/TE0FoamDYbFRoCwj72Mxz?=
 =?us-ascii?q?m7HpJIaWBcEFyMEmnnd5+CW/gSbCKeOMhhkiYLVbK5UY8uyQmutBPmy7pgNu?=
 =?us-ascii?q?fb5y0YtZXt1ddr4+3TkQoy+CduD8uDzm6NT3t7nn8SSzAq26B/pB819lDW66?=
 =?us-ascii?q?lzg/VCGZRz7vJPXxxyYYTdxOxzEdzFUTXBd9aPRU2OSMmnBy08VNQ835kFZE?=
 =?us-ascii?q?MrX525gxTC2Te6K6EamqbNB5Eu9K/YmX/rKJVT0XHDgZI9gkEmT80HDmivgq?=
 =?us-ascii?q?py5kCHHILSu1mInKatM6IH1WjC83nVnjnGh11RTAMlCfaNZnsYfEaD6I2it0?=
 =?us-ascii?q?4=3D?=
X-IPAS-Result: =?us-ascii?q?A2DsAAAiOTxe/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gWwhEiqEFYkDhmMBAQEGgRIliXCRSwkBAQEBAQEBAQE3AQGEQAKCY?=
 =?us-ascii?q?TgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYMCAQUjFUEQCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgmM/gksDCSWsNYEyhUqDVYE+gQ4qjD15gQeBOAwDgl0+ghuFQIJeBJZdY?=
 =?us-ascii?q?UaXZ4JEgk6TcgYbgkiMWItrjmKBS5tpIoFYKwgCGAghD4MnUBgNjikXjkEjA?=
 =?us-ascii?q?zCMByqCGQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2020 16:10:44 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016G9qET122333;
        Thu, 6 Feb 2020 11:09:53 -0500
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Add additional key permission
 tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     dhowells@redhat.com
References: <20200202193508.15056-1-richard_c_haines@btinternet.com>
 <20200202193508.15056-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5a899c4c-dc1c-8019-e9af-cb387eb338c5@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 11:11:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202193508.15056-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/2/20 2:35 PM, Richard Haines wrote:
> Tests the new inval, revoke, join and clear permissions associated
> with the key class that were added in kernel 5.x.
> 
> Note: These tests require a kernel patch (for key perms + policy
> capability "key_perms"), and a libsepol patch.
> 
> Permissions overview:
> The current "setattr" perm name remains and is used for KEY_NEED_SETSEC.
> This gives the following permissions for the 'key' class:
> create	Create a key or keyring.
> view	View attributes.
> read	Read contents.
> write	Update or modify.
> search	Search (keyring) or find (key).
> link	Link a key into the keyring.
> setattr	kernel < 5.x Change permissions on a keyring.
> 	kernel >= 5.x Set owner, group, ACL.
> inval	Invalidate key.
> revoke	Revoke key.
> join	Join keyring as session.
> clear	Clear a keyring.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>   policy/test_keys.te          | 139 ++++++++++++++++++++++++++++-------
>   tests/keys/keyctl.c          |  39 ++++++++++
>   tests/keys/keyring_service.c |  12 ++-
>   tests/keys/request_keys.c    |  70 ++++++++++++++----
>   tests/keys/test              |  63 ++++++++++++++--
>   5 files changed, 273 insertions(+), 50 deletions(-)

I'm going to defer real review of this patch until the kernel patch is 
finalized, but I did want to note that ultimately you are going to need 
to split up the test_keys.te file and only use the new permissions in a 
separate file conditionally enabled based on whether they are defined in 
all_perms.spt; otherwise, test policy build will break on existing systems.


