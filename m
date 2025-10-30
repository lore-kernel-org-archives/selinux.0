Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3C2EC088
	for <selinux@vger.kernel.org>; Thu, 30 Oct 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829077; cv=none; b=KiACv+67XhShRkR39s6skxRYuoHuBI239/g5YgJ9UqsH0djfHXu0buNBkjJ+YhagJlqIO5wM1gDlpee1mfsLd0H6iwGG6DfIQ60HuQBbE2zhy8wwVESksM9TLgJ8Hp2nWoR/kxrGn5ZGNDV8/oQDsmfU9iWaS1UVZryocubWKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829077; c=relaxed/simple;
	bh=Tg2/NxJFlmj8LxauxvsguXroZjCgrnDDnpp3o8n5OOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUFL2Oqq/HJTflY2wKvVA5jN6hyv2w8XsEIdHlx6vb4MARm1x5/xgRdKo6EoAsmGlRiaEpAMuzk/2bYQev2SG6a2vCAmJCpxV9Spfh32SCoTTByKjm9myGOQJ+Fz43CBbjxbOSs9rYzVJz7NrIrUOQ97Nnm4e1odj/H1AB4hGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGFFuWd8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGFFuWd8"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so787604a91.2
        for <selinux@vger.kernel.org>; Thu, 30 Oct 2025 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761829076; x=1762433876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1e5uJgNMXJB0Pqy7lR9NUxOr//WCl8mh1HEsKR93cY=;
        b=AGFFuWd83Sw9/zGJCMNKSvYEGrYj2+uXrD0YEpLAi7qmxF5I7L2zgDYNO3MNItp/GF
         WlA2Xq3ECL6uCcRGgRYepG7u02sNP3hwbo4Qcz7W0mkm3Z1hdwlKsMW8h0PAvvpqd3+5
         Z6qGVdZNSwfd/pXqQLfPyQgIKCLzYHsRn7F+yLmQZM4Ae4lQMuXgnbMWWX0LoN8I/dT/
         iZWyODvj+nfszypp49OkdgX1f1WvdY9n7TgM+GW2rdAikiy1Eu/qL0NMd/LGkbnJzSB2
         /HdFwEm6QGlMoMrFcyvGYPgI4im2KGKvlQyz2GOk23zqLkeSgQZKiGHR05v/4JhK2AG7
         t1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829076; x=1762433876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1e5uJgNMXJB0Pqy7lR9NUxOr//WCl8mh1HEsKR93cY=;
        b=kPcYkMHr3lsBs+gKpTLjQV2Nrc54GaO8CFVYYCXIMIFtjT9EGsPgYfJPlqCwfLaa5h
         FeF9KcBTGT8QNdHtp4S1jmfYsmlh55fQyrzQrnTOXlEL75RbpOhc5fWoHt7UhymlFxLM
         xq2WOyWuYKt5yKe5EyG455rPv7lLRwfXUdkgsU6ort9w/rtLmt26okncIbeSQXJ7l/h+
         uVmzLP4NtQPF/JrPGArI6MZQBBS21x19lGKZ/i3gQCywEgSH2zQSH8zyuHVNWAD3y5sn
         dzs4/UwfJeQfl4tybg/6AGvVRroEmIMrYe3JjPWkaWnqTJ3gKCGVkcmfb9ThJ3EuquVW
         SoJw==
X-Gm-Message-State: AOJu0YyuKNiGXdREQvF1C6ITZZyyDgsmFHCCaEyXiL4zD2L4aqzAWV+1
	HrYWR5FueUA1BaxnhNTO95UtqGPRHEuXdREwGoagnAkaFvF3PkfBzXW82bNIC6/MhbBIS8SDf2g
	pLFMUg5M6VFrpUrrLVMQKRrwrFVO6afo=
X-Gm-Gg: ASbGnct5DbnZydgFB5k141uFTQobPObM0it/TOY5kKlL5DcuEnPq+aLHvFj03fdVXwj
	UNDVTUlkbfeUfLLoW9QQ9v3r3XYafJ+3JHmvpfcfwSn8p3XZVKVadRRg/BAwB9hsPHDWnpGKTLU
	5p/A01AEh3sSj74xiXfjSZCvgBevmVbZvN4MT1OJ1af9KHXjxTL/OmO/R1hceRUkDMjhQQ3S/uH
	+TdO0FqIAJL2sbaDDm9TfsNuwxw92jwWYk/oRhj+XEBCHWZH0c1FsCNLYvJ3G3SB1jUv40=
X-Google-Smtp-Source: AGHT+IHDcQVR5QPcnNuRjkH1blE0Atx1AZto+DEzy2NLl0d+t0H0Y8ob8IR65oXOcZOI9Wvnt/GnMgvOR0XlFgf9aEw=
X-Received: by 2002:a17:90b:3c10:b0:340:631f:daf with SMTP id
 98e67ed59e1d1-340631f0ed0mr2206507a91.24.1761829075636; Thu, 30 Oct 2025
 05:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9bf87e7a-17e7-4c74-bafd-885752dfe045@linux.microsoft.com>
In-Reply-To: <9bf87e7a-17e7-4c74-bafd-885752dfe045@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Oct 2025 08:57:44 -0400
X-Gm-Features: AWmQ_bmjqvMqA7p--SUUC5iS8LVmVt-f2CKHIDIn_vzS4OCtUnNf2hdWq_dZx9w
Message-ID: <CAEjxPJ5SX-9OyMPQF9B9wr4ixdaG9jxSmG5R7Ozev+KVztWoWg@mail.gmail.com>
Subject: Re: SELinux documentation repo licensing
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 5:19=E2=80=AFPM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> Paul created a new repository for an SELinux project github pages:
> https://github.com/SELinuxProject/documentation
>
> There's been a little discussion in the github issues about licensing
> for the repo: https://github.com/SELinuxProject/documentation/issues/1
>
> Matching the Notebook license (GNU FDL) is one option, but I personally
> prefer the CC-BY license terms.  My thoughts are in the issue and
> reproduced below, but I wanted to highlight this on the list to see what
> other thoughts there were.
>
> My github issues comment:
>
> The SELinux Notebook currently makes use of the GNU FDL:
> https://github.com/SELinuxProject/selinux-notebook/blob/main/LICENSE
>
> It's a rather lengthy copyleft license. I personally find some of the
> specific criticisms mentioned on wikipedia fairly compelling. Notably,
> the GNU FDL requires any modifications to be distributed under the same
> license. This seems stronger than the GPLv2 requirement that you merely
> release your own modifications under a compatible open source license. A
> consequence of this requirement is that it seems to me as though we
> cannot borrow language from the Notebook into other documentation (e.g.
> comments in source, or this repo) unless that documentation is under the
> GNU FDL.
>
> Based on that concern, my personal preference would be to use something
> a bit more permissive (although that means both separate license
> standards for different SELinuxProject repos, and that the Notebook and
> this repo would not be compatible with each other).
>
> Other open source documentation licenses we could choose from include
> the FreeBSD documentation license although the language there contains
> some FreeBSD specifics that make me hesitant to repurpose it elsewhere.
> Wikipedia mentions a "BSD documentation license" which strips out the
> FreeBSD specific parts but calls it "obscure". I can't find mentions of
> it outside of wikipedia and the one of its two citations that isn't a
> dead link.
>
> Finally, Creative Commons seems like a fairly standard option. However,
> we have decisions to make, since we can specify different CC variants.
> Something like CC-BY gets us a more permissive MIT/BSD style license,
> CC-BY-SA would be similar to the GNU FDL (but of course mutually
> incompatible).
>
> My initial preference personally is for the CC-BY, but I'm happy with
> whatever license the community chooses.

I am fine with CC-BY.
