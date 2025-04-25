Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE61F8676
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601929; cv=none; b=Vt6P4VfhyrzJd6C72g5agSmz9bjeFtUrBGZ3zU2vcX/qLmbCqEK+/Hu+KTOjG/j4odJhYUrI6Tnjxsp1JPKdE+QmNj9S5SqtX5voTjmrHh5yXv/q8Z0UOdBIIMbGvB7kUPJag3XbEZULE2aUgA8euqsKBu8bEcNXpE+Y757nOcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601929; c=relaxed/simple;
	bh=7SVh2qKKBcgVbje4NfG/iRq9zDL7b+K+KtvByDPv798=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7bGJoK5iJw7+m+yiGsOWnBsY6/SRTJ64O0JLDUv/qxSsn/Etr0mOWcWGTMD5k6BFEumvBm+8BQGS8qu1dhVqf5SQUEC43Fbn+B+oOouceLgMHecwN+p7PFttZh1ZztELxia9rrNDY2pMd8vqiIY3gBfHBHGfBgErlVswd0Ydvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTW3LYwe; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTW3LYwe"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523d8c024dfso1066089e0c.3
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745601927; x=1746206727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2D0EwnIqAUvvCNSt9Kj0q3KNGEqRNXZvUg6oTFyjRg=;
        b=ZTW3LYwegvvKy+yVwTKt3+JhZNtcTd3e9sjAgpHBWmgYHVuHSsVAS6XS9UgyUNsRvD
         tBQOGzgdo7sXj4b7F0F0XByIOWN9gtTH7AqZF9m0SCMOAdts7e7656Bd+83D5j5YfzU+
         fiykNB86vELtloa3xNUGg0jDaSyceufPxtn6ROz0PeFXWC3uv/Vb/0Tb2YokCR7qi//o
         woai3ugIMthliBx4TORFYDJZa2LAhHjMxX8mtpgX1xy51fmYhZGEPl/UmbF+jtEtYwcu
         98huzb4UyjZRRNEtYp+x9FxEp+XDZWjh/606birIl2pUJLC+JIWoaE6Zow/3m7+hqAqS
         Rm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745601927; x=1746206727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2D0EwnIqAUvvCNSt9Kj0q3KNGEqRNXZvUg6oTFyjRg=;
        b=f/UsJ/L6/SA2hcLEVP+swaRaHNz6NxIe8rDIKXJRhF7xdkCRJ/9Wzb+zmHAyZl3PNE
         gUpqAX4N8784woD28a/ShGn8DSEPOuMs6SxWkwZRqKBWFdDZrlO+Wi7L0NezbzXrZGO+
         RG8Eu0J0Dsk8M2D7NoEcV+HFcHaN7VzL00HPuTuMMVF/9CPyC4W8JzYRutz7yKUn3GIx
         0Z9U+qfhZwkk6QGrKVtNtLTavJpLoI52hbRRhDd7XgcDQVOExbqBP9pL5P0U6LtXtJYf
         r3n73b/6cIgjuJkupzokHNPshITwixGFo/4VIj/Pu/hyN0f4smkm6vmxb06zCphnDP2B
         LRtw==
X-Gm-Message-State: AOJu0YzgOAQyvR+7v8QH5Ih2xUtlYfnY5hAYdwiiPGpIp2Cpg8sONxGk
	dqY8hbhBr71fm6EopkSedPLlkeQd+JDup0H1Z/06SOUKqVEHLDUmAuZnZEg2pQKrUwXlAriJLW6
	EkYL0dvU5DGojndDCROldUMB263Sv0g==
X-Gm-Gg: ASbGncsmQkbIVkGf699WA06sNqs0lLD385Qhpi89Vm0ucAQt0h0lEMGPwdi1WFGQFRz
	3DlGwvlWJGuVD7FYcqd3wjAsh/948Hzqy1D3jPsHjqm0dtcuK1yyCyzMUFfxpGLYavdHRlYU7xI
	aZ7K3pbFpQOSItjOJvQoM=
X-Google-Smtp-Source: AGHT+IE1M8KYIq06KyMt9MkVx6eTCTUN56FVejgX8LC6+/ZTSWjiIBNjxu97N04got/RDDCnRajeuifoe/Aty2AmIYs=
X-Received: by 2002:a05:6122:3185:b0:520:5e9b:49b2 with SMTP id
 71dfb90a1353d-52a96fe0d89mr176193e0c.3.1745601926483; Fri, 25 Apr 2025
 10:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405164557.107583-1-cgoettsche@seltendoof.de> <CAP+JOzRqXnysm3m1rDNTs=LEzpWRxX_vQ_omNEgnmSMsQfep4g@mail.gmail.com>
In-Reply-To: <CAP+JOzRqXnysm3m1rDNTs=LEzpWRxX_vQ_omNEgnmSMsQfep4g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 25 Apr 2025 13:25:15 -0400
X-Gm-Features: ATxdqUGQHz4qKpQcLiSAyAwDBoUdUIVjLT2bMSyoF0BE5pmi6y0Wqf_FCggHyJ4
Message-ID: <CAP+JOzSNB+-2TtfZuP9+iv3Xy1ABgfgEfGB5Qqg71S2XSsZ3_g@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix handling errors during child execution
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 10:50=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Sat, Apr 5, 2025 at 12:55=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > * Continue on pipe handling errors in parent to wait on the child and
> >   collect possible error messages from it
> > * Always exit on errors in child, do not return from function
> > * Improve error reporting in semanage_compile_module() by hiding local
> >   errno value and stripping duplicate newline
> > * Use redirected stderr file descriptor in child error handling
> >
> > With these changes execution failures change from
> >
> >     libsemanage.semanage_pipe_data: Failed to write data to input pipe.=
 (Broken pipe).
> >     libsemanage.semanage_direct_commit: Failed to compile hll files int=
o cil files. (Broken pipe).
> >     /usr/sbin/semodule:  Failed!
> >
> > to
> >
> >     libsemanage.semanage_pipe_data: Failed to write data to input pipe.=
 (Broken pipe).
> >     libsemanage.semanage_pipe_data: Child process /usr/libexec/selinux/=
hll2//pp failed with code: 1. (No data available).
> >     libsemanage.semanage_compile_module: accountsservice: libsemanage.s=
emanage_pipe_data: Unable to execute /usr/libexec/selinux/hll2//pp. (No suc=
h file or directory)..
> >     libsemanage.semanage_direct_commit: Failed to compile hll files int=
o cil files. (No data available).
> >     /tmp/destdir//usr/sbin/semodule:  Failed!
> >
> > Improves: 76cdfa78 ("libsemanage: introduce write_full wrapper")
> > Fixes: cae4a4c9 ("libsemanage: add support for HLL to CIL compilers")
> > Related: https://github.com/SELinuxProject/selinux/issues/467
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/direct_api.c | 79 +++++++++++++++++++++++++-----------
> >  1 file changed, 55 insertions(+), 24 deletions(-)
> >
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.=
c
> > index 99cba7f7..d9540d53 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -621,6 +621,23 @@ static int read_from_pipe_to_data(semanage_handle_=
t *sh, size_t initial_len, int
> >         return 0;
> >  }
> >
> > +// Forward error messages to redirected stderr pipe
> > +#define ERR_CHILD_STDERR(handle, ...) \
> > +       { \
> > +               char buf[2048]; \
> > +               int errsv =3D errno, n; \
> > +               (void)! write_full(err_fd[PIPE_WRITE], "libsemanage.sem=
anage_pipe_data: ", strlen("libsemanage.semanage_pipe_data: ")); \
> > +               n =3D snprintf(buf, sizeof(buf), __VA_ARGS__); \
> > +               (void)! write_full(err_fd[PIPE_WRITE], buf, n); \
> > +               if (errsv) { \
> > +                       errno =3D errsv; \
> > +                       n =3D snprintf(buf, sizeof(buf), " (%m)."); \
> > +                       (void)! write_full(err_fd[PIPE_WRITE], buf, n);=
 \
> > +               } \
> > +               (void)! write_full(err_fd[PIPE_WRITE], "\n", strlen("\n=
")); \
> > +               (void)! fsync(err_fd[PIPE_WRITE]); \
> > +       }
> > +
> >  static int semanage_pipe_data(semanage_handle_t *sh, const char *path,=
 const char *in_data, size_t in_data_len, char **out_data, size_t *out_data=
_len, char **err_data, size_t *err_data_len)
> >  {
> >         int input_fd[2] =3D {-1, -1};
> > @@ -672,97 +689,100 @@ static int semanage_pipe_data(semanage_handle_t =
*sh, const char *path, const cha
> >                 retval =3D dup2(input_fd[PIPE_READ], STDIN_FILENO);
> >                 if (retval =3D=3D -1) {
> >                         ERR(sh, "Unable to dup2 input pipe.");
> > -                       goto cleanup;
> > +                       goto child_err;
> >                 }
> >                 retval =3D dup2(output_fd[PIPE_WRITE], STDOUT_FILENO);
> >                 if (retval =3D=3D -1) {
> >                         ERR(sh, "Unable to dup2 output pipe.");
> > -                       goto cleanup;
> > +                       goto child_err;
> >                 }
> >                 retval =3D dup2(err_fd[PIPE_WRITE], STDERR_FILENO);
> >                 if (retval =3D=3D -1) {
> >                         ERR(sh, "Unable to dup2 error pipe.");
> > -                       goto cleanup;
> > +                       goto child_err;
> >                 }
> >
> >                 retval =3D close(input_fd[PIPE_WRITE]);
> >                 if (retval =3D=3D -1) {
> > -                       ERR(sh, "Unable to close input pipe.");
> > -                       goto cleanup;
> > +                       ERR_CHILD_STDERR(sh, "Unable to close input pip=
e.");
> > +                       goto child_err;
> >                 }
> >                 retval =3D close(output_fd[PIPE_READ]);
> >                 if (retval =3D=3D -1) {
> > -                       ERR(sh, "Unable to close output pipe.");
> > -                       goto cleanup;
> > +                       ERR_CHILD_STDERR(sh, "Unable to close output pi=
pe.");
> > +                       goto child_err;
> >                 }
> >                 retval =3D close(err_fd[PIPE_READ]);
> >                 if (retval =3D=3D -1) {
> > -                       ERR(sh, "Unable to close error pipe.");
> > -                       goto cleanup;
> > -               }
> > -               retval =3D execl(path, path, NULL);
> > -               if (retval =3D=3D -1) {
> > -                       ERR(sh, "Unable to execute %s.", path);
> > -                       _exit(EXIT_FAILURE);
> > +                       ERR_CHILD_STDERR(sh, "Unable to close error pip=
e.");
> > +                       goto child_err;
> >                 }
> > +               execl(path, path, NULL);
> > +               ERR_CHILD_STDERR(sh, "Unable to execute %s.", path);
> > +
> > +child_err:
> > +               _exit(EXIT_FAILURE);
> >         } else {
> > +               int any_err =3D 0;
> > +
> >                 retval =3D close(input_fd[PIPE_READ]);
> >                 input_fd[PIPE_READ] =3D -1;
> >                 if (retval =3D=3D -1) {
> >                         ERR(sh, "Unable to close read end of input pipe=
.");
> > -                       goto cleanup;
> > +                       any_err =3D 1;
> >                 }
> >
> >                 retval =3D close(output_fd[PIPE_WRITE]);
> >                 output_fd[PIPE_WRITE] =3D -1;
> >                 if (retval =3D=3D -1) {
> >                         ERR(sh, "Unable to close write end of output pi=
pe.");
> > -                       goto cleanup;
> > +                       any_err =3D 1;
> >                 }
> >
> >                 retval =3D close(err_fd[PIPE_WRITE]);
> >                 err_fd[PIPE_WRITE] =3D -1;
> >                 if (retval =3D=3D -1) {
> >                         ERR(sh, "Unable to close write end of error pip=
e.");
> > -                       goto cleanup;
> > +                       any_err =3D 1;
> >                 }
> >
> >                 retval =3D write_full(input_fd[PIPE_WRITE], in_data, in=
_data_len);
> >                 if (retval =3D=3D -1) {
> >                         ERR(sh, "Failed to write data to input pipe.");
> > -                       goto cleanup;
> > +                       any_err =3D 1;
> >                 }
> >                 retval =3D close(input_fd[PIPE_WRITE]);
> >                 input_fd[PIPE_WRITE] =3D -1;
> >                 if (retval =3D=3D -1) {
> >                         ERR(sh, "Unable to close write end of input pip=
e.");
> > -                       goto cleanup;
> > +                       any_err =3D 1;
> >                 }
> >
> >                 initial_len =3D 1 << 17;
> >                 retval =3D read_from_pipe_to_data(sh, initial_len, outp=
ut_fd[PIPE_READ], &data_read, &data_read_len);
> >                 if (retval !=3D 0) {
> > -                       goto cleanup;
> > +                       any_err =3D 1;
> >                 }
> >                 retval =3D close(output_fd[PIPE_READ]);
> >                 output_fd[PIPE_READ] =3D -1;
> >                 if (retval =3D=3D -1) {
> >                         ERR(sh, "Unable to close read end of output pip=
e.");
> > -                       goto cleanup;
> > +                       any_err =3D 1;
> >                 }
> >
> >                 initial_len =3D 1 << 9;
> >                 retval =3D read_from_pipe_to_data(sh, initial_len, err_=
fd[PIPE_READ], &err_data_read, &err_data_read_len);
> >                 if (retval !=3D 0) {
> > -                       goto cleanup;
> > +                       any_err =3D 1;
> >                 }
> >                 retval =3D close(err_fd[PIPE_READ]);
> >                 err_fd[PIPE_READ] =3D -1;
> >                 if (retval =3D=3D -1) {
> >                         ERR(sh, "Unable to close read end of error pipe=
.");
> > -                       goto cleanup;
> > +                       any_err =3D 1;
> >                 }
> >
> > +               errno =3D ENODATA;
> >                 if (waitpid(pid, &status, 0) =3D=3D -1 || !WIFEXITED(st=
atus)) {
> >                         ERR(sh, "Child process %s did not exit cleanly.=
", path);
> >                         retval =3D -1;
> > @@ -773,6 +793,11 @@ static int semanage_pipe_data(semanage_handle_t *s=
h, const char *path, const cha
> >                         retval =3D -1;
> >                         goto cleanup;
> >                 }
> > +
> > +               if (any_err) {
> > +                       retval =3D -1;
> > +                       goto cleanup;
> > +               }
> >         }
> >
> >         retval =3D 0;
> > @@ -934,9 +959,13 @@ static int semanage_compile_module(semanage_handle=
_t *sh,
> >                                     hll_contents.len, &cil_data, &cil_d=
ata_len,
> >                                     &err_data, &err_data_len);
> >         if (err_data_len > 0) {
> > +               int errsv =3D errno;
> > +
> > +               errno =3D 0;
> > +
> >                 for (start =3D end =3D err_data; end < err_data + err_d=
ata_len; end++) {
> >                         if (*end =3D=3D '\n') {
> > -                               ERR(sh, "%s: %.*s.", modinfo->name, (in=
t)(end - start + 1), start);
> > +                               ERR(sh, "%s: %.*s.", modinfo->name, (in=
t)(end - start), start);
> >                                 start =3D end + 1;
> >                         }
> >                 }
> > @@ -944,6 +973,8 @@ static int semanage_compile_module(semanage_handle_=
t *sh,
> >                 if (end !=3D start) {
> >                         ERR(sh, "%s: %.*s.", modinfo->name, (int)(end -=
 start), start);
> >                 }
> > +
> > +               errno =3D errsv;
> >         }
> >         if (status !=3D 0) {
> >                 goto cleanup;
> > --
> > 2.49.0
> >
> >
