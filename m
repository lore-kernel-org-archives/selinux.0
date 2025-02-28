Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD8328E7
	for <selinux@vger.kernel.org>; Fri, 28 Feb 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759382; cv=none; b=QK0DC4CCWIGlmyLCwXCFItzobtXmGtl3liLgxMw9ZTGiYbXm1b295xMu4BP0dvrXA56A+gI3fwmowBqrZkF+y6u3T1DjUmjYvdBKBAJ8v+YsaAqmt8S4P62BsdKoNnV2FKqI9ggQqvEBh7t//KliBCE97wxaZjv3LT+rwcVj2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759382; c=relaxed/simple;
	bh=FiOZxsL0zt3JSsFovgH9CUX+FCIlau9+ushBG5XwZh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdCiLG1rfaPeIQ1zNhutmqRlwd9PGHZHGzl1bzbFV8nhO9sMK6jvLecXdBTRvof4MauH6HhyJYtRKkxSW/ku2b9xeimzGCU4l0B2C0I3esFygk7FoA8XZ/z+162KiZdkmTVM4qy++ADeNNoPn/amtI4gHKZqnbN6ehjM5KRliZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z3rq7CG5; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z3rq7CG5"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5dad00b2e6so1940665276.3
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2025 08:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740759378; x=1741364178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiOZxsL0zt3JSsFovgH9CUX+FCIlau9+ushBG5XwZh4=;
        b=Z3rq7CG5MNZcPQTJETfCeRGYgTi8rF7UwLerMfqDl8hXAWk5J3jgW0dJedaNcdU2CJ
         wBTBlfQsJWk1slIYBPdIq0yljYcxfi9ZfZ/yfMthv1timVKP36/U0En0qv3UaNeL6P+D
         +jRQeNveBEhSOLql0imUHQSBqzdLSkd1EZXF3NKqOJ756C+9IlR6YZ7scbwYqeOK9ct8
         PwKDezjtsX4PwWjeikcItB8DIwhq9fVMbP/BbxW0E2BUaD50EAX2ZWVIdAxC8sJKHVCB
         2Nb9vsVbMcNRtzDQUcDBQqSFKYZHuEwd4N/Peu0qOuDf55unT/LvOXKbnGaFKfjqeP14
         A1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759378; x=1741364178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiOZxsL0zt3JSsFovgH9CUX+FCIlau9+ushBG5XwZh4=;
        b=JiL5QoXWZqoKtHT/+B1tvVVC6/B4Z86Z5UKyXm7C2l5W1+DWhhak2tpIVJ/nXqBMn1
         MuWN8TRX25GZfTg5FManKXfOXELkec+USD0F+6ld7G6KFTEklfxEYzUqxf42DmAUWjxX
         /B/Fvd91zKmb5A3VA0ME5c1ek3rT5d0f+EO+oOKbbcjz9QJI0yiPCV0W+IN3oeobg3Uw
         BSImFRYtssAvZhXmwCnvPr7DTieeJttCQto0YLMuZIA8aEDqnlHQ7kpzfJxbaSm9GX85
         xLQmfvbJ4nqc+pKufuwPJKkNOGPFCHxkiB7oMXP2JAbCBDKbwqQ0zbNHeJ1glk6PakY0
         X3GQ==
X-Gm-Message-State: AOJu0Yz4CEZfsH4tRlZ+PXNdSmTth0uJpXBr2UXyz9bOIImYw0UDcPiu
	sLOIqQirLXlq9WDLWDPr++AdeluJ7h0ZRlVqlBggUWRvvDpDH4mZtYe6GEtrSULBHfMNaB81M0E
	SHu4ahDws0uH0N3hh8I4j4T7gZU1GDrl6wtv/
X-Gm-Gg: ASbGncvQQo8vlqnIaiNtsFqVirX6znYa9vK9/hgnDYQI4AePbOIVL/NFFyHxO790zB5
	EaPJ+LRgRd5wWY5fA1Nf0hd7ll5o1fCaiyWoUcSFLMEh5W2Yt8sIZv4D1ZKOBd5vPuUP97f7T5i
	PtpIvsEos=
X-Google-Smtp-Source: AGHT+IHIIXE31TWwluV6uTKc11o5VBBP6c8Zn+4SX3Eb2bB5Eyz/E1EpqyMolXdzXz4r6C/D4CLAOJYcu8raeRuxKNc=
X-Received: by 2002:a05:6902:33c8:b0:e60:9fd4:bdba with SMTP id
 3f1490d57ef6-e60b2e889a9mr4615374276.5.1740759377695; Fri, 28 Feb 2025
 08:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87plj2dyad.fsf@redhat.com>
In-Reply-To: <87plj2dyad.fsf@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Feb 2025 11:16:08 -0500
X-Gm-Features: AQ5f1Jq4-rC8qYs6YVs8V4ecnBZSckBCpXBpIKAVhyzHik3h34jQN4-ErXm8k-M
Message-ID: <CAHC9VhRO=ctYrN-SDC9xGQ3Mg24xJ2T46x9Vj0OJz1+TeULXGQ@mail.gmail.com>
Subject: Re: Userspace: 3.8.1 release next week?
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 7:55=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Hi,
>
> there's a performance regression between 3.8-rc4 and 3.8. A fix already
> available [1] and acked so if there's no objection I'll merge it on
> Monday.
>
> Also I would like to release 3.8.1 version as a minor release just with
> this patch to improve the performance of operations on semanage store.
> Again, if there's no objection, I'll do it on Wednesday next week.

I think that's a great idea, thanks Petr.

--=20
paul-moore.com
