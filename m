Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D32DF134
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069186; cv=pass; b=M7WzLSO8737Y2CbfQ15pxOBj2cstSp8+zEc/hY4hNxc+ccJkpPp9ndsRQ39ATb7L94DypjIM77Ve0gLL9B4/QhRDIEgNa0ziSj7IVZ6JpvX0hlleuHTnkv803ttyDJAkrdEFlbt7jYPvZXWeLu4w+GZwrSyF17aWaXVQosw5mow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069186; c=relaxed/simple;
	bh=oDOPd9vZN321n844H9FITK45nSd+nl9Qwtq5z/aoWCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3BR9tJMVEHD13Y1kh0qJJC7mrnz9e5CO5xfLBZSWzi4Qs9jP5esNvLJqKAFiuz52oKB1qNm/RBCU0vJ+W4RJe4bzpGANdMC8qLUjEZxb9Fuxncno9vkG8QLkhlG+DclM/lqL1p5nEAaVTkZzZKtvsaBSdLPLBV36hE/eePOp/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ny5Eh8L2; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ny5Eh8L2"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f8b60e485so6004779b3a.0
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 08:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780069184; cv=none;
        d=google.com; s=arc-20240605;
        b=DHGyU+cBMMMPm7mMiEFnV2DjMh5pSHPj3MVdxh6uOohmKcK2GEPqk9UzPyXSNn3773
         0nUYIvxIgS5GXr3xBifZC8a7vSGwceJsuK6Vs2cH1TzzQ92IwtN84fYj8iDn8iVWQ8gd
         JUBFUzmnzGbaNJ4wetKVQMnBmIIjyVOAMvbHR4uhtvkgBLnmqV0zxxc8KQTo2tNNettb
         keq5RrzZR6zoKuc2RGHj6j2RhnDGqj6N6jVh0ZgKVa4SelWpi+iuUESnaQY86UuzUb1f
         IyBDgXlg00rSv/kI90VlWw7jiorU6KTdCfp8IN0nV7rkf2nrwKimFTVGmI/JSz3+eHq9
         mk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nIb/GwmU+y0EhXCbTieEdrNbvIsxoSpd8dmJJmG5Lk4=;
        fh=Il9nhNmOiBphgzttKmGdLyDEgkSa9hbh71Qb/m9llv4=;
        b=fS9dNRg4kJ87ULWhWDlUA0kre/0XTtmBZEwl+SVslEmP3CRPiYl0w+oB6Dq6uVZFYG
         Wr5T6WGnFZQ3NzROpukDjsHy4JjSPFFJRTyiCdh0ofQe4yGWTGnFimKVz0PI81F9L5eO
         Ea62JFtZUDHvxRcZOY1zrOoNbbcfjT13UvirFUF2nCO7z2qLwgKnf7CZn1vD+3XP2cUn
         7bwFiEY6itVcZdd1FtpqxvK85L3Kgba7xIilLFq0xOpzgptFkB7xyQqdeaSoPcC1IpSG
         q1G71mrEAKGUXHuAYVgpAuFJY+kk2sYFKk5St7UnF3bblMW9GaJWJhGoqLZg0xFytoNd
         1Cbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780069184; x=1780673984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIb/GwmU+y0EhXCbTieEdrNbvIsxoSpd8dmJJmG5Lk4=;
        b=Ny5Eh8L2i1VBwSBmv9ovVTv77s5MmYiUrbbn9Qlg6Pd04N08hBuQMBATlDU52NQDhO
         XhC43OQlw/b9JHvKXzAZoDCB4VlKXARrK9b+JuE0OzesXqk5esN+Ax/5IN0LdSGbLVMy
         /ktWcDrQwQTTzR+EizVEY+MpkOJifoK3DJKb7A/KeEqiGKlFerYHcb15VRl51fVRXh3q
         gbnz2ok47JuOQVpHhD+AB85ZCZmQezXwo5knaM251yBRewyGmphA07DmF4lxi4zUJcdb
         DMd/K9UFO5NcKWhpFVdv48PaGoKfAdc4y99kniJ7DgX77X52Y2zheXde4g4quEEs1k38
         9vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780069184; x=1780673984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIb/GwmU+y0EhXCbTieEdrNbvIsxoSpd8dmJJmG5Lk4=;
        b=BtUj+enqs3nlYsvMY9Zh30u7dEYKpeTN4iDAF95hjCuTwy7LhsFwP4qkNJcg99YbZ+
         jkNvWjiMTyMeQ0YS5G0YptBNLcTMBPpZ7eTQavVm/U3MH7cTDsWMIFXDukAdDBp5bMSf
         KV4EPJ0pex/orO+Rwpvg+kliKFaQrE4yuowRZhQYUI8z0nIIyLNVOVDGFMh8VulSbS2T
         EOpN6zDgOUWV0+2Z9mbnYSWp1+e7QDsWsMaCZ1LPLkbwXB5W76pKa7n7F9jNrIZ07LeE
         cdvShHzHq9ARcaCUI+GzcmqqeJJgsXeMrt5ydXZuCNocp1WB29WNnWwGhfo/bIs1k5yk
         97gw==
X-Forwarded-Encrypted: i=1; AFNElJ92QlTDVU5OX4brbIGd2IbNq7Gl0Ga9ePg+ZPeQ3oLZ/qPVm80STrEkV5hZ9lDSG+JChnnqp+3+@vger.kernel.org
X-Gm-Message-State: AOJu0YxCGVgSrbLxbjGe+dzf5nVi7G0q1WU4Y0S8J8SM2N4ZRKbgF0CY
	13Z6rgFXZQAJ3Rii5jntA0Z8+A8gCPeOnl/U0xbQLsNXlTAQqcTTGDYvpFq4nCirj7yfrSO6neb
	wESD3aXTX2B0z0dWdazoMhvp9SX3AqAbmB63ZWIbB
X-Gm-Gg: Acq92OHOoEMYFEhpyUdYnbK0CDcv60VqpnBlF/scKtKBzod4b9ZJhj6s+A89m7qEbXl
	RIzob0j7OFGQAb0Mu9pQiRsNMsHhU40MY+3qCaTWp9RBUlDPyp0kxVa4vuIAsG7DyFQwVyAL9US
	7/zQ3T8lEHR6tEQ1PCuRcoztKKV2AJ6YX4IkHHWCMLFBYh5SFcmUUZfDdxjs5FYvQ5Ze5gP8qKt
	IfsNpWNBPqw+Cdpcape/89spULrdhqnVE9csKSli6Jan5SamF2ZTj3NTC1iNjpolTgcUfq8LxgX
	34CITqeQx3/gxzZxoQ==
X-Received: by 2002:a05:6a00:2185:b0:838:af72:fb44 with SMTP id
 d2e1a72fcca58-8422532f1cfmr64099b3a.2.1780069184036; Fri, 29 May 2026
 08:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
 <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com> <CAEjxPJ7Y+9AqEVTJswUsan4OOP+DVkFG3vXukQVtcJZbVaoZnA@mail.gmail.com>
 <CAEjxPJ6DqhHKdjwC3ddZfUK4HVPwOTzb1Kkuabi5WmwmF8Lu_A@mail.gmail.com>
In-Reply-To: <CAEjxPJ6DqhHKdjwC3ddZfUK4HVPwOTzb1Kkuabi5WmwmF8Lu_A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 May 2026 11:39:32 -0400
X-Gm-Features: AVHnY4IzRc07289jCk2kgYhnu1tZXPLygS01KXfUrZO6SGSOP8SqZsviqJqaXDU
Message-ID: <CAHC9VhSEjSmdVgNxg=PvwS6RXnJzFybJtFhCJbOsKiRhXi5PJQ@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: Stephen Smalley <stephen.smalley.work@gmail.com>, rppt@kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, selinux@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Ritesh Harjani <riteshh@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 11:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, May 29, 2026 at 11:02=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, May 29, 2026 at 9:40=E2=80=AFAM Venkat Rao Bagalkote
> > <venkat88@linux.ibm.com> wrote:
> > >
> > >
> > > On 29/05/26 12:20 pm, Venkat Rao Bagalkote wrote:
> > > > Greetings!!!
> > > >
> > > > Kernel 7.1.0-rc5-next-20260528 crashes randomly on IBM Power11
> > > > hardware. Attached is the config file.
> > > >
> > > > **System:**
> > > > - Hardware: IBM 9080-HEX Power11, pSeries
> > > > - Broken: 7.1.0-rc5-next-20260528
> > > > - Config: 64K pages, Radix MMU
> > > >
> > > >
> > > > **Problem:**
> > > > Different crash at each reboot.
> > > >
> > > >
> > > > **Example Crash 1:**
> > > >
> > > > [    4.678016] BUG: Unable to handle kernel data access at
> > > > 0xbffffffefec10628
> > > > [    4.678112] NIP [c008000004e3c74c]
> > > > xfs_dir2_block_lookup_int+0xd4/0x300 [xfs]
> > > > [    4.678281] [c000000005eaf7d0] [c008000004e3c6d4]
> > > > xfs_dir2_block_lookup_int+0x5c/0x300 [xfs]
> > > > [    4.678363] [c000000005eaf850] [c008000004e3d56c]
> > > > xfs_dir2_block_lookup+0x44/0x1e0 [xfs]
> > > >
> > > >
> > > > **Example Crash 2:**
> > > >
> > > > [    6.327116] BUG: Unable to handle kernel data access at
> > > > 0x762f736563697695
> > > > [    6.327242] NIP [c00000000073cf34] __refill_obj_stock+0x74/0x2c0
> > > > [    6.327261] [c0000013ffdbfd10] [c0000000007418b8]
> > > > obj_cgroup_uncharge+0x48/0x70
> > > > [    6.327271] [c0000013ffdbfd50] [c00000000062fffc]
> > > > free_percpu.part.0+0x12c/0x630
> > > >
> > > >
> > >
> > > Git bisect is pointing to 54067bacb49c selinux: hooks: use __getname(=
)
> > > to allocate path buffer as the first bad commit.
> > >
> > >
> > > # git bisect good
> > > 54067bacb49caeada82b20b6bd706dca0cb99ffc is the first bad commit
> > > commit 54067bacb49caeada82b20b6bd706dca0cb99ffc
> > > Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Date:   Wed May 20 11:18:56 2026 +0300
> > >
> > >      selinux: hooks: use __getname() to allocate path buffer
> > >
> > >      selinux_genfs_get_sid() allocates memory for a path with
> > > __get_free_page()
> > >      although there is a dedicated helper for allocation of file path=
s:
> > >      __getname().
> > >
> > >      Replace __get_free_page() for allocation of a path buffer with
> > > __getname().
> > >
> > >      Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > >      Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > >   security/selinux/hooks.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)

...

> > > > If you happen to fix this, please add below tag.
> > > >
> > > > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >
> > IMHO that commit should be reverted:
> > __getname()/__putname() exist for a different purpose IIUC.
> > __getname() does a kmalloc(PATH_MAX...), whereas we are then calling
> > dentry_path_raw(..., PAGE_SIZE) immediately afterward.
> > This assumes that PATH_MAX =3D=3D PAGE_SIZE.
>
> Alternatively, I suppose we could just update the dentry_path_raw()
> call to also pass PATH_MAX, but
> I don't see why we want to use __getname/__putname() instead of just
> direct kmalloc/kfree here so
> the size of the buffer is immediately evident to the reader.

It's reverted, see the posting below:

https://lore.kernel.org/selinux/20260529153608.30853-2-paul@paul-moore.com

I think there is still value in using __getname()/__putname() here as
opposed to a simple kmalloc()/kfree() pairing, but either way we need
to adjust the buffer length in selinux_genfs_get_sid() accordingly to
use PATH_MAX instead of PAGE_SIZE.

--=20
paul-moore.com
