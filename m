Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02641C31E5B
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD72A2187F
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 15:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RJzsjj30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfFSPd6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:33:58 -0400
Received: from sonic316-12.consmr.mail.gq1.yahoo.com ([98.137.69.36]:40557
        "EHLO sonic316-12.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbfFSPd6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 11:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560958436; bh=MfABosQpLoYsk3MFanoNBkEA/SgccHCq0eV0pIhGDbw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=RJzsjj30D1zO1Vl4GOa41+giw2UxMvIRMixUt5kSmT8MxIGkOEt4+RPx4b9bwFRlm4oqMqF/Mn4yeJDaQWBFw77aRUkU2dvzOZRrnjREojaEEnAz17z413kxwms85zEpHvkPtgKKTkKEdH0SgQJAK/d6NiICXMjAz5rbfOuLy/jBT1QK/B86WPTeRg4AwFYY1Q0sL1MXDb7Qmzp02SLlDjedzWuw0oZ75hb87JpudP/n/vlHVCVILry0Dn1th86ItZZK5awpRdj6JADUqoyfyiFZKCVK/8/naE9rDvH1Y8c156kk+dXo+GsJMaL9ksXgFjoQ/tdwpA5eyWfkHNLpuQ==
X-YMail-OSG: aK4bpmkVM1mMjnFJrpuPbGV0NnrcS21bkAGhnl9g2w3.q6yzuqNDQjB85Hp60jA
 LuOOxuRIPrG61NrD0OEWZ6FZQr3bPhkwDMrK24vSQ4o9LBjGt0eNX.0CA69sbNYq9n0MYtpBDrlR
 KXKipcVELEArcwJrvg1PjjdtcLLlwXB.xOt6Vxnfbbc51CUOt454tsUIQwWyySPKqrC_9MGtd1.4
 y7xOzCxxHXuScUiQrji.oo1H1xWHZjC_ETVaYiCs1eEPNb.URRAe2lyMEN97DYJkEtbaJRFkc5ow
 KOzowKHDLEXAGJizgsR.sm1Zracak2owjiI9tdTfvLr_AuWU2QLoWjp0K4elgM8mli3nQLG5YAC7
 vLrL.hkqm1t3tle3xK1jnFVWZs14XGRgcnLVYQ7pNlZvu7W9ftjqURBOmapSzAZQOYVMB4r5BwmT
 thrr62o4WzLyh5ulsLKPnFrNLGTnbFPuvR51mO32B2dkUCBE.Z335az_eJw0QhsGSjGejeTbLQr7
 hqsX2UGQZ43hK_Rff9nu60WPprpni9cP8tJZsiua3uzxclMH7EV8EDfNuW.UXoqrd67pWqeJEnK2
 zurpAbgF5cL3Q2d9x3bAKoLGXu7wbA7xsUJ96uRnixV4w40RsLGIzw8W7Aw6Ig8kKPr6pHo7Tscp
 m8q_3YPusawsWU4keebd4F_JlKsRFnTYvSrNW.Q8c9WAOSWwPw6tMZSOhoUvd.Hyl1nS0y.dq2YL
 JaVlDW9LZOV9hU2O_QSjJlg4Khsg.wkifhrrAjd2Ovgk6pYJ2P_fFPrzoL5oKFz.FZAXSIvq0fL1
 93DwSb8TJ6lOHOmM9QqGfvVbNkerbvxLVJErwwbCi.ssbrlkIv2X4QPgAaJLRHmAkQCb5.PYr4rA
 97ubIUhP1KvW3rA.TtEAbPGGQd1iyuD744NN9XtINe.CVgNZPgC3LExCw6nVA4r9G9LNtv5sRqPB
 Z0_nUcuZ.q60oJVoOqJLHY1xOGCVnEOwwnMfr8IDnEBlh9qR.XHYOqf1_dz8XNqoW9CTfzUrg9zd
 PCvD1aYJHC36m19uXDY4DYCTpFsgP808uCnkGbgLyaSD5bW3uZI44tcVSGYEaZF2TD8NmqKeM9MR
 c9Hp8lzt09Sapi9ju5SZUxUppNvJ5xNSKjJ50KgzsPXS5zgxhuQWYSV_IpXKdorB6pabOwv_IrSs
 Umo12_wAZdpCuJqVIUM0UCPFHl82zdHx1BbrYKsD5X.n99NYOb6HTDm36vYUYkcA3AGQwC4Lo826
 vsA8DVmHzr62YqN8mZ4KT3Ia39CyylpbbnQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Jun 2019 15:33:56 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cbea28625ea8ace0c4078c131041f53f;
          Wed, 19 Jun 2019 15:33:53 +0000 (UTC)
Subject: Re: [PATCH v2 15/25] LSM: Specify which LSM to display
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-16-casey@schaufler-ca.com>
 <201906182127.073A9D7@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <199b5c49-2bf8-3b9f-3b4a-0a2139f86c1f@schaufler-ca.com>
Date:   Wed, 19 Jun 2019 08:33:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <201906182127.073A9D7@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/18/2019 9:33 PM, Kees Cook wrote:
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
> What happened to creating /proc/$pid/lsm/$lsm_name/current for "modern"=

> LSM libraries to start using (instead of possibly fighting over the
> /proc/$pid/attr/display)?

Smack already has it and the mechanics are available for
anyone who wants to use it. John says that AppArmor is moving
away from using the attr interfaces. Stephen and Paul have been
silent on the topic, but my assumption is that the SELinux
attitude is "I had them first, it's not my problem". When
we get around to creating liblsm, with the "real" LSM user
space APIs it will probably drive the addition of more
/proc/$pid/lsm/$lsm_name directories.

>  (Obviously "display" is needed for "old"
> libraries, and I'm fine with it.)

Yes, and we can expect some distos to cling to the
old libraries for a looooong time.

> Similarly, is there something that can be done for SO_PEERSEC that
> doesn't require using "display" for "modern" libraries?

Yes, and I made sure the implementation could
accommodate that. It would be easy to add a "display"
that would use the much discussed $lsm1=3D"a",$lsm2=3D"b"
format. I didn't include it because without a liblsm to
use it it's just clutter.

>
> -Kees
>
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

