Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D05FDD7
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856632; cv=none; b=tbSVLTozX2/o4FIcbldlXaridxBDU2QvxKZde2kem8ACOlFOmqogSwxF0rgIJy8nPXpVsKnyF6o473JmiemSe9s4aamXIO76icv9LJIFXsiEgi8ZXqZiAMhCJCmw42K2F01483KZ+ACbApO8wXrs4BGJlEbis8DgVZURV7wcBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856632; c=relaxed/simple;
	bh=LAxO6lwm1ExXyMRJIHbwQxuY7cr8JXQZU9DYEIHloyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKwt9tUs8z2tHqIgvnTacErbYYMjATsNPhVmbHD/6ROjQlpeY3197wE7SU1Pka7a+1k59K3SdT6wl54a/l6AUMQQ4gyYZm5X+InhhpqWI+WYSgWsbZ0gptEu/THoy7My1n3onZ92OZ6DjJRAC9Rhlk0S29WhP/kkhq/ju7SiWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTT7Y3Ga; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTT7Y3Ga"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d5c2502ea2so1963322241.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856630; x=1708461430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB+dUhS1iaSSsRm301T/ecNPuNjNxvsVRs94+WsTlYY=;
        b=RTT7Y3GapELjKokbOgwbuuQeVmZvYFEdcQUFRW0u8t/USf2kS/2yJzS6O2+KQn/OVV
         r+EoC2hGO9GeS+L0rtfua81SwX7gQq5+F6uTiKglnG597MoIKGG6OGEKT9UsQFFRx6RJ
         aotodT+0nXnN7i6KJNJiMedJFVBLv+GeUC0asxRhPOlyTa6fRb4NKeoBLjl9+DzoIVXj
         0Z19D7hIhQexfX/kHdGz+Kd5zlirvhuyFN1BQmqdFMkSFVaCPQnsERCaGrpQu0+7y5DZ
         H9yDfL8uXPCYtcw9wdvdAKwdoQMkX8Ob70EyJR17MYveXImn8Y5ENeGGAX1OXtFQ7MTO
         yjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856630; x=1708461430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AB+dUhS1iaSSsRm301T/ecNPuNjNxvsVRs94+WsTlYY=;
        b=aED/G71ibYShW+ohUd47DnfXDgjs+m/cMwUMW53dka5QthVSY9k580NKcfSUCyPzF/
         nfXgR8zZXJ5QISm03belFz0/fx/gyYrsUX/4IKp7yokoB6jkSAnnGz0hFba7w3GR8Sqm
         vst/OOyf94u4P4zpm0LeCsz6WH1OyYaZa3ENU97T2Pq2UHsSnMAMahIh89g2n/totAsp
         8aBSffY/AIIHMqpEB36ZfQtkAo0KLle+PXaazAGTIuX8QJUc/L44a3FBG1PSWpqfdJrY
         4uFx+jozJYSnYbwQ7tZ+spUnpmhjMhW+QLd3Pi4k5o1n8Xl13D2WCV6DPjxu2X1B0rLa
         hBtg==
X-Gm-Message-State: AOJu0YwOIWm1QJ6KofqObHkdmz6IHoYMdNW1h2rKdJP3Kbdw2LgGT2hH
	z6S/330eUnwkjmmhaunqQazG3MejL1ybyHj/yiIt77+MuxslPpWpK5X+uDSNarizfizTKPHdj+q
	nzGaG1Cp7Ic2fQOqP9UF25ZkAAxg=
X-Google-Smtp-Source: AGHT+IHueFsCjZYb6EBVUsq4ofBYCuuJ/oSdb2flFWFGErIJbqe+0lkGbG4e1gZUZ1H+5FalLx3q32Tx0HL+QSN/hcc=
X-Received: by 2002:a05:6102:3be5:b0:46c:fb37:393b with SMTP id
 be5-20020a0561023be500b0046cfb37393bmr604721vsb.11.1707856629842; Tue, 13 Feb
 2024 12:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-8-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-8-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:36:59 -0500
Message-ID: <CAP+JOzRBz8nQ27QBuu=+=x-nUcvpq3SAAd7qH+tz2o+vyLOs8Q@mail.gmail.com>
Subject: Re: [PATCH 08/15] checkpolicy: bail out on invalid role
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Return early on invalid roles in user definition.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 97582630..44236797 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -4244,7 +4244,7 @@ int define_user(void)
>
>         while ((id =3D queue_remove(id_queue))) {
>                 if (set_user_roles(&usrdatum->roles, id))
> -                       continue;
> +                       return -1;
>         }
>
>         if (mlspol) {
> --
> 2.43.0
>
>
