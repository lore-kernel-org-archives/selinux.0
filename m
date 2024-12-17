Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6A1885BF
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419588; cv=none; b=DAeEqkEqIbtIEStWI3whGU2GGVuqjG2L+hFtfCT8YgmniiQ/Ra5Elf1K1Je86DimMb7cOom2bj+iM7rHc2QlsDIOFeqp4rD5UhhRfopZSw4fl2jgB1KgMHTzmfAJL7xGdhJ9CLyKArovxlTPo27i//h8hzAiqEQQGeyv3J9inF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419588; c=relaxed/simple;
	bh=Y2BAiqiaZbNRAlr9sAWG2EG3LoguqaKizXLdTfMMsHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjGuzKIBZwRN2uLpbrAsMaPGNT86atsIA6hT/v9yLeOMLakJpuPx084x3aBK/hdPJ1BCSWE/1eIpRoRg058RGPZqrocUfMksftUP1kI35C2yaE/ZBJ5kwTpzu76LAcDBh0ep56hMIQEbTDYyq8UuV/sro/FoUP8uabIhavETh7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fmIqQ00N; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fmIqQ00N"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3035046d4bfso19891841fa.0
        for <selinux@vger.kernel.org>; Mon, 16 Dec 2024 23:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734419585; x=1735024385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2BAiqiaZbNRAlr9sAWG2EG3LoguqaKizXLdTfMMsHM=;
        b=fmIqQ00NI4pKIwA+9sUp4b0YlTXXUpEIs+Nb2zuauzUxw2T9HK4TtxcQj5wAg101no
         XYQf/LisBLW/c2qURMWQBHQEKEan3QHsCoLcCg3rWrTtkXBaEue+lgC3dGzZUPH5E1T/
         3iWJdcM+ZGH8nAnjSO0Z0dPz29kapL6//uKvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734419585; x=1735024385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2BAiqiaZbNRAlr9sAWG2EG3LoguqaKizXLdTfMMsHM=;
        b=J9h02lymNu7I3ILCTeLZ80GE2WN4RMeNELQplZ0yGOqgCKJjdiwZwFxJjyQFHJOE07
         wNbruYUSWpxIltSXx1SVEZiIejDenPQCxVH8fy8Wz7DG9bMnemet+k3RNBknKfJc3CiK
         goZ9T3+DILf7Efp9Lae/oJqDY/Pujs0FP7XtlFhzISikZWG6yoR65t2/uL+PY0wX1F0Y
         V+3VN+mSJNbDHad/LMXZIjqDkRDJMexunSyzK7cawTZbifz1kd8rgV/7ODRXN+SmOEyn
         8+jVXzV647ue2DcBRGxvd4QiPHH6sh1gvUBLlcqp/Oy+8JsQqI+sZjGtRSdRklVxWlHN
         X8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWixlqi1wxqNqkwEd39a7X4GrIWwZSvYVfmd0HxqSKeHllW59vmOYVow2YnB9Kz8hED0yprAS3F@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGGptX3jZjU1bWP9yCN37M03x7kbXym+jTMvCk4f04FMbi9fC
	OC+19zqiCf9Gt0ePwMoNoTGGN7TyA1Wxh+8z7QfvI7KzCYY3NKiRHN/9+Bq+EyWCh3LlcIlptWY
	JH1TvfsvEylD/b4UnSG1eogfHhLtyf42ec24=
X-Gm-Gg: ASbGncs8GGv+OP5J/xPcWLbCcUwDSZLOqCEhCkCsAhP9RIA0cxqXGMojECeaWRV6OKv
	MXuIDrDHXSEdBdYGuUQtiUb9Gevz+MY43HuXNZsNTIWGqBCuY2rTh+G1lBQXZQsDlkGk=
X-Google-Smtp-Source: AGHT+IFxZ5Es8DXC60SYmsgfWC9RmIx5PrRln6Mc/k6cjTXJB67hF3rmsUd1cZmJJgOcFiSZwuMpmAU5bgXHiQimCgo=
X-Received: by 2002:a05:651c:1a0c:b0:302:5308:ba48 with SMTP id
 38308e7fff4ca-302544642d1mr42541351fa.12.1734419584930; Mon, 16 Dec 2024
 23:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210115551.1225204-1-takayas@chromium.org>
 <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com> <CAH9xa6ccd51V9fswkRX+xGfXHQog-wJQzB1LvK0pLT3CLYkfsw@mail.gmail.com>
 <CAHC9VhQrSGitY_TUAHbds-A8uQmn2TveTUrK-Jcd6quuMPHh1g@mail.gmail.com>
 <CAH9xa6ecz_P+GwLQ_73_M==WF8cZt3bzD9NJz84U9B4mRdTOrA@mail.gmail.com> <CAHC9VhTta96fojwPuf_JRTws92=BLqRPRcDc2sBTddH-50HxoQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTta96fojwPuf_JRTws92=BLqRPRcDc2sBTddH-50HxoQ@mail.gmail.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Tue, 17 Dec 2024 16:12:52 +0900
Message-ID: <CAH9xa6d+zJRoZMO+ip_DR88vhxBf6PoneQBkrGuR7F6PqD1r-g@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> We really shouldn't have compatibility hacks when enabling policy
> capabilities, policy capabilities *are* the compatibility hack by
> allowing systems to continue to operate in the legacy mode until such
> time as the policy has been converted.

While this makes sense, as Stephen pointed out, neither Fedora nor Android will
be able to quickly enable this capability in reality. What do you think about
two alternative ideas for right things; just start to interpret wildcards
without introducing a new capability, or introducing a new syntax that does
wildcard full match such as `genfsconwildcard`?

I made a typo in my previous mail, but the rationale of supporting wildcards
without a new capability is that wildcard metacharacters have actually
backward compatibility in the field of genfs. Pseudo filesystems don't contain
"*" or "?" in file names, and supported non-pseudo filesystems, DOS and ISO
9660 doesn't allow these characters either.
