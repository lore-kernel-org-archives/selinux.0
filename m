Return-Path: <SRS0=ZoZM=PZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B7C43387
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 13:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42D720652
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 13:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EsalYLGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfAQN6a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:58:30 -0500
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:64051 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfAQN6a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Jan 2019 08:58:30 -0500
X-EEMSG-check-017: 376076556|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2019 13:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547733504; x=1579269504;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mvZ+erTj4B4qCrBEPcnv1yu9TX4+ZAKICro6YXRo0+g=;
  b=EsalYLGajNfzOJKRSJrLqPCUolg+nVhmmDqvHGrXoerH9P5KXBUaMX4Y
   cfWEUypdbxOfpVXsqWgtIh5GnYA6QiK789p5GJxigycMuPTYMb+02hD6C
   YC6DHGsi1SWlwTcUaQDWpOtvLm7PHQKNGqgpTmrvQVqrh/hq9W2r0rJji
   HjLM7WhrEroULVC0DkqradpzcFBJfrvWwSZneTaYnIwYnN//2U4wO5/Yo
   NZJ8TtaLgOanoCNfQiIXooHqKMwMTLu4V+f66iYdQ2nV5qjN+F4f86GZM
   TKRDm4RNb47n7aa0/9RpqXCcRDFXl5+BumcgssUM3b/rWfs349MdvFZT4
   w==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539648000"; 
   d="scan'208";a="22783345"
IronPort-PHdr: =?us-ascii?q?9a23=3A9RaJGB2fpS9ysSz1smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMTIvad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcpcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98NqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1b9mkEJ5KuCGbMYt7WswiQ2B0uCY6170Joo?=
 =?us-ascii?q?S3czQNyJQiwRPUdv+Jc5CQ7x7+W+ucLi10iXJ4dL6lmRq//lasxvfhWsSyzV?=
 =?us-ascii?q?1EtDBKksPWuXAIzxHT78+HReZj8Uq5wjaP0hzT6vlDIUApiarXM54hzaA0lp?=
 =?us-ascii?q?oUqUnDAjX5mF/3jK+LbUUo4PSo6uT7bbXmoZ+QLYl0hR3lMqsygMC/BOU4Mg?=
 =?us-ascii?q?wWU2ia/+SzyqHj8FXkTLhFgfA6iKnUvI3AKcgFqaO1HRVZ3ps75xa6FTim0d?=
 =?us-ascii?q?AYnXcdLFJCfRKKl5PpNEzVIP3jEfe+g0ijkDdsx/zcOL3hGY/CImLMkLfmY7?=
 =?us-ascii?q?Zx81RcxxYrzdBD+5JUDakML+/9W0DrsNzYFR85Pheuw+n5Fdp91pkRWX6VDq?=
 =?us-ascii?q?CFN6PStEeC5vgzLOmUeI8VpDH9JuA95/7ql3A5hEMdfbOy0pQNc324BOppLF?=
 =?us-ascii?q?iZYXX2ntcNC3sFvg07TObykl2NTSZTZ2quX6I7/jw7E5ypDYPCRoCrnbyA0z?=
 =?us-ascii?q?y2HoNZZm9YEFCAC3ToeJueW/cKdi2SJtVtkjseVbiuGMcd0kSiqwb+0LpPNO?=
 =?us-ascii?q?fY+iQE85nk0Zw93+DPj1kW/CFoFc6U2GHFG3lwl34UXTU/9LpyrUx01hGI1q?=
 =?us-ascii?q?0u0NJCEtkG3O9ESgc3M9bnyuV+D93jElbacsyhVEetQtLgByo4CN023YldMA?=
 =?us-ascii?q?5GB9y+g0WbjGKRCLgPmunOXcVs/w=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AIAACoiEBc/wHyM5BjGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?wMBAQEBCwGBVQUpZk8zJ4QBk3xMAQEBAQEBBoE1iTCOToF7MAgBgz87RgKCV?=
 =?us-ascii?q?SI2Bw0BAwEBAQEBAQIBbBwMgjopAYJnAQUjDwEFQRAJAhgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBglMMPwGBdA0PjyCbYYEvhC4BgRSEcIELizQXeIEHgREngmuDHgKBYYMJg?=
 =?us-ascii?q?lcCiTwaBoYmgQJUkDgJhyKKawYYgjKPWYoAhRiNQw0kgVYrCAIYCCEPO4JsC?=
 =?us-ascii?q?YYAhWWFDCEDMIEFAQGKLAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Jan 2019 13:58:23 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0HDwNvq004381;
        Thu, 17 Jan 2019 08:58:23 -0500
Subject: Re: [PATCH v2] setsebool: support use of -P on SELinux-disabled hosts
To:     dwalsh@redhat.com, Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, jwcart2@tycho.nsa.gov
References: <20190110162624.29309-1-sds@tycho.nsa.gov>
 <pjda7k3fpbg.fsf@redhat.com>
 <e3bd22ec-4d3b-99a8-2910-e4b5db8333dc@tycho.nsa.gov>
 <pjdzhs1evrn.fsf@redhat.com>
 <6bbfbf92-f3a0-f197-46b2-acd64566f9e8@tycho.nsa.gov>
 <b89294c7-bf19-00b2-49c6-bdd2bafcc89d@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1952bc15-fc2b-fbee-2e9b-365c922ce8a7@tycho.nsa.gov>
Date:   Thu, 17 Jan 2019 09:00:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b89294c7-bf19-00b2-49c6-bdd2bafcc89d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/15/19 1:46 PM, Daniel Walsh wrote:
> On 1/15/19 1:03 PM, Stephen Smalley wrote:
>> On 1/15/19 11:22 AM, Petr Lautrbach wrote:
>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>
>>>> On 1/14/19 6:31 AM, Petr Lautrbach wrote:
>>>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>>>
>>>>>> As reported in #123, setsebool immediately exits with an error if
>>>>>> SELinux is disabled, preventing its use for setting boolean
>>>>>> persistent
>>>>>> values.  In contrast, semanage boolean -m works on SELinux-disabled
>>>>>> hosts.  Change setsebool so that it can be used with the -P option
>>>>>> (persistent changes) even if SELinux is disabled.  In the
>>>>>> SELinux-disabled
>>>>>> case, skip setting of active boolean values, but set the
>>>>>> persistent value
>>>>>> in the policy store.  Policy reload is automatically disabled by
>>>>>> libsemanage
>>>>>> when SELinux is disabled, so we only need to call
>>>>>> semanage_set_reload()
>>>>>> if -N was used.
>>>>>>
>>>>>
>>>>> So right now, `setsebool -N` and `semanage boolean -N` have the
>>>>> same effect that
>>>>> `load_policy` is not run, but the value of the boolean is changed when
>>>>> SELinux is enabled so it affects the system. Would it make sense to
>>>>> use
>>>>> -N to just change values in the store and do not change the value
>>>>> in the
>>>>> running kernel? E.g.
>>>>>
>>>>> --- a/policycoreutils/setsebool/setsebool.c
>>>>> +++ b/policycoreutils/setsebool/setsebool.c
>>>>> @@ -187,11 +187,14 @@ static int semanage_set_boolean_list(size_t
>>>>> boolcnt,
>>>>>                                                      boolean) < 0)
>>>>>                            goto err;
>>>>>     -               if (enabled && semanage_bool_set_active(handle,
>>>>> bool_key,
>>>>> boolean) < 0) {
>>>>> -                       fprintf(stderr, "Failed to change boolean
>>>>> %s: %m\n",
>>>>> -                               boollist[j].name);
>>>>> -                       goto err;
>>>>> -               }
>>>>> +               if (no_reload)
>>>>> +                       semanage_set_reload(handle, 0);
>>>>> +               else
>>>>> +                       if (enabled &&
>>>>> semanage_bool_set_active(handle, bool_key, boolean) < 0) {
>>>>> +                               fprintf(stderr, "Failed to change
>>>>> boolean %s: %m\n",
>>>>> +
>>>>> boollist[j].name);
>>>>> +                               goto err;
>>>>> +                       }
>>>>>
>>>>>
>>>>> A similar patch would need to be applied to seobject.py as well in
>>>>> this case.
>>>>
>>>> That makes sense to me logically (in fact, I don't really understand
>>>> why
>>>> setsebool w/o -P would ever trigger a reload), but I guess the
>>>> concern is
>>>> whether any existing users rely on the current behavior, e.g. the %post
>>>> scriptlet in container-selinux that led to this issue.
>>>
>>> container-selinux.spec:
>>> ==========================================================================
>>>
>>> # Install all modules in a single transaction
>>> if [ $1 -eq 1 ]; then
>>>       %{_sbindir}/setsebool -P -N virt_use_nfs=1
>>> virt_sandbox_use_all_caps=1
>>> fi
>>> ...
>>> if %{_sbindir}/selinuxenabled ; then
>>>       %{_sbindir}/load_policy
>>>       %relabel_files
>>>       if [ $1 -eq 1 ]; then
>>>      restorecon -R %{_sharedstatedir}/docker &> /dev/null || :
>>>      restorecon -R %{_sharedstatedir}/containers &> /dev/null || :
>>>       fi
>>> fi
>>> ==========================================================================
>>>
>>>
>>> It would definitely break this scriptlet on SELinux enabled systems as
>>> load_policy preserves booleans.
>>>
>>> So the question is if it's preferred current behavior with it's side
>>> effects or if it's worth to try to fix it and properly announce the
>>> change in release notes.
>>>
>>> I take that it's not nice to change/break things but to me it
>>> looks like -N generally considered as option which is used to avoid
>>> changes in the running kernel.
>>
>> As documented in the man page, -N just means that "the policy on disk
>> is not reloaded into the kernel.".  So from a compatibility and a
>> documentation POV, I doubt we can just change this behavior now.
>> Looking back at the original commit that added -N to setsebool
>> (413b4933ee7203286050c2daf6f9714673cd3a5a) , it says " Fix setsebool
>> to use -N to not reload policy into the kernel optional on permanant
>> changes." which suggests that the intent was to only affect persistent
>> boolean changes IIUC.  But cc'ing Dan for clarification.
> Yes that was the intention. The goal was to work on disabled systems.

Hmm...I don't quite understand that since libsemanage automatically 
disables policy reload if SELinux is disabled and since setsebool didn't 
work on SELinux-disabled systems prior to my patch (this thread).  I 
don't really understand the point of -N for setsebool.

In any event, my impression is that changing the semantics of -N to also 
suppress setting of active booleans would break the 
container-selinux.spec usage of setsebool and thus we probably shouldn't 
change it.

Any reason to not go ahead and merge my patch enabling use of setsebool 
-P on SELinux-disabled hosts?

>>
>>>
>>>
>>>>
>>>>>
>>>>>
>>>>>
>>>>>> Fixes: https://github.com/SELinuxProject/selinux/issues/123
>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>>> ---
>>>>>> v2 changes setsebool to only call semanage_set_reload() if -N was
>>>>>> specified;
>>>>>> otherwise we can use the libsemanage defaults just as we do in
>>>>>> semodule
>>>>>> and semanage.
>>>>>>     policycoreutils/setsebool/setsebool.c | 15 ++++++---------
>>>>>>     1 file changed, 6 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/policycoreutils/setsebool/setsebool.c
>>>>>> b/policycoreutils/setsebool/setsebool.c
>>>>>> index 53d3566c..a5157efc 100644
>>>>>> --- a/policycoreutils/setsebool/setsebool.c
>>>>>> +++ b/policycoreutils/setsebool/setsebool.c
>>>>>> @@ -18,7 +18,7 @@
>>>>>>     #include <errno.h>
>>>>>>       int permanent = 0;
>>>>>> -int reload = 1;
>>>>>> +int no_reload = 0;
>>>>>>     int verbose = 0;
>>>>>>       int setbool(char **list, size_t start, size_t end);
>>>>>> @@ -38,11 +38,6 @@ int main(int argc, char **argv)
>>>>>>         if (argc < 2)
>>>>>>             usage();
>>>>>>     -    if (is_selinux_enabled() <= 0) {
>>>>>> -        fputs("setsebool:  SELinux is disabled.\n", stderr);
>>>>>> -        return 1;
>>>>>> -    }
>>>>>> -
>>>>>>         while (1) {
>>>>>>             clflag = getopt(argc, argv, "PNV");
>>>>>>             if (clflag == -1)
>>>>>> @@ -53,7 +48,7 @@ int main(int argc, char **argv)
>>>>>>                 permanent = 1;
>>>>>>                 break;
>>>>>>             case 'N':
>>>>>> -            reload = 0;
>>>>>> +            no_reload = 1;
>>>>>>                 break;
>>>>>>             case 'V':
>>>>>>                 verbose = 1;
>>>>>> @@ -130,6 +125,7 @@ static int semanage_set_boolean_list(size_t
>>>>>> boolcnt,
>>>>>>         semanage_bool_key_t *bool_key = NULL;
>>>>>>         int managed;
>>>>>>         int result;
>>>>>> +    int enabled = is_selinux_enabled();
>>>>>>           handle = semanage_handle_create();
>>>>>>         if (handle == NULL) {
>>>>>> @@ -191,7 +187,7 @@ static int semanage_set_boolean_list(size_t
>>>>>> boolcnt,
>>>>>>                               boolean) < 0)
>>>>>>                 goto err;
>>>>>>     -        if (semanage_bool_set_active(handle, bool_key,
>>>>>> boolean) < 0) {
>>>>>> +        if (enabled && semanage_bool_set_active(handle, bool_key,
>>>>>> boolean) < 0) {
>>>>>>                 fprintf(stderr, "Failed to change boolean %s: %m\n",
>>>>>>                     boollist[j].name);
>>>>>>                 goto err;
>>>>>> @@ -202,7 +198,8 @@ static int semanage_set_boolean_list(size_t
>>>>>> boolcnt,
>>>>>>             boolean = NULL;
>>>>>>         }
>>>>>>     -    semanage_set_reload(handle, reload);
>>>>>> +    if (no_reload)
>>>>>> +        semanage_set_reload(handle, 0);
>>>>>>         if (semanage_commit(handle) < 0)
>>>>>>             goto err;
>>
> 
> 

