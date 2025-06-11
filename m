Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616129AB0E
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669935; cv=none; b=pJMeEe4Kw7ePG3wFL+8QKh/BQo5wnvRcJzsnaO/VTkGSnu5iv/cmilWs+Gdj7lQBzawJTutGsHB8tAF2LW2plILCsApfXTrYv5tkYdrSkzveb7ddRs0tNm6Slmq0AVtsp4XTZ1UIapUYQRqy6KyZWZq7Dil+02GHVd8ZSjs1bJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669935; c=relaxed/simple;
	bh=tr9mASpupy5yy8mi5W6xiQKk9ZWBooM46imd7IaeIpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYLJ6cY8bEZ6W7wfBmAFtGCUUOrwEIy/z0P/DxR0aeAuh+S8c0C9+KWxgi6B66ubR/tv3/IaakMVcVH+GEb/0ZBL5Jg9A75d0e9DKjhP/+e4/3VP4v6mwzKPy6ZtTkM1reyd09jM33LMTXe5IPWX707DZKYEsxljJTOBSOuFczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvVZUNrf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvVZUNrf"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3134c67a173so311720a91.1
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749669934; x=1750274734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo4b/dvJCSpI4R9RNyhVB2E3cabiE3nb/TAsA7GII0U=;
        b=NvVZUNrfSYZSnI6wVI2zukBHYJA/z3nuJS/wqmnohojStK7xnnXbOUrrCp4i7Rq+sW
         yj1NW9ARwmBSttKbfBrCpgnQ3cB5qJzDlEt13LyAQg8HCc1sKrOthEXAVta8gV9nSLZH
         SKd/b2tsR0vRFXp8JDuhSq9Us+wxe/i+ZnfPYyE8kDbTFwkVjJTw9JDRHvAzxu93cJ1L
         8JCrA050B39/oPgD+m8oRimRnpHcgyZeMq2U+vWsUE21zV6j3U+dI3WUvsFysWHZPm14
         Hbe7f1r7hGvAkEEaRqE+3KO5bRDXcwALWAM6uq5chj5IAwBZwugl9gh6DPEmYmTBBrBO
         IxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749669934; x=1750274734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo4b/dvJCSpI4R9RNyhVB2E3cabiE3nb/TAsA7GII0U=;
        b=fAMgpWn0uEgIT4K8Vs/CKAYmN/Tpl9i+9Q0Kr8Zfzl9HsPBlG8T+PM0ekC8KU3/jIb
         qINdIEx76DT46xn3v4+CuI5QJdQbwOGXC/tjmodSFCInC+GnreXjf0JFccOsvSX9QNRK
         0tIBHdH0EVAOkXOqp4sieeA9nIgfAITR1GGvTO9N/eqvz3P8FOqTvYZWF1SlYyvpN4oh
         QITXoWz85Jk8JVkHUgTz+PFGHYyIt9xLVkCLfL/7hembVA2HPS+8XVyXkYVizQM/VZWq
         K/118z+JbKWLeSl4tYZjF2631rWPRro7zKC5pyDad5D8vfnVW5lb/lEdPr5CX2gqE23e
         UqDA==
X-Gm-Message-State: AOJu0Yw0e5QFLVK77c18UXSRkNNzDIGjO7oPhPKhZdjz7bCLtzpS27hS
	uFZGDRrc6w68n2GOIcxyo7aJXkdz0VX4hM58FDJGFPzWwi0fd3QFggdHzrHu5GEkaCVLDIC+Pcp
	rzjF4eoVjtu3Zmt8vpvipLouDHJ61ZMk=
X-Gm-Gg: ASbGnctjPf4E9z0bcgQwRsvVO8W79lCecRO2zPbv5YUCOgiZVYVJ69VaB95rhCnLrtq
	a94p0dEFbmar1y6Kn0mKKLK85jdPqEL99FC0O+UPUXCzCp9qXtYSrK9vMVSC5Z55z6mWAlEoNiB
	vRUxAMTMlGkzee4Pp8H3HdEeeo5vU4qnSHzPmHJRrPYJI=
X-Google-Smtp-Source: AGHT+IHzEdSrBJDRiLp27vEI4qI7zdhQv7y7l253DG9XZFKV51F649v5KFpGBr1xNLQHhTe8Iz0HGLwPD8m50U8cFJk=
X-Received: by 2002:a17:90b:1e4b:b0:312:ea46:3e66 with SMTP id
 98e67ed59e1d1-313bfbf52d4mr819813a91.21.1749669933669; Wed, 11 Jun 2025
 12:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com> <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com>
In-Reply-To: <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 11 Jun 2025 15:25:21 -0400
X-Gm-Features: AX0GCFv1gamWmo_kniEGbEzBe-RPTeZJLVb1vaB31yiWAUHaGynnweLDjy43Sls
Message-ID: <CAEjxPJ7JAJ2aypxVyjw4KKAvGBvUVK6eCzbXF3Wd8huTSPiSFw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jun 11, 2025 at 2:34=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On F42, iptables and ip6tables are no longer provided; check
> > to see if iptables-legacy and ip6tables-legacy exist and use
> > those instead if so.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  tests/inet_socket/iptables-flush | 20 +++++++++---
> >  tests/inet_socket/iptables-load  | 52 ++++++++++++++++++++------------
> >  2 files changed, 48 insertions(+), 24 deletions(-)
>
> It's been a while since I hit, and worked around, this on my Rawhide
> systems, but if I recall correctly, fixing the problem was a matter of
> installing the iptables-legacy package and perhaps ensuring that the
> "alternatives" config was set to point to the iptables-nft
> implementation:
>
>   %  rpm -q iptables-legacy
>   iptables-legacy-1.8.11-10.fc43.x86_64
>   % alternatives --display iptables
>   iptables - status is auto.
>   link currently points to /usr/bin/iptables-nft
>   ...
>
> FWIW, I think there is value in testing with the iptables-nft
> implementation simply so we can test the new code paths.

Ok, I had iptables-legacy but not alternatives set. We might want to
note this in the README.md file.
