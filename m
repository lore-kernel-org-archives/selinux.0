Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2305DC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 16:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99E82070A
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 16:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="cgu6sgN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbgAXQUS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:20:18 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:3942 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbgAXQUN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 11:20:13 -0500
X-EEMSG-check-017: 48635285|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="48635285"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 16:20:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579882811; x=1611418811;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=c9hGaStLffylCpkfghWVKKRpUzkI/lliuvou2FjID+w=;
  b=cgu6sgN3uWQWlcWDUqf/HVaDIFyEE1jc8UXjEqNlfbOD5bVbGhhfUe5e
   4Kq/8PFGQOC+O8aA4UZBJkP03eGlcOX0xR1cRW5SGxWrXDUWpm9txAql4
   jN/sXcIA4rY/3sgnEjvfThODQh4jptHcB8JJ+E4ggnNuRjiTOLp1uFGZg
   idN1qneQXfusbmwgKbl5kTEIyfQsQh6rsKzFlbJvceeVEWL28FaqBUyTk
   cwritfj/Ki8jn+dCKItFYaT7NP6vJLKpcSFCvJhBdX4SN+odcozQpg9Hn
   DLnVdIpR1/jhGe1jM24P5z0xuBDCNsk7eJHHijOgqZr8oMsPyY599nTn2
   A==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="32301826"
IronPort-PHdr: =?us-ascii?q?9a23=3Anj+paxZDdZySjtzbaan13xP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsm6YB7h7PlgxGXEQZ/co6odzbaP7+a6BSdQvN7B6ClELMUXEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/Jas90A?=
 =?us-ascii?q?XFr3RHd+lVxW5jOFafkwrh6suq85Nv7ipdt+g9+8JcVKnxYrg1Q6FfADk6KW?=
 =?us-ascii?q?4++dfltQPETQuB53scVnsZnx9VCAXb7x/0Q4n8vDLiuuVyxCeVM8v2TaspWT?=
 =?us-ascii?q?u59KdkVAXoiCYcODEn9mzcl9F9g7haoBKloBx/3pLUbYSIP/dwYq/RYdUXTn?=
 =?us-ascii?q?daU81PSyJOHJ+zb4oXD+oAI+lYqZX9p0ATphe6HAWgGf/jxiNNinLw06I6ye?=
 =?us-ascii?q?AhGhzY0gImEdwFrXDYoMzrOKoWVOy4yrTDwzfeYPNMwTrz9YjGfA4vof+PU7?=
 =?us-ascii?q?x/f8XexkszGA3KlViQtY/oMimJ2ugRvWWW7extXv+vhW49rAFxpyCiyNowio?=
 =?us-ascii?q?bXnoIVyk7L9SNky4goIN23Ukp7Ydq6H5pQqiqXMJB2Td45Q2xzpCY7yqEJuZ?=
 =?us-ascii?q?68fCQQzpQn3ATQZ+aIc4iP/BLuTeCcKip7inJ9YL+zmhm//Ee6xuD8S8W4yk?=
 =?us-ascii?q?hGoyVbntXWq3wA0QHY5NKdRftn5Eih3C6C1wXU6u5ZP085jbHbK5s9wr4okZ?=
 =?us-ascii?q?oTrFjDEjf2mEroiK+WcV0p+vSy5OT9Y7Xmu4ScO5V1igH4PKQunde/DvokPQ?=
 =?us-ascii?q?QUQ2ia+fiz1L3k/UHjRrVFkuY2nbXDvJDfJMQbora1Aw5T0ok99xayFyqq3d?=
 =?us-ascii?q?sXkHUdLF9JZQiLg5bmNl3QOvz0EO+zg1G2nzdqw/DGMKfhApLILnXbi7fuYK?=
 =?us-ascii?q?195lVAyAsz0d9f55VUBqsHIPLoQED9rtPYDhgnMwCs2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KWLLndsUSW6eMvOOSMf5MauDbnJPg46f7uiWE2mUUEcaa1x5Qbcmy3HvNjI0?=
 =?us-ascii?q?+Be3rjns8BEXsWvgo5VOHllEeNUSVNaHeyRa48/S00CIK8AofeSICthKKO3D?=
 =?us-ascii?q?2gE51XYGBGFk6DEXPye4qYXPcMbTqYItV9nTwcSbihV4gh2AmstA//zLpnNP?=
 =?us-ascii?q?DU+iwDtZ/40th6/ejTmg8z9TBuCMSdyW6NRXlunmwUXz82wLx/oUtlx1eH0K?=
 =?us-ascii?q?h4heFYFNNK6/NSTAg1KYPcz/Z7C9DuWgPNZ9KJSFG7TdW7BTE+UMk8w8EBY0?=
 =?us-ascii?q?ljAdWulBPD0DSwA78TibOLAIY48qXG33j+P8x90WrJ1LE9j1k6RctCLXamib?=
 =?us-ascii?q?B79wjSAY7JjkqYmr20daQTwiHN7n2PzWmQs0FCVg5/T6HFUWoYZkvMotTz/l?=
 =?us-ascii?q?nCQKO2CbQ7LgtBztaPKqhUZdL3llVJWPDjONPdY2+qh2iwBQyIxrSJbIrrZm?=
 =?us-ascii?q?Ud2T/RCE8ekwAc5XyGLxQxBj+9o2LCCzxjDVDvY0Ts8el4sn+7TEg0zwGQYE?=
 =?us-ascii?q?1nzLq65BgViOeARPwJ2LIEvyEhqzRoE1mn29LaEcaPpw1kfK9Ee9My/E9H1X?=
 =?us-ascii?q?7Ftwx6JpGgN75thlgRcwRqvkPu0Qx7CoZensgwqnMl0g5yJLmZ0F9YczOY2o?=
 =?us-ascii?q?7wNaPNJmnp5h+vaLPW2kvE39qM/KcA9u40q1f7vAuxDEot721n08VJ03ub/p?=
 =?us-ascii?q?jKFBAdUY/1Ukss7xh1vazaYi0k64PR0n1sNrO0vSHY1901A+slz0XoQ9AKG6?=
 =?us-ascii?q?qfGR66KMYaDtWgLOEw0wyiZwkJLchJ/649Is2ieuHD06ftN+Flynbuhm1c7Z?=
 =?us-ascii?q?E7yUmM/jdyTuPS95cD3/ycmACAUnO0jlKmqNr2gqhCbDQfHyy40yegTIpQYL?=
 =?us-ascii?q?BiOJ0GAnq0ItGmg9B5i4PpVlZG+1O5QVALwsmkfVyVdVO5lRZd0UURvGyPhy?=
 =?us-ascii?q?S11Xp3nisvo67Z2zbBkMr4cx9SAXJGXGlvix/XJIGwi90LFByzYxMBiAqu5U?=
 =?us-ascii?q?G8wbNS4qt4MT+AEg9zYyHqIjQ6AeOLvb2YbpsKscl5vA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BtAgDjGCte/wHyM5BdCBwBAQEBAQcBAREBBAQBAYF7g?=
 =?us-ascii?q?X2BbSASKoQSiQOGeQaBN4EBiG6RSQkBAQEBAQEBAQE3AQGEQAKCRjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBAsBBUEQCQIYAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJjP4JXJZFYm3d/M4kBgT6BDiqIJIQNeYEHgREnD4IoNT6EJCWDEIJeBI1Si?=
 =?us-ascii?q?QGBJ3qWZIJDgkyTZQYbmnyOYJ0eIoFYKwgCGAghDzuCbFAYDYgNF45BIwMwj?=
 =?us-ascii?q?VYBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 Jan 2020 16:20:09 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OGJLQn025872;
        Fri, 24 Jan 2020 11:19:23 -0500
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
Message-ID: <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 11:20:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/24/20 9:42 AM, Stephen Smalley wrote:
> On 1/23/20 7:23 PM, Casey Schaufler wrote:
>> Add an entry /proc/.../attr/context which displays the full
>> process security "context" in compound format:'
>>          lsm1\0value\0lsm2\0value\0...
>> This entry is not writable.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: linux-api@vger.kernel.org
> 
> As previously discussed, there are issues with AppArmor's implementation 
> of getprocattr() particularly around the trailing newline that 
> dbus-daemon and perhaps others would like to see go away in any new 
> interface.  Hence, I don't think we should implement this new API using 
> the existing getprocattr() hook lest it also be locked into the current 
> behavior forever.

Also, it would be good if whatever hook is introduced to support 
/proc/pid/attr/context could also be leveraged by the SO_PEERCONTEXT 
implementation in the future so that we are guaranteed a consistent 
result between the two interfaces, unlike the current situation for 
/proc/self/attr/current versus SO_PEERSEC.

> 
>> ---
>>   Documentation/security/lsm.rst | 14 ++++++++
>>   fs/proc/base.c                 |  1 +
>>   security/security.c            | 63 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 78 insertions(+)
>>
>> diff --git a/Documentation/security/lsm.rst 
>> b/Documentation/security/lsm.rst
>> index aadf47c808c0..a4979060f5d3 100644
>> --- a/Documentation/security/lsm.rst
>> +++ b/Documentation/security/lsm.rst
>> @@ -199,3 +199,17 @@ capability-related fields:
>>   -  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
>>   -  ``fs/proc/array.c``::c:func:`task_cap()`
>> +
>> +LSM External Interfaces
>> +=======================
>> +
>> +The LSM infrastructure does not generally provide external interfaces.
>> +The individual security modules provide what external interfaces they
>> +require. The infrastructure does provide an interface for the special
>> +case where multiple security modules provide a process context. This
>> +is provided in compound context format.
>> +
>> +-  `lsm1\0value\0lsm2\0value\0`
>> +
>> +The special file ``/proc/pid/attr/context`` provides the security
>> +context of the identified process.
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 950c200cb9ad..d13c2cf50e4b 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -2653,6 +2653,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>>       ATTR(NULL, "keycreate",        0666),
>>       ATTR(NULL, "sockcreate",    0666),
>>       ATTR(NULL, "display",        0666),
>> +    ATTR(NULL, "context",        0666),
>>   #ifdef CONFIG_SECURITY_SMACK
>>       DIR("smack",            0555,
>>           proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
>> diff --git a/security/security.c b/security/security.c
>> index 6a77c8b2ffbc..fdd0c85df89e 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -722,6 +722,42 @@ static void __init lsm_early_task(struct 
>> task_struct *task)
>>           panic("%s: Early task alloc failed.\n", __func__);
>>   }
>> +/**
>> + * append_ctx - append a lsm/context pair to a compound context
>> + * @ctx: the existing compound context
>> + * @ctxlen: size of the old context, including terminating nul byte
>> + * @lsm: new lsm name, nul terminated
>> + * @new: new context, possibly nul terminated
>> + * @newlen: maximum size of @new
>> + *
>> + * replace @ctx with a new compound context, appending @newlsm and @new
>> + * to @ctx. On exit the new data replaces the old, which is freed.
>> + * @ctxlen is set to the new size, which includes a trailing nul byte.
>> + *
>> + * Returns 0 on success, -ENOMEM if no memory is available.
>> + */
>> +static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char 
>> *new,
>> +              int newlen)
>> +{
>> +    char *final;
>> +    int llen;
>> +
>> +    llen = strlen(lsm) + 1;
>> +    newlen = strnlen(new, newlen) + 1;
>> +
>> +    final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
>> +    if (final == NULL)
>> +        return -ENOMEM;
>> +    if (*ctxlen)
>> +        memcpy(final, *ctx, *ctxlen);
>> +    memcpy(final + *ctxlen, lsm, llen);
>> +    memcpy(final + *ctxlen + llen, new, newlen);
>> +    kfree(*ctx);
>> +    *ctx = final;
>> +    *ctxlen = *ctxlen + llen + newlen;
>> +    return 0;
>> +}
>> +
>>   /*
>>    * Hook list operation macros.
>>    *
>> @@ -2041,6 +2077,10 @@ int security_getprocattr(struct task_struct *p, 
>> const char *lsm, char *name,
>>                   char **value)
>>   {
>>       struct security_hook_list *hp;
>> +    char *final = NULL;
>> +    char *cp;
>> +    int rc = 0;
>> +    int finallen = 0;
>>       int display = lsm_task_display(current);
>>       int slot = 0;
>> @@ -2068,6 +2108,29 @@ int security_getprocattr(struct task_struct *p, 
>> const char *lsm, char *name,
>>           return -ENOMEM;
>>       }
>> +    if (!strcmp(name, "context")) {
>> +        hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
>> +                     list) {
>> +            rc = hp->hook.getprocattr(p, "current", &cp);
>> +            if (rc == -EINVAL || rc == -ENOPROTOOPT)
>> +                continue;
>> +            if (rc < 0) {
>> +                kfree(final);
>> +                return rc;
>> +            }
>> +            rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
>> +                    cp, rc);
>> +            if (rc < 0) {
>> +                kfree(final);
>> +                return rc;
>> +            }
>> +        }
>> +        if (final == NULL)
>> +            return -EINVAL;
>> +        *value = final;
>> +        return finallen;
>> +    }
>> +
>>       hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>           if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>>               continue;
>>
> 

