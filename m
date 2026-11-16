Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794862567;
	b=afW1BxbAjFNPp7Ib7HpaMmxPf4hPzhcNrn7zyKVXgD5Lm5U/jqf0ZE/wswvDzN1mVK/h
	 +ob28A1sCGZbiruUnOvJGIyh01xl6UlvO78P8y1QDUVLqo8p79m7UD4QGHzz7VsH2/P3t
	 cjtyfnvxCgs0mkJDRQVwO6DKMiaitDC2szkptjxHdl3eAaXYJen4yVQEwcWo5IY3uEm9h
	 T0uhHtU+eayqkIv+bXe1PCmkD6VXe/Rqf0sxiaKGw5jQoamee6LqERvrtMwyolD04C2hR
	 8RdgrffUS8JA3TkzGf7lwN6OvolfondUQtYeAoAcMrSFm382Ru+kWpZ0tDaBJfNceZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=om0K2tqYywlfBQDVKPd4XnOcnEvS4L908yXMtiNQls0=;
	b=bTAxjTLgvO9OI7jRHh+h9Oje/TcLRmTCYyN4d2u8Hlq6b98A5+eVlag+1cIR/zL4ZZDv
	 AwF9rt4XqYvVh4wIVyEyJQCF0QoCX0Ph8+uJIYJ/htTLFqVAlAnqIOKZLz6gSjcX5KFrN
	 8IxOGhh9NWvOjVpD6BPlqxgLqpZOY5QY2nqLuxa8DoLTWLcyxVgzaHKaCs1SwrAQ1Iu+1
	 kR/w5ouwProq0T72Z5Ss6VYeYLVd+EUJqXhzU1183MCBaxXbktpm7Q5IyYty0XA+XRNFW
	 4O2evonzQ97NMCkHgXMN/PhMps9fnML52aMt+jpFFAJSbt8OxJsNqxFuTL5ydkkoBTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMRJBGVI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32811606A329
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 20:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32811606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMRJBGVI
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67da69e7c31so2511169d50.3
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 12:56:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794862566; cv=none;
        d=google.com; s=arc-20260327;
        b=pfiO6Iq7PASMIKMHt9UC0W0HuIA6drkIGl8GmLjH42V4ja991bro4WxQbhluSO/OGg
         eLu0MqRJ3RucEhN4yyo41JYyAcKeAg/Zi0I/hyKxUkZGmGgtRHxOxCj46UPSeMgUiYPo
         wUBn1nZvhBprhZkjRSNopoWgUxiCiveNeUacIZnr96IM9L66m2A39N84J4XgkeD4dmvr
         /Hv9xbRH48xkYwwg2MovOZeq7U1BwN5jyJ2Wanf7l2Dgos8GQ7yv+ml+LBj9TCy1oRC8
         2JLFaLWynRXK6kYnCmUBFL8joGBwTjYl8i1oy4P2DqNqPsgPibcZKXafIher47AW1AoI
         wAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=om0K2tqYywlfBQDVKPd4XnOcnEvS4L908yXMtiNQls0=;
        fh=QFKa48eN4AZKFIyrSiZk3FCE4nUKAEfyzhRYxfFXB60=;
        b=q4bbyRPIKMGHhjtPVHDby9WN2cL/6HogRBk/nmuUQTpHfbahmZ5kRo/LgT0x7VBhvp
         DwYyfdL3Mk6wnIQOMMdFqHetsBPDGrKVlzQes2HFPJAi0FJsv1N+Y4IFh2k4WUYQFUnO
         Wv0qNOoOX4LpzoD3p1FLR/Zf8caek/8xNpmI4NqNynFhDADUhMmYEPOMNamXPV/una3s
         iLF+UkWiC5J5Pdf3z5cmMMyNDM49Q9BLBUQ4MHY8xsqc8F0v1yJSb5+p9+XVLFcWnd09
         8xWdo835slMgjg7s/NU5S7pPlbgrv4DdKWAzLCsRu+kGrks7VQLH559hB2beRdc1mK68
         Pzpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862566; x=1795467366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=om0K2tqYywlfBQDVKPd4XnOcnEvS4L908yXMtiNQls0=;
        b=dMRJBGVIvY2X+8PVGCf3B2pZx8DcoNDp4L6eGoNbCxsxIStC3uflpdP5iNZjfDyprK
         rNjz6IjnCirQSEN4VzsX5iW+ucFiXMiSN9xKdODQ9tUIOntlj7moEpMp0+6kOZn+t+/S
         rYysW8XtNjjSaC12cQQBLADLwbEtG1Lea8KzdJgc5crhAey/xC5/E4tbH1JE4zSGxwtM
         qsyflezf2cXDo3jhHWFuyML4EqwvTV2iDIecKtH3eb/l1tu87RhR9raQJyJyOEvgkiqS
         PHcfl4MmJ23dBzaB4CuH5/j7BGLsfBpoFYiXF2etTg/Yi1+xvqCMnlQzz3NNIUTPVgzE
         Tayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862566; x=1795467366;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=om0K2tqYywlfBQDVKPd4XnOcnEvS4L908yXMtiNQls0=;
        b=EnRg3bAqmkfD2ALHATMj0dmaRtdDFVqfmQ9xMaBQuWHO2TRPZeUGw5v9arW9jYoAAA
         iUsiZ5CRjjas4vvy+6CzXE2NrSrwSt7vHgRo14mqxG6OD+lcTGMb2Q6STwvSMlrsIXYY
         f8c8DfUI8QI50oeEb5x7l0X9entTotDfZod2aujc7bIbhOmYc41MjD0VP+it8W8Tqb39
         V5cn9AXOiNwe0TsbyrFn4d992Gu1oKV9AkA9Gt/teuRrhs6+6yMgMnyr7CV94hwaGGOm
         A2h7QsobnieU5e/QWM81heYUAeZCwtPve5budG0g5nPvOkxh/Fo5Soch6+sA6aASp+pW
         +Vfg==
X-Gm-Message-State: APuU4Z+JZygKmKkzwM1uow3+szwPoswbjvkINj0NJQXeSNfvM9FqqSoi
	Puew6Sc4gNIBuu/X4GClhjRVuFCI9UsqhF8sLGkoa53ZjZ4F+cer+NB6n20u8E357Ej+hiijPmi
	c5NRVR/DMPWjA5zO8WCxiyQ5ky0+H+WQMEcTd
X-Gm-Gg: AZFdTZf3qkOXNRDcOEMwp+egVmu3P92mZYJmDCDUUw9i5W6xDIK525zMhdZ5nBqZWW7
	vuAQlDuZNPt36GE0wyV/WxTciZatYd8i1A40QfxrUeofnxcruXOR3DUz0VJ3wI+HfVaVcyO+v8W
	ns/Ml/WDQcKCYO6sKwl8TmWWhXe9ptfWBDthoVZ2LmaySBP5UjzKGhqaNZ4F8vymQRiWyErPosj
	GxefFWzw8pDGPTGxQWqVQEZy7NgleALJ5UmRI3CHf78DyyGuT9zWoDpXPrRAMCX51330QBpfzuM
	8m/CMRG8dCDa6mF/g0p1qBm58wpUfun3k0B2z0ZkVN58t37VdWWgKS8stHzrk0A7dyggPBrP1J7
	QvUa82jmE+X8941RU71IcaNt/ZUeXJJjnUa22BhUAT21Z1kwsnG5doxmcDL7h7RXmUTsHz0eVfE
	xzofrev5oKDfSm0JEsZVZZoLtZnBEQUJP4vIr64cHg9XRvX6+I/IQFCr2DNjwhy1L06yFUBssRs
	DsRJyc=
X-Received: by 2002:a05:690e:4005:b0:67d:ae4c:1124 with SMTP id
 956f58d0204a3-67dae4c20d1mr3210440d50.7.1794862566184; Mon, 16 Nov 2026
 12:56:06 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116145351.132137-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20261116145351.132137-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 16 Nov 2026 15:55:55 -0500
X-Gm-Features: AclHuK9fHsnUanbfdoapE-FwIIIIgOF06QtTIHWoDfNEWnOeKNOcf9aRXLRHYk4
Message-ID: <CAEjxPJ7Fetso9j77Yau4o3KLVGFO=G+541Bc_XRMAxtHt9zz8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libsemanage: accept empty local file contexts when sorting
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:54=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> A zero-byte file_contexts.local specifies no overrides. With local
> sorting enabled, the raw-file fallback attempts to mmap zero bytes and
> aborts even an unrelated transaction. Treat an empty regular file as
> empty input in the sorter and publish the usual header, just as for a
> comment-only file.
>
> Use the size of the opened file and keep the existing mapping semantics
> for module readers. Test the contents of the published file.
>
> Fixes: ee7e4e1e4e97 ("libsemanage: optionally sort file_contexts.local by=
 specificity")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 adds a Fixes tag.

This series has been merged.
