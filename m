Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42642550D7
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685843; cv=none; b=rQACsm8m+FTOh7SgUWK536Hed4YPai448S21sZxOuTDlIAHnFgzKX68A1a6hXhGOeKplrUrhRRfq+UVc61clLjS3q3DwHYBK98pJ0nqqCvwYS6jfpoEurc/dp2RyNyzlh3T8pAz9i9nl1I0qzpReTu+9WlFDIrA93LVSEzE+XKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685843; c=relaxed/simple;
	bh=IWNF9V1JsobPRKjBizRrFx4q2LJk10MCWBrj12YMPek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoQBL1szj77Eq+iQrbYIcjutmqR7218Ru0Bj60qcJJcaXBo3iQlWo4qB8SjW3K8eA0hgCqgMjn8lqiATZENDdN4nPst1niNMHiNN3y4jfN/mj5Zelvt79AGeVyV/D3KGi73M37ADl2BoaGBiJj57/LyLZ7jwmUAIB5t2RUeYxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6FWtlmw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6FWtlmw"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af51596da56so3305630a12.0
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750685840; x=1751290640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap4fc5ycs2BNX9cEfdAWDM3auCpIqspbpHFJ6dn89o8=;
        b=j6FWtlmwh1G3wQYHoGbCAk+p30ObbrXJ6HVp5JPP/Lwor3bsMwzjA9Tw4rM/q7LVsv
         g9nJwjQ8E5tLyldiWwARfAmu6//QEcGAXeufZgtUcBXCAUGNv2v5RL17EnZaIfOyfx/p
         BdiZ/ZjdCSe1z9xYAECUN8sSs28rb3PQHxynF6qv128vH5VByCPgHRsohu5S3DXjLXOa
         sEKIGqPFArKcaAErlowOMIRHIL06xSLxT0Ow/SBMvGKumq4L9K88iEXKmiUoLSal0wkt
         D6rx1cyi1Ty/hCio6r6MXhkaoKnOQwFYdPbzSkKM1V2t1kDxcybYJshXA18yyTPcH76y
         L+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750685840; x=1751290640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap4fc5ycs2BNX9cEfdAWDM3auCpIqspbpHFJ6dn89o8=;
        b=Bt5hpbjDWswzn1vf45IPp1mJsZCpS7ecJ8C8uQHxznBARhR3rmSmmHuSMwHlvsPDvd
         zUTBuDJo+kOqHx07fjAUZ9i5nsNiUnQ4uPdPCSQ4PJnoOCby3VJJvn5NMQfOlEA4HfmF
         A9K0L3e2Q17D/dPwEklknr2OudaOxMT9f5LDenEej+TPTkUF7LfjY7Q9Udoj3l5kFQBd
         V7sXsj7zvZgHpzao04J/YCWKrApApSVr7J+iButnstoEEb32H+f2L1JfJXBkvyYabrl4
         YiGMfDS5CLKLR43OwPrV5LbxnaOhjRBwvh6zWBFaRzj36VPYUJhyyn9TybBPybYDU/LD
         SU0A==
X-Gm-Message-State: AOJu0Ywdp5q7OYSQWdmm1xD2FQ0FFLz8uoB9niWwtWzAcaM6H875J3vO
	8Ccy7gu6RZKCEnFmVPopWV8/GFKFD+yMWgDjt1CZ3yvtbbkkJosVTwnumfY23ipMKNlghiX7u2+
	JVtlurrpnHMUXo+ETb24qDVRa5z0rf5Su6w==
X-Gm-Gg: ASbGncvOcVtPG9l6iLu/lAcUv8+seVOaG4Xqs5RJSqphmv7tim4gd0BCuAO3Exyfn/a
	MFFcAVDua6J2bbbr3V6N77NepKtCAkFFUilW/cy2kkzUOdpn4tXhknUlGlqOcWHqh1FrI31jyvw
	/4Qah4chYkdCKh4XeAqgNROSRICty8q7ht9DmOUv/LCgY=
X-Google-Smtp-Source: AGHT+IE9o/iSUeHiVg0EZrCUfaquJ5mXL/UTSzhhN5L8/fIEHSsxoIP7W2W5Gg2pin66CGZrwCO7fzSZ3trrQvPhGDo=
X-Received: by 2002:a17:90b:4a83:b0:311:af8c:51cd with SMTP id
 98e67ed59e1d1-3159d8c80eemr24994576a91.18.1750685840488; Mon, 23 Jun 2025
 06:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618162942.124309-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250618162942.124309-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 23 Jun 2025 09:37:09 -0400
X-Gm-Features: AX0GCFt2I47Q5C6IWxs1HtBHkoxjPpl3KBi_MhHTU9mgA_uD_iHJ43P-mat89MA
Message-ID: <CAEjxPJ7aTXY8auUXx5CiWBV2JMwWguMmVp5=oXs9faHdg3RPtw@mail.gmail.com>
Subject: Re: [PATCH] tests/mac_admin: skip another test on nfs
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 12:31=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Skip another test of undefined label handling that is not guaranteed to
> work over labeled NFS and breaks if SELinux namespaces are enabled due
> to the global SID table correctly preserving the undefined context value,
> producing an error within NFSv4 for which no error handling path exists.
> Possibly consider disabling this entire set of tests.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.

> ---
>  tests/mac_admin/test | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/tests/mac_admin/test b/tests/mac_admin/test
> index c28a7bc..8ecb48b 100755
> --- a/tests/mac_admin/test
> +++ b/tests/mac_admin/test
> @@ -11,7 +11,7 @@ BEGIN {
>          plan tests =3D> 8;
>      }
>      else {
> -        plan tests =3D> 7;
> +        plan tests =3D> 6;
>      }
>  }
>
> @@ -49,12 +49,13 @@ if ( $isnfs ne "nfs" ) {
>        `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`=
;
>      chomp($result);
>      ok( $result, "UNDEFINED" );
> -}
>
> -# Verify that test_no_mac_admin_t sees the unlabeled context.
> -$result =3D `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_=
dir 2>&1`;
> -chomp($result);
> -ok( $result, "unlabeled_t" );
> +    # Verify that test_no_mac_admin_t sees the unlabeled context.
> +    $result =3D
> +      `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_dir 2>=
&1`;
> +    chomp($result);
> +    ok( $result, "unlabeled_t" );
> +}
>
>  # Delete the test directory
>  system("rm -rf $basedir/test_dir");
> --
> 2.49.0
>
