Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE24B1D10
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212271; cv=pass; b=j5qfxSiwxQdsZPYgNBpiKXZnBs5Wr7mydl9QcyG/uoFERlVZ/4vqb50TEitE/dXAfdsDOgZe2XUUG+pDJcS2Fxe3nKBYnzghKZYWgJer/m9u17QgiHhXuprF4RDwD4720QfxK++V1MZ/sNuT79hQIL/VW4KmItawa1siyrQW5Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212271; c=relaxed/simple;
	bh=NyfaJ6LqpPDeU83/vIvKX4dKNKbdA+hT9zA+yJ5zJdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sU8weo9jvttiiaU1h7nuecAMgRmhXz7IIyD3zwsgdMvXf5M0+zkF49daX9Ewwapm1xY+B56uVBHchIOx/V5l7J7ADz0Ya6soHycncv8LpCwNQg8q0Zkp4CP9BxP7eLu3GZsD/LSn2pq5fhO9RESOT034b3qK6cPm7kvZWlV7VMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjK0KIOk; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjK0KIOk"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-677d35fd1d2so1011443d50.1
        for <selinux@vger.kernel.org>; Mon, 05 Oct 2026 07:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212264; cv=none;
        d=google.com; s=arc-20260327;
        b=MW4FHlUahzsGD7OrdNJ37gnKcdGipm7aUfckjEmY0wkJEHS6CbYe3sR3yFNoSHv4J6
         VCmZbQEy1GT2hJg0H2qNG8lySF2LjzbP6nEhb5wfNxoh7dBKxg0g/95L91+nlYazm4Fr
         lFmpF36ZAuejaGFNwyXeJ33zyI0wFspedKG7jBTFnFnYRoP8Bfcdz7g+6Q2d1zo/0s2J
         Hhe/CfdeKHXZMUKebKJ6KvXdmebSqSr3Tam9NRK9rYgZLKob/EeGDgKL3rHNRAyIqKhz
         PrcEyGyAqypbdGLlDHsZoD2p7p5G65Z6jNubMeV+cVpej7VzKX/nZMDsWpL/d0eZ5u7U
         mUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NyfaJ6LqpPDeU83/vIvKX4dKNKbdA+hT9zA+yJ5zJdk=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=jAp/zM8o5wyiIWXpp1yWPiywS9IVsjlwZ33G9lQNlhcEN3AgWeN0fiSF090UKTvohC
         A8LiRYcaJQVfSSRIRzbx5P+vHF4GjjrqPjJ6zJCrR9w7TfWZjxS3dQTuqqk7unLO3rMO
         iHS7fo+PRhmrWzwgfHWRjP9dHg+DlRmHbhy+Y90V7NZTmCnjBwLueFfZDwxuyTeFAs5I
         JA2eZp1JlimOuBgu/J55QRPqaxZZEhDA0IlBt3qRist6Y3rRF+76zEUGBGoKIFXT3W/M
         wEtrBmGxOUAosrJDnBAX1jJby53CUdKci+2P3eJ3EFDGC5/nd7mxPZ7s6udOJKIc/jUg
         ei9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791212264; x=1791817064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NyfaJ6LqpPDeU83/vIvKX4dKNKbdA+hT9zA+yJ5zJdk=;
        b=FjK0KIOklGFNdZojMO05zN3W1gsN9m96aJ8VraJAjxElqoAK7g3oVsuVmTDmoEHgi7
         /CEknCpRcp/HuRMYw7nPAXvZtHhueIkcxCGI3T7pZ19TZt0DvMd0E5JrSCtRJpUv8LJR
         VMFBopqkphA6QuHzkEux2/EevHpovv8WICIv1Km1S/FJI4xdGZgXoqsiXwtZS3WrtRD5
         q18oG5JOjQcatR7i+bB8DB8Fyy9I92DnJBPYF6M/j1J4ol7TWgR4sbawAWFKkjIcwQ8/
         +RMsIxrywkiw0/le3js8iT1QEoMe+QDlN5N/yXaEARvuPz8ChP9B0f+Z3J7kA9objlJJ
         PJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212264; x=1791817064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NyfaJ6LqpPDeU83/vIvKX4dKNKbdA+hT9zA+yJ5zJdk=;
        b=bQJfRRRDupi0J0dH43owvGNwPoQbqZ4taNY1bLO2ZBZt+e1DwkorETVYaby2OP35mI
         k6W+W/UJKaDIshz9Wo3fFXtq1JPI3DBDplXcwbQ4zHvk44E8QKFjl5hn5aZT+Viylc1a
         VM95S4PbI5drY0Jr0rbSsPwUV4+muqjiXnK9owKXuq9c4ov/GB0LfqFA3ocw59bhHtdn
         eo0z9nOrWtLIswX57FrWzkTeHthqx4azri6LHgBvrZoqYhwVU0eC92pdlCwqPzrfKxxw
         uKTC4xkncKIF2iKYZ4+2dYgSyfvsGuUJyk7R7Am7vQJEssgQ4M7929HHtuqWnaSXxN/E
         PSaQ==
X-Gm-Message-State: AFuF++mEU63v8Z19H9ci+gpGvtwo3Dg0oyeiGaXJkan8+p3kb48jANzB
	JOZYSnSuJJy8ZXO/i4V3bdlPnSdmEIyXSIRpHVo1ROnf2uhC69+qPmnfjyqQzzWsOSpH0R9wTyM
	K3T4WBaREn1q8GL60O6pIZ1pP1zMmsjKyhQ==
X-Gm-Gg: AYBFou1a5n7/MESaSdehiNFWS7jKRFm96Z6Xh8KHuLBxt0EBtjykzTlDK8qwZZTosda
	uKSQgg8V2RVLiKGfPcwkRc7x453R8W0jhOIrksUaVvJVl1t9GFQaT2h3smQLMXVo+/uc2wmLybb
	03WL4fXtFJRIEtcFwcCkaUhZRql+cW5Tp7ZQ35cPs9iE2IPsr+kkVyBXumpymM6fI7xyRt9MXRC
	XkLi7sxzJIwNZ4c86Fc5SUXFx/HQqrJcVP3Dlk5wXEqLLFT/cG0R64V/6Opc6bj7ysDUsfEPPAa
	7fHUDxGU0hy2nUNdbJpF1l4TjkUbHWCxV3FdmqFXksFn9bSCDfEPBspGKTOAqKWuqQ==
X-Received: by 2002:a05:690e:4809:b0:675:5d61:840d with SMTP id
 956f58d0204a3-677bd2ceaa0mr1122879d50.32.1791212263879; Mon, 05 Oct 2026
 07:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005133143.91648-1-lautrbach@redhat.com>
In-Reply-To: <20261005133143.91648-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 5 Oct 2026 10:57:32 -0400
X-Gm-Features: AclHuK9HbhBukNco2cdFlgy87O9O2YrdAY78_4QKuDitDhZGq3wLmMNBiIjkCqc
Message-ID: <CAEjxPJ5euHUPhGL9vAO8x7AskG5zb8cuvvC6Zq+cE2yj8wu5wg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libsemanage: backport sha256 WaterJuice/WjCryptLib
 3.0.0 fixes
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 9:41=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> https://github.com/WaterJuice/WjCryptLib/releases/tag/Version_3.0.0
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
