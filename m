Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954219F468
	for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732217; cv=none; b=LALsuEzaSNGfdoD41VLQDyeNT8ZpLMga21N6VD1YRIKUpxwotcxWyWaBAdZ49VMEUqmn7BHS+bTMRykpNpJCXEKxDNOkEWZxT1naPNNYbBVNP+UiJzdcJ693jvi/+rCHfB1TsZDkPbFJsRK1LvwtFJ/DAygtNxuIS1RkJLa/WAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732217; c=relaxed/simple;
	bh=GhoB4jdgPLUvG7kwGn5zgnlxuoDT8WRMMgSEmZbJmj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WshlIvjQXZ9Wsz0DGtITN8BrAfOdqYzaqcuYwz6lsUe/uiCTiYj6zKSVbQ9IDoYY+65dVGug2QbEiN/C82fSAhBReRRIS2VGCBP8MmQw751LdwCyoCZEODzEpy61MDRHWUrPwot17Pj+ye8XCk2okDIgweZb5S5M2JftAeqsZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QjuwKNon; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QjuwKNon"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6512866fa87so14458977b3.2
        for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720732215; x=1721337015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQEjnhPJsBKTlnL+AnULLgLA6phEDmk5N6W4l5c5JDY=;
        b=QjuwKNonZ2HHRTPkI7gzboeMAeLWoyvXN8gGBauvvQq7FJ7vet7tyUIrdD6asDTQNM
         0pTfNIkaFVLg7opKH0UZWlGUrfGAEc5rdg/8rAvJxONwhIPU4JsISGKHOFKZuxLdduCi
         6Zh7LBq0egYWA5TMjDIpAcbOyiP1eUqmBt/VTlxd79wnT8pOptAUfSoft80uoRV5qkrB
         glVudhuHzkNfGxmoLRudHbZNLXiM023GhClw/EYEeVDoGchQCRnNra4rElFmPjPmW2Qz
         J3eR8dfljm55++56szk689D+ruQLQQpyctRjuDqyUNNMogtEYD7YJdXPDSh6YvboR/np
         eY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732215; x=1721337015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQEjnhPJsBKTlnL+AnULLgLA6phEDmk5N6W4l5c5JDY=;
        b=biPQqbany6OEP8M5rjnzfOeYMz0boq+FthyblAI2ZWenHIKDlqunMRZfnN67Oewxr+
         vx8P93VBcl4eBp9qspsvQzJrG+ibAFUtmFu8kEGgIQwYHMnCpuLCK0zS0+DGnJUOK2/y
         p5LzCx8BHmnchvJ207P9ntfBdKApBx86bKgP4bZY2elhtWXLsgPzCXgiGnHULU8m307L
         bG6O0F3q7LM/93dNBBmm9ufcv+NHzV1ywUTPt6vp6OsaYabotL+TsCggA17ZoJejtbNK
         7AP8tGDRfDIrDKPt7Hb/m0nRUGNYVIv3bD7lL8NwSZiA89QGKaXfbsUVumrsDZgkMbZm
         en9A==
X-Forwarded-Encrypted: i=1; AJvYcCUOMrxUhj9wQVm6WlDrdgXbq21yxlljVgeN0oMz1/rW/l3mLM3WeQv+gy41K/l78UDICyIJJZZP7ESnNhYJX7s7lLR/yUxMZQ==
X-Gm-Message-State: AOJu0YxItusWZTfjs6poBZDD8Pwy3bcYvk0OaHoMVbdPNEKGWHAIHsPi
	P4EgMLehDRNedC3v5XHfllbXFh8hCPjV8679nCJ6eqnVIlLYfDlXJbyLsyh8QYTXhCE4TMpqHfN
	8QPYiVy7UAM8Z3Vyi+RcMejfaUEk+RU6TOQbK66LI5afXsTM=
X-Google-Smtp-Source: AGHT+IFk850plTl6FfUzJCerB2fJLct5MptmpXAlnhVn1xmW8r2nJvcEpPHxKRke7LUllx6inZ7id5LhARS4bwB6VMg=
X-Received: by 2002:a0d:d083:0:b0:643:673d:2f8a with SMTP id
 00721157ae682-658ef34aa9dmr92055537b3.30.1720732215050; Thu, 11 Jul 2024
 14:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703025605.63628-1-guocanfeng@uniontech.com>
In-Reply-To: <20240703025605.63628-1-guocanfeng@uniontech.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jul 2024 17:10:04 -0400
Message-ID: <CAHC9VhQ8y8fYeLz8KHXVNrLmp3cLZtUPHsagf3fym3gJvoTs3A@mail.gmail.com>
Subject: Re: [PATCH] selinux: Streamline type determination in security_compute_sid
To: Canfeng Guo <guocanfeng@uniontech.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 10:56=E2=80=AFPM Canfeng Guo <guocanfeng@uniontech.c=
om> wrote:
>
> Simplifies the logic for determining the security context type in
> security_compute_sid, enhancing readability and efficiency.
>
> Consolidates default type assignment logic next to type transition
> checks, removing redundancy and improving code flow.
>
> Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
> ---
> v2:
>    Modify the format to follow the generally accepted style for
>    multi-line comments in the Linux kernel.
> ---
>  security/selinux/ss/services.c | 36 ++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)

Thanks for the revised patch, it looks good to me, but it is too late
in the development cycle to merge it into the selinux/dev branch; I'm
going to merge it into selinux/dev-staging for testing and I'll move
it to the selinux/dev branch after the upcoming merge window closes.

--=20
paul-moore.com
