Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E87C33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 19:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EF3207FF
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 19:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Ft/p4AIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgAFTde (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:33:34 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:38766 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFTdd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 14:33:33 -0500
X-EEMSG-check-017: 63071641|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="63071641"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jan 2020 19:33:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578339210; x=1609875210;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=67eCUxRZt68ZH+LKSpSy6Guy4XdKARnQ4PpmgXjbTq8=;
  b=Ft/p4AIfNHsAgTjx66utwda6gkgb9CGucOU6jCEojbt5nNqEdSiyRWEJ
   PdR0iMkEj0C90dqcBIBCQ9IuFhIwY6NeoKcx+TrUb5La/rEogzCbzBU9t
   stvD+kcf4Ua/BdSZeT5gi1tyAT9Mfl7S/OQu4/NewMy4GeHGw90mBly4+
   z2an4OEto8pzJguUuqc84rkucBgcei9wBmayAwjVUiTidu0AmLAVMY0u4
   8zzarHNCetaz+KZucu6DKwGssBlDJEgLR2YoAHMbjxywgX8QEyQvp46JK
   e2M5lhBJnotyqDVc03D8416O4s83BRCe2iPWF6WCsj5I+bKez4XAZIXNu
   g==;
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="31640672"
IronPort-PHdr: =?us-ascii?q?9a23=3A87JOIxwop/ngOSnXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0ugULPad9pjvdHbS+e9qxAeQG9mCsLQe1rKd6vq8EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm7rRndusYLjYd8Jas61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IAoBa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Qgwr42mJ?=
 =?us-ascii?q?oTtl/DETHql0nskK+Xdlkr+uiv6+j9ZLXpuoScOJNuhgH7M6QuntSzAeU+Mg?=
 =?us-ascii?q?cQQ2iW4fmw2bLs8EHjQLhGk+c6nrfWvZzEP8gXu7a1AwpP3YYi7xa/AS2m0N?=
 =?us-ascii?q?MdnXQfN1JKZQmHgpP1O1DOPP/4DfC/j06qkDdw3f/KJLLhApLTLnTbirfuYa?=
 =?us-ascii?q?5961JAyAo01d1f54hUCrAcL/PzQED8r9PYDhg+Mwy7x+boFs9x2Z8ZWWKKGq?=
 =?us-ascii?q?WZKr/dsUeU5uIzJOmBfJcVtyzgK/gh/PPulWU2mUIZfaWw2JsXb3e4Hu54LE?=
 =?us-ascii?q?mDfXXshdIBG38QvgUiVOzqlEGCUTlLanmsR6Iz/Cs7CIO9DYrYXoCimqaB3C?=
 =?us-ascii?q?agHp1OYmBJEEyDHmnye4WDQfcMZzqYItV9nTwcSbihV4gh2Am1tADkz7pnL+?=
 =?us-ascii?q?zU+jAXtJ/4yth16PPclQso+Tx3EcudyWeNQH9wnm8SQD82xq9/q1Rnylifya?=
 =?us-ascii?q?h4n+BYFdtL6vNNUwc6M4PczuNjB9DxRA3BZNGJR0iiQti9HzExQcw+w8UUb0?=
 =?us-ascii?q?Z+BdqilBbD0DSuA7MPkLyLHpM0+LrG33ftP8Z912rG1K45glklXMRPL2umib?=
 =?us-ascii?q?B79wTKG47GjV+Wl6OxeKsG2i7C6X2DzW2PvE5FSgJ/TaLFXXUHbEvMsdv5/l?=
 =?us-ascii?q?/CT6OpCbk/MAtO18CCKqVUatDyglVGQ/DjONvaY22vgWu/GRGIxraUZorwZ2?=
 =?us-ascii?q?odxDndCFQDkw0L5naJLww+ByegomPeCjxjDkjgY0Xx/ulkr3O7T1I7wxuWYE?=
 =?us-ascii?q?1m0rrmsiIS0NyGSv8C1/o6sSM6oi99Hkv1i9LMCtaRriJue6JTZd5761BCgz?=
 =?us-ascii?q?H3rQt4a6e8Irhii1hWSAF+u0fjxl0jEYlbudQ7p3MtigxpIOSX100XJGDQ5o?=
 =?us-ascii?q?z5JrCCcjq6xxuocaODnwiFgds=3D?=
X-IPAS-Result: =?us-ascii?q?A2CzAACuihNe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWsEA?=
 =?us-ascii?q?QELAYF8gWwBIBIqhAIHiQOGZAEBBAaBEiWJbo9hgRADRw0JAQEBAQEBAQEBI?=
 =?us-ascii?q?BcBAYRAAoINNwYOAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIwQRF?=
 =?us-ascii?q?isQCxgCAiYCAjEmBggFAgQBAQEBGQSCQj+CUwUgrRB1fzOFT4MogT2BDigBh?=
 =?us-ascii?q?X+GM3mBB4E4DAOCXT6EFgESAYMvgjwiBI12gguGNGFGlz2CQIJFk08GG5pbq?=
 =?us-ascii?q?zwjNzBxKwgCGAghD4MnUBgNjjkBCI00IwMwEIwlgjIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Jan 2020 19:33:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 006JWpTg063000;
        Mon, 6 Jan 2020 14:32:56 -0500
Subject: Re: [PATCH] security: selinux: allow per-file labelling for binderfs
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>
References: <20200106181329.167322-1-hridya@google.com>
 <d78e4db4-5847-082c-189a-f13d7d6a6c7a@tycho.nsa.gov>
 <CA+wgaPMHWOVYo_pVeYuvj6CrQOgy9=vQco+tnGHjPX3=CLh5wA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c1354989-1e08-1433-f2c0-5984da341cf5@tycho.nsa.gov>
Date:   Mon, 6 Jan 2020 14:33:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CA+wgaPMHWOVYo_pVeYuvj6CrQOgy9=vQco+tnGHjPX3=CLh5wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/6/20 2:06 PM, Hridya Valsaraju wrote:
> On Mon, Jan 6, 2020 at 10:33 AM 'Stephen Smalley' via kernel-team
> <kernel-team@android.com> wrote:
>>
>> On 1/6/20 1:13 PM, Hridya Valsaraju wrote:
>>> This patch allows genfscon per-file labeling for binderfs.
>>> This is required to have separate permissions to allow
>>> access to binder, hwbinder and vndbinder devices which are
>>> relocating to binderfs.
>>>
>>> Acked-by: Jeff Vander Stoep <jeffv@google.com>
>>> Acked-by: Mark Salyzyn <salyzyn@android.com>
>>> Signed-off-by: Hridya Valsaraju <hridya@google.com>
>>
>> Do you want binderfs to also support userspace labeling of files via
>> setxattr()?  If so, you'll want to also add it to
>> selinux_is_genfs_special_handling() as well.
> 
> Thank you for the quick response Stephen :) I cannot think of a
> use-case for the userspace labelling of files in binderfs via
> setxattr() as of now. I
> will make the change if one comes up!

Ok, then you can include my:
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> 
> Thanks,
> Hridya
> 
> 
>>
>>> ---
>>>    security/selinux/hooks.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 116b4d644f68..3f0669a708e9 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -752,6 +752,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>>>
>>>        if (!strcmp(sb->s_type->name, "debugfs") ||
>>>            !strcmp(sb->s_type->name, "tracefs") ||
>>> +         !strcmp(sb->s_type->name, "binderfs") ||
>>>            !strcmp(sb->s_type->name, "pstore"))
>>>                sbsec->flags |= SE_SBGENFS;
>>>
>>>
>>
>> --
>> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>>

