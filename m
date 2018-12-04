Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A9C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B37C206B7
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B37C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeLDQt5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:49:57 -0500
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:26545 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDQt4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 11:49:56 -0500
X-EEMSG-check-008: 650880510|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,314,1539648000"; 
   d="scan'208";a="650880510"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2018 16:49:55 +0000
X-IronPort-AV: E=Sophos;i="5.56,314,1539648000"; 
   d="scan'208";a="18408247"
IronPort-PHdr: =?us-ascii?q?9a23=3AS0lrURyRI6Ebw3DXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+8SIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsL4V7A0XS?=
 =?us-ascii?q?mp4bltRhHmlSwLMyc1/H/LhsB1iq9QvRCvqAFlw4PMfY+bNORwfq3ec90US2?=
 =?us-ascii?q?VOUcReWDBODI6nc4sCDPAMMfpEo4TzpVYDqwa1Cwm2BOPozz9FnmL43bEk3O?=
 =?us-ascii?q?Q5EQHJwgogFM8TvnTRttr1MKMSXv61zaLVyjjDdO5Z2Szm5YjUchEuvfGMXb?=
 =?us-ascii?q?VqfcrX0kkgDRnJjlqXqYz7Jj6Y0PkGvWac7+plT+2vimgnphl1ojioyccgkJ?=
 =?us-ascii?q?LGh4ITx1vZ9it52J44KcC3RUN0e9KpEIZcuzuEO4Z5XM8uWXxktSAnwbMco5?=
 =?us-ascii?q?G7ZjIFyJE/yh7abPyIbpaH7wr4VOaUPTd4nHVleK+jhxqq8Uiv1On8Vs6s3V?=
 =?us-ascii?q?ZWtCVFiNjMtm0W1xDJ9siGSudy/kem2TqV0QDc9vpELlwumareKp4hxqY8lp?=
 =?us-ascii?q?sVsUvdAi/7gFj6gaCZe0k++uWk9v7rbqvpq5OCLYN4lxnyMqE0lcy+BeQ4PB?=
 =?us-ascii?q?IOX2+e+emkz73s4Fb5Ta5Wjvw2jqbZsJfaKd4dpq6iGQBZyIkj6xGhDzu+yt?=
 =?us-ascii?q?QXgWEHLE5ZeBKAl4XmIFTOIPPkDfeijVWskSlkx/bdM73uB5XCNHnDkLP7cb?=
 =?us-ascii?q?lh7E5czRI5zcpD6JJMFrEBPPXzV1fqtNPGCh85Mgq0w/voCdhmyIMeVnyAAr?=
 =?us-ascii?q?WDPKPRr1CI/OQvLPeIZIMPvzb9MfcltLbSiioTvHxVKaOs3ocKd3G1GNxpJk?=
 =?us-ascii?q?yYZTznhdJXVS8Rsw4/SvH6oEONXCQVZHuoWa84oDYhB9GIF4DGE7uxjaSB0S?=
 =?us-ascii?q?HzJZhfYmRLGxjYCnvzX5mVUPcLLiSJK4lulSJSBuvpcJMoyRz77Fyy8LFgNO?=
 =?us-ascii?q?eBv3dAuA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DPAACWrwZc/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopgWiEIJR0AQEBAQEBBoEILYkfjj6BZjgBhEACgwoiNwYNAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjYkgmIBAQEBAgEjDwEFUQsYAgImAgJXBgEMCAEBgl4/gXUFCKUVgS+Be?=
 =?us-ascii?q?Ig4gQuLExd4gQeBOIJrhFsOgxyCVwKJDYcikBoJiBWJJgYYkSaJBo0chDEig?=
 =?us-ascii?q?VUrCAIYCCEPgyiQeCEDgTUBAYgWgkwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Dec 2018 16:49:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB4GnssJ005119;
        Tue, 4 Dec 2018 11:49:54 -0500
Subject: Re: SELinux logging problem
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     BMK <bmktuwien@gmail.com>, selinux@vger.kernel.org
References: <CAFSQBhHFcRxUivx+wYRLyD4Z=6sZ4-3VsgtjRiG=+9crtOyTXA@mail.gmail.com>
 <01635e21-f143-d940-ceb1-b95079ddf23b@tycho.nsa.gov>
Message-ID: <67ce07aa-d88a-5e1d-fa7d-66491ced1714@tycho.nsa.gov>
Date:   Tue, 4 Dec 2018 11:52:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <01635e21-f143-d940-ceb1-b95079ddf23b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/18 11:38 AM, Stephen Smalley wrote:
> On 12/4/18 11:03 AM, BMK wrote:
>> Hello,
>>
>> I am currently struggling with a strange SELinux problem,
>> for which I am not able to find an answer by reading the documentation
>> and researching online.
>>
>> The problem is, that some AVC denial log entries seem to get lost in
>> permissive mode,
>> in other words, they are not logged...
>> I've already deactivated all dont audit rules and I know for sure that
>> the denial actually occurs, because I can trace it via strace...
>> Although I can't see a corresponding entry in the audit.log.
>> By the way, in enforcing mode I can see suddenly the missing denial 
>> entry...
>> If the permissive mode lacks/drops some denials which we can only see
>> in enforcing mode,
>> then this would be truly terrible for the policy writers...
>> Otherwise I am out of ideas, what other things could cause the loss of
>> SELinux denials...
>>
>> I hope you can point me to right direction with this matter and
>> I thank you in advance for your help.
> 
> Permissive mode only logs the first instance of a denial by design to 
> avoid flooding the logs with repeated instances of the same denial.  So 
> if you triggered the denial a while ago and repeat the operation, you 
> might not see the denial again.  To be precise, in permissive mode, upon 
> the first denial of a permission, the permission is audited and then 
> added to the AVC entry so that subsequent denials using that cache entry 
> won't keep producing a denial. You can flush the cache to force denials 
> to re-appear by reloading policy (load_policy) or by switching back and 
> forth between permissive and enforcing mode (setenforce 1 && setenforce 0).

NB Any semodule operation will also trigger a policy reload (unless you 
specify -n or are acting on a policy other than the active one), so 
semodule -DB would also have flushed the cache for you when it removed 
all dontaudit rules.

> 
> If that doesn't explain the behavior you are seeing, then we can't 
> really help without more information about the problem, e.g. the denial 
> message you say is visible in enforcing mode but not permissive mode, 
> your kernel version, possibly the strace output, a reproducer if you 
> have one, what distro / policy you are using, etc.
> 
> There are cases where the audit system could drop records due to OOM 
> conditions, its ratelimit, or its backlog limit.  In those cases, you 
> should have a audit: message logged indicating that messages were lost. 
>   Check your dmesg or journalctl logs for such messages from the audit 
> system.  Those are audit system issues rather than SELinux.  You can 
> configure the limits via auditctl and/or the audit configuration.  But 
> generally those only apply when the audit system is under heavy load 
> from many denials (or many other audit messages) and you should see at 
> least some of them.

