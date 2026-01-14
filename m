Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCD33509E
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415338; cv=none; b=d4eP8Og5AZEilxTfbymRKQrUMCjLtJCXLMAidxqmZ3wFAyqICFy3+v8tFB/6vuWMHFrCtgJSQ1VvuDVVdVMkwV3Nx0K2Y2+xQpAO3VJ7cqGvuhE4YNXXA7+RQ8YWPetq9hGkjVcNJQbiawomuLRWeA+sv17ObEASzpdLrK3f0TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415338; c=relaxed/simple;
	bh=Kl+Lm15ltKy2jYMWnZp1RRf5GQ21WkcGJpUftyvAdgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vFjECIs6PEgphEyC948WaCNadhpufV49WVLR3n2EpuP3bqXQtc1GeR/SgJNNEHj165nAwkHqsXwoVWKsb8E6ovud2OBqk7SduuwgV5iYWofnDRzds1BXM8QAstiz4RMhx+x4JiWKIrVmglUp+l9EBGdHKyJCjQhxlA2FCkI2dl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiveX1sz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiveX1sz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768415335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/wfQ4wtCCEBsUaLxY6RM7jlzUrFBMyp4WeEr7eGpeM=;
	b=SiveX1sz+n7OXC7S6cxNkIENl0ccsizCYkE5IDJnAr3m92NqmaT4rxtCgVh9xfOf4Y4nB7
	GVxisPXVvW8xo4gI1Ym5N2jcLA6IiDo4HoCMwTISSueMGibf8WgzYZ8FAhwM9Za/cgPXxr
	e2R8Hw4O7mpTxelcoGmazjktEQ8ofkE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-g8lsm7TiNOSMF1LpThzzLg-1; Wed,
 14 Jan 2026 13:28:53 -0500
X-MC-Unique: g8lsm7TiNOSMF1LpThzzLg-1
X-Mimecast-MFC-AGG-ID: g8lsm7TiNOSMF1LpThzzLg_1768415332
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B187B180034F;
	Wed, 14 Jan 2026 18:28:52 +0000 (UTC)
Received: from localhost (unknown [10.44.32.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E1D21800285;
	Wed, 14 Jan 2026 18:28:51 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
In-Reply-To: <CAHC9VhTcEFHNJcTSbvWFU4gKpAUBg-8cLAfushX8CrhnT41SbQ@mail.gmail.com>
References: <20260105174020.887724-1-lautrbach@redhat.com>
 <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
 <87h5sxvd52.fsf@redhat.com>
 <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
 <87cy3kv5w2.fsf@redhat.com>
 <CAHC9VhTcEFHNJcTSbvWFU4gKpAUBg-8cLAfushX8CrhnT41SbQ@mail.gmail.com>
Date: Wed, 14 Jan 2026 19:28:50 +0100
Message-ID: <873448ujz1.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Paul Moore <paul@paul-moore.com> writes:

> On Thu, Jan 8, 2026 at 3:57=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>> Paul Moore <paul@paul-moore.com> writes:
>> > On Wed, Jan 7, 2026 at 7:08=E2=80=AFAM Petr Lautrbach <lautrbach@redha=
t.com> wrote:
>> >> Paul Moore <paul@paul-moore.com> writes:
>> >> > On Mon, Jan 5, 2026 at 12:46=E2=80=AFPM Petr Lautrbach <lautrbach@r=
edhat.com> wrote:
>
> ...
>
>> >> >> diff --git a/SECURITY.md b/SECURITY.md
>> >> >> index 2a7ce5b317a7..faa060ccff03 100644
>> >> >> --- a/SECURITY.md
>> >> >> +++ b/SECURITY.md
>> >> >> @@ -24,7 +24,8 @@ list is below. We typically request at most a 90=
 day time period to address
>> >> >>  the issue before it is made public, but we will make every effort=
 to address
>> >> >>  the issue as quickly as possible and shorten the disclosure windo=
w.
>> >> >>
>> >> >> -* Petr Lautrbach, plautrba@redhat.com
>> >> >> +* Petr Lautrbach, lautrbach@redhat.com
>> >> >> +  *  (GPG fingerprint) 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5=
DC1 C13E
>> >> >
>> >> > I think you may want to list the fingerprint of your primary key and
>> >> > not a subkey, as the primary key is what carries the signatures and
>> >> > helps verify trust.
>> >> >
>> >>
>> >> I guess I need help then:
>> >>
>> >> $ gpg --show-keys --fingerprint lautrbach@redhat.com.gpg
>> >
>> > You want to use the key fingerprint which displays when you run 'gpg
>> > --fingerprint <email>'.  Assuming you have the keys for the other devs
>> > in your keyring, you'll notice that command can be used to reproduce
>> > the other fingerprints in the file.
>> >
>> > %  gpg --fingerprint plautrba@redhat.com
>> > pub   rsa4096 2012-04-03 [SC]
>> >      E853 C184 8B01 85CF 4286  4DF3 63A8 AD4B 982C 4373
>> > uid           [  full  ] Petr Lautrbach <plautrba@redhat.com>
>> > sub   rsa4096 2012-04-03 [E]
>> > sub   rsa4096 2017-12-05 [S]
>> > sub   rsa4096 2017-12-05 [A]
>>
>> I've also changed my email contact address to lautrbach@redhat.com which=
 I
>> use for some time already:
>>
>> > From: Petr Lautrbach <lautrbach@redhat.com>
>>
>> > -* Petr Lautrbach, plautrba@redhat.com
>> > +* Petr Lautrbach, lautrbach@redhat.com
>
> There are mechanisms to add a new identity to an existing GPG key:
>
> https://docs.github.com/en/authentication/managing-commit-signature-verif=
ication/associating-an-email-with-your-gpg-key
>


I could add plautrba@redhat.com to lautrbach@redhat.com (68D2 1823 342A
1368 3AEB  3E4E FB4C 685B 5DC1 C13E) but it would not make any
difference for this purpose.

I use lautrbach@redhat.com email and I expect people send me encrypted
emails using 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E key there.

I use lautrbach@redhat.com identity for signing since  SELinux userspace re=
lease
3.6 in December 2023.

$ gpg --verify checkpolicy-3.6.tar.gz.asc=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
gpg: assuming signed data in 'checkpolicy-3.6.tar.gz'
gpg: Signature made Wed 13 Dec 2023 03:47:30 PM CET
gpg:                using RSA key 1BE2C0FF08949623102FD2564695881C254508D1
gpg: Good signature from "Petr Lautrbach <lautrbach@redhat.com>" [expired]
gpg: Note: This key has expired!
Primary key fingerprint: B868 2847 764D F60D F52D  992C BC39 05F2 3517 9CF1
     Subkey fingerprint: 1BE2 C0FF 0894 9623 102F  D256 4695 881C 2545 08D1

$ gpg --verify checkpolicy-3.9.tar.gz.asc
gpg: assuming signed data in 'checkpolicy-3.9.tar.gz'
gpg: Signature made Wed 16 Jul 2025 12:55:48 PM CEST
gpg:                using RSA key 7200EB2C3F5E488463C0CE9ECDCAE8C927C6BE31
gpg: Good signature from "Petr Lautrbach <plautrba@redhat.com>" [ultimate]
gpg:                 aka "Petr Lautrbach <lautrbach@redhat.com>" [ultimate]
Primary key fingerprint: 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E
     Subkey fingerprint: 7200 EB2C 3F5E 4884 63C0  CE9E CDCA E8C9 27C6 BE31



The only copy of private key of E853 C184 8B01 85CF 4286  4DF3 63A8 AD4B982=
C 4373
was on my yubikey which I destroyed few years ago when I forgot the PIN.

Petr

