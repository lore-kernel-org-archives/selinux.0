Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E684175A89
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439809; cv=pass; b=nAb1vJ1VOuWPe2wT6nePVeX8spw9Dhp+IEoihu3KV3XFum24/3GkKIZSMG1OnZQ4pa+jfYEf5YxVXJHQ0/wYOyun+znsaUtwulzuQmjaUt8PTzG4gRB/KQij0gM7hc/bKTdH5fV3ZZOtYJPc3py2leOKU9d1hwAA3k1QObeVh04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439809; c=relaxed/simple;
	bh=jC6i0qMIQv1sU3si2mbJNM4UcuAaP/B70cmc54KtvGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFX1c6xp9Jt4em7rkmWZxU3PPNwoJchnWIJE3XmrV4YlQnuU+zVTog02uO9b1fSvAin6PBEFdx3nmiLhFdzXyWFgMbUr8CUweU6y/n3f7B7pFJbSaoLEnSXtoqJJy+s5VkIPvxq6C/G1M58O7omtaH5j2KZdHgtfbdHmCgVHLs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwN7NXtv; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwN7NXtv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc891373e0so25912605ad.2
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 08:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783439808; cv=none;
        d=google.com; s=arc-20260327;
        b=C6LoTXAiabzCnbykqHGQ2Bl8EbT7NnzwrpNu7qKgjPZgZH67BhSva2YW9/nF/y9YE2
         EZoFKKmZGzSqkkUnJaTdwx53IkKDXZbPomRD1K6UU3rvGZYER53CPmenzAapbBg0cUle
         KuC0kL5nm1uzR5kKehBalM+2E5JnCDtZtogjYBuhlzKa8pCl4chwxLhBCE0I2Wdyqn7t
         E+JU0IF5cNUh7G0f4B+mGOFwBrQPCZnauCpkcPmZ+ySCIfBFVZtiJQ1+8Za7dFpTYELe
         3RlhQiaFQ4V2k/1G57q1Y0Lz9QHBSWG1kFNkhIEQbnrYWv+6pb5ZjfB9ipqVgDoFHkgB
         /yrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X79soajZk7Vgr3dLVBY+shHgfpMAd/5loog+byaj1RI=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=SGRfBLJDIKEmBcc40utYJ4kdGKSJRtydeDPiuqfXvY4AFYU0VOaGtKRpIbzImDhBTd
         /XbxS5vdag47qPOlb+crhyIanmIGxEeuncvY9+3nKvb4B/XAuZCXtE/h5YxZmvfvpJP7
         i9yJ+pWt/DJFu0/vvdqmVRXgpYaMlbfoeH4qNN9wwS9IyIkxmL7rD9Vx2oIMer8WBIbo
         Uc7+jZdp32GPHXxtCtDKr4s6hDorpiwePPokkRoYeL/i3r3Flm349rKWMnflebIuR16H
         CCY0lcZuOf0W1IxJFUkBFWInXhDIVgCs7KHGrHPheD8DDZD6uVeSiZZ4LDaxvW4msY2/
         ioAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783439808; x=1784044608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X79soajZk7Vgr3dLVBY+shHgfpMAd/5loog+byaj1RI=;
        b=PwN7NXtv3PNPFQS2kfzJN+YB/Kyug8P3JXJTqE0YFeUAgu7J3I0ZCT9VhdXoIctICR
         S7uVgSyqBaRZS9ZcbnUgeze79AYNrKJ0YQqrvzwrNJ6ZTGR5dsj/QHC/LFGdSGT94h/j
         J8DzU58F0DJIfd/JIiPlCzyAm3q3S0ISfT1+bpfsy7R0zF0tyOkoUvQU/TdpnuZgXzMk
         /aMDUNz4+5SSIyJWCU5ZzGzHDvoN5eXZiorz8PlYIOnYAbY+Z/VhHEBAnv5nAbxrF4Jr
         c9fpxBIMRhEeoOiVgB7q60+ouXotT6CX0cW7PFaeX/zKl2juSqzIBtaAKFqZma28NdRm
         3QSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783439808; x=1784044608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X79soajZk7Vgr3dLVBY+shHgfpMAd/5loog+byaj1RI=;
        b=hQYRgO5wlaoisSVxh1Zv6boNJsVbAqw8nEiTqdZ9lL8vtGXAdTWjH2OHVfPWdfGaMO
         mGtMUTprCmVz7iWBsfDHLRiIqqlIvlxVeTQPy6O26qBKfwwc+i3GwcwxWNmeLKr72biS
         sM9t63ZvNQXuTQXA1hKiEogf7aMWypR6xozZ6wolwztpcu03vefFwvR8qjgMvNCsWmrK
         8bP28IE1ANo1Lf465tmLwImMXWkY3K9V3a6EbHfcWNA3m4IyKS50zPmprZlflGM7hO4T
         8XaODiIvZhV2Xo/nrXvr1NwVraOH721uB0AsoKA2NzMRn13YjXcWITVuNXIt7+N6iapL
         JD9g==
X-Gm-Message-State: AOJu0YwJ2yzouNVR6rap0V3dmU+8wOrNPv/v2s54l7zRMixBgpdXZKnh
	Jvk4Wi91wXC35shzBnblS7EmRTyLJif7XspPXtp88/Evi1iHriletD3srix4kxbag0JRImgMlT3
	S5E3pG9hYF3aVgt1F87OVGGccmSBkFBI=
X-Gm-Gg: AfdE7clPxIRVyG2kH5/lU6jCF7yRLykO69+51RaZphCd5PfvVo8MnQ+crNi5EAk0iSv
	zv7rvdBSFuZ0HOd8X0Hf9td1Optjrj701434/U3/oOvdITBCUlJRWn3AZveAEzvQ1GS01DDh4hS
	H2eCCNaC6ylJWS3F6irX8IrNNLz/Nlqg82+krCpIUHx8l1mglV15YQka47l5XN5svhKql62nQkE
	BFmLl0egJRVlSrm136T2KB3HTlHHZ7bfPr1citiz68K/M2CIiiI9f+n66r/Z40d0W52q/AwAkit
	p5+i4pA=
X-Received: by 2002:a05:6a20:2d12:b0:3bf:baed:c797 with SMTP id
 adf61e73a8af0-3c08ef1dd29mr6864524637.49.1783439807544; Tue, 07 Jul 2026
 08:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703114816.1244235-1-omosnace@redhat.com>
In-Reply-To: <20260703114816.1244235-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Jul 2026 11:56:36 -0400
X-Gm-Features: AVVi8CcLgTrMWLWnAqZXX0cl_B4SBdMqlZxX-0S2bGeiqQYpLI-eM9G5LUvEBf8
Message-ID: <CAEjxPJ5A4RQRZXcZnP67LmG0-FYmCUi7218+ADdQ0mJ8ypb2fg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/overlay: verify that execmem is not
 checked for the mounter
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 7:54=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> Add a test that verifies that the execmem permission is checked only on
> the process mapping/updating the memory region and not against the
> mounter credentials.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Needs to be reformatted via ./tools/check-syntax -f but otherwise:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policy/test_overlayfs.te   |  4 ++++
>  tests/overlay/map_access.c | 20 ++++++++++++--------
>  tests/overlay/test         | 11 ++++++++++-
>  3 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
> index 787685c..e1e1ebb 100644
> --- a/policy/test_overlayfs.te
> +++ b/policy/test_overlayfs.te
> @@ -122,6 +122,10 @@ can_exec(test_overlay_mounter_t, test_file_t)
>  allow test_overlay_client_t self:dir list_dir_perms;
>  allow test_overlay_client_t self:file read_file_perms;
>
> +# For testing execmem checking (should be checked only on the client,
> +# never on the mounter)
> +allow test_overlay_client_t self:process execmem;
> +
>  mcs_constrained(test_overlay_client_t)
>
>  kernel_read_system_state(test_overlay_client_t)
> diff --git a/tests/overlay/map_access.c b/tests/overlay/map_access.c
> index da1ae36..ccf955e 100644
> --- a/tests/overlay/map_access.c
> +++ b/tests/overlay/map_access.c
> @@ -11,15 +11,20 @@ int main(int argc, const char **argv)
>  {
>         const char *file;
>         void *ptr;
> -       int rdonly, fd, ret;
> +       int rdonly, execmem, flags, prot, fd, ret;
>
> -       if (argc !=3D 3 || (strcmp(argv[2], "R_OK") && strcmp(argv[2], "W=
_OK"))) {
> -               fprintf(stderr, "Usage %s <file> R_OK|W_OK\n", argv[0]);
> +       if (argc !=3D 3 || (strcmp(argv[2], "R_OK") && strcmp(argv[2], "W=
_OK") &&
> +                         strcmp(argv[2], "EXECMEM")))
> +       {
> +               fprintf(stderr, "Usage %s <file> R_OK|W_OK|EXECMEM\n", ar=
gv[0]);
>                 return EINVAL;
>         }
>
>         file =3D argv[1];
> -       rdonly =3D strcmp(argv[2], "R_OK") =3D=3D 0;
> +       rdonly =3D strcmp(argv[2], "W_OK") !=3D 0;
> +       execmem =3D strcmp(argv[2], "EXECMEM") =3D=3D 0;
> +       flags =3D execmem ? MAP_PRIVATE : MAP_SHARED;
> +       prot =3D PROT_READ | (!rdonly || execmem ? PROT_WRITE : 0) | (exe=
cmem ? PROT_EXEC : 0);
>
>         fd =3D open(file, rdonly ? O_RDONLY : O_RDWR);
>         if (fd =3D=3D -1) {
> @@ -28,8 +33,7 @@ int main(int argc, const char **argv)
>         }
>
>         /* try direct mmap */
> -       ptr =3D mmap(NULL, 1, rdonly ? PROT_READ : PROT_READ | PROT_WRITE=
,
> -                  MAP_SHARED, fd, 0);
> +       ptr =3D mmap(NULL, 1, prot, flags, fd, 0);
>         if (ptr =3D=3D MAP_FAILED) {
>                 perror("mmap");
>                 return 3;
> @@ -37,13 +41,13 @@ int main(int argc, const char **argv)
>         munmap(ptr, 1);
>
>         /* try mmap with PROT_NONE followed by mprotect with full access =
*/
> -       ptr =3D mmap(NULL, 1, PROT_NONE, MAP_SHARED, fd, 0);
> +       ptr =3D mmap(NULL, 1, PROT_NONE, flags, fd, 0);
>         if (ptr =3D=3D MAP_FAILED) {
>                 perror("mmap PROT_NONE");
>                 return 4;
>         }
>
> -       ret =3D mprotect(ptr, 1, rdonly ? PROT_READ : PROT_READ | PROT_WR=
ITE);
> +       ret =3D mprotect(ptr, 1, prot);
>         if (ret =3D=3D -1) {
>                 perror("mprotect");
>                 return 5;
> diff --git a/tests/overlay/test b/tests/overlay/test
> index 2d0555a..ae8ec33 100755
> --- a/tests/overlay/test
> +++ b/tests/overlay/test
> @@ -19,7 +19,7 @@ BEGIN {
>          plan skip_all =3D> "overlayfs upperdir not supported on NFS";
>      }
>      else {
> -        plan tests =3D> 135;
> +        plan tests =3D> 137;
>      }
>  }
>
> @@ -641,6 +641,13 @@ sub test_68_8_ctx {
>      return;
>  }
>
> +sub test_68_9 {
> +    print "Check execmem map access on mapreadfile, should succeed\n";
> +    $result =3D mmap( "$basedir/container1/merged/mapreadfile", "EXECMEM=
" );
> +    ok( $result eq 0 );
> +    return;
> +}
> +
>  sub test_70 {
>      print "Check unlink access on client_nounlinkfile, should fail.\n";
>      $result =3D system(
> @@ -891,6 +898,7 @@ sub nocontext_test {
>      test_68_6();
>      test_68_7();
>      test_68_8();
> +    test_68_9();
>
>      print "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D\n";
>      print "unlink tests.\n";
> @@ -1033,6 +1041,7 @@ sub context_test {
>      test_68_6();
>      test_68_7_ctx();
>      test_68_8_ctx();
> +    test_68_9();
>
>      print "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D\n";
>      print "unlink tests.\n";
> --
> 2.55.0
>
>
