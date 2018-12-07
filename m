Return-Path: <SRS0=Nhvc=OQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5F0C07E85
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 13:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E33020989
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 13:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E33020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbeLGNE0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:04:26 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:24087 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGNE0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Dec 2018 08:04:26 -0500
X-EEMSG-check-008: 664602260|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,326,1539648000"; 
   d="scan'208";a="664602260"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Dec 2018 13:04:21 +0000
X-IronPort-AV: E=Sophos;i="5.56,326,1539648000"; 
   d="scan'208";a="18505886"
IronPort-PHdr: =?us-ascii?q?9a23=3Am3tIoRzZt4gXDRPXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uoXIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ic4cDCuwMNvtaoYbgvVsDtQawCxeiBO3vyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtAUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C/g5ojUbB8hufGMUq?=
 =?us-ascii?q?x2ccHM1EcvEhnKjlGUqYP7PzKey+MAs3OG4Op7Tu+vl24mpB1xojio3MssjJ?=
 =?us-ascii?q?LJiZgPxlDL8iV53p84KNulQ0B4ed6pCIZcui6VOodsQs4uXntktDg1x7EYo5?=
 =?us-ascii?q?K3YS4Hw4k9yRHFcfyIaY2I7wrmVOaWPDh3mmpoeKm6hxau6UigzfD8VtWs3F?=
 =?us-ascii?q?ZKsCVFlt7Mu2gR1xPJ8MiHS+Z9/ly71TaT1wHc9uFEIUcumardN5Eh2aI/mo?=
 =?us-ascii?q?AWsUTCGi/6gET2jKmIeUU44uWk9uvqb7r8qpKcKoN4kB/yP6swlsClHOg0Kg?=
 =?us-ascii?q?0OUHKa+eS42r3j50r5QLBSg/0tj6bZq4vXJdgbp6GlAw9V1Zwv6xCkDzi8yt?=
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/Dfqnm1Sjiiprx/TdM735GJrNM3zDnK7kfb?=
 =?us-ascii?q?Z67E5c0hQ8wcpD6JJTD7ELOOjzVVPptNzEEh85NBS5w/35B9V514MeX3+PA6?=
 =?us-ascii?q?CCPaPMvl+H+PgvL/OPZIALojb9LeYq5/r0gX8+g18dcrGj3YELZ3CgAvRmP0?=
 =?us-ascii?q?KZbGL3jdcEEmcKohc+TeLriFKcVz5efHmyX6cm6TE6DIKqF5vMRoeogO/J4C?=
 =?us-ascii?q?DuJpRLYihjDVeWHD+8b4yZX98UYT+WZ8pmlSYJE7OmTtly+wupsVrB17d/Lu?=
 =?us-ascii?q?fSshYdvJbn2ck9s/bfjjku5Dd0CIKbyGjLQGZqyDBbDwQq1bxy9BQugmyI1r?=
 =?us-ascii?q?J11rkBT4Re?=
X-IPAS-Result: =?us-ascii?q?A2A6AADebgpc/wHyM5BjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VopgWgng3qIGYwQUgaBCC2JEg6OL4F6OAGEQAKDGSI0CQ0BAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCNiQBgmEBAQEBAgEjBBFBEAsYAgImAgIhNgYNBgIBAYJeP4FqAwgFCKUDf?=
 =?us-ascii?q?DOFQIJFDYIcgQuLFBd4gQeBESeCa4JXhS6CVwKJEw+GXzZQjzIuCY4cgykGG?=
 =?us-ascii?q?IFciD2HH4oVhHqLUjiBVSsIAhgIIQ+DJ4InFxKOKSEDMIEFAQGKQAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Dec 2018 13:04:18 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB7D49KP009086;
        Fri, 7 Dec 2018 08:04:11 -0500
Subject: Re: [RFC][PATCH] selinux: avoid silent denials in permissive mode
 under RCU walk
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, bmktuwien@gmail.com
References: <20181204204209.21542-1-sds@tycho.nsa.gov>
 <CAHC9VhTB8ZpHt3fUL4_SY2qaYZUg4au7eLLOBgnpmT-72hmCaw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d6084640-eb4a-76d4-102b-6c71c927f236@tycho.nsa.gov>
Date:   Fri, 7 Dec 2018 08:06:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTB8ZpHt3fUL4_SY2qaYZUg4au7eLLOBgnpmT-72hmCaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/6/18 6:57 PM, Paul Moore wrote:
> On Tue, Dec 4, 2018 at 3:39 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> commit 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
>> results in no audit messages at all if in permissive mode because the
>> cache is updated during the rcu walk and thus no denial occurs on
>> the subsequent ref walk.  Fix this by not updating the cache when
>> performing a non-blocking permission check.  This only affects search
>> and symlink read checks during rcu walk.
>>
>> Fixes: 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
>> Reported-by: BMK <bmktuwien@gmail.com>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   security/selinux/avc.c         | 9 ++++++---
>>   security/selinux/hooks.c       | 4 +++-
>>   security/selinux/include/avc.h | 1 +
>>   3 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>> index 635e5c1e3e48..f0e7bc0dc442 100644
>> --- a/security/selinux/avc.c
>> +++ b/security/selinux/avc.c
>> @@ -1021,8 +1021,10 @@ static noinline int avc_denied(struct selinux_state *state,
>>              !(avd->flags & AVD_FLAGS_PERMISSIVE))
>>                  return -EACCES;
>>
>> -       avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested, driver,
>> -                       xperm, ssid, tsid, tclass, avd->seqno, NULL, flags);
>> +       if (!(flags & AVC_NONBLOCKING))
>> +               avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested,
>> +                               driver, xperm, ssid, tsid, tclass, avd->seqno,
>> +                               NULL, flags);
> 
> I realize the issue here is specific to the VFS code paths, but if we
> are going to introduce a general AVC flag to tell the AVC code not to
> block, it seems like we should honor it everywhere.  I would suggest
> moving the check into avc_update_node() itself (it's static, so
> hopefully any perf impact will be negligible).

Ok, I'll do that.  Just to clarify though, avc_update_node() does not 
block, nor does any of avc_has_perm_noaudit().  The reason we have to 
skip avc_update_node() in the non-blocking aka rcu-walk code path is not 
because it would block but because it would grant the denied permissions 
in the AVC entry and then avc_audit() would subsequently bail with 
-ECHILD since it would block on calling the audit system, and when we 
retry on the ref-walk code path, the cache entry will already contain 
the permissions and nothing will be denied or audited.  So it is a tad 
confusing.  I'll add a comment as well.

> 
>>          return 0;
>>   }
>>
>> @@ -1199,7 +1201,8 @@ int avc_has_perm_flags(struct selinux_state *state,
>>          struct av_decision avd;
>>          int rc, rc2;
>>
>> -       rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
>> +       rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested,
>> +                                 (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
>>                                    &avd);
>>
>>          rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 7ce012d9ec51..9b05f84808d9 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -3196,7 +3196,9 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>>                  return PTR_ERR(isec);
>>
>>          rc = avc_has_perm_noaudit(&selinux_state,
>> -                                 sid, isec->sid, isec->sclass, perms, 0, &avd);
>> +                                 sid, isec->sid, isec->sclass, perms,
>> +                                 (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
>> +                                 &avd);
>>          audited = avc_audit_required(perms, &avd, rc,
>>                                       from_access ? FILE__AUDIT_ACCESS : 0,
>>                                       &denied);
>> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
>> index ef899bcfd2cb..74ea50977c20 100644
>> --- a/security/selinux/include/avc.h
>> +++ b/security/selinux/include/avc.h
>> @@ -142,6 +142,7 @@ static inline int avc_audit(struct selinux_state *state,
>>
>>   #define AVC_STRICT 1 /* Ignore permissive mode. */
>>   #define AVC_EXTENDED_PERMS 2   /* update extended permissions */
>> +#define AVC_NONBLOCKING    4   /* non blocking */
>>   int avc_has_perm_noaudit(struct selinux_state *state,
>>                           u32 ssid, u32 tsid,
>>                           u16 tclass, u32 requested,
>> --
>> 2.19.2
>>
> 

