Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3C34BA37
	for <selinux@vger.kernel.org>; Wed,  8 Oct 2025 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929975; cv=none; b=PgJdXSykK8Bpw7gLj3VlLLU4W6WgW5Ia8ynl5GJ4/Xri+TbFEpdcByiYUOsl1bBTsP2YF0oiLTnnTabvNLUwwjAxNi+CSH7B5vO8ueWkeeWFkkNdDAWSYx+S5qd9PbHqz8/aSzlE7HpkpFneri7JhL+cZzxCGEzxIkN15dJqla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929975; c=relaxed/simple;
	bh=slAvRscOU2RR68xyQyYV+7KU8aiMElD47TwGHkaC0S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4gB2mgKYMiRgnNJIcsN5xP6is3YXi5xst/7pW5kQyOLDHj6dP4ewHkmv3CusMPVSXtQB3/NhUFB7OsQ0P3v4cWA7s6xShsfvbxYFUOmeErq4wjHqlbRWdsoE9DpAVToNR19eswBaXMF2rf6TfwKjmK5mjdl0nUri01zyr286O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Epm5dxqZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Epm5dxqZ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so8165390a91.0
        for <selinux@vger.kernel.org>; Wed, 08 Oct 2025 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759929972; x=1760534772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjxq1RfyZxnBvdFRt5IuRma0qDKY3jgYaW9dYaOWzMA=;
        b=Epm5dxqZ7DQjgsPuloAxlpPDH62Y1OoG+bvv8nlcmhMl71uOWTd52KhuTWJRswOlWc
         kRfVngrTfxNJaEb7twVy62OjT/HEHKBLycvyhQS9P2ttVkgorGcgGs0ZURUSFYNJUyKx
         jLfXVsE5sMujWrahnAKkBx5Fs8u5mbGZ5ShPYf/eclwszbnoqUzp99RfgDA9pXn2KDCk
         pCYbNWGEuSWugdXjaXDNcRwTBuqKpk+1yN9Y0LNVSdojTJc5ICeUedvpqofdeFJL5edL
         dURvIBvy1gYq0fUL5E4ZPnAtD90VWzshfP7Wk1cTq41gpegWmnbQ1NpvqUIGlpoZGi3c
         JYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929972; x=1760534772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjxq1RfyZxnBvdFRt5IuRma0qDKY3jgYaW9dYaOWzMA=;
        b=AwRKUOuBKB73XxCNw3GpAb2UHmW5E9OF3jHJ1f2tvXxsxP1kNUyS7S3PQW61k/GQb5
         usR1hWbIMmScKrAcyHFFkc1ws31Alnp7r/9TLrpLtWd/nFGwvQTPUf2u6u3fiot6DRst
         vxoO58iB0IUPiUAJOPfi+IsGJePd40JYlUiKuYx74uD6XWlkiTOwjI5aNDrhEgZkOfQA
         9SCtuT1FPSTBey+3QCsf/JsLGJ7Bb5mbdLUMQlfVnYQKqAh0NLmjrY+2YbEblybm8r9g
         2ER/Cemjp0L/y0TFhp7oywwoAqx9rJFgeJ+/9YPNlPHsdMHQEHrmy0BzDDIYuH82m4YJ
         og2A==
X-Gm-Message-State: AOJu0YwAk2Ak0YgL4njGzNnTodkv8xLjGAzimWrjGu92D3dKdfikn26u
	nx5kryyY5pYQ00cxRTEZVJ4AMDzaYspdI8knSVgDqU4HDhbgrSdlBwiWVa2gmOyIjx/fKTCmb1R
	sRwAkxgn1dUhZsnBqclXjUEXcPwNbLsM=
X-Gm-Gg: ASbGncvVlm1XMufMMaIAPYDWBmcdumNmwMHURtKy0AGHsi6GzeXK/cNXrTpwogvmRSC
	zOMCFmltEKlR/yyOz9CScVDQQ3WOPMWMbN4idsyNwLVBM4EdptdOWXGAUuJIbJWsomcR0j6baCG
	S1W45pMqlftQhj/IqVtzWODuxrSVsoPoF2DmUh93QHRmG/kARXKdWYxBvYOaDe1PMAYkByluMSC
	WA+nb5qGKRz84tVU4uq9veNBuLzMS8=
X-Google-Smtp-Source: AGHT+IE0Tx0Ir5NPFFLcDtJw/eob1DfjB9SzpiN2xVrnSdDisQkFuJkQvrVHDYi8iC/05+cMkRiS+DEmhnVIOMrOo3E=
X-Received: by 2002:a17:90b:1652:b0:32d:d4fa:4c3 with SMTP id
 98e67ed59e1d1-33b513cd9damr3718695a91.31.1759929971652; Wed, 08 Oct 2025
 06:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007192808.514297-1-nvraxn@gmail.com> <20251008000549.539392-1-nvraxn@gmail.com>
In-Reply-To: <20251008000549.539392-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 Oct 2025 09:26:00 -0400
X-Gm-Features: AS18NWDeCoBwOSZVXF_27NuH_em6xkoqzizyv365F0xVyTZTNq9bwR3gN07N694
Message-ID: <CAEjxPJ5+P23pREOYr7nz0OyFQb04Pz1fNaNB0_9Qn52aLQqrAQ@mail.gmail.com>
Subject: Re: [PATCH v2] default_contexts: introduce PAM stacks
To: Rahul Sandhu <nvraxn@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 8:06=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> This allows a default_contexts entry to only be matched for a given PAM
> stack. This feature isn't implemented by us in this commit, though it
> may be in the future should it prove useful for `pam_selinux`.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  libselinux/man/man5/default_contexts.5 | 8 +++++++-
>  libselinux/src/get_context_list.c      | 4 ++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> v2: no need to set found to 0, it's already initalised as that. not
>     sure what I was thinking...

I'd like to see an actual implementation of how this will be used
before we add it to libselinux.
Also looking for input from the distro package maintainers.

>
> diff --git a/libselinux/man/man5/default_contexts.5 b/libselinux/man/man5=
/default_contexts.5
> index f63d24a0..49ebbd25 100644
> --- a/libselinux/man/man5/default_contexts.5
> +++ b/libselinux/man/man5/default_contexts.5
> @@ -35,7 +35,7 @@ Where \fI{SELINUXTYPE}\fR is the entry from the selinux=
 configuration file \fIco
>  .SH "FILE FORMAT"
>  Each line in the default configuration file consists of the following:
>  .RS
> -.I login_process user_login_process [user_login_process] ...
> +.I login_process user_login_process [user_login_process] ... <pam_stack>
>  .RE
>  .sp
>  Where:
> @@ -48,6 +48,10 @@ This consists of a \fIrole\fB:\fItype\fR[\fB:\fIrange\=
fR] entry that represents
>  .RS
>  This consists of one or more \fIrole\fB:\fItype\fR[\fB:\fIrange\fR] entr=
ies that represent the user login process context defined in the policy.
>  .RE
> +.I pam_stack
> +.RS
> +This consists of a name for a PAM stack required for a match.  All PAM s=
tacks must be enclosed in quotes, else they will be treated as a \fIuser_lo=
gin_process\fR.
> +.RE
>  .RE
>  .
>  .SH "EXAMPLE"
> @@ -64,6 +68,8 @@ system_r:sshd_t:s0                     user_r:user_t:s0
>  system_r:sulogin_t:s0           sysadm_r:sysadm_t:s0
>  .br
>  system_r:xdm_t:s0                       user_r:user_t:s0
> +.br
> +system_r:xdm_t:s0                       user_r:user_t:s0 "login"
>  .
>  .SH "SEE ALSO"
>  .ad l
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
> index 0f3bdc5c..331a26d8 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -165,6 +165,10 @@ static int get_context_user(FILE * fp,
>                 if (line[len - 1] =3D=3D '\n')
>                         line[len - 1] =3D 0;
>
> +               /* This line requires a pam stack to be matched, which we=
 don't handle. */
> +               if (strchr(line, '"'))
> +                       continue;
> +
>                 /* Skip leading whitespace. */
>                 start =3D line;
>                 while (*start && isspace((unsigned char)*start))
> --
> 2.50.1
>
>
