Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793022265;
	b=r82B+3DaxB/o1Q/gJimCKlUjoINlUyaLCLVVI/XTpsaFJZ28wQP2QIFQg46SyEWEHSo4
	 k9OwIMdQdyfDR/qQTxrQsYF3xvcXKgxOv3uU9HxjkxsT3oQXX/TntobFTxJxWeJ+GAnAu
	 j30tYlUyx68eYtHgYqluZoXg5tc9Qd5Wmo//T9fqWWYMHEOyJDy8kbc6cZbVx481NlfHt
	 grG2JlRlIWwjVNf50BSDQ0odcl2uZQkWYgUugdF5KH5txsukbnNiuF6wthf7blrOSebk9
	 aYmdzarQkpFFF3JdPlHMTcw7s7rNJugrnomK4AQNlrYc1XtTiC6v5ABsw/pbxTS/iZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=eoXNVXkVKcXgkFeRS/JSQkVeloe8lYbrBLFwgmnAUxo=;
	b=NeIL2iEVcmzMubKVaymATOqFM+wqTshuBhXgQ1L2S+6kQdcQa//SEZNUWMntJiTFcBjl
	 KxWAlOpqZc8QaX+Indx3SddPjg4seHAkDZmcxFzXIi2MWAe+4+SqgpOUzeDqcclr3D1XG
	 RVXMdnXO/kyh9Ed9wWSRnMHrsVTaDbDOjI3cifk9jFMk4/eSb4VtrubVR1wKVo1Z9Gnft
	 oS9PUKI7MNEYXxblZF4es1F1f6WplsMAGuW4aVq2DmThN3NiRxMocpU/3urINur5laGN5
	 0JJt6eFw5vQrWf/AXXgzsOmcUSNLmU1Pg7DptFZD812JkHl+AhCV4nCaUqob2Tpwhkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LgC5+IJt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC0606A31B
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 13:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38CC0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LgC5+IJt
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-675676afc3cso3426594d50.3
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 06:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793022264; cv=none;
        d=google.com; s=arc-20260327;
        b=CtWVPkb1fSdbPR3+G8/v2JdW0ICn1GncMh/2XT2X4xmMXc5rgD4r2Ng7VwAt2xaFF7
         MMWpm8JFur62TRpTPYoheI3bmhdyV+jTIGI2+q7E/fQVkLLrg9wN/acfVSCqY42UUNYd
         RW8pba10D2FwcP9E1DSzqoGqUHpMMoZEZ9vtnBxZD4+vimJ4a1D/RU91W64TF2Ntp5nt
         a2hqQTk+unPcP84jOCQC8F5scMx+aGPPIKZD5TwU/g+0ojfIxuT1z3fpGvx7RRgyRUx0
         Q+UbEDiy+nR4o3N05uK0S3hfKLipFUbx/Wgm84pUPdLKkTCAQJnikt5eSK0ues5FfQde
         03AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eoXNVXkVKcXgkFeRS/JSQkVeloe8lYbrBLFwgmnAUxo=;
        fh=oY3YJwlQJe6qc1tfsT1YP2sL1SDhL9BUcCb87gGht54=;
        b=eAZm3e++3vh6hRx6o4j5UWxrdM/XAsOyQ3LzpQsKiMQG29NqAW0FP1cn7L6XvN2bJA
         dY9tcUaO77xmIzMEfixsVpeixyLtYYJ5pdpfX8mb8lHS4gilaJVoz7qesGA9Vh/O94p0
         x6U8QFTbNRfmt6mrZHj+PKRu4/BwENcLSaIx7JCV1SQ28y1c+qnXu9LAIZya6r/Zz9h0
         qgR9DwHP4aymu+LaREdtenRMJxCOLBz714x87OJV//Z/QP9BP2amte+Zmug+dREtwqR1
         X5z1JTPxbX84/x/6tl/hDGkgZm18KcuyXgONiudNTHbWUgGNUld28QNR3FeSyOrNlotN
         plmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022264; x=1793627064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eoXNVXkVKcXgkFeRS/JSQkVeloe8lYbrBLFwgmnAUxo=;
        b=LgC5+IJta0OKF+Uq/DVEN2nWm+tXZFIFYbPihm52jD4cY0YkJnsSDJCr27WBm4RVI0
         GvQ+iEcbX7dfp94p1rchzFH20RwUwa+Z3jQsYodqkGO63/HTnZGslY1E57r3ypemTvqp
         4/5iXSivLk92aZP4PfS0e6ogOqyyphR4R5CBWvx+uqXtacjlpnhkob4xXrX/SrRZQTKI
         zXDJYciTirJc7Pe+21MVh22B42Ucp5NCHb7Qkaoli02zdqzySltsk3gK7BaaOgN3e9U7
         OdA9d31/RWZ8qMSwtfoxRqU+PCqUvPLv/rWC2Xl+5udaq111MTQEofINkmbgjM56U1bV
         +80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022264; x=1793627064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eoXNVXkVKcXgkFeRS/JSQkVeloe8lYbrBLFwgmnAUxo=;
        b=2RfTRDGzn4qNr2iJEt7fWtrKZ3LnEYLAi/OWaHRCIrjxsfaccJBB1oo8g8QTqILTs5
         zw1Hr93iU3HGkBzukUDE4HNBBxr+5k16Xndv0bHpWurSMvRPO77imIXHRToLn8Z0UIbf
         wSXZwfhKwMdHLCfRM8yzRyPzn0wkuN35dqp3In1DaJMC12j4fewNKz18pTbNrdaXqP0H
         48MgqGXihI1NFIWM8FWX9eyRjhx2oiBysgupQEqfpEzuRCkHLImpNSCc7Uej+8Lq/hgh
         YPoR5/S1/Mv5ce2F6+5POMvjDZXG8ykhQfmzDtlaXvMKIgQFgJWQP/ovQGHsOs6ivjJ4
         aqtQ==
X-Gm-Message-State: AFq9FYIqu8kihz3zzJzpiR9oMMvVSUvfBS6IyTdarZ9sz6Ec3zgBtrBy
	yIsgQpE2PtMCBkFaqS3G5oPjzziJV+ZN2J3DO4cQy+ow6jQSU3+HHoRWkDFKnPbO7Cm89jGDTWo
	DN7VwpGegR9ZbpZnCjr9YcT16aTwyIM0Hwznyu1U=
X-Gm-Gg: AYBFou3uE7ft43ZJ0zYIrR625EG/FrIV+lX3vBqsODBbp0zMtLp8d1xG68penhwOmxF
	QIpVQFnK0xre5q0QEDmZeogdM1IeroEWnaoPXXe3YB+XAbK9u6EoQDXZRQutp90ek7aoLGcTFyS
	BZQ4WoNnm/q8xmdYax5yt4lxL1DxxqaQEXjsDh49Amgu2gQqrCWzhu37HrcR2f+S7iUJnmJETtB
	GtgurSSj1LdMyoHYHym0sHiwljNaFQaYKkaWwZ4vhTneI/m1U8wDfTTUIZ6jNKg4ktD5zWxC+Gc
	bTIWZrcSs6/as+AzhS1zGFVZqU4UsG5zRy3YGcVrZLGARwTotyTbbq1XPjZaPrLCGdhhVq/kVro
	Kcv/FmA6NW/p57gs/EJ3ocQXyWyO8pxmUGtBeQJK4F4cl1zeUfDlVD5ADkJuuAumf6YHfbiEq9J
	g2pMQ5y5rNBJUJgRFvYraiyA==
X-Received: by 2002:a05:690e:12ca:b0:677:adf6:7366 with SMTP id
 956f58d0204a3-67a4544ea61mr6128686d50.63.1793022264226; Mon, 26 Oct 2026
 06:44:24 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023190438.62456-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261023190438.62456-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Oct 2026 09:44:13 -0400
X-Gm-Features: AclHuK-0O_9e37r3nn9DsH2NWZFbBdYZ0fvGq7ehfuVuCm-N8m02sTu1zRvyweU
Message-ID: <CAEjxPJ7fBA=iE+EMCmyMGgggGGPtnu34eSh+QE=f-JQ=ND545w@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: clear the policy file pointer after reading
 a cache
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cathy.hu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 3:05=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> dbase_policydb_cache() frees its policy-file wrapper after successfully
> reading the policy, then queries the store serial. If that query fails,
> the error path frees the same wrapper again. Clear the pointer after
> the first free so later cleanup can safely handle a serial-read error.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
