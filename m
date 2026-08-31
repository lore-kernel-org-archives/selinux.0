Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D31C38644D
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207305; cv=pass; b=HCtkp/N311Ok2o4bMigAx9PaVPXwdBG8ZTYesMJ35up7p5NWMV4oWkQ9ddrZQtgR9OD/OWFTy0ePFRyAm9LIR3oHsVpN6YjBXDsj1OQyU7bk1J06bZzU22T0OPBq8d0eY6IAACSaqgBY+RLKUOQKzsZZeauPSEjJHRixJmtabcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207305; c=relaxed/simple;
	bh=rc1kayeDO+zG9eJZu2hIJKT6rQQ3HKEy5PVi574R0z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKxYPlSK3hAOUFtl7wcoLupz7vSI5VRTJgV+1RHQ1v6FVdSrLIQeH5L2UdlsUISX2Na1aJh6pxy734KOTK5KxHdMCBUFv+jj23p2vidJ30M6/r4q4zQTIJsKXtT40onHuA+9ftgbp7hzAJHrkQkb7NEzTs+niX8siAlSnKvrXnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3dW9/Bt; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3dW9/Bt"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-46ac530b9ebso239297fac.0
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 13:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788207303; cv=none;
        d=google.com; s=arc-20260327;
        b=Tiido/5uuWqbEsWSv6XZhLgAgVt/KLQpuICPc/ls/Rryu3PQ8rBgfhyUrHSgOoOcqp
         IjQIyidRBV43ETJPyeo6Zp1v/bXTLYPQwXCtXUa4NDt9Ysh1UKH77Ef3cSoxt21E6ikR
         Dpd0Ydjo1Xg9jiRmTZpHrsTdUCUq7oD28dDkz30KwBop6IHN7uQ71/VZIdyV8TBHNl60
         Fj7v3cBSKuoNuNL9Q7yNwvimzEDdx3EmZyTRwrhAZQXwf+uQOZEJJg+wf3I7b5p95AZe
         tvjC+bSV+gns3xma6OPl7BSiAMq/Vm7AZovTQ+DpXMNZkOTVaPVsXF3URpb6Rr6Odtyh
         EDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RSyIGpFGM/rgEUuz0POEWdoLD4XAkLat0Vaxh8mIvy4=;
        fh=eQaouqZSrQIAlDzRIrQq/aTJzazDySYLD2N+VW7naxU=;
        b=kSCMq/2vOa0TyN0hFn40piWpBZomRWOTs2k8aq+x4ujj7YhxC3g3xM8k58edb7ouA+
         F8lOjnhCShiLVSCCgaaGX9VsFnX5hifRkUosTKweS05cC9uJcZYr8bUmZU+AtEQA6uCV
         7LdGe+PTY31WBu/JBH5DUINUS3Y7fV7c8fKDTlGjhIdQO1p3oGx9v39b9Gc8JtgoU9Iz
         ZYIFMh0P4VxyHRVgTdnQqHuryGAnVW9Zy1AW4+J9hzzLyEmLWLBdFtkAfRaxHuMEz5sX
         uIZUCvQWZNN1Dtm1C5VurWt49qqBxWhZKGwmaDggyrIdOw9m85nc09Kz7qwQuWuiMpq7
         Ml6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788207303; x=1788812103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RSyIGpFGM/rgEUuz0POEWdoLD4XAkLat0Vaxh8mIvy4=;
        b=d3dW9/BtVku/7l9ZbkC+7/zR8rbgwKradJMoG/lILpWIfJDd81SOlIkwvq3NfEuke6
         rKaLQ2Olr5ewzX0b3Og+o0H+0Mgm/Ml+fujqT2rWtc/lL2ax1yN9MJ626H/135we2wB7
         25K4R62oBrzUROGPg/KM09ekfetPkrnFmaYCfe7lvlw0VJABtwgDo7YN684FPbz1DQWP
         CjTjzLfGGKXJGYjqHM7Ex02qr7+53EyVBZojmiJ1A++Kg4onCdLsaGOwYzNxYkzPInu0
         CaQhxAMzY9VXIhCNn0WGiV2Op4WGjUMuKjaupniocT6XSR9gS8/Bzvg1hkT+af5+BWTp
         vxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207303; x=1788812103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RSyIGpFGM/rgEUuz0POEWdoLD4XAkLat0Vaxh8mIvy4=;
        b=hhMv1qzpkZnGN5xs3U3LKkzNDSUBFFnIlHLM3SZqw268tkBT+sgS/siRnMmzJovu3y
         wzZHodGjjW60+Egpg8E0d3BlZpV1HXubtURMf9GsDMPIgda9M8Ft4kbJNYlQeC/L3f9B
         V77xo8CNkPMyvO3oOco65vRDULzq3vzSUspABIjf4RyQcZ3zdl2LUmnJlvfjLwU5sfF5
         OJ8YppLg01/lVShgkearxRppcKX+KPRnvHGUYE2EbcHl2VMt5La2ZUuKOf337O1W9sg0
         EBjgNBfT4/1lrUdCcN8Uwoh/HRYwYMYeib9HK7NIAiYfM8gw7to4a2PISLPp2znIQHse
         DRNw==
X-Gm-Message-State: AFuF++n/0WCjeZbJczycSJ4RTE0qnvsjcNeymd0Bpta97z8wbSsU6Sht
	IBmus+3yklvnL26v4WQkyMprjLXOCyhW4qCCZdbnQivNbaAdT+Ctjw14gD+zNJqAbYBfNjadyie
	XKQ8Z1+chWzo9JHb94Ksjlr53p+HNszg=
X-Gm-Gg: AYBFou29a9XqM1tiU0FlqdHRSqj8HLtOSWd4li9vuomOO2nLjYM7McGUNk2KxFYAdVR
	U1DVcg0WYDHW/f+UUc/cURFyQC1qPExxQXKE8IZ6X5hgUX0zVsHXhCwqaH44PJJ50EAiqPEhvhR
	jz7dOWCSYw0qt6SzZKxwUJdpoyKxOgi5rl27tWGS+D7pdq8kmscfQD6zAu/0vgBNBb7VLK8qoei
	vPBJwpKHoNhtwAHEH2g7NcxTwSNIwut7h5U7spknlSTguE6X+nnrVOWCxD5UHmryitb2MKlud90
	q36QR3We0r5KvgXzcdNzwsYctekgOL/AMJMWiOTlGAGn
X-Received: by 2002:a05:6870:8108:b0:45e:d645:e03d with SMTP id
 586e51a60fabf-46afef3cea4mr831443fac.11.1788207302690; Mon, 31 Aug 2026
 13:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831133509.3287-1-dburgener@linux.microsoft.com> <CAEjxPJ7DeQkzeFTBGHoBaO63M_6i38qkqobQCz7-AZ4O=6dQiw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7DeQkzeFTBGHoBaO63M_6i38qkqobQCz7-AZ4O=6dQiw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 16:14:51 -0400
X-Gm-Features: AcwNN1VLintkEUpReBOSZBtaK5BRwcvVy_mI8mE-6wONRc80-yF2_SCVaLjHfrY
Message-ID: <CAEjxPJ6peSGOC1-+AAKHq+B00k2VhnRC4uk4z70TxXb3xDTuow@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use correct struct name in comments
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com, jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:26=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 31, 2026 at 9:35=E2=80=AFAM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
> >
> > The struct selabel_opt does not exist.  The correct struct name is
> > selinux_opt.
> >
> > Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
