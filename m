Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AmNTi/bU"
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19851A2
	for <selinux@vger.kernel.org>; Tue,  5 Dec 2023 14:44:48 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso4527322276.1
        for <selinux@vger.kernel.org>; Tue, 05 Dec 2023 14:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701816288; x=1702421088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE8Ie1YddKL2vZyVO2vSMNIUff0Tstkw8r1lK9PBuKE=;
        b=AmNTi/bUmFDyvqazXxiD9AyNeDSEk6CKTgv8cqWKjf5p29V+OocaYsQPInN1+VDmnK
         xjMsaZLrtWtKTZchZDsimYkFRXJDJ3oRzIW2p4iVD1QSUh1G3xlsiIVvcTRCV7fQe+6K
         r046uID6rejsJSvKgHV9KqIUPlCAvikmlA4zakrQWyr+Xha2PLJANcdpQPSSZHsMBoD1
         5WmgpzLHrj47XkmSsMvvg5JXIm7DAG2unb6AsiacKIXRIHj/gBOZC+1MSc3Z66WBMTMv
         NGxnmOw1gXcdafhfoP8wLXv+WeaK1JPniFGHZWdHzTDmYEj+VKvrtzByfH1jLPo5khqM
         gGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701816288; x=1702421088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE8Ie1YddKL2vZyVO2vSMNIUff0Tstkw8r1lK9PBuKE=;
        b=jvb21pzxk23fSsaPP4r3T379zFbaAnvpQPqdkRe4zKARBi4sNEazqUpa3wRRG7uqFv
         uz4kAYiY/3eFvA1QllZGqnZLDxA/2hh/NYLMvfUNGhDWsJld0kHklRl9iGo3Fxm5jTuI
         RBo9BWKyBTUsXPnXSgAoKwf+gHxwocoWOLTfZ5iyYsKW06L8f1EIUWe3ikElgvIx1bep
         7CGi2vm7gzenLTq9HR2GlhkydBgkxUZ5xKjvl+NJRsT5fivxdNAU8c0PnTq0uAX1Y5wf
         BZ/wYWx2gouqFFCIWMboqpkR2CYjWAkvlW64t3VqlYh830w36Xm7JBwmYJAOzsPxY45F
         6Xbg==
X-Gm-Message-State: AOJu0YxrBxlwVcoSgEDmPJTfgf5TaApt8svMXk4gSNEzHl8IK3i7Zudx
	7IP5GUt4w0BPIO2NozmWmwtZaoNu9Gqwu9eTmEWAgWdQ49VR1PhCjA==
X-Google-Smtp-Source: AGHT+IHNm+Dc+ME5+de4qXVztlGhWyjJzrFytiWZlQLn1mFTAfjMtFZSY5+vJfmZwXj6faMPd8LZ9hk++Ma4IIacHcA=
X-Received: by 2002:a25:10c4:0:b0:db9:7c23:434f with SMTP id
 187-20020a2510c4000000b00db97c23434fmr2235630ybq.12.1701816288108; Tue, 05
 Dec 2023 14:44:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130084453.970742-1-kamatam@amazon.com>
In-Reply-To: <20231130084453.970742-1-kamatam@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Dec 2023 17:44:37 -0500
Message-ID: <CAHC9VhS_WyFXN=4mqb+K92kx1YutnJcuuO8VdtRZNA1aJzziBA@mail.gmail.com>
Subject: Re: [PATCH] selinux: bring the comment about multithreaded process
 handling back
To: Munehisa Kamata <kamatam@amazon.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 3:45=E2=80=AFAM Munehisa Kamata <kamatam@amazon.com=
> wrote:
>
> Since commit d9250dea3f89 ("SELinux: add boundary support and thread
> context assignment"), SELinux has been supporting assigning per-thread
> security context under a constraint and the comment was updated
> accordingly. However, seems like commit d84f4f992cbd ("CRED: Inaugurate
> COW credentials") accidentally brought the old comment back that doesn't
> match what the code does.
>
> This just brings the updated comment back and does nothing else.
>
> Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> ---
>  security/selinux/hooks.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 855589b64641..d147f8ac9d9d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6459,7 +6459,12 @@ static int selinux_setprocattr(const char *name, v=
oid *value, size_t size)
>                 if (sid =3D=3D 0)
>                         goto abort_change;
>
> -               /* Only allow single threaded processes to change context=
 */
> +               /*
> +                * SELinux allows to change context in the following case=
 only.
> +                *  - Single threaded processes.
> +                *  - Multi threaded processes intend to change its conte=
xt into
> +                *    more restricted domain (defined by TYPEBOUNDS state=
ment).
> +                */

Hi Munehisa, good catch :)

Considering the ease of understanding the code below (the naming makes
it pretty obvious what the functions do), I think I'd rather see the
wrong comment simply removed with nothing added back to replace it.
Does that sound good to you, and if so would you mind sending an
updated patch?

>                 if (!current_is_single_threaded()) {
>                         error =3D security_bounded_transition(tsec->sid, =
sid);
>                         if (error)
> --
> 2.40.1

--=20
paul-moore.com
