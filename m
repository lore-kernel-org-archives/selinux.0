Return-Path: <SRS0=eYI8=NZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DC2C43441
	for <selinux@archiver.kernel.org>; Wed, 14 Nov 2018 15:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F49820896
	for <selinux@archiver.kernel.org>; Wed, 14 Nov 2018 15:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F49820896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbeKOBrl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:47:41 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:20630 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733180AbeKOBrl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Nov 2018 20:47:41 -0500
X-EEMSG-check-008: 613789699|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,232,1539648000"; 
   d="scan'208";a="613789699"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Nov 2018 15:43:47 +0000
X-IronPort-AV: E=Sophos;i="5.56,232,1539648000"; 
   d="scan'208";a="20605472"
IronPort-PHdr: =?us-ascii?q?9a23=3A+JooQBWfVP8Ng488dIeYkVrD1HbV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRaFt8tkgFKBZ4jH8fUM07OQ7/i/HzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9wIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepGs4Xxol0Dpga8CwaxHuPi0iJGiH/o06000O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaQIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+ZL4t7Wt4uTm5ntSogyrAKpI?=
 =?us-ascii?q?S3cDYFxZg53RLTdvqKeJWS7B35TuaeOzJ4iWpgeLK4mhm971Ctyvb5VsmoyF?=
 =?us-ascii?q?ZKqTdFksXUunANyRPT7s+HR+Nh/ki7wzaP1h3T6vpeLUAolavUN54hwrkqmp?=
 =?us-ascii?q?oVrUvDBTP5lF/zjK+XckUo4umo6+L5bbX6vpKQKoB5hw7kPqkuh8CzG/o0Pw?=
 =?us-ascii?q?cQU2SB5OiwzLjj8lf4QLVOgP02iK7ZsJXCKMQAu6G5GBRY0poj6hmjDzem18?=
 =?us-ascii?q?4UnX8cLF1fYh6HgI/pO0/WLPDiEfi/m0iskCtsx/3eJr3uGIjNLnzYnbf5Z7?=
 =?us-ascii?q?l99kpcxBM2zdBY4JJUEK8OLOjvVU/2sdzSFgU5PBCsw+b7FNV90ZsTWWWKAq?=
 =?us-ascii?q?+eK6PSt0WH6f4xLOSXfo8apivyK/g/6P7yl3M2hVgdfayx15sNdH+4BuhmI1?=
 =?us-ascii?q?meYXf0mdcOD2MKvgs4TOz3h1yPSiBTZ3msUKIm/D07C5ypDZ3FRo+zhLyNxi?=
 =?us-ascii?q?C7HodZZjMONlfZKX71c82hXPAWZWrGOsZ8lhQcXKWlDoom0guj8gT9zuwjZu?=
 =?us-ascii?q?3R/TYevJnu/MJ46+3aiVc58jknId6a1jS2U2xsnm4ODwQz1aR7rF01nkyPyo?=
 =?us-ascii?q?BkkvdYEppV/PoPXQAkY82Ph9dmAsz/D1qSNuyCT0yrF5D/W2k8?=
X-IPAS-Result: =?us-ascii?q?A2ALAAABQuxb/wHyM5BiGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?gQBAQEBCwGBWimBNTMng3iUEUwBAQEBAQEGgQgIJYkViSqEd4F6OAGEQAKDS?=
 =?us-ascii?q?SI1DA0BAwEBAQEBAQIBbCiCNiQBgmABBSMECwEFQRAJAhgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl4/gXUNjEWbUHwziiuBC4p6F3iBB4ERJwyCX4RxgxGCVwKJF4Zoj18Jk?=
 =?us-ascii?q?RwGAhaBWIgnhnYsmRwBNYFVKwgCGAghD4MngiQDF446IQMwgQUBAYoVgksBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Nov 2018 15:43:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wAEFhknU017037;
        Wed, 14 Nov 2018 10:43:46 -0500
Subject: Re: [PATCH v3] selinux: simplify mls_context_to_sid()
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Paul Moore <paul@paul-moore.com>, omosnace@redhat.com
Cc:     selinux@vger.kernel.org, selinux@tycho.nsa.gov
References: <20181112114426.20887-1-omosnace@redhat.com>
 <6eab4acd-a802-efba-db19-9593419025e2@tycho.nsa.gov>
 <CAHC9VhSV0ZDYBffe+nCH7N8GZ-4ZkH6Wpt+R62Ca7kO4hYrdsQ@mail.gmail.com>
 <03a3a23b-a580-8bf9-96c0-2f89b89d4166@tycho.nsa.gov>
Message-ID: <44813163-4029-70cd-55dd-aa1ae50ac36e@tycho.nsa.gov>
Date:   Wed, 14 Nov 2018 10:46:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <03a3a23b-a580-8bf9-96c0-2f89b89d4166@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/14/18 10:23 AM, Stephen Smalley wrote:
> On 11/13/18 10:14 PM, Paul Moore wrote:
>> On Tue, Nov 13, 2018 at 4:10 PM Stephen Smalley <sds@tycho.nsa.gov> 
>> wrote:
>>> On 11/12/18 6:44 AM, Ondrej Mosnacek wrote:
>>>> This function has only two callers, but only one of them actually needs
>>>> the special logic at the beginning. Factoring this logic out into
>>>> string_to_context_struct() allows us to drop the arguments 'oldc', 's',
>>>> and 'def_sid'.
>>>>
>>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>>> ---
>>>>
>>>> Changes in v3:
>>>>    - correct the comment about policy read lock
>>>>
>>>> Changes in v2:
>>>>    - also drop unneeded #include's from mls.c
>>>>
>>>>    security/selinux/ss/mls.c      | 49 
>>>> +++++-----------------------------
>>>>    security/selinux/ss/mls.h      |  5 +---
>>>>    security/selinux/ss/services.c | 32 +++++++++++++++++++---
>>>>    3 files changed, 36 insertions(+), 50 deletions(-)
>>>>
>>>> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
>>>> index 2fe459df3c85..d1da928a7e77 100644
>>>> --- a/security/selinux/ss/mls.c
>>>> +++ b/security/selinux/ss/mls.c
>>>> @@ -24,10 +24,7 @@
>>>>    #include <linux/string.h>
>>>>    #include <linux/errno.h>
>>>>    #include <net/netlabel.h>
>>>> -#include "sidtab.h"
>>>>    #include "mls.h"
>>>> -#include "policydb.h"
>>>> -#include "services.h"
>>>>
>>>>    /*
>>>>     * Return the length in bytes for the MLS fields of the
>>>> @@ -223,20 +220,12 @@ int mls_context_isvalid(struct policydb *p, 
>>>> struct context *c)
>>>>     * This function modifies the string in place, inserting
>>>>     * NULL characters to terminate the MLS fields.
>>>>     *
>>>> - * If a def_sid is provided and no MLS field is present,
>>>> - * copy the MLS field of the associated default context.
>>>> - * Used for upgraded to MLS systems where objects may lack
>>>> - * MLS fields.
>>>> - *
>>>> - * Policy read-lock must be held for sidtab lookup.
>>>> + * Policy read-lock must be held for policy data lookup.
>>>>     *
>>>>     */
>>>>    int mls_context_to_sid(struct policydb *pol,
>>>> -                    char oldc,
>>>>                       char *scontext,
>>>> -                    struct context *context,
>>>> -                    struct sidtab *s,
>>>> -                    u32 def_sid)
>>>> +                    struct context *context)
>>>>    {
>>>>        char *sensitivity, *cur_cat, *next_cat, *rngptr;
>>>>        struct level_datum *levdatum;
>>>> @@ -244,29 +233,6 @@ int mls_context_to_sid(struct policydb *pol,
>>>>        int l, rc, i;
>>>>        char *rangep[2];
>>>>
>>>> -     if (!pol->mls_enabled) {
>>>> -             if ((def_sid != SECSID_NULL && oldc) || (*scontext) == 
>>>> '\0')
>>>> -                     return 0;
>>>> -             return -EINVAL;
>>>> -     }
>>>> -
>>>> -     /*
>>>> -      * No MLS component to the security context, try and map to
>>>> -      * default if provided.
>>>> -      */
>>>> -     if (!oldc) {
>>>> -             struct context *defcon;
>>>> -
>>>> -             if (def_sid == SECSID_NULL)
>>>> -                     return -EINVAL;
>>>> -
>>>> -             defcon = sidtab_search(s, def_sid);
>>>> -             if (!defcon)
>>>> -                     return -EINVAL;
>>>> -
>>>> -             return mls_context_cpy(context, defcon);
>>>> -     }
>>>> -
>>>>        /*
>>>>         * If we're dealing with a range, figure out where the two parts
>>>>         * of the range begin.
>>>> @@ -364,14 +330,11 @@ int mls_from_string(struct policydb *p, char 
>>>> *str, struct context *context,
>>>>                return -EINVAL;
>>>>
>>>>        tmpstr = kstrdup(str, gfp_mask);
>>>> -     if (!tmpstr) {
>>>> -             rc = -ENOMEM;
>>>> -     } else {
>>>> -             rc = mls_context_to_sid(p, ':', tmpstr, context,
>>>> -                                     NULL, SECSID_NULL);
>>>> -             kfree(tmpstr);
>>>> -     }
>>>> +     if (!tmpstr)
>>>> +             return -ENOMEM;
>>>>
>>>> +     rc = mls_context_to_sid(p, tmpstr, context);
>>>> +     kfree(tmpstr);
>>>>        return rc;
>>>>    }
>>>>
>>>> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
>>>> index 67093647576d..e2498f78e100 100644
>>>> --- a/security/selinux/ss/mls.h
>>>> +++ b/security/selinux/ss/mls.h
>>>> @@ -33,11 +33,8 @@ int mls_range_isvalid(struct policydb *p, struct 
>>>> mls_range *r);
>>>>    int mls_level_isvalid(struct policydb *p, struct mls_level *l);
>>>>
>>>>    int mls_context_to_sid(struct policydb *p,
>>>> -                    char oldc,
>>>>                       char *scontext,
>>>> -                    struct context *context,
>>>> -                    struct sidtab *s,
>>>> -                    u32 def_sid);
>>>> +                    struct context *context);
>>>>
>>>>    int mls_from_string(struct policydb *p, char *str, struct context 
>>>> *context,
>>>>                    gfp_t gfp_mask);
>>>> diff --git a/security/selinux/ss/services.c 
>>>> b/security/selinux/ss/services.c
>>>> index 12e414394530..ccad4334f99d 100644
>>>> --- a/security/selinux/ss/services.c
>>>> +++ b/security/selinux/ss/services.c
>>>> @@ -1425,9 +1425,35 @@ static int string_to_context_struct(struct 
>>>> policydb *pol,
>>>>
>>>>        ctx->type = typdatum->value;
>>>>
>>>> -     rc = mls_context_to_sid(pol, oldc, p, ctx, sidtabp, def_sid);
>>>> -     if (rc)
>>>> -             goto out;
>>>> +     if (!pol->mls_enabled) {
>>>> +             rc = -EINVAL;
>>>> +             if ((def_sid == SECSID_NULL || !oldc) && (*p) != '\0')
>>>> +                     goto out;
>>>
>>> I don't think this is your bug, but unless I'm mistaken, p could be OOB
>>> and be dereferenced here.  Seems to have been introduced by
>>> 95ffe194204ae3cef88d0b59be209204bbe9b3be.  Likely not caught in testing
>>> since both Linux distributions and Android enable MLS to use the
>>> category sets for isolation.
>>
>> Yep, and we should fix that in v4.20-rcX independent of this patch.  I
>> think if we simply remove the "(*scontext) == '\0'" from the check we
>> should be okay; I believe the only time we would want to return 0 when
>> not running a MLS policy would be when there is something in the MLS
>> portion of the label.
> 
> Yes, that should restore the previous behavior. The desired behavior is 
> that if MLS is disabled, we reject the context as invalid if it has a 
> MLS field unless the context was fetched from an xattr, which we only 
> permit to provide filesystem compatibility between MLS and non-MLS systems.

Sorry, that isn't correct.  If MLS is disabled, then we want to return 0 
if either there is no MLS field (!oldc) or the context came from an 
xattr (def_sid != SECSID_NULL).  We should only return -EINVAL if there 
is a MLS field (oldc) and the context did not come from an xattr 
(def_sid == SECSID_NULL).
