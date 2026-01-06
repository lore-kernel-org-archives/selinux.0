Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F719C54E
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737049; cv=none; b=n0iVyuXexUxCg/ws8PxZSNp71lMd40SUYWitFnf4R3nov9wYRDN3NPq8H6YDwqQ1mfYu8MIZSOPZVEHJJg2FlUIbSI4XGTTQBU5tLh4O5B1KEK4tDng0g4fGSSWVpM2SqDAkOLVhKbMTdORuGB3n8T3Tal2+5lYSkMZ0w2zWhsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737049; c=relaxed/simple;
	bh=yolc2FzPr+8eWZAEHVPEtVdcRKMkUt9AjD2OpO7Ytmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZx7WVAVz64XHufXAAkkc+C1UAGd2pnDMPf34tSS5pRTrfcjII77RbGtHGc6w9JibiIKjR5xBmQ/IbhJoKsGKSxZAPOQZHJy9LiDMWT9gRnyFmaMxPikp0I/6he5dcOpQlGAp4nUkLrNVTVmwXrsTH4x1Qh9c4pgRgJLJzGPcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Bu5Ae/1A; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bu5Ae/1A"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso1078659a91.1
        for <selinux@vger.kernel.org>; Tue, 06 Jan 2026 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767737047; x=1768341847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZn7zHjhLIKjA0/VVgeJ76w8DrgDdK4tk+KG91jzuMA=;
        b=Bu5Ae/1AsyiLkIjbaha2BCAH+6bdHEtWws/pFbpqDbjZ0GN+wrjTHTT5uojNXUU1hQ
         woynRJcYyFHdKHKaf0mflJCZyb9O1YxxFp5LVkHlfzxPf3WZ2jzv+z4pvvDtBGZls1og
         7a+lsAxOKcEvnhD/yR90g8OYWVW9dzbceN3RkjZP0M9dChTE7TktOLMf1cvBZn/WPhqx
         NfYTK22SPtNBYvxoa3+nXUy2O2uzHn2s0G30d2I93rGmSWF0s7ajgP676W/jzy/y6mnw
         3cY8crVzfVTIiTuWIRkEKm/YhF7kw1385crv9l52I0b50HestxzCvNL7AjwhE0tX2Ide
         q7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767737047; x=1768341847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZn7zHjhLIKjA0/VVgeJ76w8DrgDdK4tk+KG91jzuMA=;
        b=AiIoJ+Y3ukKQBe0NHDQSZVgKr+iNNtYL2jC4sq3lFl/YnBpHQEdQYhNRQIhMaNyKLv
         chMEWQ6M6XYuMgMTZE8oMB3wPFyZuBPtB2xdEDtZ+Q3AlAHBL2nyOYqZ5u8DxJg4WteX
         V8CoqBd7B9UMGkT0yHTpHmHttFd53FCOE29YqT4roieVBC4RDlvSJn6xJylSt7cylWzM
         0Yo5qTAMS0m9CYIqfCuuXeqj1TA2LvGocelSH7+gpkqWq5Rl2GOoLWdcCDJ0R5KQxiQY
         Z98AZkV0VN5OOt1TIBW0ZKxEqu+ISdBZNDD9820Eh5lTwCcg/YBomurEU/55GTkd+HkL
         uK6g==
X-Gm-Message-State: AOJu0YxK2dXz2GrAoFGCDJdnumhiOasUZUVvyfzAH6kWwnFDI2AJW7wd
	hF5U/feA5jChvur3BcdxLUfeu5EOEXKAHbgPM/elQj8lDDHK2bFxtbsf5PHyMxi34QDYc5OWkBv
	xP7IF//8OJFjKyJkguJ9CoRimcWgXTDMEDRBPIvUJ3rnJTL40uiFGTA==
X-Gm-Gg: AY/fxX7XuVpxXpC93si/dqajmRBJZi+bDpeww6mX79ctGpuMs0ff2idGYT9INhe9Kpk
	oZo9fjquNcb+vY2u8aCMuoK21/vmibb8PLER82qRK4uVAR7wZkF8skGwbOVAcsba6qs5VPW6Ohg
	ATEYrNNiZkdob6AqNm7OWBcBw9dKy6PJSZtmH9SxzYDrWR20VirIwPkKLCCDt1CI3Q67/ZsIK/7
	Y3NwbXeb0wa5SKjyBe1MjBeWKwslVroA5ZZU0PiTsNI7d4FdsSJoQIOEgciUcvvNQOQmPE=
X-Google-Smtp-Source: AGHT+IE6wg+rg0vgwiJm8ciyQ8TbKRfqgNUgaooTTfym0vLycpNfLxfKqv1c62XObNRwsG8iyjpy3oXEiwqqcWUZtdo=
X-Received: by 2002:a17:90b:2883:b0:340:be4d:a718 with SMTP id
 98e67ed59e1d1-34f68b4e70emr479424a91.7.1767737046670; Tue, 06 Jan 2026
 14:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105174020.887724-1-lautrbach@redhat.com>
In-Reply-To: <20260105174020.887724-1-lautrbach@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Jan 2026 17:03:55 -0500
X-Gm-Features: AQt7F2qK1EnEqi5Pe5ip4ueqlkEOE7p8MVWlKsoU-aW28vWQoehLXZ-0dJb5GM8
Message-ID: <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 12:46=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> The key is available at:
> https://github.com/bachradsusi.gpg
> https://plautrba.fedorapeople.org/lautrbach@redhat.com.gpg
>
> Also update the email address
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---
>  SECURITY.md | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index 2a7ce5b317a7..faa060ccff03 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -24,7 +24,8 @@ list is below. We typically request at most a 90 day ti=
me period to address
>  the issue before it is made public, but we will make every effort to add=
ress
>  the issue as quickly as possible and shorten the disclosure window.
>
> -* Petr Lautrbach, plautrba@redhat.com
> +* Petr Lautrbach, lautrbach@redhat.com
> +  *  (GPG fingerprint) 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13=
E

I think you may want to list the fingerprint of your primary key and
not a subkey, as the primary key is what carries the signatures and
helps verify trust.

>  * Nicolas Iooss, nicolas.iooss@m4x.org
>    *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5E=
B
>  * Jeffrey Vander Stoep, jeffv@google.com
> --
> 2.52.0

--=20
paul-moore.com
