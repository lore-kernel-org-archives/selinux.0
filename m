Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B63449990
	for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593434; cv=pass; b=oZeqNuTVMOLCiZ8sqH1o9+k3IZmBnZOmPJjTBWW5BVOKDYtL9UaGz6BrcrLGka61RJl5Bm5Zof3yXfof4mPkk6A4HwQ7NKPPtBKul3Xov8oqfOQ/N18BqatZKA1XR2CH6Br5dBnYrU6U5gorbZ9PI2gKMfG+HgERog3tlTWjHHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593434; c=relaxed/simple;
	bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEkEgDSKlCrkv22V+TlrQotoPcAAJGvcu6z4WBYHsb9RACWGOyS34mNjtaDukfKqmxrnOBlnzxnCPLI1BVBs3XsQ4FZt9dj0O8ce1S7HsCxULt59DhLboDSTyRCkdZWVcjQVm/6dB16V9FXxQXQPZZBYQMXU3dmMurgcSQbIqfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joZGmF9X; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joZGmF9X"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d3b440b97aso11945ad.1
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 10:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787593421; cv=none;
        d=google.com; s=arc-20260327;
        b=PF9f8NfM4sm5FUAiLRtqcMCqv676T5mUotwktKlrDhxKYoxzGqmtqKlLSkmKKyGHiF
         Zpjs8QOCZYMhWW7+pHfxx+VZP7OIDdZhrFQqCx7x0NqcC/EZj5zvETKaO4Du1mtjJCvb
         X4B3y92WnhfniAsxpOTLO/cHvfN2lAhiLKP6pu+d94PN64OByYGsnp2Ig7y1VR+VmDUd
         9MO7A30WUOMqfg6QGT21zaMKxzTM4QRWcJ33MQ+aNiolAwkSL+wAl1qThyC10taoZyJz
         u4+CNeMaD4/gfWgJRZ5qIhSt8rE6/U/NQWQuk4Rl0h3zuxsOWUDthlSHdIoCnlyhBTZN
         rv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
        fh=hKqFxC4TUS8VErTmE9GQ5YCXax4PtyheZVkgR6cigqA=;
        b=sUedbxAiEOlRxKL3RHMt8VmXJoTQcvIrHzovDzKz+OFoDdzUvOshPkTNlNHZfkvEtx
         oZROTnFgNdn2pOM3cT+EhcyiZQFjS3AQor8o1nnvjFbCWgwSTnPbfZOImOUaYY+BT0oz
         apTc4MKq1d0g5S5g2691a3DUYw6+LhzFa0QX3nKypiXhtxEcwXdcufuMgpJBO/DGj1PT
         JlXRMVKip5SKFvx0HmvG93IcxwWasBIr6pnWgN8caXCjL6F4HaxWjkD6m+DKfxIw/X/x
         civzQ+u7okNE1vgHrocukPFYAK6FD32vkCq+rOwRjAyL7nzyl+U2nqxa9Rm7NYS5bkSy
         9meQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787593421; x=1788198221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
        b=joZGmF9X6QfJaxTMYXhYEZbMLmkmqBAN5EA9bvW1v2ezu+L7IG0imX76Og0W8AlQDG
         wxlHIHdWM/jAMnQR/mz1grjzyptG06p3gTwRGj0+TB7NT2N/3LbXMVI/WQ243ARLaKJ0
         0K+okMPpuESFoJEeI32SlJatbsXciGmOz4Ga37nTBlyT6sXwR14HiXbMsxP9HShtylEZ
         rdbU69YJONyM2PBRJHaKDbQRH5wgpyo3eAuN5tore3hNychk0/UvXALRWpaYVXubgS3J
         hz+zHXtTcuU646DtzWJXfpEymJji2evbjAy9J3jLfrxf8NCZV/ZwDu5mu3wmJ+BPWCac
         d/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593421; x=1788198221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
        b=al3r0BSRbVzuuTJE2nXB5ocT5rty0am/nDtfPf9UMwSeTErUD6m56Bt1E4djCfPxXf
         VjKSLy5SEjCtcQllYTFAeFkwKBUxqNNUo2ZnfngKbA0YnDp8TM2azQ6w4IM3lAJRE25W
         VvfPM1U18ptPbhJi0/P5S8OEEBOhScmeIfB7YGQSO+WKRYxUE3QjjsVtGN9Qr9SvfAD+
         wQnc7DJ8HAU+BN/vOuJUUnhFuVUG5VXwoyx4ASio9+nmej+Wu5Ms/u90TiPyXLBM7n9I
         RKEz08+XyCWOPPdr8BqNQdSNzt3cPNGb+vCwoi/Zmhh4zcP7y2mRcbagv/3qJPfzR2tq
         h9og==
X-Forwarded-Encrypted: i=1; AHgh+RqX4B9rfI1MCWjwlb1phXkDm+7lXyY09UR/EkXINBYMB8tt4R+8TmLiweb+pMu1YDo4grE96jXP@vger.kernel.org
X-Gm-Message-State: AFuF++nvFpAg7S/3A7h8Yj3GapwV6h8w/rPUN9NWCjm5L+2We4v5B5y9
	l09zVFPhnZD7ABABWOyL+rpFFyO5aHOTWI4+0zA7DFCfrcDt1cuzaZxQu80kWYoGMhK3EyFIyD/
	007vU5kYIq42kg8WuS/BdTDcNuDfYCPDBigem/7Ti
X-Gm-Gg: AR+sD10zUn0JNQJvThaHaAldKovVYnfWY2eDZOdpmOaCIR+z92oINuESIJzS+VjiF+R
	VhtJsEOiB2igxPjrxGGvz3tkOHnXKKvYcpQFttxf+HS8Nc17yXGLs9H0cL/99FkENaTSdGjtGFB
	DeuTTWikP15ojbklghe4dXKF4cLN6URljmM2OL3xJRUyQDTZKdHAb2G8YnSHo0gfJN5Ia+4WZyA
	SPiH7ITqd6Ce4VwYvR2JvRFPRUK97EZkgUVX4xqGPMkF0D/Erpy62+Q52uD0H5HJBT2POAfKbsB
	mJB49hEiHUZXEbSzArwawul7iGOpT6eSCkqZLJFirV8EEB8qKjJW2XW7IdR6ozvZ0fXw8YM2UEt
	WMHP/znlcI59IyDXaJaaPXGB6TCUaqDQ=
X-Received: by 2002:a17:902:d592:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2d673b9e9f2mr11726905ad.9.1787593420034; Mon, 24 Aug 2026
 10:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org> <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin> <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
 <aox7tVIQBMuz-xFO@gremlin>
In-Reply-To: <aox7tVIQBMuz-xFO@gremlin>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Aug 2026 19:43:02 +0200
X-Gm-Features: AcwNN1XNlUaHE0KSmD27zjyuJQAPDoj5SG3PPI6IvJrIGr992XerqXx0rzodOY0
Message-ID: <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 7:33=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> > On Fri, Aug 21, 2026 at 8:52=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > > The sharing a /proc/mem fd seems like that's a pretty dumb thing to d=
o in
> > > general :) but I guess you have to protect against that.
> >
> > Yeah, it's a kinda weird thing to do...
>
> Yup :)) but I guess we have to account for people doing weird stuff...
>
> In this case (I do mention it in a reply elsewhere I think) it does seem
> like perhaps you should separately check for current->mm !=3D mm of (what=
 was
> originally /proc/self/mm)?

I wouldn't want to do it for this access check, since that could lead
to "confused deputy" problems.

> Or at least it seems like a crazy thing to be able to get full access to
> another process's memory (that it... gave you though).
>
> Anyway perhaps overthinking it :)

Hm, yes, though I guess that is kind of orthogonal.

For what it's worth, SELinux can prevent such things happening across
domain boundaries - it enforces that, in the SELinux ruleset, the
process calling read()/write() on an FD is granted FILE__READ /
FILE__WRITE permission to the file's inode.
