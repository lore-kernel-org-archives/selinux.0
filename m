Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D0303A14
	for <selinux@vger.kernel.org>; Thu, 11 Dec 2025 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765449468; cv=none; b=T/2Pm4cFuFPxOkzF14JVuJPNVPwIuX3PF9n21jZAo2G1Ie3/P8bp7VzKwPZmvtAuBCkd03pUiGpxbcPmFbuL4k1iqbD6MNubTX1WurqVy2XPaDifKYtlWA5++l4atW66PE8HUcz3/i76ny/XM8w+LUPdIRhB4MUNqRm2JvNt55I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765449468; c=relaxed/simple;
	bh=9BRTH/FEGnS97KG3LM0lBBvG1ySlWbwu0HJaW9O0rNw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=AEhzGUKuHZDecpT87eyhUIt+4bQLb6YR+FiehKMRDPuzRSpHSeKpnYH81oRx4BWCkWJwLsammat9ieqmF0fX4b3ik+oQytTHhokVAyda0KgCo7k6WMBuODwchyl5wED61mtzuQUbKs3OUk8txwj8bD2mOQ+MAgXmozuENSl6fqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gy4M2ztW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gy4M2ztW"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-597de27b241so934322e87.2
        for <selinux@vger.kernel.org>; Thu, 11 Dec 2025 02:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765449463; x=1766054263; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BRTH/FEGnS97KG3LM0lBBvG1ySlWbwu0HJaW9O0rNw=;
        b=gy4M2ztWJpmEaBDVuRlSu3B9OtgZrgaYxYfQt71AAhU/GcQzBdY7uonFOOISfBE126
         2u42j6dwkrFccuwjtftgHAxMRX5K4+GKSOBmjSPr/dr2cm7id8UWR+HmHlLvLKoghDoF
         hVIM7A0nzA8uWxS2WpDIk7/CsBBrj4DH9CtNMBxg/1YlRe2Dju2kHCTPAQI9h2ANGfRr
         YIyqhcc4uVilFlNo/IIw7bnOmCcNCJjzwkGo9e7QC09ltvTKQqNrQ+wbYTJ5xRVHxzpW
         iuvTcsnh1LIcuj/Ryme3Na5DD1EUazH0+ExV+2LdMNQzhZY0hVh6Cho1aMoKcuxHBaab
         TZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765449463; x=1766054263;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BRTH/FEGnS97KG3LM0lBBvG1ySlWbwu0HJaW9O0rNw=;
        b=ERGyVPw9jQOBn2I1YdPFLN3m7Q3CietXePdpK0QTjAfe6NacN/+V0PS4KoUVexoaFu
         QGslteGvqmpt0aCLHodunayXo1JKgphfww1HH/tqwuDBByzF3Hxqm09smj0VD1EBu9/S
         HaKDadWOaISQrjkMBsqUh74/r9NCebwj/EN4TwbNJ+FZUHWQy/ppSKZK6BmE05U7UFRG
         SUhqUqlTa9YssA1dmroqIpbGLM0jjlTDJS25xpPnN4llp7RP1LVLhpom5GOYAlNZNqR8
         oOZcRZ6PTnvmrs1G3otMh8Nl8ROWptTt6EgB6+3UzPy7YGiajUmRlocVCwsfOSQiJrs2
         e+aw==
X-Gm-Message-State: AOJu0Yz2XV+6awFd1FoLAjwT+WKk88Ist/j2O9zRzEBwQVovi3fsvp0U
	BXcsfMSGWV7yVm8Kb2UfKz8YzJZjD9aSKAP+ywVEQhh7IrBGFc/Yex/aVaCAnsBWtfv+oDOs2FE
	giWroZPk=
X-Gm-Gg: AY/fxX7sxtOOaLRbfllej910FzyIbVHYqEEUBkjZfnq4cvQrshcz9GIwfqT/7q4TeAF
	DSKJAfmVBOBgkqYxOzlLQhKaFJryOAQwa4QQzJe6kXPUWgQ2lIw0BhnbQ9eJHlzFryD0fFZsHoY
	msMLue75bJB9DwI8MucE4dPXBQ4FsRaFy0cyfoVGd9pIWxrvSSf1zOLKPKONaSQc7sbuqydZ8pj
	kLl+eq4mCbGEiiR8qu3vkYspYuGDL+gJ5DAB8Nc4IVp2rPlZa8A18iwvyCqdtZW+L5z+0oqixEi
	2XhImvncB6D3yFWaTt1SGW2Mi0p9VjMrqZDnOfn8sdz/GEa7NCCXfcVhVS90Q57EnuVTtlZj8ma
	qQ+8mHv86pTRDpIZf2kEaw4Nva4AtIFflHz/kZPaDpmBIqBMUj/Vx1n4KAe0oSCLFr5gjfrZbg8
	15r/UbDW7wIVg27h38zUM=
X-Google-Smtp-Source: AGHT+IERqS1L6ci7q8dGntRfw2/ZItR2qtmAlqrQG8XSEGr8iPup2BGl+AX1ZFkBRb6+fnmg6Y4WXQ==
X-Received: by 2002:a05:6512:33d6:b0:595:81e7:3daa with SMTP id 2adb3069b0e04-598ee52e8c5mr2220693e87.27.1765449463194;
        Thu, 11 Dec 2025 02:37:43 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2fa75efsm748663e87.69.2025.12.11.02.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 02:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Dec 2025 11:37:41 +0100
Message-Id: <DEVBLPYYQNMS.3IOZO4CG4IAYU@suse.com>
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
Cc: <selinux@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [LTP] [PATCH v4 0/4] tst_runas.c, ima_{conditionals,
 measurements}.sh enhancements
X-Mailer: aerc 0.18.2
References: <20251209185557.20598-1-pvorel@suse.cz>
In-Reply-To: <20251209185557.20598-1-pvorel@suse.cz>

Hi Petr,

thanks for adding this tool. We will probably need to update
documentation as well after this patch will be merged.

--=20
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

