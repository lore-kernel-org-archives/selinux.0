Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088B21420F
	for <selinux@vger.kernel.org>; Thu,  1 May 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135699; cv=none; b=TZ8rHsBQB5DMbQ0MxUp64NyqH3F6XmXSh7AMY/Nc2cknjVYNKWqw+FGHphNhn8MJ253nhxvFDrFfefMMcAEHeqOWLrSOZDXPPiP+Fc3HUZcAFA7qkofI4gqZFKqUjhBm7d8TzEUXqzHB1OLmsLcCiwMEt93xEFHJDuoEyS61BgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135699; c=relaxed/simple;
	bh=+DI/FVL6yjZ4eh78JOb2h08Ujui571ArayEi95LXWIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgpLZgzdWebKjlW1sMadqnXpuQVBK9MHV2fBN+vvC6fBIIprz+JhqccY4e8viDvqh+pJ7ZtiyXbMVsJ8FFYp9qZycaEtKQDR3/gPzuaGlEYhSd+HybIFfNTP+O0dvFhD9TUwOoUcqFv8oIlscTe9PVuAL8Oao8EaPnr4eWbWTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=K9eyipcW; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K9eyipcW"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e6582542952so1067876276.3
        for <selinux@vger.kernel.org>; Thu, 01 May 2025 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746135696; x=1746740496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QctMbeE70hxXYOJicDt/r41Nghzd4xOqWrBlkNoECTo=;
        b=K9eyipcWxHL5i1ggj9hI4gZ68heZVuJz3B3cIBHeScFqiIeqi5YQ+VnhzVu9ZZgJzm
         ckB6IS5n8WA0s7eQ56FLK+UpW3WLjYZmtpDUEfQUKmhpj/NyZk4RwhV5cusp0n21D7iT
         A03QxyMV24tdpxFfBseBeAEbjiXsTupTcJ7gW0WNmvPovu/VKeYTrkZNuWTZjsLmiXcd
         CifbOcsn+DrrZqlBZGAH+8sYPxIrOVSK0XMEi3VzUzu+GqfDGLZ6NKDMwjL9sqmPxJtQ
         GUlNOn0LRsCHC5ujEalK+AtAPq5aa3wansb4m7k99lYhS8jmGXcu2nDC+4Icw2fEROns
         vTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746135696; x=1746740496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QctMbeE70hxXYOJicDt/r41Nghzd4xOqWrBlkNoECTo=;
        b=JIVkPVJ0jFhjwl7jfoQb15caKZZC1HJo0XGx2qEH1Enwa3yoEJp6XZ4qZTLaTumFxV
         KaHYvSBSbcaPq7bDCmq/7JT2RB/CAco64VabXhJH81CXscqYmbZ7kaIqC8vg2UMtXPJn
         LCC/63PI5BIjrF0ofjGFVDeAHJuucC7/UYVjolDWfSOQE5QL8I03iO+Omua2V4er9NLU
         pt/HgVQ8AUP5Odm2F7urPsKVPRsdfJ6vUwcBHLGrlgfiCb2BiYfmX8RiVFND0G88HYH2
         V8bCn8MZCfHokODAzzgW5yq5zdbr0kvyeFX1OYA16tAEM3rizhH5Uw3sWAZar4uB8z+k
         iGvw==
X-Gm-Message-State: AOJu0YyNmRFSNfKeg3giXfe2G5Lo5NpHNNFu7NtQo0KVSuWOZA6xC8BU
	4VXmHbgviPnOKoTn3mFjGXCLHf+RLeYNvj0R7Xp2oY1EEJFzMgS85YnbkIqq71A5egIY12BItKp
	8SCic5yyp2yyQLY9oRJHDPs6IrArpUl9zA0k/
X-Gm-Gg: ASbGncvu0Q423rnbxvqx9yqmAUkrdmLwqasy8FvBHAUdq8aFo8iO/Hd9C+hsN8HKiBR
	qHhTVl9w7eNcYkM3mENVE+uVZ+G8MLgHGtSaUmX3ygoBV22aNOesQA1jWCbP1tpd/XdceSgEejA
	2v0vJ/lF/HUF2ktq3H7BBKIQ==
X-Google-Smtp-Source: AGHT+IFbXd27PKiWhg/8g10pNE2jmugdi2QO1bx1sJGSEmtd19+ShVcKM/OSCrRUI93wBPmovixiBGmvY2M+lI34UOs=
X-Received: by 2002:a05:6902:18c2:b0:e75:36bd:c097 with SMTP id
 3f1490d57ef6-e75655a57fbmr970939276.28.1746135696616; Thu, 01 May 2025
 14:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425123719.5984-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250425123719.5984-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 May 2025 17:41:25 -0400
X-Gm-Features: ATxdqUFIrN4YtJMuISpfnSQi9Td7XN6Bsml4iSVSguGlxnESgMniMZTFLD0tO5M
Message-ID: <CAHC9VhQE6gEwpN5Y=TDQZQ6sZF3u81iqUa8oH9NvLUy3sc1xRw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: introduce neveraudit types
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 8:38=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Introduce neveraudit types i.e. types that should never trigger
> audit messages. This allows the AVC to skip all audit-related
> processing for such types. Note that neveraudit differs from
> dontaudit not only wrt being applied for all checks with a given
> source type but also in that it disables all auditing, not just
> permission denials.
>
> When a type is both a permissive type and a neveraudit type,
> the security server can short-circuit the security_compute_av()
> logic, rendering the type equivalent to an unconfined type.
>
> This change just introduces the basic support but does not yet
> further optimize the AVC or hook function logic when a type
> is both a permissive type and a dontaudit type.
>
> Link: https://lore.kernel.org/selinux/20250424200310.2409-2-stephen.small=
ey.work@gmail.com/
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> If this seems viable/preferable to the unconfined types patch, then
> I will update the userspace patches, but it would just be a global
> renaming from unconfined to neveraudit.

Without going over this patch very closely, generally speaking yes, I
believe the permissive|neveraudit approach is more desirable than an
unconfined approach for the reasons mentioned in the other thread.

>  security/selinux/include/avc.h      |  4 ++++
>  security/selinux/include/security.h |  4 +++-
>  security/selinux/ss/policydb.c      | 19 +++++++++++++++++++
>  security/selinux/ss/policydb.h      |  2 ++
>  security/selinux/ss/services.c      | 20 ++++++++++++++++++++
>  5 files changed, 48 insertions(+), 1 deletion(-)

--=20
paul-moore.com
