Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220C426EB9
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455509; cv=pass; b=jhzFVkQ9Ew60CA6n+ZAlBozUGPrv8psYUMO2GhxDETY3e/+GyWHN7VHQxbLiea4MRR9a8E4IcEFvd4eSVdZaGe2eWwou67DRRSdNYBSb62pTWLQg6xh8ewdnwZAkWalIcCtB1giVh22e0lIIbIYEKq3PjArJGnIU6KH0BhW3Gqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455509; c=relaxed/simple;
	bh=a+uXX/O+ghaPCxxi+FLKI8R/euAQBof4H5fEH7NwBTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TloP/mxIjeO+VRTAVD304h5g3Y1V9aUtNnmNJCbv1294e53O4PKsPnqYkELdkdE534pgDQsiu5kFsaK3YzJCA9S+MUlOxZ+q2gdUc1P1KwW28t4P0caE+3dp3CoMjmYokg88UC6ZKYEwOJjPaVK7PplkE/tnuhkmEnNvLjqQ5/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBY1LLTd; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBY1LLTd"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6acbbcd3798so1848812eaf.3
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 06:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786455501; cv=none;
        d=google.com; s=arc-20260327;
        b=CMg/ZgIAmr3zqpXivbTd662JSWd/4uHwecnt+Bc6S+J1fB7JWNV14oaaHwDgAzTpwl
         y7vzyG4MyOlUmisgN1OWbo5j6QAqUr11wGVyhrj+/z2O+8hPkdZnioTXQD9WW3Zku282
         N8P1/k8XiZG34lPqlLlRi/7ohxVrE7hTwN58mYT+9OHV2ysQgczBtNOUq2LDzFUSvzFz
         P7cA5jn4iacSKvIt8CIameEFVpmkS6eH1Sd6zCUTwKi6P5WMM0+b+WOyPph29REPb/eL
         G8FiW+5/gJmCCw8CX11QF/MiNpDXvmzrp15WcIodup6gejS4KwVXfufnkMwjA6Smvqjg
         qIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a+uXX/O+ghaPCxxi+FLKI8R/euAQBof4H5fEH7NwBTI=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=Imcz2TBrNBPcJKUPF5o/wUHXAObUodVewH4A7OyHncjRoQVaKgVYaewnQapMOrmHcp
         tV4q7sRZdHmie5NJjMBzkMhBFeFZH02HnSLv9mlIAu6BaXRY37K0/KznYz+vvf8APMNW
         g7KhNePFpHK0ZSv+3JiID9immPxHcTs5OFpmHMaWjZ9zgQObAbpoiTihVzig4Putrf5L
         ctv7VCFytm9w/mi051xSujBtAeA7tU1GpmeB+unG6YvgE7RBTPJtreArbXrEWhjvF9ZZ
         f96DX6DTcQNTNuqHIuE9SfmLAKpd3l0627e0YjbSwJl72M6dR2djF6TbldBhtnQ/mUMx
         gIDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786455501; x=1787060301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a+uXX/O+ghaPCxxi+FLKI8R/euAQBof4H5fEH7NwBTI=;
        b=HBY1LLTdOn0dMz9hAeGJ5XMf0YQxCQsrk5LtEaV1OdUruJxRxT7i+p1H11I7oKM9In
         t7WtGYGAoHUMkS7XOYvY/5yQnuas3hRVxcG6R9f8ymraI9vjwkB4NjcvC4ORZ4jmJCDU
         bpmZhzx0eerOCknGEr9Rw/fLPujj1RZW9vGcJAeNGdlHMgshTj5OmdwlVeDKM7HRsAm1
         sE/6XIhLTil2FgA8HmgfR35dJvuSINYhT3WKODULhOgsSA8nZzDc8AKNY6oDc1nrsrcz
         SYHGdyBpAqsbbB8EFHQAQTAQ4Sc+jkgwGUeBoRJGNIsGo9pUwSBx6RB1va2S3K9s6S2V
         CPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786455501; x=1787060301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+uXX/O+ghaPCxxi+FLKI8R/euAQBof4H5fEH7NwBTI=;
        b=CN+clmhgUPo+1WfjspbXiZIinZH50hDI98sES7GpfCyRuZgT5gmJgLK6HebIgVxsrw
         j/lsAZTbqMwBMjf+e4mwShL+K0oHYqaDOna0b38nRQrfLFZ1cgQIBJXelhYFraTzuIQd
         r8IbxGTEZpukvMiqY85bp9qgdMyyG/7lms+f/ihm/h7NARlBYp6SZ4dHdEuqoehd8Nsh
         Nba48tACSXOK8wWPfseSs0RPmUwfj+8DwPaGUjTdhtFfsC+b+wZg4J+r5O6SvfCsIDtS
         KgXwSJ7Uroun0uBO4X1rEWyKJgMHc7fkeqEZKdLyCT3px+0t8a07kj2++kBw5AwYMb6r
         TVqw==
X-Gm-Message-State: AOJu0YxKk5ORL/IvwSVo7ICjDJQ7++HSHFmiMgIlgfuOuydAP+FUi/ig
	nA5Tk+t2PrpP1ecNtXjerO3xmGoc+c+g4+qZrmC0ZgM3wVuhfphKAVpsnPnyWsUYeIkQeWopZO6
	P/IOT5j2OmpMnINn+60C4nuR+OiljsMWkFQ==
X-Gm-Gg: AR+sD12QfNU6KchwnIzFprObrCaHnsmUL6Mw6H4gUDOtoZUm1PebALCOKQXhVFP+Ru5
	gKnuEReullU0Q1zF055YkSG1bwPhfu16UtMTIxRJ8mYnFciyXySNyz1Nsst2VvlsI5rUV7FlrF6
	SN1+MiXi4iN/akdOfVnfMy6kpo9/ERXRmhXcuKihCoyiXl6VVRIO4bwpCG/QbGhIoWW0NiExSIh
	kialIyrIn+4fAfFfsxKXCmiBPPP/vWID3azFsVuzVSGIQvgT3w4zVH+Vdkx4U4X34bh1mjc0Wbn
	MO+UbGyxg+1XWBMf/4IjJiu7yb9YJ5xFDk45JBoRk1yvlyHWnihbm94=
X-Received: by 2002:a05:6820:2083:b0:6a1:3e91:dca6 with SMTP id
 006d021491bc7-6b0a311c304mr1956918eaf.22.1786455500750; Tue, 11 Aug 2026
 06:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810165340.50579-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260810165340.50579-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 11 Aug 2026 09:38:09 -0400
X-Gm-Features: AUfX_mzaPy8OXaHidfSdo9aneHDwy6B6dwRTsD1nQ3Ynqw26gh-iTHfdjbbO8d0
Message-ID: <CAEjxPJ6NEVU412nvTA=taX+NSxtRQgQ6RPXbShi4YttYSa54vA@mail.gmail.com>
Subject: Re: [PATCH] .github/actions/build-userspace: drop duplicated make
 install, fix comment
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 12:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Fix a typo in a comment and drop a duplicated make install from the
> build userspace GitHub action.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
