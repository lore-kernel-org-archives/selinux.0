Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093BA54769
	for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680213; cv=none; b=EV7FoN9tyIsCfaPnDTdaBQ+eFUVOYqqe44nQr/x4w2yxig5QJzlIRji5+uIFUIucwqi4Hw72M7024/eK2XbbSOMJbvMmN09RyWxV17XSP3+DaKu9M2/aPd1nPS75TIvN4gSyx8v/OymeIxFEtgaLlqSBCVmcrXgPQpoDgCKpgv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680213; c=relaxed/simple;
	bh=OeJ8OfkqtRzXtd2EDdJWQdPjtTAyWSbhbiihj8WpHcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQfaAJju1U7Dln8slhiByXTxrH+oQvipTEvk1ILGqtMypGRrXGno22B+omPKzJDm+YH9A6hPqWhQYIeuNj3VtgwCjYVrQZsQzowODpfT8z8W72fPDi5bdSc1VRyo3XmQlwUS2e6ot7WDgzunM30RxbY8FApKxCNhYfMAz4+dS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ9UhIHl; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ9UhIHl"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ee35ef95daso305598eaf.0
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731680211; x=1732285011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzGwq0SwGB0VE/PFjDAcsBajSl6ORdHuxbkwCiqOcqE=;
        b=fZ9UhIHlKunGXjsMtGntkS7mvQNoE7QJSCv5qgWB/dSQkBqiVgbkD091mpFLbRiYKb
         Z1kre5j3ZXTpldqxnZ5T/DYxjdBKdomFCVvEXXgnc2Yj3qhztH0SAk3Q5IVhFgA6RZLB
         Kh1UOPcZ8CnWoNtq4HQYQfyTkPTTtXK91srx0StBc6fKyS1a1gfG+bYHZexMs5pKq5mZ
         byfpGFoahIG5V19Gr0ri8GrYBZfxF6pAuxYYeDZPR3+hiqXASI8Fg/0rBM2SAYHzTsfy
         95lHicETC0ZPKF8Gh6mfSBQWsrtoDzeBFs0XIDvDd3/RhT8TVcBBGfVZf8+f04a58Z4R
         ROVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731680211; x=1732285011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzGwq0SwGB0VE/PFjDAcsBajSl6ORdHuxbkwCiqOcqE=;
        b=WJ9mBKTnUkPSLDfH0kBPUQ9BS9blSxOxeFf5Dc7hdg+U/S7Oi+MjM4N12QfL4W64hZ
         D6GoTvEmhLvXXqSQbrDwY4B5rEP+KbUBORjHwGSnV5Ct1dUNYyarP14z5UhwXLBOIar3
         3osJ8XZu2N9eBLvmSmjgaF573307DmLeJaTkkvRXxofXEXH0ZNK5n39fqDW+Or/ytysW
         k6rkf1J8IfjSSBl09Gu2bISsqA3pjUJcRrlKpy38XriJ1hkiPFEfMmQCf5wG2GSnEQoa
         JpcGkE0P4ay9Xk4cLJFw2EdPeNw+aRvuD6Ez8YiQn0K8LLFZO6NtFtJYbiBFhabogTWX
         kKkQ==
X-Gm-Message-State: AOJu0YxJS9uocfEYwyrhGbFQcUlYMsab4ECp5ZUlcKbwc7jiwwykYJfP
	IHogH2p3WHHwv0RTZELORBHc4s71NkVRnfCkWdjZs7S0aqWagDEBExukOvA4cq0hRYo8d0DuM7D
	Gpbn5jgx+I8+AV9NDzOnaTkHjP5A=
X-Google-Smtp-Source: AGHT+IES4lNBB0n6bMnBT02yRuuuTTTjcB1J54HnXkNzIEmoLJkyVxjAFWGd0dAJoO4ofIt51er3yLXLnuZ5A/r+Ekw=
X-Received: by 2002:a05:6358:6e88:b0:1c3:9ab7:eb54 with SMTP id
 e5c5f4694b2df-1c6cd0be521mr142883355d.9.1731680210915; Fri, 15 Nov 2024
 06:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111123304.651436-1-lautrbach@redhat.com>
In-Reply-To: <20241111123304.651436-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 15 Nov 2024 09:16:40 -0500
Message-ID: <CAP+JOzSv0o57nSWavdsvK3AYekh+Ct82HhgyLPiewEOmGg_5xw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: open lock_file with O_RDWR
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:33=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> man 2 flock:
>     Since Linux 2.6.12, NFS clients support flock() locks by emulating
>     them as fcntl(2) byte-range locks on the entire file.  This means
>     that fcntl(2) and  flock()  locks  do  interact with one another
>     over NFS.  It also means that in order to place an exclusive lock,
>     the file must be opened for writing.
>
> Fixes:
>     # semanage fcontext -d -e /home /tmp/testdir
>     libsemanage.semanage_get_lock: Error obtaining direct transaction loc=
k at /var/lib/selinux/targeted/semanage.trans.LOCK. (Bad file descriptor).
>     OSError: Bad file descriptor
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/semanage_store.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index 0ac2e5b2ad39..c26f5667b3cd 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1899,14 +1899,12 @@ static int semanage_get_lock(semanage_handle_t * =
sh,
>         struct timeval origtime, curtime;
>         int got_lock =3D 0;
>
> -       if ((fd =3D open(lock_file, O_RDONLY)) =3D=3D -1) {
> -               if ((fd =3D
> -                    open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
> -                         S_IRUSR | S_IWUSR)) =3D=3D -1) {
> -                       ERR(sh, "Could not open direct %s at %s.", lock_n=
ame,
> -                           lock_file);
> -                       return -1;
> -               }
> +       if ((fd =3D
> +            open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
> +                 S_IRUSR | S_IWUSR)) =3D=3D -1) {
> +               ERR(sh, "Could not open direct %s at %s.", lock_name,
> +                   lock_file);
> +               return -1;
>         }
>         if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) {
>                 ERR(sh, "Could not set close-on-exec for %s at %s.", lock=
_name,
> --
> 2.47.0
>
>
