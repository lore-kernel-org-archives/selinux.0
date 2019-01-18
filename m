Return-Path: <SRS0=8zWZ=P2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409DBC43387
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 16:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02B020850
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 16:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gXXlRlvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfARQLy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:11:54 -0500
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:1551 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfARQLy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jan 2019 11:11:54 -0500
X-EEMSG-check-017: 182692212|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Jan 2019 16:11:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547827905; x=1579363905;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ObsVYSxZ2G4Wwr2f5vneXwGB8tVgNppEfAfHJleQHNc=;
  b=gXXlRlvPehwFEW6wgUy1VWBi419yywxbnoRNmykSOmg1xfBFf71l4EN5
   Tn9g2ZNgVjay4GjBSprRD6WWeiKox3TcCxmiC061aoBd5BlGKtEVzZgAY
   oy1I0Id1ZSVgs0ZyFkQqmiTyK5DbPpIib1S1/MwG/PD0K06GI2oxmzB1+
   gsTjOrH6kLtAW/+7/pNNH8u8gLVA6Hq6+A/WlpK2q9ZVD+888dSgbquam
   R6ftDFqZnPx4RHN/YEZpJvd4VYDFLBFi//PpxJZxavGep9N/VhQa/k6FS
   79gcfpps+xXbyZ7Ryuzmo8mWDOvMrH850ivwcFEqAeiApewGWinYWgZZy
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,491,1539648000"; 
   d="scan'208";a="19666736"
IronPort-PHdr: =?us-ascii?q?9a23=3APWjG4R/bAkWRJf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21uIcTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMNboRr4oRz?=
 =?us-ascii?q?ut86ZrSAfpiCgZMT457HrXgdF0gK5CvR6tuwBzz4vSbY6bLvp+er7Wc80cS2?=
 =?us-ascii?q?RPQ81dUzVNDp6gY4cKCecKIORWoJTnp1YWsBWwGwesCuPsxDFGiHD50q813P?=
 =?us-ascii?q?guHwzdwAwtHMgDvGjIoNj7NqofV/2+wqnSzTXEavNbwSrz6JTWfRA5ofGDQ7?=
 =?us-ascii?q?RwetfMx0kqDQzFilGQppLlPjiI0ekNqHWU7/F7WOKzi28otwFxoj+1yscqkY?=
 =?us-ascii?q?nGnJgZyl/D9SVn2Ys4I8CzRkB8Yd6hCpRQtieaOpN5QsMjX2FouDs6xaYctZ?=
 =?us-ascii?q?GneygKzZIqzAPcZfyfa4WE/x3uWemLLTp4mX5pYqyzihms/US61+HxUNS/3k?=
 =?us-ascii?q?xQoSpfiNbMs2gA1xnU6seaVPRw5lyh2TOT1wDL7eFEPFw0mbLbK5E/xr4wkY?=
 =?us-ascii?q?IesVjZES/smUX2kbSWel84+umo9+vnYrLmqoWaN4BokQHxLr4imsm+AeQ8Kg?=
 =?us-ascii?q?QOXm6b9vqg1LD74EH0T7pHguc2n6XEqpzWO8sWqrCjDwNIyooj7gywDzai0N?=
 =?us-ascii?q?QWh3kHK1dFdQqcj4f0IFHDO+z4DPejjFSslzdn3fbGPqb7DZnXIXjDl6nhca?=
 =?us-ascii?q?5n60FA0Aoz0cxf55VMB74cLvP8QEvxtMfYDhIiKQy73fvoCNVn2YMCQ26AHq?=
 =?us-ascii?q?iZMKbKu1+S+u0vO/WMZJMSuDvlM/gl4+ThjWIlmV8HZqamx4AaaGqmEft7I0?=
 =?us-ascii?q?WWe2bsjs0dHmcNuwo0VPbqh0GaUT5Pe3ayWLox5iolB4KiDIfDQJ2tgbOa0S?=
 =?us-ascii?q?elEZ1ZeHpGBkqPEXj2bYWEXekDaCaILs9miDwEWuvpd4h02Q6nsBT646BqIu?=
 =?us-ascii?q?rd5msTspennOB4+/ebsRgv6SZ+Bs+dmzWVS2hpgnkCThcs0ax/qFA7wVCGh/?=
 =?us-ascii?q?tWmftdQOdP6utJXwFyDpvVy+h3GpimQQ7aVsuYQ1ahBNO9CHc+ScxnkIxGWF?=
 =?us-ascii?q?p0B9j31kOL5CGtGbJA0uXSXJE=3D?=
X-IPAS-Result: =?us-ascii?q?A2BNAAA0+kFc/wHyM5BkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VopZoECJ4QBlANPAQEBBoEICCWJM45OgXswCAGDPztGAoJcIjYHDQEDAQEBA?=
 =?us-ascii?q?QEBAgFsHAyCOikBgmcBBSMPAQVBEAkCGAICJgICVwYBDAYCAQGCUww/AYF0D?=
 =?us-ascii?q?Q+PbpthgS+ELgGBFIR3gQuLNhd4gQeBEScMgl+DHgKBYYMJglcCiUEaBoYpg?=
 =?us-ascii?q?QJWkD4JhySKcQYYgjSPYIoEhRyNSg0kgVYrCAIYCCEPO4JsCYYAhWWFDCEDM?=
 =?us-ascii?q?IEFAQGJDQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Jan 2019 16:11:44 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0IGBh9b006411;
        Fri, 18 Jan 2019 11:11:43 -0500
Subject: Re: [PATCH v2] setsebool: support use of -P on SELinux-disabled hosts
To:     dwalsh@redhat.com, Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, jwcart2@tycho.nsa.gov
References: <20190110162624.29309-1-sds@tycho.nsa.gov>
 <pjda7k3fpbg.fsf@redhat.com>
 <e3bd22ec-4d3b-99a8-2910-e4b5db8333dc@tycho.nsa.gov>
 <pjdzhs1evrn.fsf@redhat.com>
 <6bbfbf92-f3a0-f197-46b2-acd64566f9e8@tycho.nsa.gov>
 <b89294c7-bf19-00b2-49c6-bdd2bafcc89d@redhat.com>
 <1952bc15-fc2b-fbee-2e9b-365c922ce8a7@tycho.nsa.gov>
 <1298897a-8cbd-6b62-12d4-964898ecdbf9@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <93cd8b7f-1196-12ef-10be-783703d9611e@tycho.nsa.gov>
Date:   Fri, 18 Jan 2019 11:13:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1298897a-8cbd-6b62-12d4-964898ecdbf9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/19 10:10 AM, Daniel Walsh wrote:
> On 1/17/19 9:00 AM, Stephen Smalley wrote:
>> On 1/15/19 1:46 PM, Daniel Walsh wrote:
>>> On 1/15/19 1:03 PM, Stephen Smalley wrote:
>>>> On 1/15/19 11:22 AM, Petr Lautrbach wrote:
>>>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>>>
>>>>>> On 1/14/19 6:31 AM, Petr Lautrbach wrote:
>>>>>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>>>>>
>>>>>>>> As reported in #123, setsebool immediately exits with an error if
>>>>>>>> SELinux is disabled, preventing its use for setting boolean
>>>>>>>> persistent
>>>>>>>> values.  In contrast, semanage boolean -m works on SELinux-disabled
>>>>>>>> hosts.  Change setsebool so that it can be used with the -P option
>>>>>>>> (persistent changes) even if SELinux is disabled.  In the
>>>>>>>> SELinux-disabled
>>>>>>>> case, skip setting of active boolean values, but set the
>>>>>>>> persistent value
>>>>>>>> in the policy store.  Policy reload is automatically disabled by
>>>>>>>> libsemanage
>>>>>>>> when SELinux is disabled, so we only need to call
>>>>>>>> semanage_set_reload()
>>>>>>>> if -N was used.
>>>>>>>>
>>>>>>>
>>>>>>> So right now, `setsebool -N` and `semanage boolean -N` have the
>>>>>>> same effect that
>>>>>>> `load_policy` is not run, but the value of the boolean is changed
>>>>>>> when
>>>>>>> SELinux is enabled so it affects the system. Would it make sense to
>>>>>>> use
>>>>>>> -N to just change values in the store and do not change the value
>>>>>>> in the
>>>>>>> running kernel? E.g.
>>>>>>>
>>>>>>> --- a/policycoreutils/setsebool/setsebool.c
>>>>>>> +++ b/policycoreutils/setsebool/setsebool.c
>>>>>>> @@ -187,11 +187,14 @@ static int semanage_set_boolean_list(size_t
>>>>>>> boolcnt,
>>>>>>>                                                       boolean) < 0)
>>>>>>>                             goto err;
>>>>>>>      -               if (enabled && semanage_bool_set_active(handle,
>>>>>>> bool_key,
>>>>>>> boolean) < 0) {
>>>>>>> -                       fprintf(stderr, "Failed to change boolean
>>>>>>> %s: %m\n",
>>>>>>> -                               boollist[j].name);
>>>>>>> -                       goto err;
>>>>>>> -               }
>>>>>>> +               if (no_reload)
>>>>>>> +                       semanage_set_reload(handle, 0);
>>>>>>> +               else
>>>>>>> +                       if (enabled &&
>>>>>>> semanage_bool_set_active(handle, bool_key, boolean) < 0) {
>>>>>>> +                               fprintf(stderr, "Failed to change
>>>>>>> boolean %s: %m\n",
>>>>>>> +
>>>>>>> boollist[j].name);
>>>>>>> +                               goto err;
>>>>>>> +                       }
>>>>>>>
>>>>>>>
>>>>>>> A similar patch would need to be applied to seobject.py as well in
>>>>>>> this case.
>>>>>>
>>>>>> That makes sense to me logically (in fact, I don't really understand
>>>>>> why
>>>>>> setsebool w/o -P would ever trigger a reload), but I guess the
>>>>>> concern is
>>>>>> whether any existing users rely on the current behavior, e.g. the
>>>>>> %post
>>>>>> scriptlet in container-selinux that led to this issue.
>>>>>
>>>>> container-selinux.spec:
>>>>> ==========================================================================
>>>>>
>>>>>
>>>>> # Install all modules in a single transaction
>>>>> if [ $1 -eq 1 ]; then
>>>>>        %{_sbindir}/setsebool -P -N virt_use_nfs=1
>>>>> virt_sandbox_use_all_caps=1
>>>>> fi
>>>>> ...
>>>>> if %{_sbindir}/selinuxenabled ; then
>>>>>        %{_sbindir}/load_policy
>>>>>        %relabel_files
>>>>>        if [ $1 -eq 1 ]; then
>>>>>       restorecon -R %{_sharedstatedir}/docker &> /dev/null || :
>>>>>       restorecon -R %{_sharedstatedir}/containers &> /dev/null || :
>>>>>        fi
>>>>> fi
>>>>> ==========================================================================
>>>>>
>>>>>
>>>>>
>>>>> It would definitely break this scriptlet on SELinux enabled systems as
>>>>> load_policy preserves booleans.
>>>>>
>>>>> So the question is if it's preferred current behavior with it's side
>>>>> effects or if it's worth to try to fix it and properly announce the
>>>>> change in release notes.
>>>>>
>>>>> I take that it's not nice to change/break things but to me it
>>>>> looks like -N generally considered as option which is used to avoid
>>>>> changes in the running kernel.
>>>>
>>>> As documented in the man page, -N just means that "the policy on disk
>>>> is not reloaded into the kernel.".  So from a compatibility and a
>>>> documentation POV, I doubt we can just change this behavior now.
>>>> Looking back at the original commit that added -N to setsebool
>>>> (413b4933ee7203286050c2daf6f9714673cd3a5a) , it says " Fix setsebool
>>>> to use -N to not reload policy into the kernel optional on permanant
>>>> changes." which suggests that the intent was to only affect persistent
>>>> boolean changes IIUC.  But cc'ing Dan for clarification.
>>> Yes that was the intention. The goal was to work on disabled systems.
>>
>> Hmm...I don't quite understand that since libsemanage automatically
>> disables policy reload if SELinux is disabled and since setsebool
>> didn't work on SELinux-disabled systems prior to my patch (this
>> thread).  I don't really understand the point of -N for setsebool.
>>
>> In any event, my impression is that changing the semantics of -N to
>> also suppress setting of active booleans would break the
>> container-selinux.spec usage of setsebool and thus we probably
>> shouldn't change it.
>>
>> Any reason to not go ahead and merge my patch enabling use of
>> setsebool -P on SELinux-disabled hosts?
>>
> Nope, I think you can merge it.

FYI, I merged this via
https://github.com/SELinuxProject/selinux/pull/129

>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> Fixes: https://github.com/SELinuxProject/selinux/issues/123
>>>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>>>>> ---
>>>>>>>> v2 changes setsebool to only call semanage_set_reload() if -N was
>>>>>>>> specified;
>>>>>>>> otherwise we can use the libsemanage defaults just as we do in
>>>>>>>> semodule
>>>>>>>> and semanage.
>>>>>>>>      policycoreutils/setsebool/setsebool.c | 15 ++++++---------
>>>>>>>>      1 file changed, 6 insertions(+), 9 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/policycoreutils/setsebool/setsebool.c
>>>>>>>> b/policycoreutils/setsebool/setsebool.c
>>>>>>>> index 53d3566c..a5157efc 100644
>>>>>>>> --- a/policycoreutils/setsebool/setsebool.c
>>>>>>>> +++ b/policycoreutils/setsebool/setsebool.c
>>>>>>>> @@ -18,7 +18,7 @@
>>>>>>>>      #include <errno.h>
>>>>>>>>        int permanent = 0;
>>>>>>>> -int reload = 1;
>>>>>>>> +int no_reload = 0;
>>>>>>>>      int verbose = 0;
>>>>>>>>        int setbool(char **list, size_t start, size_t end);
>>>>>>>> @@ -38,11 +38,6 @@ int main(int argc, char **argv)
>>>>>>>>          if (argc < 2)
>>>>>>>>              usage();
>>>>>>>>      -    if (is_selinux_enabled() <= 0) {
>>>>>>>> -        fputs("setsebool:  SELinux is disabled.\n", stderr);
>>>>>>>> -        return 1;
>>>>>>>> -    }
>>>>>>>> -
>>>>>>>>          while (1) {
>>>>>>>>              clflag = getopt(argc, argv, "PNV");
>>>>>>>>              if (clflag == -1)
>>>>>>>> @@ -53,7 +48,7 @@ int main(int argc, char **argv)
>>>>>>>>                  permanent = 1;
>>>>>>>>                  break;
>>>>>>>>              case 'N':
>>>>>>>> -            reload = 0;
>>>>>>>> +            no_reload = 1;
>>>>>>>>                  break;
>>>>>>>>              case 'V':
>>>>>>>>                  verbose = 1;
>>>>>>>> @@ -130,6 +125,7 @@ static int semanage_set_boolean_list(size_t
>>>>>>>> boolcnt,
>>>>>>>>          semanage_bool_key_t *bool_key = NULL;
>>>>>>>>          int managed;
>>>>>>>>          int result;
>>>>>>>> +    int enabled = is_selinux_enabled();
>>>>>>>>            handle = semanage_handle_create();
>>>>>>>>          if (handle == NULL) {
>>>>>>>> @@ -191,7 +187,7 @@ static int semanage_set_boolean_list(size_t
>>>>>>>> boolcnt,
>>>>>>>>                                boolean) < 0)
>>>>>>>>                  goto err;
>>>>>>>>      -        if (semanage_bool_set_active(handle, bool_key,
>>>>>>>> boolean) < 0) {
>>>>>>>> +        if (enabled && semanage_bool_set_active(handle, bool_key,
>>>>>>>> boolean) < 0) {
>>>>>>>>                  fprintf(stderr, "Failed to change boolean %s:
>>>>>>>> %m\n",
>>>>>>>>                      boollist[j].name);
>>>>>>>>                  goto err;
>>>>>>>> @@ -202,7 +198,8 @@ static int semanage_set_boolean_list(size_t
>>>>>>>> boolcnt,
>>>>>>>>              boolean = NULL;
>>>>>>>>          }
>>>>>>>>      -    semanage_set_reload(handle, reload);
>>>>>>>> +    if (no_reload)
>>>>>>>> +        semanage_set_reload(handle, 0);
>>>>>>>>          if (semanage_commit(handle) < 0)
>>>>>>>>              goto err;
>>>>
>>>
>>>
>>
> 
> 

