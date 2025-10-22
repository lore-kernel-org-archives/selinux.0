Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1E305E2D
	for <selinux@vger.kernel.org>; Wed, 22 Oct 2025 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176072; cv=none; b=dTrnmmgj+12ttb5CESaAklj0pr5XY2RntJ5XXSai7SiW1FlsKYlft2NkhSifq9X3YjcTuE9dXbNc9oN1PIXY4ysvOKTLLEhH8+uXc7zLKuejrbpiGQYwG94EPWNJg6wt5HdF9uMd3GZCcxYFIvcvqqSUnyFZmw/bqSEwqdBLrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176072; c=relaxed/simple;
	bh=SMAOENLFLnEuNnFZ1B57t486wsXpH7mhGQuf802qEsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFEiHDAUJXj2Z0QD/jdLR3QiqiIq+WmGESoMyLnJETxPQM6RqYULqRJO1tLdx+dd5QtVGT8hmeyzB2pu2f7jNVS4ZY5qIscpinUCdkfGfablQGsqZQau4FTDK4ze6x9+v3PbLyjvKCzyM70XCwyKurIo766IV0N5ku/yo7Lj08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q8f6meju; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q8f6meju"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f5d497692so249526b3a.1
        for <selinux@vger.kernel.org>; Wed, 22 Oct 2025 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761176070; x=1761780870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYTGG9Mb6OsLLfCv5H2JjYhedhDfFTXQmDBbuKdGPv0=;
        b=Q8f6mejuot8zc2yRERzbqti3HeoTvgR8KpPG8kLTncFU3Viwta3Hn/tO9VZMK8e9iR
         buFSjJ4JUX2wfiMzEE87djhoicf+/c77NXCGGkdV/+tUQe9Bl0T3el/UOk09o24c1N8u
         7yXrzN0d9BH/Yc0Qj9Ne/Tr+/9EBF0g3VGHtH62xw+8pOeRDjJNePuagH7m4QnSW6Cpz
         4+MevC/CeNcaDOikdBGoJSKU/cfefzlc6pQhKU5lcG0cE0InUTOpGsNXxyDIjxZxjJQ6
         Ku6kSaX3Imp6h+iG5LbI6N2Dq4ZPoIUQMTarGNKqDC+0OZL9Kr4bB7BvwxxEXC2TGJEy
         T0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176070; x=1761780870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYTGG9Mb6OsLLfCv5H2JjYhedhDfFTXQmDBbuKdGPv0=;
        b=jKCTDTNryg5QUE6o0TyXzYA4ThBkmUpoPFPio4BloexeHSkDmaH3Wl2ybJB/ADXa/H
         rFyjhtuJ7NapVUzKhySSlqZdxGgmc6Arry/Bxy6ifaW/MYh4eJCiAGsFv75YeYrw8C5y
         Z3ryH+ybBFA2io3eO3CBXKSYjdyMB5L8+46MumNMAfqCB2AqrAniy6CkjWjooHBDqeGu
         tpcnsoycwRcHWnplGhKwsY+HQanV9H9rbfNgmmBhzJQ5zOsIkif2vs4UbsLJNSlZfvUP
         De9RIC21nNEft9jTW451X7PO4oLq2wRrHyA9nRSR1GBRPCIIjNLtNN16qPjPEDzdgnz6
         8JvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2VYg0dczgwmHrt4Uo8xQ0WngsBScgTnXKTb9V5M5b3oWzYV3zEHq7nh+6v5GuvomYdcUb218/@vger.kernel.org
X-Gm-Message-State: AOJu0YztAcnft0BEqFyxDPO63K1LxjztPGoE4so+H8LQ2BIozZqTjdq/
	P7GMMwuF6gKPcMeYWmSYkdIM5jEAHDKdWAQ9khgGd2lATZQ8xcw8ekih8WuJm9xuOJpXKCo/cD6
	L0yYMwsxlNQ4qK44oJ3enpUkOQB3Bd1D/6jYnFhqH
X-Gm-Gg: ASbGncue+r6Ehov3+WYF0sCo3ZLyrkx2WeqHEhx3+7U25+Wg0zmCU6EJ2HQxBeK1fkg
	48d57D2nhavG4z4dxDsIOrlnX270uJOjgk+rGEH6AFU4ABAZkH0P94zTEFX1AO1PUSRpXMSc4GZ
	SehzkkwhLNztgvT2YzJSIALWnUczPuEWX8rPYIHHWy6wsKCxgHfPIVs3RsiSqNDJtzj3xtxJQqA
	s4X/m2qgBKO5G/SLYTS8SNTJKwGM7fHKVeA8s8syseY2GoCeMX42q42mw7hbFFek11lFms=
X-Google-Smtp-Source: AGHT+IEpdFxeI3Tg3wPnuZQbcK3uSFH1zDfkYZ+d44nuiGe8slDFYbF1+f2bbbTHcXljNnVPc4f29mGU4SVhJ+4wxrk=
X-Received: by 2002:a05:6a21:328a:b0:334:a523:abe7 with SMTP id
 adf61e73a8af0-334a8594429mr30867764637.27.1761176070015; Wed, 22 Oct 2025
 16:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017202456.484010-36-paul@paul-moore.com>
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Oct 2025 19:34:18 -0400
X-Gm-Features: AS18NWB813Tg6fqdUDfKRNqfMg-iS1a5dI4NsDx5kG5Rq3ywJYs9FofpNeOyw_c
Message-ID: <CAHC9VhTNBs4+n6m83hbwJk4APALsikmwcHoyX67GWHLPZPSQBQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/34] Rework the LSM initialization
To: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 4:28=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> This is the fifth, and likely final, revision of the LSM rework patchset.
> The number of changes in this revision are very minor and barring any
> surprises I expect to merge this into the lsm/dev branch next week; I'll
> send a notice when I do.

Here is that notice.  This patchset is now merged into lsm/dev and
should be in the next linux-next release; if anyone notices anything
odd, please let me know.

As a FYI, I also moved the base of lsm/dev up to v6.18-rc2 to grab the
fix below (it was affecting testing).

https://lore.kernel.org/netdev/20251015052715.4140493-1-edumazet@google.com=
/

--=20
paul-moore.com
