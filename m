Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A5182B4
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633518; cv=none; b=VAQ6z8Z9zR+1rgy/Bcgp2mgeIE4RHJWAFd7m1Y3haFr0ffP3pOsNlxO4hHmjoLLbZHlblvlg2ZI2aECzxoL+Kp5qUNwvPAAuflUihn6/mBC76DHI+FFz3mOd1Kvt6mYPly2clMjeParANedNAyDOueTIvyPa+p0LDAkMFmpYQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633518; c=relaxed/simple;
	bh=yS3uKsC8QKC5473hH+EUg4Cooc040tf8JbzkNIjsYKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qOGCdfiNRJuLLkv/6lefv2TddL8XKc1I7ido0kG/OX8efkBu0Z1zDW11yq/NDkF/G8bkFzO/GwW3BnR+5edCtdrhopXQXYLbivzSz5S6wtzffzXs1fTbpFmv3KgyAVG1D+PxIHFUAPJqIl3bRNjrDVzpdU3u6qOYHerbCN5AWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=Aopt0j4f; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="Aopt0j4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1720633258;
	bh=yS3uKsC8QKC5473hH+EUg4Cooc040tf8JbzkNIjsYKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Aopt0j4fxHf/AZOtvuK5kqD2s5k5v0AUJeVMa8TEIhlNWm6QKI6jHXmkU7htp9Drp
	 cv2l3bi1UymWNc96oPPonv2mF/7iWehS9beUXaZ9y4oN1deSL6/UksjeRkceVLvsuV
	 HZjDKIwFhLovuTuGknGToyLrEJ9HiWKaLKt5ERrY=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id C740F6CE44;
	Wed, 10 Jul 2024 19:40:58 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>,  selinux@vger.kernel.org,  Paul
 Moore <paul@paul-moore.com>,  Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: In permissive setting labels that are not in host policy when
 running unprivileged fails with EINVAL
In-Reply-To: <CAEjxPJ45g8jh=0LtjWE14+ANXjOknnmyZUChu_D==z3M_5wZdQ@mail.gmail.com>
	(Stephen Smalley's message of "Wed, 10 Jul 2024 09:50:30 -0400")
References: <87v81d74pj.fsf@redhat.com>
	<CAEjxPJ45g8jh=0LtjWE14+ANXjOknnmyZUChu_D==z3M_5wZdQ@mail.gmail.com>
Date: Wed, 10 Jul 2024 19:40:58 +0200
Message-ID: <871q41jgb9.fsf@defensec.nl>
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

> On Wed, Jul 10, 2024 at 9:32=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> Hello,
>>
>> this is originally reported at
>> https://github.com/SELinuxProject/selinux/issues/437
>>
>> There a question why kernel blocks changing SELinux label to some
>> unknown label and requires CAP_MAC_ADMIN even in permissive mode?
>>
>> Reproducer:
>>
>> $ id -u
>> 1000
>>
>> $ getenforce
>> Permissive
>>
>> $ chcon -t bin_t /var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/system=
d/system-generators/systemd-ssh-generator
>>
>> $ chcon -t selinux_unknown_type_t /var/lib/mock/fedora-rawhide-x86_64/ro=
ot/usr/lib/systemd/system-generators/systemd-ssh-generator
>> chcon: failed to change context of
>> '/var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/systemd/system-generat=
ors/systemd-ssh-generator'
>> to =E2=80=98system_u:object_r:selinux_unknown_type_t:s0=E2=80=99: Invali=
d argument
>>
>>
>> Quotes from the issue:
>>
>> This is happening on a system with SELinux in permissive mode. Applying
>> your suggestion does not change the result. I assume this is gated
>> behind CAP_MAC_ADMIN for unprivileged users. Is there any way to make
>> this work without needing root privileges?
>>
>> Hmm so the kernel blocks unknown labels unless the user has
>> CAP_MAC_ADMIN in the initial user namespace. I'm assuming this is for a
>> good reason and it would be unsafe to allow any user to do this so I
>> don't think there's anything that can be done here
>>
>> One thing that's not clear to me, why is an unprivileged user allowed to
>> write labels known by the host but not labels that are not known to the
>> host? What specifically is unsafe about unknown labels that's not an
>> issue with known labels?
>
> With SELinux disabled, setting of security.* xattrs at all is gated by
> CAP_SYS_ADMIN.
> With SELinux enabled, the security.selinux xattrs can be set to valid
> security contexts without any capability if allowed by policy.
> Support for setting unknown security contexts was a later addition to
> SELinux for a specific use case (original motivation provided by Red
> Hat was to permit rpm to set contexts on files unpacked from a package
> before it inserted the corresponding policy module from %post), and
> was not expected to be used by unprivileged users.
> Smack had already introduced CAP_MAC_ADMIN at that point, and it
> seemed reasonable to use it for this purpose, since setting labels
> unknown to the policy is effectively like being the admin of the MAC
> policy.
> The policy can't make useful determinations about what to do with
> unknown labels so it can't provide any information flow guarantees.
> There may also have been a concern about the facility being abused to
> push arbitrary data into a security.selinux xattr to be fetched by
> some other privileged process later in a manner that would ultimately
> lead to a vulnerability.
> Not saying that we can't change things here, but would require a
> graceful and compatible transition path.
>

The use-case for this is livecd/usb creation. For example creating an
MLS livecd/usb on a non-MLS host.

I also hit this issue on policy-developement as I am also a user of the
mkosi tool that is referenced in the issue.

mkosi is a tool that can build a source and boot an image using that
source. If I add some module to my policy source tree and I want to test
that in a virtual machine then I would run mkosi on the source.

mkosi is not allowed to use the label that is unknown on the host on the
filesystem. So the file ends up unlabeled in the virtual machine. So
using mkosi for testing policy is not useful unless you run mkosi as
root. Which is fair to be honest. There is quite a bit of functionality
in mkosi that only works if you run it as root.



--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
