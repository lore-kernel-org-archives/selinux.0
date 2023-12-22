Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED92FC36
	for <selinux@vger.kernel.org>; Fri, 22 Dec 2023 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IjE1xGt8"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbd71f33cd3so2184011276.3
        for <selinux@vger.kernel.org>; Fri, 22 Dec 2023 14:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703285204; x=1703890004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPavDZH14/SIQbmSkGIOmQBvLK9NurQdJUvtQLcXavY=;
        b=IjE1xGt849ATkSTwDhKcCAh8bbqWNsjhXU/DC5fOHhAFML/O+L+CugAGzZWby5fNcC
         aG3iznvsJMPdknb97kQD5HybiWylKkgBq9Vh+zsVMkbprKodN7qNN1q12JB8cLi+Kl2k
         8a7nRIqR5dz1jY++ZoHRlhqk5gE6HNEa+CLctkmZI0fqmS2VvlBJoLt9Rbt4qVUz9ZVl
         SV4v4pC4Si91piesO0nMcIJi3P0KZ1H2SFeHp3Jxz0Gr5IJ3coQMCOz9VAjHdf+g9SAQ
         FbF9nHkcKQXOlc4F7IO0pgK20yUFVN19P19nqIcZYXBd/iDvudBwE5dyqmG7qk8Q1bGn
         8T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703285204; x=1703890004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPavDZH14/SIQbmSkGIOmQBvLK9NurQdJUvtQLcXavY=;
        b=byPvJxPgtU/bM7VDDKrDNR6HdtsiloU8vwogZYHdTJ+ZOdwpm9k47xd3KPP4u+ZxLq
         h6WUWzoLgJi7QQ4copbpZ2nl3xqbs3isXaCbRn6/LRskJ4Tg2GlCCtkFJq/bASLf92dj
         oFQl6oeU6uj8Kcwq2QX8grQhmLr6WVfccTVOnJRjegRZDvBTmN9agpVl/hQ9fz/PyMjP
         lm9R1gQhy3zxa6BXrhkIqG3XKhNdlDi+2ctmrOQEUOFw+zysr+6jxwiPk7ZTcg0rrf/L
         e65F7qjGPusXtnB0QsE8JWJYRrXe0+hgvbIz8pkjrVuT0sqAVXr5XUzNf76UuAmUgT9s
         EU/Q==
X-Gm-Message-State: AOJu0Yx+2qkH0ne1CCOWmmCzi6eU3Zh9bLD7HYtxWKT+Ywz6ujEdOIGB
	iJvJaxrRBd/BcEfsjzxd6M1bbUVyD1ZaeEXOQykyMxCoaNFe
X-Google-Smtp-Source: AGHT+IHLcOsU0tmjo107fD4FG9OJ4Wc3P5rt+PdxisgkDp6FCwfHl4/jHlSqGXr6fDE7vAYKyqyHHqke534IzPwLeNU=
X-Received: by 2002:a5b:c10:0:b0:db5:4680:ceb3 with SMTP id
 f16-20020a5b0c10000000b00db54680ceb3mr1681616ybq.0.1703285204673; Fri, 22 Dec
 2023 14:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121122719.2332137-1-juraj@jurajmarcin.com>
 <e5095e3efcf18b1ab85e98d421185309@paul-moore.com> <20231220122049.gi6qkng67jesels4@jmarcin-t14s-01>
In-Reply-To: <20231220122049.gi6qkng67jesels4@jmarcin-t14s-01>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Dec 2023 17:46:33 -0500
Message-ID: <CAHC9VhT943edUro1WyjXnonjpeJx-g9Zjfh30fREEH5iV6REZg@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: add prefix/suffix matching to filename type transitions
To: Juraj Marcin <juraj@jurajmarcin.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 7:21=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> Hi Paul
>
> thank you for your valuable feedback. I will incorporate your
> suggestions to my code. I will then report back with benchmark results
> with included optimizations. I suspect, kstrdup() in
> filename_compute_type() might also be part of the reason, the patched
> kernel is few tenths of microsecond slower, so I will also look into
> that.

Thank you.  I did look at the dup'd string for a bit, but didn't see a
relatively quick way to do away with the additional string copy; if
you can come up with something that isn't too ugly I think that would
be great.

--=20
paul-moore.com
