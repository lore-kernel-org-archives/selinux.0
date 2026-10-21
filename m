Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792551091;
	b=vBya7zUe6SdQEyqUN/at38pmb44eOSbElDWeOhVzlCrLu1OAUnQULqbPh+SUrtw3qOSr
	 DRxxgPs3PLxcxQFGE6h9jqGPW793f3BQfx4HOyaw/FGi+OWiEb/3oMl5UsxmUt4AY3if8
	 D3Lc+V1M81Q0k6ASCpat7BfotnhmpwpU8NpUlwhVEFTMADJZd3Xo0D/YvGfMnh3j5pQHA
	 Cf986ywBiIup0Fm/FZOiIY0hiWBmFiounqqKT0ROpQszOUbYyXM2vy3JI2u98nN2rHTCF
	 kEApeqhusM6E83LpvKLvbqPBY8TIr0QYFjp2+2EUGffF/uD90fwJwBU5uvd7J7w1VmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HWTr/TVASeI5+zTMpSF8Qa6tHFXkrdDNPzTvyAQvQDM=;
	b=O1PNdFNhuDJFqI5x+UmM7qTzfbRaECOAFhtFXMbjsx3Qgc0vzbHqz8Tni9q1JQaUm2FS
	 C2SMxzAKxVzQhyHqAVLiCzwpQMrbTcde6KDsqwSSHZIILZY/uZ9y+b4f2bH+cUkiCGFpL
	 q5EOTC3vYAdZODl3E9rG39IX7/KSpmN9qFD5jiGDxz9eDG8ocQASDoTkWtKzbM/Zczh8E
	 sSw8CP9fGjKkWi7sjhAs17Ai7QD8W0NMoCSL9aCUnHLPJ+xAUKmv6eCUlI82+KZ1pDilJ
	 M1d+UtzKwXqgPQcwyZcg+nUkA1zULiyGQ7XXHqynEBa1e2YsTbsAPMP+YztceDYrG3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NYHxsKKl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553D606A319
	for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 02:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5553D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NYHxsKKl
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-535f598d126so101581cf.1
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 19:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792551090; cv=none;
        d=google.com; s=arc-20260327;
        b=RR0f12iDDsgNdon/pycfaniROpTKDjLkCtBoSQdMiXpN+LxviHoqVVdoleh21fe3K1
         5un64Yle50o+6sprBfE4pb5rfGb9G2lgjCPk7wFpihPEe7clr523zPGebeJPQDYH8POm
         1+coVCsoOW/HVt/0Y/lYrWANl5l8+cgh/qrFnGhYm/XI3cdOH3XWPNeC1/PI8GoN3vZm
         mEfSxkdhnSmoEMX+M5CbJU7X34wk+a8yu5wYyCjDOQcz+g770CUO2JxaBqt091Ue6cge
         qh9eBphBxg6wF7E0ol1U7WnyZMc4Odw9u6v9OPIuU00iU6+r5vmZhoHLrvCOJ51q0FoD
         0BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HWTr/TVASeI5+zTMpSF8Qa6tHFXkrdDNPzTvyAQvQDM=;
        fh=m9ho9tsk4ilOhQtMubLbTcaOdtoM8y0jb5PipYlPIUo=;
        b=bOTsVqRlJO0qbWYLzh+wI/w/+KiH+z2Sy61hEY0gptx6hXlN5eb9V5TQEx9bdBgGs4
         qKj8/qkRwP2IqbqqTBQqQAjMfmV5Qbq7g4dJA0ll9Q1IzHBe7eBT//0K950GXo7uM2nZ
         qijV1ezuxp+dZYoJK1XvBH8qLOp/jrBNRLJ/0R9g2mWF2RAdRMZzh+fzcAhrtJdJLHvv
         I9P3th+1DrirZGconZ1OIkIEawFxNanJWUsXIOgjzgIU9I8fQ/vDWq+8YT/N932t3Dp3
         4gOQVZvqj3yXIh4fz5ZiKAOplFSvV8JgmhkiBQIQVumPonP+cBR5WrQnkIwWflSb/5fM
         vMjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792551090; x=1793155890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HWTr/TVASeI5+zTMpSF8Qa6tHFXkrdDNPzTvyAQvQDM=;
        b=NYHxsKKlM2mqu1RGY0gXYqQoTBvvAeesNpK6Rqudc6CWpA9FteA0JMmj2pGAD/e/BR
         Aco71TOREHZ9FnWlhmOoKBbPRF4BoIBjrNGjW8PaGL9wAfB1A9cVd94AB4oQG3EviFgW
         8BMa7HKA4n9TK533j9MgMlKInYg14pYA1YWrctrvNkQlKv4hMcfOyALZr3nrZZFBeuoP
         E72dG8afiFrZvRLoPz/N0Savhdn8n10gT19QtO3A64n8dM2RoS2yCq90SLjJR/+mMqlZ
         XBw9PqgW/qVrTWSTpb8TRiv0aujBjNrjbZiyXjHm/O0SHHqNOxGGQKkXXKCB93qVAvIR
         TStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551090; x=1793155890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWTr/TVASeI5+zTMpSF8Qa6tHFXkrdDNPzTvyAQvQDM=;
        b=iZHPD7vlkIlt4nzJR74rvE90QW3tnPUwrA/Gfy3FluB4cj7E6uCtmbfQLbxH5DiKaq
         +ODtvIyQ7HMRkvjdu5vJ2KFdQLTB1/M8Rc0a9Lqpkhg12fhDbClsHM1x9qeLotq/0fcu
         kS7Gsyfzxaqs42PrCuYVLgkbbDkXwrJxEn2dw8twnZF/s/BtlQ8gO7wwAAiiQHzD9OUh
         B92pO8LMur196adW97NGtzCHh9JPlBs8tlv7ElglH1kXD2vR3d81Re/fbghGIjxpVVt2
         itlaDG2fNhwfRqcBJr/vAbGETvxblTjjBjUFByeQK3Nq+jy+QCDexcHG9jSimALes0Iy
         8E3g==
X-Forwarded-Encrypted: i=1; AKwUvBxyFd4qZ+ZFDPDs1ku2YLFUT08HaQgLsWpISBYUuO378nI9C9I4ZdjkBRx+YXWuk8u5QoJMZWUU@vger.kernel.org
X-Gm-Message-State: AFq9FYKVybGcXU4pck+ItMTlfz8KWiEKPpOV7wSBxwrfNzvIWMcZhQgp
	sQUXv0jG7F1SoD0f1HzhyBFM6CHENLgX6jSfc2pnJny0eqE0vVHg3rhH2rlBu5yL0Ttq3Bcikqj
	oSNKisISH6ZuF3SsTIH8nrQCiG4FCeUlzr7zmyt5Q
X-Gm-Gg: AYBFou2SJ4iGoKhDR+gyD7LYWPEHVmqs+6CStNdcqyuf4gVBO2BV5ZiltTq6zKIByYd
	361jVZuFNkxQK1UL8Ovx3vgncNDSNuZ8vFsefd3CXmkYrxiq00KoI/sM8JZRZaE6YdeAvEPLrcV
	/aKdbPRIykYw/ckPhqBHnoYv+Nw/ebqedlqHHddpNxCUNtDTYIpvv523ZUhPFUd8c8JJsJD0GWS
	juXBoVf5xbWkdEZDCx/+Uwx70DCZLV3xmkcuqhEjmD10d9y/cmJh8zMtqi4WJZ+Ht93yp0n4iGU
	0LHNKXBwLenfUa9EThBrU2Nvg4jNec8GN9CWOUue9omutrxlXA6ooYHuNMuQyo6tRMwy73gVTSU
	MyQix1aJZji9OD+MYeij+f34XcWzBrGjYPMqYbNk/+3yJXOWgv4BluNPurLrsklUGUXPpYzbEq1
	+YLjRQ3lOaSyjGOWJ5c9Ef
X-Received: by 2002:a05:622a:354:b0:536:78de:775f with SMTP id
 d75a77b69052e-5368b3f333cmr24398811cf.15.1792551089748; Tue, 20 Oct 2026
 19:51:29 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930111444.192037-2-lautrbach@redhat.com> <CAEjxPJ4a9r0Um3ufA16spvB6raYSQhaJbzwyWCvz4zkZeigjRg@mail.gmail.com>
 <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com> <pjda4ox8pw0.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
In-Reply-To: <pjda4ox8pw0.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 21 Oct 2026 13:51:11 +1100
X-Gm-Features: AclHuK8HWhGbhKMio4VCdsYje4jLS9kdV_OgXTy39O5RZjFILwPSMnU2lBj1xQE
Message-ID: <CA+zpnLdODz8bLBgJY8LOSZuQOz2OHZYr2qK7eJQ-drB1WYrZng@mail.gmail.com>
Subject: Re: [PATCH] Replace SHA-1 with SHA-256
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	Jason Zaman <jason@perfinion.com>, Russell Coker <russell@coker.com.au>, Cathy Hu <cahu@suse.de>, 
	Johannes Segitz <jsegitz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 12:19=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Wed, Sep 30, 2026 at 9:44=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> On Wed, Sep 30, 2026 at 7:18=E2=80=AFAM Petr Lautrbach <lautrbach@redh=
at.com> wrote:
> >> >
> >> > From: Petr Lautrbach <plautrba@redhat.com>
> >> >
> >> > SHA-1 is considered obsolete so move to SHA-256 as the default diges=
t algorithm.
> >> >
> >> > Import the public-domain SHA-256 implementation from WjCryptLib and =
use it for
> >> > label digest handling.
> >> >
> >> > The original source of sha256.c is
> >> > https://github.com/WaterJuice/WjCryptLib/releases/tag/Version_3.0.0
> >> >
> >> > Ignore sha256.{c,h} in make-format and check-format targets in order=
 to adopt
> >> > possible future changes in WaterJuice/WjCryptLib simpler.
> >> >
> >> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> >> > ---
> >>
> >> A few comments below regarding compatibility / versioning and code
> >> formatting inconsistency, but otherwise
> >> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >>
> >> 1. selabel_hash_all_partial_matches() output size grows from 20 to 32
> >> bytes. selabel_hash_all_partial_matches() is a public exported symbol
> >> (libselinux.map, LIBSELINUX_2.9) whose prototype is uint8_t *digest
> >> with no length parameter and no man page. Any external caller sized
> >> for the old SHA-1 output gets a 12-byte OOB write from
> >> hash_all_partial_matches(). This interface/functionality was based on
> >> Android-specific functionality and I don't see any distro users, so
> >> this is probably fine to break, but it should be a stated decision and
> >> called out in the commit message and the 3.12 release notes. I will
> >> defer to the distros on whether it requires a libselinux.so version
> >> bump; I am fine either way.
> >
> > Actually, if someone cares, we could just use symbol versioning for
> > this and fallback on the old symbol to only write the first 20-bytes
> > of the SHA256 hash to the output buffer to avoid a compatibility
> > break. That said, the only user of this function that I see is in
> > Android's libselinux and that wouldn't be helped by that.
> >
>
> I guess it's related to
> https://android.googlesource.com/platform/external/selinux/+/refs/heads/m=
ain/libselinux/src/android/android_device.c#394
>
> It seems to me that symbol versioning would not help if android just
> pulled new libselinux and left other code intact.
>

Thanks for the patch.

Changing the content of security.sehash has a strong impact for us:
during a regular update, if /data needs to be relabeled (because the
hash optimization is skipped), the boot time increases significantly,
leading to reports from our users and partners.

It is also worth discussing why this migration is required. There is
nothing wrong with treating SHA1 as a regular digest. On Android, the
file_contexts used as input are all backed by dm-verity read-only
partitions.

If we still want to move forward, I recommend using a different set of
functions that explicitly uses SHA256 (or have a schema to support
future hashing functions). To ease the transition, we could add an
option to restorecon to trigger a migration from SHA1 to SHA256 (we
could potentially run this as a background thread after boot).

Thanks,
Thiebaud
