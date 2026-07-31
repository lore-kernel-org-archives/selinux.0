Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF035C183
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521887; cv=none; b=WI8FkxixBwBjSw6ja9rBua17xnIkSqWHiaEzdxjPWUlqT85d/4X63zub3vrnPFvCqTxGi+ov+c6fEefc1G4S5M5aY6Yr0hn5VaXCcmZPnOCHVmusPz4ziZDu+hAyjKOTJguIUVKIconw4OSin2bJg2ESUOy7E9ZzzkeH4uBVVyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521887; c=relaxed/simple;
	bh=8g7KXe528qNP4LXN8HqY8b8J0ptgbH/4lXoqEsFZCQ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cIeFVpEELiCtccQbox613lha6QwHR0zT8jbE85cV2rZii3x+1nrP+MecXzAQbwpW03998OHcG1K3n3aKqaaPqhXUf3QxeQwZOSIleIAiHsYLN1X9haqyssw7BOY2gm5AZaZN91cKJEZ1ENXrQV12f+wBpy3K4hThUEoi22RYJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZsB/vvC; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZsB/vvC"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so350785f8f.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521884; x=1786126684; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NfTR8XppsBKdhupdPij7rDfGq57BVGWLklEXWleA36Q=;
        b=KZsB/vvCejDkWdB0KEZdr3hj2NOryJhOXJLbJJBOD8grenwokohrNJeJR9hxFK9PUf
         8CjY1PnT2qX8MDqhDlWQdgstN0QZCWgaZnwcBgqMPUinoqAcBLDu+JHNvolOaTgiEKe+
         TVDELCJqwkvHQt3QofXdChuvIQB9Z3TWnuSh+DtXvtN17iZusn/RkV/UQ6hLLOdOkDDE
         eQ5TYRMbCBAfUBTjkJKd40YlkGaVCqqGiEvCvYSegHzPUCCIaI+m1IS/IamQhRAyrZmK
         LHcWGwwZp8wV1RSuIaUr8X/28LZg7J90Lktwi6aQ3TTUTw8Rz2+xBOWgMMR8x4SRPhDQ
         AgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521884; x=1786126684;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfTR8XppsBKdhupdPij7rDfGq57BVGWLklEXWleA36Q=;
        b=sNlSrQumiKVGegl5hwpIpRxeTFmx9meuRqsv8QnXJWxT3N0kKj4Y7+NvfuU/ccHt6i
         /bGI+voeESgi+taLZjEVSyiBQxfbGZ08aWJ6b7fFmFq3yI/3Iz4BTsY3Efu7Z9Qz6Ir/
         8daQJRm+vlSTKvzN2/RjhD8OXrUydkY1GyI28ACY/55Lr64qornXLwaiWvTTCcnkXQi5
         MVUWKCCBpTRVKO+Yg0xTPyTsPDWVwSZeSOvvwFDWjNAo4igZQaXHkfGATP5+IC/I2jrA
         EKmo7EEHC+P6wU0DjzERKamP45bd/F4pPTwRyR5q6i6JJGmQIpiTSq0UmcU3/Bu6aBxG
         xP+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrKPcVefEHU+j0no5Ktskfaa/wify05QfaimwyisabvgiRoOXuim0akKz1BbvipBrmXqbDET8l0@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFl5mrrx3uHNDLA4lo0BFYPxm9GbVRXW+kBksArK/W1oyU5MR
	6tmgwp903dnSHppxsoOt7yFxCZnDODmACQxtB9zvKqVhURPzF68+li3j
X-Gm-Gg: AR+sD10ho/3isTognHuUcfiuzQbmI+NDhyxkTtwCBOnCTqYBub/H022cJT3BvjQ3M30
	zxM7jQp6dkBiwmHvKregZgaPAK2fcqzYQ5O0S3ExhnmUn218MO3NZNXLecPx0ykp7/MO/umopgB
	AZG7fVrEQceOlhNP4W2dZ0zJSAHTUqhYpxbMdX9a4aXIZ218H5xejBUaylDqypYC4aZ0Fwv4CKb
	0v2ZfEZ3ia7y/cw9jaPzQ2qYg/oANxjtr8VYSjg693kNrai/nO51nRUAM9kGAMlTTdbBQrbQALy
	8Wt+Wx6W2eDQtbaBjzpxXzkBeilVXusTFdgVyWmpXrF/yxQUojytcyPFFwfI+msw4l/1j2jWtRa
	8UB3HSvVObLuXMRaoehsAtL3eZ/ct0I1WArYT87N3wOtXdKQBwWp7YRucNEPapOffb+iNVC7Yfq
	96uIErenBaBrQU0crsUXoD5QeHGWRkhzVPTODm2BoSa0oQ4+NxOM44dm0m00EJX3R3DHhYLQ/5O
	NyJKpZZ5hpe/aG4HyeHuhJVlUvthRVhESnPmaovLQI+uF9joiesRnFrWKAfOt6l5/Yn9AGCXeqQ
	A9N3YCaZGqxG/5wpgJaQikbIi1Gtnfj5vDw2rg==
X-Received: by 2002:a5d:5f51:0:b0:475:f0f0:9ec8 with SMTP id ffacd0b85a97d-47fd7328eb4mr1388509f8f.51.1785521883948;
        Fri, 31 Jul 2026 11:18:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1abfsm7033628f8f.37.2026.07.31.11.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 20:18:03 +0200
Message-Id: <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Matt
 Bobrowski" <mattbobrowski@google.com>, "James Morris" <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, "Casey Schaufler"
 <casey@schaufler-ca.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
In-Reply-To: <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>

On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
>> > <memxor@gmail.com> wrote:
>> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moor=
e.com> wrote:
>> >> >>
>> >> >>
>> >> >> Okay, it looks like there was some confusion/misunderstanding.
>> >> >>
>> >> >> My understanding of Kumar's comments was that he was referring to =
the
>> >> >> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.=
c,
>> >> >> not necessarily the new kfunc you are proposing in this patchset.
>> >> >> Kumar is welcome to correct either one or both of us, if we read t=
hat
>> >> >> wrong :)
>> >> >>
>> >> >
>> >> > Yes, after another reading, that does appear to be the case =3D).
>> >> >
>> >> > We'll need v7 anyway to fix the ocfs-related UAF the bot found.
>> >> >
>> >>
>> >> Since there is confusion, let me clear it up.
>> >>
>> >> I meant it for all of them. I don't think it makes sense to keep this=
 one in
>> >> security/ when others are in fs/bpf_fs_kfuncs.c. That confusing limbo=
 state is
>> >> worse than just placing it where others already are.
>> >>
>> >> As I already said, the discussion around whether all of them they sho=
uld go in
>> >> security/ is orthogonal and should be done separately; it isn't produ=
ctive to
>> >> repeatedly bring it up in the context of this patch set.
>> >>
>> >> I honestly don't get the urgency; it will be a mechanical change if w=
e need to
>> >> make such changes. The worst outcome would be stalling David's work o=
ver it.
>> >>
>> >> As for landing this stuff, we can let Paul take the patches touching =
security/
>> >> and route the rest (3-4) through bpf-next after the merge window. We =
need them
>> >> to go through BPF CI anyway to ensure nothing breaks.
>> >
>> > Some existing LSM kfuncs are located in the wrong files.  I'm not
>> > suggesting that David needs to fix the existing problems, but there is
>> > no reason to keep making the same mistakes.  The new LSM kfunc must go
>> > in security/bpf_lsm_kfuncs.c; if that isn't acceptable to the BPF
>> > developers then David will need to find a new way that doesn't involve
>> > kfuncs.
>>
>> What "mistakes"? Really? It's just code organization bureaucracy. Callin=
g it a
>> mistake is just blowing things out of proportion.
>
>  :D
>
> You've no doubt seen the challenging interactions between some of the
> BPF and LSM developers over the past several years.  A recent BPF LSM
> bug/vulnerability as well as these interactions between the BPF/LSM
> devs, has caused me to take a much closer look at how things have been
> done regarding the BPF LSM and there are a number of things that
> should be addressed.  Not all of those things will be addressed now,
> but I won't support patches that continue to do things the wrong way
> because I currently have very little faith in our ability to correct
> them later.

I am not sure whether you shared whatever concerns you are talking about.  =
If
they are valid, we would be happy to engage and resolve them.

I am aware of the past discussions, but we did spend additional effort to f=
ind a
way that worked well for everyone in the end.

> I do hope that at some time in the future we can reach a
> point where there is more cooperation between the two communities, but
> given the recent difficulties over even the small things, we are not
> there yet.
>

I think it takes two hands to clap.

So far, I have tried to engage constructively, and offered to discuss where
these kfuncs collectively should stay in a separate discussion. Explained w=
hy it
cannot be done unilaterally, and that we need consensus from all stakeholde=
rs
(FS, BPF, LSM). Explained that we need to figure out how the testing strate=
gy
for such cross-cutting changes would work if they don't go through BPF tree=
.

In response, I have only seen you continually tried to derail the whole thi=
ng
over the location of the kfunc, threatening to not let it move forward.

Yes, I understand you feel it should be placed under security/. You are ent=
itled
to your opinion.

No, I do not think the newly added kfunc is a big enough layering violation=
 such
that we need to do it ASAP, disregarding everything else outlined above. I =
am
sure you see that too. There are several other instances of similar kfuncs.

Therefore, please attempt to meet me halfway here.

It is calling a single security_lsmxattr_add() kfunc cleanly abstracted and
already placed under security/, where it belongs.

>> I don't think you can simply decide this unilaterally either. Do you tak=
e full
>> responsibility that kfuncs going there won't introduce BPF side regressi=
ons? Who
>> makes sure patches touching the new location run through BPF CI? All of =
this
>> needs to be thought through before we decide upon anything.
>
> I would expect, and require, that patch submitters perform the
> necessary testing for the patches they submit; this is no different
> from any other patch today that is submitted for the LSM framework.

It doesn't scale. The amount of combinations (architectures x compilers x m=
odes)
that need to be tested for the BPF subsystem is beyond reasonable for any p=
atch
submitter to test themselves. The only realistic approach is letting it go
through BPF CI and exercising the full matrix on submission.

It is fairly apparent to me that you do not have a clear picture how BPF co=
de
gets tested (which is fine and understandable).

It only underscores my point: we need to move this discussion elsewhere, an=
d
have a broader dialogue and form consensus. Not litigate over it in this th=
read.

David spent considerable effort on this set, and has carefully reworked his=
 code
several times. Blocking his work over this terriotrial argument would be a =
loss
for everyone, including the users of the kernel.

Anyhow, I cannot stop you, but it would be unfortunate if you continue to d=
ouble
down, in that case we'll have to figure out other ways of moving things for=
ward.

> [...]
