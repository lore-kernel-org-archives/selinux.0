Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC53750BC
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207325; cv=pass; b=jrwWpsyUHhNVjT1DKx/f/2+M0+o5wwFhcjb4g2HfWvMMwE/O5R/cZfss+WloaZiIRINvAsg9lS06QqzcxuQ4gFk055xv6b7Te2flcMgkj1YKuhANCOXfz7MXqEANIuT+P3qtQQTfM9IahBuaaL/hf+XQPnGbN/9fwxslSRaaJco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207325; c=relaxed/simple;
	bh=N6dHz3MC9BYdHx3xBvElb2JCTfrTAPgp/3hD2nsOaok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRNOwojutm6ZTBB18Z5EWp1FeJQ0EmC/23Vq4K3Bsv6LjyZlXxlS4bDUiS54vjVBgUmaKkD6YDO2ddhdMNN8Xb4JTms1GwVCpudp/oQ0MjskrGr7K1KFliMxVWAnv6Mafm9wwRzto1lquargYcvNwwZO74jndvKdWdxfnUz7rlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN41uk7b; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN41uk7b"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-46a3a8001cfso744297fac.0
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 13:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788207322; cv=none;
        d=google.com; s=arc-20260327;
        b=f0zu5g2PKHpl6zAsEBmlpUoiywtppi+Ac+jdXI1jXfocJ1osR0BMtbw576+2ANo0hX
         bZwXqkxX6W0kQaFgEEZ+nIF4seoUiBFiK16KwJvode9jdkNbnk7bdbucucS5sG42XGX1
         u3WzzVAN8kap15yr++hY/EmgK+GF9dGzAYyXtW0yzHSoQQxjhm+kJwoM/p8XM/PGtRbH
         cjpU/QoXcmjh4FzVVc5zaHPrvIDZ4OlHsJTr3xF9SXokGyoqR9vg2Rmp5/GHgxGAlztP
         OiO3Ulyvf07jkv7Gc3p0q05j0Vz3ZC3lhzOK5HVUvUHQxlcwM0fmI9eT1AWRgZSUrEVL
         W+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N6dHz3MC9BYdHx3xBvElb2JCTfrTAPgp/3hD2nsOaok=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=RFUzw8AW83hvE+PjGHnLUg4TJqdKA6BvMmNFp1W5n7T3GRjfpjj6uaofnbXMC6DHwN
         4R5TODtJw1PbfjTQ1z+N8fJv1im8DAGY7eGkzj4+XinJgkIGVzMhS+/0mPWrHOvOJ/6M
         7HCM4uhLo7nn3OZK3xoMocCRVEOe3ObTgT/mzjTSavkWedS9wULpA7B9Iu7Fdh/J+/OS
         6RqNkit38XY4/Wj7yG0uC1rbZGySuGzzGa4DjaYKPvXzwzZSgFDXXjYo/x6JzxI1QpqM
         0gOmceJdnAgzs1ztu0YHhl6HR/7fcWDHYJdlclZhETZ7mAG3CyU2o67HdlsxspUReV+G
         +C4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788207322; x=1788812122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N6dHz3MC9BYdHx3xBvElb2JCTfrTAPgp/3hD2nsOaok=;
        b=FN41uk7bF+EhBkggRIv2Z9VgjP8mhJTGhPLMPdctVbpyvVaFGvsSelHYVwxIvgMQQI
         2eiP2kLmNbw04aYIIxLIepa8SCCVDTvcqQ6polFdRaDRviWj3hjQE7kfn2accXpxLamM
         NZ3yA0p4mrJlbUM5ZO6iVg1D74yD6W1I1RLeaDlzDMrBcm04T9yJII7o8pbTczOFZQRK
         I6VPEXsjOuhyVLO/TFVLNz2CiDCJfkKhjuw4uLfO+OW6yXP3hyIXSOWWOXF1KgfV5gnR
         k4dX1OJuWXir2JWosPAKtJbYHIzn1EAGcyUIMX3f04HCp6wTjcNmjhdkyDw1ZjcM/2Oi
         i6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207322; x=1788812122;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6dHz3MC9BYdHx3xBvElb2JCTfrTAPgp/3hD2nsOaok=;
        b=R0SM08DuHiyPdbx0G6A40rMO3RSJ/NMN3Lcr85UDkayVtUrVCOi5Zbb3Aj2+eSdOHc
         9fPBJM7fUOdv5kl5+R3ddc5oBksolbesUaCnAq033BNT1RJ9BkY6cp4z9b+leIUEHEk0
         1Lv6ObXO6aDTpAdKN8Ufjfu9aKBD9lfm3HOezypWuFqY5Qi8Es56kAsDkZTOAVZy88Xj
         ojEAckoVExCDi/fv4t+d9xN2I2/cxUqWT32Z4EmjrpLiKmyc8D7q3pCaHgFZDN44AZUP
         SI47lXhxjGkIVZXFu2oooBX3KWsS9kl/a4kqBX6pySEGsVnML2N1jlmPstTLwGtn25U3
         4rfA==
X-Gm-Message-State: AFuF++kyIV8DQgnB8FLUlW3r9QE7yIi3S3E/ao5BIp7kX8oEnZa8Qp18
	RFndOMvbTYADb4d7asrmL3NrpHvm/1+EyNLMweAu1mbHmsLSNLJGU5786E8+83E1oQ90lp72E3U
	Ibm5iL2gFA3azQ60MpebunwPdlgEvDbLTXQ==
X-Gm-Gg: AYBFou3g+5JYkzN6OppLBeUSYB+vf/8zEMyfy3/lTaL2h58ToYdMvXcf2Y/+Pzry4VA
	yU3GYiNoJMJISzRQGdjx3AQ4/ZFko6idmd3+OUqaefYg0I7tqGm7GZy6blzMBCNrYHNUC7dLlbm
	hOk71ePltwFV9USQvDlXeZls3h2//jFhgMTmpuiyvSpSRywGqKAzNPs//P7YctxHVj2RguYaLxO
	IpwY11M0Jcv1PdJCq3ZMUdudpisY57SAu/kQgkfEGNbkBoLSH9ITdUPg+nbfPeCrbMSemPI8fIw
	Y63Dxpgw/IKsruICyhwne+SMgd3770po+FM3I4vP8c6s
X-Received: by 2002:a05:6871:89d6:20b0:46a:c217:c56d with SMTP id
 586e51a60fabf-46ac217eb59mr8263938fac.2.1788207322537; Mon, 31 Aug 2026
 13:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831141649.39561-1-jwcart2@gmail.com> <CAEjxPJ70a6MS+g7de_tYhiVxgME2cK6j-TC=LA3SsZkbTLixAA@mail.gmail.com>
In-Reply-To: <CAEjxPJ70a6MS+g7de_tYhiVxgME2cK6j-TC=LA3SsZkbTLixAA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 16:15:09 -0400
X-Gm-Features: AcwNN1W2gzcWKH2UrZBOcqnX-JGXcLN3JELTYS41_Bk1AOG-ZklMwr0XEeNAwqw
Message-ID: <CAEjxPJ4gv-rXds7U=9_hBT1ouvPSe0GZFp14MXCtzXCfW0uYrg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Tighten validation of scope index
 class_perm_map array
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:25=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 31, 2026 at 10:17=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > Commit 94e9e7cf ("libsepol: Validate scope index class_perm_map array")
> > verified that for each class in the array either the permission bitmap
> > was empty or that it contained at least one valid permission. This was
> > based on the belief that older compilers would set bits higher than
> > than the highest valid permission bit when "*" or "~" was used. But
> > this is only true for AV and constraint rules and does not apply to
> > declarations or requires. This means that stricter validation can be
> > done.
> >
> > Fail validation if any invalid (junk) permissions are set.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
