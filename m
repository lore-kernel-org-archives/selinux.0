Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B14C072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 13:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963002175B
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 13:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="VD/6BiVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403815AbfEXNkm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 09:40:42 -0400
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:52046 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391361AbfEXNkm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 May 2019 09:40:42 -0400
X-EEMSG-check-017: 216684309|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 May 2019 13:40:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558705239; x=1590241239;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=lQ5iVmR7jz3pDgrAib2vicOCAns4CbWWRvH+5x4WZ/k=;
  b=VD/6BiVG4jV9uW+e0Z0j2Elj2QweFOgwQ+tbuP/nhyYhn7gg0FP//3Uk
   9KSk5pOkizqqtQ2qEbG8xSLeWv4kDBUwRHoibMBlbPs2IYLdyoYTmpYkb
   zzz+OLK+/d2eekoHuyOQ365Dt6SkKNBH14AfWpgPxxbX6hmriCIEQ+fJD
   Y44R2w2iK6UzzVZPnTavOJKzMekPwn5C5hep7ITznTvz128WklNK8M8nb
   psrBJiIMcemnDSPQ0wmT5Tii1SRaAj+kI0S4R6s0x5Bnh1C9R9tm+yuO5
   fsXJnBc2gwGIMXcATFLmoOaYRsP3cBPq350jLCIsrSE/d1ZDeab50AE38
   A==;
X-IronPort-AV: E=Sophos;i="5.60,507,1549929600"; 
   d="scan'208";a="24067871"
IronPort-PHdr: =?us-ascii?q?9a23=3AkKEXqxF5loqI3bYlBMPL551GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8i/bnLW6fgltlLVR4KTs6sC17OP9fm5Bydev96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMRm6txjdutQXjIdtK6s8yw?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9mvyY6z6cJuZ?=
 =?us-ascii?q?+9fCUS1Zso2QXQa/2dfIiO+B7jU/yRITh+iXl4e7y/nw6//VWvx+DzTMW50E?=
 =?us-ascii?q?tGojBbntTDqHwBzQHf586aQfVn5EihwyyA1wXL5+FBJkA7iLTUJoY6wr41ip?=
 =?us-ascii?q?oTqUPDHjLqmEnujK+ZaEEk+u+w5uT7eLrmvJ6cN5Jvig3kLqQvmtCwAeQ/Mg?=
 =?us-ascii?q?QUWWiU5f+826H58U38QbVKiuU6kqjfsJ/EOcQWvrO1DgBa34o56xuzEi2q3M?=
 =?us-ascii?q?oXkHUZNl5JZQqLj43zNFHPJPD4A+2/g1OpkDpz3PDJI6bhD47RLnnDjLjhfb?=
 =?us-ascii?q?F951RayAoo199T/Z1UCrYfIP7rQE/+qMTYDgMlMwyz2+vnCs9y1pgZWWKJGa?=
 =?us-ascii?q?KZKL3dsUWG5uIuJemMZYgVuDDnJ/c54P7uiGczmUUBcqmxwZsXdHe4E+x9LE?=
 =?us-ascii?q?WYbnrshdEBHHwXsQUgV+PqiUeNUThJa3a1RaI86SkxCJi6AofbWoCtnLuB0T?=
 =?us-ascii?q?+gHpJIYmBGC1aMEWrndoifRfcMZzydItV7njwHS7ehUYkh2g+qtAPgzLpnNO?=
 =?us-ascii?q?XU8DUCtZ3/zNh1+/HTlRYq+DFwEciQ132BQmB6k24TXDA2wa9/oVdnxliez6?=
 =?us-ascii?q?d3mP1YGsZV5/9TVQc6L5HcnKRGDIXQUxnGeJ+7QVOvRJ3yAzgqSdQZ29IUbU?=
 =?us-ascii?q?d7GtKkyBvE2nzuS5sciqaGAoB82KPT2H7vJsJ5xj6S3qguiF8OTsZFNGSgwK?=
 =?us-ascii?q?ll+F6AKZTOlhCii6uydakalBXI/WOHwHvG6FpUSyZsQK7FWjYZfUKQotPnsB?=
 =?us-ascii?q?CRB4SyAKgqZ1MSgfWJLbFHP5iw1gRL?=
X-IPAS-Result: =?us-ascii?q?A2ALAAAe8+dc/wHyM5BlGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?QUBAQEBCwGBZippgQQohBOIHIs7AQEBAQEBBoEILYlOjwqBewkBAQEBAQEBA?=
 =?us-ascii?q?QErCQECAQGEQAKCPiM0CQ4BAwEBAQQBAQEBAwEBbBwMgjopAYJnAQUjFUEQC?=
 =?us-ascii?q?xgCAiYCAlcGAQwIAQGCXz8BgXYUD6VggS+FR4MpgUaBDCgBhGiGahd4gQeBO?=
 =?us-ascii?q?IJrPoJhBBiEUYJYBJNXlHAJgg+CEoQhhHSHZQYbgwaTO4xohwCQZDiBVysIA?=
 =?us-ascii?q?hgIIQ+DJwmLCoFdg34jAzABgQUBAY1CAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 May 2019 13:40:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4ODebiA021818;
        Fri, 24 May 2019 09:40:37 -0400
Subject: Re: SELinux integration in sysVinit
To:     Jason Zaman <jason@perfinion.com>,
        Laurent Bigonville <bigon@debian.org>
Cc:     selinux@vger.kernel.org, 929063@bugs.debian.org
References: <8cef19ba-5055-39fd-873f-73c7ba13cb8e@debian.org>
 <20190524125522.GA48358@baraddur.perfinion.com>
 <20190524130015.GA25786@baraddur.perfinion.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c895de12-fdb2-086d-1ccc-d187f0a5d35f@tycho.nsa.gov>
Date:   Fri, 24 May 2019 09:40:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524130015.GA25786@baraddur.perfinion.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/24/19 9:00 AM, Jason Zaman wrote:
> Bigon asked me to forward this so its part of the bug tracker.
> 
> On Fri, May 24, 2019 at 08:55:22PM +0800, Jason Zaman wrote:
>> On Fri, May 24, 2019 at 01:17:00PM +0200, Laurent Bigonville wrote:
>>> Hello,
>>>
>>> There is currently some discussion at [0] about SELinux integration in
>>> sysVinit and the fact that somebody wants to delegate the loading of the
>>> policy to an other binary than PID1.
>>>
>>> Has somebody a remark or an objection to that proposal?
>>
>> I object too. There is a *huge* change in functionality. Originally if
>> you boot with SELinux enforcing, there are only two things that can
>> happen. Either you end up with the policy loaded or the machine halts.
>>
>> In the new patch, an attacker can just chmod -x /sbin/selinux-check then
>> next boot there will be no selinux enabled.
>>
>> if (access(SELINUX_CHECK, X_OK) != 0) fails, the machine will continue
>> to boot without SELinux enabled. There is no difference between a user
>> without /sbin/selinux-check on purpose and an attacker just chmod -x'd
>> the tool.

NB even amending the patch to use F_OK still leaves one vulnerable to an 
attacker doing rm /sbin/selinux-check to silently disable SELinux on 
reboot.  And you can't assume that anyone who can do that can already 
modify or replace /sbin/init; under existing policies /sbin/init has its 
own distinct SELinux type, which would not be assigned to 
/sbin/selinux-check by default (and probably shouldn't be even in newer 
policies since it is the entrypoint type for the init domain).

>>
>> SELinux does not protect /sbin anywhere near as much as /etc/selinux
>> (and doing that would probably be impossible). You'd need to check if
>> selinux is enabled and enforcing before skipping the loading ... which
>> is done by calling is_selinux_enabled() which needs linking to
>> libselinux. The important part of the original design is not
>> selinux_init_load_policy(), its is_selinux_enabled().
>>
>> If someone really wants to run sysvinit without libselinux then just
>> switch to Gentoo, if you're on a non-selinux profile then you dont have
>> libselinux.so. But I'd definitely not want to have this patch in Gentoo
>> either.
>>
>> -- Jason
>>
>>
>>> I already gave my POV regarding SELinux integration in debian.
>>>
>>> Kind regards,
>>>
>>> Laurent Bigonville
>>>
>>> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=929063
>>>

