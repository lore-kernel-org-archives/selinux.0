Received: from mail-yx2-f29.google.com (mail-yx2-f29.google.com [74.125.224.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595693D47DA
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696231; cv=pass; b=PtOBhJeqJemw1plkZnr6+IHL6q3zP0fzkmEbXr4ZUStqyaniCGWEE5EQFhkl02e+vBt6w/5+QVU1GTzp2nLUGeS2GBUJU4Ttarz3esL4ANh7RB8g4M6jmh2QgSckY9OB/2E7yf6NpgOuZS/SoBm6DdxiB530PR78LxLjOjCZ6RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696231; c=relaxed/simple;
	bh=OXcJ09pfDPqC4XrJHROYRvifUecg4nnm4bqtIk/lTKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XD7iiGfiGhMrci1lEe0bAgivC4sB+TriZcL2vMa5dpgUWRxiM6R8NoP30qsiTR/kWw4Qj2Tj8VXJx0mH6UJAUK02uOUgtbF8sh7VAVXOVpGqHaKiGlJTzb8zr+wg16N88PjfL2Ry3d8ijV50CUZSQRTz2YuIR69PGAPBezvBDJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlQ1dqff; arc=pass smtp.client-ip=74.125.224.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlQ1dqff"
Received: by mail-yx2-f29.google.com with SMTP id 00721157ae682-8ab3fa8a788so10930967b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696229; cv=none;
        d=google.com; s=arc-20260327;
        b=haxXWc0ZihFEvXbNNsu33dzlXadWAdW+E8ktrFw4KC6P9/AHGAvkapiSOgm3+GLTl7
         Lrvdd5/+1tKpSUYLRezIIp4IpU+N/bzNH0brtiqNr1JACsBawynEDU0Cw+oLNSsWQRBr
         t8qOVzJWU6fcG6RNsBkrgX4otA2/0/dYH3Dh8XmUflO/JSM3ARm96C13BKZetVcWvJSM
         y++9N+dHXMBJ8ASvwvbaOkpRueO+HyAz1++I/8rtvUgh/XK6pnsVtw0eiCdMieXs8D1T
         esRJdlSaViLAZPB8PG2gVAg1j37xpbodYjkH5806lAGRKqukQiqKOrVAfqrrt6GYzdzz
         SAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OXcJ09pfDPqC4XrJHROYRvifUecg4nnm4bqtIk/lTKA=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=htx68ev3dI+SqW9ktG7xF9WbfPSSVE+7auH09HmF3b8ABZOLm5gusKR/gpIMJI//Hn
         0pjEPeWgyvNzTgMMB+VIUWYzYujCaHyMNKMEiCjbMnxrfhMj9hFcKDOeZuV6sQ5kwkT9
         3SeG1ZJQn8bdEnNTWpGG+PFY0dIKotggTtzw884Jkn2QiX3JbdezZ6ELdREh/ZR77g/y
         KWRK/twrdgSGnZsx6+0U/pPWaq0P2Cq1BwL2esOZZSOEWhLjQstbTw/koaZ53vADPIJQ
         6HoRIFvlruGtEj1QmSw++6bDF0/sMArpcJpXu4c95XcpIyXAi+5ZiYAzrcG+WdzgrPQV
         s6iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696229; x=1791301029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OXcJ09pfDPqC4XrJHROYRvifUecg4nnm4bqtIk/lTKA=;
        b=qlQ1dqffY3KcgbFv4sG05eyfBCKSyzV3XKTs0RACpV5T07X8g+tBYWcquGv4Ct/HL+
         ysYU2y4FNWd6CokrgBfJc5T7xoY5dZanap+o8GI0fJftNW3t8VQyJTFxCWfFzAvkD5KT
         veaWTes4iIbI0SWxbq0mXIbZC53qybu1XDTmqO0GqogsWJ1qw1uGgYF/bZz7uul4QSiV
         JV/ZiQw5vUoUuiP6A0MuV2KjIJXMWs5X1nn2bqbfJNskTKJmt/kTafI1QOiNmT/JYffy
         ve/8cEG0pjyTNzhvD2vqXdER6v7HZWXAXLG9jBSKPQgxbisTx7+asE2ivrVyM0DfEXVX
         hC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696229; x=1791301029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXcJ09pfDPqC4XrJHROYRvifUecg4nnm4bqtIk/lTKA=;
        b=OczTyRud1pkaSpbXO4T2JWYwzTQKtaFuE2UoczF8uU4hRtioP9otHRYTdDzcyy1jb+
         2cQSdi/XYJGwv7BOlXR7+NjoYgOEbf9NDu7pYxW0yCrTTcxz9tcZtB6ji2Uw3KQcW0Ea
         qhxZlCfFS1xzveP3USOKieeoo2W3mT+sBUdKMapc5IG7b5u+s0XoTs+g8sp0XWJa9A/v
         +XToHEJGAfwMSa9USuJ6yPPtom61WTzphNpX3JQqKVDQEIsgo9dsPmey2T0snr7exfoI
         qD7XYugu/WgicwGfEXM4MjP9bk7WmV80WnU+uM/b3w5ZdbdUPchTP8qmnNZeEQbbT9ue
         SoSA==
X-Gm-Message-State: AFq9FYJXgDmOHUZOWDJlqvcjjOVB3fKLU+8L+dvjF0YZmG+LKl11Hfrj
	qNJR1vcSLWjQZWnprDV1kuI2jsxFLwnd4aUr3KjrOl+zfo93hi0mVfw34v7f8BsktXesO1MusJU
	F5KOTSu3s6C4cwu2X9BVQJb+6+uqLBldsLxe9
X-Gm-Gg: AYBFou396+NRR+jcepBX8wZAMOvBI5CzMvOWC9mQxd9s3H/qiSauEM7giYZajumJqyY
	nDuPoje6+r3Lps5U+ofw1UzwpqUqxnB0CxIc1XqwEp8DxWE8LQRpn9G9UK8eVGfvExRTA15Bz85
	xqCCdelA9IhOhSRexsfrMY1w0TYzKeFR9MZNiwVUWPDD42ksp8mHurCvnMvh5FkSmGCnZJc5g8J
	1mdtLctSW2i7MdpM0dppT0C0YFf93twBN6Dmstw/kdrpesbKqfKA2/SqVIxMp9fvbjFJbjEzcFM
	587aIS1hX8abftPwPIoxkbYRThmZX4Nf8GnvI4s3CjRpWMvZjiUSSit0W4tn+m30mQ==
X-Received: by 2002:a05:690c:c605:b0:8a9:1b5d:40b7 with SMTP id
 00721157ae682-8a91b5d4f8emr28350987b3.105.1790696229369; Tue, 29 Sep 2026
 08:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-9-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-9-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:36:58 -0400
X-Gm-Features: AclHuK8u6KAXejn_R2TJ1VS2uv6M93ExmzwGB_K4FuZuyzcOxpeC6gFbzfH_u1o
Message-ID: <CAEjxPJ5h1WSyhGw3qOUSJXdbCD2j1S0acUU_ikQJ0fWOcUmtbg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/32] selinux: use struct_size() and isdigit()
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
> Use struct_size() for the size of the flexible xfrm security context
> struct, matching its allocation, and isdigit() instead of an open-coded
> range check.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
