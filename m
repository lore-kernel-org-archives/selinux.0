Return-Path: <SRS0=jgNJ=PX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B5C43387
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 18:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F106620859
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 18:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="JmaJpGp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfAOSBh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:01:37 -0500
Received: from uphb19pa13.eemsg.mail.mil ([214.24.26.87]:48336 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731086AbfAOSBh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jan 2019 13:01:37 -0500
X-EEMSG-check-017: 158130063|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2019 18:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547575293; x=1579111293;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yrOxaqck2CWZ2NzWViMelYMZ/53Pwuhp09Ch8hw7vmw=;
  b=JmaJpGp00eE0ldYJeLHIYoeNI8x4dsdDROKHsTb/JlehUJ6T1AL9FxXJ
   52t8OkS6JM3K37dgnPrD2k8hMZhSbcPKLonzSm1OFzKOE+uKoNT/2z/KJ
   nhc2QLTuzL0CjQ/vr10EACrNeadfOn/d/nvpxW5WmV0HidB3Y1lTjW4dP
   ldq0wpYF9cgFV8a0i1CajxSktaET1zRSpkPX+xRdUohssjVUt+/2ufXgY
   NImI0GIr4voyWhxApdT0ZQqhHVeFC+b1vK4rxmPcTp81hmKq+qaO533uq
   D8BGIbs0w99IN8ilrmOIOuJe+a/E6y2S+TO4n/eKhs/UNjwMmLk0O01kd
   g==;
X-IronPort-AV: E=Sophos;i="5.56,481,1539648000"; 
   d="scan'208";a="19540168"
IronPort-PHdr: =?us-ascii?q?9a23=3AVq/vEBEOViEFEDVLns7aGZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7ypMWwAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQX?=
 =?us-ascii?q?dKUNhXWSJPH4iwa5IDA/cdMepdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03e?=
 =?us-ascii?q?suHgPJ0xAvEd8VrHTZrs/4OLsOXe27zqTFyyjIYfNM2Tf67YjFag0voe2SUr?=
 =?us-ascii?q?Joccre108vHB7YgFWVs4PlOzeV2foNsmOG6OdgTv+gi3U8pgFtojmg2scsio?=
 =?us-ascii?q?7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHpVXtyGfLYR2Q8UiTnlnuCY71r0GuY?=
 =?us-ascii?q?O7czMQxJs7wB7fbvqKeJWL7BL7TOudPDh1iX1/dL+/mhq+61asx+LiWsWuzV?=
 =?us-ascii?q?pHqDdOnMPWuXAXzRPT79CKSv56/ki8xzmCzxvT6uRYIUAskqrbNoIhzqYwlp?=
 =?us-ascii?q?UNtUTDGTf7mFnsg6+Md0Uk5/Oo5/77YrTmupCcN4h0hhv4MqsygcywHf40Mg?=
 =?us-ascii?q?0PX2if4ei81bvj8lPlQLhSk/E7nabUvIraKMgGvKK1HQBY3pg55xqiFzum1c?=
 =?us-ascii?q?4XnXgDLFJLYhKHiI3pNknVIP/lFveymEiskTd3yPDGOb3tGJPNLmPZn7v7cr?=
 =?us-ascii?q?Z97FBcxBIpzd9D/5JUFq0BIPXrV0/psNzXFAI5MxCuw+n8EtpwzZkeVnySDa?=
 =?us-ascii?q?+ZKqzSrUWE6f4oI+mJfIUVoiryK+A55/7yin80gUQdcret3ZsWbnC4A/tnLl?=
 =?us-ascii?q?6HYXrjnNgBC30GvgkgQ+zwjl2NTzpTa2y1X6Im6TExEJimApvbRoCxnLyB2z?=
 =?us-ascii?q?+2EYBYZ29cDlCMCnfoep6eW/gSdS2SItVukiAeWbe9TI8h0ELmiAiv87d7NK?=
 =?us-ascii?q?Lw8zAEr5jq39g9s/XXnAwu7zZ9J96Q32GEUyd/mWZeFBEs26UqmlBw0leO1+?=
 =?us-ascii?q?BDhvVcEdFCr6dSXhwSKY/Xz+s8Dcv7HA3GYIHaGx6dXty6DGRpHZoKyNgUbh?=
 =?us-ascii?q?M4Qoz6gw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BRAADzHj5c/wHyM5BjHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VopZoECJ4QBlAtMAQEBAQEBBoE1iS+OTYF7MAgBgz87RgKCQiI2Bw0BAwEBA?=
 =?us-ascii?q?QEBAQIBbBwMgjopAYJnAQUjFUEQCw4KAgImAgJXBg0GAgEBgl8/AYF0DQ+sa?=
 =?us-ascii?q?4EvhC4BgROEa4ELizQXeIEHgREngmuDHgKBYYMJglcCiTgaBoYjSThUkDUJh?=
 =?us-ascii?q?yCKZwYYgjGPT48JjTQOI4FWKwgCGAghDzuCbAmGAIVlhQwhAzCBBQEBiiYBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Jan 2019 18:01:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0FI1Viw005569;
        Tue, 15 Jan 2019 13:01:31 -0500
Subject: Re: [PATCH v2] setsebool: support use of -P on SELinux-disabled hosts
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, jwcart2@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
References: <20190110162624.29309-1-sds@tycho.nsa.gov>
 <pjda7k3fpbg.fsf@redhat.com>
 <e3bd22ec-4d3b-99a8-2910-e4b5db8333dc@tycho.nsa.gov>
 <pjdzhs1evrn.fsf@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6bbfbf92-f3a0-f197-46b2-acd64566f9e8@tycho.nsa.gov>
Date:   Tue, 15 Jan 2019 13:03:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <pjdzhs1evrn.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/15/19 11:22 AM, Petr Lautrbach wrote:
> Stephen Smalley <sds@tycho.nsa.gov> writes:
> 
>> On 1/14/19 6:31 AM, Petr Lautrbach wrote:
>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>
>>>> As reported in #123, setsebool immediately exits with an error if
>>>> SELinux is disabled, preventing its use for setting boolean persistent
>>>> values.  In contrast, semanage boolean -m works on SELinux-disabled
>>>> hosts.  Change setsebool so that it can be used with the -P option
>>>> (persistent changes) even if SELinux is disabled.  In the SELinux-disabled
>>>> case, skip setting of active boolean values, but set the persistent value
>>>> in the policy store.  Policy reload is automatically disabled by libsemanage
>>>> when SELinux is disabled, so we only need to call semanage_set_reload()
>>>> if -N was used.
>>>>
>>>
>>> So right now, `setsebool -N` and `semanage boolean -N` have the same effect that
>>> `load_policy` is not run, but the value of the boolean is changed when
>>> SELinux is enabled so it affects the system. Would it make sense to use
>>> -N to just change values in the store and do not change the value in the
>>> running kernel? E.g.
>>>
>>> --- a/policycoreutils/setsebool/setsebool.c
>>> +++ b/policycoreutils/setsebool/setsebool.c
>>> @@ -187,11 +187,14 @@ static int semanage_set_boolean_list(size_t boolcnt,
>>>                                                     boolean) < 0)
>>>                           goto err;
>>>    -               if (enabled && semanage_bool_set_active(handle, bool_key,
>>> boolean) < 0) {
>>> -                       fprintf(stderr, "Failed to change boolean %s: %m\n",
>>> -                               boollist[j].name);
>>> -                       goto err;
>>> -               }
>>> +               if (no_reload)
>>> +                       semanage_set_reload(handle, 0);
>>> +               else
>>> +                       if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
>>> +                               fprintf(stderr, "Failed to change boolean %s: %m\n",
>>> +                                                               boollist[j].name);
>>> +                               goto err;
>>> +                       }
>>>
>>>
>>> A similar patch would need to be applied to seobject.py as well in this case.
>>
>> That makes sense to me logically (in fact, I don't really understand why
>> setsebool w/o -P would ever trigger a reload), but I guess the concern is
>> whether any existing users rely on the current behavior, e.g. the %post
>> scriptlet in container-selinux that led to this issue.
> 
> container-selinux.spec:
> ==========================================================================
> # Install all modules in a single transaction
> if [ $1 -eq 1 ]; then
>      %{_sbindir}/setsebool -P -N virt_use_nfs=1 virt_sandbox_use_all_caps=1
> fi
> ...
> if %{_sbindir}/selinuxenabled ; then
>      %{_sbindir}/load_policy
>      %relabel_files
>      if [ $1 -eq 1 ]; then
> 	restorecon -R %{_sharedstatedir}/docker &> /dev/null || :
> 	restorecon -R %{_sharedstatedir}/containers &> /dev/null || :
>      fi
> fi
> ==========================================================================
> 
> It would definitely break this scriptlet on SELinux enabled systems as
> load_policy preserves booleans.
> 
> So the question is if it's preferred current behavior with it's side
> effects or if it's worth to try to fix it and properly announce the
> change in release notes.
> 
> I take that it's not nice to change/break things but to me it
> looks like -N generally considered as option which is used to avoid
> changes in the running kernel.

As documented in the man page, -N just means that "the policy on disk is 
not reloaded into the kernel.".  So from a compatibility and a 
documentation POV, I doubt we can just change this behavior now. 
Looking back at the original commit that added -N to setsebool 
(413b4933ee7203286050c2daf6f9714673cd3a5a) , it says " Fix setsebool to 
use -N to not reload policy into the kernel optional on permanant 
changes." which suggests that the intent was to only affect persistent 
boolean changes IIUC.  But cc'ing Dan for clarification.

> 
> 
>>
>>>
>>>
>>>
>>>> Fixes: https://github.com/SELinuxProject/selinux/issues/123
>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>> ---
>>>> v2 changes setsebool to only call semanage_set_reload() if -N was specified;
>>>> otherwise we can use the libsemanage defaults just as we do in semodule
>>>> and semanage.
>>>>    policycoreutils/setsebool/setsebool.c | 15 ++++++---------
>>>>    1 file changed, 6 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
>>>> index 53d3566c..a5157efc 100644
>>>> --- a/policycoreutils/setsebool/setsebool.c
>>>> +++ b/policycoreutils/setsebool/setsebool.c
>>>> @@ -18,7 +18,7 @@
>>>>    #include <errno.h>
>>>>      int permanent = 0;
>>>> -int reload = 1;
>>>> +int no_reload = 0;
>>>>    int verbose = 0;
>>>>      int setbool(char **list, size_t start, size_t end);
>>>> @@ -38,11 +38,6 @@ int main(int argc, char **argv)
>>>>    	if (argc < 2)
>>>>    		usage();
>>>>    -	if (is_selinux_enabled() <= 0) {
>>>> -		fputs("setsebool:  SELinux is disabled.\n", stderr);
>>>> -		return 1;
>>>> -	}
>>>> -
>>>>    	while (1) {
>>>>    		clflag = getopt(argc, argv, "PNV");
>>>>    		if (clflag == -1)
>>>> @@ -53,7 +48,7 @@ int main(int argc, char **argv)
>>>>    			permanent = 1;
>>>>    			break;
>>>>    		case 'N':
>>>> -			reload = 0;
>>>> +			no_reload = 1;
>>>>    			break;
>>>>    		case 'V':
>>>>    			verbose = 1;
>>>> @@ -130,6 +125,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
>>>>    	semanage_bool_key_t *bool_key = NULL;
>>>>    	int managed;
>>>>    	int result;
>>>> +	int enabled = is_selinux_enabled();
>>>>      	handle = semanage_handle_create();
>>>>    	if (handle == NULL) {
>>>> @@ -191,7 +187,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
>>>>    						  boolean) < 0)
>>>>    			goto err;
>>>>    -		if (semanage_bool_set_active(handle, bool_key, boolean) < 0) {
>>>> +		if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
>>>>    			fprintf(stderr, "Failed to change boolean %s: %m\n",
>>>>    				boollist[j].name);
>>>>    			goto err;
>>>> @@ -202,7 +198,8 @@ static int semanage_set_boolean_list(size_t boolcnt,
>>>>    		boolean = NULL;
>>>>    	}
>>>>    -	semanage_set_reload(handle, reload);
>>>> +	if (no_reload)
>>>> +		semanage_set_reload(handle, 0);
>>>>    	if (semanage_commit(handle) < 0)
>>>>    		goto err;

