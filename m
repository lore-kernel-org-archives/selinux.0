Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289222EE28F
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258306; cv=none; b=OgCzhh6C1LwK1EhqKSrmaIrqBV8Ph45e+OSSyQ3NNQPFp9NsL+f+bJjLNl3OCHt8dddVwylIRnebcwKJgjtYgz9V7y5PDVPirMNrSgK8SsYpt+IjqQoBL3mfwT7BDHpBcfLyAWTctOY4mcavdzqBB/0FNZlhiaVnQI1Rnlfl72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258306; c=relaxed/simple;
	bh=MWQyBAVeEaMLmaKlH6HRKxP3YrIOsWR9TQZ7RtafGrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KecrOameJp+jDoOayAPe98/EACWIgi7mqvor26Zo0st2Hh3MqhU6YR2x0ac3jmid3Jv/ukgipOkj/4UvIVLgwdDIftok5rM0sHbC2WYTi3nNQh16Y/oRH9Sk7ObUwoYOZ+0jz8qZjvUnq9GvPQs1hE/jrmxbMYAHh5YjH4lwLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alF8Vvwi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alF8Vvwi"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742caef5896so5870970b3a.3
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750258304; x=1750863104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mztyeiW1lMtQgZXefvVE3n8KqKA1HsVmQ2pB5kRgtYY=;
        b=alF8VvwiIzPdnSsvT2KUjDPDtPVM72PUEIT7TRS2x8m890PhFraEJUFk56JvkohF0W
         R6yGuK1KdFjvJSul53+iT+NxVBI7URA4cvQDNqNxghJIHUlq0IDrQcJysRr64+qRZzNI
         40JEtxxLGaO+2efWId2ET4w4mzrqAG1niDE/NtlUF2yU1gFGeTnmKAcUYZVyI+gSkUaN
         Url0LBZIfecNSBQSWQFOsXeD5eP8/vew9ga1qTIQUIFQzrDjOy4BqwZQzrOfyaBMZD7I
         FXGfFzselbSNJohwmks2uOhtjVIw4WVBBoRgO4LnqTQcI3jWzyBSPpsuuyD3JHbMRbaq
         2vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750258304; x=1750863104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mztyeiW1lMtQgZXefvVE3n8KqKA1HsVmQ2pB5kRgtYY=;
        b=e/Um0LZ100pyS8PEIXWG/jsRZglVP+L/MHWLfxp5488FWWjIdYL6jWhSceeJalcuTu
         Sj4wMMPI8WyzT98g7piFAK5BRLN6ODqgoTdY8tlGulnQ6wzqdpeIGpmd2sSCqIb4ibF+
         Rxb3fNDqwusT1ilSHKn2xJy87ULR+t46d0Pf1L4L1qgnSBRBqiGOKJ02hhef05RHFr1l
         VjkzZZWJS/I9kQ78BoSgVAiEgXEnwG7iDF5GO6iP2fXAErEh2v85zWeUNAck1akAa/0W
         gwMg2rgZi35gmGfyyXD6sXEkoNHEfZ/B2Jx0Zche8QT3MdksR9Z9fRC46Z8Dx7vhtUsD
         RpIg==
X-Gm-Message-State: AOJu0Yw2JrIXNFdRi442tOiL377duUQL66RqOdg8r0PNaboMhJvlo6uK
	LQDrEAj+PO7+4fstxRvsC5DjJ58lFNNAebu498lMwgJPDu1Ey+qSESUA+k+a8SF4Yy8RnJDrDrW
	fKcXcNfT0MIkS3i1Q6W1poRzMAAJKxrI=
X-Gm-Gg: ASbGncseQE3BeN/Rkb/h2ATt5n6vHhq6ALHvSuWOLPYG6hjK1yRmnHsqEtFM4zgQENK
	w/t/f7zNHMZUQh89GRlPtQ7efZH+c5dQmDZxejH9PnqD4ocZKv8MqGVyWT95wV0g+IcyTDUHJmm
	sdvIZgHrEEwy0uTnB6n9oqhtMaIR2B3lOaVJkOoIgDzEA=
X-Google-Smtp-Source: AGHT+IGiVfge5+gPenU7BpbEuSe6m6WrFK3SRN2HSSXBf147gYEgnppU1nz7jsN41233q4ET1d2SOP8OKhjEs6pqldw=
X-Received: by 2002:a05:6a00:1989:b0:736:4e67:d631 with SMTP id
 d2e1a72fcca58-7489cfddacdmr23506314b3a.23.1750258304417; Wed, 18 Jun 2025
 07:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618000423.779510-1-lakarri@microsoft.com>
In-Reply-To: <20250618000423.779510-1-lakarri@microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 18 Jun 2025 10:51:32 -0400
X-Gm-Features: AX0GCFsq95YO8YLRhEtLVNHYiafhI6tufClrNS8avkjwIpeL3EoMjz1iF4uB0m8
Message-ID: <CAEjxPJ4z+9yEHiq0nRODqFSErDZnqtBxAOQwMzxgH7=BKTvsNA@mail.gmail.com>
Subject: Re: [PATCH] Expect Key error for module_load test in lockdown mode
To: Sindhu Karri <klsssindhu@gmail.com>
Cc: selinux@vger.kernel.org, Sindhu Karri <lakarri@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 8:04=E2=80=AFPM Sindhu Karri <klsssindhu@gmail.com>=
 wrote:
>
> From: Sindhu Karri <klsssindhu@gmail.com>

Move your subject line here to the patch description, replace your
subject line with something like:
[PATCH testsuite] tests/module_load/test: handle kernel lockdown correctly

> Signed-off-by: Sindhu Karri <lakarri@microsoft.com>
> ---
>  tests/module_load/test | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/tests/module_load/test b/tests/module_load/test
> index 98c5946..de3812b 100755
> --- a/tests/module_load/test
> +++ b/tests/module_load/test
> @@ -25,10 +25,40 @@ BEGIN {
>      plan tests =3D> 17;
>  }
>
> +# Read current lockdown mode
> +my $lockdown_mode;
> +if (open(my $fh, '<', '/sys/kernel/security/lockdown')) {
> +    my $line =3D <$fh>;
> +    close($fh);
> +
> +    if ($line =3D~ /\[([^\]]+)\]/) {
> +        $lockdown_mode =3D $1;
> +    } else {
> +        warn "Warning: Could not determine active lockdown mode, assumin=
g lockdown mode is 'none'.";
> +        $lockdown_mode =3D "none";
> +    }
> +} else {
> +    warn "Warning: Cannot read /sys/kernel/security/lockdown, assuming l=
ockdown mode is 'none'.";
> +    $lockdown_mode =3D "none";
> +}
> +
> +print "Current lockdown mode: $lockdown_mode\n";

Would remove this debugging output.

> +
> +# In cases 1 and 5,
> +# In lockdown integrity mode, the expected error code is 129 i.e. Key is=
 rejected by the service error
> +# In lockdown none mode, no error is expected.
> +$expected_pass =3D ($lockdown_mode eq 'none') ? 0 : 129;
> +
> +# In cases 4 and 8,
> +# In lockdown integrity mode, the expected error code is 129 i.e. Key is=
 rejected by the service error
> +# In lockdown none mode, the error expected is 13 i.e.  EACCES
> +$expected_fail =3D ($lockdown_mode eq 'none') ? 13 : 129;
> +
> +
>  print "Test finit_module(2)\n";
>  $result =3D system
>  "runcon -t test_kmodule_t $basedir/finit_load $v $basedir setest_module_=
request";
> -ok( $result eq 0 );
> +ok( $result >> 8 eq $expected_pass );
>
>  # Deny capability { sys_module } - EPERM
>  $result =3D system
> @@ -43,12 +73,12 @@ ok( $result >> 8 eq 13 );
>  # Deny system { module_request } - EACCES
>  $result =3D system
>  "runcon -t test_kmodule_deny_module_request_t $basedir/finit_load $v $ba=
sedir setest_module_request 2>&1";
> -ok( $result >> 8 eq 13 );
> +ok( $result >> 8 eq $expected_fail );
>
>  print "Test init_module(2)\n";
>  $result =3D system
>  "runcon -t test_kmodule_t $basedir/init_load $v $basedir setest_module_r=
equest";
> -ok( $result eq 0 );
> +ok( $result >> 8 eq $expected_pass );
>
>  # Deny capability { sys_module } - EPERM
>  $result =3D system
> @@ -63,7 +93,7 @@ ok( $result >> 8 eq 13 );
>  # Deny system { module_request } - EACCES
>  $result =3D system
>  "runcon -t test_kmodule_deny_module_request_t $basedir/init_load $v $bas=
edir setest_module_request 2>&1";
> -ok( $result >> 8 eq 13 );
> +ok( $result >> 8 eq $expected_fail );
>
>  SKIP: {
>      skip(
> --
> 2.33.8
>
