Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9033F1CDA0B
	for <selinux@vger.kernel.org>; Mon, 16 Dec 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331860; cv=none; b=HO5WNXSZwxpu1BPCUeNXr7X1LJxtmfhwpf+gkN6DwZGgBafoNUVMKnYnig8c2uX18Sstjf3oCBnSygVKSXnhMoNST8QtlXvwhfFmll7DbDEoQwdaNHt+jdaZgNt+thTBLJCMrJPbf+SgTbfjt/oibVmbV2kNaK3YUfsrQlTwacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331860; c=relaxed/simple;
	bh=aumZNbjCC9r4VVEVufGEkcyTrarCxXWpUa+1IeKbrb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P22WL3RAhH6Kh/TvLMQ35ZXL1ibtZ1Otb7okwfsv1ynYcc03sSyMGI3vx0yFlavfsMuHNIjoBSda7ZfPcwYRgRyULhBjbW2GNzNf8GKtiqH3hJ4IpHWUnbmrTQt7EX7UYeDvfLBkaV2YRdHtvBQEdiFoggH+sgiv7HzPuzpwR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U2G5wraY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U2G5wraY"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so34420251fa.3
        for <selinux@vger.kernel.org>; Sun, 15 Dec 2024 22:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734331857; x=1734936657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+tWYOCcWRN9FNJCqpuoIaOvic0DEQYdB1bbsNMBvAYo=;
        b=U2G5wraYUd5lC9AQ38ehrbw/EKF8rNIoworf3gsnkX8C8hqlWq9P/EJupsyzMdw8ZK
         5RaYl3/ZJ8miWIi5aAONSfqZ/6hAOUjQ4sEG+b/ZhInVSXM6ybFjq3u4TQZRHu2MEsfi
         i3vKAlngcXH19W95m1ECzcOat+8YVSS+6+law=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734331857; x=1734936657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tWYOCcWRN9FNJCqpuoIaOvic0DEQYdB1bbsNMBvAYo=;
        b=NYiVk2ZdvhcZKvzAA13vMF6KOiS1jCstW5ViCYQpEnU5DK2m5Us2tvK0oFxMA3rwEw
         ziFP+In8emz64/K5kSEP7TRpPdKf8JHGnJk2Nwd4gkNgBRvGLGR0Kws4xObb5ctMT/3U
         slZ5TieDJOz18zScXPtNCg1uv/Pa5GirBLsxSo+YMcZLoPD+i1vVdsM4qk37+wAKaFCl
         dzCAX63E0sqz7ZgsWf2E1tdUx3quPBZnuCGGHdgQ/h4AjtE+IyAhTqiK1ctN9EzUk2JS
         8vwTqqtMTAEBFBaJtYeK8v+HL8UxdUiBnD/iqbmSxMxvavKZPJRYmuOyAjPoHMBM2J/8
         JFXA==
X-Forwarded-Encrypted: i=1; AJvYcCX8MqaR+N2ZhOWOP+JSb+u4el4cBtb6zCOvEbQhy9rUuEoHu1ePNXUU65T3mt7YATc/9LZ/UxQV@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMxjBcgrf9lexZMaFDjXA0w/vP+9gKACPuguxE4p5/uoEUqNY
	EHQXdgY6zUh7y3+l0/mJUuAenB0RZFpV1Gi99cbc13ZYcR9J+j/C0Dr687H9Y0yPgfvIOsNMjI+
	5GfW5qpzAeaMXPAftOCcvav7LNLdQzaph3N8=
X-Gm-Gg: ASbGncvffh8tCMPitrdK5Yru7C7SucaVXrESbUSxkn5FhB8f5Yiotbu9mg2lJW85jHZ
	p29TdWkkEpLNdi9nruTzggy5pZqnfFA5nauziuRBJX80VxxtcmpXqNEUZG5ZL1I6cC1/q
X-Google-Smtp-Source: AGHT+IE8XrxVrlUaL9o2H6Ld31pJFPbsfDE9KdeY2aF/kFPlO3XPdw9KcjmY0Ec1G2qV9zM0Az6OQxTAEmhmsboiq0E=
X-Received: by 2002:a05:651c:1544:b0:300:1e0e:48db with SMTP id
 38308e7fff4ca-3025448cbd0mr36196771fa.24.1734331856714; Sun, 15 Dec 2024
 22:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210115551.1225204-1-takayas@chromium.org>
 <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com> <CAH9xa6ccd51V9fswkRX+xGfXHQog-wJQzB1LvK0pLT3CLYkfsw@mail.gmail.com>
 <CAHC9VhQrSGitY_TUAHbds-A8uQmn2TveTUrK-Jcd6quuMPHh1g@mail.gmail.com>
In-Reply-To: <CAHC9VhQrSGitY_TUAHbds-A8uQmn2TveTUrK-Jcd6quuMPHh1g@mail.gmail.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Mon, 16 Dec 2024 15:50:44 +0900
Message-ID: <CAH9xa6ecz_P+GwLQ_73_M==WF8cZt3bzD9NJz84U9B4mRdTOrA@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Currently, genfscon rules perform prefix matching (e.g., `/sys/dev` matches
> > `/sys/devices`). Directly using `match_wildcard()` would not preserve this
> > behavior, as it does full match. To maintain compatibility with this existing
> > prefix-matching behavior, the trailing '*' is added.
>
> Yes, the existing genfscon handling does prefix matching, likely as an
> easy workaround for the lack of wildcard matching, so if we move to
> properly supporting wildcard matching, and the policy explicitly opts
> into using this new capability, I'd rather just see the policy do the
> right thing with wildcards.  It might mean more work to convert the
> policy, but this should be easier to understand and more consistent
> than silently adding a '*' wildcard at the end of every path when the
> path matching supports explicit wildcards anywhere in the path.

Thanks for clarification. Backward incompatibility will make it challenging to
enable the new wildcard feature for Android or any systems that allow users to
define genfscon rules in addition to the system policy, since enabling it
breaks existing user-defined policies. It would be nice we can keep the
existing rules working.

On second thought, we might need the POLICYDB_CAP_GENFS_SECLABEL_WILDCARD in
the first place. Instead, we could make genfscon just support wildcard, since
this does not make breaking changes actually. Genfscon will be applied to
either pseudo filesystems, or old filesystems such as DOS and ISO9660. Pseudo
filesystems will not contain '*' or '?' in the file names, and old filesystems
do not allow these characters in file names either. Thus, there should be no
"*" or "?" in genfscon policies in practice. I'd appreciate your opinion.

Or alternatively, we can add POLICYDB_CAP_GENFS_SECLABEL_FULL_MATCH capability
for users to choose the full match behavior. Adding a statement like
`genfscon_wildcard` that does full match would be another idea as well.
