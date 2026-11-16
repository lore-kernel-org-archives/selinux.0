Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794862921;
	b=5TD2PB5IfZL0u8iEsNN2vaIulshCQa0+jltqn+VbEWthUbBHZaFkDpL6AHWXMU554IDO
	 vAYOSQwDIZnY6hCxC4rXn+qqHUWDAZEdWRHF4S3vxJe+85HzDm+7H11muMOtRBDXwvVxY
	 fG+tmuu3zIm4ICw1krdPkYjYSDna0pZ2m2RzFVbxxNdnF6uNd89f0kZ5addx6RrdS2CE9
	 gUl1LI5ev0NgyVep/N4/T5OfQ/fq0vOreH2U3aJPao7rZG8jS87Frlba/xTanUfeMZFjY
	 u3kgvOn95LugylsGZY37EJniMyrUf5CL++NlR+zsaNibezYUhpMQqdL8ngv/2HXQFZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=lBA55Cz+3/ELC1cl3RV0Ibrv0K7M4kE8hD/GxYm9N3Q=;
	b=fRbplzP1N5+RDC5X0eHBmcWtwcBm3IKg1/DDZJTVa//nWhU3gQfFCQBgmrT/GhRbSJEE
	 AnOW8zLrmqdP14XbW0IeMu5GY7J8LK8KZmcyQkpbK60iP95BSQJ9EptyaUCdJYGsPT55w
	 PASpHij27nJI8sP8pmRi237P7WLE674tJLc+hzj9peYBfrpiUEnRV9yfcAcRnFG1GN/dV
	 9U5Ekny+0nIxy4Wt3XpY229Jw90Cyg6psGKNNqJFtM7y+hxvxqFSk1IXFO8MFtUZM4ojp
	 FIWxE4HQ1spRvApKX2O3WAm4eatd4/BPkycgoeSwf/PKIGZvmYxDgWvZPbsmusOUnIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Nm/0ho+7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DDA606A329
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 21:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3DDA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nm/0ho+7
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67daffde88dso846253d50.2
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 13:02:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794862920; cv=none;
        d=google.com; s=arc-20260327;
        b=bKMRtOC6cJHfTeZfgULaBPWHfirsHXOKpBzCcp6pQQMnPLT+xOozw9hvwy1M1V7l1E
         by1VL3Qe3yj4kUbDP1xYzLjlrVcmHsUR/Z2jipnKmI9ok2YvgXiabBxRchCdQmgV3KCq
         GfkqGT9Vw3KQokfRqHD1Fshmh4Fm9vp5MqfLVv5EUnNVrsgSEITyHp5oSi4qYb+zwlpd
         GOTtx/+ghT+yvMUQTGbS+guj31vv7OqgQnx8X9ojJ4PTXj/Lv9s+2rdVTadaBppy93k1
         7yh1nch7x1aFHECsX7SD6agEzTdwuUtKwvvRa5OPWYmkeE9kdox690rC2h3Ms495YPnA
         71WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lBA55Cz+3/ELC1cl3RV0Ibrv0K7M4kE8hD/GxYm9N3Q=;
        fh=QFKa48eN4AZKFIyrSiZk3FCE4nUKAEfyzhRYxfFXB60=;
        b=Rkv5kLp1ttnr0xZXAt5Fx5MlaRB3JTIRCAD+i5kDv+ht8JunfoJP6UfDraxFIkPtP8
         C89QBCeJ7YBJ8uxEWIrQhTLS6Pp9WP5FvsY6ASDO3Izzv1D7UseThh7IJfMNzfAXvbad
         F19b/Te6/cBzmZxq2kw0hk1KqFXCBWfxjIg9eLRK+nhtYY362kUXX41X1om8jKFwkDO4
         zckyMEAPw9VzaW09HVXGf8B71/ZqeXmm2aKJ+Uh7o8WEAKZ6yAiMAATf2wpMmvcpw0qP
         AN0eW2P5FDJFXSjwz9If+s1cYV0Kah9fM1ZEgveCbdUfA5sKCpx49jVoEBEiouQVZIUP
         8TWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862920; x=1795467720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBA55Cz+3/ELC1cl3RV0Ibrv0K7M4kE8hD/GxYm9N3Q=;
        b=Nm/0ho+79mBpScJmaYwhhcsdXxmEcju48A0nqFKgjLLIwED/YLwgkquk+gXabA913L
         WSYRuC7Xs4P/5nt1xK+7y+AAbzd42FrZzYVE7qepVaSNs12T9ZnsZhB3uXj/Cp8KDl+B
         M8hbCMGKKtyjUlam5rvnX1rvEC6KcrQ84GJPmLRqE2O1D0CBjjNy3OqZrKYZWR/NiO93
         imIy3ECsZBpQr25iu67ZiiDYV1tzF387bAxiiJCJvjpiy18Sq/LTlASyR2c4J+pBjVD3
         gJUj/uw1kV8xeRiGYqSw0mOZyYyPRKQ54p06EbUn5pznXf/0CsqYtMX+oaMqYYp/upri
         2r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862920; x=1795467720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBA55Cz+3/ELC1cl3RV0Ibrv0K7M4kE8hD/GxYm9N3Q=;
        b=FUzYwDmNmaP3nOxxfhqz5LbpXRARJPmCFrw5tvz5NXg1N8SRkBJwUn8vlxALe2Sw86
         5loLiAci+RWhLPH4kShmovP2wD2gKgpaWDjR+aYG8MBm9x/wXeO3iQpIyjlQksREo2hA
         B3DsrQSNkQFOQZjl3flDzXjNzPhhDgVCX0ILN1lBK8xKbZQDN/Y1CYfHRcTHoufnTIno
         B4PbyvRLsBcbQgMQBTq6tRd7+idyba6lIEeVzFH6yHWMrxbUA4jPugRAxZXrvfV8szBV
         6RyiPD0f8cBO9tvaqk3fl63OtA3y60opuTVD+jL9QO23yTqgvBknoaHseLSeoVBp8oHS
         6gog==
X-Gm-Message-State: APuU4Z8cnDlbLqereeU39SVbBE9HVA5zNzmxfCbO/OKPZTWnkhKtml7d
	rCX+T6KG31JBYMEOpbYSdyuSu7l/06WBZrzsSKeWeVYmzfSGmKSSuumwvMZkBR15LdCd3rh8yKD
	miPrP+NZVadq+SIHxRwyEvAlC2KEymm1gKKmR
X-Gm-Gg: AZFdTZcpJYvI8ztB2vdfAM7EnTvujAwf2P0Tad7s3utYfLC1ZvVYSHQbBsG43RHaaBr
	tNQsn1YjuE0Ii5OVFDtcQMYZq+5/O1Nb4WA1/Zt+pTL33vzziAet+mfejA5CToRMl+st3RfVgKC
	mAYM42ZD8Jl0Jk2jMYYLjwfvB4jjbA3OW+dgE05BzzUtJ98gRR85OXa76TaXOLUVP1YLDBfxKfr
	/vw8ZR1tk9zJ+UXmn3wvijkBRtXVYs8aiDQK5pwl3vcodzDjtMdrFjkUho7gb2GenD3fgu7B9OF
	CZ1t6nUVWoT6ptUSx12VPwbijyrK7JejXfUcua80YQm9HOES+fc5E2y/Me5DM4df+bU+R/zRoOw
	o5d3xoPz8Hd+GiubIEF1l7S/4W9OrO972X2Qo33wXPoso7nseNREbN7ohZ4UODOXmJYdYfey1nm
	5qQT+CvDOju9xL6pv22suT8e5Rj+XfSZZT0ZIXQ9bnx4+x65b1NoPuK058jA==
X-Received: by 2002:a05:690e:1306:b0:67c:a0c:a09 with SMTP id
 956f58d0204a3-67d89372ef8mr4866223d50.17.1794862919731; Mon, 16 Nov 2026
 13:01:59 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116152814.137764-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261116152814.137764-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 16 Nov 2026 16:01:49 -0500
X-Gm-Features: AclHuK_iFiCPVFdDYZNdj9arQw-0zGtemn2uNy3c3zwB46BKO4bd_Yx9fTbONhM
Message-ID: <CAEjxPJ6WbHheYZwwZTtE1JiukN7mGNQy94J6YastiiZG-_soXg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: require a pathname in Python policy_open
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 10:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Python open() accepts an integer descriptor and then ignores the
> opener.  This lets policy_open() adopt and close a caller-owned
> descriptor and bypasses the read-only policy configuration file
> lookup.
>
> Normalize the argument with os.fspath() before passing it to open().
> Test both an integer descriptor and a path-like object that also has
> an integer representation.
>
> Fixes: 98c2eb900519 ("libselinux: let Python own policy_open descriptor c=
leanup")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
