Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6C2DCC13;
	Tue,  2 Sep 2025 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819208; cv=none; b=gUPsms73G1m0nHQqDHkzqBcgR3HLfir1bXfdnTS2Asrf+qJh0lWnjqt8J1qkPZkgFe6VKqxQ+OzwRXThNax4F2VYDO83snrg9+IuxnaCv2GGcy8wMtBgnBQEgqlM4E8A1jiOojHZuX9t4NwnVVtZ+2CLRrVWVPQj3yGwe5f3hQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819208; c=relaxed/simple;
	bh=K4l4mjDTpXPuFSVxGWhdojXADFvl7xOIu7taBBP0Q5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krZa+YJWlo8gbFfRfYOab00YDgnuHy/LRRuJ3iU00WvW0g3vpn+e8ROKvozu1qEObvStBkwl3k0bZlPt67R1OPYKBKwxal+7+hgRXdXAiQO8kd7ViOTnlxhB/znwxYjuncPV7jJE/aw88pZ639acL48I8qiBQoyOpetS5BEUlzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4kmI7pJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4kmI7pJ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-327aa47c928so4442597a91.3;
        Tue, 02 Sep 2025 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756819206; x=1757424006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQ3VtxgPqIjVYJknYVSwpAL4G7WyauLrFou64OSui7U=;
        b=Q4kmI7pJgHeDPJvOBwMwrl5SdpNUTIIOFX4aPfFWiq0lQYAJrGuNCNjbgIkol6yhKi
         6Y4qXGIA5S6gIVdS/sjjXRvRbkH7Bzov/Lry1kK2/QZjcMkLThvp1YJMGyfTijC2jUjM
         pXh652mQmDHHHnCcbS56Wp7qhPqv8szEs6gColQeXsq1FuzyICz0Qsapx53Hzo+Dxm0x
         M2TIWcaKQM13J8aJHyLEQ9ELsSA2NgF1myM9xa/ALZstR4ZWf9LVGwD6eIc3qC5PPXWB
         tLGisV+JbBr4DbK3JcOTSfagwcCVVcX59rc/RddTuqYk72hYarG5LByJtzd4fYizJq6b
         2W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819206; x=1757424006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQ3VtxgPqIjVYJknYVSwpAL4G7WyauLrFou64OSui7U=;
        b=opNeaAM+jKy3ftKejbq1HklUiiv7blr6VySx4X27XMLqjnVjLiQ2DLCdLOEl0eJrF4
         Na+DaH3UP9ta3ZdLX0c92vgExQ8Vw2q630XC9kAsb+GHP4FcaVqWZUaLTn2EcyUWKRa/
         xNn5J4XsDN7t/uF9sKHshPOsnb+hfV38IgZDyEmGZjUF/Z027CpvPHKoMqEIPGlaymMl
         KanHGAUmRDWh2e3J+6ke064mp+yLH8HAzcBQ8vg77t0sgBcF6ArrEgFhh+JrpzKmL1Zt
         b/J37jMiGTQJGHijPzgaX6wFdsFYLjjKIqh6Ccg+wxGHj4Ms1GGyoetawewL6UiSf7ZP
         rSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM5oJyjl8JkYZLGvQar03YpFjAKALU1V4dKFeVbT+eltCIa17JGa/QnvX++KpZ/YIvSog6Ik9J+bVRHxY=@vger.kernel.org, AJvYcCVUguJBVhieV3quShr3wu2zR8g4Z67nvTXBocaFsQRtiQxl2NN7TkKj2zVKwQ1Na8sYfEsrPHppww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/O8cWjGh9vxxupRmL7+flngMF7HxDq+fJ+qr5c0HV9XWdifpa
	zCPYtVbjYebFPLaR+SDUArSGf5fLv5PR4PeBoVqQMErZ1ACAazIfsze3bYvb4pCohq3d3XJ33X8
	9LKumGdtRdOa44B/0HRSF4NIxrbrqayw=
X-Gm-Gg: ASbGnctu2hwNQpIFAVh7nrmPbimNSULsVuTXRdPiimFkBygM/mg3DLc5QiD/6v2CEbx
	++JzCatdaHw1jbQOfhlk/qQb2/RasPkSH+chha7KRYe0PqnZN/wiX/z/ZaOMBUaPLFiWzHK6HAu
	uKqVJF+2fnDRrQ5rDM4gHIHdQ/K8gVe2bwzDhcHrWFqAMxH6h/onByCvX/COyI2URHc70UlSKjh
	9RUSLbRyEBbarJ4okAcxXJHZN5a
X-Google-Smtp-Source: AGHT+IHHntWNeb6307IeM+SI0zlh8EZ/o4DFwzv5FzECn4t5M558pYaWqyhZ8DpdAmPb1hEuATGnTdzfcm3dZ2CLfJQ=
X-Received: by 2002:a17:90b:3148:b0:327:5360:5b1a with SMTP id
 98e67ed59e1d1-3281570ba17mr17428904a91.37.1756819204596; Tue, 02 Sep 2025
 06:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
 <20250826205617.1032945-8-vishal.moola@gmail.com> <5ee2b684-94d9-40be-b01c-b0538ced33bc@redhat.com>
 <aK9Ogjn71JoOM3w3@fedora> <aLBthEcK1rDPQLrE@casper.infradead.org> <20250830074747-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250830074747-mutt-send-email-mst@kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Sep 2025 09:19:53 -0400
X-Gm-Features: Ac12FXzjdgirVSRxrRZeOJriOnHYQBVpd6gTvQBDolPhv7jSSxNDmD9GjD6pYDQ
Message-ID: <CAEjxPJ4YLoOG42QOdzHY=w_dExq9-et7su_WPOqzyDZDfGKJxA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] virtio_balloon: Stop calling page_address() in free_pages()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 7:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Aug 28, 2025 at 03:53:56PM +0100, Matthew Wilcox wrote:
> > On Wed, Aug 27, 2025 at 11:29:22AM -0700, Vishal Moola (Oracle) wrote:
> > > I imagine theres more of these lingering in the kernel, but theres so
> > > many callers and I only looked for the ones that were calling
> > > page_address() inline :(.
> >
> > There's only 841 callers of free_page() and free_pages()!
> >
> > It's a bit of a disease we have, to be honest,  Almost all of
> > them should be using kmalloc() instead.  To pick on one at random,
> > sel_read_bool() in security/selinux/selinuxfs.c is the implementation
> > of read() for some file in selinux.  All it's trying to do is output tw=
o
> > numbers, so it allocates an entire page of memory, prints two numbers
> > to it (while being VERY CAREFUL not to overflow the buffer!) and copies
> > the buffer to userspace.
> >
> > It should just use kmalloc.
>
> Why even kmalloc? Why not have a small array on stack?

Patch posted at
https://lore.kernel.org/selinux/20250902131107.13509-2-stephen.smalley.work=
@gmail.com/T/#u

>
> >  Oh, and it should avoid leaking the buffer
> > if security_get_bool_value() returns an error.
