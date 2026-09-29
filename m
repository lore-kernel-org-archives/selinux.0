Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F2351A754
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699002; cv=pass; b=thM1yr7A0KG27AyAW54nuK+23ahcaTYeBOG0D8mzs2M4xV7SMETJPmsQepdp1y7iVi0wXt3S57qrp2L6DIneVX8zOzDCK0h2YR0fiXKmlNDzWjdMxFO8cuhvo5PukYTYEKhZsWGHzCTCUFtdsfiOwkeDK2ypMjkjsdmeDfRLdD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699002; c=relaxed/simple;
	bh=ysyMhQeVNpDzWtUC9lor4RwdT8c6qwruJK4DztXrR94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHkqhbaPLZAivae+MQn+7NYgJcSGvnaYvg4WmOkAdI/oK+sz1g0gEoekgLmGhWdcVv4k8r96wKZwPTmNZyXFqNdGKHy7MRFAn8KSMklwGdRXruWIu0t0VnMNP32aS8d7xrQfTkeYEx1F+hDs/C2Q8FA4UWxm8IQcBbXGu5Q/pJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clRlIfQQ; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clRlIfQQ"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8aa75b33a26so25375577b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699000; cv=none;
        d=google.com; s=arc-20260327;
        b=UVTEWUFODrlRTYAr+R98K4gQdmtjdDfQUfGqx7CQ7V5+9LLsRuIT/RrVqAYAGjkAQ1
         TlQM9WrE3p8iFtJMYergi2QGFSXd2/i4u+5nJ3v2m48x5Ty9mAGR1sN247R4Ou6YIXCK
         uPE7HjavSzaClXl3CoqmqigD60xQp1VkVsxcfp1GcSK8xNKGMsOaPV5KvdEHdXzygsfj
         aR4slCO6+6bU/z93XzPQYeR1L3BZ73tlBErQNbMuc51dOIBu2msEsJMl40HMAI+5B/Dj
         tFnzeGUTuwpvxtjmbxbl7FuMHoANdBaw4cy7EAgY/bW/+U5Uf5yQKzTZlSQ5hW9ruroI
         raOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ysyMhQeVNpDzWtUC9lor4RwdT8c6qwruJK4DztXrR94=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=SuXo0QI6kT8vICzFu9Bz1lHKdSe6gVxI8SYraMLBBTsB8PjBammCsDnd7Lm3LXgHWQ
         p8vkLJVcwcFJCTKouKHEADRXan83+nk/4RqNRUke8U08HpgPeZBjN5gRnjnFK0DQieSQ
         pv7UAh/KX916niWN1W76jHNxRimHGuFHUsBsyu9oFpC3YAUVr6xczGaD1vvw3dXoXfhA
         ZLKJ65dIb7qB0ozfUaWgkrVic9vghhRqO5VXdcMcHGhsfbgxkqJzG7OhkD4yNG2ruPJ6
         fWHiZQcDetwFdQjjdW/SGBmsXz4H/qVLmGpqcmm6Xu+idcJQSIgDD0ygLzLshm5iFLyt
         7HPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699000; x=1791303800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ysyMhQeVNpDzWtUC9lor4RwdT8c6qwruJK4DztXrR94=;
        b=clRlIfQQXqcGZYYFrkSIGfeO2ur87Z8a/UdM2kZUHEt/GiqlJqhR2KlmCUFWX92Q/c
         dr06RnJEXaI8mSsebNLJA1pSsOK4dZoMcnhICbkia6aMXf7CK6iaK8Zp5JdCuyTH6dpK
         Teaiq6ltIFMH8lZDsXhExASbgYvm/G1iE4SP3/iBP7mBR2CpfqWgJID8JaDPw1MKAoWs
         +/SicRIdE9IZ5Luo02Y/UGT86sFNrJ+I6mRvCqzs+gqnLwckK0Fj7SbkyjO8s/wC47SO
         WH7MVcfBFMguJziE66VVQ4d5oUJxYVUDIu3uNiBmDVauBKG8RX0iXx6YUERw4UUkjS6Q
         ZlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699000; x=1791303800;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysyMhQeVNpDzWtUC9lor4RwdT8c6qwruJK4DztXrR94=;
        b=MpQqWsWXHMnDOkhrBcC9SVaIT7G6Je5JigMRCyFXhdxP1A5kIswD9P4lrObySJa/yP
         eJhi9S9SWj+XAVwNL8IkfOMt14Z/dBApvMKH8eK8zXrrF1Dp01BMVW41hbHK1Y33/VAn
         eR2XPHvm5n3ppW7hkArlRjJ8VFZIaKK2F6lRHaaDLncjZQ2ZZv7mkq8i2rSdnUjin4my
         X+arqmnERx8ySmUZ9WMnMdNhNtJNX2OK5z3VuffQFlJ0SR41S+4kQcMGmYSHJxiFKLxE
         dhw5EUW4veMePsQAAFvZWYVzUhiVU5KkKX3jQE/N8pOf5mE/lJkZSwlmlNt45YqD/9AJ
         0oIA==
X-Gm-Message-State: AFq9FYI7SWvteQffPPv/lEX09bn/3N7Zn0uxtIs+sdCZjQPZxt7ULScx
	R+j2HrF7wFQ0wkbMw7dHea9LUFRZJynLWnJltXZA7s6R1ujxIcQTsSaKpSZplkk1UaF/CjR2OcY
	6n5oTmaREIViyzPDQIGNFy/dajAYHTvQ05Z87
X-Gm-Gg: AYBFou3dtvr89DrJof24REK2sYCt9wyGiXr1izvdjjROZIirBhAne9gGKXOpVXOTmK4
	GeetQPSyRW8HxRk6m5YXdjTbH5dzbvCn+Ze62s0jawpUQT5Oexc40GydfWs/+YGzuUgbSQ/bnd9
	nj9zT4vzUm6FU0OF+jyDwKUxlfvKY5jzF5bTc54IIrtUANCHBfb+AJk+Eg26QTbyRb+eovJPV5v
	TAPcPDBxWWZm9+GbirCuMpjvPxOu9jluKXHY+ImNgBp6RixCF8Gxq7ctw6QJj9zQqEVPv9d59jQ
	HdhdB7DrEfc6PrEU6oYKO3gykynaXvkslZEI+47wi4m/6C5d28kE00c=
X-Received: by 2002:a05:690c:c509:b0:87d:8d6f:b579 with SMTP id
 00721157ae682-8a64af56fc8mr86696597b3.40.1790698999867; Tue, 29 Sep 2026
 09:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-6-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-6-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:23:09 -0400
X-Gm-Features: AclHuK9W-HRsQTFa0mPKLvAHbp0ArSeqfg8w5E7PdI_Tg3at16s1XOMDbRn490c
Message-ID: <CAEjxPJ7ic_26U5F-1skAGb2d0rZswVwdz8JJ9nkCwcF2xRHmDA@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] Fix typos
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:58=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Found by codespell(1).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
