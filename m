Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA302264C0
	for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551189; cv=pass; b=tneDHaOxfcPFsmN0szsr2HfY/UqsrLT7ljfB7JuY8Rx+UMry+BqNKt7eoJ7NPBv2shr0Qh3huuWn8jr4PiBVYW5ghUcWKR9hEIeIqYULoUP/exTXksJYLIubCYeY9UGE5NxkOdOyRLqh50txvJeYhV2Kln+qwxlA5iZmoVWDO5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551189; c=relaxed/simple;
	bh=iEljPudkY64iSiYqxMk96XjA0vobla4RgCkNZJQ8tPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl0ps+SH/AoXGGgeTEtimAFMgn9jePAz60uwjdED9pW9iUv+340dSIeOUz/VYS282+/sTJNGvF2a6c3wRMgvP7EUMCAgKfQ3eucF3hYWAuJ5zTe/HWD0i4/uLcfo46gzfOF07Y5JDRm3+hgUNqTS//HLIU4NEnxWp67J0xpF9qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JMTs7/Kd; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JMTs7/Kd"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so183187a91.1
        for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 13:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769551187; cv=none;
        d=google.com; s=arc-20240605;
        b=adVxk445K0TjoeSDlsyT/MEZ/P+JQQED9gGJzHPDV+pWarwEoGVyhbc0GYZktlOB01
         EWOMNIrR9jm3YJEYwmkh492qQQ3ebJwAqdW6Yg9fiwjFYcjSKKR07ys+v8rgP53L67nq
         1m7Thc6338Osch2KZd0TTjoHQ6aQYbcGji43ZlfafovuxlWd3+zVSDyFGpaunmisQAN7
         tZ5iggk3z3LlCzUi6YHrOWIUyjdNPG7mwHd19YCHQIHIOneWCIVZg7BWZCm/GqMHeFv4
         CvRf/ep4oSaUi2nTcfiQu/dRooI84wr8Ck+Ak0q8mHXF4RMpu2zZLLJHu175KaRo+oSK
         O9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ten/eO1oep9IThmAZR2NG/u5boCnCD9ELrI44ZU2xuc=;
        fh=h5DwtxXI7e8O/Jsf7s5o7YDLEbe3hcXhw9S8zvuvMeY=;
        b=V2dAmv2XsuJPDWcxCd9Elxjh5+3wmk+6RfkoesEa4In+s+ICbzsO6eoWZzo/O34tfi
         AWEZG913nfCcQviAtGgbiRDP5x57A2jhC0D2syNAF7/pGGzKEB9N4AY1eA2XIDQB9VUN
         402K83TWIgV7daoODi11stedOzGFNgOV8bUFLDRDekUtBmxGWOPoe6XwYkI7o9X2pJ/5
         ettgqUmM2KqjucXqX0tj8rii+sDJyYVJ2frIvy4uUsEBQFLNu01KYvTaoOuhk7Qu/v1A
         LGFz0ieQlxc2P2wDN5Xcynvee44NjmfDGEcPojxtclE27pEFI86R6FKG/tac39uCDexd
         qzCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769551187; x=1770155987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ten/eO1oep9IThmAZR2NG/u5boCnCD9ELrI44ZU2xuc=;
        b=JMTs7/KdKcxdrGHC9AxwSrl7pGUSUk9jwHQczSqgkGpi/CHtAKQxw4q5cLAwykh/fG
         skVxRkLh677s9HCG1jzpiaLsQc5WcGD2+l8JC1inqX68k3eVANi6eqXRYDWNkZoJKfzq
         KcsQqyxJ16yDe5Gmkl7NKPQahYfiTZ4lnS+8/t4bd1tBseOmH8KfgE9sYNy6mcUw0786
         w9TP3+ayqGx+MNkNLyDBcq7yU+4YwjZcxs8np53XFiWYGdyy6tKvV+RcfLITdfstnW1j
         X8X1vjbPpaPdotfnbJwVqUpqudgH0prRNnFonLR845mTgTvD9b0H7wTIhmNoZwMoWuSD
         NfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769551187; x=1770155987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ten/eO1oep9IThmAZR2NG/u5boCnCD9ELrI44ZU2xuc=;
        b=wXHKk86ovrgj49udSMEeyGbuPUtBuhvz1Jap6z8JPZgaNTt+0ILXZK+J94GfN8zrzJ
         OGnCR7ZPjFdAVr287NitBmXGP6FOmmaIaH0cjAczxM+qroC3HKXonrqxua9CRItwohQu
         xtTcnCQFF4dxgFZX3zfhXDiiXx3yIjHnQr7BNeLr5z2GYzUgYQdiXnTwc8+fPXT1+Z+v
         ZJFPsflNKwfwRZBMIqNz8/m+UXGkkHO1tYI2pdftvOIkDHTgMXgxc0FiCswUaVv7Jh+M
         MEjm3YMJET5VxPkTymxs1++yuSbmRcrmaUoKjPHP7lXWR4FtuKvYpATpiggILZ0O55A1
         u23Q==
X-Gm-Message-State: AOJu0YyTC9lN4CgHfG2wF+aZ2jIUY6RYyjZ80GXYiE+Zg5ZXTQevdhYx
	AmUL+OwowwqBafUH1DxHfRAkKJjt4kPv0m7s1j1E60BaDanaiRKLRc+s7RrzX6GWaqd2FviiIhZ
	JskoEKT3rpdOi2j2ePfcKdZsYCBjtbtY0rMI7mO+R
X-Gm-Gg: AZuq6aKMd2bdcPx06WwhJA+hceFtnYKCeByE8UNIpYT0QHEM5TO47EK7ZM09kBdOdLj
	URsgEtdjfRmqPZsYmbDDH/u7K+8zF86yiN0L3dKz121oUL7lNizy6UEA25VrYj6FqNuI6aZH03T
	sAQO8uToygd2mYxvwicPUQWan8CZ1E68ztmOYg1VrQn45eItzfrysP6AR1BQXKCaVKxH/bXE34R
	ZJusokR+Ig6x+Bpc1N/D8nix7XDpO8du6iNXgjGxiJAYtS59Qef07ilFNNksvdOglljlyuI5xwb
	dmCiaA==
X-Received: by 2002:a17:90b:3c4f:b0:34a:a16d:77c3 with SMTP id
 98e67ed59e1d1-353ffa2e81bmr2407723a91.2.1769551187312; Tue, 27 Jan 2026
 13:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com> <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
In-Reply-To: <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Jan 2026 16:59:35 -0500
X-Gm-Features: AZwV_QjHjF_BvN3T07RPQg-eLzyv77ege_ZVuB2hfBf8S1skY3WEi6mlROEWEsI
Message-ID: <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: SELinux <selinux@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 10:51=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/01/27 7:33, Paul Moore wrote:
> > On Fri, Jan 23, 2026 at 5:13=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> Since xfrm_dev_{state,policy}_flush() are called from only NETDEV_DOWN=
 and
> >> NETDEV_UNREGISTER events, making xfrm_dev_{state,policy}_flush() no-op=
 by
> >> returning an error value from xfrm_dev_{state,policy}_flush_secctx_che=
ck()
> >> is pointless. Especially, if xfrm_dev_{state,policy}_flush_secctx_chec=
k()
> >> returned an error value upon NETDEV_UNREGISTER event, the system will =
hung
> >> up with
> >>
> >>   unregister_netdevice: waiting for $dev to become free. Usage count =
=3D $count
> >>
> >> message because the reference to $dev acquired by
> >> xfrm_dev_{state,policy}_add() cannot be released.
> >>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> ---
> >>  net/xfrm/xfrm_policy.c | 35 -----------------------------------
> >>  net/xfrm/xfrm_state.c  | 33 ---------------------------------
> >>  2 files changed, 68 deletions(-)
> >
> > I didn't make it very far into reviewing this patch, because it looks
> > like xfrm_dev_state_flush() is called by the bonding driver's
> > notification handler, and I don't see that reflected in this patch?
>
> xfrm_dev_{state,policy}_flush() are called from only ...

My apologies, I was looking at the patch too quickly and shortened
xfrm_dev_state_flush_secctx_check() into xfrm_dev_state_flush() when
looking at the callers.

> LSM hook for checking whether to allow deleting a file in tmpfs which is =
still mounted
> makes sense, LSM hook for checking whether to allow starting unmount of t=
mpfs makes sense,
> but LSM hook for checking whether to allow releasing memory in tmpfs whil=
e unmount operation
> is already in progress causes nothing but a resource leak / denial-of-ser=
vice kernel bug.
>
> What xfrm_dev_{state,policy}_flush_secctx_check() are causing is somethin=
g like
> "LSM policy is refusing release of memory used by a file in tmpfs which i=
s already under
> unmount operation".
> xfrm_dev_{state,policy}_flush_secctx_check() are too late to make LSM pol=
icy decision.
> A must-not-fail operation has already started before LSM hooks are called=
.

It sounds like we either need to confirm that
security_xfrm_{policy,state}_delete() is already present in all code
paths that result in SPD/SAD deletions (in a place that can safely
fail and return an error), or we need to place
xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
safely fail.  The patch doesn't relocate
xfrm_dev_{policy,state}_flush_secctx_check() and I don't really see
any mention about security_xfrm_{policy,state}_delete() in the patch
or description; have you verified that the LSM xfrm hooks are still
being called to authorize the removals?

--=20
paul-moore.com
