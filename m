Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6776374185
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889786; cv=pass; b=o9YCNc//bXGFL3fSSfK5bRETBPdD/v5dYizWb6F0Re3ry9gwHJE6XbXIqBKIpPdwxT9XyimVsQMmUHG7j84TarO880Wgt6p534fMjt3uDDIhT/RcVQVfDLm5qwyoubbuk8efjvMBa6gopuShwO5xeLwLzNYQRy9CWWoXa5M+R8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889786; c=relaxed/simple;
	bh=7+gpJ1XTqfyvqD906j489jah9H9uwbfvoMkXE6cDPuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBwIchdLAOzX96UQdPbTBIGJqKh13fpTob76wZg9y4fHzGav81XM7IO3sI0hwA8WR2JexVaBEgqhhy7bBJ1ZCpF35izKy0q775yad1CY1kijnXBTrb2HCvV3qgEpUa05V3ARKcXoJhMkRFk4A45uyaUf2zhhvcvVzSsPfqL2/tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYzJqxem; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYzJqxem"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso4814365a12.2
        for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 12:03:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769889783; cv=none;
        d=google.com; s=arc-20240605;
        b=ZHhztBe7ENk6Fyjy+AZ/P3LwjOz/LcFAoZYhF5M6Zy+RTJMoLACPqlG0VgA2JNKYhD
         tCW6LIgXc0HEev10TekEMLQr4QHluaPZXX61kW/UV1f0XxwSP9aEKJncnQGFnb5wv7r4
         dA59LS2ToMvGqDkER8r777G0zrRMli68ffERWVQxqkhvoDaFMD2zwyl9rP2wYDZSMpn+
         zYlfuFAMbawrV67dFA3X9qb+nj+er4Aq3y3PNcRoUxpsdy+KnuXwr0QrJTSIYd0tQ/nH
         ALq3YZMsHFrGQr8AfeBvhoJ0NTmheIwN58WW/d+j2M8xUfneVYm+dA8HvB8jSPcWDYMD
         czKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rL+Su5x/WeCqYgfxZztlYQTOnKf9OKjLga2LNBzR/Ds=;
        fh=vMDG9b21NtO5D95u1+XX9vQcIMcicMCbMiT4Tjl5XJI=;
        b=iWp9Bd38mbDSg5Tpyx5RXOqrPORw3pws/3kp9mrzQ9zt5KHpRS+LfSTcstF63ePT74
         /tUzYHcsIukWaJ0A5um2GJ+poVvI0MYsJXI/t01EjQM4HttYb4gqBPy3A4vJkHllkzZA
         5KP9wK+ER+FZbiyJIfoVElAm+gCu/VAM3k2Omk6FwXavILwkusC6vNX7fLv9GRJKf/di
         rkXScZcirPSM63dMq8RPVxvEfVCKT9TEkNN38+4rmRN7bpdptthi1YvqK4LnoEy5LPaT
         y83yP0i9HcRXMSXG1Z2R++pXnm41Pa3B2RD3ETI0NQj0jN8J+lfY88z39TJS8TCGXBAt
         MIhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769889783; x=1770494583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL+Su5x/WeCqYgfxZztlYQTOnKf9OKjLga2LNBzR/Ds=;
        b=PYzJqxem9DMMIyXjr6kDBzJA4f1VkGRq2eJQo1MONDujUpBCkPw8iqCtQs39ZHSlPr
         KH5ADf6dE9OyqMI2ZmGTgszJnIvMmkLnsX7xkpylovydPpDaEGHKBt5koaw5yavgDUCC
         SHlWFDwzGeM9rhJnkZNkQziRFQxSLQgqY1T3C/TmVdMwdQC1T2wCqRKpURfVM+4pGhqS
         mKCTDgd5mIaDOjOIuhc/TYz1Nkk8YH4+UUdbtg2md6YjUcw8WS1xBe8eLhIyXJrkQtZN
         CSGxRGms/hzqb0hzapxxk2ytjHBp8vS9Vl6hgP/eRe1a3HwMRfrD0uuF20eKhAvHn+7f
         Xilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889783; x=1770494583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rL+Su5x/WeCqYgfxZztlYQTOnKf9OKjLga2LNBzR/Ds=;
        b=tMWn1RJ21ul8symS2rYxfW9unLdjgs7MBqkt+g73XMfG4y4fFp7xhleNuB3IYsjtJR
         3eHSOpg6ZLLLvk3rVmi1xo7j14N3bheZkjhL3XttsPUSWarBJhpW1BgJTpNQOzxXvPbV
         CAAY2qB9gQLYBjs8orjHjpCMy8k+qiYgvwW2a1LdkiuOp3KlfLDB3Dxryg9sxm4h4/Km
         S6A6DJDsnh9N5ZQZs0HzIwum7brIP0VVDi/iKMcqP4Sx7zeNXku6nu/1yBmLaWLQC+Qj
         Wk640PESNIZSvRdJo+hh+qaTRYGwVGwqajbQAiBsuRxRBWZycc6NzgsMb3qup4TBU3CW
         qFuw==
X-Forwarded-Encrypted: i=1; AJvYcCUJKrjxi9AiICWGjdDlZ0YrF82tmGh1IUfC2xVRWfWwvJXtykvkkfCZrogRKzROZOMrFpBZWcnI@vger.kernel.org
X-Gm-Message-State: AOJu0YyHiLDI6HP1NbzEv2RXBdGBZzGO9EcNGe4ebXz7sAFKnag0yO9b
	M41zIM9HwuxbwDjL9i74medRmmyoLf7ql18gSkY5wH0ogVkJyOKO05g5zCKLY2/J6zxYLN9TvS/
	VE8/FsH5swXKfUdpc5e+E3Bfty2ksWHx11eORSoHj
X-Gm-Gg: AZuq6aKG1++u3cSs74w5s4OTznUIIxLPgFS3UeNGxFhYu96u9bGSMKEk+LIlkwwDdmL
	TAJePyVAyXI8hBcL6uYTTht404neM3vILUy/Q3IlEK9+tTHQl4c8kmLZo0kmFdDTHkM0+n+bz9L
	fremwFn6TClKjm4U11YeA59QYzbQsW08RlBK/AiB6DnTHsTmC0EDSCFnmCH4lMa6/WayiVWTFCh
	V2TE3aFKWIy4HLgUYF9kGfmaz/IJwUWEXd0FoKFt0ZMet75ti00GCHl0nCJ0F/T0EAl
X-Received: by 2002:a17:906:d555:b0:b87:2675:9eaa with SMTP id
 a640c23a62f3a-b8dff56a89dmr396045166b.15.1769889782950; Sat, 31 Jan 2026
 12:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com> <CAEiyvppoiL2EiSmVvNV3DEkr7wwyC1Fbwhm14h7Rfus4Z8uP7g@mail.gmail.com>
In-Reply-To: <CAEiyvppoiL2EiSmVvNV3DEkr7wwyC1Fbwhm14h7Rfus4Z8uP7g@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Sat, 31 Jan 2026 12:02:51 -0800
X-Gm-Features: AZwV_QhcEbOb_GQTelufeNwJJCU6MsAWKA6Gjz0fMmR9BpLj1Kmi7hMzQGebBBY
Message-ID: <CAG2KctoHRG+4J0ujC9162n-Ndgn3nKMu_s5jh0-c-B_P6EOk6Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, linux-usb@vger.kernel.org, paul@paul-moore.com, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 6:58=E2=80=AFAM Krishna Kurapati PSSNV
<krishna.kurapati@oss.qualcomm.com> wrote:
>
> On Fri, Jan 30, 2026 at 6:46=E2=80=AFAM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > On Thu, Jan 29, 2026 at 2:52=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> >
>
> [...]
>
> > I'm exploring a few other paths, but not having USB access makes
> > traditional tools a bit difficult. One thing I'm rechecking and is
> > worth mentioning is the lockdep below: it's been present for quite
> > some time now, but I'm not sure if it would have some undesired
> > interaction with your patch.
> >
> > [ BUG: Invalid wait context ]
> > 6.18.0-rc5-mainline-maybe-dirty-4k
> > -----------------------------
> > irq/360-dwc3/352 is trying to lock:
> > ffffff800792deb8 (&psy->extensions_sem){.+.+}-{3:3}, at:
> > __power_supply_set_property+0x40/0x180
> > other info that might help us debug this:
> > context-{4:4}
> > 1 lock held by irq/360-dwc3/352:
> >  #0: ffffff8017bb98f0 (&gi->spinlock){....}-{2:2}, at:
> > configfs_composite_suspend+0x28/0x68
> > Call trace:
> >  show_stack+0x18/0x28 (C)
> >  __dump_stack+0x28/0x3c
> >  dump_stack_lvl+0xac/0xf0
> >  dump_stack+0x18/0x3c
> >  __lock_acquire+0x794/0x2bec
> >  lock_acquire+0x148/0x2cc
> >  down_read+0x3c/0x194
> >  __power_supply_set_property+0x40/0x180
> >  power_supply_set_property+0x14/0x20
> >  dwc3_gadget_vbus_draw+0x8c/0xcc
> >  usb_gadget_vbus_draw+0x48/0x130
> >  composite_suspend+0xcc/0xe4
> >  configfs_composite_suspend+0x44/0x68
> >  dwc3_thread_interrupt+0x8f8/0xc88
> >  irq_thread_fn+0x48/0xa8
> >  irq_thread+0x150/0x31c
> >  kthread+0x150/0x280
> >  ret_from_fork+0x10/0x20
> >
>
> Hi Samuel,
>
>  Not sure if it helps, but Prashanth recently pushed a patch to
> address this vbus_draw kernel panic:
>  https://lore.kernel.org/all/20260129111403.3081730-1-prashanth.k@oss.qua=
lcomm.com/
>
>  Can you check if it fixes the above crash in vbus_draw.
>
> Regards,
> Krishna,

Tested above patch, and it didn't fix the device enumerating on
lsusb/ADB issue. Seems like usb dwc3 lockdep was a red herring.

I'll respond on that thread with what I'm observing.
