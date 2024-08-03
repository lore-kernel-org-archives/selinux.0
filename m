Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0974BE1
	for <selinux@vger.kernel.org>; Sat,  3 Aug 2024 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722683060; cv=none; b=jUvqlenVCjh+mEEBiMqsXk2X1e6RYHtUhDJtBDo9aZUxUu6wGqPrEpM/4OqtfhFUbRZYWIdH2QCavT/SviN3FcZpMkNEi4fEePhJ+DGvZyfPP6f/UF++z0zXUbuvuM4wMq4SY0vKYuS02C4iFRg4bwKsvYH9VOCDCpMAo67Qf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722683060; c=relaxed/simple;
	bh=sDqmHpVlRVWwLShEysx1EowKmNYcIz3EOY/NU2afFz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u/y3v1eQebz32PtXOxhg3NtkprFjxstxlh3fsQmJ+BTNO6NMsDqGlWM92CmH/a43elCq/yelD/pjSOmPZdve0YP/vc8aqRu/fanASSaxBlJJkkPBQnukyDzyNu/moO/MX3kMfDFDI4HIDgqOEou9rzfVOSSdpSF4YgvbGnpc9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=QZfXTTDP; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="QZfXTTDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1722683049;
	bh=sDqmHpVlRVWwLShEysx1EowKmNYcIz3EOY/NU2afFz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QZfXTTDP/iVo5Oxmvdlbx1IaM23kgHvpc55AjKf7dMdymJ38QssQdGOlPph3gsO+2
	 ur3yO7v4lrMzhfnET1dh68oCOCTsGqLDZIlmXntjYt7GbSo6JohQ3GlvvlfKBCcMMV
	 Sn9L5B+xpKmZbHUb9H4oOg/IfxCwF/X26Gdm4jFQ=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id D6D2C8489D;
	Sat, 03 Aug 2024 13:04:09 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: monolithic policy on a volatile root
In-Reply-To: <CAEjxPJ4HRoGVc62mA9yP4gPEi6vnhUEz6Ge2K8L+E_G5W9r68w@mail.gmail.com>
	(Stephen Smalley's message of "Fri, 2 Aug 2024 09:05:35 -0400")
References: <87y15fe3iy.fsf@defensec.nl>
	<CAEjxPJ63KtgNc-FVBwkRJup5Qh022An21n=TsCsLP9L1bYyfoQ@mail.gmail.com>
	<CAEjxPJ4HRoGVc62mA9yP4gPEi6vnhUEz6Ge2K8L+E_G5W9r68w@mail.gmail.com>
Date: Sat, 03 Aug 2024 13:04:09 +0200
Message-ID: <87plqpeul2.fsf@defensec.nl>
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

I misread. I also think the I might be overlooking use-case but the main
point I would like to make is that with a volatile root / is empty
except that there is a readonly /usr mounted. With that said I don't see
how using /var would be an solution.

systemd-tmpfiles and systemd-sysusers run very early to populate the
filesystem from /usr/share/factory and to create users. Both of them
rely on a working libselinux. Hence the chicken and egg.

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
