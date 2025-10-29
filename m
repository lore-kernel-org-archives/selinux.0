Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE327472
	for <selinux@vger.kernel.org>; Wed, 29 Oct 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696501; cv=none; b=WIanfDtu0gP8AbYWEQPtQlrA1lA8kh4rZiz62LgO4F2IzKt4lGB/yZcnDCXkmhQynsZdOqlCLK5QkVUhfeL+hKSAWnnm2uPYMZ/7gRSh6wi38EVdwL+DRfLU3D8zQYJcoELxBHNGDtQ0ADeABHO9krHgEHehzUKwE0wQ5bh++dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696501; c=relaxed/simple;
	bh=4+0VmKS7izmdzBSkGnuSr1zXLYq/caM1BpBnvQPHwUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRqDXAqPL4EYAW3QU+8nS3jY+4RK2I0oUiCb+J6ho8itbKNBMDC6u6tl0wOgmz66hJ06XEj7P+LiQrWUuTWJuRr6AKe0XhstpVDELPlxyac5ymswcyIX/MCiHW9gJHGZOKq4kzT9VvRKKqFv6mbSHup77ECBLHchM5hNvF128F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rm/tQAfY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rm/tQAfY"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so6443370a91.2
        for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 17:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761696499; x=1762301299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZjzJP5BDJixdHcjsD4MEtXcdIeCfYM/75TifkWeDww=;
        b=Rm/tQAfYDRv9P5gu7ha5CsCLxdHAVSufx4wPrLRv39Ao5X4Zd0nLl4WMq66DKWF21j
         pzblNcL+S7EmmehpeXxiCucHVp/gIxF+345p35vVv7k3j4S9XiyILrrjYNpDck8Nwjvf
         u0v4idUFcDSYLq+/hsZKpXYxYmCl3he69VZ7RAvIotMFQhDCV2Kqsptie1SrDLZP1AA0
         kxbVDhUun37cH9zNf8QuTePAzGTU4YKjhVH0cU+/jVfx/MbmEfEddQxZN+GQ58Zt0VjO
         DdJYJ6gKRYAwQ0SnbRvOZxH3etqOX762S1vBeYEBv174TLf5QcBHlHYWHsPxQFrzkq1d
         oq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696499; x=1762301299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZjzJP5BDJixdHcjsD4MEtXcdIeCfYM/75TifkWeDww=;
        b=Xz4g5TuQPtrkwiY/G0zhCLGo1/Zmakts0tvpY4ekqdh0571NTCln7UhN3tGp/LNhJO
         v7DqtmsMR9EeGH4PTuoztQuunQOgGpy47UMuMla3U1tThd7vKdiCaovjmApt6QyNS5XW
         GFv20wxIDZm8UdAq60RI32YOzrS1CXTq1Vc6ZuZ7+SQs3n6Dstc383tvS/RsST0jtVYm
         4gFY0y7Q0cNplsfcf1xJWjPUZqt0RKC1o32NF7jwI2UOolYJiNY2XFcSiTmLC3XnwFxl
         WIbj/CfbqxbSYXYF+aERgS1nm0z5nj+HAP4zeD+66vlM24wp2eDMcHMdwJhSzr3CJFWM
         /1XA==
X-Forwarded-Encrypted: i=1; AJvYcCW4kZ0LK/4S6mUgCcwD33lLKqwl+LKVyFYMgv3bS2hfwW26oaDXlJfEXbfSFxEqPQGPvmJTLI0+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfdp24O4iEXld5B/5EDp5wyvd60uo/DuD1bA2HaUs3Dr9/DpFG
	5TwM1ho+6aFbUUHcGtIgvJ24qrW2CniMD9yJrCWl4P/PdhrUvH4Bsp2maq6okRVNKZiuDERV59O
	/bJb0WtpaAPSrYjztaLpHwarw10d6kqjrzd4G0TQP
X-Gm-Gg: ASbGncuMAV/SPBOhAXj1G5Ig2gO1aC14gI9u6txRopztG2h89G3TYFAEXTcFFVuNsND
	ZRZHfujDFrrEIv6JKJSeyXuAfQ24HrfmlzbPshYRlmqx6Pb95Ety1SnxmWCYixj/Dp5lgIJa11g
	g+aKwl00sXrYOlt1pa2FMkrFgWpEC9HcRwXdpn3TwUmbj3RgCT80/j9fdoUYpzx97ZebU1twrGe
	f8z8hxz6gSKaVs5V0OSWfKDdvt4rGqQHJ/pefUkINi09vUgSuI8MkG2Nl/w
X-Google-Smtp-Source: AGHT+IGEKRPFq5L2rd6w/ubcuTn//BXhetf/wOj9xAOGHPjYYno+UXGan0WlvoJBaoZ1JF4tIK0SCxZjeiDlUqLjb6g=
X-Received: by 2002:a17:90b:4a05:b0:339:ef05:3575 with SMTP id
 98e67ed59e1d1-3403a294f2fmr971614a91.26.1761696498871; Tue, 28 Oct 2025
 17:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-34-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-34-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 20:08:07 -0400
X-Gm-Features: AWmQ_blBn2fdqYcxKi_H91_QLngZD09fAUzDyH5oMtRPekpRq9pqWMOuQKzGUHw
Message-ID: <CAHC9VhSeiK=qqLMUDAKRTgS5EEHdVvLD7-afuDqJWYFindvfUA@mail.gmail.com>
Subject: Re: [PATCH v2 33/50] selinuxfs: don't stash the dentry of /policy_capabilities
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Don't bother to store the dentry of /policy_capabilities - it belongs
> to invariant part of tree and we only use it to populate that directory,
> so there's no reason to keep it around afterwards.
>
> Same situation as with /avc, /ss, etc.  There are two directories that
> get replaced on policy load - /class and /booleans.  These we need to
> stash (and update the pointers on policy reload); /policy_capabilities
> is not in the same boat.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/selinux/selinuxfs.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
