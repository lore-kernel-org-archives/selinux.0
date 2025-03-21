Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D31DDA39
	for <selinux@vger.kernel.org>; Fri, 21 Mar 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547755; cv=none; b=c0TNXki+ceSN/h7sL25gQZujTqEIBeedgEQnStcP4uVyBYhLYeX2OaIEhjnptEDa+6r/CpAdwxqLVfdaQfCnvY8x2NumNIy3r/SaHKHdefTm6TLtbfQ6YRrZg+kJcUsv0ipbF0BGxEPNP77dpcIhwiNfOQziQk9h7M1rKqb+rYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547755; c=relaxed/simple;
	bh=jv8dMAPFcWGYlJPrgsLh91mYREX5ZpUyUOBYh5Cl5s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UURFMR5z4zet2mxSpqtIUK0Qi+vduUZhwijyBMP0CYHgc3IDAkb6PcOXprO7ZqGeT4NQG3uJgZSV7PjUodMSNq1M4WD3WpNr2y1rdijg1XBV0vWc+VE7CDv30r52qaTpMf/XggGkJ805qacf5ibjgx/WdLLKxYa34+F50EvJQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bhtpq1g8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bhtpq1g8"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bf251025aso15812211fa.1
        for <selinux@vger.kernel.org>; Fri, 21 Mar 2025 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742547751; x=1743152551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv8dMAPFcWGYlJPrgsLh91mYREX5ZpUyUOBYh5Cl5s0=;
        b=Bhtpq1g8pK/Jgu/liURGkTWVV1jJPjaeM1pQFyP0jrG9ZiMX5wNK6jwvzOSt7nL/TD
         0VwUy1z7Nifi/TJDQHchdIQDp01xW2ILhIsK1hg0ShLV+huNyUQhHalwZzO/sItHHvSQ
         tdau8Dt7CijkbtoTgU6+NvyLItYZSrBvnNqXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742547751; x=1743152551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv8dMAPFcWGYlJPrgsLh91mYREX5ZpUyUOBYh5Cl5s0=;
        b=f7KqYYF/yNUlX4yxgymF5SuXFEObcBzhrIEYN7R8ZMWZK3n2d7vuZjlQ/qaKD69/3W
         CPqCdlQznVQypc6Vu+PgGucL7DSteP8yJg4xrHEU2+0QQQAXE1qCPdL/PFfbWc+julad
         h0nRWBnPn7xt0qibJelavzmtrX9tzAPYK84paCVREvOj4c2esqgubhfefPtahwWgkKbZ
         6022XYx+1OhU+qGy4RO3YybX/s0eArXQrcpkl7u3zTppW9DV6x56Xx6/mOzhvGq1rTfc
         qR6l2dw6ZCRn/LZ/goO5yc8JkD5A5mLdPKzDBPo5uXRSbu6QYYTpqmNebuvbuwsqN41d
         +H0g==
X-Forwarded-Encrypted: i=1; AJvYcCVdQwfcR5/McquW9FCNZtLbjsDSeMmF1ma010LQWgNvrd96wCUJZQfrR+jgevUmRPQx9P2Hc+sB@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMz6wh/PYeBqb9NaT14CzyzLiZj68Ymt3QlP+C+G4v7U0JKQc
	ExMuJDz/a4f87HRsYd9ZGGTbMdsVFocq0Puc2Nv4NBg3jrzMPpQjwnYS2NT4wWRNl7z5sOSBcd+
	oTPf6JCU7sohBmnPZLPxThVMGB4BFBQMjaQQ=
X-Gm-Gg: ASbGnctI2tozi6NcIQLfS4KykBr8BGOcsLihIoiZGidDMZzAjCKQFsniavrqG6MFLR+
	gAWJtlpfktaPh9LrSW0HORBhw7Ep/9bxjvnXHGLWgECKQcBjCNz0aKJ3nVUfjRas7pe+iKR/OI2
	VPQQIAq3dQngT304r5YpWdA9uqnM8vnH3o01n0Its7k3oRYE4z8LBBsS8=
X-Google-Smtp-Source: AGHT+IEzRNYwm7Xcj7WJIdw/eu4mKks0io4TuqVR+9jsdwN/6h4w+FzaISIafQNTBkYrSTcMRPrcB71nZrSMtOW7Ukw=
X-Received: by 2002:a05:6512:3f05:b0:549:4e79:dd5f with SMTP id
 2adb3069b0e04-54ad64f7da2mr986364e87.37.1742547751133; Fri, 21 Mar 2025
 02:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSVpDDGW7rKVCYiOtgq71yfXRWDWegyEx3Zp-BoS9dj5A@mail.gmail.com>
 <20250319141328.3931393-1-inseob@google.com>
In-Reply-To: <20250319141328.3931393-1-inseob@google.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Fri, 21 Mar 2025 18:02:19 +0900
X-Gm-Features: AQ5f1JrckEJEy5Yy3RbGNtOTlmRVYQ4DNAemj9Din63M-7aMg2aFGE_1dqmhEDo
Message-ID: <CAH9xa6dAw_EVJ=78LTaCUdUSiJX7q5N60y4oMFOtMsugZZSocg@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Inseob Kim <inseob@google.com>
Cc: paul@paul-moore.com, cgzones@googlemail.com, jeffv@google.com, 
	nnk@google.com, omosnace@redhat.com, selinux-refpolicy@vger.kernel.org, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com, tweek@google.com, 
	uekawa@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 11:13=E2=80=AFPM Inseob Kim <inseob@google.com> wro=
te:
>
> > > or introducing a new syntax that does
> > > wildcard full match such as `genfsconwildcard`?
> >
> > That seems pretty awful to me too.
> >
> > If you can't be bothered to actually update the policy as you should
> > be doing when enabling a new policy capability, add the same hack you
> > were proposing for the kernel to the compiler/linker toolchain and
> > just start adding the '*' wildcard at the end of the paths.
>
> I think adding a new syntax is cleaner than adding a knob or breaking the
> compatibility. On Android, property_contexts introduced a new syntax addi=
ng
> '<prefix|exact> <type>' at the end of the entries. How about a syntax lik=
e
> 'genfs sysfs /devices/*/wakeup/ u:object_r:wakeup:s0 wildcard'? If an ent=
ry
> have 'wildcard' at the end, it's a new type of entry. Entries without wil=
dcard
> are not affected.
>
> --
> Inseob Kim | Software Engineer | inseob@google.com

I and Inseob synced offline and I let him know we have newer v2 and v3 patc=
hes.
While we might discuss backward-compatibility efforts for user-space
libselinux, we settled down the design in the kernel space.
