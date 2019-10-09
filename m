Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4F3C47404
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 13:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90E6218DE
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 13:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZDYSBiVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfJIN5I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:57:08 -0400
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:31808 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJIN5I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 09:57:08 -0400
X-EEMSG-check-017: 33949284|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,276,1566864000"; 
   d="scan'208";a="33949284"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Oct 2019 13:56:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570629413; x=1602165413;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=y2P+4bYghfEJ3KBvRWLQ4JjxISI91wXMaXuJWnnDhXQ=;
  b=ZDYSBiVO1/0gvKEAHT+oNQy8s+bl5aa1APFyDsGMq8HRakyqRYfzT7c3
   vzZOUW/4T5wA5p09Q5XAHk7dgeewraCULCAXErCs8UQpJrWK4TdYWs5SN
   uu5dclOn7/k+WX4fj+TJYbKepGj4zirBSrNhRTUXFtBYATCCvqRlfQtEN
   f8Ht4JjptpWpkQ7GNhkZCO7UaUTzTM6Hh7A3lTnehepqak0UccM9a0CDv
   4vyN6z1XRrJq/ZjDff3yq9Ih4ItaddGSpeU+6mcQyQL+F/6/Cy1NRxRDv
   v6uTVbV2Rn8s+7mjYLVXBlBgAkO5Ij1dfezYQFML65WgjC7dExrZo0Vrq
   Q==;
X-IronPort-AV: E=Sophos;i="5.67,276,1566864000"; 
   d="scan'208";a="33953340"
IronPort-PHdr: =?us-ascii?q?9a23=3AAQiMVxeEyyXwQ8oPy+ERJlzOlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26YRaN2/xhgRfzUJnB7Loc0qyK6vumBzVLu8nJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/Qu8ULjoduNKQ8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXoxazAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/QG9ooD43xqAJtJ?=
 =?us-ascii?q?O0ZiQHyIkrywTBZ/GIbYSE+A/vWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U?=
 =?us-ascii?q?5RripAjtnMrncN1wHP6sSfSvty4EOh2TGX2gDP8O5EO0E0lbfAK5I73r4xlo?=
 =?us-ascii?q?YcsUTEHiPsnkX5kLSWeVk+9uit6uTnZq3qpp6aN4BqlgHzKrkil8OwDOgiMg?=
 =?us-ascii?q?UCQnKX9fqz2bH950H1Xa1GjvgsnanYtJDaK94bpqm8AwJNyYYs9g2/Aiy60N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4jyIV7COv/4DfChg1i0ijdk2+jGPqH9ApXKNnXDiK3ufa?=
 =?us-ascii?q?t560NH0Ao8181f55ZNBrEEJ/LzXVXxu8LCAhAlNAy0xv7tCM9h2YMGRWKPHq?=
 =?us-ascii?q?iZPbvIsV+J+u0vI/ODZJUItznlN/cq//7ugmU4mV8bY6apxoAaZ2ukHvRnJU?=
 =?us-ascii?q?WZfWTjgs0HEWgUogoyVvDliFqHUTRLfXa9Q7o85i0nCIKhFYrDXZ6igLiA3C?=
 =?us-ascii?q?e9A51XaXtLCk6DEXj2bYWIQfQMZzyIIs9njDMEUaKtS4g71RGhrAX60aZoLv?=
 =?us-ascii?q?LI+i0EspLuzNd15/fNmhE99jx0D9+Q02WMT2Fyg2MJSDE23KdioUx711iMy7?=
 =?us-ascii?q?R4g/1fFdxV/f9JVR06NZGPh9B9Xuj7RwaJW9COUlvuFs2vHDUZVtssx5oLZE?=
 =?us-ascii?q?FnFpOpiRWVm2KQArQVnqaHTLw986TRxDClPcd2y3/c2J4quFkvQ81CLkWsmq?=
 =?us-ascii?q?956wXJAYPV1U6ekvD5W74b2Xv26GqbzWeI9HpdWQp0XLSNCWsTfWPKvN/54Q?=
 =?us-ascii?q?XEVLboBrM5ZFgSgfWeI7dHP4W6xW5NQ+3ubZGHODO8?=
X-IPAS-Result: =?us-ascii?q?A2A+AQDd451d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7gXQqgT8BMiqEI45aUwaBNol4kS4JAQEBAQEBAQEBNAECAQGEQ?=
 =?us-ascii?q?AKCTyM4EwIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCaAEFIxVBEAsYAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfP4FrAwkUsC+BMoVNgy+BSIEMKIwOGHiBB4E4gj0uPoIahTiCW?=
 =?us-ascii?q?ASWJ5ccgiyCL5JkBhuCOpcGji2BP5oIIoFYKwgCGAghD4MnUBAUgVsXjj8lA?=
 =?us-ascii?q?zCBBgEBk10BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 Oct 2019 13:56:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x99Dup0M013928;
        Wed, 9 Oct 2019 09:56:51 -0400
Subject: Re: [PATCH] selinux-testsuite: Update binder for kernel 5.4 support
To:     Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20191006085121.13556-1-richard_c_haines@btinternet.com>
 <5e20d80f-909f-0bb7-4cf5-16e7ce89382b@tycho.nsa.gov>
 <57056c510589650446ac4dd079c112e22dffb042.camel@btinternet.com>
 <4f0c2ff54dd1ad94392ef7c2428c766e0e2a2574.camel@btinternet.com>
 <CAHC9VhQcvFna_Jj5kZaJVbUtY_EW97sreAODTiaH8pb8nEqZjA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e9b371bc-f028-1f0e-2b7e-628c11c1a0db@tycho.nsa.gov>
Date:   Wed, 9 Oct 2019 09:56:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQcvFna_Jj5kZaJVbUtY_EW97sreAODTiaH8pb8nEqZjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/8/19 5:43 PM, Paul Moore wrote:
> On Mon, Oct 7, 2019 at 12:35 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
>> On Mon, 2019-10-07 at 16:17 +0100, Richard Haines wrote:
>>> On Mon, 2019-10-07 at 10:28 -0400, Stephen Smalley wrote:
>>>> On 10/6/19 4:51 AM, Richard Haines wrote:
>>>>> Kernel 5.4 commit ca2864c6e8965c37df97f11e6f99e83e09806b1c
>>>>> ("binder: Add
>>>>> default binder devices through binderfs when configured"),
>>>>> changed
>>>>> the way
>>>>> the binder device is initialised and no longer automatically
>>>>> generates
>>>>> /dev/binder when CONFIG_ANDROID_BINDERFS=y.
>>>>
>>>> This seems like a userspace ABI break, no?  Same kernel config
>>>> before
>>>> and after this commit yields different behavior for
>>>> /dev/binder.  I
>>>> suppose one might argue that one would only enable
>>>> CONFIG_ANDROID_BINDERFS if one wanted to use it instead of
>>>> /dev/binder
>>>> but the original commit that introduced binderfs specifically said
>>>> that
>>>> backward compatibility was preserved.
>>> I'll need to check this further, but from what I've seen so far, is
>>> that the /dev/binder is not available until you mount binderfs etc.
>>> that's why Paul had the failure on 5.4 as before then is was
>>> available
>>> when the binder driver first initialised.
>>
>> To confirm tests using kernel 5.4-rc1
>>
>> Test 1 config:
>> CONFIG_ANDROID=y
>> CONFIG_ANDROID_BINDER_IPC=y
>> CONFIG_ANDROID_BINDERFS=y
>> CONFIG_ANDROID_BINDER_DEVICES="binder"
>>
>> On boot no /dev/binder
>>
>> To get this you have to:
>> mkdir /dev/binderfs 2>/dev/null
>> mount -t binder binder /dev/binderfs -o
>> context=system_u:object_r:device_t:s0 2>/dev/null
>>
>> You then have devs:
>> binder and binder-control
>>
>> Test 2 config:
>> CONFIG_ANDROID=y
>> CONFIG_ANDROID_BINDER_IPC=y
>> # CONFIG_ANDROID_BINDERFS is not set
>> CONFIG_ANDROID_BINDER_DEVICES="binder"
>>
>> On boot you have /dev/binder
> 
> Disabling binderfs during build is probably not the smart thing to do
> considering where the world is at with namespaces/containers, whatever
> we do we should make sure the tests work with
> CONFIG_ANDROID_BINDERFS=y.

Yes, I think the question is just whether we want to have the tests use 
binderfs for kernel >= 5.0 (i.e. the point at which binderfs was first 
introduced) or for kernel >= 5.4 (i.e. the point at which binderfs usage 
became mandatory if you enable it in your config because /dev/binder is 
no longer automatically created).  I'm fine either way.


