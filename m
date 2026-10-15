Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336014FB9B1
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073251; cv=pass; b=BnzPCEGK1HpBozgmY+EGzq7RZ7lWFw9g2SAtyZHOj4M2V4j36nnNZc8rccImHUAFmachk3hll71YtxiLA37lSdSe7Ju8LlGRAogyAm02+Lu2lt7zseB28t/0WO/s5B0BPuPLtp1E2pRjPXd5KRBYXN9DxieFG16BkGHQICvTmbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073251; c=relaxed/simple;
	bh=fkj1r0MrSWxf4byJiYSs4RQHnv8+YVW0tdVDj4L7jEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnl3v7quY0f6tdUIkBcK1bQAvAK3sul6LDlvnuLa5CCZFP5rIUxduMMUowkoVh9VNGY0q+PT9kCYpnUJ520allxGcw/5AhL4ZTmOy5LAj0zYbl56TNpkW8/coSvk7T/zWdYN6as9IHKDgc+erfcGrdy5A7oUNIxPxWwc/BVKJa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7fcbOfy; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7fcbOfy"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67990a45e02so1824793d50.3
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073249; cv=none;
        d=google.com; s=arc-20260327;
        b=gtl2vzZiNQbywUaarTgvD94kbydLubDSVwuK+QwP6Q7HGjY4ZpkAVzDYrEIxyRCsJm
         FqmC7Vx99xkzcg20Zwvhs+eHtcJJzq5eNESUj85HGThXJdni+kvLEaDGDQzwcdiao7X4
         3jvqAzo0DDoV/Y3+avChNyCZ1PkV0UxoxdaVv5IRC20jiaJJuql/S11pRHQBanEYplfP
         Fiz/UdKmXlvrRUF/LYC504JWBAaP+RLR+E6FmAP9vrckC+OSJkisGNPim3P9jFbw9M6c
         gUjSjQ9BwlkaZFR8IeJOlmcJ8/3GajJxAGAYNTkl5I+JmDSK2P2fCtKmCNQ8s/UmJin0
         RyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fkj1r0MrSWxf4byJiYSs4RQHnv8+YVW0tdVDj4L7jEM=;
        fh=gBydrNMvjriJbd9HrIy1Xz3jsVrETImIXW7v+LTQWN8=;
        b=gbgTcqDrv5oeX/u7JkDBvlEg0/HADI/6mNhJ0Zbx0ck0Dp5hINeMbfIJa62DipKd5T
         Hk2cfD6BUALCOCYcQX6a8EPoyLXhg/8j+S8YnjgB7rW9UcWGjpvjgEQuvYKEB1ElgIog
         tGNCGy1Rf31zkcih7f6fKNjEqYIntseonQknbXBER5RgbH+PmLw+DYFSw5DAUceyCz3P
         kZBYzL9L4iTrJM2E9L/Kv7KCjzc8Ezvh03vUpjs89mBIUjZGDj405Ep6m0/9t/m9Wq2F
         y8VgKbBubS/kM3W7VkHo0YtrfyaqHwWUnYWGsjMKT3rf3SxmQHMMM9Ho9Ue8fV7kLm1k
         fW3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073249; x=1792678049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fkj1r0MrSWxf4byJiYSs4RQHnv8+YVW0tdVDj4L7jEM=;
        b=s7fcbOfy/mV4xYSH4vaJI9coGyOoAvQxIBF93KkK9iTTFq/6wUZ03yUcritGLVETti
         9ODZXlCaSl9Vzb1DI6v5Z2l9l5GrwcKo3eFucIkbBqz3xuFsH9ZpqRxDEjlgB0Xe0vcF
         6/M8dJZB9GBtQuJrmolix6sM3VodLqdgybIRRwWbOyhjfOo9/BTHXZpNAg1raZBIt/cg
         JRbwV6YCVS/w7sj+zzjp9iT/5ibDMUP8GnBJUdTv8K6f4J95Eb4XtF5Jep0D3qno1Xbq
         WM5r4FKMUHxPRU/RZbQct2uQmqEP4HZJ6thRbXPzX3KANcIYX1aW5442xTyoKQLFgaus
         /Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073249; x=1792678049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fkj1r0MrSWxf4byJiYSs4RQHnv8+YVW0tdVDj4L7jEM=;
        b=aLYnwOtG1KHZ+l6nhQ0SLk4+qmWuf9DtOdqhAeg8k358D/2eHPwWA5TwgvTh1ir3ji
         awJKyZhOs+23B1ui2kg8a4hCQjdwiL5nG0n1ntxkKL0TWbzZnukPEKrZRW2nzyz5GOC2
         pRTEsd0Ox553qAE7I2CWE0eCChAwa0CYLa8fy4gKW4N/dSPr0a63c9g7wVY3whGh8tHL
         BulnMoIwGlBy3efBQRdiayCVbHIWjd5bnPEfgnuZiPiQdw52k8aUEFLNen/QshWL7C/4
         4tHxZiM1fTxBiJecNImHSj6h8mU9iQag2jO9KmCjiNeYl1CkjMhetYA34hfMHTlxkFAu
         a96w==
X-Gm-Message-State: AFq9FYJTnChZQLDgGH374QhAiKfN6u9njJenRjniA0JwYrSSysPrK6ZK
	gtgnNrX4ShSaPRaPN5jhIOBosxunpQ1o4LifyDp0aa2FZJsl/PnthzpLxsBgALfHzBMok+dvVIB
	LbcDXCTnnoaVmNBp3JdlcaEVEycoePB4=
X-Gm-Gg: AYBFou3t8+WZJNl4prEdjzqSK9RYH1ybQHOh7iKiageYhJ5H5fUQsHb1rQNsvAlpME9
	r9KgqagSyD2j9irzggse1vIiVzEWBuvsBbmrwlIsXctgpHcMKsjS491NL/5+/9Au7YHtN/ok1cU
	eBcjWfkYBvUzBuc3nRwaMw3ayEhFcw+vKE6GAISenlIsO2DnNV/uBwDTqCbH2efohB/etoY7M57
	WJVEWcr3z0HaLeTGtpbflsBzUqtgWURnobeS5pOWvC1K7MYEzBJVeNbaVzBsNpAPKDJa7OyQawu
	xeLk/BtIQtj4iMlhFQ6jgUhIRPf56UbM4BBJBWli0zCKa+xva76+A+U=
X-Received: by 2002:a05:690e:118a:b0:679:a58:14d2 with SMTP id
 956f58d0204a3-679369ea4d1mr6835414d50.41.1792073249095; Thu, 15 Oct 2026
 07:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015014457.877322-1-tmz@pobox.com> <20261015014457.877322-4-tmz@pobox.com>
In-Reply-To: <20261015014457.877322-4-tmz@pobox.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:07:18 -0400
X-Gm-Features: AclHuK-4JrqtvuRQk_dhbtU69Kx-BkESKbvALn2JAQemRxrcn4iXHGDpjdIkf5I
Message-ID: <CAEjxPJ7hw-W9gSXb2QJ1-QkZD-4EGNdhS1mEHPh0yWj_kNbkTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] libselinux: add -V option to sefcontext_compile.8
To: Todd Zullinger <tmz@pobox.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:46=E2=80=AFPM Todd Zullinger <tmz@pobox.com> wrot=
e:
>
> The -V option was added in 92306daf (libselinux: rework selabel_file(5)
> database, 2024-11-05), but the man page was not update accordingly.

s/update/updated/
