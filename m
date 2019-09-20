Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF27C49ED7
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 12:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC19620644
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 12:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ibeFp4ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408872AbfITMMI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:12:08 -0400
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:62020 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408843AbfITMMI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 08:12:08 -0400
X-EEMSG-check-017: 27497296|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="27497296"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Sep 2019 12:12:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568981525; x=1600517525;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OJfpPtTZ7VspR+LJTjlrUvTfdmy60Ek7zzwqkApSbe8=;
  b=ibeFp4ko59YkqSioN11DS9hiHbXM56veOAcrOZe7w/ux1pOlA/KDGC3B
   Fs0bFeUg0vzH7aO65khXHhF+OKjUPnSnyaA4wcHgvk2/He7rF1nbd+/7j
   pF4FV4c1zGJQNYLdN5zW/t/yoObZce+ShAa21PLygT3ihRE6fHJXlAsV3
   c4aKN3RK4yTP/BTwaSZDxy/Q3GF8y/dNHxLf91vaNiOxYL+ts5dir/dHW
   H/F4GVz7/68VhAnselhE96WxKxPsymjVDR1UrJvNqLgW5IREGu+Ic629h
   Uo62MyZK9eSasJn01ODcfIT7aH8QnUbwykcGSI5W8hwh/maX2jGZJtRsd
   A==;
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="28136370"
IronPort-PHdr: =?us-ascii?q?9a23=3AjtpyVB9KaXTbg/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20+scTK2v8tzYMVDF4r011RmVBN6dsagP17Se8/i5HzBZu9DZ6DFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMIjYd8Jao8xR?=
 =?us-ascii?q?rEqWZMd+hK2G9kP12ekwvi6suq4JJv7yFcsO89+sBdVqn3Y742RqFCAjQ8NG?=
 =?us-ascii?q?A16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWT?=
 =?us-ascii?q?Sj9KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USn?=
 =?us-ascii?q?RdUcZQTyxBA52zb40TD+oaIO1Uq5Dxq0YSoReiAAWhAu3gyiVMhnTrw6M01e?=
 =?us-ascii?q?ovGhzC0AA5H98DtHHYodPoP6kQTO+11rHFwyjdYfNY2Tnz64bGfR4urv6OQb?=
 =?us-ascii?q?1+ftHcyVUtGg7fklmctYLoMjGT2+8Qs2ab9e1gVee3hmA6twF+vCCvxscyhY?=
 =?us-ascii?q?nPm4kb11XE+j99wIYxO9K5SFNwbNm/EJRNrCGXLJd2Q8M+TGFovyY20LsGuY?=
 =?us-ascii?q?WhcyQQx5QnwADfZuWBfoOV4RzjTP6cLSp3iX9qYr6yhwu+/VK+xuDzSMW4yk?=
 =?us-ascii?q?tGoyxYmdfWrH8NzQbc6s2fR/t4+UeuxCiA2hjI6uFBPUA0ja3bK4M9wrIolp?=
 =?us-ascii?q?ocr0DDHijulUXqlqCWbEQk+vWz6+j9frXnpoOTN49zig3kNKQhhte/DvgiPg?=
 =?us-ascii?q?gLXmib/fyw1Lzl/ULnXLVHluA6n6bWvZzAJckXu7S1DxFa34o98RqzEi+q0N?=
 =?us-ascii?q?ECknkGKFJFdgiHj4/sO1zWO/D3EOy/jk+wkDZr2//GPrrhDo/LLnjYirjtZ7?=
 =?us-ascii?q?l960lCyAYr19BQ+4pUCq0dIPL0QkLxst3YAQM+Mwyw2ennE89x1oIZWWKIGa?=
 =?us-ascii?q?+ZK7jfsVqH6+MgOeWMY5UVuDnlIfg/+/HulWM5mUMafaSxxpsYdnS4HvVgI0?=
 =?us-ascii?q?WEbnvhmckBEWgUsQokVuDqi0ONUSRVZ3msW6Iw/DY7CJipDdSLeof4pr2K2y?=
 =?us-ascii?q?OyBdV3YWddERjYF3bjcIGNQLENbyWJOedkzixCUqKuHdwPzxar4TTmxqJnI+?=
 =?us-ascii?q?ycwSgRsZbuxZAh/OHIvQ0j/jxzScKG2ieCSH8izTBAfCM/wK0q+R818VyEy6?=
 =?us-ascii?q?UtxqUFRNE=3D?=
X-IPAS-Result: =?us-ascii?q?A2DCBABLwYRd/wHyM5BkHQEBBQEHBQGBZ4F0KoFAMiqEI?=
 =?us-ascii?q?o9kAQEBAQEBBoERJYl1j0GBZwkBAQEBAQEBAQE0AQIBAYQ/AoMJIzgTAgwBA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIU5gjopAYJmAQEBAQIBIwQRQRALGAICJgICVwYNBgIBA?=
 =?us-ascii?q?YJfP4F3BQ+sGX8zhUyDNIFJgQwojAkYeIEHgREnDIJfPoQtgyKCWASMTYk1l?=
 =?us-ascii?q?wuCLIIuklYGG5kmqUIhgVgrCAIYCCEPgydQEBSCdQECjTckAzCBBgEBjjYBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 20 Sep 2019 12:12:04 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8KCC1Uh005366;
        Fri, 20 Sep 2019 08:12:02 -0400
Subject: Re: [PATCH 1/1] libselinux: ensure strlen() is not called on NULL
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20190918210450.8692-1-nicolas.iooss@m4x.org>
 <1800df5d-121c-e275-f3bc-ec71d2b0d3e7@tycho.nsa.gov>
 <CAJfZ7==HxzHGkS2e+cJ+qsJaetVgBCv+xQWS0CYdE8yHWEhNwA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c4c1f901-5986-92e9-8345-1bf0b62c0ec9@tycho.nsa.gov>
Date:   Fri, 20 Sep 2019 08:12:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7==HxzHGkS2e+cJ+qsJaetVgBCv+xQWS0CYdE8yHWEhNwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/19/19 4:51 PM, Nicolas Iooss wrote:
> On Thu, Sep 19, 2019 at 6:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 9/18/19 5:04 PM, Nicolas Iooss wrote:
>>> When compile_regex() calls regex_prepare_data() and this function fails
>>> in the following condition:
>>>
>>>       *regex = regex_data_create();
>>>       if (!(*regex))
>>>           return -1;
>>>
>>> ... error_data has been zero-ed and compile_regex() calls:
>>>
>>>       regex_format_error(&error_data,
>>>           regex_error_format_buffer,
>>>           sizeof(regex_error_format_buffer));
>>>
>>> This leads to a call to strlen(error_data->error_buffer), where
>>> error_data->error_buffer is NULL.
>>>
>>> Avoid this by checking that error_data->error_buffer is not NULL before
>>> calling strlen().
>>
>> It seems like regex_format_error() should just return immediately if
>> !error_data->error_code (#ifdef USE_PCRE2) or !error_data->error_buffer
>> (#ifndef USE_PCRE2), since there is no back-end error message to get and
>> report in that situation.
> 
> I agree. I will modify the patch.
> 
> By the way, while reading function regex_format_error() more
> precisely, something seems strange in:
> 
> pos += rc;
> if (pos >= buf_size)
>      goto truncated;
> if (error_data->error_offset > 0) {
>      /* ... */
> }
> pos += rc;
> 
> As rc is not reset to zero, its value is added twice to pos. Is this a
> bug, or am I misunderstanding something?

I think you are correct - it is a bug.

> 
> Thanks,
> Nicolas
> 

