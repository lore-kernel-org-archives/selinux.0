Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98581E32DA
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261178; cv=none; b=OSzAjXehQfjtO5rRB07UwLptPTOGbSybeiNRDHchq/eI6Fvr0XhLTpG0qQMDaMr83qxPZXegiZocohfKKdWTBqkDh4mzdpXUdp1CJuQAD+zo92pioL2PDUul9rM/6GH59qQX2zukd8o8qJI/2xf8PHjoS1z7O0q/Q8Xuyho6PtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261178; c=relaxed/simple;
	bh=4nOWYvCb9ZfU+PyGQfpk3Jm3Aq4nNY8tSjlMUENWrwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzjxXdFS/ML4fJIjIAUoNvF5fX4EzKd59GQVpSZ5QoDYmLgh1pTwlmlmC0oMUnqdyeEk5WU076qPMA+2NQZfOpbp2Cp1MGlPaFSSuQu7M0tyRskAIwNIBpQ8MBG3tc4H+xYNbOJ5TQ0/qZtC/2vfHK+IKH7C9OC2QzcN118NJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR3XQhZz; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR3XQhZz"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51878cf85a7so4611989e0c.0
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 06:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736261170; x=1736865970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK/OubUAgr6mIVS6X0DMWmzjs18FZFXpSc50240dhDU=;
        b=KR3XQhZz+iqo+7gE8PGIP8jHFWQ55T9o+LSHOjgnh0gEukZIhbFGdeuUZqJmHdMlmA
         hvfUPF8nJoI9FnN7SXUk6bJcWxhmfzC7ULFe56B1XunFHz2h58eb2MVJDkZRrBmzRcUZ
         QErPkJu0ZWDV8CBGIB3qnYMC/RgnvKdvp0VMgNqNAc9HCcI/P4oUutNJI1qjLcxuyswj
         TT9l16UKsrCTsk0P+mWDLCpFL00LcF8Qjes9OlaFeQKZ6RMlKobDvTvfK8HtuWW78uFq
         kNsUugTGdkIyTndQO8vu0rWs71sjYGixS5WWmWp/64JzrBkzT6ya2wtru9wZeTx8n20P
         FL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261170; x=1736865970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DK/OubUAgr6mIVS6X0DMWmzjs18FZFXpSc50240dhDU=;
        b=B18ERnoGZSL4+spHfGEGd2Ql84LbLekcc5lct6PIv7iXQjCRd8kQ/fbmwvKE8Hl8Br
         EvttNrjvLNrS5+KiFj0KNbtQGx46UWxi07agLcaaE0Svx+D4K9u9f1dCvbDQ67QNRcr0
         0Ga681dTlqacC9uNdFrX/PkUEwULAfPPEDlJn1iq6vb8L1hhjRP7a2tyLz5y/H+GZqSF
         i6/BF/nQUECr79Vv8xSX2ELGpJURhuPlR4pjRgKcPsoUWhKjR+i/QtEveohEvdesNYWj
         vQRf0LYoThpM6JwfAZQ0s3tHA5Ab5CVF/YFAcfzN0/Py3ZI0uNOzaojzDTj3qx3pR4hZ
         tOrQ==
X-Gm-Message-State: AOJu0Yzdi1pXqvknUCXE5wja4yVSSGFEw8U+LgQd2ni/OJMH4ELA3Icf
	9zsQnoxaOul8uJ3jtr617uYK1l3WAgjeSXk/im1c90gVCrQjt6IWtTYFOS4Jl18Ul9brRSjRbF2
	bAan2CaHvGC+ovnTVroOYWfsCxv/tmw==
X-Gm-Gg: ASbGncuUMfv5op91aMjVFdCECs9xofQuGp1b35TFs3VC17aY303B51Net6s8v3YgOIM
	AZPkly6PyaSYNmb9YZWegPSNT+NACDuRq0RXRWA==
X-Google-Smtp-Source: AGHT+IFjfEyCaF/OJr4Whyt4RMquFVqZfWHpQ/tCxXUmV7vDBFQCdFn5yjPdAJvUa2G4v44gm9SSx/GjsPmAhGO8rxg=
X-Received: by 2002:a05:6122:6029:b0:51b:8949:c9ab with SMTP id
 71dfb90a1353d-51b8949cb69mr31683206e0c.9.1736261170293; Tue, 07 Jan 2025
 06:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230135114.41947-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241230135114.41947-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 7 Jan 2025 09:45:59 -0500
X-Gm-Features: AbW1kvZ0rJ3Qq6UkkbochgxI2NtElsWkReSUQ1ZplCkhxENdVTLlpc6onggQr1U
Message-ID: <CAP+JOzQBAMW3zi18Txb+RWavJKZkGxGFGDguC+SxBvcnXaR4bQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: update max node depth
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:51=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Bump the maximum specification node depth from 3 to 4 based on updated
> benchmark on Fedora 41:
>

I am not sure I understand these numbers.

>     Benchmark 1: /tmp/destdir3/sbin/restorecon -vRn /
>       Time (mean =C2=B1 =CF=83):      1.397 s =C2=B1  0.018 s    [User: 0=
.755 s, System: 0.641 s]
>       Range (min =E2=80=A6 max):    1.353 s =E2=80=A6  1.419 s    20 runs
>
Is this for depth 3?

>     Benchmark 1: /tmp/destdir4/sbin/restorecon -vRn /
>       Time (mean =C2=B1 =CF=83):      1.376 s =C2=B1  0.021 s    [User: 0=
.737 s, System: 0.637 s]
>       Range (min =E2=80=A6 max):    1.348 s =E2=80=A6  1.414 s    20 runs
>
Depth 4?

>     Benchmark 1: /tmp/destdir5/sbin/restorecon -vRn /
>       Time (mean =C2=B1 =CF=83):      1.389 s =C2=B1  0.021 s    [User: 0=
.748 s, System: 0.640 s]
>       Range (min =E2=80=A6 max):    1.351 s =E2=80=A6  1.420 s    20 runs
Depth 5?

I see the comment below talks about more memory, how much more memory
is required for a depth of 4?

Thanks,
Jim

> ---
>  libselinux/src/label_file.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 597b756e..41b2a939 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -105,10 +105,10 @@ struct literal_spec {
>   * Max depth of specification nodes
>   *
>   * Measure before changing:
> - *   - 2  leads to slower lookup
> - *   - >4 require more memory (and allocations) for no performance gain
> + *   <  leads to slower lookup
> + *   >  require more memory (and allocations) for no performance gain
>   */
> -#define SPEC_NODE_MAX_DEPTH 3
> +#define SPEC_NODE_MAX_DEPTH 4
>
>  /* A specification node */
>  struct spec_node {
> --
> 2.45.2
>
>
