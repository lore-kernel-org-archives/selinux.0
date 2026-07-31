Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8845DF76
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540866; cv=none; b=Oz1DByHtyDQfJSVD3cqESuPtS4muRMZeUnEgp4k3wtQSeQXR44icl891cMo9Sxs6bL7dla8cD5ameg6buetSPck8mPNWIpVW0n80gr5B0rRVpptf/g9WkEaHpucgnxSP8vqta7nzyewyoG/3Cq9zljaDRiGfsBgk/5Voi9IGHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540866; c=relaxed/simple;
	bh=fG4lpzFhUhSHtM3MOTFT/bKd1/wg+jyQpf2vtD+aZVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=YaHHrrI1RHyzHe8/vV7mPobozzPJJMHXb6RZcQU0VLmd5md0epA8pkobdIbZiLkQ+x9seNe0YBlx0HbWh+gIc73MXGbp9cr6dFPLGYEAjhi15F5l/6NsNw57wW9me52FAFeoeUa2LeFbp6cALrmQ5VB5AdmA9Nybh+F2D9XscEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMJt/8df; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMJt/8df"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso464609f8f.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785540863; x=1786145663; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=njEvB3ltRqMoxiCGEyBQLfrAODVw3BfigWN/Yf5Q8dw=;
        b=ZMJt/8df7hEntOCFa8HW69DC123PnyI1x1XgRZ/SxNIfSq1EuqEE4MUEMttlQSoC01
         Jt8pfCWuXO9IEmz744KCrinHOSNi3ky9B2v7YebbVIrXbkiCREty3AVW6LC68MBDGUwE
         dxUtrFehkcVS0SqHeO1lY+UCKyYeK66jb3O+3wZE+LingdgavMeoqaD3Surer8fVmdY+
         Tr+d3QiXN2LXF9vZ9FXek/V0q1ALIDkfo2r8p+N1wuhlZlzzKpkSn0mo45joBJ2dmAPF
         74qqsh/J7ItPV1IIXe+ftUJLIT7frOgl4i7V+VWPLo2X4BVZZGTdyoAXGG7PD97ahaOh
         QVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785540863; x=1786145663;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njEvB3ltRqMoxiCGEyBQLfrAODVw3BfigWN/Yf5Q8dw=;
        b=jN5S/DY7QbkZy0iH7NnvvUavqAhTkXHm9LGHqZ+Emyf+piMxJHVhkYah98Qgddmz44
         c7YX3uwR020R4H07oyBaf6GNr9393iG1rmjfFMUBq7LKaaC27ceq04X0fK9GM+0H9nDm
         AFIkDfzndDrnw2+4mIWaxxxBtlPurdhPFyljXIAdeGzhlscu/7tQBcaLH3pDRAyVW263
         2MLCT1RQzEyAOG/2ajbwCNtaTeYLNlgultqMHSqwvwVM2jQES2wdssnoBMjVJrXaG0lx
         Y/+yKvGSICuL2bpWDhPFnGkeEyIRC3uRmvEU08irFEEoRaOq6T9VUQlOaaq/UMkVBUDq
         YxJg==
X-Forwarded-Encrypted: i=1; AHgh+RrzRTAzEY1a4WxmD3qqMWznbN3/MgnYjyxjzVEq4keclijceHxD6AifU39xyfv1mMbZD7EjT2Tu@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhLkqDM4Rs5W7P2b2cyWEV2KHu/rX5Bv44nt04KWfTP18dZ8+
	Ml/52YRbdKPFN00iRwxeXp0PhBFF1b8Nnqb5c6EgKcujhgidbh1YSPHv
X-Gm-Gg: AR+sD11/w/jq+71vl3XfbLTfRIs8R1twmCJYCRXKP4V8Xw83c1pIVcvOzBVCJoUgXqK
	WhttOhPkfpkrrswbFvRA9Wo9UlUFwl4AvLdey6Z6CXkE0tQucY3RjpsIHw3YigkSvPzaZwha8nE
	HUNFdecHB19OTyM3yCUBGvK9H9AfjW7X98seimqSM70ri/sUeRslIX/5/g5chpgl0x4nOa0I5gj
	Nt4snpVxefVmQLDcFt3Y4WmeewBmhEW0+x7gAIFizB/Upe1j3NaKQBuyiXUracRt5+cjfgNGItJ
	CIPOMa2+F1t7XCSqcm4zUEQJV2WioVSDb5P/zOIvdkc3eBY6ABjMoTVBQuBjX1XqoJk4s8UsBsx
	J+N8EaXpDdqjZlhL8OXnR6l0j4AlCmxPWwl46ujB/R+lDGaf8V/6B9TRLYHAgeYGQ6vUMrYoDg4
	sXK50KBHjmy2jMP2MZLzYykDIZaP8taVdWN1P+VFKC3VkPHDRhPKUJ47uqXjghJ9nOCcaZGuA9D
	KVzaJS7xn9SNQY/wVwbDjSPLWwT0WE9rw7Yp1kkMMOK+giWSyiBCtfGHCk6SheFDDQc+hq6/3dv
	sPe634rmdUztUEJrcNbBwe/tSko=
X-Received: by 2002:a05:6000:44cc:b0:47f:6f92:84aa with SMTP id ffacd0b85a97d-47fd7312eedmr2037414f8f.53.1785540862997;
        Fri, 31 Jul 2026 16:34:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456262bsm10337130f8f.17.2026.07.31.16.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 01:34:22 +0200
Message-Id: <DKD5ES7LKD1F.YKD4OU6GTUXR@gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>, "Paul Moore" <paul@paul-moore.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "James Morris" <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, "Casey Schaufler" <casey@schaufler-ca.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek"
 <omosnace@redhat.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
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
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
 <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
 <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
 <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
 <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
 <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com>
In-Reply-To: <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com>

On Sat Aug 1, 2026 at 1:11 AM CEST, David Windsor wrote:
> On Fri, Jul 31, 2026 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
>>
>> On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
>> <memxor@gmail.com> wrote:
>> > On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
>> > > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
>> > > <memxor@gmail.com> wrote:
>> > >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
>> > >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
>> > >> > <memxor@gmail.com> wrote:
>> > >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
>> > >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwived=
i
>> > >> >> > <memxor@gmail.com> wrote:
>> > >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>> > >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwi=
vedi
>> > >> >> >> > <memxor@gmail.com> wrote:
>> > >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>> > >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya =
Dwivedi
>> > >> >> >> >> > <memxor@gmail.com> wrote:
>> > >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>> > >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartik=
eya Dwivedi
>> > >> >> >> >> >> > <memxor@gmail.com> wrote:
>> > >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrot=
e:
>> > >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kar=
tikeya Dwivedi
>> > >> >> >> >> >> >> > <memxor@gmail.com> wrote:
>> > >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windso=
r wrote:
>> > >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul M=
oore <paul@paul-moore.com> wrote:
>>
>> ...
>>
>> > As a consequence, everyone suffers because they first need to satisfy =
your whims
>> > on how all code and kfuncs written thus far are wrong, and need to be =
moved
>> > around ASAP, including the one being proposed.
>>
>> That's not a reasonble or truthful summary of things, I've only
>> requested that David locate his proposed kfunc in
>> security/bpf_lsm_kfuncs.c, I never suggested he move any others.
>>
>
> Looking at what's left of the kfunc itself, it's basically nothing.
> Everything meaningful has been moved into security/ already.
>
> Aside from bpf dynptr ops, what's left is:
>
> if (!name__str)
>     return -EINVAL;
>

You can actually lose this one, the verifier should prevent passing NULL fo=
r
name__str. Other functions don't check it either. Feel free to check it, or=
 add
a negative test in case you're worried about it.

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
>

I wouldn't bother, everything LSM specific is already where it belongs.  Th=
at
said, your question is a good demonstration of the absurdity of the ask her=
e.

>> --
>> paul-moore.com

