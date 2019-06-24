Return-Path: <SRS0=g6d+=UX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AB6C48BE9
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 16:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4005C20674
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 16:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SHRb5M7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfFXQjJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:39:09 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:37304
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727182AbfFXQjJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 12:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561394347; bh=i80H+0l4k8Sqi03iDiFVTf2XE7W38ih/MMPxE55wpGQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SHRb5M7XKp4TxDDz5iXYeKjXRLC4sDaFh84pBkys6FW7rLJyW1gd19oM+CP3dl7+92oTJKnnAeq14eXPRB/1AMna42kXc2m7P5vEETyEr4f7Q7h0eOZMCgqkT93kDD683upQ4j3T5G9R2/59SO4tmJkbMnIl6HII/9GXxcO6NYrfcxjPWLuxDngxTRokth4oG4BmQOvsZb7vv7ykVZGbmiSeDidKE3AuHUOtehxFSk41wDTLhHYCOin/JULTJ3IwDfRjytdcjjJFODg4xdPjqGdfzegsO/qdxoEprboj8Sg0BHEuXmEUcicykmxbd65u8ar8hZAFwK5ldzOg+nlXIw==
X-YMail-OSG: Z25EKlgVM1mBAPruuuG6mHihhry2oLWqRxxA6LgZAKVN4lzYYgyuX_0PtesQYrG
 FGyMIpbBBSbUFu9TK.KBwR4oMcTDprZ3DmqapexAyvIuiBiW1oiCW_dBNYzNO2EXDwu9CAHIe8JK
 xSkYdxj9.TeDdO9k54.nb36Aejgyvr9CuHcxu2gM1l2zqzxP3QAL.YhgHUDsYjETFL_NsZDbXzxp
 wBndCFDOxRgmxXCPx87LuIvl9QK743indxPx4g9ZOfx8draWpxPoBKYY0.Sj8l6Ip1VJ0s.KValX
 d_2UJXI0k0U4XtTeaByzLL.QKYEUFPL39uPbN48F4hxMuC3fs34RTKvXRuvD6dZMACwvrWo5_poC
 8X8KeS69toyO7ToNAIvKm.9nIum9xUZjxwY0H0wz_zbVwrIiL2AxsV6LpWbludPShzzqXgkZNkwQ
 OleDibhJA52OxLrAUUQiHtSFOZsnDpVmPF3m6NX7duwREO4fpgyz6y.KCduJ7AmaLyi0a3XeiB8b
 lAZIrlCszb7vJc5tMG_3a_YNTIXk9Jkt3TEoIFC3DbWqASTCUDOc7H2x6p03RoKw82cz8kyj.x50
 4MHqsGrLULnO09FOltcjotPs6uS8DG7o.uZ3uQhsAw2VJsWpq1QZj1W33st4jQF_mI0t7E00bUTY
 MGSV1QV2s38FWFkPJ0kqTcJbuEKZbJ5vDgOxnvpL9o5W7CTku1BGuXrrZ3f_.rRUEdXftHlsvJo9
 h60eKO5KwzbbMP03_gYnSNN5Y1akUJRLr.yZ.Oy5Ud26h8Iou05q4BeML5WbxaY3eV7QcE61U2sl
 JaPpTgbmVoYB84ZWsjwEYRA9vYMEhRhqEXoaGX8dLYVk7wMs3G.QIJZJbgeLLx4XEnmp81m_7O1H
 Xep7boSO4RXOa4EQRHDT1eEBlgwdmb2bFbLDj5EcXhN23Mg1.aLUOga9iTsnlX4ouCdctuwOdtRw
 dmoVhOzWlyPTbOEEMKV3uAm4kaEO0N.1xR9l0a_nbVT3habGws7As0.sMyF38Wl7xml6DIfnDHG7
 .VeZAHTB9CqO4PkAFkRqvDQAu37yHPMfpaPFyrI8mJKjAc4f1WPHqSSThN_U6FXMg6mJx8M3gb9w
 0oFvqy9nxFnbUXzR1mn8Nswz32FzfWR2Ok5tlkJXogJ7L0xOM7RMjGY8oC.fXTvuEcvXTSkX7Dss
 CqNpiHVlVPy3yFymtmbVvBWFuv1.FVeCdkKJvrZJdKJZ67ZoixkS3eEMpa5GM5DP_9RJ94evJwS9
 jXfhBULpfuvvC6DiXxuqk2M70
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Jun 2019 16:39:07 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID bc45ba626a5babb2395b0b3479fbc6f3;
          Mon, 24 Jun 2019 16:39:06 +0000 (UTC)
Subject: Re: [PATCH v3 10/24] Use lsmblob in security_ipc_getsecid
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-11-casey@schaufler-ca.com>
 <201906221545.43D54F0F@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <a70ad13e-bc69-ef03-1f9a-3378c38cae23@schaufler-ca.com>
Date:   Mon, 24 Jun 2019 09:39:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201906221545.43D54F0F@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/22/2019 3:48 PM, Kees Cook wrote:
> On Fri, Jun 21, 2019 at 11:52:19AM -0700, Casey Schaufler wrote:
>> There may be more than one LSM that provides IPC data
>> for auditing. Change security_ipc_getsecid() to fill in
>> a lsmblob structure instead of the u32 secid. The
>> audit data structure containing the secid will be updated
>> later, so there is a bit of scaffolding here.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> One thought below...
>
>> ---
>>  include/linux/security.h | 7 ++++---
>>  kernel/auditsc.c         | 5 ++++-
>>  security/security.c      | 9 ++++++---
>>  3 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index c6cddeff8a17..0d5e172341fc 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -413,7 +413,7 @@ int security_task_prctl(int option, unsigned long =
arg2, unsigned long arg3,
>>  			unsigned long arg4, unsigned long arg5);
>>  void security_task_to_inode(struct task_struct *p, struct inode *inod=
e);
>>  int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
>> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
>> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob=
 *blob);
>>  int security_msg_msg_alloc(struct msg_msg *msg);
>>  void security_msg_msg_free(struct msg_msg *msg);
>>  int security_msg_queue_alloc(struct kern_ipc_perm *msq);
>> @@ -1098,9 +1098,10 @@ static inline int security_ipc_permission(struc=
t kern_ipc_perm *ipcp,
>>  	return 0;
>>  }
>> =20
>> -static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, =
u32 *secid)
>> +static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
>> +					 struct lsmblob *blob)
>>  {
>> -	*secid =3D 0;
>> +	lsmblob_init(blob, 0);
>>  }
>> =20
>>  static inline int security_msg_msg_alloc(struct msg_msg *msg)
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index d31914088a82..148733ec3c72 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -2268,11 +2268,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct=
 mq_attr *mqstat)
>>  void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>>  {
>>  	struct audit_context *context =3D audit_context();
>> +	struct lsmblob blob;
>>  	context->ipc.uid =3D ipcp->uid;
>>  	context->ipc.gid =3D ipcp->gid;
>>  	context->ipc.mode =3D ipcp->mode;
>>  	context->ipc.has_perm =3D 0;
>> -	security_ipc_getsecid(ipcp, &context->ipc.osid);
>> +	security_ipc_getsecid(ipcp, &blob);
>> +	/* scaffolding on the [0] - change "osid" to a lsmblob */
>> +	context->ipc.osid =3D blob.secid[0];
>>  	context->type =3D AUDIT_IPC;
>>  }
>> =20
>> diff --git a/security/security.c b/security/security.c
>> index 5ab07631df75..d55f01041f05 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1812,10 +1812,13 @@ int security_ipc_permission(struct kern_ipc_pe=
rm *ipcp, short flag)
>>  	return call_int_hook(ipc_permission, 0, ipcp, flag);
>>  }
>> =20
>> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
>> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob=
 *blob)
>>  {
>> -	*secid =3D 0;
>> -	call_void_hook(ipc_getsecid, ipcp, secid);
>> +	struct security_hook_list *hp;
>> +
>> +	lsmblob_init(blob, 0);
>> +	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list)
>> +		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->slot]);
> Just for sanity when using hp->slot, it might be good to do something
> like this in the places it gets used. Like for here:
>
> 	if (!WARN_ON(hp->slot < 0 || hp->slot >=3D LSMBLOB_COUNT))
> 		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->slot]);
>
> This _should_ be overkill, but since lists of hooks that trigger slot
> assignment is hardcoded, it seems nice to cover any future problems or
> mismatches.

How about a CONFIG_LSM_SLOT_CHECK around a function lsm_slot_check()?
If configured, it does the WARN_ON, and if not it's a static inline
true return. As you say, it's probably overkill, but it would be availabl=
e
for the paranoid/debug/bringup situation.


