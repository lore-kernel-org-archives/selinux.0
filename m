Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5497E1DD889
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669799; cv=none; b=dKnRbPVkyxqAJXMfn35pzfshuf05ytr8iwIdg13/VWXV717OM5GGrafQPV9HkYoG9QHPB+aAOe2EWq/waW+d+sO6vMzMqSQrwtawGeCJL65+MoVGoZt+D3Nd8M6Kz4dP4HKygUW3VU0ef6KCHHAewpMSKIkMIFlowE5Y242e1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669799; c=relaxed/simple;
	bh=4HoR4j5jnQ4jdFPc0ILo1cpoQbbh6shRA/NSDbibN+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEb3bVR6+Wl/mt8OgYRNS7EmcUVvsasOra1Gcyx1YAuKTUrpSlzZGU0ButMEDsDY6RLf5PmIKlaK17ODyNPpOrnYCNedHEjjgmd/5q7SejJQoLgpXC0gGpPFN/GC+SEg0IBePo3SHnwLtPL0pcSXg3iLfz6Y+o6ygtvXtOsapxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M1ad8YZp; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M1ad8YZp"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e819aa98e7aso149073276.2
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749669796; x=1750274596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28SBSuDiOzPi7mQIh4g9DUjq5Xr4xFxL8PnZ5lHpaXM=;
        b=M1ad8YZpv5UZaEDDcQt67NB+qo/o2WySq3TzgEkyyoZOeW8OfqmpqCK3tu7PA/tNja
         Ltr9HrT6hOZBq1wMMghIs6aIOBQ2uIQKGbxTtlyFOzSEtQZRbxx6MnxCwfu0VMxwxq3G
         Se59qb6MQWpjST5bDSjgYJqXt6/J1xg1tbucPakGa71Htg2nrOtA8GYLzuotB67is0f8
         qDlStqhvmIpNbpWWy35AGTMLkR8FcMYs+enicOZ13htJZia+B+aCQauiZsD3YlxZLJgv
         kimFAdBYZXcM/IGWFKovVwMI50X/nxpFXemprFoUMWfkILrKqZ00Q2oG13ezNVz8ov+Q
         jFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749669796; x=1750274596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28SBSuDiOzPi7mQIh4g9DUjq5Xr4xFxL8PnZ5lHpaXM=;
        b=cYpSOz/s/Mz04xhY4NPpOX5yVgTNlboXBDZ/2ToydvLKoljtUKJdqiXD6JQ2m4RBSA
         6Z5Qa+ID0se5IezfabMse8Lhe6qKwUqCbb7IIX2wOcbXzBErVZg3xiD/YTzp7P/OoHKi
         Euz0gYt6VSVjir4tajlE/8HoBRzEtCfBth2MRErKUFnTJawkAv1uynZkInIFDfc8BbG3
         6EWe3kmNtpuAHj27/bCcgdfT7N7Tthv4xovsOcRUsYXewESl6tU2AaDvNAtXf+1f6m+t
         6Y+vTJldPmTRAhmOznJEtbFbCO+9U+ZI0QBqc6XoIJdknlltltj/UtjdiBlGMEnWl9TI
         FcZw==
X-Gm-Message-State: AOJu0YwXfPgr0pSXv9Lgi9zvpA4cqu9tKW9z0cavplHHT8DhIoKPWsXy
	oyp6G8etWyFYJ140ysTB9UzZ784005LkFMfPgGzO+G0g1y8db1ft6GB8DNCi3xbzQaC6FmErKAF
	sWsx5oypUcmqSAAnntvTa/4CeBsGvjq2Lu86u5uR+
X-Gm-Gg: ASbGncuoAhHUs8ipE03aGN72s3via/BTuprQiinm/uiUV/MN4IYFZklDVwet0VHDCH7
	9wvrizKL5BTFTwdeHlfH57Jag8kmia5QYvLfXvwVBz2cAEj1fGfKuN1l3+RWtNggoBaMgLfbjTg
	Puty5FcRVp5/ojxKA80Ok/qPCCthEfZn14oR7T8z4m7rDewbkzIhRiPA==
X-Google-Smtp-Source: AGHT+IGDcPg+0ixVjd9OzcjI8pmay5Pj8sUGBtedV8o4awtw+ZH8NnmJuMh5OWM+CN/SpHFb5PoYGJm4y9COYmpapYQ=
X-Received: by 2002:a05:6902:2502:b0:e81:2740:2d96 with SMTP id
 3f1490d57ef6-e81fd9cfcabmr6947303276.17.1749669796236; Wed, 11 Jun 2025
 12:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 15:23:05 -0400
X-Gm-Features: AX0GCFvTrinNYan_LFb2WYqJrRbiQdVHz4c5CyXMDPZiJREDB5n6MOk3fBXforI
Message-ID: <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On F42, iptables and ip6tables are no longer provided; check
> to see if iptables-legacy and ip6tables-legacy exist and use
> those instead if so.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  tests/inet_socket/iptables-flush | 20 +++++++++---
>  tests/inet_socket/iptables-load  | 52 ++++++++++++++++++++------------
>  2 files changed, 48 insertions(+), 24 deletions(-)

It's been a while since I hit, and worked around, this on my Rawhide
systems, but if I recall correctly, fixing the problem was a matter of
installing the iptables-legacy package and perhaps ensuring that the
"alternatives" config was set to point to the iptables-nft
implementation:

  %  rpm -q iptables-legacy
  iptables-legacy-1.8.11-10.fc43.x86_64
  % alternatives --display iptables
  iptables - status is auto.
  link currently points to /usr/bin/iptables-nft
  ...

FWIW, I think there is value in testing with the iptables-nft
implementation simply so we can test the new code paths.

--=20
paul-moore.com
