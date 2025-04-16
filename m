Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCAD1946C8
	for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815072; cv=none; b=hK8cVYClv4xHqUDJZEvIDpBN3wjGmz2s9+tvEc/n9i7Rvxa6XIXgxS+kle1ZRy89aC5AVJ2E/mSKzajZuJdtkSHsL+zJqsv9bMlc4Vm0fSCW1oOBzgKZ7IDK8Edn3AfxZTHzg/SlSqNMSuK1C+u4vbeMV5hWXXAnA2/bV3gvEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815072; c=relaxed/simple;
	bh=Dp5O10qwg3Q09DcSVvSvzObR67I7DMKQeoW/4wW3/8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUlrSgWgExwRkUGZNr7XwnBEjXDbY/fgIHuvjiutmKmqhbCAPSl+thYxjl7wroeuBRuVpVLrC6zozTltdoaTMUmMQtKG7DYN9SbalECwOTLaq2z74HfK8mfw1K7fYU11jcLlFj4BcZtCYhgCd+avQ7Qjo1II3GY4u17+lNVbVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlfoYM3F; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlfoYM3F"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d6ac4d5a9so2751524241.1
        for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744815070; x=1745419870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo1wMxTEq2yO9TE8sWWT5o43ht6JO4pMacYpqT2rEAg=;
        b=GlfoYM3Fjh+SlkAZ7EFW2raO+0q+3H/klsKNz/tGdchMRTggpSbkDHjbRcIQrqy0OT
         y82TkqjS5D5HyLnl5WsQw44t2Xp3dx/0Cyb2ZrYmB7zGbZm94z9LxD9Fm06kxd5ysoFD
         ErH+ImlAk57EnB2GnRJmO64CYpHQfwOrpBlK3SWtHBpc6zM8ADHWD7oB4BeVG+cDZ/kN
         doDuHFlBi46ETbb+V/TyvVbJTZLHrT8unNmarUHShPuOtX0wMeeVfV4yVn2Gl93PoPLa
         2FK4C4oAP4g4TkgCNSZGNvE+fIJEDJMuDKkwSFUPWPNIMUYE89QTGGrZPsAJDPr9YBln
         d7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744815070; x=1745419870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jo1wMxTEq2yO9TE8sWWT5o43ht6JO4pMacYpqT2rEAg=;
        b=lbsEhobbAJhrUw3UlCjmQK/xZr36CbGKmuIh9UdI/DGv2Drb6aEH4kVBIaE8N2SwLn
         FHGorzprj+VYkBI2sHbLPt86r3Pt1xYyeMNHLu1o7mKDiVpJgkBVJorhboOlOqQQZmVx
         OThQEVhOfrA+omHoqFIbO5XFJyKA6smBsGP8uisdYfyjOEAbQdqqZCQwKNev9D5t7LPH
         bl9iXOnwFXkz9dnD3u/RjREbEI8rtclZSkAtd4h4VL28tbNrty4EUcBEsuL3gEOUjsuk
         VFQzkWXWDFhZ9WxU0AvEHs7n9j3my6L5PecmHyAGBrzH12GQ7Yu/gYpNIcRmaApQd2Lw
         jiQA==
X-Gm-Message-State: AOJu0YwsKIdNaO2h6D5Z+AfzJfLZ9Zz3ETkW0vPS6s8G41mJ4uTOYv71
	CUnYr2WxxQ7KwGhVhDfx1EKUrH8NaPrQt7D6Q4aEDP2+ET4B3nB1kS/AB7RMSXDuZy/HMlb8lHi
	4EkYdBj5IYaQR0xf4sstRHtOu3YNoICsC
X-Gm-Gg: ASbGncsoTK49LbcHRI6EhjcVv/yC0yFzM2tIw1tqJsCH5o4j0r7ZLIfxwBDoMmLAXxj
	46Jl0vJQGVG6q1jNpLocunAtlGOn9F2hpkdUlZEpBAB4D3ofjJv9QxwhCzNSCXWdjl+q3TZ/MUk
	3ZE69wnX8xrULAAiHCTbE=
X-Google-Smtp-Source: AGHT+IH0+hrZQZZ70gAn9WOQ1jTncS9NSZ7y5zcH3aqxIpdOVtaGEir0j+QdANrw2n8WGyAl6w6zipz1rX+zNEoz4AM=
X-Received: by 2002:a05:6102:36d6:b0:4c3:6393:843f with SMTP id
 ada2fe7eead31-4cb5918fcd1mr1031787137.5.1744815069774; Wed, 16 Apr 2025
 07:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405164557.107583-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250405164557.107583-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 16 Apr 2025 10:50:59 -0400
X-Gm-Features: ATxdqUFz4QbPkwBHlWX1xZzC91pdcUbIIZu-rlrFtzI51YMgnP1JWCvJft2_0X4
Message-ID: <CAP+JOzRqXnysm3m1rDNTs=LEzpWRxX_vQ_omNEgnmSMsQfep4g@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix handling errors during child execution
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 12:55=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> * Continue on pipe handling errors in parent to wait on the child and
>   collect possible error messages from it
> * Always exit on errors in child, do not return from function
> * Improve error reporting in semanage_compile_module() by hiding local
>   errno value and stripping duplicate newline
> * Use redirected stderr file descriptor in child error handling
>
> With these changes execution failures change from
>
>     libsemanage.semanage_pipe_data: Failed to write data to input pipe. (=
Broken pipe).
>     libsemanage.semanage_direct_commit: Failed to compile hll files into =
cil files. (Broken pipe).
>     /usr/sbin/semodule:  Failed!
>
> to
>
>     libsemanage.semanage_pipe_data: Failed to write data to input pipe. (=
Broken pipe).
>     libsemanage.semanage_pipe_data: Child process /usr/libexec/selinux/hl=
l2//pp failed with code: 1. (No data available).
>     libsemanage.semanage_compile_module: accountsservice: libsemanage.sem=
anage_pipe_data: Unable to execute /usr/libexec/selinux/hll2//pp. (No such =
file or directory)..
>     libsemanage.semanage_direct_commit: Failed to compile hll files into =
cil files. (No data available).
>     /tmp/destdir//usr/sbin/semodule:  Failed!
>
> Improves: 76cdfa78 ("libsemanage: introduce write_full wrapper")
> Fixes: cae4a4c9 ("libsemanage: add support for HLL to CIL compilers")
> Related: https://github.com/SELinuxProject/selinux/issues/467
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/direct_api.c | 79 +++++++++++++++++++++++++-----------
>  1 file changed, 55 insertions(+), 24 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 99cba7f7..d9540d53 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -621,6 +621,23 @@ static int read_from_pipe_to_data(semanage_handle_t =
*sh, size_t initial_len, int
>         return 0;
>  }
>
> +// Forward error messages to redirected stderr pipe
> +#define ERR_CHILD_STDERR(handle, ...) \
> +       { \
> +               char buf[2048]; \
> +               int errsv =3D errno, n; \
> +               (void)! write_full(err_fd[PIPE_WRITE], "libsemanage.seman=
age_pipe_data: ", strlen("libsemanage.semanage_pipe_data: ")); \
> +               n =3D snprintf(buf, sizeof(buf), __VA_ARGS__); \
> +               (void)! write_full(err_fd[PIPE_WRITE], buf, n); \
> +               if (errsv) { \
> +                       errno =3D errsv; \
> +                       n =3D snprintf(buf, sizeof(buf), " (%m)."); \
> +                       (void)! write_full(err_fd[PIPE_WRITE], buf, n); \
> +               } \
> +               (void)! write_full(err_fd[PIPE_WRITE], "\n", strlen("\n")=
); \
> +               (void)! fsync(err_fd[PIPE_WRITE]); \
> +       }
> +
>  static int semanage_pipe_data(semanage_handle_t *sh, const char *path, c=
onst char *in_data, size_t in_data_len, char **out_data, size_t *out_data_l=
en, char **err_data, size_t *err_data_len)
>  {
>         int input_fd[2] =3D {-1, -1};
> @@ -672,97 +689,100 @@ static int semanage_pipe_data(semanage_handle_t *s=
h, const char *path, const cha
>                 retval =3D dup2(input_fd[PIPE_READ], STDIN_FILENO);
>                 if (retval =3D=3D -1) {
>                         ERR(sh, "Unable to dup2 input pipe.");
> -                       goto cleanup;
> +                       goto child_err;
>                 }
>                 retval =3D dup2(output_fd[PIPE_WRITE], STDOUT_FILENO);
>                 if (retval =3D=3D -1) {
>                         ERR(sh, "Unable to dup2 output pipe.");
> -                       goto cleanup;
> +                       goto child_err;
>                 }
>                 retval =3D dup2(err_fd[PIPE_WRITE], STDERR_FILENO);
>                 if (retval =3D=3D -1) {
>                         ERR(sh, "Unable to dup2 error pipe.");
> -                       goto cleanup;
> +                       goto child_err;
>                 }
>
>                 retval =3D close(input_fd[PIPE_WRITE]);
>                 if (retval =3D=3D -1) {
> -                       ERR(sh, "Unable to close input pipe.");
> -                       goto cleanup;
> +                       ERR_CHILD_STDERR(sh, "Unable to close input pipe.=
");
> +                       goto child_err;
>                 }
>                 retval =3D close(output_fd[PIPE_READ]);
>                 if (retval =3D=3D -1) {
> -                       ERR(sh, "Unable to close output pipe.");
> -                       goto cleanup;
> +                       ERR_CHILD_STDERR(sh, "Unable to close output pipe=
.");
> +                       goto child_err;
>                 }
>                 retval =3D close(err_fd[PIPE_READ]);
>                 if (retval =3D=3D -1) {
> -                       ERR(sh, "Unable to close error pipe.");
> -                       goto cleanup;
> -               }
> -               retval =3D execl(path, path, NULL);
> -               if (retval =3D=3D -1) {
> -                       ERR(sh, "Unable to execute %s.", path);
> -                       _exit(EXIT_FAILURE);
> +                       ERR_CHILD_STDERR(sh, "Unable to close error pipe.=
");
> +                       goto child_err;
>                 }
> +               execl(path, path, NULL);
> +               ERR_CHILD_STDERR(sh, "Unable to execute %s.", path);
> +
> +child_err:
> +               _exit(EXIT_FAILURE);
>         } else {
> +               int any_err =3D 0;
> +
>                 retval =3D close(input_fd[PIPE_READ]);
>                 input_fd[PIPE_READ] =3D -1;
>                 if (retval =3D=3D -1) {
>                         ERR(sh, "Unable to close read end of input pipe."=
);
> -                       goto cleanup;
> +                       any_err =3D 1;
>                 }
>
>                 retval =3D close(output_fd[PIPE_WRITE]);
>                 output_fd[PIPE_WRITE] =3D -1;
>                 if (retval =3D=3D -1) {
>                         ERR(sh, "Unable to close write end of output pipe=
.");
> -                       goto cleanup;
> +                       any_err =3D 1;
>                 }
>
>                 retval =3D close(err_fd[PIPE_WRITE]);
>                 err_fd[PIPE_WRITE] =3D -1;
>                 if (retval =3D=3D -1) {
>                         ERR(sh, "Unable to close write end of error pipe.=
");
> -                       goto cleanup;
> +                       any_err =3D 1;
>                 }
>
>                 retval =3D write_full(input_fd[PIPE_WRITE], in_data, in_d=
ata_len);
>                 if (retval =3D=3D -1) {
>                         ERR(sh, "Failed to write data to input pipe.");
> -                       goto cleanup;
> +                       any_err =3D 1;
>                 }
>                 retval =3D close(input_fd[PIPE_WRITE]);
>                 input_fd[PIPE_WRITE] =3D -1;
>                 if (retval =3D=3D -1) {
>                         ERR(sh, "Unable to close write end of input pipe.=
");
> -                       goto cleanup;
> +                       any_err =3D 1;
>                 }
>
>                 initial_len =3D 1 << 17;
>                 retval =3D read_from_pipe_to_data(sh, initial_len, output=
_fd[PIPE_READ], &data_read, &data_read_len);
>                 if (retval !=3D 0) {
> -                       goto cleanup;
> +                       any_err =3D 1;
>                 }
>                 retval =3D close(output_fd[PIPE_READ]);
>                 output_fd[PIPE_READ] =3D -1;
>                 if (retval =3D=3D -1) {
>                         ERR(sh, "Unable to close read end of output pipe.=
");
> -                       goto cleanup;
> +                       any_err =3D 1;
>                 }
>
>                 initial_len =3D 1 << 9;
>                 retval =3D read_from_pipe_to_data(sh, initial_len, err_fd=
[PIPE_READ], &err_data_read, &err_data_read_len);
>                 if (retval !=3D 0) {
> -                       goto cleanup;
> +                       any_err =3D 1;
>                 }
>                 retval =3D close(err_fd[PIPE_READ]);
>                 err_fd[PIPE_READ] =3D -1;
>                 if (retval =3D=3D -1) {
>                         ERR(sh, "Unable to close read end of error pipe."=
);
> -                       goto cleanup;
> +                       any_err =3D 1;
>                 }
>
> +               errno =3D ENODATA;
>                 if (waitpid(pid, &status, 0) =3D=3D -1 || !WIFEXITED(stat=
us)) {
>                         ERR(sh, "Child process %s did not exit cleanly.",=
 path);
>                         retval =3D -1;
> @@ -773,6 +793,11 @@ static int semanage_pipe_data(semanage_handle_t *sh,=
 const char *path, const cha
>                         retval =3D -1;
>                         goto cleanup;
>                 }
> +
> +               if (any_err) {
> +                       retval =3D -1;
> +                       goto cleanup;
> +               }
>         }
>
>         retval =3D 0;
> @@ -934,9 +959,13 @@ static int semanage_compile_module(semanage_handle_t=
 *sh,
>                                     hll_contents.len, &cil_data, &cil_dat=
a_len,
>                                     &err_data, &err_data_len);
>         if (err_data_len > 0) {
> +               int errsv =3D errno;
> +
> +               errno =3D 0;
> +
>                 for (start =3D end =3D err_data; end < err_data + err_dat=
a_len; end++) {
>                         if (*end =3D=3D '\n') {
> -                               ERR(sh, "%s: %.*s.", modinfo->name, (int)=
(end - start + 1), start);
> +                               ERR(sh, "%s: %.*s.", modinfo->name, (int)=
(end - start), start);
>                                 start =3D end + 1;
>                         }
>                 }
> @@ -944,6 +973,8 @@ static int semanage_compile_module(semanage_handle_t =
*sh,
>                 if (end !=3D start) {
>                         ERR(sh, "%s: %.*s.", modinfo->name, (int)(end - s=
tart), start);
>                 }
> +
> +               errno =3D errsv;
>         }
>         if (status !=3D 0) {
>                 goto cleanup;
> --
> 2.49.0
>
>
