Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC05377A8B
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623856; cv=pass; b=iBHEl68L3CZZwJLsfRyXn/+sOa4KIgDw/VrVQVFXsbMzzXp2HdcZ0MBBpvzwHEMhTnvM7gJGwMjz0ugdAOB56n7t8Q0TnVnkEQLWAaNUWOzfxl70eYqxo8zzbhik2qH9s/tf2A9yS9hrgoHPe2DVgShdDVgIqffAbKCzPyKEm6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623856; c=relaxed/simple;
	bh=cWD8I8h7f2Mn53Nrt9tP6IaEf3LtqBr0+P+yyQFgntI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqooucZDiEEaBG2Zk+GZLimkvwa3USVh6nmrU7fNU0MoSkMLjpPmj0g/AoTNEoeBo7OrTtmoHymANQtLaI82j2JQEexRp4Lua+49CsHoylGIRMhksWXF2NcpDp8pp9MpJ+3K80hv+OCnlA7Aq/XXXQIpOc6mWk0cctDxlKiXWZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvo1QHuO; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvo1QHuO"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8a8f3f7ff7cso25763817b3.3
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 12:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790623853; cv=none;
        d=google.com; s=arc-20260327;
        b=Os+czpYzDQ+ar33WrwGRFjLHIZGbEdzs063TvFD9Yq+w/7GMpImCfBJFeSgDm1MSxe
         6pcN/QukKKU1Se63DqKbolCpZlnvQosci96+dNC8yh0xMinSvqfGuC3Qk2llvS6gxkHK
         iGf9nYKZpznUvIhZ4TzXjU7KmSPCg0n4tYG4OjUU2FJ2WuQB/anYCO4J/GWyyrIESapr
         kCL37fwhhlD6mm7QXwUwjydFs/GbSBPP1gSvUoYV/i76YNjjnPd4nlqE008AbVht3aRK
         T2pubCTwPPeWX9SA6WFVDm342mYcpqclfcjzaJt4QCXAr0di/l1peQdaJe1Ufau6Q/td
         l35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWD8I8h7f2Mn53Nrt9tP6IaEf3LtqBr0+P+yyQFgntI=;
        fh=sYZahEULhEIRUqWBvHQMm51qlzhx/WS6Homio1aCbAE=;
        b=HwV7FwXoaiAQlnAQNQd2gZPvZRT7EE7cj3T+ahLc4C3OsstVju2+s30T2UnsV8vhBI
         utiXDYOAHwvIslxPnc9PmWMSQYmfaj6uWX0zJNjSp4bxBvpQOcPiCiS2OjM6EfFRG29r
         WnoAXqqZir/Vv8z2BQcZ9Kd2lt9W2dtBP01WBMKxYYPReWxk1chIIrjBRi58CQkjqvNQ
         E5eaLOELzTJLRp8QDVnWjzC2tEWDpujo9C3rhDQSHMEdH5BflchwhiO/BtOGyR7rWQMC
         GdXzHzuqxaSofKeGXoi+Qe3tTlAbn1NzF7uIvAxTw0ruelTG0ogkMKZDUWxf2cX2udZL
         Cdvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790623853; x=1791228653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cWD8I8h7f2Mn53Nrt9tP6IaEf3LtqBr0+P+yyQFgntI=;
        b=Gvo1QHuOI7A65Mgu5SAXn00It5kIXTmp9uDzN6+heSjhl7EYQE4gfOeFmtpZRYh7RA
         cXy02Z7VA7VZb+a1EpWEZ/9l6CyyedxrjKCkobJoD7r1Lg1rP5y2cub04+ySLGbYLqHT
         En6+LXxr3knrO6l54BcCuNOkmEws8qXUwlpFtom+5Zd+mwmaU8H7es6huUxxI2s5lTQr
         WiUNMtebJin3xSrwlWYzK1mb/wsdErSWbWpV4jMxxQWNNMJNrQr16RgedfR2UILKsbPv
         epDTjIBWnnT1KTaFhUZXpRRCLzJb50yO5XTlc7m5hIxM6PItG8HQYgLpaYD4bpguV9UW
         swzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790623853; x=1791228653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWD8I8h7f2Mn53Nrt9tP6IaEf3LtqBr0+P+yyQFgntI=;
        b=AvxsTJkIj8uIexZFfIGXXQAFvXchnpfGHPH99Pn8VPcXV8AQ4+GyNqmHOB/y9B9172
         krx0Zallb2We66LepZ/lEYmv+ejml1ebE9jjmgHoQBruhvf2+UHn4tJoAgg5th26KuMU
         w7e+uXaOy6Q72mDB/TX+PbP9z+iyYiriyI2R/ZawirKhpnxDho+yGn55Vk5UrMchZhBK
         RZPWS2TiWDaoxwyGsBFmbR71yLfriTzwh84LtcznjvlRUuygyqjMqq3xy7gKdfqHDmxW
         62nsGVx7rbUVF2gizsVxaxF5x8B489L4HZD+tq0NoZyFpDVcAId7bVpZUtFM2JYZhihA
         aEUw==
X-Gm-Message-State: AFq9FYIc0tIXHZa1WHXuflF1ZCmsbRv7kreGWKtLe2Y3lNfYEObf/BxY
	kjrTQ+s8ikYac49ZrsKyf2Kbt+VNzwbYaUYj30DgQ11PcnU+x4kukSV1WC30qfFswpj3pHLlC2k
	MK2TGO2M3FZBLtAZDbMAXBMMMT/7m13o=
X-Gm-Gg: AYBFou2IHPWqI7z3EQSJQ5jegvaZIOWTOyt1UuAz+mu81qL+Cq7lcQKqY2XYp9NZN20
	+XX7AiNES4ClGBmEkV25OtYfGy+xUXQDDSMO5UQMYvpvRSR2jATM0GwAfOpoRuzlnY+g8MAK+eK
	o0JM/kFcsadllLmIBSvlhLcVw5Fhrh7VXDDLN52uxOS6coAfStIldk7t6scGQVYNIccOFb/Tp01
	cwSviPnpQenkWOQaJgUAE8nTZBQqWmLzXn5IfWr4zwzvFoN6N9V9VdziAu9Y/kEfDprzLOPkuWK
	Hax3jDD0vcDHxjrqd41MX6zTDiFiZcgWd5i0gAOtvTFQKWfxLeJ/pkQ=
X-Received: by 2002:a05:690c:6e85:b0:8a8:93e9:3832 with SMTP id
 00721157ae682-8a893e93995mr38258557b3.37.1790623853302; Mon, 28 Sep 2026
 12:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928062459.3189005-1-inseob@google.com> <CAEjxPJ6iZRkAa9Xadwo=H-1CQtU+jAChydfquoSrFL82rqFiLw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6iZRkAa9Xadwo=H-1CQtU+jAChydfquoSrFL82rqFiLw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 15:30:41 -0400
X-Gm-Features: AclHuK8DUAf5K7mRzhqNlY-4fwob7r1zJv8ej2awSEwyDBbe4q3rONUxi5Ca8J8
Message-ID: <CAEjxPJ72C+biF7d1JBmeYZiVB9z1FyOewYoFjYTLWFbaE8Y2iA@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol,checkpolicy: add --multiple-decls option
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, nnk@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:35=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 28, 2026 at 2:26=E2=80=AFAM Inseob Kim <inseob@google.com> wr=
ote:
> >
> > Add a -m/--multiple-decls option to checkpolicy, mirroring the option o=
f
> > the same name in secilc, which allows a type or an attribute to be
> > declared more than once. The declarations are merged into a single
> > symbol whose attribute set is the union of the attribute sets of the
> > individual declarations. Without the option a repeated declaration
> > remains an error.
> >
> > Policies assembled from several independently maintained sources may
> > declare the same type in more than one of them. secilc merges such
> > declarations when it links the resulting CIL files, but checkpolicy
> > rejects them when the same sources are compiled in a single run.
> >
> > symtab_insert() already permits multiple declarations of roles and
> > users, so SYM_TYPES is added to that allowlist, behind a new policydb
> > flag. Like role attributes, type aliases are excluded, as in secilc;
> > otherwise add_aliases_to_type() would silently turn a declared type
> > into an alias of another type. The merge needs nothing else:
> > create_type() returns the existing datum when the symbol exists and
> > define_type() sets one attribute bit per declaration against it. Using
> > the same identifier for both a type and an attribute remains an error,
> > as does a repeated declaration of any other kind of symbol.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
