Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li5HViEW"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756BFB0
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 08:44:03 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bf37fd2bbso7836341e87.0
        for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 08:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702399441; x=1703004241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+ojP/dIR+4v+HmnKEp4jHQ4nuMVuSHGfemoRobBt9I=;
        b=li5HViEW1wL0VBlz0W5UvTNQ3OSQKw00eWCsev5SRKfoXOAUN91o1pdw2OM0uK0RPk
         eN6D2wVTKVCt14kqAj0lOFjI0g3k1kCcIpju6K1qoNlYJdijg8Y6E/zfjxSMDY9BiNXy
         2IazcbjvsJmdD98aeIRfOSGV+2Z+twP4Ala17DXlWBucYvSmFLK2toQ6/QlsuMSwl11T
         VI2fUJFQcfrfo6B1ev4dtIEEJshm+RBdEALsP+1vBHC0PgGYQAJBMPu1f92Z+DoURqKI
         gIL4NjTRa9cHLJ/x1Ceq96zVQANYJk8nkrKgr/gBrRqa4qeCOTzyQi2QyMtatmV4iV7M
         oVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399441; x=1703004241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+ojP/dIR+4v+HmnKEp4jHQ4nuMVuSHGfemoRobBt9I=;
        b=USFm+X65YR0nHTu2uiiAHwSxa2pQYRhTAcxMrX594bBj/s67Q/UotoCVOLoTwdJifv
         hVNFKKn/XOJlsiKXoPpp4LzsvIpmXuHZL8cPOjlsKTThY8rnLVrlqF/FnOYNjBKDoLkR
         ez2bCuzn4ryzD/rpQZwICv43B6/ZYvBcNaQz5busgehlNAiDOE8kzc5UQo+ds+2nul7x
         J+zgpqcIvMDZ7CF27m1yKimABE3+bf+94w4VDqM0cPi7FLUajtem0MHySmWGIZXoFCf9
         BDNUuSZVo6KvoWpp0HusRBZvNib7JARjhAmF3A4QfZxnqymjt9Z+Ggo2MVgSDfBJNReY
         WHdw==
X-Gm-Message-State: AOJu0YxPdxiNu5B8OD+BjTQkR0sfmcNPLMrPgT51Ypez+XZKydzJqxc+
	m0me9CKAdKPzzFcWGWp8ZOS3rqPq3oQJhQ1nwrI24bFw
X-Google-Smtp-Source: AGHT+IEmtus6V9NbkrXZBEYqKRR/kzzbgUA5vUHqUepXVO961+Olz/cOb9HDF1ZBmhbIvhwmW94c2Anej2QisLJwrLU=
X-Received: by 2002:a05:6512:130b:b0:50d:f857:2e9d with SMTP id
 x11-20020a056512130b00b0050df8572e9dmr3079283lfu.57.1702399441333; Tue, 12
 Dec 2023 08:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211144827.121636-1-cgzones@googlemail.com> <CAP+JOzRcTCL2yqk6PTJrvvc+116+o763voETrrcqDkNvO2KQ7A@mail.gmail.com>
In-Reply-To: <CAP+JOzRcTCL2yqk6PTJrvvc+116+o763voETrrcqDkNvO2KQ7A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 Dec 2023 11:43:49 -0500
Message-ID: <CAP+JOzT-bmDzZ5HvHw3+POXFZmovC4cheah37S5fB++BHi0uVA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: constify tokenized input
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:49=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Dec 11, 2023 at 9:48=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The input string to be tokenized is not modified.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/include/sepol/policydb/util.h | 2 +-
> >  libsepol/src/util.c                    | 9 +++++----
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/=
sepol/policydb/util.h
> > index db8da213..4ea5a346 100644
> > --- a/libsepol/include/sepol/policydb/util.h
> > +++ b/libsepol/include/sepol/policydb/util.h
> > @@ -40,7 +40,7 @@ char *sepol_extended_perms_to_string(avtab_extended_p=
erms_t *xperms);
> >   * The tokenize function may be used to
> >   * replace sscanf
> >   */
> > -extern int tokenize(char *line_buf, char delim, int num_args, ...);
> > +extern int tokenize(const char *line_buf, char delim, int num_args, ..=
.);
> >
> >  #ifdef __cplusplus
> >  }
> > diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> > index 2f877920..571f6c93 100644
> > --- a/libsepol/src/util.c
> > +++ b/libsepol/src/util.c
> > @@ -221,9 +221,9 @@ err:
> >   */
> >
> >  /* Read a token from a buffer */
> > -static inline int tokenize_str(char delim, char **str, char **ptr, siz=
e_t *len)
> > +static inline int tokenize_str(char delim, char **str, const char **pt=
r, size_t *len)
> >  {
> > -       char *tmp_buf =3D *ptr;
> > +       const char *tmp_buf =3D *ptr;
> >         *str =3D NULL;
> >
> >         while (**ptr !=3D '\0') {
> > @@ -273,9 +273,10 @@ static inline int tokenize_str(char delim, char **=
str, char **ptr, size_t *len)
> >   * contain the remaining content of line_buf. If the delimiter is any =
whitespace
> >   * character, then all whitespace will be squashed.
> >   */
> > -int tokenize(char *line_buf, char delim, int num_args, ...)
> > +int tokenize(const char *line_buf, char delim, int num_args, ...)
> >  {
> > -       char **arg, *buf_p;
> > +       char **arg;
> > +       const char *buf_p;
> >         int rc, items;
> >         size_t arg_len =3D 0;
> >         va_list ap;
> > --
> > 2.43.0
> >
> >
