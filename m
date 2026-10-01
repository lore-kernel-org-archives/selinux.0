Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AA26982C
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790884295; cv=pass; b=Kl22w8myq5/SyiM17e1qvJjHfZcOFMKJOWzSswHLCHWRp6r0IpOEA2/iURoKDjXQVwZ1xlzJqRuNqUo6tGaOCm5b9a05CoSVGBwKs3d1j/k7GvDCJyugYonTUhLVNY53l7wRDwo/iB68GuI5VBSgNUHngu9Hju9fo7F7TzR5CJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790884295; c=relaxed/simple;
	bh=OP3XDSSWU/VdeN62K8ogioLxVjAMnOT2KuU9KWDv1Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSu+yWqxONuHvMEsii9puBLYb1AsRVCgZx5+Sl9+fi9DDOCeZvOr0l68vlj+9uAFNiihaQ+W/4UO0mmuvPCeJFe+hsuGegOHKzU0iBbR7kryya5OFdYJPoUQ2oXesUfcqgJ4NRmk74ysMX9CNbjyJpgeAhqln2o+/T9NCNK7C1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9tbsySg; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9tbsySg"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab20f4bso7594981d50.0
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2026 12:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790884293; cv=none;
        d=google.com; s=arc-20260327;
        b=hXai/kG/uZ1DzEtf5V7p3TyUJZChdxPurb5DYvbF3m+RQ4RdDc+1l+qvJlAjrpFrat
         P4cPuK1BeSXNZa4vKx3veKIs07QuRiY28XmvZD13b47McOrSFFNeKCfahEXna0N4nWGX
         r7kcbaYpfQh6q+LJ2hvC0udqDezfkHaWU7lqfWOKhzo4PxGnHW3GB9CGJptbAINYOdP5
         5y6+vjXIlkeBqJXRjwmaDLnu7vC/DLhrf8GUdDUJ1xgD6NP8DmlHStME5SSBNHUWvZof
         NzwXoAEmdG8ImFcW5eJeaylPBbVkiShFmOFrnXny47j/aabu8xBZlLyVZ7moTwAZpyKZ
         zJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8J/w0j4NwnvWjg6O3ihJHH2Vq6gocuQpI6bXmVCoQqY=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=e07EJtCDN3ChC3ltFzPNEZ9wv8NV+By42L/irE1iKu8cEG2bwf8NiijIk9LbxQvzer
         5D0ZIb6WrgZ+B2rr6p9EQufGyZcXbb3bACvDZV7GNLe5vGLf2eNw+yjJImiZ3FyFh58Z
         FVHGVGeOqiIzElOGSrjiVF/PcHumbta80uDeAEzgNJr/IJ62uxHyRxhm5JrmQT7w6fHK
         0ZC6EtcsLAZSh3287bbj0GZLOPEsPnUDgk61f7IeoPsFRRkCVl1q6vsFTFQZkNgKRwi+
         S+ajTljj7uYyX2Ae5vz2AGEkipg5q3g+X0KFFp57cND0Ffga4k3wRb9trpBagr0ms39r
         Svkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790884293; x=1791489093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8J/w0j4NwnvWjg6O3ihJHH2Vq6gocuQpI6bXmVCoQqY=;
        b=l9tbsySgVkQxRYqgBQrZspv+bj6PlUiRDGYBCXTM6+UQqaShy6KRjhNKMEIOJg2pQf
         L4GiwM/ZrIyk26j+bNB93eg+ANlp5i20q0O8HJTP4q91oDAxHhCWya0n6DTmNHD9wwTr
         8VPIEYufnRCGNUf4MD9cksXhljiscPRBJoAB5xav5m9BeMgzkycv+UcweVrZmfuUF7K4
         P5Zl78lcuyb/3ES+F6qHsoa8wMmujaeBmPb1hLQcbkhFmVscusT7CxacTzXfZuEw4ooO
         JdHy57SYW1P1RFMOjKV9EtWikjKAWuUKgWfdDo77tZ5F1rZ+uU9Lehsxad1rLqDfeHXs
         sTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790884293; x=1791489093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8J/w0j4NwnvWjg6O3ihJHH2Vq6gocuQpI6bXmVCoQqY=;
        b=ryRxknLd2Qdt8zjuNnCEj3cYiVXkYKtSwSbj4z+YNBIPOmche0yBV8YFLQljakp9Vz
         Po0z8qn4aKXUFaLvx4eJPW4V2P1pURE/GG5w9T8wqS5gIk6f151mdY4TVJFOLZKSAxj4
         quyyIVPUyd3LRgXEUPrRt0efxIyT3RGtdAc90xCJSVuqISPBC7ZpmtcvlvgLtsgGbY3o
         YVtpDmtio8vYl3l+f8tbjygIPWYQOnlme2L/wexZ7tf+gDMroBCA09bygS9+5ZYRYmod
         dhLBAFNl7eErM2XrRcV0IrpRJ9D4eJilLcrBPOrH77RCpeB3p3QGjlum+8n7gqFRk766
         8QuA==
X-Gm-Message-State: AFq9FYJAzR0Jsr0DHNkHim5tA46M9RwARacj3CkCq+s4HLxehZFXSuJP
	LoGqyrqu6jdp+4yDqlan545sTd8nsuHz5PjRMA0JUxfVO35OVujHEavWQwtu/AjBt1Zp5TIWD7U
	7pqt84I+L4v/nikUNAGWcpdexQUe7UoE=
X-Gm-Gg: AYBFou0FCxD5q1rM8UhNIAG3gkZ+Ztz+la/7rrpXyTGfHRUiv+iKVklHgJfemZirKG1
	PhsQZzWB0YfHZDyBWX++uoNQ6iYFnyO92CdhsifQmltn4O4bSFPo3pQGdcO4jPFWwW6nsYwHPyX
	WCZzK0g/WhWjou8OKO0kUlE+csbEBj0FAM4J6OZpCIS1m/nMaQHf6x3pGVAofaZLGImX7Tt9Ygr
	DH/q3qBbgO759kM9w8trk9O1fsES99CfrKgJ8sb3y52cAaOpjRUnonTPP7Jt9xx1uNXkhmJHYaS
	eShW6GWhgAKwYdKMcmWhnHhoc2KvH10Z/JFwPIspyxKPzAr7b0tYdtc=
X-Received: by 2002:a05:690e:4363:b0:676:948b:1bec with SMTP id
 956f58d0204a3-677ac0fb705mr146603d50.102.1790884292760; Thu, 01 Oct 2026
 12:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
 <20260928155753.2259807-21-cgoettsche@seltendoof.de> <CAEjxPJ5BYBkugQAvZD8FzUidGV8tA5zv7WG-EQsTEhk0F3L=WQ@mail.gmail.com>
 <CAEjxPJ7Uw15KjHkv=RuX1OdZWq9Sax_d=jX2TG0RsfsFsuSiqQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Uw15KjHkv=RuX1OdZWq9Sax_d=jX2TG0RsfsFsuSiqQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Oct 2026 15:51:21 -0400
X-Gm-Features: AclHuK9-jR2rDRpfx5l_iBOh-IlbdpNXQRw3XwjmsjPmcGnc4_wLns4nolpSoSU
Message-ID: <CAEjxPJ5APz1eEDHDDo4DuOvKrjfZMHYh=hvQ-Z3_p5FB4aopiQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] policy: allow io_uring allowed in the io_uring
 test domains
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 12:20=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 29, 2026 at 11:14=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Sep 29, 2026 at 11:10=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Since Linux 6.15, io_uring_setup(2) is subject to the SELinux
> > > io_uring allowed permission, checked on the calling domain against
> > > itself (kernel commit c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM ho=
oks
> > > for io_uring_setup()")).  Policies that define this permission, e.g.
> > > Reference Policy since commit d4084b9fa ("Add new kernel security cla=
ss
> > > memfd_file and new kernel permissions"), do not grant it to the io_ur=
ing
> > > test domains, which only get the minimal testsuite domain rules.
> > >
> > > io_uring_queue_init_params() then fails with EACCES, so the positive
> > > io_uring tests fail and the negative ones pass without ever reaching =
the
> > > check they are meant to exercise:
> > >
> > >   avc:  denied  { allowed } for  pid=3D3493 comm=3D"iouring"
> > >     scontext=3Dunconfined_u:unconfined_r:test_io_uring_t:s0-s0:c0.c10=
23
> > >     tcontext=3Dunconfined_u:unconfined_r:test_io_uring_t:s0-s0:c0.c10=
23
> > >     tclass=3Dio_uring permissive=3D0
> > >
> > > Grant the permission in the common io_uring test domain definition if
> > > the policy defines it.
> > >
> > > Assisted-by: Claude:claude-opus-5-5
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > I shouldn't have to re-ack the patches that didn't change. Please
> > carry my Acks forward in the future for unchanged (or even trivial
> > changes like updated patch description or comments or other
> > non-functional changes) patches.
>
> FTR,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

I merged the subset of this series that I acked, along with a couple
of fixes squashed in for code formatting (./tools/check-syntax -f) and
some slight tweaking of the patch description.
