Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F53EFD1F
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902618; cv=pass; b=jKYXCKHFPHnUzx8Z3mJyleV9IJGplCyt1RrZUnJbPjAeiWNP4AAbOaa6w4yAIKYJBfR+cGgeVPm63niM8kUbS1p/plE6Y6rHdMzYxhiE1/gRArvw4+cFVTK3dbgVnvdEu97HcVjGb7PLt0aVWctX3cDOCl0Se0j3qpaTJx7zA5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902618; c=relaxed/simple;
	bh=QnBkQeSbB2zsfe/77HTzvBi16PLqKwVQ8YYcp65Uuq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZ3wQD6W1D7ymylAJZcEtquQh5v2f2oXGY9WRQKETghzGqSr0Xzmz50aweirNPRAb8Km1RDBfD2DUPCKlWTbT4Uvk7hAtWDe0NMbSA3mjotTxwsT5bADjr6rertGX4/GmzlcGclkYW/kNDrGvlZRenkSLiACB9zugh+AXziSnzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB2yb+bi; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB2yb+bi"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-456395f4e7bso251856fac.0
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784902615; cv=none;
        d=google.com; s=arc-20260327;
        b=IlV9XUW6t7+8C1bafTqFGafG9n8efKwdG2WBbIUCQ1HmMN9jiviac7bCjWn2Rb1lfI
         TutivsAeH3xj82S9iUmVs1/eMut1wB6eQRHUxPMQa8eOt1f+ob3ARWTJOoR6TrhBNzO4
         QHO62deod7lqE5vy0mrOLkM2NNj2bLoZRvpsOPlofu+g3njMFkbRdnpqQAaJxS4+3VtI
         1qLTPbblyKdQVLTLQKT6alo99AaRRqlPxunzE8J9egICLpz2oKLgFVRN4dMuFsqn0MaY
         5gfjwdKftrLiHjEsuxpoMkaqjswjEN//vMuw9n+UpIvo8w4UcYtPHWVkWdfAtxkHzprG
         RWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p4FFz/dz97Q746/U8iyKME+/QZjMwNqVTySTIsAU8ow=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=ZobewUWa8/ppii2qFwxDk2kFnuzZSyv98fNSH+iru0pvZiq+fEvFVuWnOSJw26CPIo
         ceqhaXLM6pJ5FGLpbM1k56hRnoRLhFrkNGDVd1IP0CGzJVGq9JCjvhgA9JyUykvsI8jS
         n/GkvCxQTOJti2SSVQ1B4/oGYnmnuEoM0Hb7jzaK3sJbGk00ckYYXoUMPMbmzVv9K4ya
         KdnKZBULVid3YM5jX2qnAqyszCvDptJDnv9up7ShB8+jd5VZZQmVWnN5R4FS8pgT+cmF
         AAWiB+xv8tZ+IcA/qn2GHpY7I6NaBqDnNVCbsz1e1H0LhTpuobsZ5Te30ym3SOTPgcD/
         Aq4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784902615; x=1785507415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p4FFz/dz97Q746/U8iyKME+/QZjMwNqVTySTIsAU8ow=;
        b=AB2yb+biIcuZ4kuz4i7btE5Qd1C9v8b4pMN8b1ZyRkEHoV/gHB0wAt5REpQQwruaeY
         FlN/PZ1ZsaKst2b0O0tG74NB6x6Ook81a9xNhW/2HX09wehF284KoJY/GtxjBnNv4lJM
         B+L9dzHTu0n9XrV+wGSbSYFuTzGGGpnhj/0ERR1uwNQzM7sNbSJ8wt4aqQXX+FJggAFU
         88oa6j6RahOsXRcP5rV7Fz0dewT3GVS9b4xjic2jIuIMDAEitrVNpKVxmgBWWaLot3HK
         CEfS8ffCKbCoudDbcr8ZR21Qrvsjb5rxVxEy81LalnXl+qugVbnA/RnxInQz2HjiFU4V
         MKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784902615; x=1785507415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p4FFz/dz97Q746/U8iyKME+/QZjMwNqVTySTIsAU8ow=;
        b=fuxLvEM2gMRDNyxPQwO2XUWNKqhNCdYYR76Gvt/DPn/SjrfXZOa01ONq460snvMtmr
         OGce7Sch4owbBh/indYmIYo8RjK3fnvFIu8SMoUZDDM8m+ebeTc6Po9oumVuIGugFJgB
         j3jp2nzgrKb4WP5WqIhxP06eBg9hLDZJtunuPHE7CDZaPD60v3vc27yFyeEihbHKFJa4
         70GQfsQJyOx6IQc6AtqMtpN9Ur8ZScmTbV7oYmw/1Ya1aOHn7MjC7JBu4bw0TRIWF25+
         U2bJw7XFpC+emf+WGeaLXSXeF+s16PN/YEM0Zk9Z0NmWxf+p+dsQ/NpiBezglvIX3t0q
         8nYQ==
X-Gm-Message-State: AOJu0Yz2s085UCKjlp/rBkkio8BkMK7OGjHHPr/hVwwbS7fA85yyokn6
	k/LE93Ij0Gubp3vbzvcs/NwzyLL1psqbWsz3eMS/CuvjFQG4B3RSSmw51KyrC3CZKUiGZ/fT/iS
	fnrg0Iumwtk9fexsi95b3ytI3Cu42sN2RbQ==
X-Gm-Gg: AR+sD12AltyHmUnCaVDlx49xhTunKbdZQD6CtDjRc9lMPWdh5P+zrAkQ2ZMV5ly9KSc
	EbXj87ys80sDtHmEfdlW6HtxlCL8snj3CCDjX3cKDSXUgy5PV0usSNCTjG2VhgngX/D+EH2AgC+
	wtgwG/WznJVkEnDhjVaj5a5WCIphOP1cMRLpniZBfip8hE+8w+nPw3ObvuaLEooBe101qxgEW/r
	OlGZHWptdy86+CTPuG/0x0jel1OSAhuzV91ZNTb9Dt5fRuLk8NP3UZfOfE+ubixn+ix8umq
X-Received: by 2002:a05:6870:e091:b0:447:2ad0:b36 with SMTP id
 586e51a60fabf-457a104d41emr4710184fac.20.1784902614985; Fri, 24 Jul 2026
 07:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720182909.46833-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260720182909.46833-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:16:43 -0400
X-Gm-Features: AUfX_myB4TvTwsnvolYyg-GPONuIpXPq3sJ-yb6crpYKBszRuzWL3Z3rsd1pu-0
Message-ID: <CAEjxPJ4bgogdVYNfiQ9bbxAzNbv2cgZTtt5n=6h++zUiJc4tdg@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: semanage_pipe_data(): multiplex the
 compiler pipes
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 2:29=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The parent writes the entire input to the compiler's stdin, then
> drains stdout to EOF, then drains stderr. If the child writes more
> than a pipe buffer to a stream the parent is not yet reading, both
> sides block. With hll/pp the input phase is safe (fp_to_buffer()
> drains stdin before any output), but sepol_module_package_to_cil() can
> emit stderr warnings while writing CIL to stdout, so a module that
> produces enough warnings fills the stderr pipe and semodule -i
> hanges. A streaming HLL that writes diagnostics while reading would
> deadlock in the input phase too.
>
> Replace the serial write/read with a poll() loop over all three pipes,
> feeding input while draining stdout and stderr as they become
> ready. read_from_pipe_to_data() is folded into an incremental append
> helper.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
> v2 fixing the formatting.
>
>  libsemanage/src/direct_api.c | 191 +++++++++++++++++++++++------------
>  1 file changed, 124 insertions(+), 67 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 6c84b23c..132e2a2a 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -27,6 +27,7 @@
>  #include <assert.h>
>  #include <fcntl.h>
>  #include <libgen.h>
> +#include <poll.h>
>  #include <stdio.h>
>  #include <stdio_ext.h>
>  #include <stdlib.h>
> @@ -565,48 +566,135 @@ cleanup:
>         return retval;
>  }
>
> -static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_=
len,
> -                                 int fd, char **out_data_read,
> -                                 size_t *out_read_len)
> +static int append_read(semanage_handle_t *sh, int fd, char **buf, size_t=
 *len,
> +                      size_t *cap)
>  {
> -       size_t max_len =3D initial_len;
> -       ssize_t read_len;
> -       size_t data_read_len =3D 0;
> -       char *data_read =3D NULL;
> +       ssize_t r;
>
> -       if (max_len <=3D 0) {
> -               max_len =3D 1;
> +       if (*len =3D=3D *cap) {
> +               ssize_t ncap;
> +               char *tmp;
> +
> +               if (__builtin_mul_overflow(*cap ? *cap : 4096, 2, &ncap))=
 {
> +                       ERR(sh, "Overflow");
> +                       return -1;
> +               }
> +               tmp =3D realloc(*buf, ncap);
> +               if (!tmp) {
> +                       ERR(sh, "Out of memory.");
> +                       return -1;
> +               }
> +               *buf =3D tmp;
> +               *cap =3D ncap;
>         }
> -       data_read =3D malloc(max_len * sizeof(*data_read));
> -       if (data_read =3D=3D NULL) {
> -               ERR(sh, "Failed to malloc, out of memory.");
> +
> +       r =3D read(fd, *buf + *len, *cap - *len);
> +       if (r < 0) {
> +               if (errno =3D=3D EINTR || errno =3D=3D EAGAIN)
> +                       return 1;
> +               ERR(sh, "Failed to read from pipe.");
>                 return -1;
>         }
> +       if (r =3D=3D 0)
> +               return 0;
> +       *len +=3D (size_t)r;
> +       return 1;
> +}
> +
> +static int pump_pipes(semanage_handle_t *sh, int in_fd, int out_fd, int =
err_fd,
> +                     const char *in_data, size_t in_len, char **out_data=
,
> +                     size_t *out_len, char **err_data, size_t *err_len)
> +{
> +       size_t in_off =3D 0, out_cap =3D 0, err_cap =3D 0;
> +       int rc =3D 0;
> +
> +       *out_data =3D NULL;
> +       *out_len =3D 0;
> +       *err_data =3D NULL;
> +       *err_len =3D 0;
> +
> +       while (in_fd >=3D 0 || out_fd >=3D 0 || err_fd >=3D 0) {
> +               struct pollfd pfd[3];
> +
> +               int n =3D 0, i_in =3D -1, i_out =3D -1, i_err =3D -1;
> +
> +               if (in_fd >=3D 0) {
> +                       pfd[n].fd =3D in_fd;
> +                       pfd[n].events =3D POLLOUT;
> +                       i_in =3D n++;
> +               }
> +               if (out_fd >=3D 0) {
> +                       pfd[n].fd =3D out_fd;
> +                       pfd[n].events =3D POLLIN;
> +                       i_out =3D n++;
> +               }
> +               if (err_fd >=3D 0) {
> +                       pfd[n].fd =3D err_fd;
> +                       pfd[n].events =3D POLLIN;
> +                       i_err =3D n++;
> +               }
> +
> +               if (poll(pfd, n, -1) < 0) {
> +                       if (errno =3D=3D EINTR)
> +                               continue;
> +                       ERR(sh, "poll() failed.");
> +                       rc =3D -1;
> +                       break;
> +               }
> +
> +               if (i_in >=3D 0 && (pfd[i_in].revents & (POLLOUT | POLLER=
R))) {
> +                       ssize_t w =3D
> +                               write(in_fd, in_data + in_off, in_len - i=
n_off);
> +                       if (w < 0) {
> +                               if (errno !=3D EINTR && errno !=3D EAGAIN=
) {
> +                                       ERR(sh,
> +                                           "Failed to write to input pip=
e.");
> +                                       rc =3D -1;
> +                                       close(in_fd);
> +                                       in_fd =3D -1;
> +                               }
> +                       } else {
> +                               in_off +=3D (size_t)w;
> +                               if (in_off =3D=3D in_len) {
> +                                       close(in_fd);
> +                                       in_fd =3D -1;
> +                               }
> +                       }
> +               }
>
> -       while ((read_len =3D read(fd, data_read + data_read_len,
> -                               max_len - data_read_len)) > 0) {
> -               data_read_len +=3D read_len;
> -               if (data_read_len =3D=3D max_len) {
> -                       char *tmp;
> -                       if (__builtin_mul_overflow(max_len, 2, &max_len))=
 {
> -                               ERR(sh, "Overflow");
> -                               free(data_read);
> -                               return -1;
> +               if (i_out >=3D 0 &&
> +                   (pfd[i_out].revents & (POLLIN | POLLHUP | POLLERR))) =
{
> +                       int r =3D append_read(sh, out_fd, out_data, out_l=
en,
> +                                           &out_cap);
> +                       if (r <=3D 0) {
> +                               if (r < 0)
> +                                       rc =3D -1;
> +                               close(out_fd);
> +                               out_fd =3D -1;
>                         }
> -                       tmp =3D realloc(data_read, max_len);
> -                       if (tmp =3D=3D NULL) {
> -                               ERR(sh, "Failed to realloc, out of memory=
.");
> -                               free(data_read);
> -                               return -1;
> +               }
> +
> +               if (i_err >=3D 0 &&
> +                   (pfd[i_err].revents & (POLLIN | POLLHUP | POLLERR))) =
{
> +                       int r =3D append_read(sh, err_fd, err_data, err_l=
en,
> +                                           &err_cap);
> +                       if (r <=3D 0) {
> +                               if (r < 0)
> +                                       rc =3D -1;
> +                               close(err_fd);
> +                               err_fd =3D -1;
>                         }
> -                       data_read =3D tmp;
>                 }
>         }
>
> -       *out_read_len =3D data_read_len;
> -       *out_data_read =3D data_read;
> +       if (in_fd >=3D 0)
> +               close(in_fd);
> +       if (out_fd >=3D 0)
> +               close(out_fd);
> +       if (err_fd >=3D 0)
> +               close(err_fd);
>
> -       return 0;
> +       return rc;
>  }
>
>  // Forward error messages to redirected stderr pipe
> @@ -649,7 +737,6 @@ static int semanage_pipe_data(semanage_handle_t *sh, =
const char *path,
>         char *err_data_read =3D NULL;
>         int retval;
>         int status =3D 0;
> -       size_t initial_len;
>         size_t data_read_len =3D 0;
>         size_t err_data_read_len =3D 0;
>         struct sigaction old_signal;
> @@ -747,46 +834,16 @@ child_err:
>                         any_err =3D 1;
>                 }
>
> -               retval =3D write_full(input_fd[PIPE_WRITE], in_data, in_d=
ata_len);
> -               if (retval =3D=3D -1) {
> -                       ERR(sh, "Failed to write data to input pipe.");
> -                       any_err =3D 1;
> -               }
> -               retval =3D close(input_fd[PIPE_WRITE]);
> +               retval =3D pump_pipes(sh, input_fd[PIPE_WRITE],
> +                                   output_fd[PIPE_READ], err_fd[PIPE_REA=
D],
> +                                   in_data, in_data_len, &data_read,
> +                                   &data_read_len, &err_data_read,
> +                                   &err_data_read_len);
>                 input_fd[PIPE_WRITE] =3D -1;
> -               if (retval =3D=3D -1) {
> -                       ERR(sh, "Unable to close write end of input pipe.=
");
> -                       any_err =3D 1;
> -               }
> -
> -               initial_len =3D 1 << 17;
> -               retval =3D read_from_pipe_to_data(sh, initial_len,
> -                                               output_fd[PIPE_READ],
> -                                               &data_read, &data_read_le=
n);
> -               if (retval !=3D 0) {
> -                       any_err =3D 1;
> -               }
> -               retval =3D close(output_fd[PIPE_READ]);
>                 output_fd[PIPE_READ] =3D -1;
> -               if (retval =3D=3D -1) {
> -                       ERR(sh, "Unable to close read end of output pipe.=
");
> -                       any_err =3D 1;
> -               }
> -
> -               initial_len =3D 1 << 9;
> -               retval =3D read_from_pipe_to_data(sh, initial_len,
> -                                               err_fd[PIPE_READ],
> -                                               &err_data_read,
> -                                               &err_data_read_len);
> -               if (retval !=3D 0) {
> -                       any_err =3D 1;
> -               }
> -               retval =3D close(err_fd[PIPE_READ]);
>                 err_fd[PIPE_READ] =3D -1;
> -               if (retval =3D=3D -1) {
> -                       ERR(sh, "Unable to close read end of error pipe."=
);
> +               if (retval !=3D 0)
>                         any_err =3D 1;
> -               }
>
>                 errno =3D ENODATA;
>                 if (waitpid(pid, &status, 0) =3D=3D -1 || !WIFEXITED(stat=
us)) {
> --
> 2.55.0
>
