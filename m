Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390C3F65F0
	for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773779; cv=pass; b=ENu22GP16ChN32q57UIhBi0YwGtmrtKmVoAIR4CJeIS11SUK5+/uIn6ULK3gED4rzQBj2daxOgaExhqumUtgH51ppYfZzEv1a686uozjiwXegQTzdA3z4q/iGm2P/XkLkGL+zNfV9JfLBdNC/aXEnJvfeWEVmvl6i3XH3+cFTQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773779; c=relaxed/simple;
	bh=FpPho7Frw71S+UhCV/WAmeaI2qfQR7xlXpP1NdnLoj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsxSeiY/JNw8RpdkgsY9BxT4Er/0pq/c4GWlNAqqfXZlboTH6iOw6ZyxD6lwJAB7LOmGaRYaxU6+zRFyMSV+jVsrxBF95pBCxhfpglSDuXYMMe9IgHqjlx37TVtgX16DVfa1pBpLChkT/QFcpE54l/s2ghsDGPptAsGw5CDvWLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5585Txt; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5585Txt"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3573600a91.3
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 11:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773773777; cv=none;
        d=google.com; s=arc-20240605;
        b=MBk/9R7fO3QqNtBF53bzPondWqCO6iL4GLHwMz8L9B9Un9KQpy13OfYyGTq2XpDl2g
         yvDzGU9ISRYAoXUzrprZakD4Er9WTKn9oguS11fQFzPhATwJpwQkVKlrCmODVAv1rl5e
         TlWFt8D99XaKn60jTZf56HZOuASxO+GJa+uG5A0nEOZiK/17U2pa7Mk7gdMzjU4rNXkK
         jVi/98GYHoA/heOdiMANIhswmk+6wR26Oq8pZS7egZie5jiA5wPS82PUhofdkPgvmOym
         IIqwkcp6VpZuu9TclcTauMAej6Ez+iQK3y7T8XUz7S3aTbIWxIffE42GvaDiYdBPyPUg
         to3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vm0OXk1nTfH6lejOjIibVhZbfPdHIP9pGVfeiqRbyxM=;
        fh=chQ82yjwsBiR9uZWyudR3T+s8hO/5hiH4ix6Fr2pKCg=;
        b=Mst8cddoDvo/sgcqlt5GnL0gZZgD3FGvAOgJJvOKHx1OYWBLS9T2Z/fz3h3lrNrt0+
         roVihuZsjU8PCrQt6d4sSu0GjP0y3Eqle3OZyuJMrzyrno5alfg3UQuIPEc+JcEb1c9D
         8aYAfo/3At47cLS12VCmyNj8T2Xc+K63PIWXE+eUN6bO+f2f2C+5HZqnNuLEvFDeV55J
         rwY3BOHrP3cI7i++fXqIIAnsMZ9eJ2WM/h8cRh4RdxF1hRD4GOiMy0tvsryWXdip/oX6
         bzXU6vA6B1efQQwS+O+gyUxIJV4K1W24c2yTZ0Xsp/75j35v0+BpptyU5hc8S3IYMkMK
         HE/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773777; x=1774378577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vm0OXk1nTfH6lejOjIibVhZbfPdHIP9pGVfeiqRbyxM=;
        b=m5585TxtjC3T4xWZH37A6uF0CXG6RrFzmJpLoSpeNOjHWzE8eTIbOI6bE96Zvlcnvu
         49Dv8hnE2iiPMV0SLcgIPdDAADQNAJxEVqH/y3g6Kj9qRZioh49NT1gCq3iuqtvKi6pZ
         1XhegiBxJFKHOdD6AVCEGgdzwQ6mmfNNfojUI3nJwCs+ncA4n+WBqNWYOjvoAL/9+RY9
         z9mTpmzXhx30TVmvsGtO0AKAA05QCX0ujnXvkwBiXMPr0+jmxPvtXVPljJsYZCGASLtY
         hxTiGjUDSujP3KVpc6qHnbj5gGsM39mpkPwZ2xbK2kqTc+3UNOX5ZxOCDKBZOCRwtKx4
         wl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773777; x=1774378577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vm0OXk1nTfH6lejOjIibVhZbfPdHIP9pGVfeiqRbyxM=;
        b=SBxY3iZkptYAfHBLFOSPPgI6pgUvp/faZfZ/MlegK1vmmxP30Z3lu/s238gKy2rKaw
         WIiq2NlSMiPclLMKx8d7EDCDigG++4h4zIQMZ9VtJ7WL9dNJFqTTeVL7KCOxT8MvYvWl
         50UlXesv8xEzyXJjgbcsZp54Uv7L2QH6Qa9mcTfGhRHsn3yqNl7kAUPMysgiQq3tg2Vq
         SK1YGw/Eti01OhUR9LTde1ufF8TdAwo0DynFV/ZhqHyZp7OjSxl9Wd8sCVz0fYLfdOHT
         Gtapcg66zNA1uqOAOdKl+J9YuAQ77Gf3LF+Qjv3kJHZmZiR/unf8SIe2lenbEPayDVoY
         IoOA==
X-Gm-Message-State: AOJu0YzeCdkJwnH7+YEUbEK4CdOKA8PnZE/FU8r9HVdYrRtcrqrdeUDo
	0qhSuPZSwgxkKaFaaCyDES6tLM+KoKIxcrQ6GE+nSOKONsRRqQg//WiYbU2yfUO+bLAPSxjmI9T
	tPZQ5Ge4KVCSNqnGhIgGFUNp3GPvjhmmSgIg4
X-Gm-Gg: ATEYQzzQTiUicyCkQLlMDK47t0d8A1mIhyy29bd6AHdBAZ/RJl3AKckfU0Uzqyg9kA4
	B70mP3SsLfEOMeoAtyF9wJcCHMGTiNBf4BEKInr0XJZ7m2V0oo4NPlpNz5kJU+3jL6m6hdcvWX7
	2aoRiG+eULMLLO65lfw9p8tUZDTZ/81YRXUBJv/f4G6BQY2P0Dq+0LJFZUeWhUUBGGH3j8AuK30
	Bcjire0T3VUESSfO7L2MCP8gO8fC4LC6UHD5KF6+FDZ1QhwHqSvYnWkM2+8SnPDtmldmsNiQCP0
	O992gm4=
X-Received: by 2002:a17:90b:1c0a:b0:35b:92c1:8a3a with SMTP id
 98e67ed59e1d1-35bb9ecb309mr452350a91.14.1773773777199; Tue, 17 Mar 2026
 11:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223091948.100473-1-cahu@suse.de>
In-Reply-To: <20260223091948.100473-1-cahu@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 17 Mar 2026 14:56:06 -0400
X-Gm-Features: AaiRm51CeozGuU-uSnDXyi3hDiUSZanl5Irs9Qcx0vPVQtyTKetcRiUeQCMx5sg
Message-ID: <CAEjxPJ5+haLPuZbz8+dmsQp7-34qu2jPb0XAZYB7vyaFKYnBLw@mail.gmail.com>
Subject: Re: [PATCH] README: add SLES and openSUSE as distros
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 4:25=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> SLES and openSUSE are shipping the userspace toolchain
>
> Signed-off-by: Cathy Hu <cahu@suse.de>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  README.md | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/README.md b/README.md
> index c272ce89..288ccca0 100644
> --- a/README.md
> +++ b/README.md
> @@ -31,6 +31,7 @@ SELinux libraries and tools are packaged in several Lin=
ux distributions:
>  * Debian and Ubuntu (https://packages.debian.org/sid/policycoreutils)
>  * Gentoo (https://packages.gentoo.org/packages/sys-apps/policycoreutils)
>  * RHEL and Fedora (https://src.fedoraproject.org/rpms/policycoreutils)
> +* SLES and openSUSE (https://src.opensuse.org/pool/policycoreutils)
>  * Yocto Project (http://git.yoctoproject.org/cgit/cgit.cgi/meta-selinux/=
tree/recipes-security/selinux)
>  * and many more (https://repology.org/project/policycoreutils/versions)
>
> --
> 2.53.0
>
>
