Return-Path: <SRS0=g6d+=UX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0331C43613
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 17:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6919720657
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 17:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VDTkiUNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbfFXRU7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:20:59 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:44406
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731245AbfFXRU7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 13:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561396857; bh=bNleVLXsAk5n7HvASEWpuoKZTAvHaFR8soZlDmPewwo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=VDTkiUNtlDf73X+pvh7QhKZVlbIfeLfSjHlJK4cGXIl5sR4WolaJxJN6drbi876vzze6f25vw1iVMDR50T5Cwh1p/sXQ7RwMIN2nZLOo6sZ2q/6WbIgdoHc5xPYQw/FiGQ5zQwlaeVl/MnZXOBHdY1CCx0s9x855MYUZHVmTuiXZenk2YUByaSnpYwdZ8Vhg8AtgbKvc9tY0QDApkshJtEKyHUkmoboJaI6xOU9TznRCW0dXIBmZD3QIkBv+0XJvhfmpR/jvfzr0Mh2GBPaI9Miw7nqcUlV0OAgB/T4GsPX6hmUbcNGvaZ/Sa5Zym+3O0s+5SaPuaAzTkvOh883ifA==
X-YMail-OSG: ctmh1hAVM1m5DSrbermjAdaItOXvwtDBeU6X6can4nzM5_Z29seFy.Oa5B3jabq
 PxX4WUIxxzl2snDTCd3Mk7cK2p1Bs3Nkun7HDWohguTqRdNVme8HxFQMg28KbX8dOnn.9x3uXRB_
 FSDATnHnNDPYVXPgpSU9uGN.jTk4sV5DuNzZBLkntTw6NXT.GGTh4Amo1uFf8kF_LCj.z0KosPdP
 _VAgI4OGfV1b05V3tRCm4aD_GoEtCxjW3i_bcpmgLcTOwFUAeX6Qb6lm0SxVtRE10IGmnzf4VV0Z
 v89wIo8aHaROYXsZ2IRHGAxjJJeVldfdgM30zE7HvHlsqrbr2bc9EOKHn2VJZuAgO6xM58WpCdom
 e72k8dmyH4GR.3AuStx8T.hym1BZ5yEmy7IOuEWtudWGWaVQ7DmuhRo4HS2XVeGI1PyqdaW3FyG2
 Io8k2kal4jOVvQXs9a4lLtcui9ijfLnXWSG.vdcRas90nUuzI9G4H4QqX0sUVnhd0nCsZQKRpPI4
 8gS5IuXzRbCXajk2dBh1TfbnpFF9PMQPGjfyU4zH5IRCYB528jem_pHS1Lgtbulbx4Ig8yMg05ie
 syqeg4pTLnmToejHRKR12zQDUrsDMd_lQNKCaNLGtSp8fKIfz.5p7mn7EY.V_6cB7g8GAsEJRgiL
 HqtVDTmKqg9IeSbGuT6fW1Gy3K8Yj7zq0_1PPZ.s6f1GWLUusKaXMF5IFjjHH_Bo9IpeftbgBegE
 D4bNmoJS4YRk96hFQUrmo89zFknWhZIUc3amNHfBXHhJFQ_D_sMVLAB0PrH1YrsLKaZMmQ0z7kjy
 85FWjIMD3oGYEepomNTFOxZxqVOw5MP9Os3g1ulJZZxlmrX8_bfYZi1PnSeugwh4elg5TJdWhkk1
 q4C_I1EswaYU8e9l5la4SATE35.xKqD5Vz_RM.vwrxQGL2643SxESG6D_W_BJl3kenemov6l2kyV
 lwmaHacsrTmavPCA_EydrPMotphHhpETY2XNs2zEooyeYlH1p53az_PZ.IwGtJTiav7JdH0CoDCs
 k79NShGuL7WpqMtdKIYJVL7jZvo4aGQH1Ox78y.aWdmxgDuEoLq44qxP3VpnVZLybh5sIYddj_JO
 4OBemko3OQZDncXVCqhR9ZUWV6AW_ZjEqN_H7n5muSqauFBQSfJY14uS4o45V6gi2hrVJa2Wzx4.
 Qrora.FwZHFO9C8mEPPkOvRQCyBa_jHucyBKYLkXrbs.p5Cz4iZXbPiWgzNbLPktsALGVbKfyWGA
 dkWUvHeXh465_HpPJA7GYTsYZVyNkgOs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Jun 2019 17:20:57 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 37efc4023587529209d32cc9457bd461;
          Mon, 24 Jun 2019 17:20:56 +0000 (UTC)
Subject: Re: [PATCH v3 10/24] Use lsmblob in security_ipc_getsecid
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-11-casey@schaufler-ca.com>
 <201906221545.43D54F0F@keescook>
 <a70ad13e-bc69-ef03-1f9a-3378c38cae23@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <10b14dda-7a02-42df-b427-72c8b875de97@schaufler-ca.com>
Date:   Mon, 24 Jun 2019 10:20:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a70ad13e-bc69-ef03-1f9a-3378c38cae23@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/24/2019 9:39 AM, Casey Schaufler wrote:
> On 6/22/2019 3:48 PM, Kees Cook wrote:
>> On Fri, Jun 21, 2019 at 11:52:19AM -0700, Casey Schaufler wrote:
>>> There may be more than one LSM that provides IPC data
>>> for auditing. Change security_ipc_getsecid() to fill in
>>> a lsmblob structure instead of the u32 secid. The
>>> audit data structure containing the secid will be updated
>>> later, so there is a bit of scaffolding here.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> One thought below...
>>
>>> ---
>>>  include/linux/security.h | 7 ++++---
>>>  kernel/auditsc.c         | 5 ++++-
>>>  security/security.c      | 9 ++++++---
>>>  3 files changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index c6cddeff8a17..0d5e172341fc 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -413,7 +413,7 @@ int security_task_prctl(int option, unsigned long=
 arg2, unsigned long arg3,
>>>  			unsigned long arg4, unsigned long arg5);
>>>  void security_task_to_inode(struct task_struct *p, struct inode *ino=
de);
>>>  int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);=

>>> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
>>> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblo=
b *blob);
>>>  int security_msg_msg_alloc(struct msg_msg *msg);
>>>  void security_msg_msg_free(struct msg_msg *msg);
>>>  int security_msg_queue_alloc(struct kern_ipc_perm *msq);
>>> @@ -1098,9 +1098,10 @@ static inline int security_ipc_permission(stru=
ct kern_ipc_perm *ipcp,
>>>  	return 0;
>>>  }
>>> =20
>>> -static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,=
 u32 *secid)
>>> +static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,=

>>> +					 struct lsmblob *blob)
>>>  {
>>> -	*secid =3D 0;
>>> +	lsmblob_init(blob, 0);
>>>  }
>>> =20
>>>  static inline int security_msg_msg_alloc(struct msg_msg *msg)
>>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>>> index d31914088a82..148733ec3c72 100644
>>> --- a/kernel/auditsc.c
>>> +++ b/kernel/auditsc.c
>>> @@ -2268,11 +2268,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struc=
t mq_attr *mqstat)
>>>  void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>>>  {
>>>  	struct audit_context *context =3D audit_context();
>>> +	struct lsmblob blob;
>>>  	context->ipc.uid =3D ipcp->uid;
>>>  	context->ipc.gid =3D ipcp->gid;
>>>  	context->ipc.mode =3D ipcp->mode;
>>>  	context->ipc.has_perm =3D 0;
>>> -	security_ipc_getsecid(ipcp, &context->ipc.osid);
>>> +	security_ipc_getsecid(ipcp, &blob);
>>> +	/* scaffolding on the [0] - change "osid" to a lsmblob */
>>> +	context->ipc.osid =3D blob.secid[0];
>>>  	context->type =3D AUDIT_IPC;
>>>  }
>>> =20
>>> diff --git a/security/security.c b/security/security.c
>>> index 5ab07631df75..d55f01041f05 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -1812,10 +1812,13 @@ int security_ipc_permission(struct kern_ipc_p=
erm *ipcp, short flag)
>>>  	return call_int_hook(ipc_permission, 0, ipcp, flag);
>>>  }
>>> =20
>>> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
>>> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblo=
b *blob)
>>>  {
>>> -	*secid =3D 0;
>>> -	call_void_hook(ipc_getsecid, ipcp, secid);
>>> +	struct security_hook_list *hp;
>>> +
>>> +	lsmblob_init(blob, 0);
>>> +	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list)
>>> +		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->slot]);
>> Just for sanity when using hp->slot, it might be good to do something
>> like this in the places it gets used. Like for here:
>>
>> 	if (!WARN_ON(hp->slot < 0 || hp->slot >=3D LSMBLOB_COUNT))
>> 		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->slot]);
>>
>> This _should_ be overkill, but since lists of hooks that trigger slot
>> assignment is hardcoded, it seems nice to cover any future problems or=

>> mismatches.
> How about a CONFIG_LSM_SLOT_CHECK around a function lsm_slot_check()?
> If configured, it does the WARN_ON, and if not it's a static inline
> true return. As you say, it's probably overkill, but it would be availa=
ble
> for the paranoid/debug/bringup situation.

=2E.. or maybe it would be better if security_add_hooks() had an
explicit parameter whereby an LSM can tell the infrastructure that
it wants a slot. The only future problems would come if the LSM
writer got the parameter wrong or if secid dependence got added
to an existing interface and a LSM that didn't used to need a=20
slot suddenly did. I don't see either of those as compelling.


