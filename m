Return-Path: <SRS0=nXDU=WF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3205AC0650F
	for <selinux@archiver.kernel.org>; Fri,  9 Aug 2019 00:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBE22166E
	for <selinux@archiver.kernel.org>; Fri,  9 Aug 2019 00:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="a/fj+9LP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbfHIASk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Aug 2019 20:18:40 -0400
Received: from sonic317-27.consmr.mail.gq1.yahoo.com ([98.137.66.153]:39874
        "EHLO sonic317-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbfHIASk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Aug 2019 20:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565309917; bh=C6g8/JppoYEbzZ7NquOWatpR5vZ/7kdOxht0G6rgL30=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=a/fj+9LPIEJFbd8Rqf89eKId1JyIcT1LMGOGoof4YmLiVPXjEtnaR/CGaiQH0QRsP9NGzTKRK/vVtQ/YdGty3gZ8UACpkgGPpKCsIzoRmWodqsTRqngcfnwpUV4caF4wtRl0B9TkG+G9/A4QIIEnjIzdeDFPHEABmYt2QQaJA2d8A6wFrjFVKT8/HfI3raQAaAkBhw5m/Z8KB/CzT4xPmCKuP1+gn6VAcngStWH+cjVyZ+EXotx5TvaKSwH61Ba46TMRqnc2T2tO8eCp/3DSE13/26CeyuccHGVNzOodAhBnVR7Uh1QcjvD/Ve7qtrhcAaedM1gp04FlN0ffXtwZ/w==
X-YMail-OSG: xOPTRegVM1nYweMOjKB7nAOsGhn8LZ2RqJef_WoN5XudWes4Z.0G.0SkH7ESATY
 KiUGUYQqV.xrkG.ATfSOLCZ7.ST_c42HH4_qp5jfQl2.mEn3o3E7gwD7OnEvUY27zkKgsTsD4qOo
 BpArV7OZVKArjvgyWdCj.WP0BjzVLXQ4mGtj3XoVeA9EJpLY1wvH8uhvhsFnPD2gsITvrqSH6SZy
 ZfUxmsv7ftZDfMPV771nVizvhvd0jRWj8Ir3VyU7NqGuO_7vROmjo1xeT5lV3DLF4iHTUJtd2XYh
 q_WLxj1N5DRc9ouBH1qbSsY9_EFwNfA7pW6aLYL8VpWtaIEPI0FAvzzSn444BsR4WCm7XlUIdWQx
 1X.cT4kcQ4znIvEewkAO2tRVbsnpZLVne05.oS7mJzWtgS071AWrUSkfQLaeFPIiY6NIQ4G0IMF6
 6rItZNTwsL0O.3JoqRICEBAJM2M0NjActKJckNetfVDnypfz0loJhzGRYBg_TAKNFm1l9ucOu_5u
 iqjgnbKCCss3gF.ny5FfUodo0LUiakmmJn.Pq2pu4uoDayjDArq0H5eaxkj2TnLo.JdkcaxzdEcn
 DS9BL0gjd30g2qpFGF2tIA9eMOeo5w1Ya7CFciLsdPQyrUpzOzTuIwG3weW0w4xRShpXVsq_JbSb
 dVv5wbfDxh7jDEzokJGA3bJCIorDTSSBMyBTtwj_VtrL0CVwRtSG8u_vfgZYREsBECg_pkmjtH2d
 4KmWs1wW0kQXtSfCiFyOz.z9S.f5UTFGNQWUVNSQZ29PuV.JWrcaUSm9ibRMyHvBA6xn7NMH0VZ5
 rI9yFzVE_uhLj0PhbzntMq1ToWahVoGeJ0P2AlN4Qa3zjiGPQWwFfDwgYX4Kww06HB9mIKZJctxN
 3Aw60ryBJxo0ZmKkArG3hBB2lKzqFrsmJFVRslue8ctusSh0acaQjNA6FpN4Zqgo9PctefjYfxL1
 TmzSuaQOziG12.dw3xRdUIDeQD8_0vKyF09tbsivFqsgusbR3irU2zLgC8YmqDnFiNyZ4GV8GuiH
 jSCeu6PLds4J39RNoSO0U37cW7nN7wU8kaix4vbiD16Mc_pl3mMtnsIlLWIvnZsBvVaT5S0Bpm.n
 vcDAT0wxXPe.3ttjzXiC7Q.uYy77rRU7aR.QnaNJVB5HZmSL5c0e34QtJCarcQSlOwMZpgG8IgyT
 pkUNyQ8QXMjmcBYqs9Pocr7QeshQOGEZVaYtnTRSiSvTFr2GVpuufYNvCbeXM7lhfNuVbvrYXsvd
 EaUrtUFGP7TEKUXYIVg3STxuVWJw3DQcyZosmYL3r3c3CCkbF1OPBycU0w3W.6Rv6Kg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Fri, 9 Aug 2019 00:18:37 +0000
Received: by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b296d44ca06fda2f56a8a28956ab776e;
          Fri, 09 Aug 2019 00:18:32 +0000 (UTC)
Subject: Re: [PATCH v7 26/28] NET: Add SO_PEERCONTEXT for multiple LSMs
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190807194410.9762-1-casey@schaufler-ca.com>
 <20190807194410.9762-27-casey@schaufler-ca.com>
 <201908081500.992E5330@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <9cfae450-6878-4666-1328-934ea07a8e56@schaufler-ca.com>
Date:   Thu, 8 Aug 2019 17:18:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201908081500.992E5330@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/8/2019 3:21 PM, Kees Cook wrote:
> On Wed, Aug 07, 2019 at 12:44:08PM -0700, Casey Schaufler wrote:
>> The getsockopt SO_PEERSEC provides the LSM based security
>> information for a single module, but for reasons of backward
>> compatibility cannot include the information for multiple
>> modules. A new option SO_PEERCONTEXT is added to report the
>> security "context" of multiple modules using a "compound" format
>>
>> 	lsm1\0value\0lsm2\0value\0
>>
>> This is expected to be used by system services, including dbus-daemon.=

>> The exact format of a compound context has been the subject of
>> considerable debate. This format was suggested by Simon McVittie,
>> a dbus maintainer with a significant stake in the format being
>> uasable.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>> [...]
>> diff --git a/security/security.c b/security/security.c
>> index 2f4a430a1126..0ea7ee27e331 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2117,8 +2117,8 @@ int security_setprocattr(const char *lsm, const =
char *name, void *value,
>>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>>  		if (lsm !=3D NULL && strcmp(lsm, hp->lsmid->lsm))
>>  			continue;
>> -		if (lsm =3D=3D NULL && *display !=3D LSMBLOB_INVALID &&
>> -		    *display !=3D hp->lsmid->slot)
>> +		if (lsm =3D=3D NULL && display !=3D NULL &&
>> +		    *display !=3D LSMBLOB_INVALID && *display !=3D hp->lsmid->slot)=

>>  			continue;
>>  		return hp->hook.setprocattr(name, value, size);
>>  	}
>> @@ -2342,17 +2342,91 @@ int security_sock_rcv_skb(struct sock *sk, str=
uct sk_buff *skb)
>>  EXPORT_SYMBOL(security_sock_rcv_skb);
>> =20
>>  int security_socket_getpeersec_stream(struct socket *sock, char __use=
r *optval,
>> -				      int __user *optlen, unsigned len)
>> +				      int __user *optlen, unsigned len,
>> +				      int display)
>>  {
>> -	int display =3D lsm_task_display(current);
>>  	struct security_hook_list *hp;
>> +	char *final =3D NULL;
>> +	char *cp;
>> +	char *tp;
>> +	int rc =3D 0;
>> +	unsigned finallen =3D 0;
>> +	unsigned llen;
>> +	unsigned clen =3D 0;
>> +	unsigned tlen;
> Please move the case-specific variables into the case scope, like (and
> expand type names):
>
> 	case LSMBLOB_COMPOUND: {
> 		unsigned int clen ...;

I've never been a fan of that style. I'll probably make the
special cases into functions.

>
>> +
>> +	switch (display) {
>> +	case LSMBLOB_DISPLAY:
>> +		rc =3D -ENOPROTOOPT;
>> +		display =3D lsm_task_display(current);
>> +		hlist_for_each_entry(hp,
>> +				&security_hook_heads.socket_getpeersec_stream,
>> +				list)
>> +			if (display =3D=3D LSMBLOB_INVALID ||
>> +			    display =3D=3D hp->lsmid->slot) {
>> +				rc =3D hp->hook.socket_getpeersec_stream(sock,
>> +							&final, &finallen, len);
>> +				break;
>> +			}
>> +		break;
>> +	case LSMBLOB_COMPOUND:
>> +		/*
>> +		 * A compound context, in the form [lsm\0value\0]...
>> +		 */
>> +		hlist_for_each_entry(hp,
>> +				&security_hook_heads.socket_getpeersec_stream,
>> +				list) {
>> +			rc =3D hp->hook.socket_getpeersec_stream(sock, &cp, &clen,
>> +							       len);
> Is passing "len" here useful at all? It's kind of a lie, but nothing
> else wouldn't also be a lie. :)

I could be reducing the value of len for each component gathered.
It requires yet another temporary length variable, and exceeding the
len passed has to get checked in here anyway. I may be able to make
this more sensible.

>
>> +			if (rc =3D=3D -EINVAL || rc =3D=3D -ENOPROTOOPT) {
>> +				rc =3D 0;
>> +				continue;
>> +			}
>> +			if (rc) {
>> +				kfree(final);
>> +				return rc;
>> +			}
>> +			/*
>> +			 * Don't propogate trailing nul bytes.
> typo: propagate

Not a typo, a spelling error. I'm real good at spelling errors.

>
>> +			 */
>> +			clen =3D strnlen(cp, clen) + 1;
>> +			llen =3D strlen(hp->lsmid->lsm) + 1;
>> +			tlen =3D llen + clen;
>> +			if (final)
>> +				tlen +=3D finallen;
> You can drop the "if (final)" since finallen is initialized to 0.

Right you are.

>
>> +			tp =3D kzalloc(tlen, GFP_KERNEL);
> I'm not a huge fan of "c", "l", and "t" prefixes -- can you just make
> these a little more self-documenting? cp and clen could be value and
> value_len. llen could be lsm_name_len. tp and tlen could be tuple and
> tuple_len. (And maybe final and finallen could be compound and
> compound_len?)

You didn't spend much time using TTY33s, did you? Or 80 column punch card=
s
where the last 8 are reserved for collation numbers, I'd bet. Kids. OK,
I'll see what I can do since I will be fiddling about anyway.

>
>> +			if (tp =3D=3D NULL) {
>> +				kfree(cp);
>> +				kfree(final);
>> +				return -ENOMEM;
>> +			}
>> +			if (final)
>> +				memcpy(tp, final, finallen);
>> +			memcpy(tp + finallen, hp->lsmid->lsm, llen);
>> +			memcpy(tp + finallen + llen, cp, clen);
>> +			kfree(cp);
>> +			if (final)
>> +				kfree(final);
> Just kfree(final) is safe here -- kfree(NULL) is valid.

Just so. At some point there was more in the if condition.

>
>> +			final =3D tp;
>> +			finallen =3D tlen;
>> +		}
>> +		if (final =3D=3D NULL)
>> +			return -EINVAL;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> =20
>> -	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stre=
am,
>> -			     list)
>> -		if (display =3D=3D LSMBLOB_INVALID || display =3D=3D hp->lsmid->slo=
t)
>> -			return hp->hook.socket_getpeersec_stream(sock, optval,
>> -								 optlen, len);
>> -	return -ENOPROTOOPT;
>> +	if (finallen > len)
>> +		rc =3D -ERANGE;
>> +	else if (copy_to_user(optval, final, finallen))
>> +		rc =3D -EFAULT;
>> +
>> +	if (put_user(finallen, optlen))
>> +		rc =3D -EFAULT;
>> +
>> +	kfree(final);
>> +	return rc;
>>  }
> Otherwise, looks good.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
>> =20
>>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_b=
uff *skb,
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index fcad2e3432d2..5e7d61754798 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -4923,10 +4923,8 @@ static int selinux_socket_sock_rcv_skb(struct s=
ock *sk, struct sk_buff *skb)
>>  	return err;
>>  }
>> =20
>> -static int selinux_socket_getpeersec_stream(struct socket *sock,
>> -					    char __user *optval,
>> -					    int __user *optlen,
>> -					    unsigned int len)
>> +static int selinux_socket_getpeersec_stream(struct socket *sock, char=
 **optval,
>> +					    int *optlen, unsigned int len)
>>  {
>>  	int err =3D 0;
>>  	char *scontext;
>> @@ -4946,18 +4944,12 @@ static int selinux_socket_getpeersec_stream(st=
ruct socket *sock,
>>  	if (err)
>>  		return err;
>> =20
>> -	if (scontext_len > len) {
>> +	if (scontext_len > len)
>>  		err =3D -ERANGE;
>> -		goto out_len;
>> -	}
>> -
>> -	if (copy_to_user(optval, scontext, scontext_len))
>> -		err =3D -EFAULT;
>> +	else
>> +		*optval =3D scontext;
>> =20
>> -out_len:
>> -	if (put_user(scontext_len, optlen))
>> -		err =3D -EFAULT;
>> -	kfree(scontext);
>> +	*optlen =3D scontext_len;
>>  	return err;
>>  }
>> =20
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 7a30b8692b1e..40c75205a914 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -3919,28 +3919,29 @@ static int smack_socket_sock_rcv_skb(struct so=
ck *sk, struct sk_buff *skb)
>>   *
>>   * returns zero on success, an error code otherwise
>>   */
>> -static int smack_socket_getpeersec_stream(struct socket *sock,
>> -					  char __user *optval,
>> -					  int __user *optlen, unsigned len)
>> +static int smack_socket_getpeersec_stream(struct socket *sock, char *=
*optval,
>> +					  int *optlen, unsigned len)
>>  {
>> -	struct socket_smack *ssp;
>> -	char *rcp =3D "";
>> -	int slen =3D 1;
>> +	struct socket_smack *ssp =3D smack_sock(sock->sk);
>> +	char *rcp;
>> +	int slen;
>>  	int rc =3D 0;
>> =20
>> -	ssp =3D smack_sock(sock->sk);
>> -	if (ssp->smk_packet !=3D NULL) {
>> -		rcp =3D ssp->smk_packet->smk_known;
>> -		slen =3D strlen(rcp) + 1;
>> +	if (ssp->smk_packet =3D=3D NULL) {
>> +		*optlen =3D 0;
>> +		return -EINVAL;
>>  	}
>> =20
>> +	rcp =3D ssp->smk_packet->smk_known;
>> +	slen =3D strlen(rcp) + 1;
>>  	if (slen > len)
>>  		rc =3D -ERANGE;
>> -	else if (copy_to_user(optval, rcp, slen) !=3D 0)
>> -		rc =3D -EFAULT;
>> -
>> -	if (put_user(slen, optlen) !=3D 0)
>> -		rc =3D -EFAULT;
>> +	else {
>> +		*optval =3D kstrdup(rcp, GFP_KERNEL);
>> +		if (*optval =3D=3D NULL)
>> +			rc =3D -ENOMEM;
>> +	}
>> +	*optlen =3D slen;
>> =20
>>  	return rc;
>>  }
>> --=20
>> 2.20.1
>>

