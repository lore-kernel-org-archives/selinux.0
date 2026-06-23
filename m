Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A9318EC5
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232929; cv=pass; b=nILwnaUiqxNpKQICSJUImabxvZor3skRzhHFTduzgPeN6z2OzDtCewLZrI1Tij9YVPUzGoruQrul/Yre2brCicsaNI1uFGa41ECHaYpb7Uoi7+D3TPdSo8H0l3waQZV0KpC+dj9hLRI+zIQTubff+snnyG0KiKFMw5O9mdSn8WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232929; c=relaxed/simple;
	bh=N3WFo5EYPGhGZqEo888t8X08yG0Miyzj7dAFML+oS4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0f7LkEtJueKAFxGkUEqc2zigiu5fCVUEJ75OacX4DWDhEKYoHI0exlpa1FMHrlHS0hawSwMvdFf/nT0lP8SGxmIxms8lzBfQbufz+0Cns4uF1F96aqrDrA4Z9KKvp2gtuvZDRaQRbypnim1pxUGSd1ZF8LkEl0eMmHiZkh5ufc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEAULHlO; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEAULHlO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so120596a91.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782232927; cv=none;
        d=google.com; s=arc-20240605;
        b=HZcSnLyFcZ5UgbEIG1fWi6uQY/G60bruQqfG6g0fRuzItWQWlBfYwaFZX+G6K9B0k4
         LCU9kcr6AaC80bxwazmB3OCr1WmbKL58yK5vOzS8+h1Smw9UQWV7APYTGUzuz9ygNCxT
         +fW8eIUxSXecJEXa+7Fjzrin9t5T0NpDJqGXQtc1XbJxPWroqQq9Mw0uIKTc+vS9tSu4
         gqzQ7Vtm7o5lQfXlBuryY2zi1faKChCuRJ3O3iHQ1hmam2dyOD+bmc9IfBJie16VGDGp
         Q0BLBscwLoHWD6YvY1WTlxoPmOFerQzc1bjxJzNL3HJsidm9MACegh9tnl4lS/dUiF/L
         c8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5I3Pt7e+Pllx186ZF00ZJ3ytHMBjm/ydfu5s0CCbPeo=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Z4OhqFiGrJJ/QVLIE6aK1KT0eJ6diafP5+EH9N1/N/Vrbma72mTk09T6VYXn35b+ZO
         Tn1DodEt7o+rlWv+BMSM8ubK5n552lSH6BoEefUncWJz52gHHd4Sud8ZWQhnn1BiRBKj
         r5gbu5jkdmY8785xp/5oFOGkNwJxEmIRetr3rEQmg7QdjSKeyanf/sptN47yd6WCXLz7
         eARERwH8MxS+naNia7WmkPCU45a76Xm6F6s8b+vH2izMaHThvqLVi7XlUG5fk2JRf8Eb
         V0MGgz6mkeREINO6nmMiY2RDaIYskunDEtuoY2End4mWbHJvfaPWqInRSBjxMhJ128E0
         NHfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782232927; x=1782837727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5I3Pt7e+Pllx186ZF00ZJ3ytHMBjm/ydfu5s0CCbPeo=;
        b=jEAULHlOBnXbRGCnpNxTGB2XJFvCnLLQj2TBKdfpg5FjpYIhNS+PbwaqchFRIhDF1T
         MKLDaKLOfy1nJI69txnj/ndmoaGYCgGREjaeUsY0Kli2OUWZl6Zelekbd9JW9WydvWRZ
         jUeKXY2Yy4ZfWSZa/mmHuq+HfJTxbJsbA5MB5vept8WWRS/sZU/nj669tMzopOmNLlmD
         bm1R2larxOs4eRRZUFhk4hT27iTjBMql10h4g8uXnHAymAWlGiy4u6IWf7zhCGEaMfQR
         2qt/LuipvOyZiWuMpFRCoXGyHjjo3RP0PRf54Vc1jstlNWM6emD5nvlr/B7pUVpjo+Z8
         ZqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232927; x=1782837727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5I3Pt7e+Pllx186ZF00ZJ3ytHMBjm/ydfu5s0CCbPeo=;
        b=ddhf3IzoJ3Qdpx8ayaCjE/UAj3Ug43XcR+rGhTs/maNb9z0x3ILcMuqjY24XfupKGf
         kc8aATWZflFfdRmxun5robEZcDivAxGOxiXRHTDg4DKOU599eGXwhT8bhhvVzmwhcHMp
         1IMYDcUs45E2EGJgqdVjQcFFZuUkKLNNX7okajTW2JlMn5BAgjmVBXi/+sySRWlIdY9r
         g8iOOHKNm8Z9YFrB3SqumwXkuPzZE8/eCGG7GYcf2not3n2mIo04e3xihMGvQqJrC2qB
         KqzTqNwk7qTA+VhofvSOFhQMIwBrXkt6rLUU47+cAl7c7HrZaXjindm9jXHItx+6/luL
         50Gw==
X-Gm-Message-State: AOJu0YwwWXiEaLkSmPzMHbHmfBVVjM5NBd7wMzTFh0QpoEiVrOJ8J2Lp
	bzH1OqZkeiPojdtR1xbbJUPUcXjWqhNrHO7cx+lcE1qqmgBt0EYAE0JcNA8X843oaZ5T7cVr1vw
	B4sVEUZgCaN6NRj4rKUevGmSZgvp7qzU=
X-Gm-Gg: AfdE7ckW1IsvA/Ciwt9LE0XBvUDbL9CVpH3j8SOut0vFOeShDTGHhfql5rm8xz05rTy
	vJ0bl5S9w1nHTnhWOcTFKXH4FbaLmxfweeAh7TH6gNuXW0J2lURh7/QQxMpKdOkFZz9jpK6SS5I
	sCaPslw9iDoGoYd5WEtUc+f6g0RPjH/grdxy4J0E4aBjh6r2M8FpdzuWxmBYZm9gNZ+S9KgYxLX
	fdTKzafWY/KtkBFar6ZwyiDSN2T/TBAZ/DzY9monOtCuTv154HPcAausHiAe0pLxXLO6p7y4Lv4
	asSzjHE=
X-Received: by 2002:a17:90b:2d0c:b0:369:932a:2b6d with SMTP id
 98e67ed59e1d1-37dd16de3acmr3835180a91.6.1782232927400; Tue, 23 Jun 2026
 09:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623141023.114173-1-cgoettsche@seltendoof.de> <20260623141023.114173-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260623141023.114173-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:41:56 -0400
X-Gm-Features: AVVi8CdaLD2XVvv1MTiOmVIu8Cm4NEK-seTHWVwrCuJPBQ98GwWVlUd9lMjM6_E
Message-ID: <CAEjxPJ7=Ak+qGj0V3wOsPW=1hSm9ANfiX-HHVMtgbeBbB5mJow@mail.gmail.com>
Subject: Re: [PATCH 3/5] newrole: wait only for the forked shell
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reap the known child PID instead of any child, so a process spawned by a
> PAM module cannot be mistaken for the shell and cause early teardown of
> the tty and session. Also report signal-killed shells as 128+signum.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/newrole/newrole.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/=
newrole.c
> index ef194efb..990ebc18 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -1232,12 +1232,14 @@ int main(int argc, char *argv[])
>                 int status =3D 0;
>
>                 do {
> -                       pid =3D wait(&status);
> +                       pid =3D waitpid(childPid, &status, 0);
>                 } while (pid < 0 && errno =3D=3D EINTR);
>
>                 /* Preserve child exit status, unless there is another er=
ror. */
>                 if (WIFEXITED(status))
>                         exit_code =3D WEXITSTATUS(status);
> +               else if (WIFSIGNALED(status))
> +                       exit_code =3D 128 + WTERMSIG(status);
>
>                 if (restore_tty_label(fd, ttyn, tty_context, new_tty_cont=
ext)) {
>                         fprintf(stderr, _("Unable to restore tty label...=
\n"));
> --
> 2.53.0
>
>
