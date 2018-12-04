Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99176C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 19:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCB32081C
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 19:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCB32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeLDTjc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:39:32 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:60041 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725855AbeLDTjc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 14:39:32 -0500
X-EEMSG-check-008: 216163454|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2018 19:39:29 +0000
X-IronPort-AV: E=Sophos;i="5.56,315,1539648000"; 
   d="scan'208";a="21327818"
IronPort-PHdr: =?us-ascii?q?9a23=3As1DTXBcC9pBRBCtpAiZhlavJlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW+Yh7h7PlgxGXEQZ/co6odzbaO4+a4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahYr5+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNIPpUo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj3LqoeTfy5wafKwDjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBeuSaaN45sTcMjRWFloCI6yroJuZ?=
 =?us-ascii?q?KhZycLyIwrxxHea/ybc4iI/wnsWPyNLjd/gXJofq+0iRWq8UW41+HxWca53E?=
 =?us-ascii?q?xKoyZYiNXAqH8A2wLJ5sSaTPZ2412v1iyV1w/J7+FJOUU0la3GJJE/2rMwjZ?=
 =?us-ascii?q?8TsVjbHi/xhUX2kLeadkU69eis7OTqeqnmqYWGN491lwH+Kb4imtC/AOskMg?=
 =?us-ascii?q?gOWHKX+eKg27344UL1WrBKjvwykqXBsZDaI9oUprKhDgNI3Ysu5AyzAje73N?=
 =?us-ascii?q?gCg3UKI0xJdAiag4TxPlHBOvH4DfOxg1S2lzdrwujLPqb8DZXWNXXDjLfgcq?=
 =?us-ascii?q?p9605b0gYzy8tf6IhOBrEOJ/LzRFf9tMbEAR8hLwy03+HnBc1m2YMbWmKPHr?=
 =?us-ascii?q?KZMa3TsVCW4OIiOOaMZIoPtzb8L/gp/eLhjXg8mVUFZ6mmwYMXaGykHvRhO0?=
 =?us-ascii?q?iZemTjgtMAEWcMowo/Q/fniEONUTFNfXa+RaE86S8hCIKgE4jDQpqhgLub3C?=
 =?us-ascii?q?e0BpdWfHxJCkiQEXf0cIWJQ+8MZziPIs9liTEETaKuS5Il1R23sQ/6zL1nLv?=
 =?us-ascii?q?DK9SECqZ3j0911tKXvkkQY0B88W86Y0H2QUGB5mEsHQjY32OZ0pkkrmXmZ1q?=
 =?us-ascii?q?0tuOBVDdxe4btyVw4+MZPNh7hhB8vaRhPKftDPTk2vBNqhH2diHZoK39YSbh?=
 =?us-ascii?q?MlSJ2ZhRfZ0n/vWuZNmg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B0AQDf1gZc/wHyM5BkGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?WZLBDMng3mUJ1IGgQgIJYkfjj6BZjIGAYRAAoMKIjgSAQMBAQEBAQECAWwcD?=
 =?us-ascii?q?II2JAGCYgEFIwQRQRALGAICEgETAgJXBg0GAgEBgl4/AYF0DQ+kaHwzgXiDS?=
 =?us-ascii?q?IRtgQuLExd4gQeBOAyCX4MFGQICgTkOYAKCOoJXAokNEoZZN5AaCYcDgRKFM?=
 =?us-ascii?q?YN1BhiCKI5+jW6INIQyIYFVKwgCGAghD4MnCYIeF38BCIJChnGEACEDMIEFA?=
 =?us-ascii?q?QGIFQENF4InAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Dec 2018 19:39:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB4JdRuI028385;
        Tue, 4 Dec 2018 14:39:27 -0500
Subject: Re: SELinux logging problem
To:     BMK <bmktuwien@gmail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
References: <CAFSQBhHFcRxUivx+wYRLyD4Z=6sZ4-3VsgtjRiG=+9crtOyTXA@mail.gmail.com>
 <01635e21-f143-d940-ceb1-b95079ddf23b@tycho.nsa.gov>
 <67ce07aa-d88a-5e1d-fa7d-66491ced1714@tycho.nsa.gov>
 <CAFSQBhHMG9cgda3KAo1y6pNWinkKvRAuwTNn6+d3j43Dphozew@mail.gmail.com>
 <b9924ce3-9039-94d3-71b4-709fdd218d94@tycho.nsa.gov>
 <CAFSQBhEXDy5RRXYqNM1Wn8naadrjS2MHO4qf5V=6U2a-AZzg8w@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6b2bfc1a-0318-c049-e6e3-aa993d6282ee@tycho.nsa.gov>
Date:   Tue, 4 Dec 2018 14:42:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAFSQBhEXDy5RRXYqNM1Wn8naadrjS2MHO4qf5V=6U2a-AZzg8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/18 2:01 PM, BMK wrote:
> On Tue, Dec 4, 2018 at 7:37 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 12/4/18 1:00 PM, BMK wrote:
>>> On Tue, Dec 4, 2018 at 5:50 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>
>>>> On 12/4/18 11:38 AM, Stephen Smalley wrote:
>>>>> On 12/4/18 11:03 AM, BMK wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I am currently struggling with a strange SELinux problem,
>>>>>> for which I am not able to find an answer by reading the documentation
>>>>>> and researching online.
>>>>>>
>>>>>> The problem is, that some AVC denial log entries seem to get lost in
>>>>>> permissive mode,
>>>>>> in other words, they are not logged...
>>>>>> I've already deactivated all dont audit rules and I know for sure that
>>>>>> the denial actually occurs, because I can trace it via strace...
>>>>>> Although I can't see a corresponding entry in the audit.log.
>>>>>> By the way, in enforcing mode I can see suddenly the missing denial
>>>>>> entry...
>>>>>> If the permissive mode lacks/drops some denials which we can only see
>>>>>> in enforcing mode,
>>>>>> then this would be truly terrible for the policy writers...
>>>>>> Otherwise I am out of ideas, what other things could cause the loss of
>>>>>> SELinux denials...
>>>>>>
>>>>>> I hope you can point me to right direction with this matter and
>>>>>> I thank you in advance for your help.
>>>>>
>>>>> Permissive mode only logs the first instance of a denial by design to
>>>>> avoid flooding the logs with repeated instances of the same denial.  So
>>>>> if you triggered the denial a while ago and repeat the operation, you
>>>>> might not see the denial again.  To be precise, in permissive mode, upon
>>>>> the first denial of a permission, the permission is audited and then
>>>>> added to the AVC entry so that subsequent denials using that cache entry
>>>>> won't keep producing a denial. You can flush the cache to force denials
>>>>> to re-appear by reloading policy (load_policy) or by switching back and
>>>>> forth between permissive and enforcing mode (setenforce 1 && setenforce 0).
>>>>
>>>> NB Any semodule operation will also trigger a policy reload (unless you
>>>> specify -n or are acting on a policy other than the active one), so
>>>> semodule -DB would also have flushed the cache for you when it removed
>>>> all dontaudit rules.
>>>>
>>>>>
>>>>> If that doesn't explain the behavior you are seeing, then we can't
>>>>> really help without more information about the problem, e.g. the denial
>>>>> message you say is visible in enforcing mode but not permissive mode,
>>>>> your kernel version, possibly the strace output, a reproducer if you
>>>>> have one, what distro / policy you are using, etc.
>>>>>
>>>>> There are cases where the audit system could drop records due to OOM
>>>>> conditions, its ratelimit, or its backlog limit.  In those cases, you
>>>>> should have a audit: message logged indicating that messages were lost.
>>>>>     Check your dmesg or journalctl logs for such messages from the audit
>>>>> system.  Those are audit system issues rather than SELinux.  You can
>>>>> configure the limits via auditctl and/or the audit configuration.  But
>>>>> generally those only apply when the audit system is under heavy load
>>>>> from many denials (or many other audit messages) and you should see at
>>>>> least some of them.
>>>>
>>>
>>> Thank you for your quick reply!
>>>
>>> Let me give you a little bit more details about my setup.
>>> I am working on debian 9.4 release with kernel version 4.9.0-6-amd64.
>>> I have my own custom policy based on the refpolicy version
>>> RELEASE 2 20161023. (it is pretty old but I have to work with that
>>> specific version).
>>> I am currently building a monolithic policy with dontaudit rules disabled.
>>>
>>> Now here are the steps to reproduce the logging problem I described above.
>>> Let say, I have a test domain foo_t, which is defined roughly as follows:
>>>
>>> type foo_t;
>>> domain_type(foo_t)
>>> corecmd_exec_bin(foo_t)
>>>
>>> Then I login as unconfined_u user and run the following command:
>>>
>>> runcon -u system_u -r object_r -t foo_t -l s0 mkdir foobar
>>
>> object_r is only for objects (e.g. files) not for processes, so you
>> should never pass it to runcon.  system_r would make sense for a daemon,
>> or unconfined_r for a user program launched by an unconfined_u user.
>>
> 
> Thank you for the tip, but I think it doesn't make difference for my
> actual problem.
> 
>>>
>>> Note that unconfined_t and foo_t actually need little bit more rules to execute
>>> the runcon command above, but they are irrelevant for my case...
>>>
>>> The mkdir binary is selinux aware by which I mean that it loads
>>> the libselinux.so shared library.
>>> The libselinux library executes upon loading the following syscall:
>>> (see https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/init.c#L156)
>>>
>>> access(SELINUXCONFIG, F_OK)
>>>
>>> This call would need a search dir permission for selinux_config_t and since
>>> the domain foo_t doesn't have the permission I was expecting a denial log entry.
>>> But the AVC denial never shows up in the logs in permissive mode.
>>> I also tried to empty the logging cache by executing
>>> setenforce 1 && setenforce 0, which didn't help.
>>> However in enforcing mode the denial is logged as expected.
>>>
>>> Hope this helps to clarify my question a bit further...
>>
>> Hmm...this access would be covered by a dontaudit rule normally since
>> many programs that link with libselinux don't actually need to access
>> /etc/selinux/config.  And in your example above mkdir will work just
>> fine without ever using /etc/selinux/config, so it truly isn't needed.
>> Thus, silencing the denial is the right thing to do.
>>
> 
> Yes, I am aware that mkdir still works but I chose it simply as an easily
> reproducible example where a search permission denial gets dropped
> in permissive mode...
> 
>> I suspect that you aren't actually stripping dontaudit rules, or you
>> aren't loading the policy you built but instead are loading the one that
>> still has the dontaudit rules in place.
>>
>> sesearch will show you whether there is a dontaudit rule, e.g. sesearch
>> --dontaudit -s foo_t -t selinux_config_t.
>>
> Yes, I double checked it and then I even deleted the corresponding
> dontaudit rules
> manually from the refpolicy but unfortunately it didn't help.
> And as I said, the denial *shows up* in enforcing mode, so I think
> dontaudit rule isn't here
> the problem...
> 
> As next step, I could try this out on other distros...

Oh, I think I understand the cause.  The pathname resolution code was 
split into two cases, a non-blocking rcu walk and a potentially blocking 
ref walk.  In the rcu walk case, we cannot block, so slow_avc_audit() 
bails out with ECHILD and the caller falls back to a refwalk where we 
can safely block.  But we've already updated the cache entry with the 
permission in the permissive case, so on the retry we don't audit it at 
all.  That's a bug.  Interesting that no one has noticed it until now...

To resolve, we need to propagate MAY_NOT_BLOCK down through 
avc_has_perm_noaudit() -> avc_denied() and skip the avc_update_node() 
call if it is set.  Then we'll never modify the cache entry under RCU 
walk and see the denial on the ref walk.  I think.

