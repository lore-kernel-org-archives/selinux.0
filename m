Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9DA3CB2FA
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360669; cv=pass; b=F0C26JGsLrtp50mAuZOk3vnmMSsS/cnZR5kbAcwIzNUqFshskAZEEyOFLbBdAqBVMLQOSPoRRcR6AkyD1Xn2zbTkwuWuhtSEQYSXykf2YgXtzNRjrVo8n8acBhsYUadfcJjppv877vMYbSEH0LQGPtA6rSxgtAVJYp1LWx/UkA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360669; c=relaxed/simple;
	bh=2D27ta1nV6O3yNwIz7r1iWi+KevjI2dOlSBZrYUROvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsFpC0FmxX3ylohJ66RaBP8+oMjB9AO1utl27ty//VrREsxMZp99RM1X0LB20irQPHD4g9tKKx/eZ7k/F9Qx0Mr8/pbKFfd1iHawoZWlFxUmK5KeuXWVborLG6RUNr4jSlCa4rC7KIzWXP/ek51ZphRxaHTi5/o9JkI0gDTtSp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZmCUzVB; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZmCUzVB"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab2029eso1215527d50.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 11:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790360666; cv=none;
        d=google.com; s=arc-20260327;
        b=olOOfFJUTMaqxA92f7ydoNrytfRzHNoUatjjDWE4QqpLri4bnJrebMFJnWzs7/v6GA
         Nurs3e89Fbiiqcf1wSSgxJxH8a5p6yum9pPrpw0GvGTiNkz5wJf3uG2nlZ6DM4uA21CZ
         9gECH1pTWx3QJd3cw41Br/4Xa4w5R2hEIisBEQzXHScZpGpUboynHb2vKl7Y8LAbFWFX
         SxJ42Psko4fXrqf+vOqHLxRFIk8UqzPLVAAIjgSmr05UQOJeFYbUykVc1RhglkzP9Dgj
         yz03ycG61b959ze2W9MaYg5uy/W9/uQ2WalTPi0o8mSzfVztvPTWbf277tI3r+p6wkfu
         DTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M4jUwV/jBrDB1xBw2pv6lS8FY+A5BnGFbeyyFl0hBpE=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=pRKGHozmvrbGdNuiqK8VHpxPPoFobm+nCJOj6zAg15UgTFa717IkEmcw1c3N0p6f81
         U7cYP41ClJIRu0uZhUi+mVKJNnya+1z4UGvfF0NBa6xKztmNX6ttbGFY9hqxL2lw9peL
         OR7o5drJHH28J2S7g91L7eiAbcqnLG65z0lcD3bdwalb/oPda7IlYfTw5dAODU5HGK8f
         G2zMcuC49bPXIi6oo7xjRw1VgWHIS3usc0IOMvuvNDSm3Qs3/gHlTEG7T9Zf4RQLfYYQ
         HeZ+8jtjrh2q6bozggCDbrJ1iVGnviOKPPkKBZ1aBfYzxLhnwE5YKNJZecPO6b4bD7mW
         UwNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360666; x=1790965466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M4jUwV/jBrDB1xBw2pv6lS8FY+A5BnGFbeyyFl0hBpE=;
        b=MZmCUzVBheR5qlJf+wvnnuKNhh98240f2gv683ELQRZLobgvY/9zJkhqEL64X8vqM8
         pNRGfYS84NI/ZIzqf9bruOWy6wAfBqeGMhd7QYV4IefyDNXPC9UjJbX0NV4ceQda5vnT
         fj36N8LfNB4+RnpaxRgTDHcYmqb2asO74bTiEEAKUVbQzqR0d3Y83EjgIYFr0lpP2RVj
         9onXxBF+0GsQ7rxxYxbGQLImbtzqYQSdwPLjCsOq6KNkfEHuMMRiZY1XzCPz4JAk99/u
         gvJ4hdG9zKZ8EagIJltKgTXbeet38Jeage3DB2yd0dBRWp+slpl2GaKz8Kt6hmxWGPG6
         04IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360666; x=1790965466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4jUwV/jBrDB1xBw2pv6lS8FY+A5BnGFbeyyFl0hBpE=;
        b=NNw9J+AMOHkoh87mEmwdH7fvk1SZWwt8wDjzlqxFPwn0ovIbR5qTwcdb7ZFRJsYA/t
         NBpIBBRJ7dKFXVB5uZViWn0G8bH158Ry9NOdHMaNelG+f56tgogqvD4rU1jPjD8p1fB2
         2JNzVzaYFFVF8YSZcbxMwW3xUrO25J6S6NKAlbbJ8uAkD1YIQtHrvhDOWI/siovvGUir
         W7N7OqLMMURfJYam6fr2OteLwgdD6pFBof6E11YX+L68WEWDCITa9WIsNycpTpo6G+Up
         ZT1sF8lGZf/IlDu19DomCkirLoCGSbUk3JVbHUd620UDLlXMwLPqMTifFeZV1SFZX1eX
         UKDQ==
X-Gm-Message-State: AFuF++njuy52MxWmP9AUbnVxIFt5rhySguAzMEPX7rIZMw3SXd9Rfk8a
	Ty9f1wDnz6OhEFTX0cUZON7/Egi49y8BT5nNAycScd54+17ELdrGijLvp2hAMNrmmmXG9USQ6OA
	peEVzb3qjNiQkvFkRWRae7lBZlixfOZxwQQ==
X-Gm-Gg: AYBFou1a/c7BnqoldD0uAqYMeQH8AlQKjlldk949Lo+hbwBy7n4YnltK58Lim1YxqEu
	AbjjIQcz/GKMWbiO+kgFj5BEGqcZO70AAVHZtUDoR2+GkGQva7k/mz5w6mJtJ8q2DiN9Y2bA+5X
	8jpwTP5G5AK+8Bg/yMBzjE1i6U5KF/L7EtPpr8f4DpPNcTmit9l5E1KL4HLGjkVYuTD9+Ykabk6
	RSm37hxNkp3SYsWCr3Yf1NFDiNCCJE/mfoqWsfVromXNL+m5dNB+Wu6ePDufz/rznSmcScwpm/M
	XSU6RzTZLozqTFNZ0DwaQma492TvSZ9NaFb6xDeolg7/I4zCfr2PvOU=
X-Received: by 2002:a05:690e:454f:20b0:66f:b5f2:163c with SMTP id
 956f58d0204a3-672ed21ad81mr1997432d50.24.1790360666493; Fri, 25 Sep 2026
 11:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-12-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-12-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 14:24:15 -0400
X-Gm-Features: AclHuK8yPNu55jk2czj0PkS40kKUh_RwiMUmRrVmXdC2YcbAGInRVs2OXGq9LGw
Message-ID: <CAEjxPJ7sU-LybFa1i0TC0PUntxBqzFhqW6v2rqxAFWoJByd+cg@mail.gmail.com>
Subject: Re: [PATCH 13/21] test: overlayfs related tweaks
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> OverlayFS does not support a couple of ioctl's and other features, like
> NFS, so skip and tweak relevant tests.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---

> diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
> index ea9f120..f8cac63 100644
> --- a/tests/ioctl/test_noioctl.c
> +++ b/tests/ioctl/test_noioctl.c
> @@ -43,10 +43,17 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> -       /* This one should hit the FILE__IOCTL or FILE__GETATTR test and =
fail. */
> +       /*
> +        * This one should hit the FILE__GETATTR or FILE__IOCTL test.
> +        * FIGETBSZ is not available on overlayfs,
> +        * and FS_IOC_GETFLAGS is not available on NFS.
> +        */
>         rc =3D ioctl(fd, FIGETBSZ, &val);
> +       if( rc =3D=3D -1 && errno =3D=3D EINVAL ) {
> +               rc =3D ioctl(fd, FS_IOC_GETFLAGS, &val);
> +       }
>         if( rc =3D=3D 0 ) {
> -               printf("test_noioctl:FIGETBSZ");
> +               printf("test_ioctl:FIGETBSZ/FS_IOC_GETFLAGS");

Should be "test_noioctl:" or "%s: ...", argv[0]
