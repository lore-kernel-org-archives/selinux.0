Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545D311C2A
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919687; cv=pass; b=Eq9mnDZNCClPwtkf+L3lcVC50zHt1kPrO6+OFTBIlpMQpYR7ozOMz5yzH9L7i1W2J79HECPeHswhMv7+S9VYJ5y2ObDOA8TBRjeKqF8Y0VLgFtz/lOMKFFLofJ8pyO8d2Qn+zn25wSZJcgNsRgo+gTf8WFmoI42mcprERd0Sn80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919687; c=relaxed/simple;
	bh=/ZYBBEAu4X3i95xWgQ75FhN18HhXl+05CmRaXgMmXxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5Kbk4HBw5ztw8Qh8zTfsmKoVYhpprDG82ByLBjVzCP4F+WCqYql9ek2jnO0gnpOCJWW4f61xMpKVFP0VetmZy7XM+E05a8fifgiou+Zy6wHpmHxaqLq7152AC4OMHjI353dZB18QUCfbxD21+GAlsctGw+bnyw39wHCgoqv/X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ttv31EEs; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttv31EEs"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-467964b7c4fso829413fac.0
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 05:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787919676; cv=none;
        d=google.com; s=arc-20260327;
        b=YlT8y5FZCQN1+cemE4arYYU1DWL63Nrz851txD9EdBZHSwY+d/yQB5jIutKMP9dhbm
         PqKhazkNW7r4WMWhwmYNMrtpO6nR3HqkJFdB8NvoE9SeFrYJa+ad6a/fDzuvxh2a+W3w
         SLptLxMV6IlaiK7zKJ/zzOharzpyVhJeghzMr+sWg1FtvKRe+9rrenR+AiVbS8z6b0QB
         shGB+Ptp2ojx7fKYjweAVYUgISN6+RqWDEp8eeMDxblK6AFcWg2jcbWBotmizDqoPCiz
         NGmRbwbQWKyVCVUoAH9JGytxkvaHMny2576xKrA3H6P7GeGJq/ZxelMD2Wr4RylXjqNn
         C9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ZYBBEAu4X3i95xWgQ75FhN18HhXl+05CmRaXgMmXxM=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=WWi2JJp1+MnCsjz6vCXmeFK6/mBp5G/Nt1J5ts9QMc08Q7ZrXPtd5YXUL7PvzwIP9h
         YL3SbVFZ+g8oSauSlLS3aPwmGDjSw8Jt5wpoL+nuZJO0jY8YRkpxrAchv/1QTaGBLukK
         v5hKyxooMK2qHJ7+KDZC4B70Dt1+lerxUml0XlZarLUg+t3/91I6F0QhvosXMBXS82NF
         6lTCaYi1irHIZOBbkVjqE/LZ8e2Od+IIhdELEAEmBfHHth22krWclza1J2UVKQrdHu15
         mvrGhllKdbdlmgPYzogtqK0VW0uGAmTsdfFoSbNSQBRmIIJToxhMCUk5lwn5QvUw0aO5
         KG7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787919676; x=1788524476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ZYBBEAu4X3i95xWgQ75FhN18HhXl+05CmRaXgMmXxM=;
        b=Ttv31EEs9iqbUWOYelMkb7Z3GwW6hca2a58x2/BRalbiNlhWLvCZKH5Acpmj/YR/ue
         gPekC5vCBv2wnyMY9Z/tJGh9hmlXAfGT6OnG6jCXLiHZcgiDKhiLUIr1dWvM0en5gXwS
         EGSrB/K2yxA6mpc2I7XEG20gBmS4Pgb+zCC6OjTxbinbHdEOQX8hIOLvWN0ayt4ejgWn
         EL6IXM9gam70BoJAhFpHxzdZpeXriQgpxPLBU4EPnhxETbH58bEiF+6bKkWVFPD9c8Dv
         h+lU5oEQTL/7E1NE6SZYxntImLiYGCtmTcloZE6rf+jYJgD7C+oksntuh9RZInaJwv38
         6ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919676; x=1788524476;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZYBBEAu4X3i95xWgQ75FhN18HhXl+05CmRaXgMmXxM=;
        b=NQz6or6yf0Ui7NL2jwfnJymM2aBAnpAUcLIVwxfxi2MtkM3HNNipmylJEAIMKhOLlU
         KQjGCsWkLOl8wGQeBm66966pedbyzZs53p1bVgtom6eCczZ1wbG1st25WXtqcQ+bCuwN
         TT4o89reBzxn9YATer6THuclOiypRae9Nvd9NelBzmYrrv5o1vImMGjMijfOwrq1LzGw
         xmy0/WhJWqom4vq/KCxazXynC7VdhEGaBPHawkhK1n5EsLnJSBB+0pJAxG0050V32NUW
         rZmUKVsEshSt7Q9LT47k9GWxHH7n8ZflBeO7KVyy9NYIaAqA04f/RTVQ7bC90eF1p9mp
         m3Dg==
X-Gm-Message-State: AFuF++mCfn1wHkcYYC5BMbNwNjIDiRfUPjY2GArh2SxAomj6wvAMBup3
	Kj1tzXXKw7Zdzxfr7LGMGJ09moe9RSTWbSloHUqQyip6wGr3Djf/SWg2q+ixHQ1Mis3yo0yB8VF
	yUge0gCaaFEOROliHdHhra2i0EhHObHXRhw==
X-Gm-Gg: AR+sD12H/9kkZOLKH9ThACNrAmvSIn8akNNamauwzRxLTmME3+AWFlcFOPCVhZkiH3s
	2jPEGREsw5Jfc7PwJy7K6lAkjnm5LRPuRoWT+qgzU72rmB/jX4f1ou62+owvlm6eihFHvmEYPfj
	sI1famXttGGQ3Hx4wNdSloizOEiuOFSBjI/PTq2pTdrEWcaAReGwtb8EQ5EyKud0AUVKfZyPBas
	thXIOh0cHHiQNoelJGTAjTFWOBaqbmMQG4XVGwDnp0PyiMfJjXE2k93s22Q/DNqh2N3PxGjKMq6
	L5mbeKDZ0Ul4VxLJNWB0b2C0V8WCH3G7Z2YGinb/kSYaHcRS296ZGbY=
X-Received: by 2002:a05:6871:3291:b0:465:317d:1c68 with SMTP id
 586e51a60fabf-468354b29e1mr7623799fac.3.1787919676309; Fri, 28 Aug 2026
 05:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826142928.3091-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260826142928.3091-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 28 Aug 2026 08:21:04 -0400
X-Gm-Features: AcwNN1UfQPCnSiKjxeZ5GXpax7_4ZPknmplAP3JBE88wYWc1ihOpxrhVlV40yCY
Message-ID: <CAEjxPJ4S29oZLuA54W5gwyhYn=gqS57m2nmpYFs0mCNMYiF+nQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: semanage_list_sort: handle a NULL *l correctly
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:29=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> No existing caller passes semanage_list_sort() a NULL *l but
> we might as well check for future-proofing.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
