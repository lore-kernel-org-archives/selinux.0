Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E64FDA72
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698244; cv=pass; b=SewHcJyg99SZabQ3UF8N5iaSvm75xAU1XGhIriczHxJTxHJzeVAHv2WFybD8ocFeeQvnYkvS5ej5UeQ1BZmWVeApIqObWuE1scMvu4UNk7Sl7HYF5DnOUZRidLiZMiZiM8HjC2TpEta38xrY9fVUSx8rxhjNHEXn+pSJZBKMzfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698244; c=relaxed/simple;
	bh=vcJoPQg5ahdgZLIujO7NvBPX0of5Q0dEGm4e8Irzhbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMoObrcldAIMLh5QV8DQTZpeLixyxZJrEdWCDhLnSR26jlgKcEcD+/XIxLW2x0OCniW7vM1bDOz9nfJ3T7wLnHhr2qXODKdEKp6woaULJN7MC0yr74lEhFZolfEPcx5U0c+feCTGSZLE/ps6An3mEzJYF95dRoywyH+/BWYfzxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAr8scUK; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAr8scUK"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8aa75b33a26so25170047b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790698242; cv=none;
        d=google.com; s=arc-20260327;
        b=gPQMbghGYNAZz1HWDmozmTGPWCI4gY12VcnXcm3mJPnP2c8HXnRnZWNiJQq4ZQwq39
         UQeuS/yjocY8jPVnUy8E6FN2nlnajkyGfma3B9Szcjq4ZxWFa2tkqJfTh7ufMGD6ROpt
         1uofBPblk1lIga8bDaGNgBwbVhhVzfA3xOuc+aMq/716Rj8qtM4HEIj7z8joNUdPvlKB
         Udevm+CI/iINkoBQKSfDOZWfD3xoRRaNd8Dw8QzbwliBfB5GDMXvTjjoS7zLQn1pzFCX
         AUPiIk21EBI+XY4WPIWFAV/vxTr0APoX7XdGAPdrCXCzcl8GR8YJUGqt14q2A3v16Hwy
         9enQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vcJoPQg5ahdgZLIujO7NvBPX0of5Q0dEGm4e8Irzhbk=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=nO0zWX2RuHg55lrcL3V35+O++rhnRIyLf7xPEqqFfrfLh0sXTIeNV/YvsMeirKbrnQ
         L9kvMcmzWFFIRX1WeJ82gVv/s2DEBhXuMC6iISMClmoprqPj0UhheAjbRQaOKsn5ypzJ
         kRDR09qM6qJg4WJJBm+/OqpozykP+SfDlVPWzB6kNUQDeQMMOG3Z1+F8KXr8gqBH1wOZ
         BZZilVIkxwqbgAmxa91mFav5zGaVuHjAgjBBi3J81nPUN/x9r/AkaYKEE/y29XH2yKQf
         cXbqyTQA2drqD3Xj4vJhZwSwyQds6EvbV1F39c6CnZDnSzaB96IbFfW39dtJUU7INhZE
         2W8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790698242; x=1791303042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vcJoPQg5ahdgZLIujO7NvBPX0of5Q0dEGm4e8Irzhbk=;
        b=nAr8scUK2kc9M9mMJj8xkwJhNBEii1N8UgSv6XE0PANLgjdcKfXkoz4lEWmWoiHY81
         JGuCEnBeiYIcEsn53MsHAKCJVm1lunzvlYAuYnJpCpOHGxhUyJm3sxWv0PL7N6Q22A1L
         6wsa/R1wDiwLX05J2my0oQzjftAB8OM/RZcwff403xEEgFbLg57erJK72WD5puMw5Sna
         tVPD7axb6dhAW4GyaYwrKYvksxkeqXB4Dr43coD4mZA369mPxVoUPfLfWI3eHY2f8HH2
         kECh9gKHr4gUZle+hMOWaHrmZ22cdlgcXZyke/XA9+JNzaQ4egcQaPrSn/x0rXQrBKv8
         j++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698242; x=1791303042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcJoPQg5ahdgZLIujO7NvBPX0of5Q0dEGm4e8Irzhbk=;
        b=e1gh9NSWRasWCeYtQgDPT/k/qmrgia9vpsaHBQKjAwQ+fBWsJ3XOFWJ2SNaALdU0ZJ
         8boTXq3jHh9v0MpQ/3+rj8XUhoGcFUya6MZHN41V3MCwp5yFv/HsPVxaFi4DSLb5WHkG
         qS9o4/0EsSuijLcZgMEe4IGZU8WvthMuxdCU9L6HIvL5iFkho8X+RoxB7h58EuzUcgdr
         Fyi4pZCHRqD/pAZ2lqkFJAsmzgZrMeNWhBQGT938ZjOJplTvbRlJMrzMTL7WrdKqUNGP
         f3coUrKR42UAK/BIpY2xZWFKKIQukZZUy0HT26dl8S0c/KM1fjpNonFXHHILXECRNf8N
         qh0Q==
X-Gm-Message-State: AFq9FYIXNlsuYm9stkIt73dGrU2Uuii23s/0gfNbpchSyVK7gsMOu4sn
	BxgUd9WRYndpXdRm0uckmqso2o/ZV4hy+x3QGo3SwhyQuniZABjcRJz/O0X9SAxVy+a3Ckc4wXe
	rz1j5oiYU12KaRPL9BrPUzz8E5o7d0PI=
X-Gm-Gg: AYBFou0lXhoE6B/6ikXTUEk9pWSl1pjosWGHKfLwBNPgpBvBzbv/0uk4bTrlBjWzr7d
	Bqf44X0ZxwWWLJqY0H6yxwKszcJww24z/PfkLFHsMhjLluYFXZwDIpZSclDMiwr1VRv0ONn7wCs
	9g3XW/TDXtuGCN7DRMFDEXIWpIkOpBvYGCBWsRrfss0meeQWng6kMpAv9KxqenSoXZvIxjaG0Cq
	y6VlQA0CHBkoUxuhT6b6TXeaLrhNNK5VIbfZJJj2tT2nkC1Y2RT7Q8hXYpWadx+7PpUgi2lxDQN
	f4c5cMHLq58LW0NVkPSkUvRIUYrjmYl00ZljOwdOT7gFZXkP5dAGdiNj
X-Received: by 2002:a05:690c:d88:b0:893:44af:ceaa with SMTP id
 00721157ae682-8a64860b119mr95160247b3.5.1790698242217; Tue, 29 Sep 2026
 09:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-30-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-30-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:10:31 -0400
X-Gm-Features: AclHuK_v0dmajPTSJ0jVoYPNGSqNMMjIb7LJkzNBtKUCNCMrL-4mlvWV0_JM6HE
Message-ID: <CAEjxPJ75AprhWOeuKYtQ5pUF+9Z5riozafFvBG4kSWaTgwHFCg@mail.gmail.com>
Subject: Re: [RFC PATCH 31/32] selinux: add policydb_class_datum() helper
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Five sites open-code the range check of a class value followed by the
> lookup in class_val_to_struct[]. Add a helper returning the class datum
> or NULL for an out of range value, and use it in
> context_struct_compute_av(), security_compute_validatetrans(),
> security_compute_sid(), mls_compute_sid() and string_to_av_perm().
>
> Each caller keeps its own handling of an invalid class. In
> security_compute_sid() the unconditional assignment makes the reset of
> cladatum on retry redundant.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

This also fixes context_struct_compute_av(),
security_compute_validatetrans(), and string_to_av_perm() for the case
where class_val_to_struct[value-1] =3D=3D NULL so it is more than just a
refactor.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
