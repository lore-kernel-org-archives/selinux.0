Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0A23183C
	for <selinux@vger.kernel.org>; Sun,  2 Aug 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682009; cv=pass; b=mH9bWuKWVdtw5vYeJdPVRTCGohcl/61K6jZTfan6nP4puZNZ1fG9PPXWTj/GO6OF+dmzld3zLl2lB6TeuUqrtvdMUNeVhGEDr0tSpqQriNABWllQ6MXxW7gshrdyB4eYcDlIIs/3BTrnSkfskUI+I0Xl96EsPe5wXxUvTIkH9RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682009; c=relaxed/simple;
	bh=3unvZdJ58CLOkAcaen4xGd68kRpfBuVgdyrgLs/h+aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4OwTHnJ1kCingDNnbhC4k81pKyqhm0lTHBY49MnjVeetgGZzOWhhKe4VM7M3w5rVTtu3G4uJ7lCEdTAdZVzBdhN/rCT51zEm21aw4Kfqd7U9pJjmgZ5bj1B9YqQax/RzKPfPTro9QU8elL0+fQ208CUIXiszYmFGrCWs6XZOTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OHh8o+R/; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OHh8o+R/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf52d15d88so20475845ad.2
        for <selinux@vger.kernel.org>; Sun, 02 Aug 2026 07:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785682007; cv=none;
        d=google.com; s=arc-20260327;
        b=B2SL+xsbBRL0Zgsp8TeK2UpWkBDcdeAscTpcsJ4xk6qa5INAn1PteFDT1iZfkXUp5u
         SmKdqXLtOyQM1MvPeTeDlULyWlwxHJYCJ6sH3eXS2Rz55mhUrg3IeWFs0Z833YyRLVRB
         1TmC3RYd1YT/1sMtv9DyYqGgABZ9PJgdCmBzgPYkjzoX0ktauLEgj8DC8ZazfKLRvlp3
         wHFnM1bIUAZw9PbxHAt46IK11PtMGXawSXkauLcXG37B38voqGYlPPZxa6avxLbVqwF4
         M44+9uNVLRprcDBlburrJUbq2B3aKdOiKXRlmzAnyxEZ628TcB79/eFT+e4Hn5V2DwlW
         ac7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uVSDCq9XMkrzuk5PhsqP7Q4DHzK39AE8ZyylcX501n8=;
        fh=c32SGodCFBUFwsBClOKCVW+kY6vOe/Hdy/iSbErVqMM=;
        b=gda83nEH6RCxUcdMvznkZPT3VUDBDAcNeCWLrZ2/11sXVVyxNlguXTc9Yl3itUyk7S
         x9Ew3P5A3xFZ85/wGLNe6yM6fYAPsvK1AoOAZT28twuE6q4fg60aQKhRXZzJ55ji4Va3
         te9ALBM8nFrTALY9Be3kSX4Ftu2MR4NsWztP3lAQnNIEWZGry5vr7ewzCmJiJMkIWi5S
         dXrVifTqyuI160/9KvKvA1BL3dK60lbHWbgMZXYQ1isQreHqV8CQZqv6x8hoiAYw2owo
         34lpGG6Mf29iS4VcLQqDZTXUbToUeehsl3CH2mFH4UUepZHJdJH0PaCrLp/N+5ZXKGLH
         ICSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785682007; x=1786286807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uVSDCq9XMkrzuk5PhsqP7Q4DHzK39AE8ZyylcX501n8=;
        b=OHh8o+R/tCSle6ncNwe5Zl2ZTuRWkRzIVW5FRgDSu9sHRwcfWiw7vF3BdBCSpFujfQ
         iT6Q0XcNOPQB3QnTAA2NM0OjY2bob8+7mrMzP5QX0xUMkB6HheH18fW5MoiUvK+7OrBE
         L838tPiITkenCBRZ17LGUNM137tb5BQQiFgTagt+DXHI/y3TTENHznJK1bjVA8rf6wAv
         s3wLUbgloWCbz0Kz1ydBeXrzQnb2/LD4e7igtByLExt/fvjaBZk8Ch/zFrmu+NatX+2E
         GkQBz59t47FSYRIFEwDn9LBD66WAhJ2rHZPVJqw4wz6qd6ivtJ3WqRG3OTaWIMM590T1
         2YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785682007; x=1786286807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVSDCq9XMkrzuk5PhsqP7Q4DHzK39AE8ZyylcX501n8=;
        b=fUoCuZqIXjVMA5ZfPs8mwzXC0lIP9yu1fR00D1xfBdGLRsG+19SQ3Q/lUXb30j+446
         tQ+lN8Ttg3pY1EgUekqpNIWMfij6ShdIuOavbcfd9uj3p2F5T2VOEdwjD0C8zuVyTOFA
         yKZgwKnGLrnkhZOyhDWK72bxp0Ny6aq72r7dnpiGBi94FMdoAUy8dZgEuuXTzAplNm83
         ScyQeWfSTDENNy8uSVlKT8LUloCnq4g/b5SBnttsbBjNPyvZE0gkqz7Ptfqq57aaZ3O+
         K8R0vDk50lxeyeV/ccMCi8Fd7nRsA9cc90GjpYLNT/zzsqTJ+uzojXf6lErLWt+nkYbu
         132w==
X-Forwarded-Encrypted: i=1; AHgh+RqNF16gf2RYjPiG+ESQ4wvWWrLx4jXbJBRVzZhNKwFvazNTn+ys9Um7tPekrXio2wID2G4cm7Ed@vger.kernel.org
X-Gm-Message-State: AOJu0YyrpJvg1aVuR+vtq1eDxQvBLWOKny2J474V7QxhGjZGpgPKDD+p
	7CU/eVqUnRw3zh5P9JqZ32PmZb8GYP0XRRd7db8CMU3Xika0HrMg5UBGkhm/Qj00WZg+ZLwvwhV
	K4BVOWk2Gh1AteYh1pivZVgFiSCWEoGRwRisJwjfX
X-Gm-Gg: AR+sD10uJISdY6qJsKyyPXz+rZz0vUgkniTGmHSPLDFgZSrgxV5QKzKgD2O+N5bgRTq
	9SJ8c6qjhloDxAhONwNV3lXrFqbJ2QlqiCIMHlYCJy0kl4bDfkW1QgOwihgJhFB/6dEtcmOkOvf
	m8BRxTkgPSSUrI6Oc4jL0vs0kJ3pL5Iw70a4ymJQIT+s/5wWGgzZibNmdk3cFCORuObaPZ4RGPF
	wm4JQbGR9PoSCIf5sAUX7PYLYZ+Xz4nFa4PFiYYFMBabkLMVzHhnNY4un7U009zXksq5J+vo2E1
	0IjYe69VSYf6Rm76sk48/ZcNcYlalHGwR6vxMbqyqdbd
X-Received: by 2002:a17:903:390c:b0:2ca:ce92:6e44 with SMTP id
 d9443c01a7336-2d05218984fmr66046745ad.8.1785682007361; Sun, 02 Aug 2026
 07:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com> <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com> <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com> <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com> <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com> <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com> <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com> <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com> <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
 <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com>
In-Reply-To: <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 2 Aug 2026 10:46:37 -0400
X-Gm-Features: AUfX_mwc3J6rwxlFv-87GN8bK5jLLOa8tHA5WdDBfhjyivOgLNhWYBAg0rZ3uGM
Message-ID: <CAHC9VhQxeNJ1U_cUX=4mdJT17jG2ZFY27YM2CXK8wcuRPQYtrQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 7:11=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Fri, Jul 31, 2026 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > > On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> > > > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> > > >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > >> > <memxor@gmail.com> wrote:
> > > >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> > > >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwive=
di
> > > >> >> > <memxor@gmail.com> wrote:
> > > >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> > > >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dw=
ivedi
> > > >> >> >> > <memxor@gmail.com> wrote:
> > > >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> > > >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya=
 Dwivedi
> > > >> >> >> >> > <memxor@gmail.com> wrote:
> > > >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> > > >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Karti=
keya Dwivedi
> > > >> >> >> >> >> > <memxor@gmail.com> wrote:
> > > >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wro=
te:
> > > >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Ka=
rtikeya Dwivedi
> > > >> >> >> >> >> >> > <memxor@gmail.com> wrote:
> > > >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Winds=
or wrote:
> > > >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul =
Moore <paul@paul-moore.com> wrote:
> >
> > ...
> >
> > > As a consequence, everyone suffers because they first need to satisfy=
 your whims
> > > on how all code and kfuncs written thus far are wrong, and need to be=
 moved
> > > around ASAP, including the one being proposed.
> >
> > That's not a reasonble or truthful summary of things, I've only
> > requested that David locate his proposed kfunc in
> > security/bpf_lsm_kfuncs.c, I never suggested he move any others.
>
> Looking at what's left of the kfunc itself, it's basically nothing.
> Everything meaningful has been moved into security/ already.
>
> Aside from bpf dynptr ops, what's left is:
>
> if (!name__str)
>     return -EINVAL;
>
> if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX, sizeof(XATTR_BPF_LSM_SUFFIX)=
 - 1))
>     return -EPERM;
>
> if (!xattrs->xattrs)
>     return -EOPNOTSUPP;
>
> ... then a call to security_lsmxattr_add. Why not move this chunk into
> security_lsmxattr_add, and leave the remaining bits, which are pure
> bpf, in fs/ for now, and litigate the total placement of all of them
> once v7 lands?

Thanks David, but my comments and decision are based on the kfunc as a
whole, not necessarily how the work is divided between the kfunc and
the LSM hook it calls; shuffling bits of code between the two doesn't
change the character of the function.

--=20
paul-moore.com
