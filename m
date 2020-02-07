Return-Path: <SRS0=TwHm=33=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D4BC3F68F
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C9221775
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 17:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qFLlrq4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgBGRvC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:51:02 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:10810 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGRvB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Feb 2020 12:51:01 -0500
X-EEMSG-check-017: 56438023|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,414,1574121600"; 
   d="scan'208";a="56438023"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Feb 2020 17:50:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581097858; x=1612633858;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=acy9Em98C3DLRuYcWtM82HsesNpon6/vQU563RLPnKQ=;
  b=qFLlrq4aGletjrShTQIiXJjJZGfzHo38HbjkgATVm5BNV5CO4lrKkLbH
   eX9jnWgwWEGv04VIk38CrfYKtlKvrqo5Ze2UX/EXTYpPgxauRuTDrofwN
   TqUaUlDQM6y+ZfL9iUxeUY/MvslgkdEKqOQXYt7RnCOf1KhlKciFjzgfx
   Wp276zdqYAK3qFhvvqLNpzCtiD/MISHqjoVIzclugb6QQLCdgDcFsBrcY
   aDz9Mx9HzlKMsk41wX2xAMsRtBJF4kUmGM3X59NtelxOhn/B77YVo/miP
   0rpeKmHl56t1msWMy8DPQ0+nXOcN9Ek886IsWwqIQr66M1V3uxqWHce2E
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,414,1574121600"; 
   d="scan'208";a="38827681"
IronPort-PHdr: =?us-ascii?q?9a23=3A0NwzMRcX50f0tZTCnVMSqfdDlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26ZhSN2/xhgRfzUJnB7Loc0qyK6vymBDFLuM7c+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTonZFe+tayX50KV+Tgh3w4tu88IN5/ylfpv4s+dRMXbnmc6g9ULdVECkoP2?=
 =?us-ascii?q?cp6cPxqBLNVxGP5nwSUmUXlhpHHQ3I5wzkU5nyryX3qPNz1DGVMsPqQ780Xy?=
 =?us-ascii?q?+i77pwRx/zlCgHLT85/3rJhcF2kalWvQiupx17w47TfYGVKP9zdb7TcN8GWW?=
 =?us-ascii?q?ZMWNtaWjdfCY2gcYQAE+sBPf5Zr4bjoVsOsQC+DhSoCO/21zNEmmP60ag83u?=
 =?us-ascii?q?svCwHG2BErEcwIvnrasd75ML4eXO6xwaXNyzjIcvFY1irn6IXQbx4vv/+MU7?=
 =?us-ascii?q?Jzf8Tfx0YgGAHKgUmfp4H+IzOY1f4Av3SH4+duV++ijXMspQFrojiow8chkp?=
 =?us-ascii?q?THhp4LxVDc9SV23oA1LsClRk5+e9GkFJ9QuD+aNoBrRc4iWHxnuD0hx70auZ?=
 =?us-ascii?q?+0YCgKyJM9yx7ZcPyIaZKE4h3kVOaPODp1gm9udrGnhxuq7EStxeLxWtO03V?=
 =?us-ascii?q?pXtCZJjNbBum4X2xDO7MWMV+Fz8V272TmV0gDe8uREIUcpmqXFM5Mh2bswlo?=
 =?us-ascii?q?YLsUTEAy/2hF36jK+IeUUg/eil8/jnba/8pp+dKo90kRvyMqUomsyxBuQ4KR?=
 =?us-ascii?q?YBUHSB9eSg1Lzs4U35QLJQgv0wjqbZq4zVKd4epq64Bw9Zyocj6xChADe6yN?=
 =?us-ascii?q?kUgHYKIV1fdB+HkoTlIU/CLf/mAfulnligiDJryOrHPr3lDJXNNH/DkLL5cL?=
 =?us-ascii?q?Zm9kFc0xE+zcxf5p1ICrEBJ+j/WknqtNPCFBM5PAu0w/j/BNVnyoweQX6PAr?=
 =?us-ascii?q?OeMK7KqV+I4vggI/SQZI8PoznyMeMo5+TwgnAkmV8SZ7Wp0YELZ3C/G/RsO1?=
 =?us-ascii?q?+Zbmb0gtcdDWcKuRIzQ/DliFyDVj5TYWi9X7kn6zE0D4KmCojDRoSzj7yExi?=
 =?us-ascii?q?i7H5lWanpaBVCLFHfib5+EVOsUaCKOPs9hlSQJVaO/RI8l1BGushL6yrV8I+?=
 =?us-ascii?q?rK9S0Xq4jj2MJ25+LNjxEy8yJ7D8CH32GKVWF0kTBAezhj5K1juwRZw0qfy6?=
 =?us-ascii?q?JxiPwQQcRX7u5VSA0zHYTRw+xzF5b5XQeXOp+iSEynWcmnCDcGYUwt38QFY0?=
 =?us-ascii?q?s1T96tnBfF0jGCDLgSmLiGAZU19uTX2H2ndOhnzHOT77Usl1krRIN0MGSigq?=
 =?us-ascii?q?Nuv1zIC5Xhj1SSl6Hsc78VmiHK6jHQniK1oEhEXVsoAu3+VncFax6T9I+o6w?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DCAgAyoz1e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBWJA4ZnBoE3iXCKJ4ckCQEBAQEBAQEBATcBAYRAAoJnOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgwIBBSMPAQVBEAsOCgICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CSwMJJa9UgTKFSoJsDWKBPoEOKow9eYEHgTgPgig1PoIbgXeDSYJeBJgIl?=
 =?us-ascii?q?2qCRIJOk3gGG4JImEctjjeBS5trIoFYKwgCGAghD4MnUBgNjikXjkEjAzCMJ?=
 =?us-ascii?q?YJDAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Feb 2020 17:50:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 017Ho4vl133621;
        Fri, 7 Feb 2020 12:50:04 -0500
Subject: Re: [PATCH] libselinux: drop error return from is_selinux_enabled.3
To:     Petr Lautrbach <plautrba@redhat.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
References: <20200207143744.9944-1-cgzones@googlemail.com>
 <pjd36bm4dat.fsf@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <53df5cb3-798c-66da-604b-94e7e48c5803@tycho.nsa.gov>
Date:   Fri, 7 Feb 2020 12:51:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <pjd36bm4dat.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/7/20 10:39 AM, Petr Lautrbach wrote:
> 
> Christian Göttsche <cgzones@googlemail.com> writes:
> 
>> is_selinux_enabled() does never return -1, do not say so in the manpage.

Just as a historical footnote: it used to be possible that it would 
return -1 prior to commit e3cab998b48ab293a9962faf9779d70ca339c65d circa 
release 20120216.

>>
>> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>> ---
>>   libselinux/man/man3/is_selinux_enabled.3 | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/libselinux/man/man3/is_selinux_enabled.3 b/libselinux/man/man3/is_selinux_enabled.3
>> index df62c225..a887b48c 100644
>> --- a/libselinux/man/man3/is_selinux_enabled.3
>> +++ b/libselinux/man/man3/is_selinux_enabled.3
>> @@ -15,7 +15,6 @@ is_selinux_mls_enabled \- check whether SELinux is enabled for (Multi Level Secu
>>   .SH "DESCRIPTION"
>>   .BR is_selinux_enabled ()
>>   returns 1 if SELinux is running or 0 if it is not.
>> -On error, \-1 is returned.
>>   
>>   .BR is_selinux_mls_enabled ()
>>   returns 1 if SELinux is capable of running in MLS mode or 0 if it is not. To
> 
> 
> There's also
> 
> libselinux/include/selinux/selinux.h:
> 
> /* Return 1 if we are running on a SELinux kernel, or 0 if not or -1 if we get an error. */
> extern int is_selinux_enabled(void);
> 
> 
> Would you mind to update this as well?
> 
> Thanks,
> 
> Petr
> 

