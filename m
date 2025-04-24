Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA161FBEBD
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527048; cv=none; b=dgr+GJ5KctktLVVdkQhiyrP+sch2punHw21KkUHjuC+HUOyGDWWZayqIEsmSQJKWkTl1WFHcpA0Pgfrthplot67c0q15LlKCQ/0fLnMczsDXrma4br6FA5x4cV0j3usQycOG+P8iQ+gR3E0oFiAWH8CsJkvcaBkC6oMcI8IZ18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527048; c=relaxed/simple;
	bh=nH7YnN2/t70+laLhi7QQmxzafObnqq5o51sGPLhaGgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvd8pgx3Zu8NUvGx0Gnyv90v0JFzDK4a9r1p/4AI0LBPJntKfmEGM9JsztPrueN568jPahschxJl652BuBm1nMw9v4z24ACIto39VdjvYJaTST5tEo3rdj9NVEuGcqBv3XVh/ZBgO/M39TYT6aaWSCVYMBniRfQGd7zl35p0UG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MEmJKZy/; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MEmJKZy/"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e726895a6cdso1413593276.3
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745527045; x=1746131845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8xe4ea8ikh9HcFOYDyLFpFVyAY6ql5Lh67QzfPHkQE=;
        b=MEmJKZy/8a/tArpY3i19jZZ+KgtmyKwtiKLPRjKbHqv0T7nG4curj2funcQZD7Cn0h
         cA/7RnXXGwTCYh5zrhKqx20MJy+5fMhG2fh+N9sZ+sIYtROMg7bRWcqlJz12y8IzN3KY
         6yAFheAT1IeFAlbVse/343damwNlRmCIWfBH/NBOgEKJ9ESfwhmcDcRXcNfpnX8JUbSP
         y2SWveQduOeV2c155ZGf9rFtPHbPrNaLecuPsvfbmjQP1fVa7P5e5em4+LBjPnOkKeKQ
         a1XDSYGOGTAq/flnd7E2MVq5X4uQwT/qR4TXrZDj/cUmqC4GW+ORWa8db4hxc8AIFRpD
         0GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745527045; x=1746131845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8xe4ea8ikh9HcFOYDyLFpFVyAY6ql5Lh67QzfPHkQE=;
        b=d6duo2H2wioFqKHCn/RjM6X9Nh7NWaicFLa8vJ3/CKhmr5HeH1E2YNS/hp4sJ2qygr
         9KCNclfeCT/GbWNPLsXaxFAlV3MKx4iOE8U6M3WTt7+1lSIjRlzILB9WEezPS4r0NKYb
         UtSsxS44Bjojnj8oM0jFfNOvmuOihFW8RV7D305CqzRFWCD93jJSzWLQ5ur6XBQT75LG
         ULaWt40K+cSQ++WfTpqPeFRK0qto3BN2wg3A5fmCkTKdOw+6Nk9FF2HRbt7N8xGLqjMS
         bh7vWEzrVCSUL/NhgF/rk9bvHbi34a/DqAJ66utiIsZ/5btSzNLsDWEmt8p1EHTX5hhc
         kJag==
X-Gm-Message-State: AOJu0Yw15ly14ARjyMaHYiQ3ecaDUGrKqaIUH4pyHHvgj1NWQ2INDkDH
	olqJG4bnct6lZh0OlPHf07nfu2WTWuMiTLn61jybGfuSBTbWxqpRt87PU+3pFt4ve6tgFVGZTDz
	etlUx/1dyBbLDDaED6ZT6ntgph1y8oWb/GLVQIylUvmqL+f4=
X-Gm-Gg: ASbGnctpRrL6EV6QMmekhcaDvotlQFbsN+zDCjGfDjJSAewc3C23zQlITFZ1NnKYO74
	Q/xPWZe/xJP5JB6/yizLZj/BAN8Qi6/qxDuWJ8RajB97LDihzT3ScysJqqW0IyFsgY3SagO1W+x
	GLbGqoyx7pGXL7ER4dsSa/AC42D4uo5BHk
X-Google-Smtp-Source: AGHT+IHXa/xnkMCJx0XE8SlaS/b1KwZPZGwGrfzHvRQ14C9FpW+d3Eflajj4nW/UUOCl6y4WT095X1XTZcPlm2LlnwM=
X-Received: by 2002:a05:6902:1b01:b0:e72:d88e:80d3 with SMTP id
 3f1490d57ef6-e7303669acemr6251555276.36.1745527045530; Thu, 24 Apr 2025
 13:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424200310.2409-2-stephen.smalley.work@gmail.com> <CAHC9VhRk-0jFcap7xeELQBykx4EOa35EdkyRB+V86nGXnXf-qA@mail.gmail.com>
In-Reply-To: <CAHC9VhRk-0jFcap7xeELQBykx4EOa35EdkyRB+V86nGXnXf-qA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Apr 2025 16:37:13 -0400
X-Gm-Features: ATxdqUGFLO13vveJZ07bwTTOP8axUR5ttg8Ev7Gcs7ar064QYZgPx4ItmmZogfo
Message-ID: <CAHC9VhQvCo--R4zGc7UOjfkW+DiyHYxA+Qmu=rMmX4C07uyNGw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: introduce unconfined as a first class concept
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 4:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> ... Admittedly, that likely wouldn't present
> quite as many possibilities for future kernel optimizations as the
> _UNCONFINED flag.

Now that I'm thinking a bit more about it, maybe it would allow for
the same types of optimizations?  One could simply treat
AVD_FLAGS_PERMISSIVE|AVD_FLAGS_DONTAUDIT the same as we would an
_UNCONFINED flag ... I think.

--=20
paul-moore.com
