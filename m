Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA022425B
	for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950889; cv=none; b=AirtQawEemjOukUJzLomWMa5wef8Bv22RBFDoFe58lnp+QtffPyl8Tio3jeGz1u2oruPg9UpSOCiumCHsB+NUFXar8V4p2bZaZSpxdn50z1ewjk94MaEwFDtZUyM++JWwzWG5jajVlVQUbhD84KXgVCGXlFUCEa7ftS81uxVn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950889; c=relaxed/simple;
	bh=qXhanpL+DK2WbdhWgqSJLD1CMqNGLtc5qG4llyV7dp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGALDcJATVK+Q3hE7Xs+adGCwFqRxN6Cp1qzcpzP/SMbLDPxDdEDumDGk7KJKVAd5OXJOCixBGSwY9UImqwgwXc9hRUsx7gffWqistsv/jdHmX6M5HES+jCzAJBV03kvrBcl8/xtFzV1u1IQuvObxpAfg7if6ZsUrATWYX79QhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=btRRtqFp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="btRRtqFp"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3219ffcada9so1321483a91.3
        for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950887; x=1755555687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXdnb41bcMRYFaefBcCIWWyf9vYxHasNkQCzWhItBkQ=;
        b=btRRtqFp9k1+3KHuadN8gK06YGLKpjW0+GWFyE9XG1iqlTQ16dWPQsFMmp51ph97Gj
         dLwIiXpomEM44yjpyqMmDrEv4P3wjNHXIYW6cGkpDaJt/NKkVf8AqZoieUypJT2i/UIh
         FriZsMf4aVn6qbLqdrEhohLz1rCS8ggHux2ODerie5ayBFWaS50j/EAqaLZj1aOLqcad
         XeYbY6PtgZpCRy8xnD0CFzH0MaFNaYaCzvcvkzFmDqQauEGA0Uu7fEj4huf6/5yCOzLA
         KlJb3aoG3F3DEp7WxAQxAi299lp1OJW51AUAGcvGJ+MdIoVSgb1gIWOzIOge6W2IRrdG
         xKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950887; x=1755555687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXdnb41bcMRYFaefBcCIWWyf9vYxHasNkQCzWhItBkQ=;
        b=cH/NOARLHDTln0JK+qohsqPxxOVyEiXbr4GKHM5c8Lw3rKuEXTX24UYd4vVt3BEwaC
         M/aPx66o4VDEp7cQ1S/8GQhJGLByuTy508kG/IeTCrqbS2hfMF1LBlw8LbSmF6RM1JbV
         k+v5HKclu7gSFVFbyIm6mYmgv5YgBmPJnHFwxGk7SFFxdYmjqca+UsR3LhYIwNgpWlMc
         moKtiFkmZSOUHJ8xjztuMGeyxpKugNhfpWdpcMd+Q2LD9f8jCTQkboH66glKNvtQxqFT
         jDdxiBVf3R5klz+lLh9ztwrJUOtB2EcHb4Do+dToGUqb4MMw7fQjEaiiR20Ywz3ScAr3
         pPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0ylx4Sut30vjH01XBEi64bdtNdDTjDbmhZdQEZ5U8/BXhH+vZjwYJQ0a6kefBkVIxdxaS8Olm@vger.kernel.org
X-Gm-Message-State: AOJu0YzkswQaMn6+DQGFfsBNHZdVMtkk11YcrnuVYdbgUB4cLfkp+/uo
	a9mVDlQ7x2JSltZUwlamwvvfM1MWgi8O8xpZRI9B/8l7wAfyPl+BndYJES+lkQzoH8JbKF+lkac
	JtYtnjTssnpAHn6aPuHuoNyPzBWyd4Kxcw4HfQ//H
X-Gm-Gg: ASbGncsnj8aSGcJorw+z21cDIAjaP4qh5XBGmwnVfXpRAcxKufLjkleAvpdGsJHpngZ
	DFhZmXTxqztUVLQY1f9rjo2AxK1DYaTU5d/ndfMo34BtIkDpmhb98Kyg9WQ8vJ3G2xyCUdLmCSD
	Kc6TTWe1dfa0WBGbXZGYfCSJ2Tknc2uwV5EEVMD8cZ67VYnKfm9nZvp4FGr0vFXk28TtycXqQLi
	X3WcVLo1u6/7XPgqA==
X-Google-Smtp-Source: AGHT+IEss2X+BEVYoSZIRFPMdBMIECB9EsuPm1/5BEpb7wMtfKbuhIPqkxFcGxZboN3KJZ7oj0OWy4xB2RyQ2dN40eo=
X-Received: by 2002:a17:90a:dfc4:b0:321:6ac:532b with SMTP id
 98e67ed59e1d1-321c0b3493dmr1670945a91.35.1754950886988; Mon, 11 Aug 2025
 15:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716212731.31628-5-casey@schaufler-ca.com>
 <d5f0d7a5edea8511ab4467e0fb225b8b@paul-moore.com> <4f6c9294-dfb3-45cf-8f46-c1a0063d2921@schaufler-ca.com>
In-Reply-To: <4f6c9294-dfb3-45cf-8f46-c1a0063d2921@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:21:14 -0400
X-Gm-Features: Ac12FXyMjcnxuMYwY6jL1gdJPw-g9F2DzMGA2F70iCe8j7vzY4irDpbe-2aJOKM
Message-ID: <CAHC9VhR-Jd8JGhEETSBLDQA843FtsyN+ocM1XjfA_A6g+tJeng@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] Audit: Fix indentation in audit_log_exit
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: eparis@redhat.com, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 7:06=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 8/5/2025 12:39 PM, Paul Moore wrote:
> > On Jul 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Fix two indentation errors in audit_log_exit().
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  kernel/auditsc.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> > As this is indepdendent of all the other changes in this patchset, I'm
> > going to merge this into audit/dev-staging now and audit/dev later when
> > the merge window is closed.
>
> Spiffy. Thank You.

... and now it's in audit/dev, thanks!

--=20
paul-moore.com
