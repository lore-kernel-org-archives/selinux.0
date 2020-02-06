Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A60C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7483C218AC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 17:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="nXlT4Dkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBFReP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:34:15 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:51686 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFReO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 12:34:14 -0500
X-EEMSG-check-017: 55758858|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55758858"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 17:34:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581010446; x=1612546446;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uitglYAsxBW70gfI3K2N4Io4s9jsHzXkJ6Q9OzkGud4=;
  b=nXlT4DkqnoysDnSV/6cblU8VI/52VQVqqnJ55o0D8+YeGAJo1fwfLlLl
   qfF8HXgzYJlWwPiFfsF6GXzk0kkDLblDKIDQE40o2KueuDXeG2KhbEE97
   tG/cPIijyV52CHw8johI64TQEZE2DxQW5uTQWc3gTGbo6rsZJ5xvPfLuc
   bUFaLsfWu6oTVhiTuKtKKFed+4VmnC0lTM0czPPeclUs6dA/wAmTBlV79
   HoZeNwvm9/pIP1eRgjSjeCwMYEERAp1Y+X1S+xi4UWhIbHICf5ZueaVmi
   ZXZurs0fFS6r/w+Z4vyPA1lPJSlWwlvn1sHnYd80jH/2FzvFMX3U0JJnT
   g==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="38768670"
IronPort-PHdr: =?us-ascii?q?9a23=3A4CZ/nRRWLr9TMS2M54fU1KkTA9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YhOHt8tkgFKBZ4jH8fUM07OQ7/m8HzFbqsfQ+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTonZFdetayGdsKFmOmxrw+tq88IRs/ihNtf8t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks03O?=
 =?us-ascii?q?Q7FQHNwRIuEdQAvn/JqNn5LakfXOSwwKTO0D7Nbe5Z2S3l5YbVch4vv/+MU7?=
 =?us-ascii?q?F+f8XfxkYgFR/KgFqLpIz5PD6YzPgBv3SV4udiU++klm4pqxt2ojiq3soil5?=
 =?us-ascii?q?XJiZwNylDE6yp5xps+K8C9SEFhZd6kFIVftiGHPIZxWcMtXnpotT0myrwGpZ?=
 =?us-ascii?q?G7fC8KxI4hxx7EcfOLaYeI4hX9VOuIJzpzmXxreLW6hxmo8EigzPXxVsa10F?=
 =?us-ascii?q?ZWripFj8LDumoR2BzU78iKTOZ28ES52TuXygze5e5JLVo0mKbGMZIt3LE9mo?=
 =?us-ascii?q?QJvUjeGCL9hV/4g7WMdko+/+il8+HnYrL7qZCCL4J0kQT+Mrg2msy4HOQ4Lh?=
 =?us-ascii?q?ACX2iF9uS4073u5VH5T69Qjv03j6nZq4rWJcUdpq63BA9VyZgs5AqlAze60N?=
 =?us-ascii?q?UXgXkHLFVfdBKBk4fpIE3BLOr9Dfe+h1SgiDZrx/bYMb39GpjBM3fOnbj7cb?=
 =?us-ascii?q?t99kJQ0hQ/wN9B655OF70NOPfzVVXwtNzcAB85KQu0w+P/BdVmy4weQnmCAr?=
 =?us-ascii?q?OZMazOsV+I4fgjI++XZIAPojr9JP8l5+D2gX8jhVAdZbWp3YcQaH2gBfRmJk?=
 =?us-ascii?q?KZYWDyjdcFC2gKuBcxQffliF2FVj5TaHKyULwm6j4nD4KmCJ/JRpqxj7yZwC?=
 =?us-ascii?q?e7AppWa3heCl+WDHfoc56JW+8WZyKPJs9tizkEVb+mS487yx6irhP1y71iLu?=
 =?us-ascii?q?DM4C0XqYrj1MRp5+3UjRw96yR0AN6H02GMVGF5hXsISCUs3KB+ukx90lOD3r?=
 =?us-ascii?q?JkjPNGD9BT4OlJUggiP57G0+N6E8zyWh7GftqRS1apXMupASotQdI2xN8OYF?=
 =?us-ascii?q?1wFMmijhDZ2CqqBr4Vl6GOBJAu9aLcxXfxLd5ny3nazKkhk0UmQsxXOGK8gK?=
 =?us-ascii?q?5/6w/TB4jSnkqHkaaqcqEc3DXC9GuZymqOpk5YWhZqUarZRXAfelfWrdPh60?=
 =?us-ascii?q?zeU7CuE7MnMhBaycOZMKRKbMDmjU9BRPfiJdvSeX6+m2C1BRyQ3LODcJLqe3?=
 =?us-ascii?q?kB3CXaEEUEjwcT/XCGNAQkAiehvn7RDD91GFLuZUPs7fdxqHehQkAoyAGKal?=
 =?us-ascii?q?Vr16Cp9R4NmfycV/QT06ofuCg/rzV0HVC938/ZCtebuQphc7tTYckn7FdEy2?=
 =?us-ascii?q?3ZrQp9MYKkL6x4gV4eaQt3tVv01xprEoVAjdQqrHQywQp2KKKY1k5BdjyB0Z?=
 =?us-ascii?q?DzJLLXMG/y8w6ra6PNxFHe38iZ+r0V5PQ7tVrjpgepGVQm83l91NlVyXSc7I?=
 =?us-ascii?q?3QDAUOSZLxTlo39x9iqrHZfCY9/YXU2mNoMaWtrj/NxcgmBO4+xxm6eddQLb?=
 =?us-ascii?q?mEFAjzE8IHHcShNOsqm12xZBIeIO9S7LI0P9+hd/aexKGrO+BgnDShjWRd54?=
 =?us-ascii?q?BwyU2M9y17Su7H25YK3euU0ReAVzf53x+dtZXMhY1aaDdaO22lxCztAoIZMr?=
 =?us-ascii?q?Z3epwGDW6oL+W4wdJxg5OrUHldohrrH1ob3OexcAeWKln62hddk08QpDjvlD?=
 =?us-ascii?q?Ox1T1vuykgtKuExCjHyOmkcwAIfiZISWR5hlDrIqC/j8odWUm1ak4ujhThrU?=
 =?us-ascii?q?/8269djKl5KGzITgFPZSeyZ2ppSKyrrZKLZcJV75Ik9y5QVaD0fVecW/j5vh?=
 =?us-ascii?q?AZ+yLlA2Zagjs8cnXioZj9nhpnmEqDI3tp6nnUY8d9wVHY/tOYDfpQ2CcWAS?=
 =?us-ascii?q?p1kz/aAnCiMNSzu9aZjZHOtqa5TW3lHp5eay/mycacuSK+zWRsDQe4nvz1kd?=
 =?us-ascii?q?riQiYg1iqu7MVnTSXFql7HZ4Dv06mrebZ8clJAGE736808HJp31IQ3msdDij?=
 =?us-ascii?q?AhmpyJ8C9fwi/IOtJB1Pe7NSFcSA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BTAADjTDxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWkFA?=
 =?us-ascii?q?QELAYF8gRhUIRIqhBWJA4ZkAQEBBoESJYlwj1CBJANUCQEBAQEBAQEBASsMA?=
 =?us-ascii?q?QGEQAKCYTYHDgIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgwEBAQEBAyMECwEFQ?=
 =?us-ascii?q?RAJAg4HAwICJgICVwYBDAYCAQGCYz8BglYlD5ECmwN1fzOJKYE4BoEOKgGMP?=
 =?us-ascii?q?HmBB4E4DAOCXT6CZAKEdYI8IgSWXYEnl2eCRIJOhHyOdgYbgkiIEJAzjmKIb?=
 =?us-ascii?q?JQ4Cig3gSErCAIYCCEPgydQGA2SEIocVSMDMI5KAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Feb 2020 17:34:04 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016HXCn4173745;
        Thu, 6 Feb 2020 12:33:13 -0500
Subject: Re: [PATCH] security: selinux: allow per-file labeling for bpffs
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Steven Moreland <smoreland@google.com>, paul@paul-moore.com,
        eparis@parisplace.org, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     "Connor O'Brien" <connoro@google.com>
References: <20200206165527.211350-1-smoreland@google.com>
 <91465612-2fb2-5985-ba45-d4d9fcf0f70c@tycho.nsa.gov>
Message-ID: <c61fc8f6-55c2-c717-5090-e535b7bdbb4f@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 12:35:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <91465612-2fb2-5985-ba45-d4d9fcf0f70c@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/20 12:21 PM, Stephen Smalley wrote:
> On 2/6/20 11:55 AM, Steven Moreland wrote:
>> From: Connor O'Brien <connoro@google.com>
>>
>> Add support for genfscon per-file labeling of bpffs files. This allows
>> for separate permissions for different pinned bpf objects, which may
>> be completely unrelated to each other.
> 
> Do you want bpf fs to also support userspace labeling of files via 
> setxattr()?  If so, you'll want to also add it to 
> selinux_is_genfs_special_handling() as well.
> 
> The only caveat I would note here is that it appears that bpf fs 
> supports rename, link, unlink, rmdir etc by userspace, which means that 
> name-based labeling via genfscon isn't necessarily safe/stable.  See
> https://github.com/SELinuxProject/selinux-kernel/issues/2
> 
>> Change-Id: I03ae28d3afea70acd6dc53ebf810b34b357b6eb5
> 
> Drop Change-Ids from patches submitted upstream please since they aren't 
> meaningful outside of Android.
> 
>> Signed-off-by: Connor O'Brien <connoro@google.com>
>> Signed-off-by: Steven Moreland <smoreland@google.com>
>> ---
>>   security/selinux/hooks.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index de4887742d7c..4f9396e6ce8c 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -872,6 +872,7 @@ static int selinux_set_mnt_opts(struct super_block 
>> *sb,
>>           !strcmp(sb->s_type->name, "sysfs") ||
>>           !strcmp(sb->s_type->name, "pstore") ||
>>           !strcmp(sb->s_type->name, "binder") ||
>> +        !strcmp(sb->s_type->name, "bpf") ||
>>           !strcmp(sb->s_type->name, "cgroup") ||
>>           !strcmp(sb->s_type->name, "cgroup2"))
>>           sbsec->flags |= SE_SBGENFS;
>>

Also, your patch appears to be based on an old kernel and won't apply 
upstream; see
https://github.com/SELinuxProject/selinux-kernel/blob/master/README.md




