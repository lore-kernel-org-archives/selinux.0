Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0D3214
	for <selinux@vger.kernel.org>; Mon,  7 Jul 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906505; cv=none; b=igTGOb8SlHfubDN74isoO6fhnZZSas6UBQ1gkHCCV4fykU5Ljxib9yZx1y+N6DuGKY1+S4Wn875lf6LRLnyQGXRBXuDrrKDYDba/M8J7+3upraWUGZAiz6YPQXd2Jdh58sZ6IYD2zFyIYEhHumfEhaIC4g2aK6isWtvX0vvXF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906505; c=relaxed/simple;
	bh=PAdUzfWH63hmXlvvvadvUzrx/s3QN/Oar8ZIRvxnw7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNdKd1BsJYmbtFUuOYy1kkX4d6auGa7R2N5c33oWZKxos19UW6Ftv6HRxKP/l0iIt94QjBhUnzyyq0TP5ixAImN+XjuplAksYwHy7P0JyUtSIorylMJwEPhc2e39ZqeMmtYugmf5kYZONWQZjX+hl8wFlGL9mM06bc27TwrVhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeUTl9iF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeUTl9iF"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748d982e97cso3069557b3a.1
        for <selinux@vger.kernel.org>; Mon, 07 Jul 2025 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906503; x=1752511303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuB++z/FMm4sFCesTK/WVVNHfEEgdYDM4tPby9Mg+Gc=;
        b=YeUTl9iFiYq4un0YF61X2UxqsLxZ2rLY9VlkY7DrG3CGT4D6MUnzjb9O0kh0jc254K
         4o377YyzyGv0ndwVOeYr2gVFspz2w5/+o8ZkgXARBGFH3UZXCQOh2bO8pfE65FgP9Rm8
         fWHDMsdydKmmcquMLA8sR1UvWZKgqOK+xlB+RW19u5nbNc8hOeqeOwNrvQlA7GoRsnRP
         2tBhJ9gtvY42SxvNrFDWmzJOo8nxy69xk16po894DAUwpR+vXZqhAFDfiDWr9rze5qba
         lU+duKzD8F3dhW1ywp1gbLm/mt9QM9prgG3Ip5azWkB5j4AZ8SOrJG8bZcYnYes0Mq7r
         xQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906503; x=1752511303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuB++z/FMm4sFCesTK/WVVNHfEEgdYDM4tPby9Mg+Gc=;
        b=I/UVWhqaUUXUJGhhwOqpZeetEi77MvmO13aq4Z4+edSy1T4Kz/e8ukD7r+ZYhXVQug
         9/VZIMZAb1jgxK9rGfJa6hhrQbt2oT/kW/HnefVONZfYK7WOVd/vLtGYOMjpI4jSiNjt
         FB7k+Iw6U15F6Qz54qIZkOomRK+pNvl6DIHUgw3Pl4PiB3zoTL1FSvauo1pRE5Umw/8J
         EYHChhO7Wv9zOgsrV/Tx9QgJVN3rhdhxLfOWZKn/Rp8zW5Cu+ojoFiBSbydjLeGP0f52
         09pnwACnax43DUnmHXZHssXQkyyvTdEkfvBYZBzzBKkhe3aizhBYNH8qpLpEOqGJZOFX
         CFdw==
X-Gm-Message-State: AOJu0YwzzqfonurM5JHWdb4GToMwgrm0/Pl51syb5koeHRybPlLKcg5U
	3d5n4CqMbGHVmWdV0KuswKkq0XoQS2I6ylP7iCrePZzThDSGc25jm8uga7zXyH58trNFO0n3dDz
	tFRzLNHKon16Cy2yP5xuEtYcdrLCjbIW+vW0/
X-Gm-Gg: ASbGnctbg82kw4STgctpPWptqmdavfDyePwl/QSlywpIG7KcUd2rWWSIRQTIgPdkJB1
	SMAzjPhEXSe6vnzxyX8UKIVvA1BikOHyf+kPBGQJ1KJr4Qxu3X/ddWw4yGAmFRXkhMZFW7LIaE2
	8UQh6UfpPFzQ2eSxUeAkbXJ2VhxJ9IcsvXkuycIsS0bx4=
X-Google-Smtp-Source: AGHT+IFw/kMlwmGT06yyiCv1j3yzUJI7YSTVCLEXI/QSyfQ8+np2m7nMydSBLE8fkzJ+BrLQGve6pBq8NwMH6WTg50Y=
X-Received: by 2002:a05:6a00:218b:b0:747:bd28:1ca1 with SMTP id
 d2e1a72fcca58-74ce658a5d9mr23000687b3a.3.1751906502663; Mon, 07 Jul 2025
 09:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705121424.1221268-1-omosnace@redhat.com> <20250705121424.1221268-5-omosnace@redhat.com>
In-Reply-To: <20250705121424.1221268-5-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Jul 2025 12:41:31 -0400
X-Gm-Features: Ac12FXwdbLpwUSNhuhaOiNDhdLMi-rzb1wwfUUZba5yrJKd8Lr2VUVyTBlSMGGs
Message-ID: <CAEjxPJ7wJJnocUvEW-79nsD+aU3mwK-Zpm90Urk-+u4s_-6_rA@mail.gmail.com>
Subject: Re: [PATCH testsuite 4/6] tests/module_load: run sh instead of bash
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 8:14=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> This avoids "bash: /root/.bashrc: Permission denied" messages when
> running the tests.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  tests/module_load/test | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/module_load/test b/tests/module_load/test
> index 98c5946..b7318ef 100755
> --- a/tests/module_load/test
> +++ b/tests/module_load/test
> @@ -116,12 +116,12 @@ SKIP: {
>      system("echo 'measure func=3DBPRM_CHECK' > /tmp/test_ima_policy");
>
>      $result =3D system
> -qq(runcon -t test_policy_allow_policy_load_t bash -c "echo '/tmp/test_im=
a_policy' > /sys/kernel/security/ima/policy");
> +qq(runcon -t test_policy_allow_policy_load_t sh -c "echo '/tmp/test_ima_=
policy' > /sys/kernel/security/ima/policy");
>      ok( $result eq 0 );
>
>      # Deny system { policy_load } - EACCES
>      $result =3D system
> -qq(runcon -t test_policy_deny_policy_load_t bash -c "echo '/tmp/test_ima=
_policy' > /sys/kernel/security/ima/policy 2>&1");
> +qq(runcon -t test_policy_deny_policy_load_t sh -c "echo '/tmp/test_ima_p=
olicy' > /sys/kernel/security/ima/policy 2>&1");
>      ok( $result >> 8 eq 1 );
>
>      system("rm -f /tmp/test_ima_policy");
> --
> 2.50.0
>
>
