Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB252BE5C
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072899; cv=pass; b=Qr0chc1mwmfFUrJ0iA9G6e+1IXt/72zaVIdIWDjHk8kLQL68wWcFZtqqnsyZ63KH4Mb8eCX+xdLQGgkxVGFH4i3g0tAZBS0quzafcuucyUK3KZ6WhyyHiFRM06u4FrJ577kw8tz1YMjhwfEZDrH+XLNyDNRx7ZPy/hArKeHAhsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072899; c=relaxed/simple;
	bh=4ZfpOmKAtykOc+d/fnv85GlpzyGWVNRtTunIrunGqws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDaIznayrackuenYy64mN0AqoTTgosH05W/D4YnqjCbNZ3O3aUgsy+V97WgRImaSBbkI1v54LVRKzedzMoFZntJR58YdJh2mOscXh95h1Q7grnNbBgQwlzRJDlgEYpcQUW2M8z82PgZZAuM8ZvPbPcaeiDheihKM3bjgwPBtzgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA4wLEfo; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA4wLEfo"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67921b515a7so5356342d50.2
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792072897; cv=none;
        d=google.com; s=arc-20260327;
        b=E0o1QoRVFQ0bzfY7sCfqXJxvXJVGKNIBADNj1uCXzw01Y4dfz6NrTZkCqJ8wqyc9VF
         oTuAtxh0eSBxx/RU/oRf3rSxuGHciiH0FOWAlZKUmFIn1urqz6KftGXHcC9GZSp7g1wf
         Pz6khUX1a9+y/XGOIhdSVzj8aizQFU1lgyl0vPlwW0YrAh+PLVBJ8HaQxqyhrziBWxAK
         kDFjxhacpt4hfPvEtFNjhxJCipdw8YRWfQ7hu+vUQtI12g5HOk+/7NE6vFcXc1JUJue/
         ksg+NTaadV30SgpiBWlHrswg74yaOQHPF33ZTT2tSsOAu+6fl8p3GUeb8wL8QMwrXZLX
         u4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4ZfpOmKAtykOc+d/fnv85GlpzyGWVNRtTunIrunGqws=;
        fh=wcyU6aOJQoBdwM7xO0e/zdCL44PS19EXwxnL/XIYXqU=;
        b=KttCQRQEVrMbdOicXu7yU+2k3xvB8dGz1bgFgQXooUWs+VvJn1DDVDInTNZCq8qGpv
         fKIi0P/mNxfdSLj6tQSAy40Eq9Gym2Ab0pDZctrBXrZ3BN8rEdiVlDIt9PONBaGXSPId
         zcSKzphJ6pHLfOcBi7LxN/qVfU3gLDudlZXdE4akY4w2N7mNeEGf5fjo4PIqyZ2RCADu
         7WbARWALT1wVoY+P2S+6XGwbxaK3D5JiYaGR3S8Jp79AfQUSlZ0hIakVuSTmQIjM9cs+
         5ZjkXmZruPzeUUZgL2SFpfJIakLtGrvvQiod6vbzH+M3tg6Fv3Wfo9qrciXGubuOzCTL
         Yu+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792072897; x=1792677697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ZfpOmKAtykOc+d/fnv85GlpzyGWVNRtTunIrunGqws=;
        b=WA4wLEfoyG6rh6TsfXqJoAzg5Ua2VAnQSYdURZ4DMSOIedZeW+A0C5YNEEmg2+HONH
         gKSS5WG1Wy/5fuKYnTItz1gaNfpZrN3yjVv1ELiSNZgM4M2yj4xZIKcmeIWiLXMe7vRI
         HIpzkzYu2yM1QTyd8ZVf5cksBD7qLZ5OQS1TPY3ywt3peTHc3i872/VOkmQ2GYviddS8
         Gl4He+VcrJ1pAw/AjeBnrQ/A0v0eFN06QaT1JBnr3gkHvpgrNqVObjsvImK0dKhCx0zt
         YGHzXXy/JE5+mujZEkzQ8TdvsF2AK5nkHBdmXhw6MKPPMr9L4EoVR/vvuW1sWyuD8R7I
         TsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792072897; x=1792677697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZfpOmKAtykOc+d/fnv85GlpzyGWVNRtTunIrunGqws=;
        b=ND1YW89f/dmJ81ukhZZctd+THkx1Gmapb3X5a1jGUHWubgdv22F0Lvk4VAJiZjDl5H
         YIIZ62+XrBFb4tdykH4GfPt8SFPhKpy83wU5wEwd6Bg0l95Wd/KIKvmy/yDd8ndwxbfN
         Z7fnnl9bYcacF5eiMRqlUPeZ0NJO74azETSKauKWoI1fhv0BM7kTv6LJek2lKpgKYyV5
         ODy/D4Rlo8oKfy/AKAMokTijWL7TBUGbrAqzZMnGNcGwKNj6goDUZ9Fh8p33BEALZLWv
         7fBsj+a4uZjsZzH43cmVgES5TZLcN2KecnmrL8S33Nh1lu4Z6o2jgzO21CtPPvb+Vo2j
         eniA==
X-Forwarded-Encrypted: i=1; AKwUvBzYbbkN1CiEje/1yyhufxrJ+0XsDqOUhfcWSVRAJ1UUl7muQXh84zZ8FO9Pe503yGGNnLmehKuw@vger.kernel.org
X-Gm-Message-State: AFq9FYJERdzOGJUJepgjG5sI604o+US/u4dxwv/zu7TacSiB4hy84/uB
	EX5x0BuNznCXcvD5TpG9Lo6YVzmnQYBcUPTpUT1Z4jz1lltiPkRV0NELf2XxMLoSERSW/xyzpNW
	QzoNPAISa5QDhGieybwIqfBr5VIA5aJNY/Uu9
X-Gm-Gg: AYBFou29o/R3V/N/V9gy9DZF23Wp11DVb1DyjxpZTue5rROH3bWewn2m/OirfVZSJfW
	Q2hJaQ+TwoALwfZPzt0DjY4D7VKOfvh53eC37YuEC4ZLaGm9llZeUja/PbyW46PndSWHvzywB76
	JZvohrIMzvtGRHyTLtHFPI9BNuGQ/5Jh0NTR5bAYIyou9otb57hsGc2Q2LPBe6nvpjIvZAxO2ED
	Plf8D4qvTEx9P+EOKkHHJMQH3040BPGvnEU3sUA0mA9uhrBLxQcOsYvMfFdq78ahAPYkEse7ERW
	T6GBDOHOA5krchkwRVFHJZPXML8zMQKdOzin1adcdI5vRrHMigy/3XE=
X-Received: by 2002:a05:690e:134e:b0:677:db69:cc1a with SMTP id
 956f58d0204a3-67935ed6114mr7100720d50.7.1792072896630; Thu, 15 Oct 2026
 07:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014160741.222219-3-blum@kernel.org>
In-Reply-To: <20261014160741.222219-3-blum@kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:01:23 -0400
X-Gm-Features: AclHuK_I5_tvXYJ71ZFBH3sU-3OKO_yyAB0kwxjx4G7oBnqckAyxHHPbF4-yx68
Message-ID: <CAEjxPJ5tbPLOj17dwEDvzVNEJnEgMy7hGgFzEe8MYwzVxU1smA@mail.gmail.com>
Subject: Re: [PATCH] selinux: use isdigit() in selinux_genfs_get_sid()
To: Thorsten Blum <blum@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:10=E2=80=AFPM Thorsten Blum <blum@kernel.org> wr=
ote:
>
> Use isdigit() to replace the open-coded implementation.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>

I seem to recall seeing this same patch possibly from someone else but
regardless:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
