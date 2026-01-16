Received: from mail.bizial.pl (mail.bizial.pl [141.94.21.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BCB30DEC4
	for <selinux@vger.kernel.org>; Fri, 16 Jan 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.94.21.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554531; cv=none; b=NFBSfL5FY0bW3yp2V2Gwt/rv+04r32P5LD6POYeHhpXunsx5zW1XkkP5UY/jGwIr+5faPkfwy+92QiyCoins+CA84tQZRvYevJoaawSo1j8nzRLZNj3Y1HSNQuBmocir4Ro7VbpN9yIqDZyahZeeQn6Y+FYsAcNlT7beuispbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554531; c=relaxed/simple;
	bh=T8G42ymPsbQlOmSfXp6t7vdzurf0DxoeMgYu7hEL14k=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=RNCWPE0LBRg1SKchzJQlpfQ819+SmA/2U2XUR4nof8zLCUX1grMcqV4F7Ec/qZhtTY4ZJ5D2AmXRHFt/P7cKkSdKfpPI7r93YQIHvm+YZJ+zCxpf6hkpy8PcDHJ3ig/v0IVM3yX5jd8GMJwoHR2exaJAzHdxT7Lssou7098CoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bizial.pl; spf=pass smtp.mailfrom=bizial.pl; dkim=pass (2048-bit key) header.d=bizial.pl header.i=@bizial.pl header.b=okxSdTiS; arc=none smtp.client-ip=141.94.21.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bizial.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bizial.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bizial.pl header.i=@bizial.pl header.b="okxSdTiS"
Received: by mail.bizial.pl (Postfix, from userid 1002)
	id 6A871256D4; Fri, 16 Jan 2026 10:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizial.pl; s=mail;
	t=1768554447; bh=T8G42ymPsbQlOmSfXp6t7vdzurf0DxoeMgYu7hEL14k=;
	h=Date:From:To:Subject:From;
	b=okxSdTiSWmfWMTC1JnUOgdowBcl3QYG0J+yWZGLnfoPT3Dl/gPGJPbemXArF3q5nq
	 vhVZ2Z38/nZlhMO9XEYVZlYDn8sfUY5UBeuKcv4K7uRyTparI6V6a9nz5dYP/SwqRn
	 PNqES19ZEL7/YrnePWC1vs9UdIylCVCLiArDE4eMeqfkwHtB2ZRAaOW1/4ZrsD0KOQ
	 G4K83zLLsr8iiFPodbrkv5DxSBcExqzOw6fQ/RTr5YRrvF4CC0tz24eVNM2MPSjq8G
	 5IXG/3s5/8JyzdOr/ud/4TLUG7gDz4u3oWmG3zAAdVspqqS+NWFGNT5Rii1NLrAXpo
	 oSTCpWGLBYCTw==
Received: by mail.bizial.pl for <selinux@vger.kernel.org>; Fri, 16 Jan 2026 09:05:54 GMT
Message-ID: <20260116084500-0.1.d4.2vyaj.0.74lpe4xdiq@bizial.pl>
Date: Fri, 16 Jan 2026 09:05:54 GMT
From: "Filip Czuczwara" <filip.czuczwara@bizial.pl>
To: <selinux@vger.kernel.org>
Subject: Prezentacja 
X-Mailer: mail.bizial.pl
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry!

Czy m=C3=B3g=C5=82bym przedstawi=C4=87 rozwi=C4=85zanie, kt=C3=B3re umo=C5=
=BCliwia monitoring ka=C5=BCdego auta w czasie rzeczywistym w tym jego po=
zycj=C4=99, zu=C5=BCycie paliwa i przebieg?

Dodatkowo nasze narz=C4=99dzie minimalizuje koszty utrzymania samochod=C3=
=B3w, skraca czas przejazd=C3=B3w, a tak=C5=BCe umo=C5=BCliwia tworzenie =
planu tras czy dostaw.

Z naszej wiedzy i do=C5=9Bwiadczenia korzysta ju=C5=BC ponad 49 tys. Klie=
nt=C3=B3w. Monitorujemy 809 000 pojazd=C3=B3w na ca=C5=82ym =C5=9Bwiecie,=
 co jest nasz=C4=85 najlepsz=C4=85 wizyt=C3=B3wk=C4=85.

Bardzo prosz=C4=99 o e-maila zwrotnego, je=C5=9Bli mogliby=C5=9Bmy wsp=C3=
=B3lnie om=C3=B3wi=C4=87 potencja=C5=82 wykorzystania takiego rozwi=C4=85=
zania w Pa=C5=84stwa firmie.


Pozdrawiam
Filip Czuczwara
