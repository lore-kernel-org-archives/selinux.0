Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BB3B841B
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600385; cv=pass; b=qBgMFwWxKMUf14OL5oMFEw7ORR8PVShNqElajgGiaYkcOB20RV4Whv/gLD9tJ3q8WfyA2ISmpWmqB572abZj2T9CALRVAVSfB7HAZSUYTWWn3H9cgxxK+11dGwxhER2WZvp4zzRUCroxHdGoQuQvJ52q5sjxArR78PVZiJDCOYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600385; c=relaxed/simple;
	bh=bwWeruTmqY+g1Dne5zVi+IQagJadoWacOUnx83e5aFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZnWYXLzYsWC5TXTDy/dg4i7buPZ731Um45YuzVFX81Av9khsBpxRXlUfR4FnBif2REMz27HZJSWEpStVvj+b0loEcnvs/0vwAv1J/oMlTXWdM8+elpg2NKfZRC5FnxFY7D23ok9YKie0vGMru51tXtoqEd8q4JH+1s4w1SosO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LO1VOstT; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LO1VOstT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso56790815ad.0
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 08:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778600383; cv=none;
        d=google.com; s=arc-20240605;
        b=M0cMT3VYEQUqtUeAjI6MuYKDBZfYx7+6aBywvCRxi2xQbeBVrceXX9nBgKe8zsckt9
         zR2EE/vWYLk/c5DbzDGegwZaVpcK5+14TVv1VSWpJaXhXUeUgu6pGgtVv44ulE+0PesX
         +4vTsN+H2t6TVsYC6AK4SpQSsgH0L2uztuzlpRgn02ltG+wZZf4gfOHH3EWGNwMUuIz8
         dy9nOXmPmnja+csZlDlROySlCE8WvNsBJga+/uCznxB+BiE1HnRHmtLC7bt7Uh5Qjvht
         bM+Z6pjfsA5M29g9AeIl2RoJiGOPdjOOWwf4J1Pw18lF3/BRp6acYzRBmR9g5ZsUoO5M
         BJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QxfO3PWax/OepqpzsmliNGo1en+SXf5nsZZ2i6kCODg=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=TPJpsntZlvHFvmjKdIV1vzsJ9ctM3FoI1mZM/Z9DlenuoUrwhUT2UIBmtcFEk942Ne
         C4FnLGqL/ETSc58MhCxhSpzV0+r+eMFDwmRV4zCUTV0vkO61SITK51QvsM6iC+1uPM4/
         D5wqwRfKBg72QIR/hgKO+RDoXOikGhKTP5IRJyCr8UuX4Mdy2XOMjmU+krCQu5NvX/Wa
         1qiLjplJj/oSQn6zk6gM0v+BGNO79B/Ogeud0ge9blsrVGJFUTih7x15XZ0tkqf8VDuy
         dQjUbuzN/wgV1mCFCoc4KgSbyFe/Rf2vg5wL2XJluh+HVFma3LE4dPfJV1nWqrwZJ8s5
         HeEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778600383; x=1779205183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxfO3PWax/OepqpzsmliNGo1en+SXf5nsZZ2i6kCODg=;
        b=LO1VOstTmi7yLW+tJRjAbPs8TeEoybe/7o9mgRNjdI8a3DW5YAUONfqaCp73PCES9J
         w/ebn19KlYMBMUSEIbsvLXsh0hWj+j3oYK1eH8mCHsVPmDDaGuhufyETkV7nsHH/tFV8
         galebIXIkyxjeP/lNoPc27fHWlAjZtve4J4g9N1bjykyDn03mTcQL5rIWrbgAtMcGaBH
         YboAdE5FwxTydjQt8VVqtlTD7BYZtOoeZOYFyY9hnihfKHhXX6QZrRfV2VTmaaHGfYDo
         2Xm4C16uIFQWGEZc3rG0oTm5hHI/GpdJqhPwJelmcr+vw+wfFZ+J7yal253kqw2CAvxT
         YArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600383; x=1779205183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QxfO3PWax/OepqpzsmliNGo1en+SXf5nsZZ2i6kCODg=;
        b=ESp5jWn9Kk04YLF6rMUQi73eWWe1sBIoF3rO5fdlP9E99QHxjH1X+beHQk5xEm1FuE
         TQing78fzHRhuGfJw2azDfc7hSXGoJ9hMwaUgRxQDEneT3xoNQGHUjcWtE+nOdiM9QdM
         cvijZO3X88JfuCojEHwJaSahV9nfni3/vr1Elyb+mCU2lfkcJ8Ri+wP9+LGqqurKfIop
         pXEpi4pWBuxrxeJnMPS7cs//UJcrmcJKmk8koElmgiXgKD790axO2WjT1ZYJyEGP7o1Z
         6YAnOCgLSNfuERgfWAEFn98UvbLbcw4H4SRXB8ZTecvcvsHpLHK6zydig3ZkGNZ9s39d
         9e0g==
X-Gm-Message-State: AOJu0YwWkZhDxWdBjNxLkD9luy9eLUEfpxrGCLcm0T36ae6IdDOodl5U
	ybl3erpsdXLohDvfDSoXDUOnZHIa87MqRzpjYAJ8GcpIqqRM3+IzRC3We6WTBV/zvVIRRxcueOy
	YCUUTOq48fEcn4g8UqIWphy91Lk0BCaY=
X-Gm-Gg: Acq92OHYk1D9IrKHpLrf4K6v7zuTga3t/BCYOvP6xFoDwqWt+rp7rN2KWKsy3GjBE47
	kEv2AyJ8iU09p4cwBBiXIgpu/4Ony2aICBPbxjF/Jy0xlSYZRWWsgpTn+JWPxfooE7JUp3aqhZH
	koFwNspwLcJ01vhUFEcQhCZwack1k4DghF3bb+XK4lTwk9wIt7Eryd+3s8p02cO3O5rT4F0p2Sp
	LYiMlMD5fc5/c+7CmdfMbSFWAj+Ov2F/DkFkQwqUJGzY3Vf69yP+P6u5TPJNqA5XLxxJ/3fxn6c
	djttB7I=
X-Received: by 2002:a17:902:7489:b0:2bc:dd58:3db7 with SMTP id
 d9443c01a7336-2bcdd584281mr54380405ad.34.1778600383008; Tue, 12 May 2026
 08:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427162452.132118-1-lautrbach@redhat.com> <20260427162452.132118-3-lautrbach@redhat.com>
In-Reply-To: <20260427162452.132118-3-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 May 2026 11:39:31 -0400
X-Gm-Features: AVHnY4JpDVI7ShUbXpY-yZ6mDsr3C7eWCJxzbSO8-Kd-n0-RgFHmBde7JNC-JJQ
Message-ID: <CAEjxPJ6n9wJWMree_=eZnPmyinoAESzLezFF_BrwiXdvsxK1Tw@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsemanage: Do not use vfork()
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 12:29=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>
> Fixes:
>     semanage_store.c: In function =E2=80=98semanage_exec_prog=E2=80=99:
>     semanage_store.c:1307:16: error: variable =E2=80=98a=E2=80=99 might b=
e clobbered by =E2=80=98longjmp=E2=80=99 or =E2=80=98vfork=E2=80=99 [-Werro=
r=3Dclobbered]
>      1307 |         char **a;
>           |                ^
>     semanage_store.c:1265:15: error: variable =E2=80=98new_s=E2=80=99 mig=
ht be clobbered by =E2=80=98longjmp=E2=80=99 or =E2=80=98vfork=E2=80=99 [-W=
error=3Dclobbered]
>      1265 |         char *new_s =3D realloc(s, len + 2);
>           |               ^~~~~
>     semanage_store.c:1265:15: error: variable =E2=80=98new_s=E2=80=99 mig=
ht be clobbered by =E2=80=98longjmp=E2=80=99 or =E2=80=98vfork=E2=80=99 [-W=
error=3Dclobbered]
>     cc1: all warnings being treated as errors
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsemanage/src/semanage_store.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index e3048c08df0e..99d55d9813c9 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1488,7 +1488,7 @@ static int semanage_exec_prog(semanage_handle_t * s=
h,
>
>         /* no need to use pthread_atfork() -- child will not be using
>          * any mutexes. */
> -       forkval =3D vfork();
> +       forkval =3D fork();
>         if (forkval =3D=3D 0) {
>                 /* child process.  file descriptors will be closed
>                  * because they were set as close-on-exec. */
> --
> 2.54.0
>
>
