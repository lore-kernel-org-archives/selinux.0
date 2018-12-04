Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B194C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 20:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAAE2082B
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 20:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAAE2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbeLDUCj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:02:39 -0500
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:23732 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeLDUCj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 15:02:39 -0500
X-EEMSG-check-008: 650991410|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,315,1539648000"; 
   d="scan'208";a="650991410"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2018 20:02:36 +0000
X-IronPort-AV: E=Sophos;i="5.56,315,1539648000"; 
   d="scan'208";a="18420801"
IronPort-PHdr: =?us-ascii?q?9a23=3A77F2Th8Z8wQcA/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20+8cTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMsPsTbAwRD?=
 =?us-ascii?q?+s8aFlRhH1gysDLjI17X3bhsl2galGohyuugZ/zpbJbo+LOvpwfqDTc90USm?=
 =?us-ascii?q?VOXMleSyNPD5igb4YNFecNIfpUoof/qlYIsBCwBROsBOTqyjJQm3H2wbM10/?=
 =?us-ascii?q?whEQ7Y2gwrAs8AsHHOo9XxMKcdT+C0x7TPwDXYcvxWwizw6JTIcx89ofGMWq?=
 =?us-ascii?q?h8cczKyUY1DQ/FgVKQqZL8Mj6Ty+8DvW+b7+96WuKujW4qswVxoj+gxss2kY?=
 =?us-ascii?q?bIhpoZyl/F9SVlwIY1OMa3RFRnbt6jFZtdsTyROYhuQs46Xm1ltyk3xqcGtJ?=
 =?us-ascii?q?KmZiQG1psqywDFZ/CadYWD/wjtW/yLIThigXJoYLe/hxGv/ke+0uD8Tcy00E?=
 =?us-ascii?q?pSripCj9nMqmgB1xzN5ciDTftw5luh1iyV1wDS9+FEOlo4lbbbKpE9wr4wkY?=
 =?us-ascii?q?AfsULfES/thEr6lqqWdkQg+uSw6uTnZKvppoOEOoNphQzzPb4il8yiDegiLA?=
 =?us-ascii?q?QDUHaX9f6h2LH7+E32WrRKjvk4kqnDt5DaINwWprWkDA9OyYsj9xa+ACum0N?=
 =?us-ascii?q?Qfh3UHKklFdwidg4jmPFHOPuj0De2jjFS0jDdr2/fGM6X6DZXILXjDjKrhfL?=
 =?us-ascii?q?h860FCzgo+1t9f55dOBbEAJPL/QFP+tNvdDhUhKQy73/7nCMlh1oMZQW+PGb?=
 =?us-ascii?q?GWMKfTsV+O++IuLPKBZJEauDnjMfgp/f3ugmEjmV8bY6ap2YEbaHeiHvRpO0?=
 =?us-ascii?q?+Ze2bjgs8dEWcWuQozVPTqh0efUT5XfHuyR7gz5iw/CI6/CIfDQYetgKaf0y?=
 =?us-ascii?q?uhApJWYWVGWRiwFiLCUqbMD/0Jaz6PPc5slBQLULGgT8kq0hT45yHgzL8yFf?=
 =?us-ascii?q?bZ4i0Vs9rY0dFx4+DC3UUp+SdcE9WW02bLSXp92GwPWWllj+hEvUVhxwLbgu?=
 =?us-ascii?q?BDiPtCGIkWvqtE?=
X-IPAS-Result: =?us-ascii?q?A2A8AQB83AZc/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopZksEMyeDeZQnUgaBCAgliR+OPoFmMgYBhEACgwoiNwYNAQMBAQEBAQECA?=
 =?us-ascii?q?WwcDII2JIJjAQUjBBFBEAsYAgISARMCAlcGDQYCAQGCXj8BgXQND6UHfDOBe?=
 =?us-ascii?q?INIhG2BC4sTF3iBB4E4DIJfgwUZAgKBOQ5gAoI6glcCiQ0Shlk3kBoJhwOBE?=
 =?us-ascii?q?oUxg3UGGIIojn6Nbog0hDEigVUrCAIYCCEPgycJgh4XfwEIgkKGcYQAIQMwg?=
 =?us-ascii?q?QUBAYgVAQ0XgicBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Dec 2018 20:02:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB4K2Z4a031001;
        Tue, 4 Dec 2018 15:02:35 -0500
Subject: Re: SELinux logging problem
To:     BMK <bmktuwien@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com
References: <CAFSQBhHFcRxUivx+wYRLyD4Z=6sZ4-3VsgtjRiG=+9crtOyTXA@mail.gmail.com>
 <01635e21-f143-d940-ceb1-b95079ddf23b@tycho.nsa.gov>
 <67ce07aa-d88a-5e1d-fa7d-66491ced1714@tycho.nsa.gov>
 <CAFSQBhHMG9cgda3KAo1y6pNWinkKvRAuwTNn6+d3j43Dphozew@mail.gmail.com>
 <b9924ce3-9039-94d3-71b4-709fdd218d94@tycho.nsa.gov>
 <CAFSQBhEXDy5RRXYqNM1Wn8naadrjS2MHO4qf5V=6U2a-AZzg8w@mail.gmail.com>
 <6b2bfc1a-0318-c049-e6e3-aa993d6282ee@tycho.nsa.gov>
 <CAFSQBhHDWSRQOHkQ28afbECzTqXpR_FFV9jo+Q7HKsAydgh5Zg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6370dbe2-616b-1854-8f6b-52692a426c7a@tycho.nsa.gov>
Date:   Tue, 4 Dec 2018 15:05:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAFSQBhHDWSRQOHkQ28afbECzTqXpR_FFV9jo+Q7HKsAydgh5Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/18 2:56 PM, BMK wrote:
> On Tue, Dec 4, 2018 at 8:40 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 12/4/18 2:01 PM, BMK wrote:
>>> On Tue, Dec 4, 2018 at 7:37 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>
>>>> On 12/4/18 1:00 PM, BMK wrote:
>>>>> On Tue, Dec 4, 2018 at 5:50 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>>
>>>>>> On 12/4/18 11:38 AM, Stephen Smalley wrote:
>>>>>>> On 12/4/18 11:03 AM, BMK wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> I am currently struggling with a strange SELinux problem,
>>>>>>>> for which I am not able to find an answer by reading the documentation
>>>>>>>> and researching online.
>>>>>>>>
>>>>>>>> The problem is, that some AVC denial log entries seem to get lost in
>>>>>>>> permissive mode,
>>>>>>>> in other words, they are not logged...
>>>>>>>> I've already deactivated all dont audit rules and I know for sure that
>>>>>>>> the denial actually occurs, because I can trace it via strace...
>>>>>>>> Although I can't see a corresponding entry in the audit.log.
>>>>>>>> By the way, in enforcing mode I can see suddenly the missing denial
>>>>>>>> entry...
>>>>>>>> If the permissive mode lacks/drops some denials which we can only see
>>>>>>>> in enforcing mode,
>>>>>>>> then this would be truly terrible for the policy writers...
>>>>>>>> Otherwise I am out of ideas, what other things could cause the loss of
>>>>>>>> SELinux denials...
>>>>>>>>
>>>>>>>> I hope you can point me to right direction with this matter and
>>>>>>>> I thank you in advance for your help.
>>>>>>>
>>>>>>> Permissive mode only logs the first instance of a denial by design to
>>>>>>> avoid flooding the logs with repeated instances of the same denial.  So
>>>>>>> if you triggered the denial a while ago and repeat the operation, you
>>>>>>> might not see the denial again.  To be precise, in permissive mode, upon
>>>>>>> the first denial of a permission, the permission is audited and then
>>>>>>> added to the AVC entry so that subsequent denials using that cache entry
>>>>>>> won't keep producing a denial. You can flush the cache to force denials
>>>>>>> to re-appear by reloading policy (load_policy) or by switching back and
>>>>>>> forth between permissive and enforcing mode (setenforce 1 && setenforce 0).
>>>>>>
>>>>>> NB Any semodule operation will also trigger a policy reload (unless you
>>>>>> specify -n or are acting on a policy other than the active one), so
>>>>>> semodule -DB would also have flushed the cache for you when it removed
>>>>>> all dontaudit rules.
>>>>>>
>>>>>>>
>>>>>>> If that doesn't explain the behavior you are seeing, then we can't
>>>>>>> really help without more information about the problem, e.g. the denial
>>>>>>> message you say is visible in enforcing mode but not permissive mode,
>>>>>>> your kernel version, possibly the strace output, a reproducer if you
>>>>>>> have one, what distro / policy you are using, etc.
>>>>>>>
>>>>>>> There are cases where the audit system could drop records due to OOM
>>>>>>> conditions, its ratelimit, or its backlog limit.  In those cases, you
>>>>>>> should have a audit: message logged indicating that messages were lost.
>>>>>>>      Check your dmesg or journalctl logs for such messages from the audit
>>>>>>> system.  Those are audit system issues rather than SELinux.  You can
>>>>>>> configure the limits via auditctl and/or the audit configuration.  But
>>>>>>> generally those only apply when the audit system is under heavy load
>>>>>>> from many denials (or many other audit messages) and you should see at
>>>>>>> least some of them.
>>>>>>
>>>>>
>>>>> Thank you for your quick reply!
>>>>>
>>>>> Let me give you a little bit more details about my setup.
>>>>> I am working on debian 9.4 release with kernel version 4.9.0-6-amd64.
>>>>> I have my own custom policy based on the refpolicy version
>>>>> RELEASE 2 20161023. (it is pretty old but I have to work with that
>>>>> specific version).
>>>>> I am currently building a monolithic policy with dontaudit rules disabled.
>>>>>
>>>>> Now here are the steps to reproduce the logging problem I described above.
>>>>> Let say, I have a test domain foo_t, which is defined roughly as follows:
>>>>>
>>>>> type foo_t;
>>>>> domain_type(foo_t)
>>>>> corecmd_exec_bin(foo_t)
>>>>>
>>>>> Then I login as unconfined_u user and run the following command:
>>>>>
>>>>> runcon -u system_u -r object_r -t foo_t -l s0 mkdir foobar
>>>>
>>>> object_r is only for objects (e.g. files) not for processes, so you
>>>> should never pass it to runcon.  system_r would make sense for a daemon,
>>>> or unconfined_r for a user program launched by an unconfined_u user.
>>>>
>>>
>>> Thank you for the tip, but I think it doesn't make difference for my
>>> actual problem.
>>>
>>>>>
>>>>> Note that unconfined_t and foo_t actually need little bit more rules to execute
>>>>> the runcon command above, but they are irrelevant for my case...
>>>>>
>>>>> The mkdir binary is selinux aware by which I mean that it loads
>>>>> the libselinux.so shared library.
>>>>> The libselinux library executes upon loading the following syscall:
>>>>> (see https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/init.c#L156)
>>>>>
>>>>> access(SELINUXCONFIG, F_OK)
>>>>>
>>>>> This call would need a search dir permission for selinux_config_t and since
>>>>> the domain foo_t doesn't have the permission I was expecting a denial log entry.
>>>>> But the AVC denial never shows up in the logs in permissive mode.
>>>>> I also tried to empty the logging cache by executing
>>>>> setenforce 1 && setenforce 0, which didn't help.
>>>>> However in enforcing mode the denial is logged as expected.
>>>>>
>>>>> Hope this helps to clarify my question a bit further...
>>>>
>>>> Hmm...this access would be covered by a dontaudit rule normally since
>>>> many programs that link with libselinux don't actually need to access
>>>> /etc/selinux/config.  And in your example above mkdir will work just
>>>> fine without ever using /etc/selinux/config, so it truly isn't needed.
>>>> Thus, silencing the denial is the right thing to do.
>>>>
>>>
>>> Yes, I am aware that mkdir still works but I chose it simply as an easily
>>> reproducible example where a search permission denial gets dropped
>>> in permissive mode...
>>>
>>>> I suspect that you aren't actually stripping dontaudit rules, or you
>>>> aren't loading the policy you built but instead are loading the one that
>>>> still has the dontaudit rules in place.
>>>>
>>>> sesearch will show you whether there is a dontaudit rule, e.g. sesearch
>>>> --dontaudit -s foo_t -t selinux_config_t.
>>>>
>>> Yes, I double checked it and then I even deleted the corresponding
>>> dontaudit rules
>>> manually from the refpolicy but unfortunately it didn't help.
>>> And as I said, the denial *shows up* in enforcing mode, so I think
>>> dontaudit rule isn't here
>>> the problem...
>>>
>>> As next step, I could try this out on other distros...
>>
>> Oh, I think I understand the cause.  The pathname resolution code was
>> split into two cases, a non-blocking rcu walk and a potentially blocking
>> ref walk.  In the rcu walk case, we cannot block, so slow_avc_audit()
>> bails out with ECHILD and the caller falls back to a refwalk where we
>> can safely block.  But we've already updated the cache entry with the
>> permission in the permissive case, so on the retry we don't audit it at
>> all.  That's a bug.  Interesting that no one has noticed it until now...
>>
>> To resolve, we need to propagate MAY_NOT_BLOCK down through
>> avc_has_perm_noaudit() -> avc_denied() and skip the avc_update_node()
>> call if it is set.  Then we'll never modify the cache entry under RCU
>> walk and see the denial on the ref walk.  I think.
>>
> 
> Ah, I see...
> Yeah, if it is a bug, then interesting, that no one noticed it until now...
> Do you think there is any workaround I could try
> to solve my problem?
> Can i somehow disable the caching in permissive mode?

No, I think your only options are to test in enforcing mode or patch 
your kernel.  It only affects the checks performed under RCU walk, 
namely reading symlinks and searching directories during pathname 
resolution; all other permission checks operate normally.

