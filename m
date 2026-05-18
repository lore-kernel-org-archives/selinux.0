Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E878391826
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134391; cv=pass; b=IJE78t/n0CrdoG2y2lRxm9OYgjCJy4FilD8eQrjm1qpU8kFU/kIMEalin07H2CjrZNz46k/LaY/XAzg//lSqM6xhxjql1x4Gd19OSBuEP41IXPu81VLEzEWI1tAPOAnbzI0lV74cvpyL0qYmohEe8KsGlBhCQ2EihiQSdhOvciw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134391; c=relaxed/simple;
	bh=VwfqMc/WiIStEXdsNQKhIVstOcaGlJsQ8vg35wdmkb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkZNrGr04827qTb3pJoPVhw/exBw/1GU8rKdaUAja7gLpwoCSR+57iLRnQCxW19Tz0ScoEEu7kBeiJv+TRl1jxElnPmL21xz2skJjvmtEtXzAhhAvHm67Rtc8yNl1YKygMGEI+3IPCoVO1GEXS5z1rHMtPKncjDHIC0NFPzBpqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SerHdrh7; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SerHdrh7"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so2482228a91.0
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134390; cv=none;
        d=google.com; s=arc-20240605;
        b=EGkTb9ISbWir2jMn0jUeQeZaDZOi8miB60ihKoU52fGdG29zLrv0biFByh9y8277Qy
         TP8itB9DQjSXfz6cTRhO/aouT3tLiPqFSinyXjJCz2bL8mbvYmduL97+c8k+WpOjATHe
         HiYiwLGw9l450zwHzJLWnLZ+VCgsOBTwrjIGmTCjAWP6aeFU56jCNpMAOrRy7DMY6e+Q
         a9ilBR/cPzRER6fQ3CujoQ3kWiM4cFJdgMjJMqjV6/R0FMjivNSM55A8ed8gSn1Ea5M6
         Sakoktrunhz94ARmcl6OeHC6PpzNH70Qat1km1uw2oiRajZwpAWfbOtGu/L6WAMBFvIp
         8eMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FxEz3/puYXBfSIsFCCC80jABCT83S2VshCjyfPsLIfc=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=HgIpYQG8H68FNzfnSgswQk8OP1g3/HAty7Uioc08QIo1RIvpw4/8HfZ4txTZeRa6Ie
         TmzMOjiI40id5Zv0EGnxHN2ldv/SWvT9nVv89bjTSMl6wFYdK2Q/OfyEQdGjuv4DvLJ+
         3CyfQQEZe1HO39HkDmiyRUy3GlkD3ChB6MAb0YE/YCQuSmVEQQR9oK/YgC1/m42A0/5i
         XG2AjcSBRq94PVYEwdvnGswy1dnqt1pG6OHJCaXsdWh9uzybVufAkoEOf6eDFVPGiP20
         7XvUloZN9E9cQqbkC/KUz8UeNhySaoig5gyEHwxMp4f8Its8Af1ClVOrr8EcyF4e67yE
         r+2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134390; x=1779739190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxEz3/puYXBfSIsFCCC80jABCT83S2VshCjyfPsLIfc=;
        b=SerHdrh7L8r6QrR25aOqx+12jjdrURsNV6ymqVjVz5I0XPVIme7vFib5vzwuQAxhca
         iYwtR00Wg7/E/Cjr/axmteOkjh+nl0ikW6Blc2U3ojuCSvkhdqiW4HVUiHFNvHg0bE0N
         s/fwuzr7aj1pHnZosMMMKiBKDhAmR7u3mxqKN5yu0oP6HOZ4Lhg54bn+xN/HH9SzUbBF
         /0BGp1ETh/WQtmXZpV5VlU23GbgE+Ucs6mf74gcT+dk+JiGFtJkXeWYPju+wEAycYkfk
         exTamQCtxnnAJc48F5QzAy5jbvAY+bllOnFur3T7iqOFxIBW5Sjrd3KdM4XAZgodp5nf
         0QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134390; x=1779739190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FxEz3/puYXBfSIsFCCC80jABCT83S2VshCjyfPsLIfc=;
        b=R8M8APxdcCEJSz60f9Skt/JUIEGfCPjHXDCb0GLjBQMpAbzenDpg9xVK+5GeGfB/Ha
         ObtYwGYpMrgI6GjbIHy2fZe0kWGb2hSJeyiFmbnMgBRErkc954NLWOVMO+pYZrD9Ts8B
         etlkFoNiNVcVMXCkUSmyx705nCHwZrwZiB0OtKsAHUv3y/Nwz0EbsWAMA2itfwOgg+wB
         M2Fej5L5Wqv2nhkDX7iZ0V/2l6s/BMj6JheldWarZyJ3RcCbMiqxxBn9/Er5TGL4OHws
         PgcOTjRh91TIHi+0BznBW1i80uOtOTpbQ7C0jXSvg1ypnJI1/q/W3X57+5zqrkOrcZHn
         PIiw==
X-Gm-Message-State: AOJu0Yya/lWhKBweq4OVggkA/Fq2PuMmfXuiDhfJpPzzsbpb6Tyxalq8
	W5YWGd+xI6HUGnLhVjwb5GN1E4ugyE3rXfIhE3hBzbmv0fCdwkw2rSh4jXVC503QqZ2PwqyKfZ8
	6+mZ33MybUw5THLC5KeAGIt0dEcQgIDx4cQ==
X-Gm-Gg: Acq92OEbrtNxc1tpaLfQ6YaUvFXjsa3Ks7ASZHlq9iG5yqhsZ3ypRrdoNaY4INKFmy3
	9VgCufnHXcWHJ7/juiFV5Gi6rg60UhgAz2HtwSNmNwYTDwFiUcBrxnTpXzzpbIQJaskxl59i0EZ
	yXWHOHfb9Ka/Vs7ZnnaHB06DAhaibb5cwiJxwLdxfQP2QIpLkvf/lJG42/szv6Cwgrmzyz0cXCX
	f5AmqRCLZyoxw/MWWfhdLw9vtNhsARJmw6RZGQz1+g17A8Za5yG+PyEIurEMhevb0TnAk+AAncv
	5JdJxboqZRF3IlD//g==
X-Received: by 2002:a17:90b:2248:b0:368:341a:a925 with SMTP id
 98e67ed59e1d1-36951c97685mr16631924a91.23.1779134389878; Mon, 18 May 2026
 12:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513143020.39094-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260513143020.39094-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 15:59:39 -0400
X-Gm-Features: AVHnY4Ie9WJB6qkQfFBKg2e4869DKZfOWoLrr3I4EGeyUwUkOndz5K80nvyCo2g
Message-ID: <CAEjxPJ4+X5j7OHR09OcVVCus+8em=YgBkLQRC6stmJduX+1+DA@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: verify RUNTIME_DIR before use
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 10:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> RUNTIME_DIR can be inherited from XDG_RUNTIME_DIR or set to a default
> path. Regardless, we should verify it the same way as the other
> user-supplied directories before first use.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  sandbox/seunshare.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Merged.
