Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F91CF7AF
	for <selinux@vger.kernel.org>; Sat,  7 Jun 2025 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749280115; cv=none; b=EgDgTe1a+KueO7o3hzWVlDtmDOcKCRxdA1OyenGNo2mn0ePJXJzvWmKBAfLdCeJVNCxLOFYv8dWTZIjjBSM+eVn7Jrj2nl1pUqnS1da9fQhWYMhKhvWgEw13o01V05MtjcXDX8uu+rCs+ULAtu15CrG/Whewly/Y/maWm4vLGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749280115; c=relaxed/simple;
	bh=jtLdnWny8T44XQ5dnVM+067P3nIllY2Lj/sHo5c9PbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UZW0NwnfClIE+duzbStEmm4NAdbf76ji0VU+EtrrlpTdKr2BfWDXMulj+Y1Pul3K9yVW97T/04GYSJS56U94LSc8TGvKu8nbOLlQumUVDrnrWhfbg2fCMI1fH2R0r9eeaGoZf26sXJfMtK4EtXR7vgTeKOsH70DJPNNWNPhECWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=bV7n817T; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="bV7n817T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1749280111;
	bh=jtLdnWny8T44XQ5dnVM+067P3nIllY2Lj/sHo5c9PbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bV7n817TkKq1ygrVDliZ9calwtoMXjzaeBB6NxsUks+z6ELvjkgOeIrQ9lhT2lUQq
	 +RszvUuAPx4mCYS4IOPxz6ip0tl5LBryCwddAo7/9JrMGV/qLiqw7S4Lu751c41j3+
	 mIHd9KD9ApJ1z73xZ5PVRLaxrdCE+KxLj0JOUcj0=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id D515D1A0E03;
	Sat, 07 Jun 2025 09:08:31 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,  SElinux list
 <selinux@vger.kernel.org>
Subject: Re: selinux userspace wiki
In-Reply-To: <CAHC9VhT-e8=TrjVcMYW8um_DrA1V1u6m+qrH1JCQ_3fxJY__Ww@mail.gmail.com>
	(Paul Moore's message of "Fri, 6 Jun 2025 22:13:32 -0400")
References: <CAEjxPJ6P6oH4nUMwhFs=ctDekm3CHVtGgp+gx0QCjxZz5d4TCA@mail.gmail.com>
	<CAEjxPJ7RbPCdJsO=CeRSisa+1=eLNOSkVWByGb2sdF1VUCLCCw@mail.gmail.com>
	<CAEjxPJ5PHAU-_ru9=zN_iuvLGEGDxL_T50-fW4XecnZ6p2ww8A@mail.gmail.com>
	<87zfeky6lz.fsf@defensec.nl>
	<CAHC9VhT-e8=TrjVcMYW8um_DrA1V1u6m+qrH1JCQ_3fxJY__Ww@mail.gmail.com>
Date: Sat, 07 Jun 2025 09:08:31 +0200
Message-ID: <87v7p8xc40.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Moore <paul@paul-moore.com> writes:

> On Fri, Jun 6, 2025 at 4:13=E2=80=AFPM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>
>> > On Thu, Jun 5, 2025 at 3:05=E2=80=AFPM Stephen Smalley
>> > <stephen.smalley.work@gmail.com> wrote:
>> >>
>> >> On Thu, Jun 5, 2025 at 3:03=E2=80=AFPM Stephen Smalley
>> >> <stephen.smalley.work@gmail.com> wrote:
>> >> >
>> >> > Since I created a Getting Started guide under the selinux-kernel wi=
ki
>> >> > [1], I also did some refreshing of the selinux userspace wiki [2],
>> >> > moved the Presentations and Papers sections from the kernel wiki to
>> >> > the latter, and cross-linked them for easy discovery. However, I ha=
d a
>> >> > few questions about the selinux userspace wiki:
>> >> >
>> >> > 1. The Home page and the Userspace Packages page are at least partly
>> >> > redundant in their content, and the actual list of userspace packag=
es
>> >> > modified for SELinux was very out of date (I added a note to that
>> >> > effect and how to query for a more current/accurate set). Should we
>> >> > drop one or the other or somehow combine them?
>> >> >
>> >> > 2. The Tools page is likewise quite out of date. Do we want to refr=
esh
>> >> > it (and if so, does anyone want to do so), or drop it?
>> >>
>> >> Sorry, forgot to include the links:
>> >>
>> >> [1] https://github.com/selinuxproject/selinux-kernel/wiki
>> >> [2] https://github.com/SELinuxProject/selinux/wiki
>> >
>> > I refreshed the Tools page, deleted the custom sidebar that was
>> > (presumably unintentionally) hiding several child pages, and moved the
>> > Other Resources section to its own sub-page,
>> > https://github.com/SELinuxProject/selinux/wiki/Other-Resources
>> > and made further additions to the Presentations and Papers sub-page,
>> > https://github.com/SELinuxProject/selinux/wiki/Presentations-and-Papers
>> >
>> > Feel free to suggest others that should be added or if you are a
>> > maintainer, to add them yourself.
>> >
>> > Another question about the old content: the Contributing page lists an
>> > IRC channel. Is it still correct and used by maintainers? If not,
>> > should remove or update appropriately.
>> >
>>
>> Yes #selinux on libera.chat is still correct and used by maintainers.
>
> ... and I'll add that Dominick has been doing a tremendous job, over
> many years, providing help and support over the IRC channel too!

Thanks for that acknowledgement. I enjoy talking about this matter and
IRC too because its easy to hop onto a channel and start the conversation.

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
