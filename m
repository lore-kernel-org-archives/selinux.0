Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE140360EC5
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528111; cv=pass; b=GnIn/l1RflzcVxzBpEqvatr4QTV4bxTn6eZt8ICup8gLo4cosUb/tPY1ZrPt/5Eduq+M52cwt4NqsR2z3NrVDXAeu6PVrpEsmy3LPOA8/Pb5wAF2H6UesxgOQmXgECu1812LssBRcxd3tm9U/NsGcGDLo42vuzEEt7cB05SUP98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528111; c=relaxed/simple;
	bh=gRRnmeN9RDyGdwkQ6hc2aJMVDCzCayRkvIQhFAXj1sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCAjUQsukJzwm6UOhN2emsZaOtMV8w1jpyQ+hbSxJx/xeJ5fjemrXXa/x1B37ZwHmI0/7rTEY/6b95DCm1TMx258gECX5gQtVZRu4FD3s4mlYuFlj+qzVlb0bSuLQl0nhS5abqtzQlQUioTtnjOwv6I9Q95KuQXXD31WUpm31Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aFwq9SN1; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aFwq9SN1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caced6038eso14240655ad.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 13:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785528109; cv=none;
        d=google.com; s=arc-20260327;
        b=DaL8Doqwvw8IXnqyFZDbES/JbtjaXbDAMijZWSrKF+6Lbyjz7CmAtTlGRXgIbWJJHG
         u1cy8qHwp/8PomP6EHCWQmi7DoIjsMAhZ4Tsg4ZSL+RNimGum8Viz1ZCpPlRvacesHZT
         EvVNt3WXXP5JtONsEDwLRRcifx244cB4xoqdiNIogw0P+L2OzddxPbY8iZHNxjnwcCng
         dLuHK7joBzPYIUDT6DPwx51BFJumLKFr2ij5LToU45atLjJ4PnQJ9dquGBjq1uYfpRKg
         zb+7qtR1l3GcjW7CmxkbcPJnCStkOkXwVesi+W1HLZ9mmpAcTbq0nBd9nI2taGj6YM9C
         hTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=90lqn9zwzwzuSyB92NhXiXKx6ZV128838nCa/C22sEw=;
        fh=wTBoW2Uab/v09+r5aQqcY/xjaHXt+1gDihiDn3qA/2U=;
        b=maducS6Va3QFEryQ/RLVjK4awzHmz/rpBi5cICrZtGdtzELW+EIpIoRdX1RJ1u8P6D
         Nk1D5VY4sFC6AfDV9nLM6CfLs3JquBhtJ2gPG+5Oflk9rT4vi+k7nNqyxHpQo5ol+pxB
         5dwpOi/pXhSzmW6w9toMSvLxUDDMJjEwzxxXh8WBXPbQi5QUi4vf1GNhIKG4nIIxk/cv
         GwQ1Fsy9EOFP8uE6eIt/TOlWwKNJGNSivEa3UsFvP3hauAtWmyntOhC+qantGt3Ng6YQ
         mAT+x7QMLN0w4NB959BJxK5VYYFqAOyJMnMpyuQFFGdxvG/Kstz8rfG+n0Umb7UX6Hl7
         2hXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785528109; x=1786132909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=90lqn9zwzwzuSyB92NhXiXKx6ZV128838nCa/C22sEw=;
        b=aFwq9SN1TWTwbejPl0nWEM/1wplBm+Yh5FhIAyE4/+nAbmIaPYXNI7PRJsLgWBUm8t
         HReBWKuTXOjAh9SkhHqbkL+aXJmEjY9HIHOWP12ghviZ8NhwyhOFHRQB+r/Zdo+NmahP
         fMl2sB5kJRsbkHE2u9/AWh/nogdgrwqsYE0u1D+9yOr60lZqUaPZq5uwH5dftSnsieCr
         odhDlS6y++A0BplPc2nXIgLYh0SCHDBpKvREvoCSNlE8U1MiuTyyzwl1KsNhF17C/6Lk
         NQSeHgOpCY55snfplNnMDJ+YtBTpIJYVlQ7UGyf/4s3NPamBQ7P0qnG44V8GzLDeuoWH
         sRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528109; x=1786132909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90lqn9zwzwzuSyB92NhXiXKx6ZV128838nCa/C22sEw=;
        b=iVStS7D5kcEGiUwHWjEvCibwrkqGK/AqxnvF52ywOriNqzbbjBnqeGRz4LQceboofP
         OrT9/C4k5KQJA3Ge0JQ4zqctzAzLZIpNmsasLe4o59pDRbl8d9Kbimipi2AbHmipYqHI
         ch0u8IVQWZYGCph+UB40fWn0FV/gZs0JrnlbNcAZtVRjIFAm9tOLpudrxmfovBiE4gnG
         HEjRUiX5R4/1JwoKliUXGcuucNktHLL6GlohUfXdhOL1uyVWvi3FHYIw7MJHl3xljQ5M
         32g6PK12nYKM6wiCn+ue9G39Eoa+WnIwG2pTniZi6Y1ZbIMCqXi8U1ofm+ASvKzOz+ZD
         N06g==
X-Forwarded-Encrypted: i=1; AHgh+RruSDRRyH+n6W5vkg5mGNf/MXug3YAyQrI8wM6XfKazIJ5KoS42oSoSvJHm6Hv3rkCmryAHGUxg@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXo7JcgjcjKas3rBDfD2yjSFArALRbML58cMBIXzSfNTT5T3Q
	HJZTmfrddYqlX0DUGqsiqrTQ5JLS1tjp5xlrtp804COZNtLZ9AJWzrUYbOHmFZwmm3yvp9d5R8T
	D5yvV0Ts+I7fXhMGjgWID5ShYwI3jvZ2GA6YsytJo
X-Gm-Gg: AR+sD10P8fyim5YIjY9wMxNOYR9H8glbMYvyynUJ8k5e4abc/OmhHGoFwmZelemH4UO
	orRuhEzKyKk/fApMET0QSdtFYn+6Z1XXk5+Yzd0W2QcjXBUFxORw6KiJcl+dMclVzZsR6J6ZICq
	qm0udqGdkytnT1LwqGrT8Rdi5M8+UOhsLdJxkjUKFjmvxSShiXyP4jGXDzJWSt5LNy1L+aJsloI
	E5MAhentEb6cD1p0yEgdEHlCsyioPxJQ6XbhtTnh+Be+6cB5gXpc6proztykn+0h+rnwRFzgiQY
	poOeqI/6j/KV9uBDN24FiUxVulCyOkU2oLnbvQDKIhbR
X-Received: by 2002:a17:903:388e:b0:2cc:fa13:dcab with SMTP id
 d9443c01a7336-2d0535b76a5mr7661595ad.8.1785528108976; Fri, 31 Jul 2026
 13:01:48 -0700 (PDT)
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
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
In-Reply-To: <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 16:01:36 -0400
X-Gm-Features: AUfX_mxEzGe35aVmPcS7WDk7t2BJZHhAOGYT9pJ9XPaYGcHRGyGSxkU5VCe6zxA
Message-ID: <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwive=
di
> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@p=
aul-moore.com> wrote:
> >> >
> >> > ...
> >> >
> >> >> Yes, I understand you feel it should be placed under security/. You=
 are entitled
> >> >> to your opinion.
> >> >>
> >> >> No, I do not think the newly added kfunc is a big enough layering v=
iolation such
> >> >> that we need to do it ASAP, disregarding everything else outlined a=
bove. I am
> >> >> sure you see that too. There are several other instances of similar=
 kfuncs.
> >> >>
> >> >> Therefore, please attempt to meet me halfway here.
> >> >
> >> > I'm happy to work with you, and/or anyone else, who wants to work on
> >> > finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.
> >>
> >> Right, and for that file to exist, you need to get everyone (FS, BPF f=
olks) to
> >> agree on whether placing all such kfuncs there makes sense. It is not =
for both
> >> of us to decide on our own. So let's revisit this whole topic once you=
've done
> >> that exercise.
> >
> > The kfunc that David has proposed must be located in
> > security/bpf_lsm_kfuncs.c, similar to the VFS kfuncs and
> > fs/bpf_fs_kfuncs.c.  If you read David's bpf_init_inode_xattr() kfunc
>
> Sigh.
>
> I now went and read the archives, and Christian already told you no befor=
e [0],
> which I missed in my first read. So two people whom this code affects alr=
eady
> objected to your proposal.

As mentioned previously, David's kfunc has nothing to do with the VFS.
Look at the code if you haven't already and you'll see what I mean.
The only relevance to the VFS is the fact that "inode" and "xattr" are
used in the name; David's currently proposed kfunc is an LSM kfunc,
not a VFS kfunc.

If you find yourself required to abide by Christian's comment, despite
this not being a VFS kfunc, that's fine, but this puts us at a
stalemate and David will need to find another approach for his work.

--=20
paul-moore.com
