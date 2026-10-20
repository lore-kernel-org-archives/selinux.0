Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792488273;
	b=HiWAqgSfCJ84iqs0xzjRRy6h7slqvvpkHYdBR4hhadA8UFXyDq07vFI2WxPduznIODox
	 vXJjDJHhfLk8//hR12KWwe0rzimwreKexzrCNfe7eLev7rzvWtjn72FSMCGYQRloGoOsg
	 XcVs9Ie6ZOY2RDk8k/ggx8tmRUrBq/Vo60TMcy/Q66eQyHIsGT7FKKuIIi8ghfhHZZxOp
	 98bQwym8iUWZAVzbX+SDcrv/GZ7C46HIYF+aLEhjdyg8nXCajbLG6we/bezTEpq1CymS/
	 VaSBis0AIP0oxNVVwDBYk+sBdZLbX6iLhDzkc+NT9eF9PlupL9NTTj6IJ0lYLT/3mVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Iwgl8oQ5K8L9pT3sKlAx6LPcaTSPSfXlf0AhtaIEwaE=;
	b=Vh0TeRp5t85OtpsoBt8FenjHenOIJxyXDJ7lS9i5U6YHlRWndeK39medxLGKaUbdBfaj
	 nOPvIbwuPtHkm+bJ3bMh/GkV9uU1QfG+nz4hAlTMwraGbSv+TmrfKxDX8qLwC+6Td9EnR
	 mod+MPEc1VnttLWJdGZwI3SgpXid6VIWI7TSdE9/H5TUYrPhOpzckXxzjjt1pvph/WMCu
	 IqovnLpM3CFrbhXFW9MfN7+z0pZ1Cds7SDCpfTWh1fCwXJccBy+f5FqSFDcohrZ/AZXmN
	 gw7VJEFCz9UPhZpo/OnI2hPs5AREOa+nrJs0UVxn6VYvhIaTAi758F1HsCg/Nzk+fUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FliO3Hfy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640C60A263A
	for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 09:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9640C60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FliO3Hfy
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso7254368eec.1
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 02:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792488273; cv=none;
        d=google.com; s=arc-20260327;
        b=ien3M06hXD6z+1WlOkJWlyj8mrf0J3A5HzlJzWUcMzOoWsfQSswfGUadt7ovpnvGWi
         YU295OCBQNT8ggsOlyVXI1loDr5U66ZQJ98bw0ZVz0QJxg1hXoF9TtBQc8XaPcIbLh7M
         e5AfUNKS8uDs4JXucXVnZW3VmrVCVAuIMDY7YweKZplMm9kpwP5BrPJdS5uaYZiwnQsl
         2HAbYTlrlTJMsYxuIxGnv3O8gB9t+zFf0JknJ+poxNShe4AeS09Lr3r0ulUTkiBWabOc
         7D2WfaK/U7Ydt3TzxGkxEem/ywTuWz7rNqS47Tcs6RFKPSXTrufgN2O0xom0FT9cn3kL
         1mqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iwgl8oQ5K8L9pT3sKlAx6LPcaTSPSfXlf0AhtaIEwaE=;
        fh=3eImBoZARjQuUN1pu+W5Y7ExGSAVCZmCCZ+5eUEaZ5A=;
        b=RqwZngg2modp8PgLHmL7rYk3fqn21budZX1axwTkQ/BUyICdKZGQdpj8CTDMlprtCC
         U5NqVSZKR2uDrC9QondYYyujhymgxPLbFv8Trao3rCpj6qDHrOgX13A/1y0Buyo+BLu0
         UYGITdzUfdfDV2W/3EZVA1ueryfsY9J4xx10Js7v/Eiez4Pmxt2cj8qH8RHNzwdIt/AS
         d4AglfsSl6HbBobgyBzY6ujQjL2EvIEe3YWYwljU8yhgKdePWWw6kF5CVUjP9TXvhtRU
         RfT3YgygUrGold3z6JkuYZstN5hC+h3ZCpDniNAHGB1fRAKt4NoD1qtVwZVDUF/BmV+I
         Au3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488273; x=1793093073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iwgl8oQ5K8L9pT3sKlAx6LPcaTSPSfXlf0AhtaIEwaE=;
        b=FliO3HfyN4XLFfTl5kfd8wqdjKyygSzHDqDP3xBwrLpOK86m78ZWvCpPXhb1UxODdz
         27inJWSka3XyZU+5kCcXYuuUSO5fyDzvwMejIhKdGj4OQRK7wHWlvBExlAr6jlc5KQmB
         Zahv8qliGCmIAkbbpNmum45s0T2OWTt8k0+DoCTJaTorGEEcIgjnxMQrvPpeajcu7aJn
         GK1Hk34yK/Syl/HFYjQa9m4rTJI6BXvJvB7pIrumC+gYzEURNbeqhrp6VzYvA4O/BUpR
         faB7UNOk2SKSaYmnMTdDrlJL+hmPeM2i2RsInSULVeGhIARfZcwnUnhTdOugov2ASQot
         P9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488273; x=1793093073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iwgl8oQ5K8L9pT3sKlAx6LPcaTSPSfXlf0AhtaIEwaE=;
        b=fO9JFrq99aBRwAaTTaw3jB+AmjbrkyeMYRT2F6VfiDvza9uoS6FOIfZDDFOmJ7ccgW
         gjodQUvs23Q3nvTiG3djIoVtpFqWb8Y8rbeKtDfdakNhmaAYF/5kxz+sj93krkm5t1IA
         87GNwnInhkDdsby/LI1dkIm8nfRiBkL075kaomDSBx20WUoKcQkBQXcjkOwWcrwibig4
         MP+SqBytStJGYQS3a0NUN0szbB/oftL1blkrg+83TN+3i35LSZTn45VwpoiI56z0tAVI
         coOmwlIH+kxackTu/zoEBAJnup6zpIWopIIYNY6MvPfy+BEesZnXwTRePIVuktAkF//F
         0+hQ==
X-Forwarded-Encrypted: i=1; AKwUvByOPx6sRnm9qOgz7hs6w2jGuMeGAPtCHQbnLHsCmKzKYI0yz28s+YawnsN2G3jl9cMBqjJMPTBW@vger.kernel.org
X-Gm-Message-State: AFq9FYKyAY5VB6n0V7fo+Lc+iA02vZJFAzpGuNHGk20Se5uY++2LjtPA
	PY54FoLfjFpz86M1xpeQKo3AIRIdQ5zXHqDAfcKXfThVq7yno5v4ayhA5U/C9+lAh9nqt9WK+Ka
	JRkyIccOcCSyZgZLOSfjJSgZyLYh+NPk=
X-Gm-Gg: AYBFou1CVfjgMfLzxuOan7wPzrMrI6KNash0/k8Gi6YRboIAbql3kxDvfZ5pkASvWoe
	srBo0Xn6MYSo46U44Kt+B4pFftyrjy+gtSRaTpeWf6Q6sfFZD81r0gp+Mqqha7yxckO+moDF4iM
	ZlApEp0k2ap3O8jFtMUN3ijT4YUwR6XQ9i+bjLhpZeAO5U6gWb/Awd9tMV+lf3JnLYOpE0h0sMc
	Q6vzyOtObxOSl5DGuqfq5SmChG4VzgobPPgnnBJh9BI9Wv1puc1hjVFpBYO8UwTSliAa2iDng5p
	xFNL2GQwbE/oX/3s03a6iujRUIz0cvqbweyUGLHbq14Lq4wOJJAbZNhNMUxDoV7H73a+NOLqKUU
	oBL+AsGel
X-Received: by 2002:a05:7022:ea46:10b0:144:fb31:a597 with SMTP id
 a92af1059eb24-185150c9622mr14969915c88.47.1792488272389; Tue, 20 Oct 2026
 02:24:32 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179216341681.27711.14564271122957760636@gmail.com> <CAEjxPJ4A=3_Wx74deVjVNjt3NLK291BqR8v6X_DUXNJnVVkN0Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4A=3_Wx74deVjVNjt3NLK291BqR8v6X_DUXNJnVVkN0Q@mail.gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Tue, 20 Oct 2026 11:24:20 +0200
X-Gm-Features: AclHuK-s2GNCnyVUETxFr79-HbS9GBatvBSVkG5bOpabcMssuA0g3hqykq3waUo
Message-ID: <CAAUqJDvLLerV__ihp3AMtbrEuiOafTDs+FQC2S1RUs9zz1-q1g@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: test CALIPSO over the IPv6
 forwarding path
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Joas Antonio dos Santos <joasantonio108@gmail.com>, selinux@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 at 21:13, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Oct 16, 2026 at 11:10=E2=80=AFAM Joas Antonio dos Santos
> <joasantonio108@gmail.com> wrote:
> >
> > The existing CALIPSO tests only run over loopback, so the code that
> > rewrites the IPv6 header of forwarded packets (calipso_skbuff_delattr()
> > and calipso_skbuff_setattr(), called from selinux_ip_forward()) is not
> > covered.
> >
> > Add two subtests that build a client -- router -- server topology out
> > of network namespaces and send traffic through the router:
> >
> > - the client labels its packets with CALIPSO and the router, mapped to
> >   unlabeled, removes the option;
> > - the client sends unlabeled packets and the router adds a CALIPSO
> >   option.
> >
> > The first one catches the payload_len bug fixed by "calipso: update
> > payload_len when removing the CALIPSO option": without the fix the
> > server drops the forwarded packet as truncated (Ip6InTruncatedPkts).
> >
> > Commands inside the namespaces use nsenter(1) as "ip netns exec" and
> > "ip -n" remount /sys, which is denied when running as sysadm_t.  The
> > policy now allows unlabeled_t traffic on the generic interface and
> > node, needed for the unlabeled packets the router forwards.
> >
> > Tested on Fedora 44 (aarch64), as unconfined_t and sysadm_t:
> > - 6.19.10-300.fc44: the new removal subtest fails (udp, tcp, mptcp),
> >   the new addition subtest passes;
> > - 7.3-rc6 with the fix: all inet_socket and sctp tests pass.
> >
> > Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
>
> Agree that we may want this to be bracketed with a kvercmp guard to
> avoid breaking testing older kernels but otherwise:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

If we assume that the kernel fix eventually goes to stable kernels, I
don't think a version check is necessary. Tracking exactly which
kernels have the fix would be tedious and hard to keep in sync with
reality (esp. if we wanted to take various cherry-picked distro
kernels into account...), so I think it's better to leave that logic
out of selinux-testsuite (for backportable fixes, that is) and leave
it up to the users to work around if the fix is missing in the kernels
they are testing.

I would normally just wait with merging the testsuite patch until the
corresponding fix is merged and shipped at least in the Fedora kernels
we test in the CI, but otherwise I think a kvercmp guard is not
necessary here.
