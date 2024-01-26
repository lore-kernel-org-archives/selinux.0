Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C931D559
	for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287025; cv=none; b=ED2d8wAdiDqm7/U+ZezgMGMGY3838gNQD2RuRgytPs7BNEBJeX1n1/b8bNdjSlxVHkG86MvJuTJIu+PFv4506L02eH7gZSRRjRVNSh85RXH1f1dQRr6KXfSw28H+BuGZ6l8tPLxXxd/yv3whziNgF1XSZsi1RU78nVwQwbOtER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287025; c=relaxed/simple;
	bh=wSmrRfqfJYXAukkoC9bFymxs+Pb6XIHT5Xn0NB2N21E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiSiag3nvcd5TCBFgYVsbgLKHGJQHjcJ592IUcmf3eruKjoAHEFDJ8LN/qJaxgL9lko0WSJdzVcotXuBBFfcGa/VrGrn3vdJsiOfNUgNYsrcDQXEi1l6Kn5U2bTuFL/5Phm1eSBU/bAlEV/O3i319EK5PBa0Z6rrzRtHsnO3Bxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fNCd6Gfs; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fNCd6Gfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706287015; bh=TYSUJQEGWBvrlpg4P9k9g0mfK5sCeQ5uI18J3lbJD80=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fNCd6GfsQFEBb7Pfo5NEAa+YWIrC+wnVTzmpD5oWhw0wL1R/OKq/UJPhAMvkkM2coSFEuw8sbM+8A3U9oPFOd3taDqjOqcmI6tkCkZLQCEIVFfKQ9aOswzSTrQ3DEIbTaqnqNpKK5UmYkvQwkbn2foasslcDcr3n4UPRW0x4qkdXjDBIDsX9Ccgdk5K/+M535qStB/qFgfxYKPPiieh1A6PuutlRRVTnsCFrpHIV9UOCWkFvxs5lIaiUnLsoxmQwLBd9vJF03prT/fFCF+cRdt440JaRlGk481j3UpivChUG2Eu8U5LcOXIrynZONpLSLGhOFVATNosNduxhzstOLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706287015; bh=a+kEE3L0srdY+7z6MZT7rV3uTx59301U3xwqbdu/SmY=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=unGQ6bgIRHYFDeSrD95pc33ZhIZoXkBxk5HxCSSVArfmeQ5dF0DgIuQaEFoeAXhNrgC9het5Kga62vynbLvHx/8lV3Cnr6O9VLphtY9c1vOVwRNRMJZMV0tgB3Np9ZgMbq9W8KIouuSySfqgxX2IXwPSAS66ohAOeyr+2uPopUqznW8O2IKKuiCXrkPpJkkeE24UI7tT1DnmTPngi5fMGRR9rXopKLXkrJrlr6StiMp7+GG80s60XhBbiaJeK4XBR2qNdTYs2w+XhLE3+Edl/iIRv1YhkclTKRro+17kV8nPdUz4YTojapWokZ7pq65cRjFjDiTHRgMEo/qJv640Tw==
X-YMail-OSG: AW.HhQ0VM1mcTX3m9Iw0Ra9Q_q6ldJQ9qD3k_qmX4SGFk.8wdNxyltE4eTJiumB
 Xs2qEkliEvJ.bZX587_B1uq9fOB0MgmxSJUEwmJL.O9mNgNFX0o.fTVUezvYnYfXudeBE_5Kmbb9
 EoWZBJy9aMKxH3BuNuNQC0R3gb8zgO9exwpt1fNSiHM4AVS_jqErB.Qho9vyeiKrFvN02ISF.j6R
 7v.zEmNOUlD2w7za1VvXqK.tb7F95jOnOZminfTj18W5WgcXNe0E.Oi9.t_35YGo3u4OJA_9p3CD
 fytumVLixR50njw3DPZlySWDKVddenCrjyEd1eOpe4R.X300nMswDg_vYfguqDg7.tJ7FANIlJR6
 .yjEQzGUEPg79Y1bPhn0oAAXgTVwKiKjOxEEW_7I_8yJDwPUVJE23.6nspz3TsM95_RqLhENViex
 2cO6O9T4uVh9tMj8OwveR5iIaKC84nTHCmpftP_EC1QkCEAqmtlmGSBW.ZsSxh2yrlCZIn7QkTms
 iwlKiQRLpXwk2TWPPv07P7e0sBkviV3H3qQLXc.uNImb4q4z5AENMV.V9Y_0s3pfNdAnBiwezc27
 NRCUW5B0Pp5_82Avxgjx0AKYi8Qy2T6inQL1vC8O0kIAGBgUhuYaZVJXD1NByL8.S.KZFPsokzzS
 6kjX5d.rJxeahOespa4MZCNHRgBork9uisArbaMpZtYS3FuoRLr1hQu6hrtsgjGv79etCp.nBFH3
 RdzhpoVCCNxdu48VL49mZ_Xzbm5cceiP2aU0Y01oSyOSCmBRdbWIQl1nGSuxDpymHkuzfAzrwOli
 Xqv_M5DOWpYQJ2LOonKd_bsArKomPyeY3huI3zcf86CePhEcIAjNh69CaChxQd1eO7qL5PTw4sHp
 aPKznNPi4vYonYnUuh.tWzdGgzL24ON7_go56XGZGiyHxC3AYBzmsxVT4nZlVghQm7P8Z1hk..Jn
 kZ9jKpL89KyxzmLVBo7ptWCKg1A5v9brYJXPyyR4CZDjAwUji26ISHojvaDyo4qIv.2jh3cEzCpP
 8PW3a6WcGg3UecYvLcU0rKjGqZ4031xx4MW4D0B4sIRFeTtlfQPHo4y17l63BHA9w3b65i1DsqyI
 efxnsCd2LbNzxbtsCVBX0xyeTze6GS.qMPI0BFtKQaBFZQF3H.cYwkWXbC_p0IyUxjO4iZYJ3Juk
 VTrR84W7c3pMmRvllkX8lWTOWQJWjqt5U_t9h3nteEifh2dklVH3tfLKP1cNum.jXXqaWqTZuFht
 3IZ0V578U6ItIvSjxCvPoEhLBawcPalOzV6UB9grggs2YHP1FbVuwxDBviSBfBoJS0oeY3giEXk.
 2WMI1ehUp_UyYIHtE84R20vpeNtFYRk6ldMoKAIDF_9Gao7uYf8F3huu.TDj4wGmYmgHwsN39XEr
 pwTWeIIzYlq_XNWjB2MqG7kWzEEzjNSqIEA82PdfATvruwHns.RzwTL3aNp2cg59Mobsec9v0T2M
 RBsqzlJ3VMKDAf2HvREM9PtoG9ThTAUAN_QhyfFvBq_5tYXCxu2e_yCq3xzsax8HMVOA29sKaeFa
 56c7Pxodt7ui_ODPMEpVBP6ZC3S9c8rFzToXi2SpdJsxGQ7FSNePLqyukYk9TJGbH510eEImhQGP
 0g.KYaPyudmOfItQHx8QbvJGLjcoc2HBF1Ry_nhjPFon6F_KXOZz78TCPZQmY.CCuEr64G8pmzjL
 myKG90aU3keQXRIabu1Yt._l5wMQhEz5mOKFU8.bI6uUpHd9QjcONhstwSvEqePXxMnhCPFC.fsE
 NWPJfzcp5e28LAeUjS8.y02_jT5q2Dcqn_citzuYL84yNwmChsdc84VAEEFQrMHVJNQeD7dUf4vs
 stf_MlOrBhCEH.13H56mYs0q86OCyrPfnRaS5YaWXUSN1kxXpflFSHGuAkMSl05Qa2E7pYcqeVLs
 2SuACQLZ8OoaPaTU4yoT852ZMbHJFkmWh_5WQ3gMCAz1JRZ6uz0xFl5kUPfL08ZIej9WVyR1QpWp
 BaDc_CRpJ3z250xNSC01uhlWd14SWhEkmTbSQuG55l6IIPQie6kAvAr.2L.MCW9wJU53BdEgwQzV
 7BsNuE7SZPJxzznYQ3Y4fu8BeBy.KmBrQ88NbUhQB_j77pOdsxH4GfTzKzvtb3NZ57bRFRSvMbyC
 3rcBCqlxDzy3X9wLmji8ln5b016M5vHBSK5WEByhyu4xAHyAv.UcirbsZQ3Mch200C47FYHNNwqp
 6k0GKet8h0YLhbYnptKJkJm5YM8mzuqqHcpl8wqD3tfT_D_MeULz0OV63gY3TaGKA2I613MAHm0i
 EwNCwS4CF2KS5ug--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8f6d3212-678a-48e8-9810-c399ab7475b9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Jan 2024 16:36:55 +0000
Received: by hermes--production-gq1-78d49cd6df-mnx8f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3ed002f489920444cb2e810213f6b866;
          Fri, 26 Jan 2024 16:36:52 +0000 (UTC)
Message-ID: <86cca857-2d7d-4a9b-9191-185460fc9943@schaufler-ca.com>
Date: Fri, 26 Jan 2024 08:36:51 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
Content-Language: en-US
To: Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240126104403.1040692-1-omosnace@redhat.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240126104403.1040692-1-omosnace@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/26/2024 2:44 AM, Ondrej Mosnacek wrote:
> The inode_getsecctx LSM hook has previously been corrected to have
> -EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
> behavior. However, the call_int_hook()-generated loop in
> security_inode_getsecctx() was left treating 0 as the neutral value, so
> after an LSM returns 0, the loop continues to try other LSMs, and if one
> of them returns a non-zero value, the function immediately returns with
> said value. So in a situation where SELinux and the BPF LSMs registered
> this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
> returned 0.
>
> Fix this by open-coding the call_int_hook() loop and making it use the
> correct LSM_RET_DEFAULT() value as the neutral one, similar to what
> other hooks do.
>
> Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com/
> Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecctx")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>
> I ran 'tools/nfs.sh' on the patch and even though it fixes the most
> serious issue that Stephen reported, some of the tests are still
> failing under NFS (but I will presume that these are pre-existing issues
> not caused by the patch).
>
> I can also see an opportunity to clean up the hook implementations in
> security/security.c - I plan to have a go at it and send it as a
> separate patch later.
>
>  security/security.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index 0144a98d3712..6196ccaba433 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4255,7 +4255,19 @@ EXPORT_SYMBOL(security_inode_setsecctx);
>   */
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
>  {
> -	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	/*
> +	 * Only one module will provide a security context.
> +	 */
> +	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
> +		rc = hp->hook.inode_getsecctx(inode, ctx, ctxlen);
> +		if (rc != LSM_RET_DEFAULT(inode_getsecctx))
> +			return rc;
> +	}
> +
> +	return LSM_RET_DEFAULT(inode_getsecctx);
>  }
>  EXPORT_SYMBOL(security_inode_getsecctx);
>  
