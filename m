Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C099529CEB
	for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065084; cv=none; b=eOwc7TGI4195ib8q5jxzmtrj+yvtswdZjSrMP1T7un/aViBcuuIYt1vZ4TM1DLSYtohlSwbXRbHunijU1IT1gt3CZxU8B+Sr/tgsRIZGk8cnlKGYUKQDXn1bmSdgFk8bYr/He8yvqSyq1DH5z4jckL01SFv1GbQqmv1UErnFBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065084; c=relaxed/simple;
	bh=Wyb1/gYczLTnS0QVQF3Ihr797lKax2HmLzKlpskuTlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCWeE00hIMB4SGJzWin3dBf45SrORVHplxLZ+Q3MmhtXIBc9I1Z3/JjGqG8v6sKoK34P/fxoCpR6LYRwoimKKIAA99Kn3HGmXiNDNDJX+g0OHp8RsV/8tPr5IT0ASPJmQg6gz/KSSiZo0HXhoyJYPIdo2oQ0LRmHAIg32tz9avE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJzsVnY1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJzsVnY1"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59581e32163so851376e87.1
        for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 12:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763065081; x=1763669881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd92Ndz/t9JneRdrlKnJP40FMXBs68UtdyPJfj/H4QQ=;
        b=QJzsVnY1FifMwvGcxuIk4Z5f7+XYKnlr/LqIY1rNnF1akdGYCJVykc92FlucoRJciK
         JLft3glECj6/8qEVEm+awyxbyUEUTUxSjwWBoP+KlH972ngPuvEbEbrQXPcRgcWcTphb
         VWla14Rm7m5rugw3lVWr8m/fWV5N/sSmwwCfJlOVJq0e21ozT4WTQMIuFRgyDXUSn2xw
         eE5hGpzPJfcQ+1gB1dVDPJzrZ9xYtpnuBysfTKZsntSoFqZ4p3yRTAZNdaNAaB8DJibA
         v75d8ClNigF5cXysV/ZnlVxte4f5h58MjcfdrulV55MirRnddsLfEz9y08IBY9Er3q3D
         xXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763065081; x=1763669881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd92Ndz/t9JneRdrlKnJP40FMXBs68UtdyPJfj/H4QQ=;
        b=LqLK84fYaleLQR47Ml2kSRSAR/cIv+2rkhbWqBewGQVqHLMOzLecfUg0bs54Y4BXNa
         BkI6FcTe1giQKsBfPHd96kJqYYsJAMIzgFutAjB1eS124I4FHZXP9Gbb3jwvTkBnoD5U
         SJCqTTGxOXOjzn1slMqvwTXsvzYLtjG3+SFazTIWr7TzWRzb5p9+4VJLiq5QrKqM5VA4
         ohmUYeXo4lIXyeE6CtK2qiAaFvydPLmtQBu5CCRbu8RAR0EB3NZobPnwN65sD00lAsqE
         LhZMylfCvIqw9kFBbJ6u/+rYJ43IR9bu9AeBWNktpzSSTd6hNzMf8BaZnnwqsa86bzU5
         bCyw==
X-Gm-Message-State: AOJu0YyPm5kifdEeQHbXMz3xEZjcoaVs/Ti51CS7yntocE6X5VhaQ0xG
	oj2wLOpmH3hdpyRpyCbvCUM4OuQ0OOvHIeyHduxcpUmOPmilnc6KYzE9BpbAWpufxa3+y+poWm3
	lS51d3kvhyngzO12mTJ2CTwMsVl5GMmPu5w==
X-Gm-Gg: ASbGncvrFAaV/wNlSzrMPV+uj4JS6biUwNm5saEyJydi0d+6qz7kmS3Jf8OPlLkIV/b
	Z5z6vp1+VPN07kwhJOXF7ZNbLhSYxNrTK2OQ0Mp4q8WN0W3Zwp0r5rfaMpev36GiZjYEwrw2GW7
	Vk6CRH8otjF8NGHOo6oYUu9quwQWkb7v1nu0g6pg43vy8peZeAWE1Si88zUJZZ6zzkLdqcy9Mbq
	tdiy6xpHJbt2IYihjbUA9cmcxw8CHy3cMpEvTp1ZrbR99DNa30kKFvBKRJXYw==
X-Google-Smtp-Source: AGHT+IFMhoanrLbvPoIFU8p+RGq24PrndonGtZTmlXvJv7DqRGij6CJDpxn2Dj70MPqS2ULI3zlAhnMgMC4Pbero0Qk=
X-Received: by 2002:a05:6512:230a:b0:595:7dff:ebb1 with SMTP id
 2adb3069b0e04-595841fa4d7mr220848e87.36.1763065080554; Thu, 13 Nov 2025
 12:18:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFftDdp3ZChoaVF-5FN=O=b09Hv6VSXAUzRQ0muW0NParjZBhA@mail.gmail.com>
 <20251113171151.719458-1-vmojzis@redhat.com>
In-Reply-To: <20251113171151.719458-1-vmojzis@redhat.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 13 Nov 2025 14:17:48 -0600
X-Gm-Features: AWmQ_bkGqTORZdA2UaCeLkQ9Uc_F-jvihj9E58M7_ukjMpVL-rntHLmMbP9qLOw
Message-ID: <CAFftDdp9+wUoYG+8TL9J0JGCh_dkLA+ty2w=sJQaayHJwbyMLw@mail.gmail.com>
Subject: Re: [PATCH v2] restorecon: Add option to count relabeled files
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

<snip>

Just reviewing for the output formatting.

>         if (r_opts.mass_relabel && !r_opts.nochange)
> @@ -479,5 +484,14 @@ int main(int argc, char **argv)
>         if (r_opts.progress)
>                 fprintf(stdout, "\n");
>
> +       /* Output relabeled file count if requested */
> +       if (r_opts.count_relabeled) {
> +               long unsigned relabeled_count = selinux_restorecon_get_relabeled_files();
> +               printf("Relabeled %lu files\n", relabeled_count);

I like this better, I guess the question is now, do we just make it
printf("%lu\n", relabeled_count) for
ease of parsing? I can see Dan's point there. I am fine either way, as
adding cut -d' ' -f1-1 is fine by me.
However, whatever we choose, the output **has to be stable**.

Hard lessons from tpm2-tools still haunt me, sorry Stephen :-p


> +
> +               /* Set exit code to 0 if at least one file was relabeled */
> +               exit(errors ? -1 : relabeled_count ? 0 : 1);
> +       }
> +
>         exit(errors ? -1 : skipped_errors ? 1 : 0);
>  }
> --
> 2.51.1
>
>
