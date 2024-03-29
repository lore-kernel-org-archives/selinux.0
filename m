Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863B1C0DDB
	for <selinux@vger.kernel.org>; Fri, 29 Mar 2024 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725584; cv=none; b=d3Q6ZOKV6KFLM8MgBoRM3teBR0clXMmkc8eZunluyW2z2GCibsImcc0IMNH78AiVL/mbV6hoHm7wGAgkKGMHZ1YlyqbXKLOdldOn3tIIOVbd7Plylx/7Udm5wy24uFGDTq/QNQ1NUParLQ5Qje+n5aaYUjNFx75ka4u9BrzsoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725584; c=relaxed/simple;
	bh=FVebU1TNg/c0gTEK7LYf0PjVx6lJ+f7Q+zj7w6ps5AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVy/1zPSnC661+3gvgsZEVohZUckEEPtRD7PU0N7E9mYHXrH8jUwGK8igYeswH0h4LDXfmn3urZhBVYsizl90pAdzux29ajlCldsElw2yxetRxgtaQOUDfm4Rilpg7xJqc4BEd5o+8srCrKzinzcBHitdM6d1a3Z2nR3fU5OJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dcWuLZC/; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dcWuLZC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711725581; bh=bBj+xVlTRZsCwoKWG1LhU2euabd/Zy1SaThJSK2foM0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dcWuLZC/x4d1od6LQ35z3N9bKZ+i7DedcLg2W0EC39m4pOdTBRl1FvU2AmDSI9LtKHY05P1UcWjzBFJueESvaIej6wNzGtwEUrp5a3JhJvyWlUpvCP4XIWXya6ZDZw50cxRUd+dLf5rs0NdLQrlruRn/duk+ilfADw/UyDHq5ktaVievBI5DXZLypdB9PMqAqAxhB5kWx56vdj9NEb6SeJ3e1Jjx+/2uMevXe8FG88TfL1jvRps28blD7hrmlbZ+Tjfw0UaJ1vkH8ZG07CRPh60JXqR/m8JzsOsd5vcQ3QlUE+GDZktEi3fhxs2u7QT+yY7ema5kE8z76ytqj7xRYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711725581; bh=M2donQ5zvX/WMVWWs8558AOwgUM6zWGQU5+zhHH0uDK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IwohUklce0TE6uD68gGgOGLrvFgJ58icvUzjdZ2Kik3b2p91eYwG7bBVzualqbv4jV/VazhGuKB1S5Yfpdg9URqplnPcBz/0WrH69b09DperC13xH+rAQFpW9n0hwDtw8QrJkNeKIWMb7tFEhRYKxQ5NTNL6LImmhCnajVViDYwt7xmY59JZh1/e9M5iPM+aE7dWQ/e+90V8tZ1JT9xKek7/rYbneXDhK2Zltd7hnvi0VqH8OpTcwHA/HFVfj6108gRPm8xLMDZsrZLfspVglAUXT2DSmNXCTPBI8mkql6fKHe6py2FA7WCOF4F1ofPzqxivOki4l9/pljTG/vsFrQ==
X-YMail-OSG: CSsQ4c0VM1lttEu.fwKH4IiMKzR2PiJ6syfA2sFFFe_dMNLnxsVVamP3AbEkREz
 5TSaNJW8OIOvU4QItWO2_wUngp8QO9RYTrlOCtL9WrS51p4Ieix6mgyRfULD1YdOvDpWX533EQpI
 BAHt10OCIF21Dy6KqHBoCZkERex4XA1qhfbfzmORWg_Q.KvvbZPRIo7EBbu0I2RSbAentepzA.bs
 QyeB1nA_QxgG.IdLG00N4eJ_4zIc7NqJc_k6sPrVvpKtOuX7k1KhttqRbxsyhPqw_Q0.K2472RMZ
 jfa5Ht9jD019yCUzOv2bE.jucsnfI3qJu0OVAPy96MhwCh6YxjpwZMP.Plj2pImu2zRcnqF6M2MC
 kBuKIe6OLM6cdo07.LCDYaKx3Q9tg7sAUwA.zAQvI3mDEi1lF3LDFo1.73VMGFoXltBGsK9mZFfV
 6Cxz6M298WqYaQWSYkLa5av6fAwzqxPn2fCsaXWE7AaoqcX7Y0f3q6BVz92U0DcL3JXkUPbLcm.4
 kcJdSko_k_UslqzSlhZCENaJTMDzGHy.f.bRSFKZX609PHszJR2e7dQHQGpw_icjoij.eMq0QUqh
 G6B9QEVEQPKPK336VTCQlxx2w.f1SAMt69DvPxEtVRgd2Ziv1ni69lhJLtE6J0XK3KCb225u0WeG
 QII8PdlYuOmQpHxBIv7Ne22CbI3InStqy6GCuAb.zDdlZLwvom2bIwhWZt1Eq2zB2imSG5CJP4Ry
 OMnLa00Ms7JTXogPBfOL2L2AGggslLUOanfRlTFSCW4hcHVDzOr39LI8IqYEJKdoZADcaCEsat5r
 T_foNcfwP2NP2dCoCuJlfzUGCGL.VScHRB65TFmJrliy7NcDm3pnJwa_2xBt62qWM2KvtogtrgmC
 0aDKyc.t9B8UkGXvxBKUGSqFUtkCYM8VZNaqLVOsgd_wHS9LTrtJHzSc1H8CZ46bB_ei4W_f3dy6
 4QTKJxvSZBW3bzpMhnvPBif5TcT0mnijsHudQE1Bq5_yDeFVbgVZYokVcy_Ey2BB5oIhM8z.BAu6
 gud91d3hrMu.S8v1KxiFSayQCUA6DJ8K5zi4TUCyuPvl7TMI81BnDN1XgTrXg7zl13Nq5I_68GmC
 4Cw3XHs1rUfzDbnwfvYqJnOStzxy3D4avBeDdYMRQrJtNeaXqL.Y9HvuwWzsPjUYFdcr0g5KSck_
 2Z_.G3Zc.Uv83dlnGW3.GJpRQ0cWRtuVXxIvbxw2QqSNQaKQ0mQfpH_gX1WREZl9u1V2q5__.kvi
 C6pRW4WLSeS7A0kawjR0ILejZ80GBdJ7wZIgHIlLPNoPLcYMPjY8zN9eoZ3P0SOmnMCidNFyfZSi
 WEnlbVQNGic8LodDaZ7uR0xvWuSuk4InWSSjpHsngbW1aPOqIEPue7Qh0bACJEkfMNESLCZZwa9t
 9d3vkzTfkhOSKUPMbWNfHDA9HXcC71EqNwBS_XIC2sd0oBrVrLnidwUzNg26S0c_7.VD__S64GM9
 X4DtNYz5brtRsElYvM0G48_BR89qHXJb56nDWh0WbFEWIhe9uEef3vJuynggtILlj30SBgg1rWqy
 TUCma0X2ictx6E3auBeXOG6UVdYwIJhyKFvfhbIo6RgZkUpVfOImJNYr5zP_bmJFQnWaHlxSwAex
 M4tyFB1E4nH0_LprohJorJaIErY_DhF_xQpxh1b69mDveOsGPUNWWaBKn3REp.svnVNEjLMvWvlJ
 Cr4Kq2aBMMKZYmq59oOqXvTCsIaH7pL6ZVyoUp0sE7z05LiFAC0HlUjmdVO6nEXpxu68N2skUjke
 .GZkNCJtavfHLZXdw869YdsWNjcbXHmgKXd6ULK34_0IPg6mUTcq6ingLXjR1AMpIzvPIfGHpAZ2
 HcxJ2_JeoJsIjUNKUAI1F6KxtPKPmoHQegoy7PJatt6yFod9efR7Eo0NWqNvofUzs4TELJ4Nv04r
 WV06EozDp2WAwNbLfIPMfoZJfZ2ysGWXKVMYNfTXa2lqtmZB4PNvqyNU3RHtYwtZvOGO0tYipZKW
 4cRbvbjzCIHJytp1tZxPxvZEdnP8w3ncXOOkRgpLGKxLxxryz2FRMEf.ok6S.chpLIr.nTPbjuKR
 8QenFrVeTyLmbbaQ8ncbtCueO0ByHYDMlc2Ar.9ApvvEXOqJPGVnJSRX.3AlcQ3fWlmJsIpXeYsa
 YFZqF_9E7KIZbJ3EPDGVkhtLDBSPcFLK1wWFJU.1Ag0A8aKyrVyxBMNSJEFi0_FHRVPFP.BMFV8Y
 iJl1AEI6xyMJlaTj4PghEdauMSMfwacVxbkUMc_aFhP.D8YklRVUd8vXswAm8n1KXPs7KrmEem01
 TpWfKz4MZvA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c3373593-a600-461c-9442-8ad878511d83
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 29 Mar 2024 15:19:41 +0000
Received: by hermes--production-gq1-5c57879fdf-4h5cs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 54b2aaa1354c496291820834bb3b3e1f;
          Fri, 29 Mar 2024 15:19:39 +0000 (UTC)
Message-ID: <27065c08-5120-4458-93bf-d7378dee3da3@schaufler-ca.com>
Date: Fri, 29 Mar 2024 08:19:37 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux: avoid dereference of garbage after mount failure
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 selinux@vger.kernel.org
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240328191658.210221-1-cgoettsche@seltendoof.de>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240328191658.210221-1-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/28/2024 12:16 PM, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
>
> In case kern_mount() fails and returns an error pointer return in the
> error branch instead of continuing and dereferencing the error pointer.
>
> While on it drop the never read static variable selinuxfs_mount.
>
> Fixes: 0619f0f5e36f ("selinux: wrap selinuxfs state")
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/selinuxfs.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index d18581d741e8..7e9aa5d151b4 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -2125,7 +2125,6 @@ static struct file_system_type sel_fs_type = {
>  	.kill_sb	= sel_kill_sb,
>  };
>  
> -static struct vfsmount *selinuxfs_mount __ro_after_init;
>  struct path selinux_null __ro_after_init;
>  
>  static int __init init_sel_fs(void)
> @@ -2147,18 +2146,21 @@ static int __init init_sel_fs(void)
>  		return err;
>  	}
>  
> -	selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
> -	if (IS_ERR(selinuxfs_mount)) {
> +	selinux_null.mnt = kern_mount(&sel_fs_type);
> +	if (IS_ERR(selinux_null.mnt)) {
>  		pr_err("selinuxfs:  could not mount!\n");
> -		err = PTR_ERR(selinuxfs_mount);
> -		selinuxfs_mount = NULL;
> +		err = PTR_ERR(selinux_null.mnt);
> +		selinux_null.mnt = NULL;
> +		return err;
>  	}
> +
>  	selinux_null.dentry = d_hash_and_lookup(selinux_null.mnt->mnt_root,
>  						&null_name);
>  	if (IS_ERR(selinux_null.dentry)) {
>  		pr_err("selinuxfs:  could not lookup null!\n");
>  		err = PTR_ERR(selinux_null.dentry);
>  		selinux_null.dentry = NULL;
> +		return err;

Surely this is unnecessary.

>  	}
>  
>  	return err;
