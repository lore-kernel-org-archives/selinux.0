Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6CCC43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB28F2067C
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 14:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lQ7NP4/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfLLOf5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:35:57 -0500
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:32542 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbfLLOf5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 09:35:57 -0500
X-EEMSG-check-017: 56993713|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="56993713"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2019 14:35:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576161355; x=1607697355;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9Mqz2dOWd/pYg3QfH3sCrA8eHMS8tT1vuibnf0WsL4Q=;
  b=lQ7NP4/bhxS7UpvN7yU/SBCJcKh89DIlmIJZN8ptiZWc3LcI5S3AQ3vj
   M0s6Hn3WwZ0pXruMe/VkedXbrvLxAZXpN2KU/eN87X6isnvrE4hjO98UR
   1lTmgJdXDlGWw371VBkrES8k+qOL9+k2V8Ek5ajZtKL6ZDbZP7GMkLYyk
   6KOpY9wv/FFUdcKLP5ZeMX7umKy6y2SvaePKjnblgIqL/dRL5GuSMBxtc
   mOKT/lbbdHWJ2fJjWoQoE+B6o3eaeqJfXnHw2T59fQXC5Drh/cBTUjHUz
   cbm8GtISdym663Aeuh4jm1W5AH6OQ11KsgYL9/0iz30IcmOyNkWm1nUSW
   w==;
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="36663169"
IronPort-PHdr: =?us-ascii?q?9a23=3A/9Us0xa/4J54C7T1e/WELe7/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrs26bnLW6fgltlLVR4KTs6sC17ON9fmxBidevN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdu80UjIdtK6s8yg?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDE36mHXjtF7grxdrhyvuhdzx5fYbY+ROfZ7eK7WYNEUSn?=
 =?us-ascii?q?dbXstJSiJPHI28YYsMAeQPM+lXoIvyqEcBoxalGQmhBvnixiNUinL436A31f?=
 =?us-ascii?q?kqHwHc3AwnGtIDqGnarMnrO6cKUeC60q/IxijeYfNTwzj97IzIfQ4hoPqRWr?=
 =?us-ascii?q?9watfeyVI0GgPZjlSftYzlPzSP2uQLqGiU9fBsVe2oi245sgx8pCWkyMkrio?=
 =?us-ascii?q?nMnI0Vy1bE+D12wIY0Od24SFN7bsW+HJRMsCGaMo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Qgwr42mJ?=
 =?us-ascii?q?oTtl/DETHql0nskK+Xdlkr+uiv6+j9ZLXpuoScOJNuhgH7M6QuntSzAeU+Mg?=
 =?us-ascii?q?cQQ2iW4fmw2bLs8EHjQLhGk+c6nrfWvZzEP8gXu7a1AwpP3YYi7xa/AS2m0N?=
 =?us-ascii?q?MdnXQfN1JKZQmHgpP1O1DOPP/4DfC/j06qkDdw3f/KJLLhApLTLnTbirfuYa?=
 =?us-ascii?q?5961JAyAo01d1f/IxbCrUAIPL1R0/wu8fVDgE2MwOq2ebrEtZ92Z0EWWKJHK?=
 =?us-ascii?q?CZNLnesViS5uIgO+OMfpMauC7hK/g54P7jlWI2lkUBcqWz2psXdm63Hu58I0?=
 =?us-ascii?q?WYfHXjnMwMEWgPvgUkTezqjEeOXiJUZ3a3DOoA4WQgBYanC5rTbp6ijabH3y?=
 =?us-ascii?q?qhGJBSIGdcBRTEPXDtdoOFUPRERziTLNMpxjANXv6mVYI7zxCiuSf1zrNmKq?=
 =?us-ascii?q?zf/ShO5rz5090g3PHejRE/83RPCs2Z12ycBzVvknggWy493Kc5p1d0jFiEz/?=
 =?us-ascii?q?4r0LRjCdVP6qYRAU8BPpnGwrk/UIH/?=
X-IPAS-Result: =?us-ascii?q?A2D0AAC2TvJd/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gRhUASASKoQDiQOGaQEBAQEBAQaBN4lbDpFGCQEBAQEBAQEBAS0KA?=
 =?us-ascii?q?QGEQAKCLjgTAhABAQEEAQEBAQEFAwEBbIU3DII7KYJ6AQEBAQIBIxVGCwsYA?=
 =?us-ascii?q?gImAgIhNgYBDAYCAQGCXz8BgkYDCQUgD6xkdYEyhDoBgRSCOw1jgUIGgQ4oj?=
 =?us-ascii?q?DJ5gQeBOA+CKDU+ghtJAoRzgl4EjRMDD0SJGkZ2lW1DgjqCPIRoijKEHQYbm?=
 =?us-ascii?q?kGOS4hMgheRayKBWCsIAhgIIQ+DJ1ARFJAsF4NQinEjAzAKkA4BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Dec 2019 14:35:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBCEZcd6043956;
        Thu, 12 Dec 2019 09:35:38 -0500
Subject: Re: [PATCH v2] mcstrans: start early and stop late
To:     selinux@vger.kernel.org, Dominick Grift <dac.override@gmail.com>
References: <20191211134423.2357254-1-dac.override@gmail.com>
 <20191211142124.GB2233813@brutus.lan>
 <d992aba5-77a3-bd47-6cae-95fc5ecf10dd@tycho.nsa.gov>
 <20191212142436.GA2670272@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c961712f-a084-e421-a919-41d5a86ee5bc@tycho.nsa.gov>
Date:   Thu, 12 Dec 2019 09:36:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212142436.GA2670272@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/12/19 9:24 AM, Dominick Grift wrote:
> On Thu, Dec 12, 2019 at 08:45:29AM -0500, Stephen Smalley wrote:
>> On 12/11/19 9:21 AM, Dominick Grift wrote:
>>> On Wed, Dec 11, 2019 at 02:44:23PM +0100, Dominick Grift wrote:
>>>> It stopped too early, exposing a bug in sudo selinux_restore_tty():
>>>>
>>>> SELINUX_ERR op=setxattr invalid_context="wheel.id:wheel.role:users.terminals.pty.pty_file:SystemLow"
>>>> avc:  denied  { mac_admin } for  pid=859 comm="sudo" capability=33 scontext=wheel.id:wheel.role:sudo.wheel.subj:s0 tcontext=wheel.id:wheel.role:sudo.wheel.subj:s0 tclass=capability2 permissive=0
>>>>
>>>> If we want to be able to reference human readable contexts in SELinuxContext= and nspawn -Z and -L then we need mcstrans ASAP
>>>
>>> Unfortunately it does not quite seem to address this challenge, at least currently, but still
>>> I think systemd would need to refresh its label cache when mcstrans is started, as per systemd v245 that should be a little less painful than it is today
>>> Something like a: ExecStartPost=/bin/systemctl daemon-reload would do that then
>>
>> I'm a little unclear on where the bug lies - you show a sudo denial, but
>> refer to systemd as the culprit?
> 
> The sudo bug is fixed here: https://github.com/sudo-project/sudo/commit/718e6997fcaae6ea065ce74d08dd4aae5917df5e
> 
>>
>> If we don't care about being able to use translated contexts in systemd unit
>> files or options, it could always use the _raw interfaces to ensure that it
>> is always dealing with the raw kernel contexts.  The translated contexts are
>> mostly for display purposes for MLS labels/policies.
> 
> The thing with systemd is that since systemd runs before mcstrans is started it doesnt use mcstrans.
> So if you try to reference translated contexts using systemd then it will refuse.
> Running a systemctl daemon-reexec after mcstrans is started fixes that issue but that is not really an option.
> 
> I am wondering what causes this behavior, i suppose this is some libselinux thing.

Yes, libselinux checks for the existence of the mcstrans socket exactly 
once on the first attempted translation, and if it does not exist at 
that time, it never tries again.  That is to avoid overhead on systems 
that are not running mcstrans, which is the majority of systems. 
mcstrans is only really needed for MLS policies and those are a minority 
of SELinux systems.

> Regardless of all the above though, i think it makes sense for mcstrans to start early and stop late.

Perhaps; I'll defer to the distro maintainers on that.  I don't really 
recommend using mcstrans unless you truly need it.

> 
>>
>>>
>>>>
>>>> v2: stop late, but do stop
>>>> Signed-off-by: Dominick Grift <dac.override@gmail.com>
>>>> ---
>>>>    mcstrans/src/mcstrans.service | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.service
>>>> index 09529432..c13cd09a 100644
>>>> --- a/mcstrans/src/mcstrans.service
>>>> +++ b/mcstrans/src/mcstrans.service
>>>> @@ -2,6 +2,9 @@
>>>>    Description=Translates SELinux MCS/MLS labels to human readable form
>>>>    Documentation=man:mcstransd(8)
>>>>    ConditionSecurity=selinux
>>>> +DefaultDependencies=no
>>>> +Before=shutdown.target sysinit.target
>>>> +Conflicts=shutdown.target
>>>>    [Service]
>>>>    ExecStart=/sbin/mcstransd -f
>>>> -- 
>>>> 2.24.0
>>>>
>>>
>>
> 

