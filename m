Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B562216E24
	for <selinux@vger.kernel.org>; Fri,  6 Jun 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240816; cv=none; b=j2+LQ5ix8QsSA+yS8hb78p7xSK5H4d6NkGC4a23X6uyxsIX6RZ6UiZ7iixvHz32edHx9ARinK/NBjapmYy9OYnih4c03SHq633+qRNXIFBegaNRnyChAwMqzqwx0NZAU4seYaEJ2qDjxooOcmSc+SgU6Vi6FKdZ9689Ywy3Jm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240816; c=relaxed/simple;
	bh=okprkF+Ur51kysKutyKEfwtJqG4bghjbjWxibnKrkg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o12uJCdaFQ2bxbyTy2GRqhPR9B76mLVeDV3EZfodOsPoZwALrm3UiXVMdX/jr5tj4mEBsrr8HZAMUIsgSxrvgqSS+U1m6iysZtqA354pQPVdpcoNQFUZzM0nAV/sBOmnVi1MGlHFOPn3RxEDBiyE3PUW/8Bux3x2twt/Dai5pB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=id0buRWD; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="id0buRWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1749240584;
	bh=okprkF+Ur51kysKutyKEfwtJqG4bghjbjWxibnKrkg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=id0buRWDaFh8nhoxcRsjIj4qYHhNHTCatw78WzcXTLUpTVcNb4PneAb7adKcjxFdr
	 F+drseX9Mx1bjfWJGHrRLqMb3UykElockYUWD0l/fFoYQ9TjWfIf5pfnsBVeIUzbkm
	 4g99RKpTYpGcWRSABPbjkskgRThICtgx2XTutWEg=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id DC8391A0DE2;
	Fri, 06 Jun 2025 22:09:44 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Subject: Re: selinux userspace wiki
In-Reply-To: <CAEjxPJ5PHAU-_ru9=zN_iuvLGEGDxL_T50-fW4XecnZ6p2ww8A@mail.gmail.com>
	(Stephen Smalley's message of "Fri, 6 Jun 2025 15:39:21 -0400")
References: <CAEjxPJ6P6oH4nUMwhFs=ctDekm3CHVtGgp+gx0QCjxZz5d4TCA@mail.gmail.com>
	<CAEjxPJ7RbPCdJsO=CeRSisa+1=eLNOSkVWByGb2sdF1VUCLCCw@mail.gmail.com>
	<CAEjxPJ5PHAU-_ru9=zN_iuvLGEGDxL_T50-fW4XecnZ6p2ww8A@mail.gmail.com>
Date: Fri, 06 Jun 2025 22:09:44 +0200
Message-ID: <87zfeky6lz.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Thu, Jun 5, 2025 at 3:05=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> On Thu, Jun 5, 2025 at 3:03=E2=80=AFPM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>> >
>> > Since I created a Getting Started guide under the selinux-kernel wiki
>> > [1], I also did some refreshing of the selinux userspace wiki [2],
>> > moved the Presentations and Papers sections from the kernel wiki to
>> > the latter, and cross-linked them for easy discovery. However, I had a
>> > few questions about the selinux userspace wiki:
>> >
>> > 1. The Home page and the Userspace Packages page are at least partly
>> > redundant in their content, and the actual list of userspace packages
>> > modified for SELinux was very out of date (I added a note to that
>> > effect and how to query for a more current/accurate set). Should we
>> > drop one or the other or somehow combine them?
>> >
>> > 2. The Tools page is likewise quite out of date. Do we want to refresh
>> > it (and if so, does anyone want to do so), or drop it?
>>
>> Sorry, forgot to include the links:
>>
>> [1] https://github.com/selinuxproject/selinux-kernel/wiki
>> [2] https://github.com/SELinuxProject/selinux/wiki
>
> I refreshed the Tools page, deleted the custom sidebar that was
> (presumably unintentionally) hiding several child pages, and moved the
> Other Resources section to its own sub-page,
> https://github.com/SELinuxProject/selinux/wiki/Other-Resources
> and made further additions to the Presentations and Papers sub-page,
> https://github.com/SELinuxProject/selinux/wiki/Presentations-and-Papers
>
> Feel free to suggest others that should be added or if you are a
> maintainer, to add them yourself.
>
> Another question about the old content: the Contributing page lists an
> IRC channel. Is it still correct and used by maintainers? If not,
> should remove or update appropriately.
>

Yes #selinux on libera.chat is still correct and used by maintainers.

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
