Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47532C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 16:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0434020700
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 16:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="NY+DJtbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbfBVQPP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:15:15 -0500
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:60025 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfBVQPP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 11:15:15 -0500
X-EEMSG-check-017: 201612213|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Feb 2019 16:15:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550852110; x=1582388110;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3zBGejq0u5Wg+xmpA437gkncifDjVjbPsdIDJG1cpTM=;
  b=NY+DJtbXuSTx1AG3ZEPLF6KKf7X9Mqy7duqdGQflmg26AWcWJRliOHHx
   xo4Bc2vC4015HnpBgprdYYTJZ9DLc513cE9IkwTndyjfr0CSTuTz8RDRw
   Ay6Glf9X0ipzU0Dsbasu4rbuA77b3dO8ybmL2i3gYew1oEr0z4HZ8f5wV
   qLBrHaHJ56j7Dcv1P9LGuJ7bw1oQ7uDF/V5L2CRNWOTFeNHEwItoGZrVH
   D0H9tKORuqMJa1HWWPp7XUPkGGs5ZnBqpoj16IPZ9kS0cHbwyXqoaT21o
   qJSYnH9Qt4g111s8kUWWJJdNOxjuappA7rV2jUjaMQGMs/+bL0AfSvYs/
   g==;
X-IronPort-AV: E=Sophos;i="5.58,400,1544486400"; 
   d="scan'208";a="20797814"
IronPort-PHdr: =?us-ascii?q?9a23=3AdNOpjhxCEU3mcjjXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+wXIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsL4V7A0XS?=
 =?us-ascii?q?mp4bltRhHmlSwLMyc1/H/LhsB1iq9QvRCvqAFlw4PMfY+bNORwfq3ec90US2?=
 =?us-ascii?q?VOUcReWDBODI6nc4sCDPAMMfpEo4TzpVYDqwa1Cwm2BOPozz9FnmL43bEk3O?=
 =?us-ascii?q?Q5EQHJwgogFM8TvnTRttr1MKMSXv61zaLVyjjDdO5Z2Szm5YjUchEuvfGMXb?=
 =?us-ascii?q?VqfcrX0kkgDRnJjlqXqYz7Jj6Y0PkGvWuD7+d4SO6ihGEqpxtxrzSy3MsglI?=
 =?us-ascii?q?bEipwPxlzZ8yhy3Zw7KseiSEFhZN6pCJ5QtyaHOIRoWs4iWGRouDoiyr0BpJ?=
 =?us-ascii?q?67YDAGyJQ5yB7bbPyKa5SI7Qj5VOaQPDd4n2hpeK6/hhmu8UigzffwVs+o31?=
 =?us-ascii?q?ZRsiVJiNzMtnEJ1xDL68iHTOVy/lu51DqS2A3e5ftILEApmabBNZIszaA8mo?=
 =?us-ascii?q?AOvUjbGy/5gkT2jKuYdkU+/eio7vzqYq77qZ+HLIJ0lgH/Pbgumsy4G+g4NB?=
 =?us-ascii?q?MOUHKB9eSz073j41X1QK9Wgf0ujqnZrJfaKNwDpqGjHg9V1p0u6w6lADe71N?=
 =?us-ascii?q?QUhHwHLFVCeBKdkYflIU3BIPf9Df2nmVSjjC9rx+zaPr3mGpjCM3/DkLLgfb?=
 =?us-ascii?q?Z76k5T1AkzwcpQ55JOC7EBLu7zV1Tsu9PGAB82LQq0w/35B9phzI8eX2aPCL?=
 =?us-ascii?q?eDMKzOqV+I+v4vI+6UaY8Opjn9L/kl5/jzjX42glIdY6ap0oUNaHyiHfRpPV?=
 =?us-ascii?q?+ZYXzyjdcFC2sKuRA+TOO5wGGFBCZaenKaR6sh4nQ+D4W8AMHIQYX+rqaG2X?=
 =?us-ascii?q?KAApBOZm1AQmuJGHPsepTMD+wAcwqOM8RhlXoCTrHnRIg/g0L9/DTmwqZqe7?=
 =?us-ascii?q?KHshYTsojugZ0vv+A=3D?=
X-IPAS-Result: =?us-ascii?q?A2CsAACqHnBc/wHyM5BlHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VkqgTcBMieEB5Q9AQEBAQEBBoE1iTuJU4cLOAGEQAKDfiI3Bg0BAwEBAQEBA?=
 =?us-ascii?q?QIBbCiCOimCaAEFIwQLAQVBEAkCGAICJgICVxMGAgEBgl89gWYNkCebYXwzi?=
 =?us-ascii?q?i2BC4s9F3iBB4ERJ4JriAuCVwKJdRGGSYEGWpEqCZJaBhmBcYkciAItizGNV?=
 =?us-ascii?q?oUsIoFWKwgCGAghD4MngigXE20BAo05IQMwgQUBAY8EAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Feb 2019 16:15:08 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1MGF8Zt021777;
        Fri, 22 Feb 2019 11:15:08 -0500
Subject: Re: [PATCH] libselinux: selinux_set_mapping: fix handling of unknown
 classes/perms
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     dominick.grift@defensec.nl, selinux@vger.kernel.org
References: <20190222144139.8396-1-sds@tycho.nsa.gov>
 <e8da7085-91d5-9834-afe2-30d5d8879c62@tycho.nsa.gov>
Message-ID: <b69e3998-3c54-9b4e-58a6-913808d398aa@tycho.nsa.gov>
Date:   Fri, 22 Feb 2019 11:14:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e8da7085-91d5-9834-afe2-30d5d8879c62@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/22/19 11:11 AM, Stephen Smalley wrote:
> On 2/22/19 9:41 AM, Stephen Smalley wrote:
>> The libselinux selinux_set_mapping() implementation was never updated
>> to handle unknown classes/permissions based on the policy handle_unknown
>> flag.  Update it and the internal mapping functions to gracefully
>> handle unknown classes/permissions.  Add a security_reject_unknown()
>> interface to expose the corresponding selinuxfs node and use it when
>> creating a mapping to decide whether to fail immediately or proceed.
>>
>> This enables dbus-daemon and XSELinux, which use selinux_set_mapping(),
>> to continue working with the dummy policy or other policies that lack
>> their userspace class/permission definitions as long as the policy
>> was built with -U allow.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   libselinux/include/selinux/selinux.h |  5 +-
>>   libselinux/src/compute_av.c          | 16 +++++--
>>   libselinux/src/mapping.c             | 71 ++++++++++++++++++++++------
>>   libselinux/src/mapping.h             |  4 +-
>>   libselinux/src/reject_unknown.c      | 40 ++++++++++++++++
>>   libselinux/src/selinux_internal.h    |  1 +
>>   6 files changed, 117 insertions(+), 20 deletions(-)
>>   create mode 100644 libselinux/src/reject_unknown.c
>>
>> diff --git a/libselinux/include/selinux/selinux.h 
>> b/libselinux/include/selinux/selinux.h
>> index 01201eee..a34d54fc 100644
>> --- a/libselinux/include/selinux/selinux.h
>> +++ b/libselinux/include/selinux/selinux.h
>> @@ -328,7 +328,10 @@ extern int security_getenforce(void);
>>   /* Set the enforce flag value. */
>>   extern int security_setenforce(int value);
>> -/* Get the behavior for undefined classes/permissions */
>> +/* Get the load-time behavior for undefined classes/permissions */
>> +extern int security_reject_unknown(void);
>> +
>> +/* Get the runtime behavior for undefined classes/permissions */
>>   extern int security_deny_unknown(void);
>>   /* Get the checkreqprot value */
>> diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
>> index 1d05e7b6..d5741637 100644
>> --- a/libselinux/src/compute_av.c
>> +++ b/libselinux/src/compute_av.c
>> @@ -20,6 +20,7 @@ int security_compute_av_flags_raw(const char * scon,
>>       char *buf;
>>       size_t len;
>>       int fd, ret;
>> +    security_class_t kclass;
>>       if (!selinux_mnt) {
>>           errno = ENOENT;
>> @@ -38,8 +39,9 @@ int security_compute_av_flags_raw(const char * scon,
>>           goto out;
>>       }
>> +    kclass = unmap_class(tclass);
>>       snprintf(buf, len, "%s %s %hu %x", scon, tcon,
>> -         unmap_class(tclass), unmap_perm(tclass, requested));
>> +         kclass, unmap_perm(tclass, requested));
>>       ret = write(fd, buf, strlen(buf));
>>       if (ret < 0)
>> @@ -60,9 +62,15 @@ int security_compute_av_flags_raw(const char * scon,
>>       } else if (ret < 6)
>>           avd->flags = 0;
>> -    /* If tclass invalid, kernel sets avd according to deny_unknown 
>> flag */
>> -    if (tclass != 0)
>> -        map_decision(tclass, avd);
>> +    /*
>> +     * If the tclass could not be mapped to a kernel class at all, the
>> +     * kernel will have already set avd according to the
>> +     * handle_unknown flag and we do not need to do anything further.
>> +     * Otherwise, we must map the permissions within the returned
>> +     * avd to the userspace permission values.
>> +     */
>> +    if (kclass != 0)
>> +        map_decision(tclass, avd, !security_deny_unknown());
> 
> We probably want to cache security_deny_unknown() and refresh it upon a 
> policy reload.  If the callers were to use selinux_status_open() during 
> setup, they could get the current value via 
> selinux_status_deny_unknown() without requiring any further system 
> calls.  Or if using netlink selinux notifications, they could call 
> security_deny_unknown() again only when they receive a 
> SELNL_MSG_POLICYLOAD message.  Not clear how to best integrate it here 
> since security_compute_av*() can be called directly or via the AVC.

Actually, I should probably move the security_deny_unknown() call inside 
of map_decision().  Then we can omit it entirely if there is no mapping, 
i.e. caller is not using selinux_set_mapping().  That avoids any extra 
overhead on selinux_check_access() users.

> 
>>       ret = 0;
>>         out2:
>> diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
>> index f205804b..892f887e 100644
>> --- a/libselinux/src/mapping.c
>> +++ b/libselinux/src/mapping.c
>> @@ -8,7 +8,9 @@
>>   #include <stdarg.h>
>>   #include <selinux/selinux.h>
>>   #include <selinux/avc.h>
>> +#include "callbacks.h"
>>   #include "mapping.h"
>> +#include "selinux_internal.h"
>>   /*
>>    * Class and permission mappings
>> @@ -33,6 +35,9 @@ selinux_set_mapping(struct security_class_mapping *map)
>>       size_t size = sizeof(struct selinux_mapping);
>>       security_class_t i, j;
>>       unsigned k;
>> +    bool print_unknown_handle = false;
>> +    bool reject = (security_reject_unknown() == 1);
>> +    bool deny = (security_deny_unknown() == 1);
>>       free(current_mapping);
>>       current_mapping = NULL;
>> @@ -62,8 +67,16 @@ selinux_set_mapping(struct security_class_mapping 
>> *map)
>>           struct selinux_mapping *p_out = current_mapping + j;
>>           p_out->value = string_to_security_class(p_in->name);
>> -        if (!p_out->value)
>> -            goto err2;
>> +        if (!p_out->value) {
>> +            selinux_log(SELINUX_INFO,
>> +                    "SELinux: Class %s not defined in policy.\n",
>> +                    p_in->name);
>> +            if (reject)
>> +                goto err2;
>> +            p_out->num_perms = 0;
>> +            print_unknown_handle = true;
>> +            continue;
>> +        }
>>           k = 0;
>>           while (p_in->perms[k]) {
>> @@ -74,13 +87,24 @@ selinux_set_mapping(struct security_class_mapping 
>> *map)
>>               }
>>               p_out->perms[k] = string_to_av_perm(p_out->value,
>>                                   p_in->perms[k]);
>> -            if (!p_out->perms[k])
>> -                goto err2;
>> +            if (!p_out->perms[k]) {
>> +                selinux_log(SELINUX_INFO,
>> +                        "SELinux:  Permission %s in class %s not 
>> defined in policy.\n",
>> +                        p_in->perms[k], p_in->name);
>> +                if (reject)
>> +                    goto err2;
>> +                print_unknown_handle = true;
>> +            }
>>               k++;
>>           }
>>           p_out->num_perms = k;
>>       }
>> +    if (print_unknown_handle)
>> +        selinux_log(SELINUX_INFO,
>> +                "SELinux: the above unknown classes and permissions 
>> will be %s\n",
>> +                deny ? "denied" : "allowed");
>> +
>>       /* Set the mapping size here so the above lookups are "raw" */
>>       current_mapping_size = i;
>>       return 0;
>> @@ -181,30 +205,49 @@ map_perm(security_class_t tclass, 
>> access_vector_t kperm)
>>   }
>>   void
>> -map_decision(security_class_t tclass, struct av_decision *avd)
>> +map_decision(security_class_t tclass, struct av_decision *avd,
>> +         bool allow_unknown)
>>   {
>>       if (tclass < current_mapping_size) {
>> -        unsigned i;
>> +        struct selinux_mapping *mapping = &current_mapping[tclass];
>> +        unsigned int i, n = mapping->num_perms;
>>           access_vector_t result;
>> -        for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
>> -            if (avd->allowed & current_mapping[tclass].perms[i])
>> +        for (i = 0, result = 0; i < n; i++) {
>> +            if (avd->allowed & mapping->perms[i])
>> +                result |= 1<<i;
>> +            if (allow_unknown && !mapping->perms[i])
>>                   result |= 1<<i;
>> +        }
>>           avd->allowed = result;
>> -        for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
>> -            if (avd->decided & current_mapping[tclass].perms[i])
>> +        for (i = 0, result = 0; i < n; i++) {
>> +            if (avd->decided & mapping->perms[i])
>> +                result |= 1<<i;
>> +            if (allow_unknown && !mapping->perms[i])
>>                   result |= 1<<i;
>> +        }
>>           avd->decided = result;
>> -        for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
>> -            if (avd->auditallow & current_mapping[tclass].perms[i])
>> +        for (i = 0, result = 0; i < n; i++)
>> +            if (avd->auditallow & mapping->perms[i])
>>                   result |= 1<<i;
>>           avd->auditallow = result;
>> -        for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
>> -            if (avd->auditdeny & current_mapping[tclass].perms[i])
>> +        for (i = 0, result = 0; i < n; i++) {
>> +            if (avd->auditdeny & mapping->perms[i])
>>                   result |= 1<<i;
>> +            if (!allow_unknown && !mapping->perms[i])
>> +                result |= 1<<i;
>> +        }
>> +
>> +        /*
>> +         * Make sure we audit denials for any permission check
>> +         * beyond the mapping->num_perms since this indicates
>> +         * a bug in the object manager.
>> +         */
>> +        for (; i < (sizeof(result)*8); i++)
>> +            result |= 1<<i;
>>           avd->auditdeny = result;
>>       }
>>   }
>> diff --git a/libselinux/src/mapping.h b/libselinux/src/mapping.h
>> index 22a4ccaf..12ebb89f 100644
>> --- a/libselinux/src/mapping.h
>> +++ b/libselinux/src/mapping.h
>> @@ -7,6 +7,7 @@
>>   #define _SELINUX_MAPPING_H_
>>   #include <selinux/selinux.h>
>> +#include <stdbool.h>
>>   /*
>>    * Get real, kernel values from mapped values
>> @@ -29,6 +30,7 @@ extern access_vector_t
>>   map_perm(security_class_t tclass, access_vector_t kperm);
>>   extern void
>> -map_decision(security_class_t tclass, struct av_decision *avd);
>> +map_decision(security_class_t tclass, struct av_decision *avd,
>> +         bool allow_unknown);
>>   #endif                /* _SELINUX_MAPPING_H_ */
>> diff --git a/libselinux/src/reject_unknown.c 
>> b/libselinux/src/reject_unknown.c
>> new file mode 100644
>> index 00000000..5c1d3605
>> --- /dev/null
>> +++ b/libselinux/src/reject_unknown.c
>> @@ -0,0 +1,40 @@
>> +#include <unistd.h>
>> +#include <sys/types.h>
>> +#include <fcntl.h>
>> +#include <stdlib.h>
>> +#include <errno.h>
>> +#include <string.h>
>> +#include "selinux_internal.h"
>> +#include "policy.h"
>> +#include <stdio.h>
>> +#include <limits.h>
>> +
>> +int security_reject_unknown(void)
>> +{
>> +    int fd, ret, reject_unknown = 0;
>> +    char path[PATH_MAX];
>> +    char buf[20];
>> +
>> +    if (!selinux_mnt) {
>> +        errno = ENOENT;
>> +        return -1;
>> +    }
>> +
>> +    snprintf(path, sizeof(path), "%s/reject_unknown", selinux_mnt);
>> +    fd = open(path, O_RDONLY | O_CLOEXEC);
>> +    if (fd < 0)
>> +        return -1;
>> +
>> +    memset(buf, 0, sizeof(buf));
>> +    ret = read(fd, buf, sizeof(buf) - 1);
>> +    close(fd);
>> +    if (ret < 0)
>> +        return -1;
>> +
>> +    if (sscanf(buf, "%d", &reject_unknown) != 1)
>> +        return -1;
>> +
>> +    return reject_unknown;
>> +}
>> +
>> +hidden_def(security_reject_unknown);
>> diff --git a/libselinux/src/selinux_internal.h 
>> b/libselinux/src/selinux_internal.h
>> index dfc421cc..70b5025d 100644
>> --- a/libselinux/src/selinux_internal.h
>> +++ b/libselinux/src/selinux_internal.h
>> @@ -59,6 +59,7 @@ hidden_proto(selinux_mkload_policy)
>>       hidden_proto(security_getenforce)
>>       hidden_proto(security_setenforce)
>>       hidden_proto(security_deny_unknown)
>> +    hidden_proto(security_reject_unknown)
>>       hidden_proto(security_get_checkreqprot)
>>       hidden_proto(selinux_boolean_sub)
>>       hidden_proto(selinux_current_policy_path)
>>
> 

