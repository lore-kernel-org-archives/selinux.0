Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241415;
	b=MFVZruIQAlUmGRvi14NMS3gdCLU1zJCQV9LkwHPU4N1iEy+2d/La7Zx3JQextzACKTcZ
	 aOMu1fUWr6jCHzMSctXLZtPiRRBrKzuWc59x/xIiNcTJ3dJt60o/JtJQtRG5Osw66bz/W
	 YhuB+x73DB5nOgaUDJryZMAIW540rmMuLqVqvRa7GHkNLcRpQKPzV/PJB1ghGo84iDCe8
	 Dy8V5XE9iXHYlNhf7YPuLZaMX/2uPk88CsjDKdLvUxJaUQDoKuHIYZ7yJqv7K573xDVI8
	 fmCZS0hkoI0sf22JpUdPVjFZLGgmi+CaZ1/DkUDN629lqy4kaysYuPuYhB9Z8Ux78Og==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LrFf43B4pGIBlZfw4JJGfhrMSDmRHExCPStqN2kS1LY=;
	b=bBfbJXmElLxYWR4HMOOnrQshyvSXHU+15jl6N8eQgTabtD1MCfJ4tD6UNpEJ0ASRFDbU
	 l8Z675qjzi+p0Z18waS203LMUA5Zcq7VLebqzHw/x+Q/jR6qlnCFY87ia28rTz+sFY87g
	 T962vXpVb+42QgZY4tBhILYWZMe+Glg3TIo7e2yNfgKkWQDUacWjhi4jFjPK7GgQqNkPB
	 CqBR9X2u+tQRspa6onlCEUO+Uyz3JkONYYNfNLr3oBwS8oLmTNjlMZXC8Kc7omwFX6sfh
	 qV6dBDg41vFQNnyk93+81ONIsBTLZNcXZx1imSX1INq+KCWJg4sWHnzBdD2niheixmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgS8MdJV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD979606A330
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD979606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgS8MdJV
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b315dd057bso7170177b3.1
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 08:23:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241414; cv=none;
        d=google.com; s=arc-20260327;
        b=YbiJafhjLO7c2akGXfABJyHrmNwQOfB6IpjBnYt9UutctqAkIzTHMqbtjPvBhhpBU1
         EsLGe1UnAVB6oBugyvrgtmRjoXAljcsRAaE/QMx4ShJJdsmW6AcCktMJPGztMGB/klFh
         hJc/SMly4wY1u1a+2BkybglPlM+rXBkDw+7L6nYmtH3Zxa25TjX+AxTm8naIJqLXe1W8
         NXQy8yPdaoynOyrpLpMKulHteIKWuW6CTKZeoo5o/WYjJY2n7AOkl+1KMFcYguZnup9P
         1pj2edAAOkXiVvDUAj1LjkTEUUZsjmhe+iVQNDkdbMT4TUBZeNj9mvx7tCYbFRNIVh0t
         C4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LrFf43B4pGIBlZfw4JJGfhrMSDmRHExCPStqN2kS1LY=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=IApC3A2BHmtueDrkzkMNU2XhlLgLhvBQ6YFPdQVjq4lw9FiLs0sJgKv8owUpB2WJgr
         PN/+h1tHvAUejup03PIl0ZUfRC50YX5rOePrY2ZWw7oAjNL+gsrLGOSy/303TV/yJB8V
         UQoYKiKe2J3QhD9FtqtpItkCNsF+3ouY0SvDKLIVmtweAzakeqDEHSndFkvWJPHpSB4/
         MXE0Tv/L9JaHHUQwMGFEftiJDggpBF99LEe8qyR5bhPmS8o7ah7k33aEDwNnAYx9btxi
         hL+n6QfUoVS/m6b/v1UAg53ZVs3AD8iYWuggWvza7tvIe6Lxx9pEP3WF7PTyNBX+e0Fu
         z2JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241414; x=1794846214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LrFf43B4pGIBlZfw4JJGfhrMSDmRHExCPStqN2kS1LY=;
        b=QgS8MdJVA0D7UJjSNf2zmZD8Bgpb9yHbdmMIcNweFizBJMcsMlo9V1HKStqpDb/RI6
         cp01c4cTy4hmwBACtoHa05y1CRYuTMDf2IpMkKFoRcLoicvrjRqyQx5cCK/lkC0CBftw
         jvebdCNL5s2JApAO7rKIncbHJgwWAqNJdlEXsSFtvqs/hiA0LA/jxQ6aP0QcNEZwChRJ
         0VYyDIvv8tIGe9wPKfQWZT8cP/gE4D5nUBSOlACDvOmO/VnygKQbrsgp3ZIVNxvS4wzY
         TwWWtNYdRg6+Ucm45MHZZu7zE+t6+YohpdVWUpjSQZ3KM63D8rPwlH5aqwLRGYparv+I
         Agxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241414; x=1794846214;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LrFf43B4pGIBlZfw4JJGfhrMSDmRHExCPStqN2kS1LY=;
        b=iE09f2INEP3wBFDf0vG9dkGn/qVDoZIxAAKWQ9Bi/brcyEYqQ+VeketR5Y0NjIpgdg
         TL5Znoe0o4y1qklidndyhlEopNrKSs+yytBJ+Da1MtSbMuIScRi/YhDiulVsDqW8Xn/a
         P8HMnsAd+BdmHuWfuJRIYnsDMYUBqPNwZF/Ty5qon7hvw4t8nNQPSY9yFq9idJRi0R67
         NuAIIw4cIilIiG4wpHV4j5L8zFRn9ChF9NAV7nGmavhIzx/epEMusWhWJkwzKfM1jst5
         N1KddM1u8Lp+K0Pl8UPOyqRYsKb9x2eKLcNsAE05l59HDTuKQny6UKQVCFmTjyyW2S99
         SxSg==
X-Gm-Message-State: APuU4Z/DsUb/61Uj40ogjiR/60cxbfEjYxJ/F7xRXwtdHgJ/Hc2F4aS1
	zMKIiM2wRbkyUbPG6yzO5SePFJPH4AdJCepvC2lT4hUMgGVdE70CJTqE3gqPx7VgKzqkmgTdh2w
	2rHcsad38NhbacMIb7wP10gULpm2acuZ0DKi7
X-Gm-Gg: AYBFou16sF1OKqoPAAP9L2wrdr+VKSlJVVicNZ5Tl3aSD8ZNFzVhiX7kyP9/yaXozMG
	3ANiefxWvFYnpyWWXF1J9Fa132TMWLXOQHS1yWzPWQzhSU+lxZG3mFETwKogGPD4o+xkF8mQg6O
	IkwsBbqTSUU2oEqXFG5Q9cE/yzCBptq+5NyHlhjv+fz4c0nmS/8Fshe53rtzLQ6DQd1bRXOrLfA
	WwP7ar0dmRD4dsxIhSBeHfgoC9XG2DcNrGtW/k785fTQXVD/jq7NdkcLNuK59wDQXkySyPSYz6E
	waVAY5t6BEnDYPvBseHHOd/YTSmUX9WQJxcLv5OOzkxTYWA3VPpk+r0Kv0U1FG2O2OLjP1S2tmY
	YC1v1zO9BI4zyCjzPT9ZObyYBZSYD6QUp6fuQCq2i+dmD6F1PdwjqKzbKNy1aCohnZLB+CP6o0n
	++vMYg9FpdQPbfsFXS40zALnb7UL3P2jN4Ve+7mREd5zmE/iqpbqBJIbDaIQ==
X-Received: by 2002:a05:690e:21c9:b0:675:7068:46e8 with SMTP id
 956f58d0204a3-67c568da1f2mr35267d50.95.1794241413842; Mon, 09 Nov 2026
 08:23:33 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106135150.377761-1-cgoettsche@seltendoof.de>
 <20261106135150.377761-2-cgoettsche@seltendoof.de> <CAEjxPJ4W72BqFzd=8dN+3DoRTM3kGLD0w=zjzOd36HrkU13dog@mail.gmail.com>
In-Reply-To: <CAEjxPJ4W72BqFzd=8dN+3DoRTM3kGLD0w=zjzOd36HrkU13dog@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 11:23:21 -0500
X-Gm-Features: AclHuK9zYscdKd2tCjPtZJjLx4WNiEkfddulimhvc-pqXHqzwZ1QnT_kL9NG9nA
Message-ID: <CAEjxPJ4-0dzzq7vzUAs5H-fRxdOpY6piJgvUBjWCEVrgs=QTRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: link the Python bindings with -fPIC
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 3:19=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Nov 6, 2026 at 8:57=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Pass -fPIC explicitly through CFLAGS when building the Python wheel.
> > Setuptools supplies -fPIC for compilation, but does not automatically
> > include it in the extension link commands. LTO can generate code at
> > link time, so these commands need -fPIC as well.
> >
> > Match the existing libselinux.so and Ruby binding link rules.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.
