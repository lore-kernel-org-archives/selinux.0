Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78074EAC7
	for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727589; cv=none; b=OcQXl0yRVjUGFbt34e8TcDGeWN9H1/KhqLXPy/mnJPdQTPgeED1Ts3cZRCL68IsAMnSh3f/496KXGbh7rWeNIrIJBYjN4IE9q0teSq24DEdfpo4u6refFUY/uC6AxRGqo0TQhLAkohBqlgf2QsK9xyWZWQ3NsFmQcYrItZkam0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727589; c=relaxed/simple;
	bh=WDjQUW99dHTzgc6CuI9NKJkvZJTSqWbb6QipV7OWZ1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMPY1mg1DPtHUBxNWvoUISrNa78ux4ij8nE893VSwtsrQvk9qGP1RI94lAjiISGNSs9Vs1aSpzYLcE3H4UotghxYmzKM+oKYwRKWb6N30A1Y9+bH5OVX34enplpVgHPEgZzMjMB8XOv/uYwfFIHX3YUL81NbzpsbrZbQlE13elQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hv84+OaT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hv84+OaT"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70427fb838cso51158337b3.2
        for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744727586; x=1745332386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQb+LwXxZjcSfcaUg6MxfDDirgi43Vg5VFm9cRjamoM=;
        b=hv84+OaTLnScoEUv1OtwytXomTjayyxFkwIydFYgO+SKXlQ9U87vRfbxJxrBGrjWBV
         0+iiT5cNq0pm/F/WmsVt1FGJ7HmHI21+KiTiD1nrWAckwKlPoGY0WnFAQVCaSDOYXQUy
         TeguRvWklgNqzpnVtFVadpS/EAlFd+2nU855dhgky4Hrwk2oK6Y+qOPVWQLikjXKaLYp
         nSYX+6UI038AQbMUu4UWYrQf7DZ+NnHk13D3usJcy7FInxUjgqhGl8yFDdGWyczYLNU3
         NFyHXXCokF/NNfTanIILMkVSRn8HJIlzQDzquXLDozI7lM1E88uC9aCXTcQlpSezICOm
         VVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744727586; x=1745332386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQb+LwXxZjcSfcaUg6MxfDDirgi43Vg5VFm9cRjamoM=;
        b=HDjCRk13ls5yRMEUYpQfQamTvFW9eWVK9SB/lkY1xx8AEyjXy5yACVEj07G4LnUgGs
         ZMyM35jB3O5RGzYcfdTdmImeFCaIUh7Adss6ldbgFpqSaxg8u4MrTlebpal4THCRbuXH
         GoAGESIo+d1+NczKRqWb4G0jl1e/5NKOk5fvlS7BN434zDApGytaNLZbunvUxW2/Q9BA
         sqius++nmbJVmwAfsrPJaN3l7mnDrSKmH9z1G/wuuFgMuZhvAW1nHfVGOkAAMYpeShYo
         zU5OsKKh1vz6SEYMlzhE91ljkxhx/VfoZ121vqNwgdYUSrWzWh/+CLT6xVFte6CAgzho
         2SdQ==
X-Gm-Message-State: AOJu0YyqiRdlQjE7h+RWI8qE8H71QfUGvPKrHh7AMXjn87V42gLdTHuS
	ji+HOA8ZOmwSOxmDA64Aw3hSnAOtnXZuREF7kgcxNSDkUsD6zbJpkJ6NI0jdy4qYUxUwJV7DETL
	SikojgwPFMCYzAfDltqM2vBJBeAs=
X-Gm-Gg: ASbGncsneZpFyXcAZSQD0P16wVANwU8TxvHuShOCddDVeqYPkeQCf9rJF6VDQsDy571
	tnTZE8uVp7iP5ZuWUCQ9nuJOx3Ri48HzYagUFUw/SJNB87qqkORain2TGqjgwa92Jky/3/6CyZM
	/1H5Pcdy2J1LewzgvC2PcmGrc=
X-Google-Smtp-Source: AGHT+IG2NPuM2Y6jynO8qsF3XuKJcEMiTP3mIY9Sg762pz/RimiqfelbIXYJOIZOTWScyecjGpCJVR8CPPHntTUoe0k=
X-Received: by 2002:a05:690c:6381:b0:6fb:b8a1:d3bb with SMTP id
 00721157ae682-705599f91d1mr277896717b3.17.1744727586170; Tue, 15 Apr 2025
 07:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405164557.107583-1-cgoettsche@seltendoof.de> <CAP+JOzR57B8kaqsX4dZORSt5WrO9iatgFxKZ6sKrg91VUFe+cw@mail.gmail.com>
In-Reply-To: <CAP+JOzR57B8kaqsX4dZORSt5WrO9iatgFxKZ6sKrg91VUFe+cw@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 15 Apr 2025 16:32:54 +0200
X-Gm-Features: ATxdqUET5eKIo7RzN2nZOU3B4nqK2Wauk5ExQF31C62fbuv3y7iW0IR8b6txGqI
Message-ID: <CAJ2a_Dd9z9HVWZPH91cG3akczwGpZjRcoYQ5U_hdXJ=JLaSc8Q@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix handling errors during child execution
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Apr 2025 at 21:09, James Carter <jwcart2@gmail.com> wrote:
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
>
> I understand using "(void)", but what is the purpose of "(void)!" here?

GCC might otherwise still report an unused return warning, see
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D66425#c34

> Thanks,
> Jim
>
>
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
