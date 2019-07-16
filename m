Return-Path: <SRS0=e+Ck=VN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1C7C7618F
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 15:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E472173B
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 15:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="VeuBnmMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfGPPIk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:08:40 -0400
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:51117 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfGPPIk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Jul 2019 11:08:40 -0400
X-EEMSG-check-017: 873039548|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,498,1557187200"; 
   d="scan'208";a="873039548"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jul 2019 15:08:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1563289706; x=1594825706;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OlYRE8uRAueMrwc2Y4GxXIlPLZ0TFNlPetWv5UDX1g4=;
  b=VeuBnmMJPVX3co9J5dNivOliegpKacVOcH8rZjx6sJV+XVxvpJyni1LE
   CGiRb4ShA8pIErTjvtgJXyHpnl1/nsknD3xl0fD2vUEFUaGXdqbz7UN74
   yJBlXhnVjxVby8x7fFNRGWiXtQWU07X4OabDAtLjFSAP1LZHiCXVOYjgI
   kX7vi740lm+JIZ1HTYlunC7sV/Ft339iKlMp39nKnvy0brzuNJCbEOAgD
   JM0wGAeNkupGiNNblvwa4B7qKqQVj/lpj3WCCC68Hho0/kStB9V3/iF3B
   SgA5xrw3Fi+cLWmUXV/4dZIc8rv50ZjWp31QkUgxE4jsppurwzYjj1R56
   w==;
X-IronPort-AV: E=Sophos;i="5.63,498,1557187200"; 
   d="scan'208";a="30205658"
IronPort-PHdr: =?us-ascii?q?9a23=3Aiz5A2BYrfvZEVLbCa9ntvmj/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps+9Zx7h7PlgxGXEQZ/co6odzbaP6ea+ASdQvt6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6twTcutUZjYZhKKs61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IAoBa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Q9wr8wip?=
 =?us-ascii?q?UTsUPDEjXwmErql6+Zal8o+u2p6+Tjernmp5mcOJFoigzmL6gjlcOyDf44Pw?=
 =?us-ascii?q?QTRWSX5+ux2KP58UHkWLlKi+c5kqjdsJDUP8Qboau5DhdO0ok+8BayFCum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHj5PzNF3UL/D4Cum/j0y2kDh33/DGIqHhApLVI3jHjbfhYb?=
 =?us-ascii?q?F95lVfyAUt19Bf4YxbCrUbLPL0QE/xu8TSDgUlPAys3+bnFNJ925sFWW2RGK?=
 =?us-ascii?q?+ZP73dvESI5u01J+mMYI8UuDDnJ/c54P7uiGczmUUBcqmxwZsXdHe4E+x6LE?=
 =?us-ascii?q?qDenrjnNcAHHwRvgUiTOzlkkCCUTBXZ3msRaIw/y00B5i8AYjfQYCthaSL3D?=
 =?us-ascii?q?2nEZ1OemBGFleMHG/wd4qeRvcMbDmfItd7nTwZUbitUooh1RaptA/g1bVrNP?=
 =?us-ascii?q?bb+iodtZj7zth6+/XTlQ0u9TxzF8mdyH+CT2V1nmMOWj8307tyoVJyylidy6?=
 =?us-ascii?q?h0mf9YGsJJ5/NPTAg6MYTQz+tgC9D9QgjBZMuGSE66QtW6BjE8VtYxw94IY0?=
 =?us-ascii?q?ZgFNSulwvD0DS2DL8IjbyLBYA086LF03j0IMZy1mvG1K0/gFQ9XMtPOnOphr?=
 =?us-ascii?q?Rl+wjQGYHJiUOZmLiudagG2y7N7miDx3KUvE5ESA5wTbnFXXcHa0vUqNT54V?=
 =?us-ascii?q?nCT6WvCbQ8KQZBz9SNKq5UZd3ol1lGQ+3jONvGaWKrh2iwHQqIxq+LbIfyeG?=
 =?us-ascii?q?USwjvSCFMYnAAU+naGNhMzCTuho2LECzxuEFPvY17p8eVkr3O7VEA0xRmQb0?=
 =?us-ascii?q?J9z7q15gIVhfuERvMR2bIEuCEhpy92HFa639LZEdyApxF/c6Vaet4y/E1I1W?=
 =?us-ascii?q?Tetwx7P5yvM7pthloEfwtruEPu0g19Cp9cnsgysHMq0A1yJLqd0FNGbTOYwZ?=
 =?us-ascii?q?fwOrvSKmTp4B+va7TW2lbb0NaX56cP7e40q1L5vAGmRQIe9CBO1dVEm1+B+p?=
 =?us-ascii?q?LPDRAJUpO5BkIq6x9SpLzAZCQ5oYTO2isoeeOPvyXN1poEQqMFwxKkbtEVeP?=
 =?us-ascii?q?efGRX9HuUaDsyqOepskF+sOEEqJudXoZUoMtumev3O46uiOOJtjXrylmhcyJ?=
 =?us-ascii?q?xs2UKLsSxnQ6jH2IhTkKLQ5ReOSzqp1ATpicvwg40RIGhJT2c=3D?=
X-IPAS-Result: =?us-ascii?q?A2ACAQCg5y1d/wHyM5BlHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?WwqgTsBMiiEHJJmUwaBCS2JYYl+hTKBZwkBAQEBAQEBAQE0AQIBAYRAAoI6I?=
 =?us-ascii?q?zcGDgEDAQEBBAEBAQEEAQFshUiCOikBgmYBAQEBAgEjFUEQCw4KAgIRFQICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+BdwUPrRaBMoVHgzWBSIEMKAGLXhd4gQeBOII2NT6Df4EEg?=
 =?us-ascii?q?kuCWASMH4ImhiyVcgmCG4IfiSeIQAYbmAotjQiZXiKBWCsIAhgIIQ+DJ4JNF?=
 =?us-ascii?q?xSOKSMDMIEGAQGPKwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Jul 2019 15:08:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6GF8LPP028909;
        Tue, 16 Jul 2019 11:08:21 -0400
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
To:     Andy Lutomirski <luto@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        mortonm@chromium.org
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
 <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
 <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
 <20190716140349.GA4991@mail.hallyn.com>
 <CALCETrXR3RoRF0kZk_G-gAg=D6LNAcBJYiiHFHSe3S=bRZcwNA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <38ae330f-d673-d01b-c2be-530f9668ced5@tycho.nsa.gov>
Date:   Tue, 16 Jul 2019 11:08:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXR3RoRF0kZk_G-gAg=D6LNAcBJYiiHFHSe3S=bRZcwNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/16/19 10:21 AM, Andy Lutomirski wrote:
> On Tue, Jul 16, 2019 at 7:03 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>>
>> On Fri, Jul 12, 2019 at 12:54:02PM -0700, Casey Schaufler wrote:
>>> On 7/12/2019 11:25 AM, Stephen Smalley wrote:
>>>> On 7/12/19 1:58 PM, Casey Schaufler wrote:
>>>>> On 7/12/2019 10:34 AM, Nicholas Franck wrote:
>>>>>> At present security_capable does not pass any object information
>>>>>> and therefore can neither audit the particular object nor take it
>>>>>> into account. Augment the security_capable interface to support
>>>>>> passing supplementary data. Use this facility initially to convey
>>>>>> the inode for capability checks relevant to inodes. This only
>>>>>> addresses capable_wrt_inode_uidgid calls; other capability checks
>>>>>> relevant to inodes will be addressed in subsequent changes. In the
>>>>>> future, this will be further extended to pass object information for
>>>>>> other capability checks such as the target task for CAP_KILL.
>>>>>
>>>>> This seems wrong to me. The capability system has nothing to do
>>>>> with objects. Passing object information through security_capable()
>>>>> may be convenient, but isn't relevant to the purpose of the interface.
>>>>> It appears that there are very few places where the object information
>>>>> is actually useful.
>>>>
>>>> A fair number of capabilities are checked upon some attempted object access (often right after comparing UIDs or other per-object state), and the particular object can be very helpful in both audit and in access control.  More below.
>>>
>>> I'm not disagreeing with that. What I'm saying is that the capability
>>> check interface is not the right place to pass that information. The
>>> capability check has no use for the object information. I would much
>>
>> I've had to argue this before while doing the namespaced file
>> capabilities implementation.  Perhaps this would be worth writing something
>> more formal about.  My main argument is, even if we want to claim that the
>> capabilities model is and should be object agnostic, the implementation
>> of user namespaces (currently) is such that the whole view of the user's
>> privilege must include information which is stored with the object.
>>
>> There are various user namespaces.
>>
>> The Linux capabilities ( :-) ) model is user namespaced.  It must be, in
>> order to be useful.  If we're going to use file capabilities in distros,
>> and distros are going to run in containers, then the capabilities must
>> be namespaced.  Otherwise, capabilities will not be used, and heck, should
>> just be dropped.
>>
>> The only way to find out which user namespace has privilege over an inode
>> is to look at the inode.
>>
>> Therefore, object information is needed.
> 
> Agreed.  The concept in the kernel is "capability over a namespace."
> 
> That being said, sticking a flexible object type into ns_capable()
> seems prematurely general to me.  How about adding
> security_capable_wrt_inode_uidgid() and allowing LSMs to hook that?
> The current implementation would go into commoncap.  The obvious
> extensions I can think of are security_dac_read_search(..., inode,
> ...) and security_dac_override(..., inode, ...).  (Or dentry or
> whatever is appropriate.)

1) Not even all the inode-related capability checks go through 
capable_wrt_inode_uidgid(), so a hook there won't suffice.

2) Other capabilities have other kinds of objects, e.g. tasks, sysvipc, 
etc, and we'll want those to be handled too.

> 
> If this patch were restructured like that, the semantics would be
> obvious, and it would arguably be a genuine cleanup instead of a whole
> new mechanism of unknown scope.
> 

