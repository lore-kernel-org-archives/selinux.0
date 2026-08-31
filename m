Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956C38887C
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207397; cv=pass; b=kuL939nXqKTTUl0AAigd8fjxGSxTX3meIZc9N7sMc7Ks+HSW8Ag7dvI1CPRJowXaUTcNTNSpGHtmdHDXwg8ucFlc39J4XF+IEQujCYtoHQvBXtcnTca7J4E/6f42p+ivzqG+S1iuBxTcGtgRaUMsTOohGhMWzvmQojPkX389lVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207397; c=relaxed/simple;
	bh=yr5iNxcw8bTg7j2UseUQOUswTBZwGogZ/08z12aUCoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3Fzw+DgHME4+X8fCYg/tuK0ixSBPr6g9tt9T0v7U3qhaRxi4hz/QaPmIcByphMmorLjptxGfupKZWuMlLoaE4cVEFBUpmlRjihpxCoHU6U/OYX7E6ViayRtq4ZQrJAlGVWMgartf9oSLyPSq7ifbnDrKKBPZdEmXUERrAX7aJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rrilXz7d; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrilXz7d"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-45837e52d8aso3694848fac.0
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 13:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788207395; cv=none;
        d=google.com; s=arc-20260327;
        b=AcQA8IDNHvYKgH6eRAXPT40/XOvOX8twvTScuOU5SV776oqpkYzqZetG3nqjJ26vkE
         gb4hJfynmbmlX16hhW1wP688ZHW70ZI2y4JG+5rGWHjFRL8+1cGPDCHj2XbdbZQJDaVV
         7kcA+lOovuGA11O1Muhj680Ty5n1gmiXcyeojuDMGIuApcd7NWTBEo/mfbj4RBOIDlbh
         9KUZB62jyLy7nYs8PhxhwCxjH6d8SFbj7Pxg+Apzj3delu2CSK51AE5m8KR0EWwPTEZ0
         che1TcIEZuBgELtsMC9ysP5CI6Nq9cWOMrKIMnIbE8ZHMpAFWyUooXNllbQ0KXUG899y
         nd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yr5iNxcw8bTg7j2UseUQOUswTBZwGogZ/08z12aUCoE=;
        fh=rQiLjAUWN/whwGPkKboh3u+23beWUnZWsu+n140LG28=;
        b=rzByuK/0OPYNcPXFlIAvVlcrUooJKsN9ujarlr5Gtd+HMjQ6nTt2ndM/+yfVWgeZNC
         HA7NBGoXzn/uAW1Ac/oXMGXV/Z+/Sla5lwSB+D1d5luDmCQYftWl1smH8ZbVA7uv5CON
         9jOv+pSK/9mUDbYVrdegE62442LCYMO0njOFkGLrBQiwev4l1fmnsC4AXr1AexqKc04L
         A+i4a2oT22VuSkWbuwmf7y7LW09fg279iRZlZMjj5DQNj2ViHcWyi4sRr922kNzPUrdn
         oy65+349Owct5WmPrnrLaxnUc1Chv7i64rYZfbPCcdTI9eTzJlx3HMHxIOI8HfFur+ZR
         zgJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788207395; x=1788812195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yr5iNxcw8bTg7j2UseUQOUswTBZwGogZ/08z12aUCoE=;
        b=rrilXz7dYaSubEvj6YCQyrki2rsogeiOyxlRNJ4ltf1VJgpZRZzFSu78G7IXq1mwAA
         JpnbSCzUvI8FLrYnIuCeqFW/C22pVEFpplRtYE/ANxG6GtxZTBvKQTVvHfqcgmVN9n6J
         QptVy+eG5XvXjTxlnPgQ0ILryL6pbWvlHLy8eqyRN/4bjEzpHf5dQbaBczfWkTAigxcP
         F4DaSmlDgAMYB0vbXAenYBRXBLXnq44WoUkOBODEh8svV8/pwC+pn5w/TAc/IcfSwoXn
         SO7ZOnqjQrrRZk8RiqOCb2m3WjuQHKfy/YdQ4YKXgzr83TbBvKLg7UJs27dm+wEOavh+
         Rgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207395; x=1788812195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yr5iNxcw8bTg7j2UseUQOUswTBZwGogZ/08z12aUCoE=;
        b=jFRaiYJHbVXob7BREcStQC7Lx0HyCfbIoqZB0wmi1C/if8DC78hsEnIUXSJxQg+JBz
         G3qDF4H7fGMPJdv2CKumMktO0KWgaK3JwDuq7CcwHkyGEFZ/ra9qKGOo+09WjyvgBavk
         VcHlN+oqu+KqaQ3XZDMW6OAVXJpz73z2TToeBz2H23RA3BxJct9MlMxWww/AIzddYbsZ
         HhpXAj9RrxJl7Y0ok8ekrlQzpQvxmSEbNiBEGai+loosWFKNUwsC54xrQjjF3onXCnk4
         /Xw14O19DOcW9o23vdufRV8ASg2dC8mp33i6CDILTgSgYHrc3jzZyvd4s2lcDR30edXk
         zGaA==
X-Gm-Message-State: AFuF++npOp8hIMoV/36nYoHBALX9wKF+ZnQL+DgnH6uMLYGyLJ7Dimh+
	AuEiHyraDM37SwG8X/q2CTOFS2zbnVHUgD8W+RORyzYdknOZG3iiBi0xx6gBgQl/3xfTz86GRs7
	R5/JM9PaDcBkfROv/kwsqh3mxFAkJFGPJ8Q==
X-Gm-Gg: AR+sD12PiNgBaW9j80KkgYyeXX19mnu3WNMh4e21PXMm+8/1dAq98mFmOS5dpDCvisI
	NQ8bNNP5skzwHTMxROl/P+YFZ0BeOEm0spdSmlBaBT+NG86ifx8vQLdylr/yCpOSKkZ8/uuLiWL
	Jlgh1ldRGSsg8IRtOCXjSn8a5AYrWgcyqWnSSxxXH94iRvggFykEsL52XQibfhw79enXnP6rUNP
	w7iKk6azIS8c4Q73EvR5UPC1jMiTovlCtTqRpfIHgDBsz2+FIq2mb7xbSA/okxHa3LlWRSQnXBQ
	wooU/SAy/hsMaZ7g+CEbDUtX7DmDZIm9akUV/OlJY5VCNDcqwAuKK3g=
X-Received: by 2002:a05:6870:8094:b0:43a:19fb:8b99 with SMTP id
 586e51a60fabf-46af568c963mr3742857fac.9.1788207395255; Mon, 31 Aug 2026
 13:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831165034.80872-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260831165034.80872-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 16:16:24 -0400
X-Gm-Features: AcwNN1W3G930ls7oGalQ0Iy2KiHHM_1ooN45GQ2QXHmnnUQm30sAMXmSv-ClqdM
Message-ID: <CAEjxPJ7owMp-UOFafDNFfa7H=BVTDMLaskxVKPvUj9TzuO+vqA@mail.gmail.com>
Subject: Re: [PATCH] .github/workflows/run_tests.yml: use a modern refpolicy release
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, pebenito@ieee.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:50=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The run_tests.yml workflow tries to download an ancient refpolicy
> release for the sepolgen tests. Update to the latest release.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
