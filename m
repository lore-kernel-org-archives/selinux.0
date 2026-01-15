Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106932E13A
	for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464065; cv=none; b=c/0oOgM4+ZOICdkMOK3yWgDzXBScQJU0S9VQmgd2TLMGFdKE3EALYqf6YUra5TIESX4lbXMt4v93lVx9NbsORVDX704P2I18tCfChIFAVSpPseUUi+pp7M7nap1sAdoeYgpYHgrdcZyPC13sw8VOfBLoZEeKGVeiWtdoTa2ZcD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464065; c=relaxed/simple;
	bh=TyZjkTEgQQv2qNcss8tbuAFQwkm40ae+9Kcv3IF7nZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=amzFACl1ufj7IcWIhecODvPI82g/koKyi6kccQmqg12l579hpvV71iuSrduxv+wUwiiGze2YhuLQkNknaWybts5324wR4wrVCpgjNZj7SdwHc1KSrSZQzNdE4XCehLDbvzY6S8acDVm6aQ2wZP/+OIspeDdnQboUJl/VSyDm+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UStQMU89; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UStQMU89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768464061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0thFOOhBlsfzvsrhP0+xjV/LtVYR/Nfb8tev44U3tno=;
	b=UStQMU89TD8mttd2R0QHHRA99Nu+WXS3Xluhw3hCffUxefCDnODYHCqIFDZSfKU5SjVm3a
	OAuvlThINpMO9/6M311irdlEcjz3q3AkKq4vwm6DhBUEbLj6FX2rtLiVzcKsAJw6DKymkr
	0cz1rDmTCWVUEBJ5Zo7nI7mCP/hWCBc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-5SXeXmQ2P5ub-03M3EY8yQ-1; Thu,
 15 Jan 2026 03:00:59 -0500
X-MC-Unique: 5SXeXmQ2P5ub-03M3EY8yQ-1
X-Mimecast-MFC-AGG-ID: 5SXeXmQ2P5ub-03M3EY8yQ_1768464058
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A151918005A7;
	Thu, 15 Jan 2026 08:00:58 +0000 (UTC)
Received: from localhost (unknown [10.45.224.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CC9D180049F;
	Thu, 15 Jan 2026 08:00:57 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
In-Reply-To: <CAHC9VhSBGr=6izQCmWwOcg85S3G02aDMgSrQ-bGEf-sR9RYtVg@mail.gmail.com>
References: <20260105174020.887724-1-lautrbach@redhat.com>
 <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
 <87h5sxvd52.fsf@redhat.com>
 <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
 <87cy3kv5w2.fsf@redhat.com>
 <CAHC9VhTcEFHNJcTSbvWFU4gKpAUBg-8cLAfushX8CrhnT41SbQ@mail.gmail.com>
 <873448ujz1.fsf@redhat.com>
 <CAHC9VhSBGr=6izQCmWwOcg85S3G02aDMgSrQ-bGEf-sR9RYtVg@mail.gmail.com>
Date: Thu, 15 Jan 2026 09:00:56 +0100
Message-ID: <87pl7b1f0n.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Paul Moore <paul@paul-moore.com> writes:

> On Wed, Jan 14, 2026 at 1:28=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>> Paul Moore <paul@paul-moore.com> writes:
>> > On Thu, Jan 8, 2026 at 3:57=E2=80=AFAM Petr Lautrbach <lautrbach@redha=
t.com> wrote:
>> >> Paul Moore <paul@paul-moore.com> writes:
>> >> > On Wed, Jan 7, 2026 at 7:08=E2=80=AFAM Petr Lautrbach <lautrbach@re=
dhat.com> wrote:
>> >> >> Paul Moore <paul@paul-moore.com> writes:
>> >> >> > On Mon, Jan 5, 2026 at 12:46=E2=80=AFPM Petr Lautrbach <lautrbac=
h@redhat.com> wrote:
>> >
>> > ...
>> >
>> >> >> >> diff --git a/SECURITY.md b/SECURITY.md
>> >> >> >> index 2a7ce5b317a7..faa060ccff03 100644
>> >> >> >> --- a/SECURITY.md
>> >> >> >> +++ b/SECURITY.md
>> >> >> >> @@ -24,7 +24,8 @@ list is below. We typically request at most a=
 90 day time period to address
>> >> >> >>  the issue before it is made public, but we will make every eff=
ort to address
>> >> >> >>  the issue as quickly as possible and shorten the disclosure wi=
ndow.
>> >> >> >>
>> >> >> >> -* Petr Lautrbach, plautrba@redhat.com
>> >> >> >> +* Petr Lautrbach, lautrbach@redhat.com
>> >> >> >> +  *  (GPG fingerprint) 68D2 1823 342A 1368 3AEB  3E4E FB4C 685=
B 5DC1 C13E
>> >> >> >
>> >> >> > I think you may want to list the fingerprint of your primary key=
 and
>> >> >> > not a subkey, as the primary key is what carries the signatures =
and
>> >> >> > helps verify trust.
>> >> >> >
>> >> >>
>> >> >> I guess I need help then:
>> >> >>
>> >> >> $ gpg --show-keys --fingerprint lautrbach@redhat.com.gpg
>> >> >
>> >> > You want to use the key fingerprint which displays when you run 'gpg
>> >> > --fingerprint <email>'.  Assuming you have the keys for the other d=
evs
>> >> > in your keyring, you'll notice that command can be used to reproduce
>> >> > the other fingerprints in the file.
>> >> >
>> >> > %  gpg --fingerprint plautrba@redhat.com
>> >> > pub   rsa4096 2012-04-03 [SC]
>> >> >      E853 C184 8B01 85CF 4286  4DF3 63A8 AD4B 982C 4373
>> >> > uid           [  full  ] Petr Lautrbach <plautrba@redhat.com>
>> >> > sub   rsa4096 2012-04-03 [E]
>> >> > sub   rsa4096 2017-12-05 [S]
>> >> > sub   rsa4096 2017-12-05 [A]
>> >>
>> >> I've also changed my email contact address to lautrbach@redhat.com wh=
ich I
>> >> use for some time already:
>> >>
>> >> > From: Petr Lautrbach <lautrbach@redhat.com>
>> >>
>> >> > -* Petr Lautrbach, plautrba@redhat.com
>> >> > +* Petr Lautrbach, lautrbach@redhat.com
>> >
>> > There are mechanisms to add a new identity to an existing GPG key:
>> >
>> > https://docs.github.com/en/authentication/managing-commit-signature-ve=
rification/associating-an-email-with-your-gpg-key
>>
>>
>> I could add plautrba@redhat.com to lautrbach@redhat.com (68D2 1823 342A
>> 1368 3AEB  3E4E FB4C 685B 5DC1 C13E) but it would not make any
>> difference for this purpose.
>>
>> I use lautrbach@redhat.com email and I expect people send me encrypted
>> emails using 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E key ther=
e.
>>
>> I use lautrbach@redhat.com identity for signing since  SELinux userspace=
 release
>> 3.6 in December 2023.
>>
>> $ gpg --verify checkpolicy-3.6.tar.gz.asc
>> gpg: assuming signed data in 'checkpolicy-3.6.tar.gz'
>> gpg: Signature made Wed 13 Dec 2023 03:47:30 PM CET
>> gpg:                using RSA key 1BE2C0FF08949623102FD2564695881C254508=
D1
>> gpg: Good signature from "Petr Lautrbach <lautrbach@redhat.com>" [expire=
d]
>> gpg: Note: This key has expired!
>> Primary key fingerprint: B868 2847 764D F60D F52D  992C BC39 05F2 3517 9=
CF1
>>      Subkey fingerprint: 1BE2 C0FF 0894 9623 102F  D256 4695 881C 2545 0=
8D1
>>
>> $ gpg --verify checkpolicy-3.9.tar.gz.asc
>> gpg: assuming signed data in 'checkpolicy-3.9.tar.gz'
>> gpg: Signature made Wed 16 Jul 2025 12:55:48 PM CEST
>> gpg:                using RSA key 7200EB2C3F5E488463C0CE9ECDCAE8C927C6BE=
31
>> gpg: Good signature from "Petr Lautrbach <plautrba@redhat.com>" [ultimat=
e]
>> gpg:                 aka "Petr Lautrbach <lautrbach@redhat.com>" [ultima=
te]
>> Primary key fingerprint: 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C=
13E
>>      Subkey fingerprint: 7200 EB2C 3F5E 4884 63C0  CE9E CDCA E8C9 27C6 B=
E31
>>
>> The only copy of private key of E853 C184 8B01 85CF 4286  4DF3 63A8 AD4B=
982C 4373
>> was on my yubikey which I destroyed few years ago when I forgot the PIN.
>
[...]
> Beyond that, I think there is a disconnect between the different GPG
> key types, signatures, etc. There is a link below which I think may
> help explain the differences, but if you are already familiar with GPG
> keys and I'm simply misunderstanding things, please feel free to
> ignore the link (the post is somewhat lengthy).
>
> https://davesteele.github.io/gpg/2014/09/20/anatomy-of-a-gpg-key
>
> When listing GPG key fingerprints, people list the fingerprint of
> their primary key, as that is the key which is signed by others, and
> the key used to sign other people's (primary) keys.  This primary key
> is then used to sign the subkeys associated with the primary key;
> these subkeys are what are typically used for signing, encryption, and
> in some cases authentication (ssh, etc.).  For example, if you look at
> my entry in the SECURITY.md file you will see a key fingerprint of
> 7100..., the fingerprint of my primary key, but if you look at the
> kernel tag signatures you see that I'm using my signature subkey.
>
> [NOTE: command output trimmed for clarity]
>
> % gpg --fingerprint paul@paul-moore.com
> pub   rsa4096 2011-10-10 [SC]
>      7100...
> uid           [ultimate] Paul Moore <paul@paul-moore.com>
> sub   rsa4096 2018-10-15 [E]
> sub   rsa4096 2018-10-15 [S]
> sub   rsa4096 2020-06-19 [A]
> %  git tag --verify selinux-pr-20251201
> selinux/stable-6.19 PR 20251201
> gpg: Signature made Mon 01 Dec 2025 03:54:57 PM EST
> gpg:                using RSA key 4B42...
> gpg:                issuer "paul@paul-moore.com"
> gpg: Good signature from "Paul Moore <paul@paul-moore.com>" [ultimate]
> % gpg --list-key 4B42...
> pub   rsa4096 2011-10-10 [SC]
>      7100...
> uid           [ultimate] Paul Moore <paul@paul-moore.com>
> sub   rsa4096 2018-10-15 [E]
> sub   rsa4096 2018-10-15 [S]
> sub   rsa4096 2020-06-19 [A]
>
> I believe that if you look at the other GPG fingerprints in
> SECURITY.md you will see that they are all fingerprints of primary
> keys, not subkeys.
>

"68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E" is not a subkey.=20


$ gpg --fingerprint lautrbach@redhat.com
pub   rsa4096/FB4C685B5DC1C13E 2024-11-04 [SC] [expires: 2026-11-04]
      Key fingerprint =3D 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
=20=20

      Keygrip =3D 834230A0854D7A8698B5432C007560FE7AECC504
uid                 [ultimate] Petr Lautrbach <plautrba@redhat.com>
uid                 [ultimate] Petr Lautrbach <lautrbach@redhat.com>
sub   rsa4096/C500C028A770AB66 2024-11-04 [E] [expires: 2026-11-04]
      Key fingerprint =3D 58E9 06B2 5680 15A7 91C8  D2EC C500 C028 A770 AB66
      Keygrip =3D 2EF1D48B43E234CAAE155A0AD032C00063FCB102
sub   rsa4096/CDCAE8C927C6BE31 2024-11-04 [S] [expires: 2026-11-04]
      Key fingerprint =3D 7200 EB2C 3F5E 4884 63C0  CE9E CDCA E8C9 27C6 BE31
      Keygrip =3D CAE3E6B80FFD15958C813CC635CFFDF9F86D9C17
sub   rsa4096/37BCD711A64B2890 2024-11-04 [AR] [expires: 2026-11-04]
      Key fingerprint =3D 832F CF4A 82B0 7F2A 51E4  3DDB 37BC D711 A64B 2890
      Keygrip =3D 850707DAF56607DEABD28933FD0A77D382923F1C


$ gpg --list-key FB4C685B5DC1C13E
pub   rsa4096/FB4C685B5DC1C13E 2024-11-04 [SC] [expires: 2026-11-04]
      Key fingerprint =3D 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E
      Keygrip =3D 834230A0854D7A8698B5432C007560FE7AECC504
uid                 [ultimate] Petr Lautrbach <lautrbach@redhat.com>
sub   rsa4096/C500C028A770AB66 2024-11-04 [E] [expires: 2026-11-04]
      Keygrip =3D 2EF1D48B43E234CAAE155A0AD032C00063FCB102
sub   rsa4096/CDCAE8C927C6BE31 2024-11-04 [S] [expires: 2026-11-04]
      Keygrip =3D CAE3E6B80FFD15958C813CC635CFFDF9F86D9C17
sub   rsa4096/37BCD711A64B2890 2024-11-04 [AR] [expires: 2026-11-04]
      Keygrip =3D 850707DAF56607DEABD28933FD0A77D382923F1C


$ git tag -s -m "check signature" check

$ git tag --verify check=20=20=20=20=20=20=20=20=20=20=20=20=20=20
object 374ee744d6ed84ee2ca70c90be023290409a8fa4
type commit
tag check
tagger Petr Lautrbach <lautrbach@redhat.com> 1768463780 +0100

check signature
gpg: Signature made Thu 15 Jan 2026 08:56:20 AM CET
gpg:                using RSA key 7200EB2C3F5E488463C0CE9ECDCAE8C927C6BE31
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   1  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: depth: 1  valid:   1  signed:   0  trust: 1-, 0q, 0n, 0m, 0f, 0u
gpg: next trustdb check due at 2026-11-04
gpg: Good signature from "Petr Lautrbach <lautrbach@redhat.com>" [ultimate]
Primary key fingerprint: 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E
     Subkey fingerprint: 7200 EB2C 3F5E 4884 63C0  CE9E CDCA E8C9 27C6 BE31



I've dropped all but the one key from https://plautrba.fedorapeople.org/lau=
trbach@redhat.com.gpg

# curl -O https://plautrba.fedorapeople.org/lautrbach@redhat.com.gpg

# gpg --show-keys --fingerprint lautrbach@redhat.com.gpg
pub   rsa4096 2024-11-04 [SC] [expires: 2026-11-04]
      68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E
uid                      Petr Lautrbach <lautrbach@redhat.com>
sub   rsa4096 2024-11-04 [E] [expires: 2026-11-04]
sub   rsa4096 2024-11-04 [S] [expires: 2026-11-04]
sub   rsa4096 2024-11-04 [AR] [expires: 2026-11-04]



