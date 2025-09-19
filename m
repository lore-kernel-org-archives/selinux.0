Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915C1DE2BF
	for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285409; cv=none; b=bfWu60F6cIFg2HSD2ZcfGtzccR22nqV0IbRkr9f9lAJaqZU3ZkXH8agBU3NghqFoYlMEXJ1/y6N3g1hcT4St9JRqwV1vlT4H04bfM+spFWxh2xq3Vx6qnbt6o5P688TYT2xDcjH1qLXX4bbDQzZJiKa5TX/vehKiinBEwkDDEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285409; c=relaxed/simple;
	bh=ItCZQv++MaHYEMA+uysHuieNug/nYE0FC70KBObNI4I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YV1a+7kF4bmTSMxIKE29dQrqVRMNX3td2RqFFVnN8RaIEQ5Fll8JtLd0cLtw6aCMfNazKW2SVRaLi1N+jGu0z0FFfnb+MAkRBb2iab0EOIrPeARUEO/rSWhRM5lGgPTOr8BioZ14Q9MIN1ui/msxcDxZywMaiDCruOfQm6C8UmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dvqIzD0m; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dvqIzD0m"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fc2d92d34so1369893a12.2
        for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758285406; x=1758890206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItCZQv++MaHYEMA+uysHuieNug/nYE0FC70KBObNI4I=;
        b=dvqIzD0mA5E/mmP6LIIx0LTUXqzD2f7og21uKv9pdd49hGkZuHOUmaalcmBzLl1del
         ITTgT9yoLExtLh9oA0AckLYtR5hC7YiuScAxhtWrWmtCagQJBdMfq4VvcgaQ/K9uZetU
         2XOjlRZ8gq6nM7WvYrhYLtAjqz0QKZXykK0nV0pM1fd6wPc5YYRQjrZHJ0In8W/PakLj
         VtDD+I/Q3Qq1iqciojn4M4ofAipU0uMfkFFQUr0Nt1ZYedNyxLU+BnfNaEZuZQJ4G86t
         qzrXjH/2b0gOegD6xKt4r2BRYrqAgHAcq/P7l9ZsXnBYEFye2gyZ0pNAPpDHujgOr62o
         Pi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758285406; x=1758890206;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ItCZQv++MaHYEMA+uysHuieNug/nYE0FC70KBObNI4I=;
        b=C39L2OzXCXubIa08VdtnvKheyex3aL3yk0x7ojZP3DPyCx8ZuA0vjsrPdzlX4YBoov
         /vEZDvJObB0akaNh8ozT+vxC7e+MJ2XZ98vcBtKp7iqxsWuMIAs/OaB7OiXFxILUEUU5
         Jifw+G859PV9Bq/vi7LopyZ6ZfwFFY9TkdsUIZ+C4g9/0w29Lr9sRDTa3g+96jvqWVV3
         6jMQZ45iYy2K5Yd018ydjyAlhdrWzvpeh7tXMZMt9QUkHtpfnh0dg3e78We3hzf/+H2g
         7RySgAXrsEDBlsdEFtNxiky6gyWNuG/+LSogcAc+SqT7+n2crk5qB78Ry2pofKL2RxjV
         mdvQ==
X-Gm-Message-State: AOJu0YwrDafcTsZvVTWGCNKUWVP/rEzopJlbRsyNTnQNvkXZ7HIXU6R0
	C/+ILD/g2W90EH3QXLsnmfr965RkQjZwH3OdXOCehknxofURVoULwCnoPir7PjhM
X-Gm-Gg: ASbGncv+aqfNt2a8M+G2LzhKD4ah9RV8dGwb3A4JN5RlBg6NgGKqhyWzVGZ9yEwp73k
	Uh1dahvhIios2T6nNxv486B3xddQ9RIeyUpcQXK56egjO3bBkAINt/0WFLrfuuG31pZu+MM/TgJ
	VuMTW+72DzlxhQipcaDlVDS8GeaMBrrbKkwjX7VjRlmOSx8QHUQGgSPVY4f3/mbKD+2N5wZDFxx
	VP19M6ezPduSMcYhFD1GJNrwgqWGAVDSy0W+gSHPp1cQw5e/TKV+LHMl3F4k7ZBlhVtaPMtbKh2
	K8E4QOCfdS0j99WwsiptpBER2HdJBH2kkVwZkFXPFbsrdjFwlto2u0foxzZFPjPwtVZzGUZ17Xm
	Mcg6e39NnJ4c0QC8I5W/E/19vcrhF9TnwMp9P+0k5K1baGtNSMHugc3SFYBg+u8LnctWEuxTt
X-Google-Smtp-Source: AGHT+IG/pj0a4Hrrciz0UjpDPHqR9b3YWqYFGkSnD0g7P832YVswHPDXBnfQwORlT/RAOrzuKDpqzQ==
X-Received: by 2002:a05:6402:3202:b0:62f:43cb:e8c8 with SMTP id 4fb4d7f45d1cf-62fc0a78139mr3245481a12.22.1758285406017;
        Fri, 19 Sep 2025 05:36:46 -0700 (PDT)
Received: from [127.0.0.1] (213.209.99.84.static-pppoe.dt.ipv4.wtnet.de. [213.209.99.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f2702csm3305753a12.38.2025.09.19.05.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 05:36:45 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:36:43 +0200 (GMT+02:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Message-ID: <4f3cafc8-54da-4092-a383-49c168b4990b@googlemail.com>
In-Reply-To: <20250919122100.181107-4-stephen.smalley.work@gmail.com>
References: <20250919122100.181107-2-stephen.smalley.work@gmail.com> <20250919122100.181107-4-stephen.smalley.work@gmail.com>
Subject: Re: [RFC PATCH 2/2] systemd: perform SELinux initialization again
 in a SELinux namespace
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <4f3cafc8-54da-4092-a383-49c168b4990b@googlemail.com>

Sep 19, 2025 14:24:42 Stephen Smalley <stephen.smalley.work@gmail.com>:

> RFC only, this demonstrates the changes required to systemd to
> perform SELinux setup and initialization when run in its own
> SELinux namespace. Otherwise, by default, systemd currently skips
> SELinux processing when run within a container to avoid conflicting
> with the host.
>
> Modify systemd to perform SELinux setup and initialization when
> run in its own SELinux namespace.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> src/core/main.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
> diff --git a/src/core/main.c b/src/core/main.c
> index 3e7894ee5e..fb903b7646 100644
> --- a/src/core/main.c
> +++ b/src/core/main.c
> @@ -3164,6 +3164,21 @@ int main(int argc, char *argv[]) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo=
g_set_target(LOG_TARGET_JOURNAL_OR_KMSG);
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const ch=
ar *selinuxns =3D getenv("SELINUXNS");
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (seli=
nuxns) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D mac_selinux_setup(&loaded_pol=
icy);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 error_message =3D "Failed to setup SELinux namespace support";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto finish;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mac_selinux_init() < 0) {

Should the return value here saved to the error variable r before jumping t=
o the finish label?

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 error_message =3D "Failed to initialize SELinux namespace supp=
ort";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto finish;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Running inside a container, as PID 1 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo=
g_set_target_and_open(LOG_TARGET_CONSOLE);
>
> --
> 2.51.0

