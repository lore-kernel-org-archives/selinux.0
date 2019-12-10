Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDE3C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBC020652
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IYW84sbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfLJTun (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:50:43 -0500
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:4847 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJTun (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 14:50:43 -0500
X-EEMSG-check-017: 59847776|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="59847776"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Dec 2019 19:50:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576007441; x=1607543441;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=goBTfmzGGIGxz3Ccp8CHUXIk/x2ZpDlOsc3qC/ro7+s=;
  b=IYW84sbPKBrWd+lPsEu1EoKdaLw5uUgaww4IjAjzJ5vuvwE3hGaBa+H3
   AuXpdSvC/LDngpn/a+m7gDFcTmxXJpCYZHWZo2URjTAX0BgdtjvE00JaA
   hnnY2BAu2Jv9lW7ysxhj8B6l5q87NCeNpNJFVyXiKKgGTyGJponQbjgec
   MC5Tav3pUSmGdaX1cBSwvKdRXzahANDppqskhqJEy7qCBMLIbqE3lmzOU
   TOP1BNBfAYAVVINFbxEAMHiVi0wRgLHU9vAdhh+8ETMYqDowktEYGToTI
   quFiKMFVPU3GgpiSkEwjMfOKNpzISp1niEKu+2UkDQoI1FQdCdE/cNnhr
   g==;
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="36571271"
IronPort-PHdr: =?us-ascii?q?9a23=3A2O3J8RDctp9nFcjmcEj1UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP36ps2wAkXT6L1XgUPTWs2DsrQY0rGQ6vG7EjVavt6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdu80YjIdtN6o91B?=
 =?us-ascii?q?nEqWZUdupLwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q6FGATo/K2?=
 =?us-ascii?q?w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWT?=
 =?us-ascii?q?mn8qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSX?=
 =?us-ascii?q?ddUspNUiBMBI2zb5ELD+EcI+hWqYfzrEYKoRenCwShAObjxzlVjXH0wKI6yf?=
 =?us-ascii?q?wsHxzY0gwuH9wAs3rao9v6O6gQTe+7w7LFzSnBYv5MxTvx9IbFfxInrPqRXb?=
 =?us-ascii?q?xwa83RyUw3Gg3YklWft5TlPzOL2eQLrmOV8u9gWviri24jtQ5woiWky8A3io?=
 =?us-ascii?q?bUnYIY0UzE9CVlz4Y1It20Ukh7YcW+H5dKuCGaMJV2T9okTmp1tig6zbgGto?=
 =?us-ascii?q?S6fCgM0Jkn3QDQZOGHc4eS/hLvTvqeITB9hH9jZbmxhA6y/FC9xuDzWcS4yl?=
 =?us-ascii?q?ZHojdfntXSuX0ByQbf5tWBR/Bg5EmuwyyP2BrW6uxcJEA0krfUJIA5z74rk5?=
 =?us-ascii?q?oTrVzDHijrmEXqlKOWdlsr+uyv6+n/frXpvIWcN45pigHlKKgum8q/Aeo/Mg?=
 =?us-ascii?q?gVQWeU5f6w1KHj/ELlQLVKiec6kq/Fv5DBOcsXvKu5Aw5R0oo76ha/CSmp0M?=
 =?us-ascii?q?gAkHUaI19IdwiLgoj0N13UPvz1Aumzj06xnDtzwvDJJLzhApHDLnjZl7fheK?=
 =?us-ascii?q?5w61VBxwoo1t1f+5JVBa0BIPL0QEPxssfYAQUjPwy7xObnFs1x1pkCVmKXHq?=
 =?us-ascii?q?+ZLKTSvEeU6e01OOmDeo8UtS3mK/c55/7hl2I5mVEZfaa3x5sbcWy3Ee58L0?=
 =?us-ascii?q?qFZnrsh88LEX0WsQomUOzqlFqCXCZLZ3moQqI84io2CJq8AofeQoChmbmB3C?=
 =?us-ascii?q?C8Hp1MeG9KEEyDEXDtd4+cQfcDdDqSItN9kjwDTbWhTIoh1Ra1tA/80bVoMv?=
 =?us-ascii?q?Tb9zYCtZ39ydd15/fclQ0o+TNoCMSd1nmHT3tokWMQWz82wKd/rFRmylid1a?=
 =?us-ascii?q?h4gvpYFcFc5v5STAc6OoDTz/ZgB9DxRA3BZNGJR0iiQtm8BjExVN0xkJcyZB?=
 =?us-ascii?q?NWEs6vn1j41CqjHrERmqbDUJc96a/N92P6J89gxXLLzuwqhh8tRc4ZcSWej7?=
 =?us-ascii?q?N7vy3UAJTE2xGBnruuXbwVwSqI8WCE12fIt0ZdBko4dqPJR30dLm7RttLw7U?=
 =?us-ascii?q?7BB+upDLM8NAJKxOaYJ6dKY8GvhlJDEqTNItPbNlmtln+wCBDA/baFaI7nai?=
 =?us-ascii?q?1JxynGIFQVmAAUu3CdPE4xATn38DGWNyBnCV+6OxCkyuJ5sn7uCxZvngw=3D?=
X-IPAS-Result: =?us-ascii?q?A2BSAAC99u9d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBGFUgEiqEA4kDhnEGgRIlgQGIaI9fgWcJAQEBAQEBAQEBK?=
 =?us-ascii?q?wwBAYRAAoInOBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJ6AQUjFUEQCxgCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBF4JIPwGCUiUPrWaBKoEyhU+DQIFCBoEOKIwyeYEHgREnD?=
 =?us-ascii?q?AOCKDU+gmQEGoEKJYMogl4EjRKJakaXIoI5gjuEaI5HBhuCQow3iz+OSohFk?=
 =?us-ascii?q?30igVgrCAIYCCEPgydQERSMcheBBAECgkmKcSMDMAGPNQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Dec 2019 19:50:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBAJoHwi144932;
        Tue, 10 Dec 2019 14:50:19 -0500
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less
 broken
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20191209075756.123157-1-omosnace@redhat.com>
 <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
 <CAFqZXNvMHEvv0tP7ybFEsH1-CvE5GGC9fEP=yXqEnQmjxgdDjA@mail.gmail.com>
 <CAHC9VhRe=xdz9eD9q8mO8=3QDVfsRpn7OUyXDj7o4C-cYfFHMQ@mail.gmail.com>
 <e1d9b641-8de6-9a0a-e6a2-d58c178a184b@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9669d08f-6411-f381-2f2a-59ab1d3fe337@tycho.nsa.gov>
Date:   Tue, 10 Dec 2019 14:50:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e1d9b641-8de6-9a0a-e6a2-d58c178a184b@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/10/19 2:43 PM, Casey Schaufler wrote:
> On 12/10/2019 11:29 AM, Paul Moore wrote:
>> On Tue, Dec 10, 2019 at 6:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>> On Mon, Dec 9, 2019 at 2:21 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 12/9/19 2:57 AM, Ondrej Mosnacek wrote:
>>>>> Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
>>>>> infrastructure to use per-hook lists, which meant that removing the
>>>>> hooks for a given module was no longer atomic. Even though the commit
>>>>> clearly documents that modules implementing runtime revmoval of hooks
>>>>> (only SELinux attempts this madness) need to take special precautions to
>>>>> avoid race conditions, SELinux has never addressed this.
>>>>>
>>>>> By inserting an artificial delay between the loop iterations of
>>>>> security_delete_hooks() (I used 100 ms), booting to a state where
>>>>> SELinux is enabled, but policy is not yet loaded, and running these
>>>>> commands:
>>>>>
>>>>>       while true; do ping -c 1 <some IP>; done &
>>>>>       echo -n 1 >/sys/fs/selinux/disable
>>>>>       kill %1
>>>>>       wait
>>>>>
>>>>> ...I was able to trigger NULL pointer dereferences in various places. I
>>>>> also have a report of someone getting panics on a stock RHEL-8 kernel
>>>>> after setting SELINUX=disabled in /etc/selinux/config and rebooting
>>>>> (without adding "selinux=0" to kernel command-line).
>>>>>
>>>>> Reordering the SELinux hooks such that those that allocate structures
>>>>> are removed last seems to prevent these panics. It is very much possible
>>>>> that this doesn't make the runtime disable completely race-free, but at
>>>>> least it makes the operation much less fragile.
>>>>>
>>>>> An alternative (and safer) solution would be to add NULL checks to each
>>>>> hook, but doing this just to support the runtime disable hack doesn't
>>>>> seem to be worth the effort...
>>>> Personally, I would prefer to just get rid of runtime disable
>>>> altogether; it also precludes making the hooks read-only after
>>>> initialization.  IMHO, selinux=0 is the proper way to disable SELinux if
>>>> necessary.  I believe there is an open bugzilla on Fedora related to
>>>> this issue, since runtime disable was originally introduced for Fedora.
>>> I, too, would like to see it gone, but removing it immediately would
>>> likely cause issues for existing users (see [1]) ...
>>>
>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1430944#c2
>> For the record, and for those who didn't click on the RHBZ link above,
>> I'm a big fan of getting rid of SELinux's runtime disable but concede
>> that it must be done in such a way to as not horribly break userspace.
> 
> Is there some reason that changing the "disable SELinux" option
> has to remove the hooks? Why can't it set selinux_enabled to 0
> and be done with it?

selinux_enabled is only used during initialization to deal with 
selinux=0 across the different components of SELinux.  It isn't checked 
by the hooks themselves.  And if we were to add a if (!selinux_enabled) 
return 0 to the start of every hook, then that's just another easy 
target for kernel exploits to leverage.

