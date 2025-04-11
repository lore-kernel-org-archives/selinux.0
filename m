Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7335202C50
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398585; cv=none; b=FP0V8767qSRr17uECNsN07N/QmsncB33Bw45o3MLmZoV0CZ+2XzKcnepZvvgI0T2fbupqItpL7Bol1n0/11x7aHOl8iJxiPAi7FfmJMtq4lUxQS38DhJJmAwNt0TK/6Di8hYcLHJxADfhO2SAmYWgJyS5HGd62lkjGxyEyr2W4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398585; c=relaxed/simple;
	bh=DQkYz0ix1NIVjAO6ds9zXD8EGanb4XzIpQZEQU4Lnss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkMyPB18zK5bulZEyM9lXBCLyV3anruT7KKip9/IFe9lCjeVLPAWyAq4xpos5KdZZ8021St+HQRhtz9yv6h7HZuKXV+u+iM0sb1Oid935uW5jg/DESlX8dizcfs+JErvk6jdoOcAlCIIHc6+fHAi7J94C3EAPXDsZnfWnNF1nXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwQyQGhg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwQyQGhg"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c55500d08cso212285685a.0
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 12:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744398582; x=1745003382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmoYGtWuPkLumm23eNMuMppYlvjP1cRMcS+NhtcXa50=;
        b=IwQyQGhg5bMUbM/9muS48kWg93WI3cj1IjEoRmRA6ufrytSb+EPF/+924P45BfcEwU
         5SEQn/r4vbkUqtZBVIiwdHSBYHpKXZwpH4lPQOrJ5xELWmkd36qRlMwrM5ub+tozca5m
         dm3oZQ9r+8h/DYM2ploqujTbDaRKdWrazxIIe4Q2gLhz6Za5cMlGNkijkoKk1Dq7EQWo
         BHSMK0CMdRmCdIDnKKYSBV8GJzmjKinCvScXRW8IhF/L9Fqp6HxLrbUwsL/lSWwHst1k
         sy4wNG6bTYi0ymMb+MAUU8xpjE+0Sbk4Ikrsg8PbdLnlJ05cgEa0qt7UawJ9Ia1JMoHE
         +G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744398582; x=1745003382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmoYGtWuPkLumm23eNMuMppYlvjP1cRMcS+NhtcXa50=;
        b=kH0PMalCI3VK/du2J4AKB+vmYPe5Qbaeh8JMODzYltIqopm+eE3tVxlAFSK8hLlGPi
         Yhu0Wn9i+GQl7mMHJ924cSa3mFvpQefGKIhflrrg7xGZa70p4IZPMVb1x6gNkrVvhna+
         X+fWzAwXh6k/Ecj73CMoSn5/1npB4DAvmxg2FqqiCJKqweuj7t1YAvBTjB4ggNmE0MYs
         gmGxM2EylCo7oDgeSAodyIFgpRkb81GqCqxL7UgdDpmhGxrjXM9npdrwxkCoxPW+WI6a
         RBQo4AIwkuZokFL12/NiJJWEBVDsRjJ5MKgyhYtRAG68aSqd2QzCGPRfWJ1ZfZnEHqAI
         /eRA==
X-Gm-Message-State: AOJu0YwyJKjJzR7o2lM7M2hXcMjbfVC3B/4c6deaEvaAS+fDGq3OF2pA
	fljYVWjVeWXpM+XXsZOqREx//fDjdhecu0pm8+hEVVw4qHeY1i6LcyjLtgUHc5HVYrCllBj10CH
	6C71YPtDDsVBFtfCEE15gmn8XKj8=
X-Gm-Gg: ASbGncsfeZb//y2hgTvup789hUijiqTR0C5H5t9ZzVzjsjLeOYq8gYqUKl17ZLCX66z
	NER9F08w9jvSnzzbhYAgHSQdDjPATGv7QiHuElVZRI929UjjOAVX6onUb2h1A1ni+2lohtKlci5
	PlIVYeJSXEmq6owGQ0xjY=
X-Google-Smtp-Source: AGHT+IFg0J9Lb37wvYjMRjj6S2wsHzhmuWQHoEqbyxOxGcehjnSBzGZibW7O3XTJgGgh517rPfWN7FQQ7kvIgCsGusw=
X-Received: by 2002:a05:620a:28d5:b0:7c0:a3bd:a78a with SMTP id
 af79cd13be357-7c7af1f3d4emr533024985a.41.1744398582531; Fri, 11 Apr 2025
 12:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405164557.107583-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250405164557.107583-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 11 Apr 2025 15:09:31 -0400
X-Gm-Features: ATxdqUHWviQPNJ28IGCUYDty-9zxOhHtVfqrQ7NLeQTR4pmj8mZ52vrrH-pfRN4
Message-ID: <CAP+JOzR57B8kaqsX4dZORSt5WrO9iatgFxKZ6sKrg91VUFe+cw@mail.gmail.com>
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

I understand using "(void)", but what is the purpose of "(void)!" here?

Thanks,
Jim


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
