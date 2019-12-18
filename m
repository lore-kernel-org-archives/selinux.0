Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C91C2D0BF
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5D52176D
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="p5vDSCxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfLRUue (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:50:34 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:2375 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRUue (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 15:50:34 -0500
X-EEMSG-check-017: 62289349|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="62289349"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 20:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576702233; x=1608238233;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TXNkffQ2Q7PMkXY+IUFoZWxKyeAVPAhP6xWuzQHzd84=;
  b=p5vDSCxXmOssDDOpoOeZ402C/8KAIf0m9bgkzNP7qht6sx2XLjwPnjIV
   j4av7axe81i8S1K9PFh9TYFhQJ41cHBZVMy/rZpqHmn1SVFuGYZPxAfdO
   LOVn4EewKxLqn6BHzjpnX3FHqzUeCDBkvu5gueicbmloPUuFxOgDS3eiz
   LNPI+zkNS4yU/04+gewDvAIx0c36auRZqyUB7BWA5viVRDg/yCeCvNOe7
   B9LJIcsp4WcregfvlHn59srOADVdcSbV6VCYuT05WlMu/S0AYTF1QqeuJ
   fkvunLKi3Mrm8w53M3pJrfxYiiJBZAibXz/v6klV1I+byszM4O/Xr9+k4
   w==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="31256595"
IronPort-PHdr: =?us-ascii?q?9a23=3AuegeKB9xRSci//9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1+0SIJqq85mqBkHD//Il1AaPAdyAragc2qGP6P+ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBmqqQjdudQajIVgJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvkUCoB+7CQSqGejhyCJHhmXu0KMn0+?=
 =?us-ascii?q?ovDw/G0g8uEd0Av3vbrsn6OqgJXOCpz6TF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMZ8hwrg+lp?=
 =?us-ascii?q?oUqkTMADP5lF/qjK6Wakok+u+o5/7hYrr6vZ+TK5V4igT/MqQqgsC/AOI4PR?=
 =?us-ascii?q?YSX2WD5Oix27Lu8Vf5TblXlPE6jKbUvI7AKcgGvqK5BhVa0ocn6xaxFTem19?=
 =?us-ascii?q?EYkGEcLF1YYxKKlJTpOlHSL/D4CvezmVKskCxxyPzcMb3hBYvNImDZkLj9Zb?=
 =?us-ascii?q?Z991JcyA0rwN9D/Z1UEa8OIfLoV0/qqNPYDgU2MxG6w+bjFtp9zJoSVn6VDa?=
 =?us-ascii?q?ODLKzStlqI7Po1I+aQfI8VpCr9K/896vHyl3A5gkESfKmz0ZsMdH+4Hu5pI1?=
 =?us-ascii?q?iXYXronNgBC3wHvgs4TOz2llKCVSRfaGq1X6I5/js7Ep6pDZ/fRoCxh7yMxC?=
 =?us-ascii?q?W7HphRZmBcEFCMEGzoep6CW/gWbSKdPM5hniYDVbi7RI8rzQuuuxPiy7p7Mu?=
 =?us-ascii?q?rU/TUVtZbi1Nhz+u3Smgg+9SdqAMuBzmGNVWB0nn8IRjMv2aB/plFyykqH0a?=
 =?us-ascii?q?dmmPFYC9NT6O1TUgsgNp7T0fZ6C9bsVQLFZNuJT0ymQtq+CzErUt0x28MOY1?=
 =?us-ascii?q?p6G9i6lRDMwS6qA74Tl7yWC5056bzc33fvKMZn0XrG17cuj0MgQsRRMW2qnK?=
 =?us-ascii?q?l/9xLcB4TRiUWWi76qdbgA3C7K7GqDznSBs19DUAFsVqXFWnMfa1DKotT5/E?=
 =?us-ascii?q?PCSLquCbU6MgtE08KCLbFKatLxh1VcWPjjIMjeY362m2qoBxaIwbOMbIzwd2?=
 =?us-ascii?q?Uf2yXdCFILkwYI/XmYMwgzHTuurHjYDDxpE1LvYl/j/vN6qH+hUkA0yASKZV?=
 =?us-ascii?q?V717Wp4h4VmeCcS/QL07IcpighrTp0HEu839LQEtaApBRufL9aYdwj5FdKzm?=
 =?us-ascii?q?PZuxV5PpynMaBtmEQScx9tsEPtyhV3EJ9PndIsrHw01gZyK7qY2ktbdzyExZ?=
 =?us-ascii?q?DwJqHXKm7q8RC3caHWx1Xe3c2O+qgV9fQ4r0zvvASuFkol6XVozcNZ3Geb5p?=
 =?us-ascii?q?XPX0IuVsfaW1065lBBrLHTfyc56pmcgXZlKqSlmiTJ29s0Cu8o0FOrdpFUN6?=
 =?us-ascii?q?bSUEf5GtYXFo61I+wjhlatYwgsPeZO+apyNMSjM7OE3amxJud7tDSviGlGpo?=
 =?us-ascii?q?dn3QbE8yt6V/6NxJsO3uuZwhrCUjDwkVOsmt74lJoCZjwIGGe7jy/+C8oZfa?=
 =?us-ascii?q?B2fIAWGU+wLMCtgNZznZjgXzhf7lHwKUkB3ZqSZReKb1H7lTZV3EATrG3vzT?=
 =?us-ascii?q?C01BRogjopqeyZxyWIzOP8IklUclVXTXVv2A+/abO/iMoXCQ3xNVkk?=
X-IPAS-Result: =?us-ascii?q?A2DJAABekPpd/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF2gW0gEiqEBIkDhloGgTeBAYhpkUUJAQEBAQEBAQEBNwEBhEACgj04E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQLAQVBEAkCGAICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCXz+CUyWSSZt0fzOJBoFBgQ4oiCWEDXmBB4ERJw+CKDU+h1mCXgSNO?=
 =?us-ascii?q?Ih1gSd3lj6CP4JDiiWJJQYbmk4tjiGcXyKBWCsIAhgIIQ87gmxQGA2NHheOQ?=
 =?us-ascii?q?SMDMI8tAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2019 20:50:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIKo4Lm151779;
        Wed, 18 Dec 2019 15:50:05 -0500
Subject: Re: [PATCH v12 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-24-casey@schaufler-ca.com>
 <56b96440-a304-42b6-1515-1ad2659b2581@tycho.nsa.gov>
 <e7aa3b6f-cee1-6277-21dd-77a4db9bbc2b@tycho.nsa.gov>
Message-ID: <a522de22-ba62-a24d-24f7-b69418e7ec0b@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 15:50:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e7aa3b6f-cee1-6277-21dd-77a4db9bbc2b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/18/19 2:12 PM, Stephen Smalley wrote:
> On 12/18/19 1:28 PM, Stephen Smalley wrote:
>> On 12/16/19 5:36 PM, Casey Schaufler wrote:
>>> The getsockopt SO_PEERSEC provides the LSM based security
>>> information for a single module, but for reasons of backward
>>> compatibility cannot include the information for multiple
>>> modules. A new option SO_PEERCONTEXT is added to report the
>>> security "context" of multiple modules using a "compound" format
>>>
>>>          lsm1\0value\0lsm2\0value\0
>>>
>>> This is expected to be used by system services, including dbus-daemon.
>>> The exact format of a compound context has been the subject of
>>> considerable debate. This format was suggested by Simon McVittie,
>>> a dbus maintainer with a significant stake in the format being
>>> usable.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> cc: netdev@vger.kernel.org
>>
>> Requires ack by netdev and linux-api.  A couple of comments below.
> 
> Also, have you tested this new interface?  I may be doing something 
> wrong, but a trivial attempt to use SO_PEERCONTEXT with both SELinux and 
> AppArmor enabled only appeared to return the SELinux portion of the 
> label 
> (selinux\0unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023\0), 
> whereas /proc/self/attr/context returned a compound context (the same 
> but with apparmor\0unconfined\n\0 appended).

Ok, this seems to be a lack of support in AppArmor for saving the peer 
info for unix/local domain sockets, so not your bug.  Doesn't implement 
the necessary hooks.

> 
>>
>>> ---
>>
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index 2bf82e1cf347..2ae10e7f81a7 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -880,8 +880,8 @@
>>>    *    SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
>>>    *    socket is associated with an ipsec SA.
>>>    *    @sock is the local socket.
>>> - *    @optval userspace memory where the security state is to be 
>>> copied.
>>> - *    @optlen userspace int where the module should copy the actual 
>>> length
>>> + *    @optval memory where the security state is to be copied.
>>
>> This is misleading; it suggests that the caller is providing an 
>> allocated buffer into which the security module copies its data. 
>> Instead it is just a pointer to a pointer that is then set by the 
>> security module to a buffer the module allocates.
>>
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index 536db4dbfcbb..b72bb90b1903 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -181,7 +181,7 @@ struct lsmblob {
>>>   #define LSMBLOB_NEEDED        -2    /* Slot requested on 
>>> initialization */
>>>   #define LSMBLOB_NOT_NEEDED    -3    /* Slot not requested */
>>>   #define LSMBLOB_DISPLAY        -4    /* Use the "display" slot */
>>> -#define LSMBLOB_FIRST        -5    /* Use the default "display" slot */
>>> +#define LSMBLOB_COMPOUND    -5    /* A compound "display" */
>>
>> I'm puzzled by the removal of LSMBLOB_FIRST by this patch; it suggests 
>> it was never needed in the first place by the patch that introduced 
>> it. But more below.
>>
>>> diff --git a/security/security.c b/security/security.c
>>> index d0b57a7c3b31..1afe245f3246 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -723,6 +723,42 @@ static void __init lsm_early_task(struct 
>>> task_struct *task)
>>>           panic("%s: Early task alloc failed.\n", __func__);
>>>   }
>>> +/**
>>> + * append_ctx - append a lsm/context pair to a compound context
>>> + * @ctx: the existing compound context
>>> + * @ctxlen: size of the old context, including terminating nul byte
>>> + * @lsm: new lsm name, nul terminated
>>> + * @new: new context, possibly nul terminated
>>> + * @newlen: maximum size of @new
>>> + *
>>> + * replace @ctx with a new compound context, appending @newlsm and @new
>>> + * to @ctx. On exit the new data replaces the old, which is freed.
>>> + * @ctxlen is set to the new size, which includes a trailing nul byte.
>>> + *
>>> + * Returns 0 on success, -ENOMEM if no memory is available.
>>> + */
>>> +static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char 
>>> *new,
>>> +              int newlen)
>>> +{
>>> +    char *final;
>>> +    int llen;
>>> +
>>> +    llen = strlen(lsm) + 1;
>>> +    newlen = strnlen(new, newlen) + 1;
>>> +
>>> +    final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
>>> +    if (final == NULL)
>>> +        return -ENOMEM;
>>> +    if (*ctxlen)
>>> +        memcpy(final, *ctx, *ctxlen);
>>> +    memcpy(final + *ctxlen, lsm, llen);
>>> +    memcpy(final + *ctxlen + llen, new, newlen);
>>> +    kfree(*ctx);
>>> +    *ctx = final;
>>> +    *ctxlen = *ctxlen + llen + newlen;
>>> +    return 0;
>>> +}
>>
>> You should likely take some precautions against integer overflows in 
>> the above code?
>>
>>> +
>>>   /*
>>>    * Hook list operation macros.
>>>    *
>>> @@ -2164,8 +2200,8 @@ int security_setprocattr(const char *lsm, const 
>>> char *name, void *value,
>>>       hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>>>           if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>>>               continue;
>>> -        if (lsm == NULL && *display != LSMBLOB_INVALID &&
>>> -            *display != hp->lsmid->slot)
>>> +        if (lsm == NULL && display != NULL &&
>>> +            *display != LSMBLOB_INVALID && *display != hp->lsmid->slot)
>>>               continue;
>>>           return hp->hook.setprocattr(name, value, size);
>>>       }
>>
>> Is this a bug fix that should be folded into the earlier patch that 
>> introduced it?
>>
>>> @@ -2196,7 +2232,7 @@ int security_secid_to_secctx(struct lsmblob 
>>> *blob, struct lsmcontext *cp,
>>>        */
>>>       if (display == LSMBLOB_DISPLAY)
>>>           display = lsm_task_display(current);
>>> -    else if (display == LSMBLOB_FIRST)
>>> +    else if (display == 0)
>>>           display = LSMBLOB_INVALID;
>>>       else if (display < 0) {
>>>           WARN_ONCE(true,
>>
>> Why is it necessary to re-map display 0 in this manner? Previously if 
>> display 0 was specified, it would require it to match the lsmid->slot 
>> value.  Won't it match anyway?
>>
>>> @@ -2246,6 +2282,15 @@ void security_release_secctx(struct lsmcontext 
>>> *cp)
>>>       struct security_hook_list *hp;
>>>       bool found = false;
>>> +    if (cp->slot == LSMBLOB_INVALID)
>>> +        return;
>>> +
>>> +    if (cp->slot == LSMBLOB_COMPOUND) {
>>> +        kfree(cp->context);
>>> +        found = true;
>>> +        goto clear_out;
>>> +    }
>>> +
>>
>> If you re-order your pr_warn() below with your memset() to address the 
>> earlier comment, you'll end up trying to print the freed memory.  Not 
>> a problem if you just drop the pr_warn() altogether.
> 

