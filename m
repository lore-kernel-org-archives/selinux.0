Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1476399372
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183418; cv=pass; b=k8anNLshypebO0xHxoIpbmwLio2kK50168wbOQimMgCCfZv2vaOo2m+Yl5nvM+e3hsBQU87NzbcYi7lFsYt8mXxJ/8hjowjESKvNSuC7JSU7/ScZvMc/O2PCEgf67q12Stk6FJ+kN708ACn6dh7RVnlR9UTdINXIyJOPfdalvm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183418; c=relaxed/simple;
	bh=l6Wk/6F0CJ5mE93UKcVZQ/+R1EfTSIoUMGc5X7ThiYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2Lee41onpYVfsJOn1EYAst0J5sf7Vsc7xSvOdnveadHzS6p/gLnfCXFuD8/mqxWcjP8SB5N126YtY46rjjqlId5W2e8gsmYh5B10OAtvlVUhAPuR0rvMAk9JU0EQE0v0BrCjozidnVa8d9YBB+eD8pr3FG9lNFi6qJIc62cFRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kR5d1RFA; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kR5d1RFA"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso1670281a34.1
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 13:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785183414; cv=none;
        d=google.com; s=arc-20260327;
        b=lISKBIU3rmp6MUwEUORREDLCDO9/rHG42Ai8ucfc+lzf3F0ZPa/XV1pXHFU1zkq0l2
         TW7/YC8yqwZ/D2lHgZA5+c6GCKNZbI86eE5F8xoHSvku9toiGUzYFtYykxoF5RQcbYli
         TlDP5T4lQ4sMSjus3HYmgH4U7NwE+uvn2pj2tdRNy7FJGFfCYDlFjZ4i5zeeWyOD27gU
         P4XKzI0VnOBrrDU9117c6sBhyk73mS9Wuj9uFsHxmLZsnbjPzW4j0YmM0fPj2qJYv5N3
         /dxlr0mr9maWbzNfbeqrakJy1rxFfTPWhZh71bBM7LYcJjNAW14Ihwerk0ZIgb98xY23
         LeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l6Wk/6F0CJ5mE93UKcVZQ/+R1EfTSIoUMGc5X7ThiYE=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=QLEp+A7PFk24QUVSiCjbN6E8okXE/vFLvX9KkJ00jus63+TKCq3K7pZTJvSpl3ko7Q
         TY6h+8wI2JW5lejRQoEqfdHkex2lJ4ZzZUzSl/DmRDLhCAG/J8eBTgNjBw/nG19mc+6O
         QTREmjvbIJn7SsanV0e7TH2u90pvck9P+p16NZGcauDOcUMMbkSCeYaL1i/cqm0ZK5Yz
         ec0X/h5+ynK1bIlmm2OpCdwWGaAKepm8ZEgZ1jEsAZlVXYwnfAsIeVLKlhvX8wuK9qrT
         b1z7+UnpbnTUBhu0ZzysJG0VL3JhdZlgR4XJpMJDfKun5k5n0slcOLXDyw4M5jN6r+Ri
         9x3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785183414; x=1785788214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l6Wk/6F0CJ5mE93UKcVZQ/+R1EfTSIoUMGc5X7ThiYE=;
        b=kR5d1RFA87qFjcg276n6yK6WrxiJbOCBDZ2ZpDMHE8GHN+hXBV9XXqb3GKXMjya1nK
         9UJT6CZ0yBfV9a7tvrq/0UGXIta1iFwqjEtvc+scFDtihC7ri81lqNET94Td1CRFWQoO
         a6uqzkV4TvBGVVFIciJkFEiG1fmGVeQcQtwyiewCJGHmqLY4B72/U6D2fJwbEWCUWvbU
         Vz2DZdoaApfUGSxyFf2PaWgY7j0Bl5VdJ5bzIsGrM0IpOxeXnWq2zvpBsvCI0B0Y7swV
         GobREdJ8CvGlcMH4NyUyBVLNi8QzqeOBMsE+ezcTnv0qqintNkWDx/CQanyYDnRqFrTd
         uJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785183414; x=1785788214;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l6Wk/6F0CJ5mE93UKcVZQ/+R1EfTSIoUMGc5X7ThiYE=;
        b=TlhH6pvOkl96DF4v9UDKZ2aHjSnrKyCjer0kfdi2GlRG15zYyJc7NPUhjTQOegQv8a
         frvwtyP3sZp3jMnzAC3EOcOq14kSk56W8Ca7j4i8nM9BJ2Tsr4GZBxUsz16ok74Hjp+b
         uRtI0385xFevt1snq9HTPSoGuQ4ygiMyHBQ7ocqsynpT8CacqDCQyvVhK6VCEa2J/hkq
         k+AyIa2UYBay6nC3Zp77DthmecxoMMYvJWd+E1tg5swVZ/oXS5/13hRVSohjxeoFrOix
         EEidyfmhPO/FzOP1q0Hecwx6PQwROHLYgjo90xGHa3GNbLOOT4fQdIkbf1BRvIZ6oKsF
         wwXQ==
X-Gm-Message-State: AOJu0YwzS1jVTZAp/jlAzY7pf3V9bQR0kqtB/hWgaCTV1+SwId+XBp//
	zOqs8UwHBIZZ1lJGFtgjeelR9/NhSzy1weqXU64ih6gAFqL3kPiuE3LgVpepflyx06VWnWxzTCV
	2S2CnKtnC0xJXgU3pxM+YcYdHwp3xrlE=
X-Gm-Gg: AR+sD12TjIlcOoAG1+edNZ1pq4LtwfKbxjiura/U0DR2QKJ6nkS1IGyVZWUOKQpozxn
	OUSg1ayzD2dkALSat5ZlhO5OekntZ1KXXRNqNerlixIrUqzZCmUTW8gqWNQHwbbVKY9p1oNOJcD
	3dSAHzgtmEIlZG5BHWsDuOkVwkOQ/xOgEy0uGH8c/PP9muKi22GIUCmx95PWldHBqI0xSNC+qSz
	pgs1sShiey2eTPC9+bbsh+nCeyjSpypeUeehEmVLlUUCX/7ZlfjKb4/cdxcZw==
X-Received: by 2002:a05:6820:4b01:b0:6ac:90d7:123 with SMTP id
 006d021491bc7-6ac90d7072emr774673eaf.57.1785183413657; Mon, 27 Jul 2026
 13:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727013929.2457799-1-tweek@google.com> <20260727013929.2457799-2-tweek@google.com>
 <CAEjxPJ5bkPUXBF5ge0zChcWHQVxMX3n0dGRFsYJnuSyfk44BCg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5bkPUXBF5ge0zChcWHQVxMX3n0dGRFsYJnuSyfk44BCg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 16:16:42 -0400
X-Gm-Features: AUfX_mw35A6QhS33VME9XSmVlp_4m9PdZn6sSuFHFF0pHrVXH4BYEgL3Ynz_B6c
Message-ID: <CAEjxPJ59uCpyzqv6mAt2C75DBnhQxnYiAUg_U65dRFrvJJtmvQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libselinux: support multiple context files for the
 file backend
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 9:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Jul 26, 2026 at 9:39=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> >
> > Update the file labeling backend to support specifying multiple
> > SELABEL_OPT_PATH options in selabel_open().
> >
> > All provided paths are stored in rec->spec_files and processed during
> > initialization. Derived files, such as substitutions (.subs, .subs_dist=
)
> > and auxiliary contexts (.homedirs, .local), continue to be based on the
> > first path (or default selinux_file_context_path()) when enabled.
> >
> > Duplicate checking is only performed within each context file. The curr=
ent
> > behavior expects the ability for a later file to overwrite a previous
> > declaration (e.g., .local).
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series is merged.
