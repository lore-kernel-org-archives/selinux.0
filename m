Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC51E3CB9
	for <selinux@vger.kernel.org>; Fri,  2 Aug 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605001; cv=none; b=IAevDJaxOGgtqZPG5xuWi9RDAXYz3BRmm84enKmvJBs9jH+d25Xr3wEA1a+NsDEM6Lz6qxAdzDNtNlmdWGHERzI+8YiccgnijXrqaL/4yaNML+KXbJLn0bMgnXgv0BziVS8VML1tUyOGCdbNsFhMpycfxWaLm0zvQPm7IDByuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605001; c=relaxed/simple;
	bh=BG6oz+wK40f6D8pjnL8H20gJ7AKKys8Z1cCXxDQAMI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gktrE2czzNCjk01DHYsPvVq1niToJsSHVfmrn3N3b1mzXoUe8BFDyJKQnbgJFkaEQYoSkXTadjjtSy4KkrzKHERJ4SdicFiBwQEdfxfdfYIs7fq2tPNNeqNPJotvWvM2g2TyOBqAQYWL1uIOEc0+ZG5ySKX3NN8Fh57oxDWhzGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=i2DtEkQs; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="i2DtEkQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1722604997;
	bh=BG6oz+wK40f6D8pjnL8H20gJ7AKKys8Z1cCXxDQAMI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i2DtEkQsdCkj+E/gyUsM9sPqwpyuqUYel57WgR/q4V2mxvjVPZii+SG0w6mgOCcjl
	 +/8S32nkJ/WlSV+Pm8mqT7ePiH0LDXP7QNJtd1r9lziPP7VtP6c8a/mDU/3rjrmKIi
	 QpIVJDk28qP0WRGNJGCOWHvprwn4Gi8RNlLRBv0c=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 5BD1484830;
	Fri, 02 Aug 2024 15:23:17 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: monolithic policy on a volatile root
In-Reply-To: <CAEjxPJ4HRoGVc62mA9yP4gPEi6vnhUEz6Ge2K8L+E_G5W9r68w@mail.gmail.com>
	(Stephen Smalley's message of "Fri, 2 Aug 2024 09:05:35 -0400")
References: <87y15fe3iy.fsf@defensec.nl>
	<CAEjxPJ63KtgNc-FVBwkRJup5Qh022An21n=TsCsLP9L1bYyfoQ@mail.gmail.com>
	<CAEjxPJ4HRoGVc62mA9yP4gPEi6vnhUEz6Ge2K8L+E_G5W9r68w@mail.gmail.com>
Date: Fri, 02 Aug 2024 15:23:17 +0200
Message-ID: <87ttg3dpoa.fsf@defensec.nl>
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

> On Fri, Aug 2, 2024 at 7:45=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> On Fri, Aug 2, 2024 at 4:27=E2=80=AFAM Dominick Grift
>> <dominick.grift@defensec.nl> wrote:
>> >
>> >
>> > I think this question was already asked but I could not find the
>> > discussion.
>> >
>> > What would be the challenges to support a monolitic policy on a volati=
le
>> > root?
>> >
>> > In a volatile root scenario there is only a non-volatile readonly
>> > /usr. Would it be possible to teach libselinux that if there is a
>> > /usr/selinux and not a /etc/selinux and/or /var/lib/selinux that it wo=
uld
>> > use that instead?
>> >
>> > The challenge I am currently facing with systemd.volatile=3Dyes is that
>> > when the policy is loaded from initramfs that systemd-tmpfiles (and
>> > systemd-sysusers) cannot properly populate root from /usr/share/factory
>> > (or created) because they rely on libselinux,get/setfilecon and thus on
>> > /etc/selinux/contexts/files. There is a slight chicken and egg situati=
on there.
>> >
>> > Often times its not a probable because one can do with automatic type
>> > transitions but some of these files get created atomically (/etc/passwd
>> > and /etc/shadow for example) and not to mention that these libselinux
>> > linked components might get confused and noisy if selinux is enabled a=
nd
>> > enforcing but there is no /etc/selinux.
>> >
>> > Duplicating policy in initramfs and /etc, /var/lib would invite
>> > inconsistencies and is not feasible but if the policy is readonly and
>> > thus monolitic then this might be feasible if it is not too
>> > ugly. Actually in such a scenario we would probably not need a policy =
in
>> > initramfs at all since systemd would just load it from /usr instead of=
 /etc.
>>
>> I've seen a similar concern raised previously even for modular/managed p=
olicy.
>> It's all just software so I don't think it would be hard to modify
>> libselinux to fall back to /usr/selinux if there is no file in
>> /etc/selinux; it just requires someone to write a patch for it. May
>> have policy implications (i.e. anything that currently accesses
>> /etc/selinux now also may need search access to usr_t) but that's
>> pretty common anyway.
>
> To clarify, for monolithic policy, you just need to update libselinux
> to fall back to searching /usr if /etc lacks the file.
> For modular/managed policy we would also need to update libsemanage to
> write the final policy files somewhere, although /var seems more
> appropriate than /usr for that?
>

Yes I think the module store could be copied from /usr/share/factory to
/var/lib by systemd-tmpfiles if applicable and it should not cause
issues but the overal idea of using a mutable policy on a volatile root
seems counterintuitive. For a readonly monolithic policy it is probably
robust and simple.

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
