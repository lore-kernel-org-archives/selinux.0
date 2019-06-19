Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71938C31E5B
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 17:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E22321874
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 17:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ji+YJtJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfFSRA3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:00:29 -0400
Received: from sonic311-30.consmr.mail.gq1.yahoo.com ([98.137.65.211]:43776
        "EHLO sonic311-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbfFSRA3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 13:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560963626; bh=Rj5mnQVSFoysum3YjTA5P/5VI78gd7vlqTouOFJ2HOw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Ji+YJtJxfyPsznZNQCGE0oNeOJoUO5VzUYIcLhKFchPYAz0vgPk7Rg88SlJUK4ZD64iCBmTP47ZRMo6qqMCcRBD1J/4xDl0lHlMx/BRFK00weBTiZI6BordgW9haiuWZ4HndF4k0dKele9LSNQ1/J8XEX4Pyc1gefcDydSYi+KuITYBH5uJC4gRqa9qMQN8YrOE9Jc29h1ZbEfPT4bmyw+ko9Tvgcues90GCSeI+iSYiXAmctZmeh1KDcnz0xaDi9HYWR7QaQSsauFNV9nY2I/Li6FXftr7VR3GJjZclfKpjqWRetbyWr4TBXUlrEtPt6KuCjg2noBr0UJaHiM0iFA==
X-YMail-OSG: hMmGOQ4VM1lX8iRRBvcvtOkQb_QLMA8M_tlUgBRq0oDcDlhD6BoLqtjHNhE3bET
 TAE.8zCtyZJ.tFhY9jI73WtxG3wGItGpKVDDITqPpKnyVYbDDaF1NvYUDuY_EJIcP_kVGxv57A9r
 uWRmYMfupfVQK4kz8mqcCTmoyw38GTOHcJSoIsxBGECUN_0UFPxqQ9Clfd_uzke1KAaMwQem2YkK
 Z5j5RgEqJpIZqT3S9JkSkh6B2ci3fLXpZWhjQZH1bUv0Za43zM5.jL3knaJZbyzBSVEyMYkynFWa
 3hC.nNTiGiHGpZHFr.0tDZJdvg9ramJwSbzRbBR9qGkPp7uesLnZo5gXbRh.v8r6Ci6s7MbmEj9i
 t2eQKzRHBAR3Aa7hFTEmtpF3o2M2V0nZxGtMdN9oT75CiSM0tI3PS54Hfkm9dps0E5R3i2qT6Yau
 jmSkshn1tU97NLjdfvADZP3Aya7gBpFAazQtXw7r0ng7G.ZpsLJRnWfOi_SNTEXRzotah8YnN068
 YTiXzy9ZKpZF4D7qjgHVwGVExhn89lx32jpMppY3vmMNU1qb8zpQHs28yhFM5hTdIpn4Yj3C2UJp
 DVGjivdWq3XGURI6kjSbxfL59HqaeA.2JUwoheZj1h9Y7B.C93dRuy2bDzsoO3of6DGvmFdu7qzd
 5lnfa.aR1d5VYzc.zQT.28KaBBBtMNvo6jsLix5uyCidmMvkhisbBBczkA0lr2akGxkt81reEc6X
 dYrr9xtPRB6xCY11h5w1eIZ6ZCqkTloMoGq4Vgsv_knapwdv7AQtR2.pXLWkfsyOot.huePrf29O
 9Q3yNbK63lqyRxH.2BnQcH4H_bQ7L5WdNJrihjloJIlcGHRhrQ9aGvuosyM1jGFOoYzK5w5Ccr7b
 .gbHq6oqu6iulU8RHnMy6qcwfD6yYbw6Sj73wxVQ9b3xXdHizp0WRnIKNZ..4iUsm_TpIjm29gfq
 C.QULcjsqS2JDJmVD2QrxPHIdQDqsDuR8Q7j1RObKemMD.Eops2Gi5rjqGDlhnEWUW0Ivb.k1Jwo
 QVixdcb6uOQf6wmPUuhzAsyV7MyPQEiek7vyCfWovSS_OzPO5ZXCktouRYlp9.JJlgVTf3aSsdHT
 Fnx2FY9E4CiV.bZuDWQFZeqq2WfyUeddRA0QXgxkyD.Ne8F8h2ipsTXMx6uIEPTzH1asig0tpGtG
 qLsaMjcjGCiCtGU86eD3uFkBlxXnDRmS010hvkrAgBb8ERl6aiFPHKeMBURJvAcKqMITEQIHe2ZK
 p0lXZqgNkFpNR_0vidt.2iGqiSk3D8khQc3A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Jun 2019 17:00:26 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp431.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2e2cec29b67b10fdc4f09eb213618ef2;
          Wed, 19 Jun 2019 17:00:25 +0000 (UTC)
Subject: Re: [PATCH v2 15/25] LSM: Specify which LSM to display
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-16-casey@schaufler-ca.com>
 <201906182221.8E3938600D@keescook>
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
Message-ID: <ea943c29-858e-8d8c-eb6e-d524fb1b5862@schaufler-ca.com>
Date:   Wed, 19 Jun 2019 10:00:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <201906182221.8E3938600D@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/18/2019 10:28 PM, Kees Cook wrote:
> On Tue, Jun 18, 2019 at 04:05:41PM -0700, Casey Schaufler wrote:
>> Create a new entry "display" in /proc/.../attr for controlling
>> which LSM security information is displayed for a process.
>> The name of an active LSM that supplies hooks for human readable
>> data may be written to "display" to set the value. The name of
>> the LSM currently in use can be read from "display".
>> At this point there can only be one LSM capable of display
>> active.
>>
>> This affects /proc/.../attr/current and SO_PEERSEC.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  fs/proc/base.c      |   1 +
>>  security/security.c | 108 +++++++++++++++++++++++++++++++++++--------=
-
>>  2 files changed, 88 insertions(+), 21 deletions(-)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index ddef482f1334..7bf70e041315 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] =3D=
 {
>>  	ATTR(NULL, "fscreate",		0666),
>>  	ATTR(NULL, "keycreate",		0666),
>>  	ATTR(NULL, "sockcreate",	0666),
>> +	ATTR(NULL, "display",		0666),
>>  #ifdef CONFIG_SECURITY_SMACK
>>  	DIR("smack",			0555,
>>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
>> diff --git a/security/security.c b/security/security.c
>> index 46f6cf21d33c..9cfdc664239e 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
>>  static struct kmem_cache *lsm_inode_cache;
>> =20
>>  char *lsm_names;
>> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
>> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init =3D {
>> +	.lbs_task =3D sizeof(int),
>> +};
> This needs some comments. I know what's happening here only because I
> understand very well how the blob sizing works. :) Perhaps:
>
> .lbs_task =3D sizeof(int), /* storage for selected "display" LSM */

Point.

>> =20
>>  /* Boot-time LSM user choice */
>>  static __initdata const char *chosen_lsm_order;
>> @@ -578,6 +580,8 @@ int lsm_inode_alloc(struct inode *inode)
>>   */
>>  static int lsm_task_alloc(struct task_struct *task)
>>  {
>> +	int *display;
>> +
>>  	if (blob_sizes.lbs_task =3D=3D 0) {
>>  		task->security =3D NULL;
>>  		return 0;
>> @@ -586,6 +590,10 @@ static int lsm_task_alloc(struct task_struct *tas=
k)
>>  	task->security =3D kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>>  	if (task->security =3D=3D NULL)
>>  		return -ENOMEM;
>> +
>> +	display =3D task->security;
>> +	*display =3D LSMDATA_INVALID;
> Similarly I think a comment here would be nice. "Initialize currently
> selected "display" LSM to unselected" or something.

Point.

> Also: "int" is okay here for now, but if the LSM infrastructure wants t=
o
> do more like this we'll want to convert to a struct of some kind at the=

> start of the lbs_task.

We could go whole hog and include a lsm_info pointer (once
the slot number moves there) instead of an int, but I think
it best to leave it as is for now. I don't see a case where
more information would be required, and it would not be a
hard change to make later.

>> +
>>  	return 0;
>>  }
>> =20
>> @@ -1574,14 +1582,27 @@ int security_file_open(struct file *file)
>> =20
>>  int security_task_alloc(struct task_struct *task, unsigned long clone=
_flags)
>>  {
>> +	int *odisplay =3D current->security;
>> +	int *ndisplay;
>>  	int rc =3D lsm_task_alloc(task);
>> =20
>> -	if (rc)
>> +	if (unlikely(rc))
>>  		return rc;
>> +
>>  	rc =3D call_int_hook(task_alloc, 0, task, clone_flags);
>> -	if (unlikely(rc))
>> +	if (unlikely(rc)) {
>>  		security_task_free(task);
>> -	return rc;
>> +		return rc;
>> +	}
>> +
>> +	ndisplay =3D task->security;
>> +	if (ndisplay =3D=3D NULL)
>> +		return 0;
>> +
>> +	if (odisplay !=3D NULL)
> Perhaps merge these into "if (ndisplay && odisplay)" to drop the early
> return 0 check?

Sure. The logic took a few iterations before it got to
what you see here.

>> +		*ndisplay =3D *odisplay;
>> +
>> +	return 0;
>>  }
>> =20
>>  void security_task_free(struct task_struct *task)
>> @@ -1967,10 +1988,28 @@ int security_getprocattr(struct task_struct *p=
, const char *lsm, char *name,
>>  				char **value)
>>  {
>>  	struct security_hook_list *hp;
>> +	int *display =3D current->security;
>> +
>> +	if (!strcmp(name, "display")) {
>> +		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
>> +				     list) {
>> +			if (*display =3D=3D LSMDATA_INVALID ||
>> +			    hp->slot =3D=3D *display) {
>> +				*value =3D kstrdup(hp->lsm, GFP_KERNEL);
>> +				if (*value)
>> +					return strlen(hp->lsm);
>> +				return -ENOMEM;
>> +			}
>> +		}
>> +		return -EINVAL;
>> +	}
>> =20
>>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>  		if (lsm !=3D NULL && strcmp(lsm, hp->lsm))
>>  			continue;
>> +		if (lsm =3D=3D NULL && *display !=3D LSMDATA_INVALID &&
>> +		    *display !=3D hp->slot)
>> +			continue;
>>  		return hp->hook.getprocattr(p, name, value);
>>  	}
>>  	return -EINVAL;
>> @@ -1980,10 +2019,27 @@ int security_setprocattr(const char *lsm, cons=
t char *name, void *value,
>>  			 size_t size)
>>  {
>>  	struct security_hook_list *hp;
>> +	int *display =3D current->security;
>> +	int len;
>> +
>> +	if (!strcmp(name, "display")) {
>> +		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
>> +				     list) {
>> +			len =3D strlen(hp->lsm);
>> +			if (size >=3D len && !strncmp(value, hp->lsm, len)) {
>> +				*display =3D hp->slot;
>> +				return size;
>> +			}
>> +		}
>> +		return -EINVAL;
>> +	}
>> =20
>>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>>  		if (lsm !=3D NULL && strcmp(lsm, hp->lsm))
>>  			continue;
>> +		if (lsm =3D=3D NULL && *display !=3D LSMDATA_INVALID &&
>> +		    *display !=3D hp->slot)
>> +			continue;
>>  		return hp->hook.setprocattr(name, value, size);
>>  	}
>>  	return -EINVAL;
>> @@ -2002,38 +2058,41 @@ EXPORT_SYMBOL(security_ismaclabel);
>> =20
>>  int security_secid_to_secctx(struct lsmblob *l, char **secdata, u32 *=
seclen)
>>  {
>> +	int *display =3D current->security;
>>  	struct security_hook_list *hp;
>> -	int rc;
>> =20
>> -	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list)=
 {
>> -		rc =3D hp->hook.secid_to_secctx(l->secid[hp->slot],
>> -					      secdata, seclen);
>> -		if (rc !=3D 0)
>> -			return rc;
>> -	}
>> +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list)=

>> +		if (*display =3D=3D LSMDATA_INVALID || *display =3D=3D hp->slot)
>> +			return hp->hook.secid_to_secctx(l->secid[hp->slot],
>> +							secdata, seclen);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(security_secid_to_secctx);
>> =20
>>  int security_secctx_to_secid(const char *secdata, u32 seclen, struct =
lsmblob *l)
>>  {
>> +	int *display =3D current->security;
>>  	struct security_hook_list *hp;
>> -	int rc;
>> =20
>>  	lsmblob_init(l, 0);
>> -	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list)=
 {
>> -		rc =3D hp->hook.secctx_to_secid(secdata, seclen,
>> -					      &l->secid[hp->slot]);
>> -		if (rc !=3D 0)
>> -			return rc;
>> -	}
>> +	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list)=

>> +		if (*display =3D=3D LSMDATA_INVALID || *display =3D=3D hp->slot)
>> +			return hp->hook.secctx_to_secid(secdata, seclen,
>> +							&l->secid[hp->slot]);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(security_secctx_to_secid);
>> =20
>>  void security_release_secctx(char *secdata, u32 seclen)
>>  {
>> -	call_void_hook(release_secctx, secdata, seclen);
>> +	int *display =3D current->security;
>> +	struct security_hook_list *hp;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
>> +		if (*display =3D=3D LSMDATA_INVALID || *display =3D=3D hp->slot) {
>> +			hp->hook.release_secctx(secdata, seclen);
>> +			return;
>> +		}
>>  }
>>  EXPORT_SYMBOL(security_release_secctx);
>> =20
>> @@ -2158,8 +2217,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>>  int security_socket_getpeersec_stream(struct socket *sock, char __use=
r *optval,
>>  				      int __user *optlen, unsigned len)
>>  {
>> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>> -				optval, optlen, len);
>> +	int *display =3D current->security;
>> +	struct security_hook_list *hp;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stre=
am,
>> +			     list)
>> +		if (*display =3D=3D LSMDATA_INVALID || *display =3D=3D hp->slot)
>> +			return hp->hook.socket_getpeersec_stream(sock, optval,
>> +								 optlen, len);
>> +	return -ENOPROTOOPT;
>>  }
>> =20
>>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_b=
uff *skb,
>> --=20
>> 2.20.1
>>

