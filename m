Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792487333;
	b=MzA142K644MUyuuM4kO8Mkp0TgKgEdCBKLktP/QbY+WYD7ZVrVhyQtp9tmulltZl0ETZ
	 3oJ/10rHibZHmzLQDMnOLP74j90XNu6zsj4TmG9yz2Xi2kx47vfqmfajdzoRpq1FVXpmJ
	 Hp+S9xHNxPGspEL+Hhnzqitl4OruJJncc8gH29Ec01gRisflzuuLc+/4BGOUamDdI/T/4
	 3R0vC9cHBIPWSkhvN1W/hf9FZ96QfTyCR4n1bgR9uOZHumQ40tIKlCRCmDCD0I0OgRTHk
	 YnHnvHz93p7AbJCRkcKZhdBXf/mHf13a/FRu4jSb4YaPxoH43vOAofIk5ITcK0gjzHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2jsmq3aefVWD4bDlitMgcEI82j+y3JmPm9P/TUSO9C4=;
	b=Q4UJJ3fngy8+94jgLFsGWiyx1yoG8L2oQ6ucPBhR2fM3GNgbDbQgOR/fVC7ihmlrEOW7
	 +4fZXqXOzWpXghbzexEBwf1y4auGrQKaMuXnacHWHuEmhxl6Z+2A5QiyA5R8X1ykuz03H
	 G3HKN1X5Dn2Wv3ldajbfbDRL+g6RhZmt40DmvGVCSOqswQU+uSArH8l6TiPFY0HzmO4oi
	 M9zr98rBQUwuXjjYf9O985+GK/AS6Vll30yYtTdO2txFuZuMeLHnkvaYHsLQuDvvQWbvj
	 0k8LAQHkpcmaStrUlgFuon3sk3Z0nIfmSE35I5YJ1KXujNDXKU8jDNkBGqALp9/oIew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rY+NfefQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A5606A31D
	for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 09:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C5A5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rY+NfefQ
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15354aa70e8so22093c88.1
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 02:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792487332; cv=none;
        d=google.com; s=arc-20260327;
        b=ZNA3YA/5f5dne24WjtYgoS9i0Qs/TUCwjQcUVY/xlHC/jTOUMIpO3xTJ4ORXGvolgm
         NoBtFTJALwCDlubqzkKBd+3mtGY+HvP8gGpZHFbkn1TfEDYlslHM2uVnm4WrsbLQEJmD
         OHjckZX65pf0FPdsJOTSYn10Iioomkuaxxi7EhOIqEb+XtbJcyVJ/9yfU0o3tYvVi5qT
         LAMXAP9qxoXNFPguQBYBcMf0Pq5rP9KSzWobzZWbbF2lz14hZ/iKAAPwaSITTHmXkwpo
         wGjeynKc6UbFwZIUQ8HcnIVdyhA/u4gr8dug7bnilooLQQJBxrfXTGK8lYMPkDCAb74h
         cCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2jsmq3aefVWD4bDlitMgcEI82j+y3JmPm9P/TUSO9C4=;
        fh=DOu3seTWHU2nS0/XI+437ZaaFdbIJOrG2jPEGYm/wO4=;
        b=KFRThf+IkVran7u01dDz9c/vCiCFOHZ6pox9GSyHGO6w9Hf8IRP78aoPmAGQzP7CId
         lXyO4gPMJ1tx6HB6XIHV0RvsT2UFeHKoXzU25xXbcrhNwndGQINgz80ojEUXYWyJE53K
         nhDrbGHAyL3ZRj+UDOk0JXrY15Tl/UTi1Nc4Qhn5liwPOLME8b1ukAe+G9FDMYLtBSuG
         Zl5W0ZcauyA4wCIy6qSpSTHEBD3DBS7ScV9j0tuWzR/fNr88qeWKsQxeYF/mkbWqS+Dt
         705R+DNC445pUOT47JzxnKmf5SVfKrsPklq0Z4RJVen+KOksHsfVy3btoq5wO63uch3j
         tu1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792487332; x=1793092132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2jsmq3aefVWD4bDlitMgcEI82j+y3JmPm9P/TUSO9C4=;
        b=rY+NfefQSJ0NRCtGt3BYbaaLjDNbYpa7EzunNzIPywzStk+qzhkLubqxEPKPA7Mbus
         aXDKvts0sa9KGiE7j6bgE5hwm33D8XzZ5EodT4rAQPqEgbKyAOkhnAOwoz+iixCyMb+/
         getHMXme2g5O1Wf2snXFjNEbF9c1wKp3/dQ/N+yZLysPIH4miWIQTmiHPH+PunOD63v0
         f0BCUT+brOM5yhAN77RrhgXBLVrQ6Cif9p3s1rjAI3qI90uFFNmUaXHsktNAtO8gTwhG
         X3s0YQS0IoheIWMT6FcltIPKEA4VSIuAMb1kCphMtk+21+VKuYqlcmJ0CUeI9JRp9Lsx
         abnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792487332; x=1793092132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2jsmq3aefVWD4bDlitMgcEI82j+y3JmPm9P/TUSO9C4=;
        b=C13qsKfQ8Cn48iZOAroCboN5iu0ztngKjFHnysdyt42hIS3dKFVQADg+7HvEC7YDO0
         DVkDtJfnImz1yG1/leA6cYPHSNnqeE5lQEDaIXo+SYaDWCv24QlvZIdLrGQKEgHhwcb/
         UZ+Wwm1MYj0it2RM7t+EHoYyEfjbYF44GpJdTc0xkcFDt/tG6KYbSg0e07578yZPhMei
         7S9zSt1NytgzEScdn2iwfI9qs2jibI7U1G547mXzg8SnWKcqqlXBCt7fsljOXBScGbEC
         qgD/XqQ8CslJ7UPnXILD2MlE4PNvc4WcmYuz6udoFSG6YttfFjormytuVpDbuhlO6jz1
         +AZQ==
X-Forwarded-Encrypted: i=1; AKwUvByD98YixjqZ3bOP93p6p8yMY1JAPlKuKdpyMJEQvjEcp1pTJCKsF+LQoeRSJD1ecX3Uty0dSIih@vger.kernel.org
X-Gm-Message-State: AFq9FYK4WP3B73thoi61rSeD8KKIHH67hZPAS2VPZJtdcMgGKTV5TVIM
	C89wNLbcgeXZtDN45mKXklQwwWPe6hozVtV5+d7tZbP7OqaqZgnzXjel8QP8+L1B2rZcQvDKEyL
	wbXxJ4vWlkY6ylq1KgoSJZrhXEqp2c4k=
X-Gm-Gg: AYBFou06GqFad33vtsqdx1OWM7mgQlzdVHTvf7/IaejOVMG4PRmDiNXl9k6NBsUJ5gQ
	vAdiradop8p8ln2qxjFhuNxyqA1mudWe2N0D5MhyYo0CEkJ6FW5Xmzpz/vmZpKgVmf1lb5uGFd/
	JGWp8SLBLxPd48reC+Gb0NCa3KSuIHgdvyj6m7WEJvjjLFYyR8M/x6k2iYYuDj935rRSQKURHQK
	asPizxCkKJYRm9TM84J9PLReICi/Rr4WwMsIqT1ME5yk4YqvYbSV+1PiJ6LF8/OqFYe875zryxA
	i3ISShkpUM3qHWEjumWW5toXI73+h2FmlCREBK/Eum6Z3FZTqc7Uq9TF4hkf8MSnikzlZLwlqgN
	Q5zTa7OITGg4duPSDb+OxNdzaqEGLsmNC5644cMCTvK3f+J3+kRJIzU0biNH+75AppArIy+B+fz
	+/f5bNt28/BSk=
X-Received: by 2002:a05:701b:450a:10b0:166:862b:9bcc with SMTP id
 a92af1059eb24-18512f1b124mr14638894c88.18.1792487331910; Tue, 20 Oct 2026
 02:08:51 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <71419b5cb9dc6c289ac7a64b9fe44a3b29bb5d56.camel@infradead.org> <CAEjxPJ4fydhRXZTxcbu+d-Gzw9qa-u65cqB2gD0Qs6TT++MrRg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4fydhRXZTxcbu+d-Gzw9qa-u65cqB2gD0Qs6TT++MrRg@mail.gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Tue, 20 Oct 2026 11:08:39 +0200
X-Gm-Features: AclHuK8XK9tGovS5ghMyn1Dz1rrOn80XMmYfNhphn9vyvlMPOWoJX4OsO2aHJJs
Message-ID: <CAAUqJDt-0ZHG8O0AwV0YuabyD+MvydcbwH=AZ1VxSL9APwgJGg@mail.gmail.com>
Subject: Re: [PATCH] tests/tun_tap: set an owner on the device for the relabel tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, selinux@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2026 at 19:14, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Oct 19, 2026 at 12:05=E2=80=AFPM David Woodhouse <dwmw2@infradead=
.org> wrote:
> >
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >
> > tun_relabel creates a persistent tun device with neither an owner nor
> > a group, then reattaches to it from a new context without
> > CAP_NET_ADMIN, exercising the tun_socket { relabelfrom relabelto }
> > checks. That reattach only works because the kernel permits anyone at
> > all to attach to an ownerless device.
> >
> > Kernel commit 3ca459eaba1b ("tun: fix group permission check") made
> > such an attach require CAP_NET_ADMIN, and all six relabel tests failed
> > with EPERM from the kernel's capability check before the LSM hooks
> > were reached. That commit was reverted in a70c7b3cbc06 ("tun: revert
> > fix group permission check"), but these tests should not depend on
> > which way the kernel resolves that question.
> >
> > Set an owner on the device before making it persistent. The reattach
> > is then permitted by the kernel's owner check either way, with no
> > capability required, and control reaches the LSM relabel checks that
> > these tests exist to exercise.
> >
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied in:
https://github.com/SELinuxProject/selinux-testsuite/commit/b2f894f0016b3ad6=
a991811bf8e69a4aa4bce4d1
