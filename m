Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3E15E88
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720640864; cv=none; b=T7psKkd6wdZO5r1fa5Q4+DC3ed9KNMk2+ZoGQPBZrPyIC8Krt31814hQYZ5MfxKufE54YjcUleqF5zvSmZLf0Lnfs5e+ZBsqG/OqaKjFFZJqWQ+rHsjRjonNeVtZIFxWfio62lscvW8Ygj1O2qO1UZcV4M0zCeCm6eidknFNCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720640864; c=relaxed/simple;
	bh=BiM9NfzCVqGfQ9/qKYi5pgCPSFIK5bOJWuO2urZgUzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UeORV/WNrhCk9tBnLz/NAWtb4I3K9CAT3LNVHIrPrEXpCnDgECvPpoEN47QseVASqjtrIHP3H70YL//44qC3RyUYaO/ven0m+a7m9IkJq2wBNGNZD+MQvoGiSp12MaxMGAeedj+XUA+s0XvJTncz+VQJ6QfffVv3rD3sBvtWFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=kW9FlLFA; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="kW9FlLFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1720640860;
	bh=BiM9NfzCVqGfQ9/qKYi5pgCPSFIK5bOJWuO2urZgUzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kW9FlLFARvD1emtvuA9GnVdIlKZhNcFJOBkUgkx1TVve/aounbYSDGBZQTj0wWPLH
	 7PHilAaT8zzlxlHpYQUNOGtCgOi6TtnQhFlUWs37W+mKyTDeYg46JpO256K/ujEsCP
	 9OOAjx40cCuK3BOGAtgc+8OQwQM9KP21dRofKA0Y=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 184956CE5B;
	Wed, 10 Jul 2024 21:47:40 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>,  selinux@vger.kernel.org,  Paul
 Moore <paul@paul-moore.com>,  Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: In permissive setting labels that are not in host policy when
 running unprivileged fails with EINVAL
In-Reply-To: <CAEjxPJ4mQjwsp1KydTEc+Ot7=eFHnwUUmk2t2mSnXTHS0Vt0Vw@mail.gmail.com>
	(Stephen Smalley's message of "Wed, 10 Jul 2024 15:29:02 -0400")
References: <87v81d74pj.fsf@redhat.com>
	<CAEjxPJ45g8jh=0LtjWE14+ANXjOknnmyZUChu_D==z3M_5wZdQ@mail.gmail.com>
	<871q41jgb9.fsf@defensec.nl>
	<CAEjxPJ4mQjwsp1KydTEc+Ot7=eFHnwUUmk2t2mSnXTHS0Vt0Vw@mail.gmail.com>
Date: Wed, 10 Jul 2024 21:47:39 +0200
Message-ID: <87wmlthvvo.fsf@defensec.nl>
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

> On Wed, Jul 10, 2024 at 1:40=E2=80=AFPM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>
>> > On Wed, Jul 10, 2024 at 9:32=E2=80=AFAM Petr Lautrbach <lautrbach@redh=
at.com> wrote:
>> >>
>> >> Hello,
>> >>
>> >> this is originally reported at
>> >> https://github.com/SELinuxProject/selinux/issues/437
>> >>
>> >> There a question why kernel blocks changing SELinux label to some
>> >> unknown label and requires CAP_MAC_ADMIN even in permissive mode?
>> >>
>> >> Reproducer:
>> >>
>> >> $ id -u
>> >> 1000
>> >>
>> >> $ getenforce
>> >> Permissive
>> >>
>> >> $ chcon -t bin_t /var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/sys=
temd/system-generators/systemd-ssh-generator
>> >>
>> >> $ chcon -t selinux_unknown_type_t
>> >> /var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/systemd/system-gener=
ators/systemd-ssh-generator
>> >> chcon: failed to change context of
>> >> '/var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/systemd/system-gene=
rators/systemd-ssh-generator'
>> >> to =E2=80=98system_u:object_r:selinux_unknown_type_t:s0=E2=80=99: Inv=
alid argument
>> >>
>> >>
>> >> Quotes from the issue:
>> >>
>> >> This is happening on a system with SELinux in permissive mode. Applyi=
ng
>> >> your suggestion does not change the result. I assume this is gated
>> >> behind CAP_MAC_ADMIN for unprivileged users. Is there any way to make
>> >> this work without needing root privileges?
>> >>
>> >> Hmm so the kernel blocks unknown labels unless the user has
>> >> CAP_MAC_ADMIN in the initial user namespace. I'm assuming this is for=
 a
>> >> good reason and it would be unsafe to allow any user to do this so I
>> >> don't think there's anything that can be done here
>> >>
>> >> One thing that's not clear to me, why is an unprivileged user allowed=
 to
>> >> write labels known by the host but not labels that are not known to t=
he
>> >> host? What specifically is unsafe about unknown labels that's not an
>> >> issue with known labels?
>> >
>> > With SELinux disabled, setting of security.* xattrs at all is gated by
>> > CAP_SYS_ADMIN.
>> > With SELinux enabled, the security.selinux xattrs can be set to valid
>> > security contexts without any capability if allowed by policy.
>> > Support for setting unknown security contexts was a later addition to
>> > SELinux for a specific use case (original motivation provided by Red
>> > Hat was to permit rpm to set contexts on files unpacked from a package
>> > before it inserted the corresponding policy module from %post), and
>> > was not expected to be used by unprivileged users.
>> > Smack had already introduced CAP_MAC_ADMIN at that point, and it
>> > seemed reasonable to use it for this purpose, since setting labels
>> > unknown to the policy is effectively like being the admin of the MAC
>> > policy.
>> > The policy can't make useful determinations about what to do with
>> > unknown labels so it can't provide any information flow guarantees.
>> > There may also have been a concern about the facility being abused to
>> > push arbitrary data into a security.selinux xattr to be fetched by
>> > some other privileged process later in a manner that would ultimately
>> > lead to a vulnerability.
>> > Not saying that we can't change things here, but would require a
>> > graceful and compatible transition path.
>> >
>>
>> The use-case for this is livecd/usb creation. For example creating an
>> MLS livecd/usb on a non-MLS host.
>
> I'm fairly sure that people have been using the unknown label support
> for livecd creation successfully for quite some time. Have they just
> been doing it with CAP_MAC_ADMIN enabled or otherwise as root?

AFAIK (and from experience) yes, CAP_MAC_ADMIN and root. Theres also
setfiles_mac_t for this.

>
>> I also hit this issue on policy-developement as I am also a user of the
>> mkosi tool that is referenced in the issue.
>>
>> mkosi is a tool that can build a source and boot an image using that
>> source. If I add some module to my policy source tree and I want to test
>> that in a virtual machine then I would run mkosi on the source.
>>
>> mkosi is not allowed to use the label that is unknown on the host on the
>> filesystem. So the file ends up unlabeled in the virtual machine. So
>> using mkosi for testing policy is not useful unless you run mkosi as
>> root. Which is fair to be honest. There is quite a bit of functionality
>> in mkosi that only works if you run it as root.
>
> Yes, I'm not sure if this is a compelling example. For Android I just
> built the support for labeling files into the filesystem image
> generation tools themselves so that it could produce a fully labeled
> filesystem without ever needing to mount it on the host. I think the
> Yocto meta-selinux tooling also migrated toward that kind of an
> approach, although I could be wrong.
>

I agree but its not mounted on the host. It just installs a tree on the
host, labels that a then uses systemd-repart with --offline [1] option to
copy the tree to a disk image (no root needed and no mounting needed)

You'd still need to be able to associate an invalid label with the file.

[1] "--offline=3DBOOL

    Instructs systemd-repart to build the image offline. Takes a boolean or=
 "auto". Defaults to "auto". If enabled, the image is built without using l=
oop devices. This is useful to build images unprivileged or when loop devic=
es are not available. If disabled, the image is always built using loop dev=
ices. If "auto", systemd-repart will build the image online if possible and=
 fall back to building the image offline if loop devices are not available =
or cannot be accessed due to missing permissions.

    Added in version 254.
    "

https://github.com/systemd/mkosi/blob/main/mkosi/__init__.py#L3210
https://github.com/systemd/mkosi/blob/main/mkosi/__init__.py#L3334

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
