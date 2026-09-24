Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D24B487D
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276841; cv=pass; b=LMltubn1jgTQU9skykUU55lUhWAn4i2IITlJAmDY7jFtaJB9ntoLvpeDC9yWZFOuWvY6SCG6zSMCU6eaAZjVA17/5jWQMFy84z8uRMnkDuXiU18P6Hp6S/R0FoS4yReSWUL0ElkuixpzewJ/qmbBWvnVbGxK8l0NyWuur0kaa/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276841; c=relaxed/simple;
	bh=CivqF49ja6jklZuKxy0TwxzfsP53fbOWheXl9+keSHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOnt8HJmNZMzCt+RjEpeJR1Z45d8m3FVKcqKwGi493zYyTyzFlW/LIOga0i7atAijkZpEFVTduVbq2e+Mhwad3h6J+iK/gfp/OUJebbFRLJll8v9sT9eJlCY4lcJ78rlF0CQU0ZoGzrhSIDcP6mITCENZZy2Ubs/ntqX1sLSovU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpEhJlJf; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpEhJlJf"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505824so1674127b3.1
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 12:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790276838; cv=none;
        d=google.com; s=arc-20260327;
        b=lv9S+dEecYSrq98YT1xB3jDXhoRsLAxGu5tzqg+Bo2Clupcqs05C36Y0cck7mnCuX6
         Hse8CSdZXdRNUK0k5l1iXMf28E8AZH0xPTv3pRan/3TyiGtN5INzAS9y+DC1FPlKznR0
         h7ak2kBIPIp4MW403u9u5E6kAZyh9+IU+cWZBvuGjXgtq3cGDsA3Z8l4gV5xzC7efHAU
         cAIZ6hr0x8AqB8rYjN3Jpg2LWcutMgMuGereGGApoeX4jNKzBQCcVu7jMT0vPqFixcYE
         LWZo8LHD8ZJW5MFiLfPWGIn8ePJzreUArG/6cwSeNOTBDW0YyORUrmQUajd8qqBizdIi
         3+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CivqF49ja6jklZuKxy0TwxzfsP53fbOWheXl9+keSHk=;
        fh=dc3EQ/hIxp1pauLSo3m9n6KxtPvL25eRgmVrAAZOHiE=;
        b=e3Q/c6E+mZbaKZdL8RiESP7jordi8IFvo/TBgnL45B00h0M1o9+f/slct7C0vCaTEB
         yJGhYk9erp5XFoY/l8i22RhdOvXKCtCbAdYNmjo3B+/nmYot8hAe3USKyU1hTmrnqysC
         OSCGzgnyT5MF+cJpKct2LmS3gQM+SylR3go0A+X4M0hc9+m/7Z1gNsoqC0qtPP/nZd5y
         4KVF5EP8bTuW4nSrah21+hwD/CKnazq8koubQhr2Ch1SRdm94EdWB+T6YjJhUjOuP1mb
         jw7BrSzLHEOj/LarHBpWIGFtfQBhN6EKJ766iVmKEbVGMqRTkoD0QP4OkXqHPHRRFVF9
         r9Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790276838; x=1790881638; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CivqF49ja6jklZuKxy0TwxzfsP53fbOWheXl9+keSHk=;
        b=kpEhJlJf5k+EWeDYLAQYilry9NYx+jvMAK5h9guDfe6JLWZ4F+NfbNWqw0MQ5CIzwd
         uCSlsR4FU2emHDf4w2sv1guhIDlfo0TeSHACDv6bdFfdUL5I5s9R0YIjhzB9ybfjb7jG
         cNf9bKqh0LQaoPARQgmtMT+6izmeENS+HYTzPPTiufnEBZeSIhV1HO+/BL8+jToou4O2
         LGffeU0cvT8UOpbTuevnaBTgdoM8pGHpMGV9jbMTAK/D/L/dG4mToGEcdbO6sLyIF8uX
         MWjXf4jnHo7qY1oLIx49TXoPgCHrjyQWE62Er2+OVv6ojzsIJmikzF9QGk4TgddSHTLp
         br3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276838; x=1790881638;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CivqF49ja6jklZuKxy0TwxzfsP53fbOWheXl9+keSHk=;
        b=PzYtys+f7uzqH/r/2DawsiMN2cT1kO/irdnWfvcXOYAF8i31StXNaeO7+pFp7D0cAC
         1bkVh+5QtpHty+Pg3MMdgIkjiV3mKNYLxCG0ezIIo2Ne5/ZTEtiw2dYQ7MUzUN9lUf3K
         zy6CEzmJUb7vnlbBtvZWm8ZqllgNunCwoJ8ltLWhzJdWm0PmW42p+xybXhNdQfr3HvKU
         2gqaKfjigrygifPbD49Kll8V/vL5JfHEbxUjreHW8xvPJHnUReTB/yqDSIPcNyIRjGyg
         WT70UJwQwuU5eGh5D6Ejxn9yCb0Lw5YjChb1f8w0PztUXDXzqroVSOBSCIMa1x2OD0BA
         rqaw==
X-Gm-Message-State: AFuF++klHZVC9wLs5BF+44mKbfLiv6WSpgWrvy7Vh+EPX0P3G4pUXOZO
	+uovR8wor3IJ5kf8HBzDizi227DN3Vwii/vx4TGRNpNQGdYHxSqNnIFS5BJ6OCDGmgoM75MMt24
	0T0r1EESpsUqMoUUbn27elHA3LGt5IWu/kQ==
X-Gm-Gg: AYBFou2bsjE2RNXV7ixSywY4q2E/cgIdJP6YMxbKE15AShw3xXDCL6X8ASvTs4hsWmq
	DMG/J/7oSFJQnEqhfJd+cM8Vd/YMZcUe7bnBiEAq4YGrRkM4qjRcKfwObsYcdr4HhtAClOFolwY
	7cyLAaiYv56xs1SfjOlBEN0hWh8gkz3ovApnhDK5oJWH0R4OfftuhiORGoPrLIl7qE4rfL43IGP
	0wjOwDMMZI1iWK141f/uLSb+hQDsxMnkd61AgDhJMxJmnNwq1E1sIxO4uKe0JScdc2wL2olcQXx
	qtkTijtZgpm4Iq5UjpUEPjIGWuLIxg8P2FnmzXAyRGQ2oXjG6lG1d1U=
X-Received: by 2002:a05:690c:ec7:b0:882:ef39:13ea with SMTP id
 00721157ae682-8a64bc4f8c0mr17689277b3.28.1790276838342; Thu, 24 Sep 2026
 12:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924155435.64444-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260924155435.64444-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Sep 2026 15:07:07 -0400
X-Gm-Features: AclHuK9EBoPRfLqbE0WsCaqCesR437FG96TuF-Ohq1t4txok5MxNnoGz8cHVDk0
Message-ID: <CAEjxPJ5v1LVyEmDk6esgNY1-EBiWpD+M_MS-+8sPuUW0LdgCFA@mail.gmail.com>
Subject: Re: [PATCH v2] python/semanage: document and export the user labeling prefix
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> semanage user -l has always printed a Labeling / Prefix column and
> semanage user -a/-m -P PREFIX has always set it (stored in users_extra
> as 'user NAME prefix PREFIX;' and consumed by genhomedircon for the
> ROLE template substitution and homedir_role selection), but -P has
> been argparse-suppressed and undocumented since the 2013 argparse
> conversion, and seluserRecords.customized() does not emit it, so
> 'semanage export | semanage import' silently resets any non-default
> prefix to 'user'.
>
> Give -P a real --help string, document it in semanage-user(8), and
> have customized() emit '-P PREFIX' when the stored prefix differs from
> the 'user' default so export/import round-trips.
>
> Reported-by: Laurent Bigonville <bigon@debian.org>
> Fixes: https://github.com/SELinuxProject/selinux/issues/140
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 adds a space in the man page to prevent bolding (8).

This has been merged.
