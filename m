Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78E3B3C15
	for <selinux@vger.kernel.org>; Sun,  2 Aug 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682215; cv=pass; b=HGatbcbYL9Vm9w58eiz8JT+LLa6HgSKda7/Im1aRHaRXh70BlgR7vyzRbFYpfbYPaXmpKbzzvs98bua2F7XLvk8U6aZBnAkD6S2uqiooJfJnK2fKmu07qM0dhBOiACzah2znPK49Sffzr2jB8POFxyXB6qMzILLmWJQQ4Qlr0PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682215; c=relaxed/simple;
	bh=7kkcp+wOorntAb3DNadH0Q8Sg1yGSgKiD+TONbs7qUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plBvqhWutP3LSs0v+wpCKGnM08QrCgBFEbkLBygKYFTODsSPgeJZCR/KXSTMjAzetqebbNIPdnYB2C0M1deRkBuOpEEZ++wGgkZZnR92QeAMGK4IZmHBQUPX2JzQsl72GAmQ2rgzwxCV7xW+nH060EuhTNHX9qiHPeAwMQ8e/0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d3TmUEmD; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d3TmUEmD"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848643382fcso2253224b3a.1
        for <selinux@vger.kernel.org>; Sun, 02 Aug 2026 07:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785682213; cv=none;
        d=google.com; s=arc-20260327;
        b=NHc8IiHTf3yIrQzljF8N0Wrjm0H7wWd7wPL2yMcttxmUMFWjXER/BLz34cBClLtuRd
         bVO4oldJiNIHF5ies7XX1/lsKW5VCK1uq0QCWyqX9JHaNuyTSaThZBYBSCgQEJMHX1Z8
         FKsa3LIsaELroFzPIj3QivWd1DS4VQjygxx/L3Yzoomx0E5f2dQoZaAF0eZwNzI5CMBA
         FKsoEkpe8TynE/1MI/N7C+sbuObvvnF1YLB2FkuJZ44raDTegUhz2YTPwJBQkKnGSiPd
         0fOBjo1fK0LH62UGGzGe11n8ZBS4BsruAuuZFt8pi56Zii/6R1QLi6ylWDLxIHyfF8Iq
         qeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OmgWl/f4uXW4AQpzfCn2lxP5muAJ5BUlRpvNvDKBVgs=;
        fh=9+iiMwg2UOFdDcHvfCx7vEzmVotscG3Mf9Kl7RDjg6w=;
        b=boy3cholMgyGxQliBhbwEnvhNu2AeKq9fNyt/FDIwqoS9D2uiEOSEPKO3S+KHL9wPv
         4S6ntZUKS5yvuZZHixN2s3L8DIBOoIX7RrkMchygNkV45l9NOl/+Fs+BB6QH4LVNEGcf
         1FtSajAir4vD13Zn/9WpXHDEsUxac//myqUB7hhPdVMV3PpnBEEmQuW7sl3qLCbh0Ray
         odNpNLkr9Al85ZAcfERhGGDYKkU7Eb39i5UZw+m/cgFPuF8/l5ZJcU2VA9Ipw/1lXat+
         /BUqC5AE7tl79sSjWE2pCMZdAWYWRhrxvhwU+9546wWplhspXZvphmnfd/17e3HfYVhD
         i6yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785682213; x=1786287013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OmgWl/f4uXW4AQpzfCn2lxP5muAJ5BUlRpvNvDKBVgs=;
        b=d3TmUEmDewxJT2GJJ7flVa7AXI99c0jYB/Vci5U63n3USKpC5+LDvLpUnz4on+ypxi
         a/iyVr7JUa0NIzulDnSprmnZdyTmouYpUiDDFC5wel/7jkvzaPLhR46rOzF/X9RAu6AT
         1g1BZaRSKENCDMGTi7RlE1Xu++pjSkF0+9myK99aZTDszaTD7vn9SH4p5xWpeUJ0kzcu
         ln9n1Ye7sIwrY0SUdzj58jQBwZbVu9ffhcJeJlsjiJCt6oKF0Nmoz7uMUf9iOQRkl6Kf
         abDInXlm5RnSjfJ3IH5DV0+J4Z8YI317/4LJ1/KC3fEioyR0GHlcv+b8ZtLGH36/6mqk
         cf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785682213; x=1786287013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmgWl/f4uXW4AQpzfCn2lxP5muAJ5BUlRpvNvDKBVgs=;
        b=De12qYmTYeMYviIwvNWLnNw1cK3ZZr5eUnZ/IUGQU0A/PbedRWRBpUsyv7/PBXj84i
         DQNlrZzDNlJ/LZbDKTcvVA71YRNknQe9lJI8dpAWm+vc2xputup1bzeIZHKdNAubOift
         nR9s870jH+rbOEtYRuDpzral6ulqc9tHyrx6RgU0YAAK5OG/AJMXRngO2DCGxicFGuPm
         kohCL0yGMQOxgMzxFK/1yrPXDRJPIySmQ7NtItj7IGkJDBMr+nn0Gl3LPu6SqVVjww4Q
         dQk8ECGFNEKnrVpJhc6XsJZCeWTe81X4LQujZqRhd93YsyKfagvilsfPjxufbyBjzq/4
         tNYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBhGBkiHY87Gq77PD/29y0oEYXHczPz3KfLf85JgtES+Zu7tE1FgqBNSw0uxWdVSyPuzfA8gMV@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZlVYglLi/c5BsNHuTXseTbtDWpxW/tpT3Ox6cD5m1b6Aj63+
	UwRPAFVlgmyLTBU+yzLRBY9zyt+dHD0onF3/XgCVw6KO3UKC4+BomU+dow+Qh4IDACHw9S+J2pi
	n+fHKxD9ulEmb+8ssZ4Gytz7yU/bjk59vbTLn0Up/
X-Gm-Gg: AR+sD12P8hZEPuaVxDV/nfs9f9r9mrai5tqsBISbCoA69ZNGDo1wjFP6P5Z7V7rVriZ
	6tcaOEES37imo6gkFSu5+fnz0zUc/hV76lMa1xSJayGXAegjvHNawBSRuT8EyEsn5boCFFH4G3x
	2Pzypg3GnD8I4sw/s6uGZV0jWAGSKCbzt6fhfaQFApiejgBZFbz8ZXHWQMuZO9tAQdsopIIhk2j
	wWc9gfGgUpDRDGXMgwtjbTho7N16W0E6RvyLvvlOxMfbahE3fj2lEFYPmodKgHadIgC+DpRgzNn
	++EU/IdlZ7iz+jHEjGbB2oqa2bftG5iTR3ZLXC4kVKaS
X-Received: by 2002:a05:6a00:9289:b0:848:6c1c:17c0 with SMTP id
 d2e1a72fcca58-84ee47c7dbbmr6238656b3a.19.1785682213526; Sun, 02 Aug 2026
 07:50:13 -0700 (PDT)
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
 <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com> <CAHC9VhQxeNJ1U_cUX=4mdJT17jG2ZFY27YM2CXK8wcuRPQYtrQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQxeNJ1U_cUX=4mdJT17jG2ZFY27YM2CXK8wcuRPQYtrQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 2 Aug 2026 10:50:03 -0400
X-Gm-Features: AUfX_myOurolkOWbQTM-uf1kAESEJT0FADttjcAMdHsh5yOJTC09VeSrydmRClc
Message-ID: <CAHC9VhSRbwLD_yxEPKx38X59KcjZWKPQj2QnGupP4NFC6zu66A@mail.gmail.com>
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

On Sun, Aug 2, 2026 at 10:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Jul 31, 2026 at 7:11=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> > On Fri, Jul 31, 2026 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > > On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> > > > > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> > > > >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwived=
i
> > > > >> > <memxor@gmail.com> wrote:
> > > > >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> > > > >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwi=
vedi
> > > > >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> > > > >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya =
Dwivedi
> > > > >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> > > > >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartike=
ya Dwivedi
> > > > >> >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrot=
e:
> > > > >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kar=
tikeya Dwivedi
> > > > >> >> >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore w=
rote:
> > > > >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar =
Kartikeya Dwivedi
> > > > >> >> >> >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Win=
dsor wrote:
> > > > >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Pau=
l Moore <paul@paul-moore.com> wrote:
> > >
> > > ...
> > >
> > > > As a consequence, everyone suffers because they first need to satis=
fy your whims
> > > > on how all code and kfuncs written thus far are wrong, and need to =
be moved
> > > > around ASAP, including the one being proposed.
> > >
> > > That's not a reasonble or truthful summary of things, I've only
> > > requested that David locate his proposed kfunc in
> > > security/bpf_lsm_kfuncs.c, I never suggested he move any others.
> >
> > Looking at what's left of the kfunc itself, it's basically nothing.
> > Everything meaningful has been moved into security/ already.
> >
> > Aside from bpf dynptr ops, what's left is:
> >
> > if (!name__str)
> >     return -EINVAL;
> >
> > if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX, sizeof(XATTR_BPF_LSM_SUFFI=
X) - 1))
> >     return -EPERM;
> >
> > if (!xattrs->xattrs)
> >     return -EOPNOTSUPP;
> >
> > ... then a call to security_lsmxattr_add. Why not move this chunk into
> > security_lsmxattr_add, and leave the remaining bits, which are pure
> > bpf, in fs/ for now, and litigate the total placement of all of them
> > once v7 lands?
>
> Thanks David, but my comments and decision are based on the kfunc as a
> whole, not necessarily how the work is divided between the kfunc and
> the LSM hook it calls; shuffling bits of code between the two doesn't
> change the character of the function.

To be clear, this means I would still need to see the proposed kfunc
in security/bpf_lsm_kfuncs.c to be deemed acceptable.  Also to be
clear, I'm not suggesting, or even requiring, that you move any of the
other existing kfuncs in your patchset; I never suggested that as a
requirement for your work.

--=20
paul-moore.com
