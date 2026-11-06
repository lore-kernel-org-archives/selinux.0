Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994590;
	b=F8QHU1hyzcFxDJKxVnAHfTbu3QIyvj3EKVQKdw9hPBymSIL7+f6Kwt7ER6kI1eWINtcH
	 8AX16saoN6auVquRM0fJTJ3NlVDFXQ4n7gWdZs4iohXkXAK6fjfR/ZiEL1X0hQ7UkQ1es
	 +zs8BZVFHrQGJn8W2BqdfcH0lOgLMzLEuU0seTPX0hs2ybGuzNFXdyId/W4zl76RW0DPn
	 w0Hj1D6XRVmPTEf9AnSiOhKBmlLEwDAlIDkVPSw+a/PLj0oC1bNZntbKIuUOqFfHlBHOj
	 /rxb7jhdv6p1G5d/IuXG/H+uMuI6FGl0klloi4A5IZcJHyg66XtvYXRKw/0G77PmakQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cTpLGlcrBef14QfFl8dD7RwbFJO4EskdPMYuHGUlYzI=;
	b=mBP1+jr0oFzZ/1KqfNVrHw4FiQpa5N3KZCeZKePTP/xu+8xdH15hvWJO9Gp0WQ9YSdMe
	 DxUsCN/Oycm7AZbYk0wUtuZ61GOX1yvKsRwuoIPRKaHLyMVIkcE3FRQIcypFGSHePDNif
	 WAUjwanrOEU1QKx/kWKNf5we5ysLg6Fx50bZ74oR280N5ErAVDu9VmEjPKLHeZz+dmUAz
	 ++uvCa5DEDzZFvghV9Zv64vWnZ4HlS9NWtxumIHgVKDYsdjfULxLNJ++ZL9qpD3kFmh1H
	 1QacQviKq2gMXa+f9W/uYW7A7i5mbraXrpSMWpzf1GF5FPDckCgKRfRHHUUpLr7/V0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r74m8S5C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BFB606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6BFB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r74m8S5C
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67c05273c38so1090636d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:49:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994589; cv=none;
        d=google.com; s=arc-20260327;
        b=FNmaTafnrpd662gS78wv+6HIC1qEDRk3hOB73bUqgwK1yYHSBTfRqr4tfj/oKFreYR
         eKRsntgFCnM1agUf/zJP/oWqKNGPfAikccw3HIMCvVZ4rtuSigPEUmbpvP3/Y3t0igT4
         hbP4z+66ZliUUMnnHUjGdstrIMQDFpbYjCHuHbdIONzrnrHomvUjIlGdGDn9EqzEIww2
         uZGz9GvOLkDUlsfYNXoP3oJvH0GOljnStlqQBpfoseSaWZUamc1v1zh7gqDjAQuWBk07
         7TBzQHXEzLKcBzcdKV3BevznVtoTZmDfeaeVRUG7+gc2j1GWMDzG3pa/YJxh15xmqJAQ
         meNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTpLGlcrBef14QfFl8dD7RwbFJO4EskdPMYuHGUlYzI=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Iglc/eDEamXqfwM8gjBMkaZfWBnedMRw5RQgW1h8CNyScjaT7Vfa/aeRnPqqzm6dDK
         acQHiGtf8MmlypQD9GNqG0QZTSsz2rKuQLXIvwYvzgkjesPNvgZ06rOkq+GkvrubjJKI
         +NpLu1o5nlGPzl1rQg/lIozKTN578KDvhkQ+3vCkYD0OgjvZZrkUHUYLzE0Ukytcwd16
         Zs8ZjvTcu0iFxiVIFNXF0pwDZgtOFjcgtg2tzpxBBxfPGfEVIczdZD2QOEhk5URzqk/L
         yNN4jf/Um8PQjFgGNqI29Pfzjt6pZy8GIkaFdD7dp/7MvKjSor7Id/svfDy7OFPAPsng
         A28Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994589; x=1794599389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cTpLGlcrBef14QfFl8dD7RwbFJO4EskdPMYuHGUlYzI=;
        b=r74m8S5CmeOS01Uqe26aMpR8k2jJjljUM1ocB9pL572zHlakwGcxorP5m/m+KYAzD+
         XmGUQaoIDAWQ+lx24LdT++XUk4r5pDR8uGpl9+rS4UTaWLDj4Kk5fz+wYI35lxEmBNtC
         PZARRCVJqeggBtfT/NG5WSWm6LqYKLALijrAig5d6dKIJ1L31HDfYbOPqp8DimhwMYX3
         OmIMtNXQdw0yRsDLfp2aH/FDs4yW2SIykEMMc4rCgRk+IfdtUkWv8Ijrk8HKVlg4UOLs
         vNRi1p9YlO/AMEqTI9sA7P7mFxgH4+9tayrerLWa5mpJdjMz4rfV/u+Lvpoqkhaij+lC
         ExkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994589; x=1794599389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTpLGlcrBef14QfFl8dD7RwbFJO4EskdPMYuHGUlYzI=;
        b=TPtbnhLi5D9oYFpFcoK2IJtPV8z0TAYrJMjZ2wVJoz4x7wgpPl2GQhi2XLVAGSX/yr
         iKGu84ShGVKUGGaWJ+Og+VN1hHEbyygD9Xi/5BA2ddiGNC6aW2i8phDIiWsMmE8Zvx5P
         kVT++/X8f9H/7RZf2zbKY4LVL45UGE9F/spNrm/6JuWVd5cgdJczRq9NpN0Zf98ZTq11
         0rTe87n2rECrH76mTOraGXLOdiM9sLmiZKUZMBlR07D+DToLvm/NG7e6lIQxX8nR0VYG
         wA3Y2uWsKN4UPWF6fEK+uXSF9DaZnnyB2zVWPI000Bhj96qz+nsqPpArVmXl5Ebdvapu
         Dw4w==
X-Gm-Message-State: APuU4Z9mmCsSmuID7bUNJxNmOYv4gfM3+woPdokvSOe+hEXMaN22OlsN
	A1it1RaWsWZLfvxtO/DlrGWYfxEEXtzYg7LrMDJPYKoDEFko6EiO/AH3ciqw9QB34idnEBZBsOO
	E2FRlmnEzGgg0YhV9yRSzrfZqaTwSGJc=
X-Gm-Gg: AYBFou3xj1lD+TuF4s0FsdI+KN5XB3Q0dXM59HZsWJuwUka2yqsbAFJm4cAgmEc4DG1
	lmwUAps+WNbHzFJpsGiHeOhKPJNucJEu24jH06sO6jKwiieoJF9k8RPVurTviUz+OmWMaoAgfdU
	Y6yNDtUtJVnasyrhXMFiIf8T25UXBY5GFktV0n0faOR7jiAjvouApihvjXv/r9VUZ1Ivyfxj8c4
	036YkLgUytPR4x9EaWNJ9u8vsimhfmZUehmtUwynOZAU3L/NGqXXUSJh7LOedjDpqzwka0HHrcq
	13somPhYMHkDc4c7V79VeF1CLIfBZdxhKwnnsnBenE/5a733c68BsNTwpBUlfY3pX4eKFGPu20S
	esYOmEr3G/kdUh2LQ8Ni1dp0FWnaPKyyP9E66VW0mQMu/Uk/EzCm1VQm/+vIMt0TxtF1vw6mOT9
	EtxN8UbjYY051KsHHBz2Om/CcBjfPPvtLuTOPK8e4YnPWn551pP4Kjk7MCHQ==
X-Received: by 2002:a05:690e:b84:b0:679:5ae6:b290 with SMTP id
 956f58d0204a3-67c140783f3mr1765590d50.3.1793994588879; Fri, 06 Nov 2026
 11:49:48 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-6-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-6-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:49:37 -0500
X-Gm-Features: AclHuK_FF9pYZ822rko_gmA-vF4s5xXZdn44a9OEZBz6349ESGi33bXsA19jSr8
Message-ID: <CAEjxPJ54-Qa8Hnpp_yJXVUZE9HubpLs88bdNmzBi1T6kt4GxvQ@mail.gmail.com>
Subject: Re: [PATCH 07/16] libsepol/cil: reject over-long ibendportcon device names
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The binary policy format limits an InfiniBand device name to
> IB_DEVICE_NAME_MAX - 1 (63) bytes; checkpolicy refuses longer names and
> policydb_read() refuses to load them. secilc accepts any length and
> writes a policy that neither libsepol nor the kernel will read back:
>
>     (ibendportcon <64-byte name> 1 (USER ROLE TYPE ((SENS) (SENS))))
>
> compiles, after which "checkpolicy -M -b" fails on the output.
>
> Apply the same length limit when building the AST.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
