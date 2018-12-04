Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367EAC07E85
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C2A20672
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C2A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeLDShL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:37:11 -0500
Received: from uhil19pa13.eemsg.mail.mil ([214.24.21.86]:25679 "EHLO
        uhil19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeLDShK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 13:37:10 -0500
X-EEMSG-check-008: 349906479|UHIL19PA13_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2018 18:37:07 +0000
X-IronPort-AV: E=Sophos;i="5.56,315,1539648000"; 
   d="scan'208";a="18415621"
IronPort-PHdr: =?us-ascii?q?9a23=3AKA32nBRdjQqZsj2FMDrYLewmwdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yYRWN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4KlxSB/slSwJKTg3/m/KgcB0la5XvQ6tqxl5zoXJYo+aKeB+c7vAc90ES2?=
 =?us-ascii?q?pPXsVfWSJPDYyzbYQAE+UPMP1Er4T/vVYCsQeyCAeuCe7p1zRGhmX23ao/0+?=
 =?us-ascii?q?k5DA/GwBIvH8oOsHvKqtX+KbocUeWvw6nMyTXMcfNX0ir65YjTbx8huuqBXa?=
 =?us-ascii?q?5wcMXNyUkvEBnJjlOLqYP/JT+V2eMNs3aC4udmSOmhhWknqwRrrTiuwMchko?=
 =?us-ascii?q?3JhoUaylze7ip4wJ45JdK5SE5nYd6kDYBfuzuGOItxR8MvRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lo?=
 =?us-ascii?q?YTsEvfHi/2n1/6jKmKeUU/5uek8eHnYrTippOENo90jB/xMrg2l8CiDuk1PR?=
 =?us-ascii?q?ICUmiG9eimyrHu8lP1TK9XgvEul6nWqpHaJcAVpq6jBA9V154u6w2iADe9y9?=
 =?us-ascii?q?kYgXkGI05FeBKAlYTpPUrOL+riAfewhFSsji9nx+raMb35HpXNMn/Dna/6cr?=
 =?us-ascii?q?Z46E5c1BczzN5e551KDLEMO/3zWkrru9zZCh81KRC7w+HiCN9lzIMRRXqPAr?=
 =?us-ascii?q?OFMKPVqVKI/fwgI+2NZI8TpTb8JOMo5+DhjXAng18RZ6qp0oUNaHC+APtmJ1?=
 =?us-ascii?q?+VYX32gtcOQi82uV8Uac+i3FeHUiJOeHe/WYoz4zg6DMStCoKVFa63h7nU5z?=
 =?us-ascii?q?u2Bp1bYCh9D1mIFXr5P9GfV+wkdDOZIsgnlCcNE7emVdlyhlmVqAbmxu8/fa?=
 =?us-ascii?q?Lv8SoCuMemjYB4?=
X-IPAS-Result: =?us-ascii?q?A2BlAwB6yAZc/wHyM5BlHAEBAQQBAQcEAQGBZYFbKWaBA?=
 =?us-ascii?q?ieDeZR0AQEBAQEBBoEICCWJH44+gWYyBgGEQAKDCiI4EgEDAQEBAQEBAgFsH?=
 =?us-ascii?q?AyCNiSCYgEBAQECASMVQRALGAICEgETAgJXBg0GAgEBgl4/AYF0BQgPpQCBL?=
 =?us-ascii?q?4F4g0iEcIELixMXeIEHgTgMgl+DBRkCAoE5DmACgjqCVwKJDRKGWTeQGgmHA?=
 =?us-ascii?q?4EShTGDdQYYgiiOfo1uiDSEMiGBVSsIAhgIIQ+DJwmDNAEIgkKGcYQAIQMwg?=
 =?us-ascii?q?QUBAYgWAQ0XgicBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Dec 2018 18:37:05 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB4Ib57A020588;
        Tue, 4 Dec 2018 13:37:05 -0500
Subject: Re: SELinux logging problem
To:     BMK <bmktuwien@gmail.com>
Cc:     selinux@vger.kernel.org
References: <CAFSQBhHFcRxUivx+wYRLyD4Z=6sZ4-3VsgtjRiG=+9crtOyTXA@mail.gmail.com>
 <01635e21-f143-d940-ceb1-b95079ddf23b@tycho.nsa.gov>
 <67ce07aa-d88a-5e1d-fa7d-66491ced1714@tycho.nsa.gov>
 <CAFSQBhHMG9cgda3KAo1y6pNWinkKvRAuwTNn6+d3j43Dphozew@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b9924ce3-9039-94d3-71b4-709fdd218d94@tycho.nsa.gov>
Date:   Tue, 4 Dec 2018 13:39:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAFSQBhHMG9cgda3KAo1y6pNWinkKvRAuwTNn6+d3j43Dphozew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/18 1:00 PM, BMK wrote:
> On Tue, Dec 4, 2018 at 5:50 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 12/4/18 11:38 AM, Stephen Smalley wrote:
>>> On 12/4/18 11:03 AM, BMK wrote:
>>>> Hello,
>>>>
>>>> I am currently struggling with a strange SELinux problem,
>>>> for which I am not able to find an answer by reading the documentation
>>>> and researching online.
>>>>
>>>> The problem is, that some AVC denial log entries seem to get lost in
>>>> permissive mode,
>>>> in other words, they are not logged...
>>>> I've already deactivated all dont audit rules and I know for sure that
>>>> the denial actually occurs, because I can trace it via strace...
>>>> Although I can't see a corresponding entry in the audit.log.
>>>> By the way, in enforcing mode I can see suddenly the missing denial
>>>> entry...
>>>> If the permissive mode lacks/drops some denials which we can only see
>>>> in enforcing mode,
>>>> then this would be truly terrible for the policy writers...
>>>> Otherwise I am out of ideas, what other things could cause the loss of
>>>> SELinux denials...
>>>>
>>>> I hope you can point me to right direction with this matter and
>>>> I thank you in advance for your help.
>>>
>>> Permissive mode only logs the first instance of a denial by design to
>>> avoid flooding the logs with repeated instances of the same denial.  So
>>> if you triggered the denial a while ago and repeat the operation, you
>>> might not see the denial again.  To be precise, in permissive mode, upon
>>> the first denial of a permission, the permission is audited and then
>>> added to the AVC entry so that subsequent denials using that cache entry
>>> won't keep producing a denial. You can flush the cache to force denials
>>> to re-appear by reloading policy (load_policy) or by switching back and
>>> forth between permissive and enforcing mode (setenforce 1 && setenforce 0).
>>
>> NB Any semodule operation will also trigger a policy reload (unless you
>> specify -n or are acting on a policy other than the active one), so
>> semodule -DB would also have flushed the cache for you when it removed
>> all dontaudit rules.
>>
>>>
>>> If that doesn't explain the behavior you are seeing, then we can't
>>> really help without more information about the problem, e.g. the denial
>>> message you say is visible in enforcing mode but not permissive mode,
>>> your kernel version, possibly the strace output, a reproducer if you
>>> have one, what distro / policy you are using, etc.
>>>
>>> There are cases where the audit system could drop records due to OOM
>>> conditions, its ratelimit, or its backlog limit.  In those cases, you
>>> should have a audit: message logged indicating that messages were lost.
>>>    Check your dmesg or journalctl logs for such messages from the audit
>>> system.  Those are audit system issues rather than SELinux.  You can
>>> configure the limits via auditctl and/or the audit configuration.  But
>>> generally those only apply when the audit system is under heavy load
>>> from many denials (or many other audit messages) and you should see at
>>> least some of them.
>>
> 
> Thank you for your quick reply!
> 
> Let me give you a little bit more details about my setup.
> I am working on debian 9.4 release with kernel version 4.9.0-6-amd64.
> I have my own custom policy based on the refpolicy version
> RELEASE 2 20161023. (it is pretty old but I have to work with that
> specific version).
> I am currently building a monolithic policy with dontaudit rules disabled.
> 
> Now here are the steps to reproduce the logging problem I described above.
> Let say, I have a test domain foo_t, which is defined roughly as follows:
> 
> type foo_t;
> domain_type(foo_t)
> corecmd_exec_bin(foo_t)
> 
> Then I login as unconfined_u user and run the following command:
> 
> runcon -u system_u -r object_r -t foo_t -l s0 mkdir foobar

object_r is only for objects (e.g. files) not for processes, so you 
should never pass it to runcon.  system_r would make sense for a daemon, 
or unconfined_r for a user program launched by an unconfined_u user.

> 
> Note that unconfined_t and foo_t actually need little bit more rules to execute
> the runcon command above, but they are irrelevant for my case...
> 
> The mkdir binary is selinux aware by which I mean that it loads
> the libselinux.so shared library.
> The libselinux library executes upon loading the following syscall:
> (see https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/init.c#L156)
> 
> access(SELINUXCONFIG, F_OK)
> 
> This call would need a search dir permission for selinux_config_t and since
> the domain foo_t doesn't have the permission I was expecting a denial log entry.
> But the AVC denial never shows up in the logs in permissive mode.
> I also tried to empty the logging cache by executing
> setenforce 1 && setenforce 0, which didn't help.
> However in enforcing mode the denial is logged as expected.
> 
> Hope this helps to clarify my question a bit further...

Hmm...this access would be covered by a dontaudit rule normally since 
many programs that link with libselinux don't actually need to access 
/etc/selinux/config.  And in your example above mkdir will work just 
fine without ever using /etc/selinux/config, so it truly isn't needed. 
Thus, silencing the denial is the right thing to do.

I suspect that you aren't actually stripping dontaudit rules, or you 
aren't loading the policy you built but instead are loading the one that 
still has the dontaudit rules in place.

sesearch will show you whether there is a dontaudit rule, e.g. sesearch 
--dontaudit -s foo_t -t selinux_config_t.


sesearch -
