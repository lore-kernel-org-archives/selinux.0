Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDED52E050
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073174; cv=pass; b=DWkDbhjsBqAjXuYsWv4Dxn+XE/31B+/e3MBW5+zOy8DRiw+4jTBiGsg3rOoRYqRcq2JqVW9IsUM+isgZRQUGIDOZRbUL6jy5iM+LikvnWPBmHjcpTF5CJFn3EYZg6m8PgzGR2K/R5d/RChVBwKqf/WuHyuUfbtWTKvIXyFd77hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073174; c=relaxed/simple;
	bh=4tjX9uzZG5XRFIXTawNaJzo9jtMvY0lIh7pgbG9gsWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG2u1RXZxliTTxVP/G+f4K2olxx8Z/+oYlt4Geaygovd+ktmE+zxGEJqHswCh90uDs+gMqQvuhOeJLomBoaY7HXVsztIIJpCt0SnFfZ+dI5YRxtBm+OCiBBkCUstY060GmDZRO66pH/hlyVD0YNUlimHMqnQNAWX1QRwwcENSQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=The6UWgB; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="The6UWgB"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-679965fb848so1568876d50.1
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073172; cv=none;
        d=google.com; s=arc-20260327;
        b=hfEMUuLKowBOF3zepjgSGVf7l9j0yinOJBjol3IfQylGwkB4LqBB59jRLkMzX1gP/e
         CmZexbNB+fVg+do/rmoDFLYMDQmLdM8wTQScsU/Nv/mponHCvQ+fQSVm9cVuKP9okhjG
         9Yc/vFGAuLPY6nHCz+GlYvVVP1MmpN+/pG/dM94eFHbtmhT3wCH82RiOM2DQNnZk5MD4
         wNyp6VLUyMM8yTG5IIYfzg23ofw64pG7vlWpjkYibARZy9/S7GFnl1r9MKbHGsq3LR45
         mWpJiWoGYMpgVt+va0NOlc2+wpmoA4JiDmN0Am9hmr/CNF5mBraHV2xd9tcvYqmv713R
         H+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PBgmbeY4RciGSktQEM9Ym+KUlsrjssOvVLBoxe6QDKQ=;
        fh=gBydrNMvjriJbd9HrIy1Xz3jsVrETImIXW7v+LTQWN8=;
        b=sYa5z7WP+lCiwiGr3Hiys/FTuTyCiJnMB636KLV4fETKFmVHDXtUDW2/tepVcZx24+
         ywiRskJbh5RhER7VUFrbAmkgmJDy4J76king8JXCAuX1qivYlzf/Mv03uYK8k5O/BTFk
         h1/HnDY3dKC+ZAmXCJtTeQz38BL0L3n3xin0z1q1i2evRH9N6hbZREsGOdcPNugDXAGF
         mBQeNdR5oL4/imPLZxl60GeYGhf51Nq3uHja83Zsyetl1p7Q8Chmd3SkCTw0CpHQxHby
         a0XiCnbWcd8u/RkvGEGyoa4xYr6EJhCNllUEqUV6n9sTkDSFQ1w9+VzjLUAK63ifRh2f
         G3ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073172; x=1792677972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PBgmbeY4RciGSktQEM9Ym+KUlsrjssOvVLBoxe6QDKQ=;
        b=The6UWgBE1FJzbCGWvSlg4GeRzib2OTWTqCkVHcm7CLb24Tl4Z1OOm+4wuF7AaQ7y0
         E+iiA9ngh9wVkx7vqEiAFy6VK6ryWM4lU7s/e0/ZUOKj6H+inZXxXRISfa1lRJnlocID
         Ihqj9YIpurMDQzK4DhtaRIAzfArDztR/xhXTf80F9R7mUGdY+RJMAoQL3OAbdP8aRotl
         RHB5UjgBamqxp/bXAfD/hvJj/EbDuKqtPCoMJ9AIPBuhh1TejOyFJrps437ukGC9OP2H
         7U/evqwLDYFUg8NJ2dCfGBMZqTF7L034XnlhjrVvi7CnC+zLMhWzWvgK6pxvNf5Bh5JD
         0rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073172; x=1792677972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBgmbeY4RciGSktQEM9Ym+KUlsrjssOvVLBoxe6QDKQ=;
        b=UwOyEhhceHsKHfHCZxRqstoiSS5mR0zEXdG/9efpWxfFR0s2sCTZaFXgH9w0o6ein2
         7Ku2gWgf9XGLxlPipbwAtGVGIBKk5SovuDa7ZFwGNi8ggywHzdTTiAVQcA+CGkF3HnEP
         +zixHs0ApPonOnR/+KowC7aPy9WikQRoKMRJGxVrLoBWG2SjMEYxPhHFZvvaAn9plE1Y
         +0eWJMt/8h/wxgCg1z3kp/DsnkDf5b35Tt0Ut9L5Hl3mEO0WAWtSrzvfBe7NnGwlPiXD
         cCKdHaZy14wC6gWW/d3ueYv0ih5VlS0OAw2xDMgeAPWdu9QUOzI9qITdsFhlCLi15Zod
         8YYw==
X-Gm-Message-State: AFq9FYKEEQWHBTk55hr99c3SBOnDugIx4VMNvSidnfodBITda1UfstbE
	5jTV1ln+YNuVObtocCfVzi/e8xgj3kvKQpSgXSZg0AwJJW335fuYY8CI3O7ws2Lo+zfITQghZMH
	1N/R4tHYF1m/zaYYJ1p0rWKEJ8xGQlgM=
X-Gm-Gg: AYBFou0tdR4Lu+Dl1m+1WhpQiRy19Ihv/IKTswSDec+tKld2Nod6j0oowDcqrixjE+M
	nvhx1YmH7AdaEBLhqtEoYFbv8MJPJCYH0oByWM0TxhID8oRLpELr/BpojSJ57uCzPIbzrbgrnK+
	rzXshpaRVdfhu90HxzOKq0BSmEGQsUzAmhwCFR7hZDhOcuuOmtvuT1nZFOABKwOE+d5oGCUfk9y
	Gg+OMfUOsgndvlyjV3hneniJGZCO3oF0bn4DKvfTxXcULjsQwWbTGJgeBlqzWueDruAJDthsKMY
	+hdSP00POCSE3xYjO1mCEu0OX5brHmgyvtxjd2dVRJNEh/RHC+ioBnk=
X-Received: by 2002:a05:690e:408f:b0:66f:c1be:3181 with SMTP id
 956f58d0204a3-6793628e4b1mr6613569d50.88.1792073171815; Thu, 15 Oct 2026
 07:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015014457.877322-1-tmz@pobox.com> <20261015014457.877322-3-tmz@pobox.com>
In-Reply-To: <20261015014457.877322-3-tmz@pobox.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:06:00 -0400
X-Gm-Features: AclHuK_oRbh_A6yXNt1oQzyxQywlp6XEQT0aJ-MfHQZ35ToXIQ4U3dzTpDHPXW8
Message-ID: <CAEjxPJ5G4qNpngG5uq8GYxp5TaSPhS5_A+BUr5avrESsn8rsGw@mail.gmail.com>
Subject: Re: [PATCH 2/3] libselinux: add -i option to sefcontext_compile.8
To: Todd Zullinger <tmz@pobox.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:48=E2=80=AFPM Todd Zullinger <tmz@pobox.com> wrot=
e:
>
> The -i option was added in 487d652e (libselinux: sefcontext_compile: Add
> "-i" flag, 2016-09-28) but the man page was not updated accordingly.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  libselinux/man/man8/sefcontext_compile.8 | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/ma=
n8/sefcontext_compile.8
> index d80a7381..13192e85 100644
> --- a/libselinux/man/man8/sefcontext_compile.8
> +++ b/libselinux/man/man8/sefcontext_compile.8
> @@ -47,6 +47,18 @@ Omit precompiled regular expressions from the output.
>  (PCRE2 only. Compiled PCRE2 regular expressions are not portable across
>  architectures.  Use this flag if you know that you build for an incompat=
ible
>  architecture to save space.  When linked against PCRE1 this flag is igno=
red.)
> +.TP
> +.B \-i
> +Print regular expression info end exit. That is, back end version and

This is a typo carried over from the usage() string - should be "info
and exit" rather than "info end exit".
Please fix in both places.
