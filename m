Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC37E110
	for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501855; cv=none; b=T7hAd+wsXyezLVAB+NB0VWJX9QA/vn5Cu/OUGXsuL1F3J42/5zMR5bD4lubzU/X1Y3LGSdNBkCc0D0p99/5XVONuk1o3QXFo4cJ3v1FUcmUMBRrgNxAO+9/6WGQI8IFDdpgE81ixPI4eNqFS2DJMjm4MDoqd5p0j3aqyl5bWpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501855; c=relaxed/simple;
	bh=kOFdyFLrNqqSSYEonZmo4lLZjpAVFVIDGNDux7zZO3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OohDryZFZ4AC15tm6WQG78fke5aSNRqxLgro1G62D45C8kKVlmp6FPtDq4AKguHNqv+H85pv2DfvEYlL4uVDBodDpF/MbnoYXwKZeLp/uowlX7DN1d3HgyCVYdl+Jt1gvn0FFh4xrCi44gIBwqceDHVV+Qdh5wK3nJmSuGSahYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AjytT9HJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AjytT9HJ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso644825a91.1
        for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 10:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768501853; x=1769106653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NBlsHGaPofsfeysKJDYrwWUKppjpSWrgs3CKYo92f4=;
        b=AjytT9HJvBfQAgSGdrGe9TEqrorDXcD4DSqoTDkaDNml5asNM2f2YHyIeYRsm2zP/d
         Ss3glhF5OHpv8HYsqRGL0IQ021nQVFDuCTY3pmByQeZWVJ7umbki2on/PwG2H/WZdifF
         4P9NLzSrGWmZCQVONY7ozwkeDFADIwekD85kDylqaEEzLiNhCyAgldP1GJfZXMgH4A4H
         INoF4j5XThv7PBTaWOd5tZ/t8PBoR5Y7pr8gMg0mNdQeyM6xhM4mzX9G7sWCccy9RZAz
         8yfbnV4h4wZCILOojOLZn+L2IoE5RvnX5C++P96G0gdQ/xS8S9djTQkELJQ2CZIe89Iy
         t3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501853; x=1769106653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6NBlsHGaPofsfeysKJDYrwWUKppjpSWrgs3CKYo92f4=;
        b=nydofMzYsKYV4hNMTydnMxNqN9VxM4JrtRUGvkORa96ZTT5eFKwszfRcdT7f0YCMtD
         HF6Ev1iFi6GU6WE/c30RjMfT10Gk/A9b406r0t+NlYehAmvWZSDDuXPqPf/UWESzrkir
         qYyvVCzRN6yBGe/x7RtW6iq0oy5gxamYP9lZPLj0/icvC2n0bJL+6WwZH7TVW9DsOsV7
         x+b96hGPIgmoUSF4Yukh/QwwPXlvonCJjgfhea5z5Dp/C/qYm1OFc4adjeGChyG4ayfR
         geQ3u237tctF53J5qf8peyaCs/K/+3rNEMmZdcnFKIU2xIrnYjUcuYdxW19yrrFGLgCq
         YRtw==
X-Gm-Message-State: AOJu0YyrFT+iUXkYbIAHiVnbHI9SVVq0U+aA7ycJiJHl7NlgPTX/FEQ6
	hhzulxNkvouITtAnpwWBIfbztT4R3G3DsF7pDQiMYCuzOqXIDz9Ot7hkaSs6tnz2lAcT6HJ1ZH/
	aPKtMUApFvN5z/GHv63yOVo0XgJ2h6sH0Oo70JVHtwUY8uhthGvKu2w==
X-Gm-Gg: AY/fxX4pF0EdCO93VeE/dDJ3+niGFKJnOoRrP+kEv6twJ++h3L+Y/YJkvi5kygbCCnD
	5L/0mqAd5a5yYJ7iMBz1RjHfu+tUExoxeN5v1DrVpD/Q46B4uXO5eUorqte6fTtqpG0HBEOMNBu
	sk0abLLY/LZr1jxyCZ4BMDZMM7vhSB/l6rMUGEfum3M6ccvm7Rnppho+WbVP6AT6GIuhTnVytsJ
	NmylHLWiNwMsO+vCLsn+B5YfhdWYQKL28FQWPQaFXpwydPZdG3oUm73P7ImSMOY6V+NbPY=
X-Received: by 2002:a17:90b:2644:b0:34c:6d33:7d34 with SMTP id
 98e67ed59e1d1-35272f2a5cfmr313121a91.16.1768501853068; Thu, 15 Jan 2026
 10:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105174020.887724-1-lautrbach@redhat.com> <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
 <87h5sxvd52.fsf@redhat.com> <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
 <87cy3kv5w2.fsf@redhat.com> <CAHC9VhTcEFHNJcTSbvWFU4gKpAUBg-8cLAfushX8CrhnT41SbQ@mail.gmail.com>
 <873448ujz1.fsf@redhat.com> <CAHC9VhSBGr=6izQCmWwOcg85S3G02aDMgSrQ-bGEf-sR9RYtVg@mail.gmail.com>
 <87pl7b1f0n.fsf@redhat.com> <CAHC9VhQHrnkMO0JMtDyEnsmgMJisSU5bs76bzLYXGirc8uDYmA@mail.gmail.com>
 <87jyxi24jd.fsf@redhat.com>
In-Reply-To: <87jyxi24jd.fsf@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Jan 2026 13:30:41 -0500
X-Gm-Features: AZwV_QgAXG7799O5Q9sncDS3FvVwyHiveIjUlgaxhyo16GpUVprVgqJlH3eC_tU
Message-ID: <CAHC9VhS=LNhFxHjxdeiCD2nThXPeCUibcos5wNTqox4uvVO5ug@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 12:02=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Thu, Jan 15, 2026 at 3:01=E2=80=AFAM Petr Lautrbach <lautrbach@redha=
t.com> wrote:
> >>
> >> "68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E" is not a subkey.
> >
> > Okay, in this case you need to get this new key signed by other
> > individuals trusted by the SELinux community before we can consider
> > including it in the SECURITY.md file.
> >
>
> My idea was:
>
> Before this patch my address was there without gpg fingerprint. It means
> that I could be contacted directly via un-encrypted email.

Yes.  However, I believe there are usually different levels of trust
associated with plaintext and encrypted email.

> The key I used in this patch was already used for SELinux userspace
> release ...

I think the understanding was that release signing would be done by
individuals with a GPG key signed by others in the SELinux community
to help establish trust.  However, as you pointed out I don't think we
documented that requirement or enforced it properly, we should do so
in the future.

> ... public key is available at 2 different locations connected to
> me - github (I'm part of SELinux organization) and
> plautrba.fedorapeople.org (I'm a packager for 15+ years) and it's also
> used in Fedora [1] and RHEL [2] - only Red Hat employees can push there a=
nd it
> was me who pushed [3]. That being said I expected that the key is
> already trusted due to all the records.

While that demonstrates some level of trust between that user/key and
those organizations (GH, Fedora, IBM/RH), it doesn't establish a level
of trust between that user/key and the SELinux community.

> But I see your point. I'll send another patch which will remove my addres=
s from SECURITY.md
> and when the key is signed, I'll return it back.

Great, thank you.  If you want to also propose an update to the
release process wiki page describing the signing process and
requirements I think that would be a good thing.

https://github.com/SELinuxProject/selinux/wiki/Release-Process

--=20
paul-moore.com
