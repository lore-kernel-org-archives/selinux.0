Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24D18027
	for <selinux@vger.kernel.org>; Fri, 11 Oct 2024 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664453; cv=none; b=mvnY8XmAbYDRoDoqBdo5+QjnIi+KGdAfAXSF5Rfp+ETzVPTxSNCqOiYa8lxB5EkL6B3i3+XNe9+hyxFUtaR8pUR2UC7inyziJ9FPEqaph7yLQ6purmUQxh3Zuk+0XN+EnsWcn14q2y10dVK33HAS2xqGMUnPUgr59uArI8A0OtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664453; c=relaxed/simple;
	bh=e+9kzhUJ+tnucZs7OOGtFidzLYWCzsiTmsIeavg7j5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWgGsiIn8T0Id8Wpig9zB8o8Yo+bzK77HKBIvOOKUQQmGcuqTtCSjXhRfEDcKhzmALP5b+/SFNKUWjSbXaEGG6tMaOakVaiSgJSo6qnEYhrxYEz+My8v5vm1RpS51RW6zUiUru5ssUFdIUsGTDIJMPr9Lp+UhfUkbHTkqKmXWCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=R28FICU5; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="R28FICU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728664445; bh=lurWTRWfGmxvBkgBW61dJhEER75ryLb3QoDneiV+T04=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=R28FICU5RTRNDdjzVJx/HmoJseTDvUwazmuOb5rphyEW6KsaxvLCui2eyMDjjzgTj/QJcBxcsGE4UdEwXYCnrx8PXYHY8+Go/knjmZH72dnNJqsY7ZFqh0PONkDP5E4OzKPUZS2bh4AAkDjBcMMuMFzzBXVQSD3Ks/j2n3cH64s29Iii2Mm18AWjG5VG3JQUaktOQG+yQkjaKK55WLOfmGUUWViB8Jh2mnxDYql5Pkfuy2+MNBGgpQ1EyOOIz/OkSDDcPrXFzzUH6u/oMdNcfgp/ZVKaNlNCAmWDLXFfXLayjeCFecdDXYOBzxtz9KKSQSzl7jqdv7fYLBlnt2awvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728664445; bh=mZOdNhGWrv7eCsxxostaqKVQxCDMMRCnvvxPoWKuNot=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RmtXx87ab1RN/2u4DvAtvP49uQ1gcKr2kPnpxIoQoMGgb9w0upF6iDYX8cZpqDVFQkvByZEIs6lryKsaANwLmYCJkVSWtsdLY+Zb33WAQPv5ESGSd+3UVK20wk1WtPMVl0LO6hpSzpNWDKNdKC12tBbuvmXjFdoSfkXm5zTAlokta6owOeaw1cjBPfndSnC0aWMc7nlL1Vyxy5n6Y36kYEeg1aRykqy6ucpnZqHXb3b4LfGOArSrlHXY85ZUNEP8ETChAwyW51E66929FsaXSRquTkiRK/9nZBuf/eQnecaylXvT9xePJTPL2sWFo0tYM8RgmNyWfq4c5nwxdqd88A==
X-YMail-OSG: fw6cvC8VM1lGeRaLbY6pdYINehhgm52GLEs07CFszb1tBbg8mkmIfrfGCsOFtp7
 xJWsXLOnFH3tKr_.r2s57Jz04od.CJv8M.TTZrOx8PtxOVy.FbpHCvfImuan5wnWHyYV1WsMkyZx
 8HRXRJcOc5csI_qxfqM9W2rxDahFBVrr5Rp2kdiN_5P_vW8DHbHTByhm3d4fi0yKJzaB9DUQoi16
 Czzsnr1gp6bFBsAuz37P0dOJmMn6hiu1JGZQjV87bCx3bkuqi9vl3DGHOCWoRD3kxq93bpC64U27
 62qjI_HxTt89_EeibN22Lb046QEoN_v3JzWPQU2oJ1l5MNZzRwjcG9ecVmhY.fA1PTCRbHaihCll
 0L2Eb.ig5Bx8o6KWDMtiz..I6.iQZuYbM6lPD9oiFS4qI.BxBN0xzHXJmOA5.3rl3.OMDYn9Umkm
 Qqpi_ezajXR7FMs1L86mHRaDMLyljDJCHWO8GO4_IYrNI30CH40mRrUrKncGqjIVQUcjf2dEJnl.
 LYz4j5REZTH0J1KI9eGIZzRNqYWUBcUVHUr1rSeuQQ5_EWqYgj5Iv8tzhbRw7sjUl4ERG81gbRgS
 c7stkR0eEvwe_.jt1zyvdz_yyYN120CH3CEM3ybvrqCCKW7AzYdh6AOGHtz0MaqYDsgnZJD5XrR4
 poEtK7OA7..2jg5odPt9E9j3L87MoE6.a.MhMB2keNo.pveNaVq9Tf2nqmyQWRJlHKy1RdDDz2xj
 S5LQ16aC5MKzAM_sau60uRD9eIaueEJ8y7JHkTlaaU15YVVj_6wHeEbIziJHrZvaJ00WFkk6.GGT
 r6Mt6QRSxl5xdkEcuwL0ZFwHPZ4vBPDK2RypWVdDFPb21m.rVC4h7sdR1pmWnEs5RFSJmZsqoWeO
 RnWuFHKucKemTp9VlGtsYZb.UHKJmb.U11yO4_k.IObdaJBfZ_6zvMqDsCGiu.0bLmOD82wKnXnk
 h9uAtJoNqgZVZZ16PuJ3AqMZ1S0dlMf6csATeLirJMu.DrtiTZu2VHO4DqufSmPS.PIC0A3vRWsw
 OaQKHY6hDkoY53nm4mWeFZRjuYLQZqdvZj6NMpDL.58ieN29oD3zbL5rlFc.4Oi9cMzcfDbXUcSh
 z82Z5kQxOdA5CNvwl4QiYKPnjBG0SefGME4XyJZUYEBEE6orBhDBGVI5BTXon28yeSLD0PQGzttd
 KPFqZ21sRgKAxl_TbBEpQjNxe.GFko0iPh596lXlitWud3Rf_gkaogAfAw6a1bZAYa7uaCZX9HgO
 5lzeFDPnqChADZfwMp29LRV0NXNmezRcPy0lyq4ZZ22W9yKFCznS5EROEVdpBsg0jKd71WO0sBza
 J_Xo_iGKw8lCuKOZBkEpwDoB2sFarpoIeuJ6U5Rym9A2Qzwm9FZw1FWhcsKBhyEP0qeuElyk4b7w
 F148N9LR8hpKFJ0HMBwD4vdcuHbAiBRNEj5QJQzckiLDNl5Map24uGPehhwrdev1VlAtXtCfU34g
 FwS3T68hQ7UBRAvGTZPv8mD7zH08.LnsXG4Y8qbwnVTimmcSNygBEH89N3cOG.NHzeHvHjCi2l6S
 lhPNNf2g8eCc.bE7GmvYVeXdJqwNIunr5MVAsYPnjgSSkeT9yNUVjNAc9cgZqgsB9OnOuEYVwFCr
 n2O6Sdkc7eilGCCe8kV2nZt8thsM2S81o9K7d1IIZaLO9c_BpFjQ.9izmY8N6JXKrDdHlOvUKSGl
 Ahq1TBI0wMnirRZtjUhZRSF8r1vNEUnaDn4C4db1GQlkY56AJI8_5xP1ja8naoTP1LDfSANIOlAR
 Lwv_BEaFY5AltHkO1jKAg5IBUmqnGSnkm20jOh5lgjLKPO0bBWTl155.XXDfn1JeVIJkq5MuBKUl
 WxCoZrubrPDe.dG1S31btGjq.5oFAJNvIVNUun00IslkKuLZRPp.gSDDIAcea4xzDPHC2XHLkjx8
 AYjSSaFy9D0MRKMeVDwQmBgA4D227QCiBCVoPpJO75qzF2Yxp9Dg6OzPNdrS6g6DNx8KWBC5z.2Y
 xZqJwmW5r7n7bWOQmjqVw7f2i8OqR55BCPRfrplWphhLJ6iqoU6VOzUaYqfQrEfbMTXh4.WdQTrq
 xMQsCtixCveJSmdRGWd.yK7CPMps8DkMkeeVmQDdlfW6uLOm.VFLoub1cfa3DntEEh.WmzxwVtq2
 eWs_FWtRdcS2qAhYoEWvZ2kfT34RdmTJA24feW_puJ3dDraCFJ5RIHbHB8kpJ4U74wRliepWmxbQ
 p9MKKCUXfdwV2Yo9vtDKbqIrDxTRZ5u8bfC8oe0sU0tg2XGGd.ECZw1jM9IJ2ZM9d.R3NK.1ZrTu
 ub6BVruQtehcyTp3SGGuXS34xvuri7Wg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9dbf66ff-57a0-4509-bec2-32255002911d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Oct 2024 16:34:05 +0000
Received: by hermes--production-gq1-5d95dc458-gnv6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 69b34e485aa7d5c01254829018687508;
          Fri, 11 Oct 2024 16:34:03 +0000 (UTC)
Message-ID: <c3423767-91df-4dc9-afe8-895540b185d7@schaufler-ca.com>
Date: Fri, 11 Oct 2024 09:34:01 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/13] Audit: maintain an lsm_prop in audit_context
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241009173222.12219-5-casey@schaufler-ca.com>
 <4e2669fc0be9b0f1ca15b17ca415a87d@paul-moore.com>
 <a4094e38-44c9-4ab2-9b37-c1eafee16d5e@schaufler-ca.com>
 <CAHC9VhSaCVvj-+U+WEBxvzXyi=FPNaL7HMt4Kg86Ugi1SNnCdg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSaCVvj-+U+WEBxvzXyi=FPNaL7HMt4Kg86Ugi1SNnCdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/11/2024 9:11 AM, Paul Moore wrote:
> On Fri, Oct 11, 2024 at 11:52 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/10/2024 8:08 PM, Paul Moore wrote:
>>> On Oct  9, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> Replace the secid value stored in struct audit_context with a struct
>>>> lsm_prop. Change the code that uses this value to accommodate the
>>>> change. security_audit_rule_match() expects a lsm_prop, so existing
>>>> scaffolding can be removed. A call to security_secid_to_secctx()
>>>> is changed to security_lsmprop_to_secctx().  The call to
>>>> security_ipc_getsecid() is scaffolded.
>>>>
>>>> A new function lsmprop_is_set() is introduced to identify whether
>>>> an lsm_prop contains a non-zero value.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>>  include/linux/security.h | 24 ++++++++++++++++++++++++
>>>>  kernel/audit.h           |  3 ++-
>>>>  kernel/auditsc.c         | 19 ++++++++-----------
>>>>  3 files changed, 34 insertions(+), 12 deletions(-)
> ..
>
>>>> +/**
>>>> + * lsmprop_is_set - report if there is a value in the lsm_prop
>>>> + * @prop: Pointer to the exported LSM data
>>>> + *
>>>> + * Returns true if there is a value set, false otherwise
>>>> + */
>>>> +static inline bool lsm_prop_is_set(struct lsm_prop *prop)
>>>> +{
>>>> +    return false;
>>>> +}
>>> If we're going to call this lsmprop_is_set() (see 5/13), we really should
>>> name it that way to start in this patch.
>> Agreed. That's an unfortunate artifact of the lsmblob to lsm_prop name change.
>>
>>> Considering everything else in this patchset looks okay, if you want me
>>> to fix this up during the merge let me know.
>> I can do a v5 if that makes life easier, but if you're OK with fixing it
>> during the merge I'm completely fine with that. Thank you.
> For trivial things like this where I've already reviewed the full
> patchset it's easier/quicker if I just make the change as I can do it
> and not have to re-review everything.  Otherwise it's another revision
> for you to post, me to review, etc.; granted in that case I'm really
> just diffing between v4 and v5, not really doing a full review unless
> something odd pops up in the diff, but I think you get the idea.

Indeed. Go forth and merge. Thanks again.

