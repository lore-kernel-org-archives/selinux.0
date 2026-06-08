Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55390387363
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947804; cv=pass; b=nk/0fXhGgxolVskBLY3QvWrAgMDuJMxxczK3lHogl+jyJlFmyVEueF1F4YSGWsiQ+X1VA9iVvjC4IoaKpw6arreULAh0PGE3fRBMAhrVbjYQvEIEFhxwgm7ri2W0lm9Q1pP9ljmJgX3O5dfiA1aFnuenV57wEvfy47TrVBT2s14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947804; c=relaxed/simple;
	bh=+kxl12sAFiiBsQZ0XSP7HrvaQHj4JKdelwDmv48i94M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZysONYmzKTqXKJABnMmCykUOcxPXY+q3d5cdU6uIXiRVrWDHtvZuW9/HwVw5KqTTmz1cJ9NGl4l5SvZFY5unP26M4XtXobfbFZW0JlKIMG/fjtXKotQVWaXQtSCX9KYqtwQnQ+TF9iKR+anyEvqRqht7kbnphryt7JX/dkW/sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTCGeLFe; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTCGeLFe"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-396779b9a7fso39782781fa.3
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 12:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780947801; cv=none;
        d=google.com; s=arc-20240605;
        b=UIhOZ+YHCWMAsVYshJF0qwJwYUoHgn3+m85jHIQc8hbO11//58yPXImTGSzLRL21Np
         O6pqFx+G4fIYxS79lW9U1ZlUjzXQUQaskUDcxVHI9TBJmiAzXru+vLga14mK90NWKITr
         HV6B+8JCUz5r9o+kYASpCKzXIOmijJKvN5uNTESVEP2ciR2efY/C0BrOaZelziQqQ23I
         R7V7O3l+NxMm1a+xqAyMC3vn433H6Qik9vjF8VjgyLIhzpKAxhmq8ybxTCu3Ek7a4gd/
         lFhOWF28GMBXwDyVQPcx2M7lv/wu+cvQ7BliFHnRt1DYLG2VvUXarCPdHo++msK8zyKr
         XbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FvEBFGlaFJpPEGXdB9EWYj74twctEUhvoin7xU3WOXA=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=cLOThuWmL/glGBOwPR9892cLFSlr8gi3kaVXA600vr6cM2YvU+vc/Jjd35dmVKq2sZ
         NoNXOFTnllsIvhEWJ7/j13uG1uwvS8bQ9s85wOCihUN8EEpTQefBUaXizOrTYkn8J86f
         jyNRw921GdApbIKDldprBNSYj79BKbDGi4M8EH0HHS39+txVvrUmxmGdYX2tkL444v9c
         5r10+3Q6CXUKzLHEcIMhkf62vdy4HpFMvkCvGzZDoUEYRNahDCzaPHqhCLIQqeDLn5mr
         ezVMnE0zfBmjbvGWHwEnGkb5CI3keKWSbHpwwKJBslEfnAB+NoEoKmh1QAc+dBGPD7lJ
         LCGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780947801; x=1781552601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvEBFGlaFJpPEGXdB9EWYj74twctEUhvoin7xU3WOXA=;
        b=JTCGeLFe6asrj7Z1ZD31K8vqYzRCDl1DJnSwuZjn3hN3zaN8Zb8LIO18gABiiVhsok
         dDT8+nRNwrpoPAodUKcZY8GD85SOrhjjVY8T9Mhe+SCoai9wW8hiUXDA9kyM4FsUTSXz
         K0ZLVbKVyImJvFk/cxatgBe6MAHTvgq3mYHxxSsFETVnQ3W0pXSLTuUXQUnSnacFlNAz
         6LFNcg57SA2tjmLExRYS1pfOKfqtJLUGpeqO1CIq5UdxorOVSUUzuT4UAsZq4ljuHDiD
         naXDlgpwcFIe17APSaQZ4qHFbocE7LPhBZPR0uIhYj4Re4PYDJeYzESLxqlCc2uwQSCk
         qSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947801; x=1781552601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FvEBFGlaFJpPEGXdB9EWYj74twctEUhvoin7xU3WOXA=;
        b=hvFOEikUmUNWtHGF8zcwLzaSqxXkkKujmOKq8pvSoHVkEt2d3QCPwjyScET9oJ5kZy
         oFwrlz6j001EkUi6aclh08ppsKBtdIxSjzzWeW8weqzGcFOtvB45kWr13TiLkEcWlIud
         1ul8/pMwnJEUdjlA/I6Ysi+O+iscrYAfk3t6t/QOVpb9eG159NF1C6n0uPKIFai2ixh8
         Hj42J8L9uB2+xQY/HW/+bqfGauUBmhvtae9c4SyOimOq9MCTG30mVI5T4E1XVX+DsCXS
         3t+pGT1j32psISQaazefE2nqEECdBKxHEyrhDLq9NfMCucTPWzlqgfBPVzPyKz5Q8YnV
         u4Ag==
X-Gm-Message-State: AOJu0YxpViqe/cWEcP42UHlfPmzQnCn3SXdcVcqK2yavq6h6nqHaqLF+
	Ve3d8gouCZDDR/1KsSv8UfnIg2QiA7gyQUA+laPYsGgeLZJo3yGJB6ziOv6js6pHO/QqV8CYuCE
	RBKLR/FE3dwZhuZ9aq/53O1tQzn0FRVE=
X-Gm-Gg: Acq92OFXbo4UOpg93LstWVS/moRvhbm55j9A4lRN95DIaJ6LiM/3yCJEnVrBvrr5pDF
	FAVN2gCZgdV74Tg01oGauwR4OeLJEmEmRuYjaaWOhjs7NUZZ8kVwIlflJCkrd8lzh+OeM6LWdKA
	r1JIygtwihrHI3UN9tXEMOISPWbnshplZ39lEhs97mdOCjAeS6TQyTBhRwXIU+23/YX/h3w2HTt
	HWsMCO8nQtyvHC253IC3k+p8/PdcEpw6mYRF5jYMrFOF37gW8K+KggCe5/RYk+EBOGm89+sZELe
	iztGRpGA7iroU0s=
X-Received: by 2002:a2e:be0a:0:b0:396:8c15:a4c5 with SMTP id
 38308e7fff4ca-396d07f0a57mr46224781fa.1.1780947801194; Mon, 08 Jun 2026
 12:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608183618.318484-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260608183618.318484-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 8 Jun 2026 15:43:09 -0400
X-Gm-Features: AVVi8Ccn9v_aFAR7-COtZDIkyVKs0GWUHNpafOqCuweD58YaLZEDcE9l9FRYciM
Message-ID: <CAP+JOzQmu5JWaNJihw_2CViLj0Aaa+__yLPMi54XNKcydadfQg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: digest_gen_hash(): reduce the chunk size
 for Sha1Update() calls
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 2:37=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The Sha1Update() implementation in libselinux takes the provided
> bufferSize and shifts it left by 3 bits to convert the byte count to a
> bit count. To avoid having this overflow, cap the chunk size used for
> Sha1Update() calls to (UINT32_MAX >> 3).
>
> Fixes: e17619792fa1 ("libselinux: correctly hash specfiles larger than 4G=
")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2 updates the comment to say chunkSize instead of UINT32_MAX.
>
>  libselinux/src/label_support.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_suppor=
t.c
> index 9fa7f0fa..cc5c279e 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -134,6 +134,7 @@ void digest_gen_hash(struct selabel_digest *digest)
>         Sha1Context context;
>         size_t remaining_size;
>         const unsigned char *ptr;
> +       const uint32_t chunkSize =3D UINT32_MAX >> 3;
>
>         /* If SELABEL_OPT_DIGEST not set then just return */
>         if (!digest)
> @@ -141,13 +142,13 @@ void digest_gen_hash(struct selabel_digest *digest)
>
>         Sha1Initialise(&context);
>
> -       /* Process in blocks of UINT32_MAX bytes */
> +       /* Process in blocks of chunkSize bytes */
>         remaining_size =3D digest->hashbuf_size;
>         ptr =3D digest->hashbuf;
> -       while (remaining_size > UINT32_MAX) {
> -               Sha1Update(&context, ptr, UINT32_MAX);
> -               remaining_size -=3D UINT32_MAX;
> -               ptr +=3D UINT32_MAX;
> +       while (remaining_size > chunkSize) {
> +               Sha1Update(&context, ptr, chunkSize);
> +               remaining_size -=3D chunkSize;
> +               ptr +=3D chunkSize;
>         }
>         Sha1Update(&context, ptr, remaining_size);
>
> --
> 2.54.0
>
