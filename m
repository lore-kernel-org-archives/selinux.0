Return-Path: <SRS0=jgNJ=PX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F36FC43387
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 18:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5112520657
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 18:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfAOSqk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:46:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729764AbfAOSqj (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 15 Jan 2019 13:46:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6C9587621;
        Tue, 15 Jan 2019 18:46:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-166.rdu2.redhat.com [10.10.124.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FB5160FC8;
        Tue, 15 Jan 2019 18:46:38 +0000 (UTC)
Reply-To: dwalsh@redhat.com
Subject: Re: [PATCH v2] setsebool: support use of -P on SELinux-disabled hosts
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, jwcart2@tycho.nsa.gov
References: <20190110162624.29309-1-sds@tycho.nsa.gov>
 <pjda7k3fpbg.fsf@redhat.com>
 <e3bd22ec-4d3b-99a8-2910-e4b5db8333dc@tycho.nsa.gov>
 <pjdzhs1evrn.fsf@redhat.com>
 <6bbfbf92-f3a0-f197-46b2-acd64566f9e8@tycho.nsa.gov>
From:   Daniel Walsh <dwalsh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dwalsh@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFsaqOEBCADBSnZCZpi262vX8m7iL/OdHKP9G9dhS28FR60cjd8nMPqHDNhQJBjLMZra
 66L2cCIEhc4HEItail7KU1BckrMc4laFaxL8tLoVTKHZwb74n2OcAJ4FtgzkNNlB1XJvSwC/
 909uwt7cpDqwXpJvyP3t17iuklB1OY0EEjTDt9aU4+0QjHzV18L4Cpd9iQ4ksu+EHT+pjlBk
 DdQB+hKoAjxPl11Eh6pZfrAcrNWpYBBk0A3XE9Jb6ghbmHWltNgVOsCa9GcswJHUEeFiOup6
 J5DTv6Xzwt0t6QB8nIs+wDJH+VxqAXcrxscnAhViIfGGS2AtxzjnVOz/J+UZPaauIGXTABEB
 AAG0LERhbmllbCBKIFdhbHNoIChGb3IgR2l0KSA8ZHdhbHNoQHJlZGhhdC5jb20+iQE4BBMB
 AgAiBQJbGqjhAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCi35Adq+LAKHuJB/98
 nZB5RmNjMWua4Ms8q5a1R9XWlDAb3mrST6JeL+uV/M0fa18e2Aw4/hi/WZHjAjoypLmcuaRx
 GeCbC8iYdpfRDUG79Y956Qq+Vs8c6VfNDMY1mvtfb00eeTaYoOCu0Aa9LDeR9iLKh2g0RI+N
 Zr3EU45RxZdacIs1v6mU8pGpyUq/FvuTGK9GzR9d1YeVCuSpQKN4ckHNZHJUXyk0vOZft1oO
 nSgLqM9EDWA+yz1JLmRYwbNsim7IvfVOav5mCgnKzHcL2mLv8qCnMFZjoQV8aGny/W739Z3a
 YJo1CdOg6zSu5SOvmq9idYrBRkwEtyLXss2oceTVBs0MxqQ/9mLPuQENBFsaqOEBCADDl2hl
 bUpqJGgwt2eQvs0Z0DCx/7nn0hlLfEn4WAv2HqP25AjIRXUX31Mzu68C4QnsvNtY4zN+FGRC
 EfUpYsjiL7vBYlRePhIohyMYU4RLp5eXFQKahHO/9Xlhe8mwueQNwYxNBPfMQ65U2AuqxpcS
 scx4s5w208mhqHoKz6IB2LuKeflhYfH5Y1FNAtVGHfhg22xlcAdupPPcxGuS4fBEW6PD/SDf
 Y4HT5iUHsyksQKjM0IFalqZ7YuLfXBl07OD2zU7WI9c3W0dwkvwIRjt3aD4iAah544uOLff+
 BzfxWghXeo80S2a1WCL0S/2qR0NVct/ExaDWboYr/bKpTa/1ABEBAAGJAR8EGAECAAkFAlsa
 qOECGwwACgkQot+QHaviwCi2hgf/XRvrt+VBmp1ZFxQAR9E6S7AtRT8KSytjFiqEC7TpOx3r
 2OZ4gZ3ZiW4TMW8hS7aYRgF1uYpLzl7BbrCfCHfAWEcXZ+uG8vayg8G/mLAcNlLY+JE76ATs
 53ziEY9R2Vb/wLMFd2nNBdqfwGcRH9N9VOej9vP76nCP01ZolY8Nms2hE383/+1Quxp5EedU
 BN5W5l7x9riBJyqCA63hr4u8wNsTuQgrDyhm/U1IvYeLtMopgotjnIR3KiTKOElbppLeXW3w
 EO/sQTPk+vQ4vcsJYY9Dnf1NlvHE4klj60GHjtjitsBEHzdE7s+J9FOxPmt8l+gMogGumKpN
 Y4lO0pfTyg==
Organization: Red Hat
Message-ID: <b89294c7-bf19-00b2-49c6-bdd2bafcc89d@redhat.com>
Date:   Tue, 15 Jan 2019 13:46:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6bbfbf92-f3a0-f197-46b2-acd64566f9e8@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 15 Jan 2019 18:46:39 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/15/19 1:03 PM, Stephen Smalley wrote:
> On 1/15/19 11:22 AM, Petr Lautrbach wrote:
>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>
>>> On 1/14/19 6:31 AM, Petr Lautrbach wrote:
>>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>>
>>>>> As reported in #123, setsebool immediately exits with an error if
>>>>> SELinux is disabled, preventing its use for setting boolean
>>>>> persistent
>>>>> values.  In contrast, semanage boolean -m works on SELinux-disabled
>>>>> hosts.  Change setsebool so that it can be used with the -P option
>>>>> (persistent changes) even if SELinux is disabled.  In the
>>>>> SELinux-disabled
>>>>> case, skip setting of active boolean values, but set the
>>>>> persistent value
>>>>> in the policy store.  Policy reload is automatically disabled by
>>>>> libsemanage
>>>>> when SELinux is disabled, so we only need to call
>>>>> semanage_set_reload()
>>>>> if -N was used.
>>>>>
>>>>
>>>> So right now, `setsebool -N` and `semanage boolean -N` have the
>>>> same effect that
>>>> `load_policy` is not run, but the value of the boolean is changed when
>>>> SELinux is enabled so it affects the system. Would it make sense to
>>>> use
>>>> -N to just change values in the store and do not change the value
>>>> in the
>>>> running kernel? E.g.
>>>>
>>>> --- a/policycoreutils/setsebool/setsebool.c
>>>> +++ b/policycoreutils/setsebool/setsebool.c
>>>> @@ -187,11 +187,14 @@ static int semanage_set_boolean_list(size_t
>>>> boolcnt,
>>>>                                                     boolean) < 0)
>>>>                           goto err;
>>>>    -               if (enabled && semanage_bool_set_active(handle,
>>>> bool_key,
>>>> boolean) < 0) {
>>>> -                       fprintf(stderr, "Failed to change boolean
>>>> %s: %m\n",
>>>> -                               boollist[j].name);
>>>> -                       goto err;
>>>> -               }
>>>> +               if (no_reload)
>>>> +                       semanage_set_reload(handle, 0);
>>>> +               else
>>>> +                       if (enabled &&
>>>> semanage_bool_set_active(handle, bool_key, boolean) < 0) {
>>>> +                               fprintf(stderr, "Failed to change
>>>> boolean %s: %m\n",
>>>> +                                                              
>>>> boollist[j].name);
>>>> +                               goto err;
>>>> +                       }
>>>>
>>>>
>>>> A similar patch would need to be applied to seobject.py as well in
>>>> this case.
>>>
>>> That makes sense to me logically (in fact, I don't really understand
>>> why
>>> setsebool w/o -P would ever trigger a reload), but I guess the
>>> concern is
>>> whether any existing users rely on the current behavior, e.g. the %post
>>> scriptlet in container-selinux that led to this issue.
>>
>> container-selinux.spec:
>> ==========================================================================
>>
>> # Install all modules in a single transaction
>> if [ $1 -eq 1 ]; then
>>      %{_sbindir}/setsebool -P -N virt_use_nfs=1
>> virt_sandbox_use_all_caps=1
>> fi
>> ...
>> if %{_sbindir}/selinuxenabled ; then
>>      %{_sbindir}/load_policy
>>      %relabel_files
>>      if [ $1 -eq 1 ]; then
>>     restorecon -R %{_sharedstatedir}/docker &> /dev/null || :
>>     restorecon -R %{_sharedstatedir}/containers &> /dev/null || :
>>      fi
>> fi
>> ==========================================================================
>>
>>
>> It would definitely break this scriptlet on SELinux enabled systems as
>> load_policy preserves booleans.
>>
>> So the question is if it's preferred current behavior with it's side
>> effects or if it's worth to try to fix it and properly announce the
>> change in release notes.
>>
>> I take that it's not nice to change/break things but to me it
>> looks like -N generally considered as option which is used to avoid
>> changes in the running kernel.
>
> As documented in the man page, -N just means that "the policy on disk
> is not reloaded into the kernel.".  So from a compatibility and a
> documentation POV, I doubt we can just change this behavior now.
> Looking back at the original commit that added -N to setsebool
> (413b4933ee7203286050c2daf6f9714673cd3a5a) , it says " Fix setsebool
> to use -N to not reload policy into the kernel optional on permanant
> changes." which suggests that the intent was to only affect persistent
> boolean changes IIUC.  But cc'ing Dan for clarification.
Yes that was the intention. The goal was to work on disabled systems.
>
>>
>>
>>>
>>>>
>>>>
>>>>
>>>>> Fixes: https://github.com/SELinuxProject/selinux/issues/123
>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>> ---
>>>>> v2 changes setsebool to only call semanage_set_reload() if -N was
>>>>> specified;
>>>>> otherwise we can use the libsemanage defaults just as we do in
>>>>> semodule
>>>>> and semanage.
>>>>>    policycoreutils/setsebool/setsebool.c | 15 ++++++---------
>>>>>    1 file changed, 6 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/policycoreutils/setsebool/setsebool.c
>>>>> b/policycoreutils/setsebool/setsebool.c
>>>>> index 53d3566c..a5157efc 100644
>>>>> --- a/policycoreutils/setsebool/setsebool.c
>>>>> +++ b/policycoreutils/setsebool/setsebool.c
>>>>> @@ -18,7 +18,7 @@
>>>>>    #include <errno.h>
>>>>>      int permanent = 0;
>>>>> -int reload = 1;
>>>>> +int no_reload = 0;
>>>>>    int verbose = 0;
>>>>>      int setbool(char **list, size_t start, size_t end);
>>>>> @@ -38,11 +38,6 @@ int main(int argc, char **argv)
>>>>>        if (argc < 2)
>>>>>            usage();
>>>>>    -    if (is_selinux_enabled() <= 0) {
>>>>> -        fputs("setsebool:  SELinux is disabled.\n", stderr);
>>>>> -        return 1;
>>>>> -    }
>>>>> -
>>>>>        while (1) {
>>>>>            clflag = getopt(argc, argv, "PNV");
>>>>>            if (clflag == -1)
>>>>> @@ -53,7 +48,7 @@ int main(int argc, char **argv)
>>>>>                permanent = 1;
>>>>>                break;
>>>>>            case 'N':
>>>>> -            reload = 0;
>>>>> +            no_reload = 1;
>>>>>                break;
>>>>>            case 'V':
>>>>>                verbose = 1;
>>>>> @@ -130,6 +125,7 @@ static int semanage_set_boolean_list(size_t
>>>>> boolcnt,
>>>>>        semanage_bool_key_t *bool_key = NULL;
>>>>>        int managed;
>>>>>        int result;
>>>>> +    int enabled = is_selinux_enabled();
>>>>>          handle = semanage_handle_create();
>>>>>        if (handle == NULL) {
>>>>> @@ -191,7 +187,7 @@ static int semanage_set_boolean_list(size_t
>>>>> boolcnt,
>>>>>                              boolean) < 0)
>>>>>                goto err;
>>>>>    -        if (semanage_bool_set_active(handle, bool_key,
>>>>> boolean) < 0) {
>>>>> +        if (enabled && semanage_bool_set_active(handle, bool_key,
>>>>> boolean) < 0) {
>>>>>                fprintf(stderr, "Failed to change boolean %s: %m\n",
>>>>>                    boollist[j].name);
>>>>>                goto err;
>>>>> @@ -202,7 +198,8 @@ static int semanage_set_boolean_list(size_t
>>>>> boolcnt,
>>>>>            boolean = NULL;
>>>>>        }
>>>>>    -    semanage_set_reload(handle, reload);
>>>>> +    if (no_reload)
>>>>> +        semanage_set_reload(handle, 0);
>>>>>        if (semanage_commit(handle) < 0)
>>>>>            goto err;
>

