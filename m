Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC93451986
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524752; cv=pass; b=SHfFWNo7sPNDzzY58cJsRzIF1gQDI2kgvQ7R6EdOe+CfLbos5ZAiG0nbI65Bjj5hDbfadebxKEznVMxII0m35opX3VwxzR9D/z6QCLjKZzi7fBv/CGAntkvj65yGooXbpQ91s53tlnyf/ry30gJJuqghxjgpI7kVgrRncGqBSoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524752; c=relaxed/simple;
	bh=yYMvOLG38w4orK+MApkA+zLYeQLhs8q2VGY6o9e0R70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvF/4/WVZkUU0b1OngX9/U3V8kkV02JwgkDYGbe3oTLFZ5cE3ghmrrew39kw2UDzn1p8Epm3nIayB45iBweRR1LFscMByFalB5J+pYLoVwf9TpdyzlwCp9zFu4Nz1bVRkz1FDA66En66TNkPw7Ykx72Gr51koocaRHZg/Q4tmGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JHsniNAR; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JHsniNAR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1178105a12.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 12:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785524750; cv=none;
        d=google.com; s=arc-20260327;
        b=i0HgMV4sKFasazM7RYziVQOLrcflW5TwfnP3ycjZ/zDv5GgVvBQn5mraJr1bVtWO+F
         GJ8yxaPprp9hpLsAR/I+BHXVik0MQTzfrLqltpW9zZ7felyDhXJiiszOpfHsVDShEJur
         aZoBKArz8ca4Qs0eW8B3UJJiGqmUCpfBkQ9UGytUxfqGbits5M/C9JEs5gh2rqAPYAIG
         7JkwuggEdXRXSUVQe7R6o3laLymPu6bsaGrRvnI67sOnCxHKCp5xak5kXrfWVnfnrxKv
         D5eXQqTUvn0JwlZniGt6+4hsjSF7BRuFrR8zZ9SHn8WDB90POIztx5ztZrYxHe9+Gt2B
         bzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zCFFdTFE+G8fjImWxQnVKNrepHGR6cvlOP2Q22SYkCE=;
        fh=u0dQqdSNtiDjWxAH8xnVBXYX7tix0F7LpyV5szwjDdE=;
        b=kk1ey4zXhliYha8EvCCGjpWo2z4eMiIRxDh2ukOjtcIsXaGgR2FSUyqg39fd1Gw/g6
         KTDfgHvRVMsNFj77sJ4nJFL5xe093F0NmjOFjr+lYwZ/TAt8DUc8hyhpDTBZBNPhmd1B
         6fRrcx1KpPZCqHtmzgujDzBXFKMEqJFFqTCKaJhoObFOl7xB8ug1YPmYTmWM4w7CWg0y
         prE6esdJadQ1XICAQnaOOzttCtBE3rnhlEekK4Q4cRpGvTH7iGi3fryiTkilFfRDv5mT
         y7zsehJ/x4rkRkbR3kDk7N9eadlrptL7SNVLIIymPqcPCZLyUDGoa1qXqb5+9psm3mtO
         nXIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785524750; x=1786129550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zCFFdTFE+G8fjImWxQnVKNrepHGR6cvlOP2Q22SYkCE=;
        b=JHsniNARppQyfJeOgEgBJvYYzu8PxccLQtymddShLvf8oyb5pRRaNbSXotDjNhau36
         +hBb3nubmbuoMpB9/XVN4ELIDLMy/ArNYL1yWJZ6ROnOokG3T/hGs8z+mwcLKfZRxmuS
         ek8A/9RDiZY1h/u+1sYJwSz7awEGiAw2eHh2nwLf3vRTGy37vuRAiZFN/+z3r5QT7NMI
         MbxoxWNq5djA1Z2XkI1LGRxpyeZ+cGTKSO8Zn0Oq6B1QdNcbcbj8BzClTNxHEtvSzjGe
         7anGUu34U3LKcW/bI9SDCerAiIAFR5cMQ9DrPeN9ENL9qZSiwPiRnqduKgyRQhK6QM4l
         E7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785524750; x=1786129550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCFFdTFE+G8fjImWxQnVKNrepHGR6cvlOP2Q22SYkCE=;
        b=qnO0f7BytZ+0bLgp1yMab6WPyYHg0Z3Q5Xngng/HeKokZs70DnjZKvftz+V+OTK0Uj
         VShhsk9lsYy7lqq2DnjOGhLPEtQtRv7FEbQ5NsEQqjDywumTsAjL+dHcfh69KifAfnVp
         ZS7+2ByDoSaOyIOHX9a2FihvkjIi3E1rSxERCioXJfZ4KUrwwRDMYK5dZOOc/vaujXhv
         tOjQcZbfzGeSsFxCEDrPGJBoP/Aa1LCQT1lTieYNo41pgSx1kaanBgmA0S/tIfH72YXK
         9UEJKDk2GHbrXk1sA+wP9KETfpxKeijijOUI9hlHXs3ptpL0Pno61cDnlp7dU9VxOavX
         iMzQ==
X-Forwarded-Encrypted: i=1; AHgh+RpdVmx7ZPmz+NLr8f+kWBOsIu2+4XMOIxRTQYaCKEwHgEQkxqiUltVr4FhoGEStS29LRi+GZA+V@vger.kernel.org
X-Gm-Message-State: AOJu0YxGeXuaTzN27ZWGpWJ1rlJlzOpZQD3k0EIS98FIG9dmj46eXiMb
	skWEEQF5QLLIqCAD2SmyZ9ZMDYHib1pEXyEqdR9AsOKTFrw+4NY5aoAEUq/jVLYKYc2UJZC1dZY
	jpu90MKjGzXiE/sxxkZ188uDQlyti2bjUmNoJLA+p
X-Gm-Gg: AR+sD11h1kRnlaKEUb3ZLxLbsyw2txx5wtWSnFd8pG2OHfYI90PJCmM3ZNuMhhxdCBT
	TthSCJJaYex1FhiA/zr+J6e5FJ6H4CPTphUzcORvUxpqgTusLnax2wEO3SF5k07hUUGk0hNaAGI
	vAi7FIJ/nmThD7wlN9r6VM23qG3JON5jvuRRJcXMSp3+AqFs01lRXoGffvRcK5KXiNv8+jiTSpf
	HMn+dN/rV0nEm861wFKZTQOfuqTSr1NL7RIMzQ7O/cI/22b3ifFBa0b5qSbb8ca0qPx59FOxvpK
	zzBwMR7K3VPb/AUjxRA327KUdDTyd+JCPiknyZsn54OZNyz50RfXqtk=
X-Received: by 2002:a05:6a21:7a46:b0:3b4:7b3d:179b with SMTP id
 adf61e73a8af0-3c92a53fb35mr967925637.12.1785524750076; Fri, 31 Jul 2026
 12:05:50 -0700 (PDT)
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
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
In-Reply-To: <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 15:05:37 -0400
X-Gm-Features: AUfX_mzhQwXzX6axL_JCU146kBpF3HezC08-d7tZrEnJLnYGCd9nHtAkxsjABNI
Message-ID: <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
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

On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul=
-moore.com> wrote:
> >
> > ...
> >
> >> Yes, I understand you feel it should be placed under security/. You ar=
e entitled
> >> to your opinion.
> >>
> >> No, I do not think the newly added kfunc is a big enough layering viol=
ation such
> >> that we need to do it ASAP, disregarding everything else outlined abov=
e. I am
> >> sure you see that too. There are several other instances of similar kf=
uncs.
> >>
> >> Therefore, please attempt to meet me halfway here.
> >
> > I'm happy to work with you, and/or anyone else, who wants to work on
> > finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.
>
> Right, and for that file to exist, you need to get everyone (FS, BPF folk=
s) to
> agree on whether placing all such kfuncs there makes sense. It is not for=
 both
> of us to decide on our own. So let's revisit this whole topic once you've=
 done
> that exercise.

The kfunc that David has proposed must be located in
security/bpf_lsm_kfuncs.c, similar to the VFS kfuncs and
fs/bpf_fs_kfuncs.c.  If you read David's bpf_init_inode_xattr() kfunc
you will notice there is nothing in the function relating to the VFS,
well other than the "inode" and "xattr" in the name of the function;
this is purely a LSM kfunc and I stand by my previous comments.  The
BPF maintainers have seen fit to decide quite a few things LSM related
solely on their own, I see no reason why requiring a LSM kfunc be
located in security/bpf_lsm_kfuncs.c is unreasonable given our current
situation.

As I said earlier, I'm happy to work with you, David, or anyone else
on ensuring security/bpf_lsm_kfuncs.c has the proper test coverage,
but I'm not going to continue to go back and forth about the location
of the bpf_init_inode_xattr() kfunc that is proposed in this patchset.
If you, or any of the other BPF maintainers, are not able to live with
that location then David will need to find another way.

--=20
paul-moore.com
