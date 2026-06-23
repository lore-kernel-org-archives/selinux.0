Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F6E39E17E
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187335; cv=pass; b=GDaDD2+co3ODTwg+JKsRBBJAIKyw241kKtYWW18FBDgkq06II7BgNf9GJGtTte98Ug5UUzJomb7fCx30UanAwSVvFpX6sv2FLjPvllhat/N5BgAPaRTZ3e9gyOFNMtMDw6879DWYRlHUriX/LqBkDJT0OBYQuNzFXSzl83hlC+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187335; c=relaxed/simple;
	bh=F0wTGQkkGlxpSFeNyjD6eaC/VlWEy1Nj2KPYSgkBaLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ot2lxmZD50JRXXGizShRoYtWvutMPb6gIy5NwyHO6pMoQKknE3X358ITwzFj5ok9oKSuDaBqfIHTkQxbure3AsoAryzg+YI6cPA/k0gyqqY/MLozTQ0mREns28XGkdukmcsv7WOhdIYvrOKSx3e6vAWXxOAfFG9vSB4/N8vPSa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvfEHe85; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvfEHe85"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-519defad0d9so46435361cf.2
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 21:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782187328; cv=none;
        d=google.com; s=arc-20240605;
        b=k8WIJX8XDbKfwxBST3wWJMeCE1nIS7YkyLJHQnVWb8J6UhS30P7L8+f8fO0Xn7getp
         mUBZ3fhNoQba4fg/Twwgiyb+4AR6AkYEns121o2QOlJuFB8/VJvA7kGnsBUI2VWiyzZP
         dOuDI1f2SepyXSUglMuUtvVh6bG1ruUlrF89M+jQJHtLyjTn/IK+at6/8Z+ndAxmJFBT
         XR+wr+KrXLeOCxhdp5OuQmFkpNoN27BFRsgCM8D+m1MBujR+kZ2l4lH3MvCZFNZuKDTP
         EQyXeNBM+PZp/W3R34+nNoxDEy6nXDkeY8yOrt5+dsGWeATrIOmDgzclRXFD0TUjHZcO
         2wSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        fh=CpMqYK7hy6Fc/OF5Va66zHYzvggOgepwr8I3FUc8SKw=;
        b=B1c8jYX3jjsuq6ZksQsLl3A7QV48inlg7lirDb7Q0KoT/ZDyaJH9QceLGCzQ3HSrvV
         7x6rGJGPDhUC5pOBuY4GN2LGypDX5xafg0/wc5CM4IDY0LBK529yxZ9ZWw5IjKuFzi5V
         luqMrN+n8pthpbwco1dm+sOKwbRQSF5Rp1wmfP44p5Jn7aGKbhMyq4l11zEFaQHR5Zq0
         XQLnoZk4ZRAavP6sv5SD7kSVl+lJafhgFx7yOA9RhJsdvyQp9QmtGk2/JvfjxncEaKRW
         a9IEEhrp8ib5cRVESKftrQnxKKdW8PU7N8H9nLceDrqQ2Jy+G7yEALFPGa5G5VrURH8Y
         Hg2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782187328; x=1782792128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        b=kvfEHe85g9lUYBp4b+HBBNOtnEXPs2FhHtjfbueg3OXE/2zsiVDDCk5Sf2KOR1lxib
         zIoQxQiskpChFQyo21WNgATlA1ZTx/GP/aSDvLer8bGK1k/DXX2aghlwkYqQv2pFkyFz
         oked1raJu7gLr0qxR3h80MSU/LFbvjxaK41XdPy0f5iGOahOso5D6brjklO00daNIfq1
         gIxALTWLg3bznUVXFcT2ZVDOgIwpidNjrhE9Sc+zhNk1C8e6f6KiwIxKTskiB6kpTBMK
         w1nNx8ay0Yr5pDD5SIS7zDfDIGIW66P2uO5D9Xu05DDJK12HXpSTUlR+6N1r5JyQ9KZc
         sUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187328; x=1782792128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        b=gAWqEadE2zOhaYMPo7HMyJ0nuEhijjNocFJdKxO0nVxFso11GlkRUfwTNGJnnvYI6b
         fVGwv0K1FhJjjxOoyyha64tetyu0oyGor0VpMKo/QjHfWwPXdM4W0tl72cUtvu0xezEb
         5EpBcioNGsVoUT6tRqvHIJzzdxePtFkvSXZPmQOBXD5KCtJPLRKMen3h8L0pKGFntQ+D
         Arh99Pag3e+kgNzYyKeftK63PNIFFHt8RUyAy6fRYunWObis5UZlhjKZhP0u08/WovpK
         Cg9g3hkbX1+/qT4SycyzqW8+9DUefjOb3D2w0y0Sp10GIVUnSqAkXNDJOld7Pk8HaMiT
         YkRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+oEbAfUQgcuVM2R2LKjjKJKOuoxkf7JIz8b7Y+iCC94yeg/7iPw0NIQn1fsEQW3awItv0T6LjU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Nwj++/7TThWib9kv8prQhIkNpxvTg5LnBQHmE81dBLw/xk8H
	Yp1Ez6kBk78SSCs9KcuS7XavoLQ3aAUmTYaiQ4K2qMlTtMROtI/uBqTTq88sJ/5nAMyztbJp3u4
	0JianH202EpEbNfyvUTVrLB7iZcvBPHA=
X-Gm-Gg: AfdE7cm8+Dz9yPzNvwEHpExScnrt3mpSmJhGjU0GdjtW8jd826rLo6AzkLULJDLLLvu
	gBRM0qK6CB6CqwX151VBV2EogjQRRcO6JDWMY/HEP5u+zVtsJd3u9eaNIp807v6YRhIccZVesF3
	/HvoHj0bdssEkuHXvY5xB/GoDTq6uyD7cGiIwXG9Gl5pDbQdWncBZG8nz7ze7UvzNJk2+owzVZO
	8T1N/4z7Q3xb73MiZpmbIQWAhYrLTCZU89yRU3W2lAOcXlDppmbLkm3dkWBLNtjKhMCBbzylX9I
	JOLIhDvzvL8qUr5Bsm+30KAWMIq/zctsUVac4A==
X-Received: by 2002:a05:620a:4808:b0:915:e9c3:f1a0 with SMTP id
 af79cd13be357-9208f05c232mr2733502085a.12.1782187328229; Mon, 22 Jun 2026
 21:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com> <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
 <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
In-Reply-To: <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 23 Jun 2026 00:01:56 -0400
X-Gm-Features: AVVi8CdBJDCEtsjZ6Cr-k5RWu5qRO4rCaGhk6aOZoAtNJHl7U-y4zrw2gKO9F3E
Message-ID: <CAEXv5_jTxeTRdWpv71=6k_VTN4ZCes30xPs746Frw96fShfe4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>, selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 11:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> > > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > > index 1a721fc4bef5..b41b02173e24 100644
> > > > --- a/kernel/bpf/trampoline.c
> > > > +++ b/kernel/bpf/trampoline.c
> > > > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_t=
rampoline *tr,
> > > >       }
> > > >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> > > >               return -E2BIG;
> > > > +     if (node->link->prog->aux->attach_limit &&
> > > > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_li=
mit)
> > > > +             return -E2BIG;
> > >
> > > No need. The check inside kfunc is enough.
> > >
> >
> > Paul wanted this check because it occurs at bpf prog attach time,
> > whereas the one in the kfunc is at inode creation time.
>
> Sorry, we're not adding redundant code to the verifier.

Thanks, will send v4 soon.
