Return-Path: <SRS0=Nhvc=OQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D87C07E85
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 14:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB62E20837
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 14:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB62E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGOj4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:39:56 -0500
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:59926 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeLGOj4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Dec 2018 09:39:56 -0500
X-EEMSG-check-008: 174530065|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Dec 2018 14:39:52 +0000
X-IronPort-AV: E=Sophos;i="5.56,326,1539648000"; 
   d="scan'208";a="18510151"
IronPort-PHdr: =?us-ascii?q?9a23=3AOppy6RU72H51SZ3J1+6qSEVpOSPV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSOuKdThVPEFb/W9+hDw7KP9fy4CSpYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLxi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHH2w6M63e?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoRS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJqXhDY/QLnjHi7rhZa?=
 =?us-ascii?q?xy61NYyAYqyNBf4JVUCqsfL/7pRkDxs9nYBAcjMwOo2+bnFMl91oQGVGKUHK?=
 =?us-ascii?q?CZNKLSsVmV5uMgOOSMeoAVtyjnK/Q/5P7hk2U5mVkDcqmtx5cXb2q4Hvt+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmV+PqjV6CUSJOZ3e8XqIz+Dc7BZmpDYfGXI+tgbiB0D?=
 =?us-ascii?q?2nEZ1RY2BMEkqMHmvwd4WYR/cMbzqfLdF5kjMeT7ihSpQh2Aq2tADg0bpnL/?=
 =?us-ascii?q?HU+jUctZ35yNd6+ffflRYo9Tx7F86dyX2CT3lonmMUQD87xL5/oU1nyleEyq?=
 =?us-ascii?q?V5guJXFdpS5/NXSAs6MZ/cz+pnC9H9QA7Bec2JSFm8TtW7AjE7VsgxzMMWY0?=
 =?us-ascii?q?ZhB9WiiQjO3y6rA78TiryKC4U48qzH33fsOcl91WjJ1K06glk4TctAK3emir?=
 =?us-ascii?q?R89wfNHY7JlVuWl6KweaQbxi7N+zTL8W3bhEhFVEZVVqLfUDhLfkLLqfzh71?=
 =?us-ascii?q?7GCrqpDq4qdABGzJjRBLFNb4jSkVheRPrlcO/bama1lnb4UQ2E3ZuQfYHqfC?=
 =?us-ascii?q?MbxyybB08axVNAtU2aPBQzU3/y61nVCyZjQBe2ORvh?=
X-IPAS-Result: =?us-ascii?q?A2BdAAAOhQpc/wHyM5BjHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?VopgWgng3qUKVIGgQgIJYkSDo4vgXo4AYRAAoMbIjUIDQEDAQEBAQEBAgFsK?=
 =?us-ascii?q?II2JAGCYgEFIwQLAQVBEAkCGAICJgICITYGDQYCAQGCXj+BagMIDYlOm1B8M?=
 =?us-ascii?q?4gDDYIcgQuLFBd4gQeBEScMgl+CV4UuglcCiRMPhxVQjzIuCY4cgykGGIFci?=
 =?us-ascii?q?D2HH4oVhHqLVAMzgVUrCAIYCCEPgyeCJxcSjikhAzCBBQEBikABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Dec 2018 14:39:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB7Ednae021889;
        Fri, 7 Dec 2018 09:39:49 -0500
Subject: Re: [RFC][PATCH] selinux: avoid silent denials in permissive mode
 under RCU walk
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, bmktuwien@gmail.com,
        Eric Paris <eparis@parisplace.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        linuxfs <linux-fsdevel@vger.kernel.org>
References: <20181204204209.21542-1-sds@tycho.nsa.gov>
 <CAHC9VhTB8ZpHt3fUL4_SY2qaYZUg4au7eLLOBgnpmT-72hmCaw@mail.gmail.com>
 <d6084640-eb4a-76d4-102b-6c71c927f236@tycho.nsa.gov>
Message-ID: <fb3cb728-afbf-c8c8-1190-60e2efd87719@tycho.nsa.gov>
Date:   Fri, 7 Dec 2018 09:42:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <d6084640-eb4a-76d4-102b-6c71c927f236@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/7/18 8:06 AM, Stephen Smalley wrote:
> On 12/6/18 6:57 PM, Paul Moore wrote:
>> On Tue, Dec 4, 2018 at 3:39 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> commit 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
>>> results in no audit messages at all if in permissive mode because the
>>> cache is updated during the rcu walk and thus no denial occurs on
>>> the subsequent ref walk.  Fix this by not updating the cache when
>>> performing a non-blocking permission check.  This only affects search
>>> and symlink read checks during rcu walk.
>>>
>>> Fixes: 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
>>> Reported-by: BMK <bmktuwien@gmail.com>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>>   security/selinux/avc.c         | 9 ++++++---
>>>   security/selinux/hooks.c       | 4 +++-
>>>   security/selinux/include/avc.h | 1 +
>>>   3 files changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>>> index 635e5c1e3e48..f0e7bc0dc442 100644
>>> --- a/security/selinux/avc.c
>>> +++ b/security/selinux/avc.c
>>> @@ -1021,8 +1021,10 @@ static noinline int avc_denied(struct 
>>> selinux_state *state,
>>>              !(avd->flags & AVD_FLAGS_PERMISSIVE))
>>>                  return -EACCES;
>>>
>>> -       avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested, 
>>> driver,
>>> -                       xperm, ssid, tsid, tclass, avd->seqno, NULL, 
>>> flags);
>>> +       if (!(flags & AVC_NONBLOCKING))
>>> +               avc_update_node(state->avc, AVC_CALLBACK_GRANT, 
>>> requested,
>>> +                               driver, xperm, ssid, tsid, tclass, 
>>> avd->seqno,
>>> +                               NULL, flags);
>>
>> I realize the issue here is specific to the VFS code paths, but if we
>> are going to introduce a general AVC flag to tell the AVC code not to
>> block, it seems like we should honor it everywhere.  I would suggest
>> moving the check into avc_update_node() itself (it's static, so
>> hopefully any perf impact will be negligible).
> 
> Ok, I'll do that.  Just to clarify though, avc_update_node() does not 
> block, nor does any of avc_has_perm_noaudit().  The reason we have to 
> skip avc_update_node() in the non-blocking aka rcu-walk code path is not 
> because it would block but because it would grant the denied permissions 
> in the AVC entry and then avc_audit() would subsequently bail with 
> -ECHILD since it would block on calling the audit system, and when we 
> retry on the ref-walk code path, the cache entry will already contain 
> the permissions and nothing will be denied or audited.  So it is a tad 
> confusing.  I'll add a comment as well.

Hmm...looking again, I'm confused by the current logic in slow_avc_audit():

	/*
	 * When in a RCU walk do the audit on the RCU retry.  This is because
	 * the collection of the dname in an inode audit message is not RCU
	 * safe.  Note this may drop some audits when the situation changes
	 * during retry. However this is logically just as if the operation
	 * happened a little later.
	 */
	if ((a->type == LSM_AUDIT_DATA_INODE) &&
	    (flags & MAY_NOT_BLOCK))
		return -ECHILD;

Since we only do this in the LSM_AUDIT_DATA_INODE case, it isn't clear 
to me why we are passing down MAY_NOT_BLOCK from 
selinux_inode_follow_link(), which always sets type to 
LSM_AUDIT_DATA_DENTRY. If we truly don't need special handling of 
MAY_NOT_BLOCK within the AVC except for LSM_AUDIT_DATA_INODE, then we 
don't need to pass it down from selinux_inode_follow_link() and 
therefore don't need avc_has_perm_flags() at all since that is the only 
user.  Can we dispense with that?  Or is the logic in slow_avc_audit() 
wrong and we ought to be bailing on MAY_NOT_BLOCK for more than just 
LSM_AUDIT_DATA_INODE?  Passing MAY_NOT_BLOCK down to the AVC also seems 
like a misnomer, since it shouldn't be making blocking calls anyway.

> 
>>
>>>          return 0;
>>>   }
>>>
>>> @@ -1199,7 +1201,8 @@ int avc_has_perm_flags(struct selinux_state 
>>> *state,
>>>          struct av_decision avd;
>>>          int rc, rc2;
>>>
>>> -       rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, 
>>> requested, 0,
>>> +       rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested,
>>> +                                 (flags & MAY_NOT_BLOCK) ? 
>>> AVC_NONBLOCKING : 0,
>>>                                    &avd);
>>>
>>>          rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 7ce012d9ec51..9b05f84808d9 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -3196,7 +3196,9 @@ static int selinux_inode_permission(struct 
>>> inode *inode, int mask)
>>>                  return PTR_ERR(isec);
>>>
>>>          rc = avc_has_perm_noaudit(&selinux_state,
>>> -                                 sid, isec->sid, isec->sclass, 
>>> perms, 0, &avd);
>>> +                                 sid, isec->sid, isec->sclass, perms,
>>> +                                 (flags & MAY_NOT_BLOCK) ? 
>>> AVC_NONBLOCKING : 0,
>>> +                                 &avd);
>>>          audited = avc_audit_required(perms, &avd, rc,
>>>                                       from_access ? 
>>> FILE__AUDIT_ACCESS : 0,
>>>                                       &denied);
>>> diff --git a/security/selinux/include/avc.h 
>>> b/security/selinux/include/avc.h
>>> index ef899bcfd2cb..74ea50977c20 100644
>>> --- a/security/selinux/include/avc.h
>>> +++ b/security/selinux/include/avc.h
>>> @@ -142,6 +142,7 @@ static inline int avc_audit(struct selinux_state 
>>> *state,
>>>
>>>   #define AVC_STRICT 1 /* Ignore permissive mode. */
>>>   #define AVC_EXTENDED_PERMS 2   /* update extended permissions */
>>> +#define AVC_NONBLOCKING    4   /* non blocking */
>>>   int avc_has_perm_noaudit(struct selinux_state *state,
>>>                           u32 ssid, u32 tsid,
>>>                           u16 tclass, u32 requested,
>>> -- 
>>> 2.19.2
>>>
>>
> 

