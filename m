Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B143CEF7
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537311; cv=pass; b=G3OQmDaa6MpJRIy6UVpzSCQ+UUvlOs4R/n2+arwRMTgoTnWKHkdPo3uC2MkH+iI7lf1CFiQI36k6B4H8lLGsLJwLwAc3KgZwWe692v2KSCLUgQ4opB4cx/Ly37NPezgPrSzqgRsrRszV1NS0vR1W+cH/sZXJuK89nuslWZaRbKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537311; c=relaxed/simple;
	bh=BA+fyf6rFHr+h2Gj6qKcSMLuAPt5/TZceF1KaMQSNXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klJoTWuTCYivNNRhrgYeqp/XcKdN/Bev4nFJvVvjFtQK9EURFwZVARg6ce38YBEUxF8YM9Brz/xSgQoruVvElXU2cASsgjaJj4cjR63Aw60S6PM5TwNihiZ8NsIAabpxeCE6vxNsy2opQ5Mnez0xy+yPNvp3dLED5EWDw5kyvlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4s3x31v; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4s3x31v"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6ae4475c68aso302888eaf.2
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 05:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786537309; cv=none;
        d=google.com; s=arc-20260327;
        b=ruzl3Vpb6RoM/Op4JA3j0auadUrStkhIDbgWYfmI6mB9OVi4KnEeC8on2dXTxLEiSc
         EHKV21X5hHL+meEuBl9jjHV7BumU3WoA1qB0RVvlpibda0bW9xWPDdkEoP1BBZ4qvn07
         ymxibJ4+g79bDHf6JX9LVIXxSUOHDwB1/VhcLB3DoRiRnTgcSeQXoicbrN0k+t5iEOPE
         aILk04qDoo43k6m4jxqrNtGewSSGzCQ5QIJnouS7yqAvq/8pzVikaZNuQzPCgKZdJET6
         rQKzTrTbmLv8J8zIgEE1HZIDgZoCJRCQHmV0ie6jbnhxpK+D0SlFKw+1Rpot1EM1CTU2
         7Qfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BA+fyf6rFHr+h2Gj6qKcSMLuAPt5/TZceF1KaMQSNXw=;
        fh=5CMF/6ELXj+1r6PbBJUhzhCkrBYeABmfe1l0UDZkohA=;
        b=h+R2dTzNDKU0+AWVT9QXp7H6XBheZdU84UDtl4qG7lxqogVjn4fQ9PV8flevnS4Zic
         wiazwtHUkqBIcJCQxs2TmuJ+egrrg6yKP1z/qUjQf18Tcj25IEWlDPQMG6xI6Vo/Z1Ah
         E7S6hko2z0k6cZqWKUqpF9LxY/NIMhGeppYO0zBDVKND8GyQt+ywxns/sbYSkn29rljs
         5A9UFl9LeRFeY1OHIIPknt7DGolb7u0ePYzGYtkNuwJY0bOkqIzpJTmUBH5wGYNL+glW
         xLqaqKioppZ/X4LwOPqBIfCHKTc45D+jMaAxgrBraO++SQRLZMax+26TFZ3gCJSz2blq
         8B7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786537309; x=1787142109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BA+fyf6rFHr+h2Gj6qKcSMLuAPt5/TZceF1KaMQSNXw=;
        b=b4s3x31vk3B83u4Xkn138OBoBkNvNx4sBCW/Ys12ay4oMTlIp1dI9sJkAM4bQPb1H1
         48aaDwbbytJMhI9KEW/+Dj/18R/RQBF/meZvfa5N1erLYdr6Ld6KTyKHRod67i/LpZ4I
         HKC8pKD874Lvl/N/cWXWguj3YyckD3NAjB/o4cPyPyAIOqaYZoC+zA1ymYN9qikrRUU0
         /WSEWS/YDMVwL6+I/NAyCCJAUK/Rln/39mF/VDIS1NsNbjpc3pBusMr6YH70o30WyI8F
         6NrqDf9Qd1REZH1/0o0aq0aodiDJmz5FLt7hHlWFkvAfxK6T81bcPO6bZpMAet7/6W/E
         zjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537309; x=1787142109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BA+fyf6rFHr+h2Gj6qKcSMLuAPt5/TZceF1KaMQSNXw=;
        b=WeE1tPXbwHTIoaTYiE7s8b7S0F8ZcPIEzpxlW6BpF+2n9Tj22xMXQYMXN/1vNEW7Q8
         n+6hjS0ZjEnbBVYUq3x2J2jpB9V/Z/rK8djSNqLjUD4MhmxtlOjjrT9MtQIl2d+1rhND
         m4H4/fhHWrYcSxdJsIcMqr4poH3Dese3w7JBwQo+2K1W/3Kf/laluVniynKHsTJ2qG1t
         gcNVCpaPdBjYyrU+xHL24pDjzxqKr/xGVrxNOOD0FyikaeBp6zBNkkEqnqFhQU/XaJUI
         o5KQXgWCCaeaeUXLwjmk8X/a0B9F7OoFQNTzo+ENqeAo8cY+l2BCYp3KeGnRU76zStWR
         xcUw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0FDksx/vQJoj97HoqTUiVcyIKZc6U76ifNVlug6/sM839J/Bo6DqD6VjBvKv2vQ56dn0NGM/J@vger.kernel.org
X-Gm-Message-State: AOJu0YyveCNyYq1RViLih7A/j25onEGfdC1P2RfI6HFG61ey14Hd9Ofk
	KW1uf0mauI2CQYnbQ1ugajQB31BmAZOvpdt9UfYWRxS2KzpiBE8pR/jENx8smNJFxxgQy8QED4c
	8KbenG7OjZ735q5/VcjJFPj/ajVDUqZc=
X-Gm-Gg: AR+sD12wA0CUjFDqzhHUsriQtiNRtZqkB5belXiK6QH+RDcfuxfmVQR3xqteU179Wvn
	d4EZdM/MzPKeCWLC4fe8KQmxEV/Ngb06q9GUDHWyoMIz0vDptidzWwOpUV9Bno1dTmsh43nxQtB
	0DlIWDdJG55MQRc6eQ8+GEblerJoCnm0TYcTB+rfUG3/pyuV/z+bxZtShz34I5xl/zzZCk2Ns0q
	hnnlr7VDhKxBLKSMeZHRq7YB/01ZmkKIkwIvNG7mxZao6HTMk4xbxz8nul34gUdW/wrNddvLmmU
	saThr6Fkk/huAf5cYA5600MD9Cu+4pYDngOeiRtxboDY
X-Received: by 2002:a05:6820:f00b:b0:6b0:44c8:daec with SMTP id
 006d021491bc7-6b0b28b32b9mr3001172eaf.25.1786537308045; Wed, 12 Aug 2026
 05:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811042908.3803430-1-tweek@google.com> <CAP+JOzRhNTsZKOkEvmKMqB_M681T6xp3eUic=00HQUhbF_V87w@mail.gmail.com>
In-Reply-To: <CAP+JOzRhNTsZKOkEvmKMqB_M681T6xp3eUic=00HQUhbF_V87w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Aug 2026 08:21:35 -0400
X-Gm-Features: AUfX_myzZEusyL8qCanaJBFiM9Xyy_Nge3X1CyHlUUBdmZUMHzAh8pGZQcGJSDA
Message-ID: <CAEjxPJ78Z4_PiMFnOfXMkGBzqGLAz7fzcAGeC+G14R_-wFfDkA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Output culprit rules from binary policy
 when CIL AST match fails
To: James Carter <jwcart2@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Inseob Kim <inseob@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:48=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Tue, Aug 11, 2026 at 12:29=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > Commit d8507429f15c ("secilc: Add program that checks CIL neverallows
> > against a binary policy") added secilcheck to validate neverallows agai=
nst
> > a binary policy.
> >
> > When a violation occurs, secilcheck attempts to locate matching allow
> > rules in the CIL AST. However, since the CIL AST in secilcheck only
> > contains neverallow rules and declarations (not allow rules),
> > cil_find_matching_avrule_in_ast() returns an empty set, resulting in no
> > culprit allow rules being printed.
> >
> > Fall back to calling report_assertion_failures() to output the culprit
> > allow rules from the binary policydb when no matching rules are found i=
n
> > the CIL AST.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
