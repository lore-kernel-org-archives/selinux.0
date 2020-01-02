Return-Path: <SRS0=cqSC=2X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C4EC3276E
	for <selinux@archiver.kernel.org>; Thu,  2 Jan 2020 23:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81DB21835
	for <selinux@archiver.kernel.org>; Thu,  2 Jan 2020 23:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eklbBhTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgABXgk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:36:40 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:45238
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgABXgk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jan 2020 18:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578008198; bh=bGP9U0QBq6OqyqdbBxigvhO7XJE6ElgNoBBjWGYwBCI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=eklbBhTmg8MowHO5vOtPd8H+0JExTJuujXF/DP+8ivK5ZJ98TKhg3Sq1XB9bbmov5OSpZbccY3iBzietSkDlPTsMBzN5RCLxFNqfQr1TsMEtMSziD02oyWbablP9/eC4ClYW3FYTSqDn8yEms3Q8bIyO7ekeYWWanFPpCgRgBcYd0tsRRSiQQE35ABZwKE2PRUWdeymWos/RjQVro9xl0NoW4GG1c8jyoSVPd3fw9v1J8BnW+lwanOKaZxqO0rrz10W6UBlnTP7ijXJfs57S5TI7YzYCYl+cH3DVnHly33HCik8gJ+6USjD1eqKB46zzdhkfWXzS7xopa5pzy0HFaA==
X-YMail-OSG: _8ZEFxIVM1lz24uUBz_J5zg0RbEtxSgw9ikGMpdMjEP80WtPsgChrIhR52XOPab
 hcuD7VQn5sai0MOUJb.Vt1py_tFszzKXYhg5oFWzZERf58LfZp40Ak.6YYURUr.HSHUlAOOv3xAs
 e777sYzgCja_yaLkSBA1cfiImTo1RlxQq25_.9kTCNDjLneLDMI.qyGeLTyIDahRNfbVh0tCtP80
 j3nCiM7Xre4cEjMIkwJkk7cWBQidTtsSixV0yA12ckV6BsqHKx9MRYB2orkiyrXmwIkVa1V3.EYU
 N8VhBXXmFiHDL2WRpII_mByp.FbHIhj6MhL0xPWZWoEvPFFBExTBtTVXxZR97b2FpMRQcYUI6161
 IA6f_AZEiGrriJG9fwqgBHFDOjT456WtrzkkVauMH1ux4RlPK0DGkPzF1ACzFPiWMA9oLC4Gr4bA
 HhMLokHO6Xk41y8HPbZZCnkqEDr6qmhPPC4tqjezGRMe.0OA4iWwO4.LwzjsgL.48muXaWpIl_Se
 6oI5Yc8x80K_G2HtgEiEAOxHb8iLVWgSYWxUsKyRy8PJQsMfRfYhdsEBnM6qhB9AIy9RJ6NvmnQn
 lSEhYvsnJWmidn15.baf01sQ_U.mZ7XJEhs_KMqVHHSGb8RZeh4il5dSs4xssLmuy4GgWQmrppnw
 p5P3VYfhJW0QD5LXs.3EiHMDAZ3RFFly2l1MYSjg9TwTZHAHVgmgZo8VezABwmIQCn..fPJHrRn3
 kEL3kWsDRcyCX8lvH5aXMjUrgvSp5FGAbd.PLBVfL91s8YThpLdRo2RWQMYdohseS4PzLVHcDz6X
 kWk9wrtVzui_NG90xrfhAdsGj0Beze8Gia10TMOSGtxpIb62FtUZ4Dn47eAmLKvwiaQUoGC5CVI1
 hKO9NptZBtAyFczfAeOSJAe67Z64BoiP55CMiZRaLCwSZV6WM_4Tx1uTwOX4ZwA9olO6Hr0SZlvI
 8Ka.VY9UtWkluHbNh59NcSEIz4rLFGdMG08Rhdb6jFgEg2jO.BkJ4971mFclBwN_0dq9Dvd3rhd2
 lVIehraPhFkGwkUieWr3z4q7hMCrk1e4Zp5ISzeVL3j7j7YNi70YsFjd24Q.gbOZuehrv.JEpwdO
 1PIOW_TIayogqsPaO38ou8WV2hB3GZc6HYNvJaf95q75._ZWxxrL.DRszmZzcELsV9CbnpkKKZUA
 iett51UcedvQym.vKmPp08b2rQ3_MoqvuGSt4bBNUcW59LrMZi4g0OIeYwQD4pvnmi866u62IWVn
 18McKtOFhhrAcn0v.q7H6E3Q5IsiqrWkGoJObQX9xm8MZQpkjyknErRwWP5jg1i1nR_0lpweRRg4
 c2Bxcu4MrLZNfVe4TKP7vetdP0Uwzmcuheh6W38YFs8AJT2Zy7eVeRS7CFrX942iydsNPMxznarZ
 SV3xmfecFZekRiVP2hTqyxx5.fPo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Jan 2020 23:36:38 +0000
Received: by smtp412.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 85c801de5c031110742eb15a6b9cf61c;
          Thu, 02 Jan 2020 23:36:34 +0000 (UTC)
Subject: Re: [PATCH v13 03/25] LSM: Use lsmblob in security_audit_rule_match
To:     Mimi Zohar <zohar@linux.ibm.com>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, Janne Karhunen <janne.karhunen@gmail.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-4-casey@schaufler-ca.com>
 <1577797998.5874.75.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <eeeb3e9f-1117-9a51-e4d7-8340a1423031@schaufler-ca.com>
Date:   Thu, 2 Jan 2020 15:36:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1577797998.5874.75.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/31/2019 5:13 AM, Mimi Zohar wrote:
> [Cc'ing=C2=A0Janne Karhunen based on his recent work updating IMA polic=
y
> rules LSM id's - commit b16942455193 ("ima: use the lsm policy update
> notifier")]
>
> On Tue, 2019-12-24 at 15:59 -0800, Casey Schaufler wrote:
>> diff --git a/security/security.c b/security/security.c
>> index 87fc70f77660..12e1e6223233 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -439,7 +439,7 @@ static int lsm_append(const char *new, char **resu=
lt)
>>  /*
>>   * Current index to use while initializing the lsmblob secid list.
>>   */
>> -static int lsm_slot __initdata;
>> +static int lsm_slot __lsm_ro_after_init;
>>
>>  /**
>>   * security_add_hooks - Add a modules hooks to the hook lists.
>> @@ -2412,9 +2412,21 @@ void security_audit_rule_free(void *lsmrule)
>>  	call_void_hook(audit_rule_free, lsmrule);
>>  }
>>
>> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsm=
rule)
>> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op=
,
>> +			      void *lsmrule)
>>  {
>> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule)=
;
>> +	struct security_hook_list *hp;
>> +	int rc;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list=
) {
>> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=3D lsm_slot))
>> +			continue;
>> +		rc =3D hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
>> +					       field, op, lsmrule);
> IMA's policy rules may be written in terms of LSM labels. =C2=A0On IMA
> policy initialization and, subsequently, when the LSM policy is
> updated, IMA correlates LSM labels with LSM ids. =C2=A0Doesn't
> security_audit_rule_init() also need to be updated to walk the LSMs?

Yes. I've got a change in test.

>
> The basic assumption with security_audit_rule_match() is that there
> isn't any naming overlap. =C2=A0Is that guaranteed?

No. A valid SELinux label is also a valid Smack label. If someone
asks to see subj_user=3Dwhatever_t both module will look for it.

>  =C2=A0With this change, do
> the IMA policy rules now need to be LSM qualified?

I have a change for that in test, too.

>
> Mimi
>
>> +		if (rc !=3D 0)
>> +			return rc;
>> +	}
>> +	return 0;
>>  }
>>  #endif /* CONFIG_AUDIT */

