Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6026D4E5
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424121; cv=none; b=Vg8iQ+TbofwaWHoPppPb5Dm9XPf+I/sy3tYiESlzCtIkIThs75mCCGj2WRVMtpwXweegRfR5mkdqcnB/gM+YFcbEaTkzouFiM1LJEKzQ1vjHrPePRH9/BnJS8v4O5rChtLTs1zzzg2FTkisjZHTxzvEEQC46EkR0JQYM4ejRrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424121; c=relaxed/simple;
	bh=WzPP6InwypV58AN4M9bxp/LPj/erFLR8FnWiDAgRzSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNX46uT8ga1KcDPZkB2g0BH5CQ+uxCwyC43lQd3h2qIuY9+vb12/WtCbcNwtRh9PU+s9YYnP6OJkCa/HQ7nWW+7lgs0dM22XQnadHSU+pmK0LS/yUrbqTvOEGIn1+zBhWnQHhVOTZyc4IJSWdIp9m+hGBHCXRv84aL3C66Kmh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Oo7iw5Vz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Oo7iw5Vz"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34b75fba315so58147a91.3
        for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 12:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768424119; x=1769028919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov56W3kE6T99c3Wt7CAHQmWWwKH29Zcq0pg7H0jYfZ0=;
        b=Oo7iw5Vzu+oig+4Qtn7Z1yGu90r3M0Jio6plIaVhiHXTKaGsTgcd0+kLsx5A/3xcdZ
         orsT79JvI16c4qMVPxHDNs2KfgwTvgR9USww7uOf0Isuxd6rrBYabKjNL3GUm99gWX1L
         ArLAkwp2TfQHJx64NO9FO5Bqsw0JXadbx79z/G4Q5yti1Vf4C0ki4HIIKlsDlLtgKctN
         FsytA4iTSmdrwhwanqeaRf1n457FvWvvMWyMXbzPl3eDhYYsQqKI2neXbFq17jrTaobb
         fqxDRYx3pMpofXSWbcw/qX3rXoOxBXys2jjxaal0rUOhF2a0rCVA43+rZP6rFdf3Ffw0
         yifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768424119; x=1769028919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ov56W3kE6T99c3Wt7CAHQmWWwKH29Zcq0pg7H0jYfZ0=;
        b=K3iVR2+mmtwQYs5nd+loVVdNUwtrJOFz4bybiBTgxt63LGeTKlh8auxUgYiGttdHEg
         naszxotEx3lE1s0jgYTICm0aJNNrgLyyE3ogrk3wlJaT5B7BJEHhB8halTlli3SgPkBQ
         7f/7NaoWG+ox13wItWpDSBG5Po3AMmm0KO7b9Qy1QdzHKiBo9ziOwdMNS5DMdB8cE36n
         SF/idP2DK7geEL6AH+26tXbLeP1NHX/2D7/6I1rMdmNilwBWHdLgnHxVbpuX6cejBLU5
         aDfEsBJrNQr+8g50MkJ+FXQeeZa888EtxY5QqDOxEy4AWT78D3Z1N4llYtdQrYJIhhkZ
         PKag==
X-Gm-Message-State: AOJu0Yx0H/Yp39PulxPtpjbvP3wUqvpuaQPTdeC8ZhyYSY/qM0g2WiUk
	1UQfqeZ6iA6kNY5T+2MnPZDLnjTciO17AN4o4HZsIznZOU1pW6DJdW3Q9Ikn6nSirj0nrGhYw/n
	M++3T2+yPjQOczF2WxO4eJlGaA8Kmnh5SA6ijHjVq
X-Gm-Gg: AY/fxX4aQqGCOJpX9zfPcl8N7xBn/g2V3d4xz02+jwYSazJiz3Xe4MjqmZVggaxDwIF
	OI+JCcHvX+94svWLzNfORmNH1VEXb3+7QOI8TxaN3E/HN/8E/bL5lPC4wmXBhtY2i1r/cnBGTiu
	eFNlGpHa8RV6/2S7lQObBOOXaq5PRmieTWDtrymzoKBjkAwEF7URkhTl5chw7mtVP5PIkANpoNe
	wn+PeiL5X/eJgxPI1I8zTgjTNYhYPhK7HRXlzpC0rWccx6a/aeqSiXakL2vUuSF4qsoLS6dakAi
	+nmofw==
X-Received: by 2002:a17:90a:f945:b0:340:e529:5572 with SMTP id
 98e67ed59e1d1-3510909522fmr3520456a91.8.1768424118933; Wed, 14 Jan 2026
 12:55:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105174020.887724-1-lautrbach@redhat.com> <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
 <87h5sxvd52.fsf@redhat.com> <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
 <87cy3kv5w2.fsf@redhat.com> <CAHC9VhTcEFHNJcTSbvWFU4gKpAUBg-8cLAfushX8CrhnT41SbQ@mail.gmail.com>
 <873448ujz1.fsf@redhat.com>
In-Reply-To: <873448ujz1.fsf@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Jan 2026 15:55:07 -0500
X-Gm-Features: AZwV_QjmC-pDRioATxlKz7fkKkKMQfDn3eYu_OR7mkiZr6Hlgx5p46BZt3N4fOE
Message-ID: <CAHC9VhSBGr=6izQCmWwOcg85S3G02aDMgSrQ-bGEf-sR9RYtVg@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 1:28=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Thu, Jan 8, 2026 at 3:57=E2=80=AFAM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
> >> Paul Moore <paul@paul-moore.com> writes:
> >> > On Wed, Jan 7, 2026 at 7:08=E2=80=AFAM Petr Lautrbach <lautrbach@red=
hat.com> wrote:
> >> >> Paul Moore <paul@paul-moore.com> writes:
> >> >> > On Mon, Jan 5, 2026 at 12:46=E2=80=AFPM Petr Lautrbach <lautrbach=
@redhat.com> wrote:
> >
> > ...
> >
> >> >> >> diff --git a/SECURITY.md b/SECURITY.md
> >> >> >> index 2a7ce5b317a7..faa060ccff03 100644
> >> >> >> --- a/SECURITY.md
> >> >> >> +++ b/SECURITY.md
> >> >> >> @@ -24,7 +24,8 @@ list is below. We typically request at most a =
90 day time period to address
> >> >> >>  the issue before it is made public, but we will make every effo=
rt to address
> >> >> >>  the issue as quickly as possible and shorten the disclosure win=
dow.
> >> >> >>
> >> >> >> -* Petr Lautrbach, plautrba@redhat.com
> >> >> >> +* Petr Lautrbach, lautrbach@redhat.com
> >> >> >> +  *  (GPG fingerprint) 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B=
 5DC1 C13E
> >> >> >
> >> >> > I think you may want to list the fingerprint of your primary key =
and
> >> >> > not a subkey, as the primary key is what carries the signatures a=
nd
> >> >> > helps verify trust.
> >> >> >
> >> >>
> >> >> I guess I need help then:
> >> >>
> >> >> $ gpg --show-keys --fingerprint lautrbach@redhat.com.gpg
> >> >
> >> > You want to use the key fingerprint which displays when you run 'gpg
> >> > --fingerprint <email>'.  Assuming you have the keys for the other de=
vs
> >> > in your keyring, you'll notice that command can be used to reproduce
> >> > the other fingerprints in the file.
> >> >
> >> > %  gpg --fingerprint plautrba@redhat.com
> >> > pub   rsa4096 2012-04-03 [SC]
> >> >      E853 C184 8B01 85CF 4286  4DF3 63A8 AD4B 982C 4373
> >> > uid           [  full  ] Petr Lautrbach <plautrba@redhat.com>
> >> > sub   rsa4096 2012-04-03 [E]
> >> > sub   rsa4096 2017-12-05 [S]
> >> > sub   rsa4096 2017-12-05 [A]
> >>
> >> I've also changed my email contact address to lautrbach@redhat.com whi=
ch I
> >> use for some time already:
> >>
> >> > From: Petr Lautrbach <lautrbach@redhat.com>
> >>
> >> > -* Petr Lautrbach, plautrba@redhat.com
> >> > +* Petr Lautrbach, lautrbach@redhat.com
> >
> > There are mechanisms to add a new identity to an existing GPG key:
> >
> > https://docs.github.com/en/authentication/managing-commit-signature-ver=
ification/associating-an-email-with-your-gpg-key
>
>
> I could add plautrba@redhat.com to lautrbach@redhat.com (68D2 1823 342A
> 1368 3AEB  3E4E FB4C 685B 5DC1 C13E) but it would not make any
> difference for this purpose.
>
> I use lautrbach@redhat.com email and I expect people send me encrypted
> emails using 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E key there=
.
>
> I use lautrbach@redhat.com identity for signing since  SELinux userspace =
release
> 3.6 in December 2023.
>
> $ gpg --verify checkpolicy-3.6.tar.gz.asc
> gpg: assuming signed data in 'checkpolicy-3.6.tar.gz'
> gpg: Signature made Wed 13 Dec 2023 03:47:30 PM CET
> gpg:                using RSA key 1BE2C0FF08949623102FD2564695881C254508D=
1
> gpg: Good signature from "Petr Lautrbach <lautrbach@redhat.com>" [expired=
]
> gpg: Note: This key has expired!
> Primary key fingerprint: B868 2847 764D F60D F52D  992C BC39 05F2 3517 9C=
F1
>      Subkey fingerprint: 1BE2 C0FF 0894 9623 102F  D256 4695 881C 2545 08=
D1
>
> $ gpg --verify checkpolicy-3.9.tar.gz.asc
> gpg: assuming signed data in 'checkpolicy-3.9.tar.gz'
> gpg: Signature made Wed 16 Jul 2025 12:55:48 PM CEST
> gpg:                using RSA key 7200EB2C3F5E488463C0CE9ECDCAE8C927C6BE3=
1
> gpg: Good signature from "Petr Lautrbach <plautrba@redhat.com>" [ultimate=
]
> gpg:                 aka "Petr Lautrbach <lautrbach@redhat.com>" [ultimat=
e]
> Primary key fingerprint: 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C1=
3E
>      Subkey fingerprint: 7200 EB2C 3F5E 4884 63C0  CE9E CDCA E8C9 27C6 BE=
31
>
> The only copy of private key of E853 C184 8B01 85CF 4286  4DF3 63A8 AD4B9=
82C 4373
> was on my yubikey which I destroyed few years ago when I forgot the PIN.

First off, if you've lost access to your primary GPG key you likely
want to create a new GPG key and get that signed by other trusted
SELinux developers; I'm sure you remember the process, but we can
discuss more offline if needed.

Beyond that, I think there is a disconnect between the different GPG
key types, signatures, etc. There is a link below which I think may
help explain the differences, but if you are already familiar with GPG
keys and I'm simply misunderstanding things, please feel free to
ignore the link (the post is somewhat lengthy).

https://davesteele.github.io/gpg/2014/09/20/anatomy-of-a-gpg-key

When listing GPG key fingerprints, people list the fingerprint of
their primary key, as that is the key which is signed by others, and
the key used to sign other people's (primary) keys.  This primary key
is then used to sign the subkeys associated with the primary key;
these subkeys are what are typically used for signing, encryption, and
in some cases authentication (ssh, etc.).  For example, if you look at
my entry in the SECURITY.md file you will see a key fingerprint of
7100..., the fingerprint of my primary key, but if you look at the
kernel tag signatures you see that I'm using my signature subkey.

[NOTE: command output trimmed for clarity]

% gpg --fingerprint paul@paul-moore.com
pub   rsa4096 2011-10-10 [SC]
     7100...
uid           [ultimate] Paul Moore <paul@paul-moore.com>
sub   rsa4096 2018-10-15 [E]
sub   rsa4096 2018-10-15 [S]
sub   rsa4096 2020-06-19 [A]
%  git tag --verify selinux-pr-20251201
selinux/stable-6.19 PR 20251201
gpg: Signature made Mon 01 Dec 2025 03:54:57 PM EST
gpg:                using RSA key 4B42...
gpg:                issuer "paul@paul-moore.com"
gpg: Good signature from "Paul Moore <paul@paul-moore.com>" [ultimate]
% gpg --list-key 4B42...
pub   rsa4096 2011-10-10 [SC]
     7100...
uid           [ultimate] Paul Moore <paul@paul-moore.com>
sub   rsa4096 2018-10-15 [E]
sub   rsa4096 2018-10-15 [S]
sub   rsa4096 2020-06-19 [A]

I believe that if you look at the other GPG fingerprints in
SECURITY.md you will see that they are all fingerprints of primary
keys, not subkeys.

--=20
paul-moore.com
