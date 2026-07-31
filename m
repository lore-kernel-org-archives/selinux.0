Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF741F35C
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517174; cv=pass; b=iAUuaMu3vseB8J6gaYnZ7+CkuSQVTGNXakJrk/RiXe2QrD1qW036VJQ3071XUgigED9+EbIB8Su3cTVhB2UCDW/XjYy5wUEb37bYn+nCKDrefk7prR6t5oJEKSfZix+wTxtqTSDiz0xYyz6/gyAQF2+ujLW+xgb+bDH2fEAtLlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517174; c=relaxed/simple;
	bh=QRsMcHmTFVFh22BHxXQg21CAvxZvm8fj0rIAcVM2X2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYYGUOxTPdoNjuvkxpiMv+XtHtXm7L4qlJkqXCTogY4S9hbqDuNzuJUsXWT1MKwN/5zcJ7sQyIZ5ES8yEHtIMS9mXUGC2xEPU5qxwk5hys6Lyb1ePHpT15qCKUQe35gIgimojFKkL9jmCQDW3yriEztkk+GDOzflXPlsWor1f/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RK/ffCL+; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RK/ffCL+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1194760a91.3
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 09:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785517172; cv=none;
        d=google.com; s=arc-20260327;
        b=Dz0/KnAoy5FOPw3MW3kEo05GWyaFk+2t7hTDw/K9mDTv9Q+FEZtfVMcp0bxL+PwftD
         1d1DgoGAw0AC3cev+53+IbXikRIjeTR8hKd5rcDfCt9xP9HS1xO7MChw7jail6XQip/g
         xAIIIg4Hw6Todo9UGju0YjAH99hthSY12Fc9+T4o5PBEQ2GU79SiH/5mQzr9H7myThOE
         7Qcvc0hRER6HiYtZb/Za5CNlTQQdG1a/yQCRyKdMJ3dMSXvxWgNtcyELyIHKqKjdi7Cg
         H/20c8Tyi2kwFhoFPD87WcuSJohQlhS0nBj8c1Rs06hHs97mwL7qrZDgOTrhpn3/Su3s
         AqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zOKR/PjmyeeQ5AAj59WkFZ8/Hg/6PfssbyNnrg+0nMg=;
        fh=suW051RIkNMTvQ91ksCDg9de1Xze9/bJ337cDpF2uqA=;
        b=FtCmmYkBIKGh+7Pcvl0nW95/qwAerYmWZFJ//+WyJebg4mFFucTAlbFSqm5jENBlsk
         f80ck8OUxYshZj8mMeCKpGzVWRWeJZgU2tOTYRFNPaQZzvriK8KUJkpu41lXIzhTK23F
         mXXZTo6iJV3mqhkCSIGi1QRGLgwoK1bhBYFH/zHGAO2uTit/SERDKkXUD6tKXGBFp++X
         DXnFG37MdyDxZUrEdEKkidsTXohQXZZkgNfnj0SyHuRY6e7/3W78SEqp4FNgZlNLKkj2
         dpEP7sCiY/FVadhW//keKc8xFwyh+f++5TGwlMzXiw6BSPKi4/aLR+xp07FnHnNh+JOZ
         0EKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785517172; x=1786121972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zOKR/PjmyeeQ5AAj59WkFZ8/Hg/6PfssbyNnrg+0nMg=;
        b=RK/ffCL+62C/EbBLkUR5vfyVH831xrlHLmfwSa4rgWJIe6oagWgsKcMZm6SsdGdYCt
         DYBESgUCY5oodjuf1puuRv62UVDRSa15X0LOEzot/yRH7EFy8Jh6U8VxSvZIrZLfidYy
         bunxAGK0hH58Ai6xQ/gY9rR5RFumpoUDEr4kYFLuv1N3o0DyFjRWwfYDg2rVbdYsWoPY
         C3rIFlOxwWxo3gshS5IiYFc/ic/XSohJ8q0qJUGqWKjm2y4jRoy+SXZLz9cSv5JBqv0q
         oEINlI0axA/2NEhGQ5Vm/NbEkD63MjbQmGlqIAlswCIB6ruNh2Oek7pnZFfrXZxd537k
         k8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517172; x=1786121972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOKR/PjmyeeQ5AAj59WkFZ8/Hg/6PfssbyNnrg+0nMg=;
        b=jwi2oWtxAaEQZRXUzqz4tHGrxFa83YPRqd/tWN27PP5a+C2jEyLSLm+wYZYrnF4b24
         XY6SvsswHTBA1CubX8ao8cWNyiglIdciUUvtMzTVs1r5sd99+M7vhwzgAWvfzgq6YfdY
         Q5RwLGEZKXMmwbBDUfEc91ynOoATiPag9URZ6IaVG10//XDGEducusn+dtbdyKESize6
         mk2swfk1ARdeOmtWe4Z4saN49/CYXPIctr35oJYNqIHa+FMhYmZg/IVHHYrhiRpC6W8l
         hrSjpZ8NgigPQVFCQNVr/q0mQIarmg7zBeLo8RrrJOm56jdeupAUkdgOGAz/gj8hWX3u
         2+kw==
X-Forwarded-Encrypted: i=1; AHgh+RoZEuh5hyP3YxqP32DYrCE8ylVe28k2J/ohiBWMVeGKSxhr6/60zaWutr6m3t7V14+Qsspibhxh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1f+Brda2azWNcrhbFgrBQ2WAACnwNh+rhy7gddPKNgjxFtNB
	j42cEeqoDoloy9GF2KEUONQ4VQjg9KB53PeM671klGI7RqaFqloYi7SwoQImZ1ZmUG8u/0Ki+LH
	XiQHcyOiG0/RakH1/2DpmCnxrQ9wmZzWFmdvstuMc
X-Gm-Gg: AR+sD137D61Mg4HLG2w7pHNyFfkEScUjdjls4wazrAWq3NY5Ne9w47GzwtIL6CJTy1G
	peUKEvs0Yg4M/xb9KiwhYRmZYBD0boxQmFyAkPF3vyRvANrI3H0pI1EElh+7D0kdEy2L3Ibv+s3
	5UdNb5CC/ia9EiZe6MwicVhGG7/0SPkIhHI4W/OtA2BE6GvH08cTFL7tWsw5o5amUp7+KKxp3rf
	U1pGtZ7BRoiMLt6uGvMyebnJT296fa5s7YYzaS5L7xgOc4JwnduSHn/WA3T/DRUMmTS5f+p51nP
	B5R34LLvC9s9cT3xOf0yyVI94N24q9/qcdU9uvYIFfrV
X-Received: by 2002:a17:90b:564c:b0:380:9f17:6df3 with SMTP id
 98e67ed59e1d1-38fbc3e5947mr633869a91.4.1785517171698; Fri, 31 Jul 2026
 09:59:31 -0700 (PDT)
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
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
In-Reply-To: <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 12:59:19 -0400
X-Gm-Features: AUfX_mxiTF4CmakubyzcMYYVqWjlKYkApVmZz3ybbsziujIkCqg8Z2kjrrbozIE
Message-ID: <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
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

On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore=
.com> wrote:
> >> >>
> >> >>
> >> >> Okay, it looks like there was some confusion/misunderstanding.
> >> >>
> >> >> My understanding of Kumar's comments was that he was referring to t=
he
> >> >> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c=
,
> >> >> not necessarily the new kfunc you are proposing in this patchset.
> >> >> Kumar is welcome to correct either one or both of us, if we read th=
at
> >> >> wrong :)
> >> >>
> >> >
> >> > Yes, after another reading, that does appear to be the case =3D).
> >> >
> >> > We'll need v7 anyway to fix the ocfs-related UAF the bot found.
> >> >
> >>
> >> Since there is confusion, let me clear it up.
> >>
> >> I meant it for all of them. I don't think it makes sense to keep this =
one in
> >> security/ when others are in fs/bpf_fs_kfuncs.c. That confusing limbo =
state is
> >> worse than just placing it where others already are.
> >>
> >> As I already said, the discussion around whether all of them they shou=
ld go in
> >> security/ is orthogonal and should be done separately; it isn't produc=
tive to
> >> repeatedly bring it up in the context of this patch set.
> >>
> >> I honestly don't get the urgency; it will be a mechanical change if we=
 need to
> >> make such changes. The worst outcome would be stalling David's work ov=
er it.
> >>
> >> As for landing this stuff, we can let Paul take the patches touching s=
ecurity/
> >> and route the rest (3-4) through bpf-next after the merge window. We n=
eed them
> >> to go through BPF CI anyway to ensure nothing breaks.
> >
> > Some existing LSM kfuncs are located in the wrong files.  I'm not
> > suggesting that David needs to fix the existing problems, but there is
> > no reason to keep making the same mistakes.  The new LSM kfunc must go
> > in security/bpf_lsm_kfuncs.c; if that isn't acceptable to the BPF
> > developers then David will need to find a new way that doesn't involve
> > kfuncs.
>
> What "mistakes"? Really? It's just code organization bureaucracy. Calling=
 it a
> mistake is just blowing things out of proportion.

 :D

You've no doubt seen the challenging interactions between some of the
BPF and LSM developers over the past several years.  A recent BPF LSM
bug/vulnerability as well as these interactions between the BPF/LSM
devs, has caused me to take a much closer look at how things have been
done regarding the BPF LSM and there are a number of things that
should be addressed.  Not all of those things will be addressed now,
but I won't support patches that continue to do things the wrong way
because I currently have very little faith in our ability to correct
them later.  I do hope that at some time in the future we can reach a
point where there is more cooperation between the two communities, but
given the recent difficulties over even the small things, we are not
there yet.

> I don't think you can simply decide this unilaterally either. Do you take=
 full
> responsibility that kfuncs going there won't introduce BPF side regressio=
ns? Who
> makes sure patches touching the new location run through BPF CI? All of t=
his
> needs to be thought through before we decide upon anything.

I would expect, and require, that patch submitters perform the
necessary testing for the patches they submit; this is no different
from any other patch today that is submitted for the LSM framework.
Patch submitters would also be required to CC the BPF mailing list and
I would encourage interested BPF community members to offer their
feedback and review; once again, this is no different from any other
cross-subsystem patch today submitted for the LSM framework.

> Thus, I am simply asking you to be reasonable: let's help David make prog=
ress,
> and get the changes landed. FS, BPF, and LSM folks can then decide on whe=
re to
> copy paste the existing kfuncs later.

I view my position as both entirely reasonable and consistent with the
current LSM approach to cross-subsystem patches.  The location of the
kfunc David is proposing is dictated largely by the kfunc's contents
and interactions; it is only legal to be called from an LSM hook
callback, it manipulates LSM-only data structures, and aside from some
BPF kfunc boilerplate, it only calls into LSM hooks/functions.

--=20
paul-moore.com
