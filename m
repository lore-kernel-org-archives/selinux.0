Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DD3B05BD
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341852; cv=pass; b=RdOpHBU2eHuj/eI8ibgf+xBLMxHPywaxFj7WZ5t5eBwRIPZ09G2WsLpkSYUSE7KDkpttU0JolXUE9KVfqfUoGSJ/70hfG7iIKQt8wZi3i4KBZ9WWS1Gqjvqgbb14Y7q+iQj06QCzi8HPgEPeiQ1bVfApcopmPLbQ/dd1WSCmkS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341852; c=relaxed/simple;
	bh=TfkhLFjOb356Q0MH2ar65KZ1XBTWZp3SXy8BAZZ2JPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atOrFHCQtyDe2HhcEY4LOLGNFWXX0kzfkD1Ose/3DYuKM7+wkqYYbTtxxw8orpWSvFWa8HrkXTNk+fvVVewuVmfN1knYID0psyW3E8sKkLHX7CvQ4Ng/nsVx81PWC2t+L2nN6ZkGCopI0ls86toJ64OHx9CGhWG+4NZUoOTLHTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dChehV7q; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dChehV7q"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so456887fac.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 09:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785341849; cv=none;
        d=google.com; s=arc-20260327;
        b=K2PURj7pU6Kif3ZYt/TYCOwnx3R/+vTziX/PqVr4jhGhI4rjqcQLtyhghwcIczlWAx
         DlyE0guVFUBy+47+vhMkQsfjbFJc/hveBhGRN5C3o/KbFNiyKEXMH0qET6EN0eysYCp5
         vcCc0/WN91si2bScRthguUPHS8EhZ2nQPFIjrWl2ZsQvU1crdVFBJJ1zsTc5AVkJ65M8
         mEuIAD1nQ+ophPqMb5G4xj2qxBEfa9dGHn8tJbXJ2LqMTNomb5zRmfi/f+gGop6Z0L+L
         ayViy461++mDqr70s7zNlZ+Add17aukK7owD8lIUX2XUhZVlwpa4CEtpgsQYf6JER7NP
         MQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rfRX78pxBpMnoTjNRFIkb3nVnH2WCnysYHfD8mM9nJU=;
        fh=E51Jjr8Bz9WzQ+Ik80n9UcoRPIh3NakEhV8l9xr/qbM=;
        b=kYtcBn6KJDq2d+2l8fYla3oRSf3g2APIXthFAS69AyGz4/UARNAuIcCSfBDV4hfa17
         F4TaO11zhN0qf0h8qn3oSnVIuT3PNDbElEnV2jjXlFJlVmYiYFrLoRlthYMzn59ndvjy
         I9e5z096REYC7R0oVkC9xYrxxphLkB3+qR01AMCrqvFuhTTtdTht+BtnIdXygsNip7HJ
         iLjwVN8Olu3OHA3xgw2ACFT27TKZXv7Myp+pLimDaSay+s5e4/YU076VQz+hsG+uElnO
         A8xR/bxQ8Up/zP5091yu9ZocArbwe1DJr4Wt0XbX9v+W4g9e51KSRzrc0qM1rJ3ZWS/P
         3Cqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785341849; x=1785946649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rfRX78pxBpMnoTjNRFIkb3nVnH2WCnysYHfD8mM9nJU=;
        b=dChehV7qblscj14MLVCg9ug5oGrF/qBTJh73YXOFB2kCI/Ne2VrZPkI1pr1D6O3Gyc
         oaVF8QHcmn1/ZDbhS4MkzpET4JtDr1whX7qOFWW0RkhRe7h7vdRFMG3WiUbb1A00uljj
         gAq+6HTB5DYOq940yOLf5DrSER5fJUq64CZTzuHmAo8cG7X522JKS+qDDR3/iRdJq3VI
         br+8OjProN8WYZrkRLx8GRfnBPlg6WCd8X6KKB1M46lNpcB6DoaHobYWCPZbLT9HpErm
         Vly0WWOh8RwpC9Z8n33qKLBMsoG2EhgRUjdWDiRI2uSO86Bnx561BruBLbZLbUxspCB8
         O63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341849; x=1785946649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfRX78pxBpMnoTjNRFIkb3nVnH2WCnysYHfD8mM9nJU=;
        b=ZUV2dQYHfScItfkZ5u/0sMAdegCPVSkVx4TAx1CAokhtXLlN5dgmz0AuO/VrbEH1oT
         edd7Q/qAIxfGjROFSYy4mcBP5nFjxorDYETjdqmK45UoZ/7MjOOp7Jxxj75f0tyvSQDC
         CpwFmsiGbTobluQIL8M/2B8dQeWE5L0evI9kMDovBhmfQJTXZrgf6dm7agdmr3LZG+yw
         ZZIp1P5ItLO/nyzJTRN3T4pfm1OK4pHhVPBwHeL5yehwYk1j6wZPJZEU79ilj+TFOHnA
         fc7Cw5grqizSOXQMVm93XyFjUU0Vw5CsYCKzPJbPToJte2OwrKAAeET7FfZfg5lO9NfW
         sRdQ==
X-Gm-Message-State: AOJu0YyCC4ed49W9RhCYsYuLnSAbYr3DpMXnE+t0LChyN9bLLuReUhQ8
	NU5QNdS7Lep+WVE4Mk8zRYWYMu6+QyG2Shp3rYCycRh5HbcIccjxdWgyB4bJHnwJXRFUuYDeScf
	cfv3U2/JUtkiG3eqO++nsUo6SR0ZEjTx0Zi0Q
X-Gm-Gg: AR+sD1348sKUxp1fkBghyDzG5BEKTsuxAb0qVmB/6J9X4o1ONgjqihN0irJO0wX9AR6
	vzCeKYNH58dS71hn4Sq4IpsopKGjk5Y/tXEz6N2CWUVMxZB8gmzGqmjS8vGMqVP12/MMQ/xcaAq
	19hjn6vwDVanrE5Jq2IoX+UjYDXmCfIqMaejO3BetXYolufZvXZOZJ0Ijo41hWeDnJd2kW78Uok
	qQeobJt6LboEXf/+T7dqcn2mRtStoXrmwpAbfPZjf4KYzQD+/DSnQKwBqPa9kXAJdV/FY2yiPrR
	sIL/PyYto5a/csrJN8XP06xyfixj0L8wPkkskZL4Mkwo
X-Received: by 2002:a05:6871:5b1d:b0:44c:b310:7ecb with SMTP id
 586e51a60fabf-4586cd96f2amr4346368fac.25.1785341849346; Wed, 29 Jul 2026
 09:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729145524.3882905-1-jsegitz@suse.de>
In-Reply-To: <20260729145524.3882905-1-jsegitz@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 12:17:18 -0400
X-Gm-Features: AUfX_mzgfMvzw114WTA3aXghUrdVsGrGOhHI_ITZhQg0VBJdYAXo7Fz_TGlshMM
Message-ID: <CAEjxPJ56f86q0+Yhyz6TQRqLKNUvMiwDzR29Se-MzfauWwmXwg@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: harden systemd service file
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:32=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> =
wrote:
>
> Start to harden the systemd services file with some of the
> unproblematic options.
>
> Signed-off-by: Johannes Segitz <jsegitz@suse.de>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  mcstrans/src/mcstrans.service | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.servic=
e
> index fdcfb0d4..114c802f 100644
> --- a/mcstrans/src/mcstrans.service
> +++ b/mcstrans/src/mcstrans.service
> @@ -7,6 +7,13 @@ Before=3Dshutdown.target sysinit.target
>  Conflicts=3Dshutdown.target
>
>  [Service]
> +ProtectHostname=3Dtrue
> +ProtectClock=3Dtrue
> +ProtectKernelTunables=3Dtrue
> +ProtectKernelModules=3Dtrue
> +ProtectKernelLogs=3Dtrue
> +ProtectControlGroups=3Dtrue
> +RestrictRealtime=3Dtrue
>  ExecStart=3D/sbin/mcstransd -f
>  RuntimeDirectory=3Dsetrans
>  RuntimeDirectoryPreserve=3Dtrue
> --
> 2.55.0
>
>
