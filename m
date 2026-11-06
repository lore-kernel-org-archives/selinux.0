Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793995612;
	b=z64w2Y8KkEfcAMDDKmh7rrKN5PL9w3eJJX5nfsYKxoP1ik9Qk9R7Ghy7Ht7DO8Vdkj8Z
	 jEY3umlJdJ8nYHJASBbqWwFusEwRkmOf8tWN6IQuFxOgrOC5Pz6rwfVkKjtvzSquI8o6W
	 TROygb2y2JuUs7wnfXF0Y75BkOzgeC+4nUAjHu6Ni1JwtOKhDXenHkUGwzDE89B+bd+XV
	 LwKKK4rnrSUkrDXT8NOslDr4n+oJHUMxT1YWU5qD185uIXJukHetG6/CMBaFhwp02XfoC
	 FylBoU1lEUeWW8Ss6Cr9wu9JJxCHQww2VK0/JLr8WyVDMcnXLpifL5s85eOFbEVh2ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=neYQyC5uc/9JMXk/k8FeXytXcg0PwzRWyOjCEMVuYx0=;
	b=p53nnRxbCTfoziA4RZWnCVDaWAS3+2q1fB+ZekP87OUeIHeyjAPd8kLWa/Ev+Y8soSlK
	 U3r6IxqE6xYUvRN2Hh+IlNoiAjZVE4z6MgG3KlQMGLfahFtks69AVNJpId4PjwIn8U0Sa
	 EtN8pgc8/Sjd2KtRFi+EXp9yg9Zm9ogmBJcYccn/jvf0SLFOp+MIR6zOwha6kRYeELcCl
	 ZHqud0UcSIfRzEpvzokIMnWElrNOPPh55MYcrN1mQvu9xAMaigV7h6hxvLjMDwXFehF1A
	 fAPGtZDLKCDS4ANGZTQ6MY2tlnfqHbcbidk0axfj5etgMmzxwPGze6cwdkBxWgeOczg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WGr2MrsU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C11606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 20:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65C11606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WGr2MrsU
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso20933d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 12:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793995611; cv=none;
        d=google.com; s=arc-20260327;
        b=Z69TSwjW22pSVOnrusnU4kW0EhWiVOOkRKF/yQLYhtXL/cOuwOjET8wS/+S8UtaSTs
         rfkUGHtqqGn7B7oi4Z8kG20CpufBv6YJaec8CEwn6cUSyz/fj6R1ayP0Gd+n/sJOozB5
         HpSZcdX9ULA8lgfLPU+/i0FqVFisDTcaltfEEfqOK5Evp9scBjmk2wIB5JyzNNtcWVGa
         Mt4QR8sHtQeWwMk2JQAw4n0oYuro13PqRxpC6b5S3iY9dn2kJUYAA/Sb8uwNNhx1BaGy
         WWffvVXCvSt2joz9ROAkeLxxXO1JdUbxTmbU/gJL8S6ztuA9QRfVZyhqwzaeaEirCRk4
         B1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=neYQyC5uc/9JMXk/k8FeXytXcg0PwzRWyOjCEMVuYx0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=FiPG7dQo+NoNyA0nnyHr/okZOZnoLieRfSj/RaMxrslNVfqONov32AZerUF3Rs1UUF
         lHju0cly7vEzSK7Dk2Mq63QREKtVv12LtBuBPMoGFemMlSgS6zusDGfHJXRDga8JKwuO
         zUHMbnOXMwKbJVKR06yLZZgjcnyU4kYWdJ8AbaKL/qsgp2KFX7sDySx4l06Cg4clNE+B
         0VW69XmPjGDfgkUVuOMCSwN/LKd1fgZbA2AMhsVEeD0f1LCyX7Bs3v++ChnSP54KZWR4
         eGk7YoHGwBnPwNe8wtdscjai0qINfsjzsKDs9BhvxKJXZZq/5PW7Qi90Nd2lEHiuOmhQ
         NPcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995611; x=1794600411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=neYQyC5uc/9JMXk/k8FeXytXcg0PwzRWyOjCEMVuYx0=;
        b=WGr2MrsUkjpvcFT2DWFyED70OZUD/psICeU7Vx/UnlZKt2HeCPHrzskUxgj7S5GOcE
         FNa0MfgM9mhE2Fiq64EVuMu6NJ8smAu00ePzfd/0+A6UC9yHuJ9T6ZQUSYl368wKb2EY
         02XSaEKCgxnHNoJanlgqoU9Hczwr38BbUJOuZlCPUBymicVEaoaZTgSXIPxUd92AQ8xY
         vN1pC4pi6j+q+7Kw58MQy6P5dHVpiAdCmG5eWCCkIO+6ulmicx+skCc/+d/dYCx95A/X
         t8tCsSwT/9huZafzfKTDwLrYZ0s82QIchE8T8LZ8Mmxkmj7BlIFcQlFxgUC/8HTVZa7N
         mspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995611; x=1794600411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=neYQyC5uc/9JMXk/k8FeXytXcg0PwzRWyOjCEMVuYx0=;
        b=BnVsjOovrCs2BjLb29G3pVgjB8dMw+TeXa/XlgdMouyaVlAuxjTjZKPQ2QZCs6/5/y
         u2rrsBpNwyG3u2gV0yLvH3uo08J+P2f6MadFWjJnlZnouBwL25O+dv/trvA4SIi10q7M
         AcCYBbXcwyRJ5zJiMa0u5fHY9ARMhrOadzd5PEE9UdF5Xdp1MEszCxheWhi/Ke9qlpid
         Cg1d/YA4cAsrsdbFjMGGKJX6LFmEXox86kGvYb9+N1ZeMbPCIALXFhqNtA+7EMffjwD7
         qo1OTqIYvPyrSel8EXBh4O1wgZLbO+lpR9hb/2YVZVuZVseUATidSQhqFIYp2yeqRHT6
         JOiA==
X-Gm-Message-State: APuU4Z+8zKNcyCHObr8U14SDzcMR0ketCx0SiW1vNblacGWrdT0b3tSk
	2o2CIEP+bC+KX6+mth0YVXv+QPztMIjxZLdeRA4wWxBetUCsFZWFQz8eWa26cKgnjeB5fMWpJr9
	mW7Ti/p1ewHIC+n1c38MgWdvddGDZcXtBxeS51n8=
X-Gm-Gg: AYBFou0IqQkHIOOTbtMX4JPs5mgs92A9nt+tB4NrHltGtV8/rlMwtYriDtmDxcmklrG
	qsyLtxciQXRR9gb1plEgoQdoXtih7zNMPGQUdWZuaz0Aifrz0hczcEj2Nxrjnog/eGodkffezn8
	Xzy/ntgbwjo+/bADNDN86/gU2YuhlDrwN9LnuP+vXK2G9Cgac4dFtjn0nv6iDENi8B8O6KTA1Nb
	1ekW/gvS43LIM/ijIKALP/JE9deBoXxWEpawP3v3JmMyvp3VAYQvHrPkS92SSDiqk7G2dmH+O+k
	e90ZICqXQfXecgeuOL3hErXJndM/clUCKbuPzexlk5N1N/pvE1QB3XN2A2ZvvksJEXfF1NcXKOJ
	sRgiQorV5uiqFzctcTzuhR77IZQ2Xtosi0Ts87PeSnmPipmM5DY8GTeBz+zY+JgX1ArLJAyYDLz
	EDXI3IPA/IxszGPHhufL4J0TfoA3mbqltLzfbEMegj28sGWWH/plvewEPC5Q==
X-Received: by 2002:a05:690e:439a:b0:66c:e21d:9ab7 with SMTP id
 956f58d0204a3-67c29ca5d3fmr11029d50.12.1793995611454; Fri, 06 Nov 2026
 12:06:51 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-15-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-15-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 15:06:40 -0500
X-Gm-Features: AclHuK9joX8FwhYwFNnYQM91T8wz0Id8ORQJfWlbFP-zdF93mwmyb9l89mwUcig
Message-ID: <CAEjxPJ5oKiOYphn3tb1yw-s3TstpkoXd4J-ZSGjV4PnhOkf2wg@mail.gmail.com>
Subject: Re: [PATCH 16/16] libsepol/cil: name the members of expanded
 attributes in constraints
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Since policy version 29 a constraint expression stores the types it
> names in type_names alongside the expanded set in names. When a
> constraint names a type attribute that is not kept in the binary
> policy, e.g. one marked "(expandtypeattribute (ax) true)", secilc leaves
> type_names empty. The access decisions are unaffected, but every
> decompiler renders the operand as an empty name: checkpolicy -C writes
>
>     (constrain (CLASS (PERM)) (eq t1 NO_IDENTIFIER))
>
> which secilc refuses, and seinfo prints "t1 =3D=3D ".
>
> Record the attribute's member types in type_names when the attribute
> itself is not written.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
