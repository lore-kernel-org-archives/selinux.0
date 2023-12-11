Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf6Zz+SI"
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4D39F
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 12:41:55 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c701bd9a3cso894686a12.0
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702327315; x=1702932115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33t2g+/gUkd+7OlI6NoESbBIyjIFqJqqsI+NlZRd3GI=;
        b=mf6Zz+SIdhpbJuGH7JX93zUvGs3nQMjcgZ91pzPQ2FyqMDTL67GeULs8PRpIdDb/1C
         xAzGQJq1/D78S5yNdhvyzJ2oQdpdS05raFVZklZ8s36fL2UYsluHBxqa3Q9ltsX3hSQM
         Hfxm1dgNZQp1BKd9uh8jULSpi4qb22FF+fVUb2CB5xgLMMza11/4hrYPqUqt8WoaMzYq
         R4mh+oB3ePhsNmyzhESTsb+CBlkdD3GA3U7wHcKkjHw0a9NOYgAbQJ2EZ6OXa1ftD0Zg
         l6zQqR9bFdLe4p0AgSxZRVp1buiJL39A2pXlZHHSjIVdk6wueXPgyWKYAN6U7vBH0m1Y
         G9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327315; x=1702932115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33t2g+/gUkd+7OlI6NoESbBIyjIFqJqqsI+NlZRd3GI=;
        b=Bbsig+tzI+Z2mqiLy9ySYWa6Kq7v6Hvg6mOsnu8ykQtSo605pxdZW9LL4tEmwllecr
         OBsMRChSlu8+xB5fwtIOHzwXpQbSBFYP+/uemqj4xaDNkw7WnsI/WEeyW4FC0gXHH/wZ
         BcO8B5vbv/9+D4JoNnZHc8bvnRKz4NoMOw/uVAzg6+bpWk7oMLzSs4ALxxL9HCkhLxGu
         ChZa3yNif+DMu+lOcQlOeMLgHXGBU01EYnLDJZZLLksDpl25mKWJJnDWLTnCcepx1I6U
         Golrp/NYErPj7ZWPn9xm/ovrDRcEFXuBGccmBAXMalah/QzwI9rj0FyKR2qwfRrBnG8L
         bKSg==
X-Gm-Message-State: AOJu0Yya0GPJK4tVI7pSAMilQ9yWJjkVF/zDj1c6semsUHml+GlJTBTg
	I/cby5zgswrMk6sPq1p/FhDhcrxC4GGryFvw5v4=
X-Google-Smtp-Source: AGHT+IFQOeuNwIQGFGJSGXBX5U9K920sfHB/Aoh794Is5Ivph7gijv/iN3O99q8XrtqIOdXynnQ27osxobEg9pN298Q=
X-Received: by 2002:a05:6a20:3d89:b0:190:72d0:d13a with SMTP id
 s9-20020a056a203d8900b0019072d0d13amr2441824pzi.77.1702327315277; Mon, 11 Dec
 2023 12:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211145408.124757-1-cgzones@googlemail.com> <CAP+JOzS+CAydQ=bhw5L8TUb2TXzp-EX20b3C6EDKQOv++MYVnQ@mail.gmail.com>
In-Reply-To: <CAP+JOzS+CAydQ=bhw5L8TUb2TXzp-EX20b3C6EDKQOv++MYVnQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 11 Dec 2023 15:41:43 -0500
Message-ID: <CAEjxPJ4y7XFk5o08BoVw8hxrLv-go-fgNh1Bqhz4Eh7sVwnm6Q@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol: handle long permission names in sepol_av_to_string()
To: James Carter <jwcart2@gmail.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 12:07=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Dec 11, 2023 at 9:54=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use a growing dynamically allocated buffer to format permission names o=
f
> > an access vector instead of a fixed static buffer to support very long
> > permission names.
> >
> > This changes the behavior of the since libsepol 3.4 exported function
> > sepol_av_perm_to_string(): previously it returned a pointer to a static
> > buffer which must not be free'd by the caller, now an allocated string
> > which should be free'd by the caller (to avoid memory leaks).
> >
> > Reported-by: oss-fuzz (issue 64832, 64933)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> I like this patch and would like to merge it, but it does change an
> exported function (by removing const on the return type).
> As far as I know, the only thing that uses the function externally is
> sepol_compute_av in libsepol/utils and the function has only been
> exported since 2022, so I doubt there would be any harm in making the
> change. But I am still hesitant to make the change.
>
> What is the best way to handle this?

Hmm...there is a reason why this and other libsepol functions were not
exported in the first place, not sure why that changed.

There is no real good way. Options are:
1. Change it without touching .so version and hope nothing breaks.
Don't see any usage in Debian code search but one never knows.
2. Change it and bump the LIBVERSION to reflect an incompatible
change. Seems like that should be batched with other longstanding
desired incompatible changes if done that way.
3. Use per-symbol versioning to auto-magically redirect the caller to
the old or new implementation based on the version against which they
were compiled. Seems like that has caused us grief in the past.
4. Don't change it.
