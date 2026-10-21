Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592395;
	b=qYtgOFeVqMcK1FQAsFQvnMu4Qocl56/yTPIo0wbhPDQ0brac2zCyUPYecUe4SV6dfO3S
	 q1mJA1z8Fyh6ygb091RmI9r3d7CPcVyUCgJRX8dFy4GLJXioc3siG0NCOA9svBUzISLCs
	 YzeqCcvKwlLSqdrbaszg4qLoFhNnoth+wmCVLVV0WSVZrqLUlpm1+fmqKMclxfG6vHWYW
	 uajhVhF3oezvfYFRLwv0EoHrocgbZdmZBqtkv0Ktsuf0ZGBuDTDTtzrL8a2f15bXtBR5U
	 Y4aI7gNHH8HeT16j+uwpaV51jx3z2d/BccVSNk4I/Tcg+Q9dqnOfIl7B/bj+cLbhBgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BvftV8zWG4/uABpRve1okL9nX0afDvhMmqrVe2IKJXk=;
	b=HTMRirDdQj7kCfeoq5JGiyHb7eFdK3z+57WsT6W7YVDfDOPXBZ7s4jRVlXuDSaEWN7SG
	 75yGkXHy2cLD8mo8Q+DiyAYLcPP/Ta1tWohIgaU43tG/oTmaGte6msjfS6VdSCH/fX7i7
	 5yv6WwDPICGEorwPwDLOgy19AK7bN+SGsXuG7WkpHAZp0VcFy5t6Ssr8m7xd6m7IS2I4P
	 138jlbxcXkTa2wCzNMumuc0WegDS1j48x0CgaIfjN3bikqHcxEFBuTK8qODufsHgxb464
	 IU0MNcWPkDmn9bVveHloeAKuqwC19v1p0VIJ9vPsRqC9CV8J4eSyar2qu3lsh1x0KLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P3kU0X+j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25896606A31B
	for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 14:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25896606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P3kU0X+j
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67489c8202cso669658d50.3
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 07:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592394; cv=none;
        d=google.com; s=arc-20260327;
        b=qj9Irv1sbrlulnNs+N23Rew4ID54LUHgDtAAyxaIUXHQo5adm8kRnS5wb9eFc6AgrK
         G8bXPAdmGybXTOubzUoPNeHYXT65TQsKSYXtrYdyvtE/yZVVLZIH1w4ZobEaLCFmD8Ea
         X614i00fnGc773ypVsobHwHsIU3HBLqDGhxVptGT+y/o4/3hJpGeq0OxYQWkMCX0FIh9
         RwvTwRUMN+ps6Of7NV4A5D4LsamTKUCbfWHJMbmZSQkFTnbZRaqxG2Grm+kAzHhXsayS
         Gba8qSVHBYjUxdX8sgGXza0OVJTOquXGWEwT4PU4kC/YPonecpM3nGiUvGBkfjS27u0d
         p3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BvftV8zWG4/uABpRve1okL9nX0afDvhMmqrVe2IKJXk=;
        fh=Cro9iRu5VqBPimjvTrwob6mfxekVgzOEg8dgkpvRp8o=;
        b=B2XEOD6NOKjyAMED1hMqoIQrDhEoJYu7zxb5KrhQRaAQb4Fj8NZMrgEsBGUn410cPt
         f28we1JlMenGiSIMOQ9SZP5Qj0Qfct6RtVkFU9Mwi9Pm6Hd4K5vM7Un3RM8V1o8P1oZg
         JVvtd29ISIyvR+U5pyle4PLvhJ5EPinyO+qyD67ZCUaA+P/2WaX8qiYN5nd3ICJRWRy2
         LPO+6WNnQ7wAdY/H671BroW7CEjd0b6K8h5lhqozmBtk3whfgsddPH/Da5HZ67nLSc3f
         USPf3sV2+TfwA4RUEzkJv6KjF92wRPCoag1zyzXt1uyOQJr3B7RXwObhL/7mLGtAF9SK
         P3nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592394; x=1793197194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BvftV8zWG4/uABpRve1okL9nX0afDvhMmqrVe2IKJXk=;
        b=P3kU0X+j6vUUPcu5mRmOc1Jck20OYFz0DdLqJPxOUi+/O5kuPeqGEGim6harcn2IkA
         du5musS945lT4EkIGlNoDhfm9sEgKXNw4iXaDB65+C0MonMtYHxZUrTWLKLIydxRYARp
         HEeASvzOBdB5o7+/EreXAnBI8/zG3REQmut3orO/Vic8rxv3EQu0itbaL7Hy0m2ejGx1
         Dp9mRUDiwzMKilgqIh3/GIlbOiw1zdZhOlSR85KSoYB2hrj5sHhPk9WHnEEWUBh2K+JO
         5eO9nQ7UX3ljt4HVIXYhl02GP9oxeZoNmBzn/pWs5wRjx+ciEaHGunEWdE2YLVqYQ0bd
         hBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592394; x=1793197194;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BvftV8zWG4/uABpRve1okL9nX0afDvhMmqrVe2IKJXk=;
        b=IuJwfBYwlydg9la9RDZifK0jf97jPiAG443H/2ZrEO4XKA72hDzSSw2a+4gWquzS7/
         /qXq/xmrrkxR/9JzXiO3qFDmZmQvF56bVKNtcJyomiJO3mrGNB5bTyd3eHszXvT7hlik
         rweDYKta6KD2ejv1ucGfZmcfZNIr0DiQ/z5SAboVH0wrPNNs7+BaAW8RsiOh/ANEbZ1v
         C5d5fXVinTEffgW1kJ13w3qPxQsYmQDlvtawoic7WZIJibf2wNFzODmFgX6OZMyl/MAo
         wf5LF+5R/R2aebWYVroKJtvfKouEbgNNFKzuarO/9Arq0/W/L20z1WlSTKzh8pNU9Px8
         QHBA==
X-Forwarded-Encrypted: i=1; AKwUvBypriiprkMh4tZninZ8wusR34U6/Sx73bFTAzM6M9V/qAi54fWKQW256b9egyzj1MxqPCyFJjCf@vger.kernel.org
X-Gm-Message-State: AFq9FYIbieEBn7Venb9N0Qb19qPxnCVADCHHQOfbCO/5xJPtkVsaDOTr
	qUv9c6UEbEVauqv9v+NP6ngyBydNcrXTNrNLXBfe3gE/FYppvKQXASUMnc+pmQYTfPB+/njCGxy
	U+su20Enr9ugRJQ3wkEeBHYgJ1t6MvK0=
X-Gm-Gg: AYBFou0Xd/2AEKeK6K5zoyUgDIKoN1lD0RME1ad9aSKzu1T7uziAdqqfGp1TeVvJ3ZL
	qSNGNkP6cJV+j5JPBv7poejWit5K49QGX6L2lY01LxWl43RAnQFbXHS6TmUlMo/WAzVN3UZz/Zy
	Xx+KlUoLrxZ94x4D18JHrbDNhAp1xi4F23LWmKn+Sv6jPJ5xsZjv2WKHveTFjNOlLtegEEIOqbx
	V9gFgVkmZc2pVpya5Ps8a5dn2Ex9JCPPx6rhwd+ivllGHIw6/RZfn21eQB4/FIkdISUPRv5RZIR
	u1h+Zp6fXoJHrc/dSx9iyMEjjzLaaEKR4zz9X3SX20xn8DHrN+BYwb7pPKj6LRgb/BwHbhNZDGY
	q+H/war80ZHMZJzzOTEed0WIzT1HFSoasvPtj93M5+iCsVojViBipUCJ+Oeo/cZj/FLOgeW8Vdf
	4gGSFjDoGrpG0S/thclMIuSw==
X-Received: by 2002:a05:690e:b87:b0:679:b48d:4adc with SMTP id
 956f58d0204a3-67a0e584a57mr1057040d50.88.1792592393857; Wed, 21 Oct 2026
 07:19:53 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179216341681.27711.14564271122957760636@gmail.com>
 <CAEjxPJ4A=3_Wx74deVjVNjt3NLK291BqR8v6X_DUXNJnVVkN0Q@mail.gmail.com> <CAAUqJDvLLerV__ihp3AMtbrEuiOafTDs+FQC2S1RUs9zz1-q1g@mail.gmail.com>
In-Reply-To: <CAAUqJDvLLerV__ihp3AMtbrEuiOafTDs+FQC2S1RUs9zz1-q1g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 21 Oct 2026 10:19:42 -0400
X-Gm-Features: AclHuK8uQKiB1inpven9_hhOsxDQ2LF2er-4do1mhfpzQd582-8l0DpPOZyeRJ8
Message-ID: <CAEjxPJ6jVhOCFBrwREKZs2BvZAmTtFV=9mXK36b01-GwfZA+KQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: test CALIPSO over the IPv6
 forwarding path
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: Joas Antonio dos Santos <joasantonio108@gmail.com>, selinux@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 5:24=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> On Fri, 16 Oct 2026 at 21:13, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Oct 16, 2026 at 11:10=E2=80=AFAM Joas Antonio dos Santos
> > <joasantonio108@gmail.com> wrote:
> > >
> > > The existing CALIPSO tests only run over loopback, so the code that
> > > rewrites the IPv6 header of forwarded packets (calipso_skbuff_delattr=
()
> > > and calipso_skbuff_setattr(), called from selinux_ip_forward()) is no=
t
> > > covered.
> > >
> > > Add two subtests that build a client -- router -- server topology out
> > > of network namespaces and send traffic through the router:
> > >
> > > - the client labels its packets with CALIPSO and the router, mapped t=
o
> > >   unlabeled, removes the option;
> > > - the client sends unlabeled packets and the router adds a CALIPSO
> > >   option.
> > >
> > > The first one catches the payload_len bug fixed by "calipso: update
> > > payload_len when removing the CALIPSO option": without the fix the
> > > server drops the forwarded packet as truncated (Ip6InTruncatedPkts).
> > >
> > > Commands inside the namespaces use nsenter(1) as "ip netns exec" and
> > > "ip -n" remount /sys, which is denied when running as sysadm_t.  The
> > > policy now allows unlabeled_t traffic on the generic interface and
> > > node, needed for the unlabeled packets the router forwards.
> > >
> > > Tested on Fedora 44 (aarch64), as unconfined_t and sysadm_t:
> > > - 6.19.10-300.fc44: the new removal subtest fails (udp, tcp, mptcp),
> > >   the new addition subtest passes;
> > > - 7.3-rc6 with the fix: all inet_socket and sctp tests pass.
> > >
> > > Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> >
> > Agree that we may want this to be bracketed with a kvercmp guard to
> > avoid breaking testing older kernels but otherwise:
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> If we assume that the kernel fix eventually goes to stable kernels, I
> don't think a version check is necessary. Tracking exactly which
> kernels have the fix would be tedious and hard to keep in sync with
> reality (esp. if we wanted to take various cherry-picked distro
> kernels into account...), so I think it's better to leave that logic
> out of selinux-testsuite (for backportable fixes, that is) and leave
> it up to the users to work around if the fix is missing in the kernels
> they are testing.
>
> I would normally just wait with merging the testsuite patch until the
> corresponding fix is merged and shipped at least in the Fedora kernels
> we test in the CI, but otherwise I think a kvercmp guard is not
> necessary here.

That makes sense to me - feel free to merge it then once the fix has
gone upstream.
