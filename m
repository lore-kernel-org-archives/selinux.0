Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776218C31
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049322; cv=none; b=HcEmVr4KDfOytrWnTtLKQKGzHuyHTAhdO3Tn45BBSUXN3/u66Pu8i5PWUTN2gXJ9PoAKtjJ060S0hLtuQ43lbPoeZIywuOn6Naqqf6RWzyoB4/0kBmbNTC/vXNxLij9IKbOJ3R5GPr3/gYZpl7W/W3axxWs61BqOq+P/011DDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049322; c=relaxed/simple;
	bh=mvKYKmCQfLQmW9yWKFiRl6TyKxLpaMCuZWREe7ol9Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnpSCDfITPuDh6kkIDpNsSLF6Iv8yDVIfLPFtDEtSed2KUvPnfUsMQ6rqKH2sSSLI6HdYQ3jpfJdSP70iMYmKWc7QlkWfBF0Nk0OC6BVclVZX4cflyWF7Ppy/3KsuIy+bVRUEg01+1jTDeHdO9ElRidzE56UTL+cBr52nN72VCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQEJc6jY; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQEJc6jY"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523f670ca99so2085074e0c.1
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049320; x=1744654120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Zvh5qYwsh2ARxwUxEIIYJ4WvYrRrT6jIJ8i9rI2y4I=;
        b=LQEJc6jY8rx2RHLdTx/QoJFJiq4jq10qaGi3vFfHIkR3qes1mEQX/JRra23dJ+ctZX
         Iysg5LO3o45OISApuTAf6gMkpPi7NW0V6WM0vo4j7nBY5bgMZS60Lg4WADDc6xzZDkGI
         zsMqZ1dO9fVXE+GpJUUlNdUE0SeWpprIUvVQ8v72/CuHvvTQs16DUxtpnaxdytLPPTbG
         M1/PNXfjWZhEOU8TEaCqmaQk4/tTC31VbQhb1hdwh36/QLL828Ofdh8gNpXlploX6+0Y
         KtA64//B8+76coMcyfBNAtqsUNGrAvIxUjGgmTgnS0aywLlsMOLr777y/pGdnHHugap+
         gwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049320; x=1744654120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Zvh5qYwsh2ARxwUxEIIYJ4WvYrRrT6jIJ8i9rI2y4I=;
        b=C0egLirrM1pw1jgex71hhNuijV44TMndrd8DeEfhiJoqSmlLLhic/3S20XJkjP9wJe
         pxmqQ5A8riNIsHQNave1UqqPy7KZ7N6b+owUXROFzabk7t+6+NBIJEdqTh8UnBRibvUX
         lId0HUdIVgX9SGtLpL4NFPm/lqV840sqQt0yS4JLKMt0KVLnH52rKe3qkUf15bhWehP9
         QA8C/QOgmsDhdX+Xt572SNqul7U9dOIJWOR1XTbAL3iRyjY0JkAhX4S46xXSN2Xl728q
         t85oTsiN2m2UM8K6E0ggQCzKeUK7i/OCJ5lXQSoV9U1Xgw690DbSCGLf2uVIvHMdm0Pe
         DOLA==
X-Gm-Message-State: AOJu0YzS1KRaCIIRwktCxLRs4HEm8EQGlh+DeQ4gbCJr7SPsiplb6qhH
	6sf0Ev5SK9t9yiXzeoCtPnvoRgR5NoydqikwDa1GKDFtsufhh/JMsFh1W8DGRi72OhnwcA/OVVk
	iezApG/XRyFSGiZehxzed1T8KZRM=
X-Gm-Gg: ASbGncvup7CbLn8Go5/3ofgUPdvx+nWxDvxNCSxPGl505lJVyDl3O55gTuxWZsm5LuE
	x0AH0cOxWuW2wqXJ1K0UDGLMzvM+TIvS8ZJDV/JFPPRg/sKM1YiiQdOHuQNSjktn+YFeDg3zgk0
	8eQQ3+xvrmCAFr0RpjZvEDFRI=
X-Google-Smtp-Source: AGHT+IFV7vKtp5Aul7W1nuVoeH2CmwbRiCVQvjnajtHcIxOKoozq4yH5+7q5FrtAr/vgGR45XXNl5sp+dprmods+c5g=
X-Received: by 2002:a05:6122:828f:b0:523:dd87:fe86 with SMTP id
 71dfb90a1353d-5276453c081mr10823856e0c.6.1744049319694; Mon, 07 Apr 2025
 11:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225143312.47755-1-cgoettsche@seltendoof.de>
 <20250225143312.47755-3-cgoettsche@seltendoof.de> <CAP+JOzR0U7Hjo43R_TqpgS-OHE8T8ZV8nbmU9nhnXzSZH0E_PQ@mail.gmail.com>
In-Reply-To: <CAP+JOzR0U7Hjo43R_TqpgS-OHE8T8ZV8nbmU9nhnXzSZH0E_PQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:08:28 -0400
X-Gm-Features: ATxdqUEFSDrY3pPSs2OAPZ-gd1t4Q5abpufoViaC2HMfLisx5UUtra4JsNC-6qM
Message-ID: <CAP+JOzQZKkFxr7fbk4=Gxpxmbhx3j0xgCsBOPYec=dagh_Y-sQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkpolicy: free left hand conditional expression on error
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:05=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Feb 25, 2025 at 9:37=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > On a failure during a binray conditional expression free the left hand
> > side expression.
> >
> > Reported-by: oss-fuzz (issue 398356455)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged  these three patches.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index f19e9f6d..18654d00 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -4202,6 +4202,7 @@ cond_expr_t *define_cond_expr(uint32_t expr_type,=
 void *arg1, void *arg2)
> >                 if (!e1 || e1->next) {
> >                         yyerror
> >                             ("illegal right side of conditional binary =
op expression");
> > +                       cond_expr_destroy(arg1);
> >                         free(expr);
> >                         return NULL;
> >                 }
> > --
> > 2.47.2
> >
> >
