Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F73128D7
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785530929; cv=pass; b=gPCP1Oz4A/Hk9OhjQLlcKSJfyEAtTOlzgHA+8bEfF10Ox24mgC125v9rHSfEK5OM6KyWzWdH+tR96/DEFqwluh/hHawtgpiV5nbGw0VYAoJgcrESU/4Lc4PqNtEJ2TY2Q5MhNS45Moa1sq+JOK3D/nqf003bC2fb888CVKqtUzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785530929; c=relaxed/simple;
	bh=M8VnBEn1fzw+IBCpYk4jT3YhvULPCFsyVr4mz7NayKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP2UHttTggVn0N9QHUUMOdoN2ERzcpK7P2ldkgoGMDBug3ZXphtf47l6YhPXgp+FbxRadsqOZJHkCJilDd9Nj7b/TAjWY6USGrg1CjyEotWezytbzDkXr6xs1aGROubOygvuAPWfPm1C3NvrZ3FCfL5+eHlE3J3mleHYQPSonJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LdHFbH20; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LdHFbH20"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e7109321dso886034a91.3
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 13:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785530927; cv=none;
        d=google.com; s=arc-20260327;
        b=FCGDe4aruLst7Vf1FIege4e2EG8AaHZddd1I9E1M81aqZSsKeZBa1hxqxKFi2MXTD6
         fIS/F/1kqSiGAsAhdYUitlQ6QCzZHmqdHtUd1ajXVIwluYINrla0fuoWQJmlltaah2WV
         2D3PEEfJxFZ00D2BzDw47jt2c1DPkFu5HppSiJu21/lDBSQDBtVEq5mMijoxR7ywp096
         sxm78XgM8XWo4inbg41/z+kQdOL0Qu4/12UOAF3fqLV3eOfZIN4Ql4Hq45rEzOrJMjCq
         OgbN7Mk4GbYghjzn9dBFIdaTEcwDIe088r8j7FPfEKK6uTR8DZepFevhdY0nf9G209KU
         xv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n99Y4TVdVLwkrmbFc6xvkbJUkFajn56eSscgelJgGwE=;
        fh=BD2zslqYzgUaiWpRIpB8juRVKXwqYmUfmEe+zhtFSGk=;
        b=QDDEc/Y7LlPlbvcYe9gb+p4zOy2rLl+6/Ah4qTJqtcGZiBEOZfvQ+0Pjv+pniTmyfq
         QqEYuEe97cBrh8YdhR2Okpcj/V5S4xCkxa97cQLWK71RGeUaJpqEYA9ehpvT8U1jb+pV
         Th9Gvl6dPCgh3XmhgQeRVbdPacxJ2lLF+xguy2AmkcMNa4SuPf/HR69Tsp7ch0S9UiYJ
         45lF/BFryRDgLlJHg+x+QKpHR3Z2E/u5Vp3dpvGOJNw+4qlch94vjRftspmfeRQW6IUp
         f5ZsByvbCfxlsVWPirAoORZ/MJ7f8YaPBiHRbeKCCY0TEJFGsflXXWl+ARAQnUaEegGp
         OJSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785530927; x=1786135727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n99Y4TVdVLwkrmbFc6xvkbJUkFajn56eSscgelJgGwE=;
        b=LdHFbH20iCZVdvfuvpPkfYhY6pFn0NbfBZM5U58l9BQg2+6m8rZ+bUHF8qH19sXw5Q
         wDxZeTkPpvyefiTYrBQ1nJWXiGVQWvsrrP46ruNDRUxJghwLLaRnCX5I/hm8ws8TNxuK
         weSJbzouzt30b0fh72kvnGnVRemdDNcpUN+Pu6mNibI6yQe6VFweS6kyNnz/r0XdgoB6
         /97UTU8mULx8K+Q48/y0eDhW/h4sYhi117eAuYl7jAmXBDXLVvulBBzUysScDAno6yl4
         owulwUZTveoQTyt6lOdiqcV8j1xtFIMm2HDSa/p3zN+pL7EiE89JWCI1JKT1l/3lpxDx
         9v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785530927; x=1786135727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n99Y4TVdVLwkrmbFc6xvkbJUkFajn56eSscgelJgGwE=;
        b=jhHx3K5mrBa+/BuiTbo7e1lLvuu9xHc/H05DffsHOGwvM8LrlywcSvlmk8VrW9+akr
         SgTM5W6KPkAzYEqIzCgy3MDFv1mQMwFYQq5mQYoC9aINAJuynXFsBudyow8jqQeUqFIb
         RJA4e2teALlYyUukrAPgzcCuNWcgxfz0ZWDQzoBd4W19gnAcMroRMLhHOzYDCAP4gFyC
         9gObtnCqEZPuRuKMLvV4pv724uHgI+7siyHVPYWwgVLuy9+gPVphJl5isxOmor3t8YgW
         M3fJ3ujjeKCECyB71l13xvFa4z3q5OjxwigyvANnvdwX6fInbDjZjF76GNBVXCWXn6+i
         YxBQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDQwM5Dba1Fvlv1Novrg1Mn1GM+iLb1c1BwCVdhs+NBP9EPDIVqqqA+RSvMtHRRQWXVmE6vRZi@vger.kernel.org
X-Gm-Message-State: AOJu0YyBnwkp/jCIh8zEyzSBI8fEj+LLva6PYwfsRbLoGrWg1yCeDQtB
	J7DsEE3zXyXJCnXBifzYY2jHwFVyvdM4Yon68M3rRWzWzkabrAf4jwDgBd+SuTkwP3sPp4OPeZ5
	EyfIr8l2x1RKTMRzR4dC4VfD+cHkamaId3Tfed8r6
X-Gm-Gg: AR+sD13WN8InIJOhsV/t1u+anDoBVbZhUuA1eiJ9pJJwgG9vw6kupcSEU9rKBkX8FsP
	r/EJHBpn1QHvUDYQWHRh0OSVxoNIyOivwBrFP7XRMq3SuPNXSctVCZ+WJ1DNk/awW1yeHBciVIW
	H36exQjZJz8Fx+KGk9oObRyuOoEYwvyiJcu4W4UCs7Trewi3Ig6h/vO5vukU2B7hXGtcFESyHUR
	yhabxe5PIDVeQl2Dlok3kCWo3UdavYz74wsmKh5zdtMlQQdqo4eGs+eoai+JTfSdW+q7aTRH9Mk
	oJRJVuo5JMtOTG/zxhOUCTeZvZmqCjYl8rkftQ3/Qv6f
X-Received: by 2002:a17:90b:4c44:b0:38e:21da:9257 with SMTP id
 98e67ed59e1d1-38fbc55a8ffmr1001602a91.37.1785530926988; Fri, 31 Jul 2026
 13:48:46 -0700 (PDT)
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
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
In-Reply-To: <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 16:48:34 -0400
X-Gm-Features: AUfX_mygZc7iXRdpSQn--2JfmeRTMiYoMN85HlxYxxZIHazgpGRFnpSW3d_XCEA
Message-ID: <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
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

On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwive=
di
> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dw=
ivedi
> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <pau=
l@paul-moore.com> wrote:
> >> >> >
> >> >> > ...
> >> >> >
> >> >> >> Yes, I understand you feel it should be placed under security/. =
You are entitled
> >> >> >> to your opinion.
> >> >> >>
> >> >> >> No, I do not think the newly added kfunc is a big enough layerin=
g violation such
> >> >> >> that we need to do it ASAP, disregarding everything else outline=
d above. I am
> >> >> >> sure you see that too. There are several other instances of simi=
lar kfuncs.
> >> >> >>
> >> >> >> Therefore, please attempt to meet me halfway here.
> >> >> >
> >> >> > I'm happy to work with you, and/or anyone else, who wants to work=
 on
> >> >> > finding a way to test kfuncs that live in security/bpf_lsm_kfuncs=
.c.
> >> >>
> >> >> Right, and for that file to exist, you need to get everyone (FS, BP=
F folks) to
> >> >> agree on whether placing all such kfuncs there makes sense. It is n=
ot for both
> >> >> of us to decide on our own. So let's revisit this whole topic once =
you've done
> >> >> that exercise.
> >> >
> >> > The kfunc that David has proposed must be located in
> >> > security/bpf_lsm_kfuncs.c, similar to the VFS kfuncs and
> >> > fs/bpf_fs_kfuncs.c.  If you read David's bpf_init_inode_xattr() kfun=
c
> >>
> >> Sigh.
> >>
> >> I now went and read the archives, and Christian already told you no be=
fore [0],
> >> which I missed in my first read. So two people whom this code affects =
already
> >> objected to your proposal.
> >
> > As mentioned previously, David's kfunc has nothing to do with the VFS.
> > Look at the code if you haven't already and you'll see what I mean.
> > The only relevance to the VFS is the fact that "inode" and "xattr" are
> > used in the name; David's currently proposed kfunc is an LSM kfunc,
> > not a VFS kfunc.
>
> I am sorry, I read it and I don't see why it is an LSM kfunc. It is absol=
utely a
> VFS kfunc, that is using LSM APIs to some end. The LSM specific bits are =
already
> in security/.

We clearly have different opinions on the matter.  I've mentioned why
I believe it is a LSM kfunc, I would be interested to hear why you
believe it is a VFS kfunc (what VFS functions does it call, what VFS
variables does it manipulate, etc.).

> > If you find yourself required to abide by Christian's comment, despite
> > this not being a VFS kfunc, that's fine, but this puts us at a
> > stalemate and David will need to find another approach for his work.
>
> Paul, let me remind you of another email you sent [0], in which you contr=
adict
> yourself. I don't know what caused you to get confused over the month.
>
> In it, you tell David to move *LSM* bits into security_lsmxattr_add(), wh=
ich has
> been done in patch 2. Thus, by your own characterization, it means the re=
st is
> *not LSM* code.
>
> Quoting you verbatim:
> > As I said previously, if you absolutely insist on the kfunc being in
> > the VFS kfunc file, the LSM specific bits need to be abstracted out
>                         ^^^^^^^^^^^^^^^
> > into an LSM function.
>
> You yourself made the point in that same email that the kfunc can stay in=
 the
> current file once LSM bits were moved out, and your request was honored.
>
> At this point, anybody reading this thread will only see your position as=
 a way
> to undermine David's work and waste everyone's time, such that you can gr=
ind an
> axe against BPF folks. It's a repeating pattern.

It seems foolish to speculate on what *everyone* reading this thread
might be thinking, but since the discussion has decayed to the point
where we are spelunking archives for quotes, let me provide my comment
from David's v5 patchset where I explain myself:

"I'm sorry David, now that I'm seeing this function again, especially
with the LSM specific bits extracted into a LSM function, this absolutely
belongs somewhere under security/.  It's only callable from within a
BPF LSM callback and all it does outside of some BPF pointer boilerplate
is call right back into a LSM helper function."

You are welcome to view that however you like.  I saw the v5 patchset
and the nature of the kfunc became painfully obvious to me so I
changed my opinion.

> I tried my best to engage in good faith, but it is clearly not working.

I've been working with David and providing feedback for a while now
(perhaps before you started commenting? not sure on that), and I'm
continuing to engage with David, you, and anyone else who wants to
comment on this thread.

[NOTE: Dropped Matt's address due to bounces, see my other email in
this thread about that.]

--=20
paul-moore.com
