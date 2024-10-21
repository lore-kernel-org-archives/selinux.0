Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7491E573E
	for <selinux@vger.kernel.org>; Mon, 21 Oct 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532122; cv=none; b=YuQ1yoWO2/MBzEAimWFNEWSyyKLcVZJmtf5H2GVEV5lH44seqdxZtYSjOMYHQY9xHFipbgTrpNlHB91BN9T0Y67AC15JFhJMYzvzD4pWj9Zeh+/fbckJNJIr8OZHK3e98+8kdOYmzMZwvTQLaW9ObWKgAAnMgXV2o9MisKoX1lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532122; c=relaxed/simple;
	bh=NixG2MqnSZWvXZAnOW0XgHgg9coCJ/+3XNAkUa3oMzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDqWvAjKHGrf5FsnuJd8CZhjCFxKlp9VsnqQYizsgdbv+PKNVxFZ/+tkLQBvpH9k9ZNtd/5m/Jbhot4syOa3vQtDOPuZhhg+OcXRKUo/Kp4JNaSUMB07+aS1DBJJnglE31duRXAr7lPhnffgToMyJGYIRJybr+OHt1oYQUJnLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA8JkVLy; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA8JkVLy"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a47d1a62bdso1126274137.0
        for <selinux@vger.kernel.org>; Mon, 21 Oct 2024 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729532119; x=1730136919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18ANe5LIsMWTXO2qEjSmhQCNfmADHEfcpR5+SmldDsA=;
        b=IA8JkVLyOt35W5VbPXksNLqyYR4BHnt+yc/n06cJZOqQwdgHiaQftJHt4344Obx1UZ
         nmWdbT2RyBJjaPpshAAllrB1yeM3ilB4VFagNNJJT8ajFFmk2pBrW9wr+hXXDXho+uHR
         sfV8iRxMhTrcF5zONESXvs9NqeNq8YIFEk7B0StXJsEW73aorrnzDtPZtyDpF4bA0uho
         4jN251rHLkbTE+wp6uJkeEnQlZiSmvVcrIAZN4IAx8k31LHb0LHdmBJwGg/3kEysNHP5
         SZpx8tA2v4FFHZ0R9NrEdNXMdpTuBUwRezh9kjCDFXd2bc8YmIOQAWt7lko2WymKcGXc
         Qy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729532119; x=1730136919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18ANe5LIsMWTXO2qEjSmhQCNfmADHEfcpR5+SmldDsA=;
        b=AaPUFKncFJJs2Ewc0u/H6lODabNVb9BsQOwPE3MIDYZshwZDtoC7XVwF1aq0Bbt2Yp
         DcqJoliAv3ZHb7Sw4jWNytOBRENdDtEQE6RnPC2E7gtgkv7aPsfsGlwky5p+nGbUUbur
         hzJkwRgIs6F17Y41D5/+tEu3hatC2Ox08TTJ8d03XCw2FqBBW/NU2wDW/RZ7iY+T6Dvo
         oe79VEpfGbwwCYH5BbqkMhocMtZ0vbPYw1QI6379v+qKlcPV47xMl44ih6wv7i5n9Q9i
         14pjO+9trcMFZuws30cW0ASHfL3nXjwtoa62KQ2xn7ancXK7Tt9Njq0ujnbzpGGI2EiE
         ck8A==
X-Gm-Message-State: AOJu0YyLL5wm8J0tUZzGVg54PASQQbL2GBwMi4OrBigDOh6Z9FzjhciB
	RzOrM2VTl+OGikRAaPzs0IkNS+M96R6TTHjJJa63Dc76NOcHUaMlcrU65zEGtKQZLwuZe2eiQlN
	VL1wEi6AQZICOo8GlYqqzkCX7qGQ=
X-Google-Smtp-Source: AGHT+IFpKIM7Z2Xf84vJ3tRgflDARnOa7wa7yUPX5bmtPE6wdfUUKPcPaCLUFt4xYMVhgfv2SAJmrAZoNGTE3mWGKwA=
X-Received: by 2002:a05:6102:5112:b0:4a4:87f8:f414 with SMTP id
 ada2fe7eead31-4a5d6aa0ecemr8490068137.6.1729532118713; Mon, 21 Oct 2024
 10:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018151213.444982-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241018151213.444982-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 21 Oct 2024 13:35:07 -0400
Message-ID: <CAP+JOzQ-e5u+tXD4f0DhtWHW189=6MzFvbDGeGTvd=GuyMTyNA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy/fuzz: fix setjmp condition
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:23=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> setjmp(3) returns 0 on the first fake invocation, adjust the condition
> accordingly.
>
> Reported by the OSS Fuzz Introspector[1].
>
> [1]: https://storage.googleapis.com/oss-fuzz-introspector/selinux/inspect=
or-report/20241016/fuzz_report.html
>
> Fixes: f07fc2a75 ("checkpolicy/fuzz: override YY_FATAL_ERROR")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/fuzz/checkpolicy-fuzzer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/che=
ckpolicy-fuzzer.c
> index ddb43260..331201c0 100644
> --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> @@ -101,7 +101,7 @@ static int read_source_policy(policydb_t *p, const ui=
nt8_t *data, size_t size)
>
>         init_parser(1);
>
> -       if (!setjmp(fuzzing_pre_parse_stack_state)) {
> +       if (setjmp(fuzzing_pre_parse_stack_state) !=3D 0) {
>                 queue_destroy(id_queue);
>                 fclose(yyin);
>                 yylex_destroy();
> --
> 2.45.2
>
>
