Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1927B34C
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770005284; cv=pass; b=CSY1j0qbnkcI6akvQOwNTtKy8Q8lFHs+4/hQ10HYwUcx/2AwPGSt7GaVnUazL9D5pCC/LSiZyKtGEtReKjYAdaJ+WyUAW0oU5+NqDi6miTL6nqMimR+HjqQwZxyf9AaJOF2KymQ3LyGdCo+hBtlI2Db72vbs/9pU1VlaB0/2DQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770005284; c=relaxed/simple;
	bh=YOKr40N5NMnJSSsWi5gI3boLeIf3C3Tjpjo+QN3HJjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdfz9T3v2Fzp0hQ0nRipZPzZ5o3ceLbYqEYX3PQOSls19WqvuP2HQ3Bodzvb9GCUBSCx//XO7PviZ8dmA1mGMx5Qp3ZrDEXkhbnFZf5riEopzx3xfUHzkwAeuXAz+PYn40LUoVvgvfVnUnNgRa0bXgTwCPbXsWgMGzubaQGskzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IvWIS+Xz; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IvWIS+Xz"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c227206e6dcso2498685a12.2
        for <selinux@vger.kernel.org>; Sun, 01 Feb 2026 20:08:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770005283; cv=none;
        d=google.com; s=arc-20240605;
        b=W8IkSI8BAe4cFkaiFbNQbEmTy8XHaVTR8Z6D6R5DQpZjGM68wngT7pV4dyiJWeVKeD
         ltiyvSByp1AMIycIGgvwkK6towdNh6cjcIClUpBZ/ud72CdIhvYq2vgHBcu9uSp+wjSJ
         01m7kLlHETfz0zK+5xi5+3ikHG5D+qUsmCbusp5uZ0FCHPzL2AK4WRj9Ea4ilp3DM8lW
         4X32ScfQBRYgnpwwWmQW9GPQj90esA0gld06sR1XyrO6I/ybkXW0V6j/wcb8c3fPqTtM
         e/w0Cqdae/3nofVMyVj/yI7L+bZDbtUdxJrQT2ILFpkY8jNnEPGTZlI+tjEwtqL+iewX
         yYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V0H+rWHAjETqi9RQMu+lWQENmuwh8JTpCpYCQS4X1u8=;
        fh=h5DwtxXI7e8O/Jsf7s5o7YDLEbe3hcXhw9S8zvuvMeY=;
        b=J6CJ+iIuIi75C/BCtJd5jX1Z1vU0SfJoP+lPyI7iaP1eHJVIY1r8IElOJNvez6u+Wr
         0+Xf6kksmkAWmfgQsQgSnjXjK/t6WTX++0Fa4ULAVS+oKKm7Tgw1UAhiVJY7LCTfTI0N
         XhhMJq2QzKh5Uqhvr2nlYewMIX4TFNhDur+m179x3tB0Tu3T8LbbofAi6T3i2MyrWKkn
         36MO4e1lKWMFMfL6mrgRk5dXF9ERpXHglPHbHp9kn+i+wpt8R03XnhkDCm3MPAzfpjYl
         ipCaqkaGe62o+QYjn9a8nRu8zGS1NFDK7rc3LI5aN3mJJckuLcqGIgBiHVReEksQYFZk
         EUbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770005283; x=1770610083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0H+rWHAjETqi9RQMu+lWQENmuwh8JTpCpYCQS4X1u8=;
        b=IvWIS+XzZ6U7rFPnUSWCGO8Q3sknl0BedpgeIZL6i8mAFEWGtcK5Efs2l8bT8pM6PV
         SGcDQmHDZ2mURMsU9hej5blJxnPZ3iNIuBcZPQy6nXkhztPJdB6dDkQCtYefYPl30Puo
         /DJPPseUGvDG0ijkPFAo4Nzv49LIKIxHY+DYElnW2U9NIhfj7cLnyodQWno48Oem4hJA
         SmS2rCOdhbxZpedZMgomtz8EnynLBJDX5PFDpRy83dJ/JMADB5zhhdFQbEcLabIFADqL
         QpDxWjfjVjeaxnwUdbnXriMMXSU6JrOnIcbyOzlsfYYvmlpXoBJ1MftB7Nu4VlgNhZQk
         +SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770005283; x=1770610083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0H+rWHAjETqi9RQMu+lWQENmuwh8JTpCpYCQS4X1u8=;
        b=l4wNX2Rc9R1+hzzogTPl9CyFPgmshECD+F/h0xqekzUCxo0Jn1QMp1/bSYNNvz5b5R
         mGGmK5q74zm/7/7eFLdYfPvDeltqnF1wA3hodyrV1zN/yF2Th1EEgPRVvMWwjV3mKKDi
         aPbe5rQj/Y0WIa0TZyBXwJYB88FcJ3ciORAMqfKqsS8/yuX6FJlZxxzzCbXRKibs4yi1
         80Yw3m0u2Cv0GrgnZ97yYd1Tbm9PhvH5Hxa1z+bxukXROvCznnvei12+MIjJNulz8eOs
         yyuu56+nnmwoAW6zft0rkx4nL0xnOdKf0yMIrXdbelJIBEBqTFbw2KaBfoNL079eMAkH
         +oMA==
X-Gm-Message-State: AOJu0Yy0kZVEu/hKGIc21wbbWsFezzcizVSB0QZKqDQMw1xA0Wmf9/yR
	aXSoTshTiHInbvjT18JcLMBdY6IswMV8NsFqqn4M4P4BjkFSTb6UmqDIFTnf7gRRf8+7lIc3OnP
	O/V3euSs/xfNu7ChvmfTpCveRoCcwkRhJwb3RPyrW
X-Gm-Gg: AZuq6aKoOnJe3yLnb4T30PNDE/bv4Q0r/7EF9GgqiMK815XhVex4gi3g42jJ/lI+1gp
	74wN+6KkW0mUYpwGIvzBitfHr2xycVLLAbQZxOQqdSFFJK8ABIV4SlYZ3fV5FcaUorKZtzE+5I1
	iismuxnskL3XbAVIRacSxdrlkJzjxKgUikqiueDRSuogAyVOVjI1pKF3aWqqaY5k3KE3n7Ur1et
	P76mNyGzjMze0Qv9PpJ8uCqI/y+d9p6ar+PdDI/2yzM4u2SS+r+JPq5agmoGyPNksotG1I=
X-Received: by 2002:a17:90b:2e47:b0:34a:b8fc:f1d8 with SMTP id
 98e67ed59e1d1-3543b3e3a6amr10303423a91.37.1770005282654; Sun, 01 Feb 2026
 20:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
 <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com> <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
In-Reply-To: <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 1 Feb 2026 23:07:51 -0500
X-Gm-Features: AZwV_Qj0ZPr30GBIZpy2KTBmQCeMzIbAaQJB4ILIbQRznBk2H145kQkQiYyOBUA
Message-ID: <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
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

On Sat, Jan 31, 2026 at 1:01=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/01/31 6:56, Paul Moore wrote:
> > On Wed, Jan 28, 2026 at 5:28=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> On 2026/01/28 6:59, Paul Moore wrote:
> >>> It sounds like we either need to confirm that
> >>> security_xfrm_{policy,state}_delete() is already present in all code
> >>> paths that result in SPD/SAD deletions (in a place that can safely
> >>> fail and return an error),
> >>
> >> Yes.
> >
> > To clarify, do you mean "yes, I agree", or "yes, I've already checked
> > this and can confirm that the LSM hooks are already being called"?
>
> I mean "yes, I agree".
>
> >
> >>>                            or we need to place
> >>> xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
> >>> safely fail.
> >>
> >> Did you mean xfrm_{policy,state}_flush_secctx_check() ?
> >
> > They both call into the security_xfrm_policy_delete() LSM hook which
> > is what I care about as that hook is what authorizes the operation.
>
> I can't understand what your authorization is.

I'm asking you to verify that we have the LSM xfrm hooks in all of the
necessary locations to ensure that we are safely and comprehensively
gating all of the operations that result in removal of SPD and SAD
entries.

> No authorization can be placed during must-not-fail operation.

Of course, but that means that we simply need to make sure we have the
authorization hooks placed elsewhere to ensure that users can not
remove SPD and SAD entries if they are not allowed.  I'm not arguing
about if returning an error in a place that can not handle an error
condition is correct or not, I'm arguing that you should audit the SPD
and SAD removal code paths to ensure that they all have the proper LSM
xfrm hook authorizations.

--=20
paul-moore.com
