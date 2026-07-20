Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E2390CB2
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572042; cv=none; b=DkFOIXCZyfubZHIN2t38UVMYTTXkbxebesNwhzAgMtsb9XpIuYEaGv62tM5V1wRZlHZeQWT1A/QnUj5cFbFoq/iF7Yvgh4HxGT5XK3jlJ8jsXmwS+kxf5ZdkEZj13K/452isoH+DNJ974JW/YslmGSfSXgGDjTks8D9tu/wGN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572042; c=relaxed/simple;
	bh=HaKBPDdvqD3jL+crpoeSpqk4rCYr9G1sp8Bvlz+sMGM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QWJOOlp7dNeMjJ0/D8gJuXKLOhYnX+poDHPdDGEkt2dt8B2lejKeCCs7bBKSNJ4M2NAMDVHKP3k47YAgu5pOLUXk39ssw4bIUYVl1uzYrtQ1J77gmERuofTLW5SrWnwBqqP38NbsWNcspg56IienXenljS0yZShOYua422eFFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0xzQg45; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0xzQg45"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so3709653f8f.1
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572039; x=1785176839; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4BSD6EaevsT9Fl/VQOSMyXi/kGr0zB0+ZQdJSCGrj20=;
        b=s0xzQg45ODMjIkrBxaOW/KlxKiRtUAz2Bi8N3AspgUHh9RvnAN0zeXcz3yZ9VikHTI
         eAxZ3lafL10cuAoICpdOm0p0TbshlDVBxfCkdnoi4Xw6K8r2diMtvsZ0EW58qfZBcU66
         pgeR+MPFIBT3nQI4QADwxyYU7TDAhpwLYV9GRHyQ9UlgRgr6np4QNy64LpxnLmaQulQL
         6NIvWJvGYr2/Nllw1SJVB1u3kh5AH5cFtMTWGDHdtq0zrU4GdeGD+/yIuKIenCz7KCDo
         SUZaLmOvV09kA+v4dJw1pugxwWwm2YjE3x7FX2Wm0Rx/0wu/Fl85s/BjVIwVb0DcTVTU
         AyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572039; x=1785176839;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4BSD6EaevsT9Fl/VQOSMyXi/kGr0zB0+ZQdJSCGrj20=;
        b=WHRCMp57JU8R2IjWP6oair4Q0kWTqdL77nAMMPf3LA/My3N7j+xxCJKFmc3oeJC9jx
         +zBiLjULmCT/aGsEkNIVKhtVRhdWERefUDorw6CG/qnhTA0ffpx3Kkj6phNERJMwhPHR
         xhstIvuVn99j1moKHrV6QbDLqiNAob25Jx3Q6O/sl+7Z55aHGXXoXhmQk8WDlyDDugNz
         4AiiMAep+R0q1bby5bnBmYCFfEqWW3txIy1REcLKUxWuabWVzQtbFhruNJWvxNAtMExq
         bSXyyBCFuSoX9AB7bm4wrUGGMGZg7D2cG6DXX6GYFVvDsIWLaefBQ+U0AADwFKsBMa75
         Mb7w==
X-Forwarded-Encrypted: i=1; AHgh+RqFgeZNq3zVcADT9Ctp2mtyhi0D5uvIlTNwx1g5xO8xYM5QwzrXN2oLnX/2ksC8BM+hW8yTqWAd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzyc1P3UC7AXqstjlWJEfGiBvkGeHgyYcCNo3H7daF8P3a53P8
	BLWRzMZj4iclBSN+Ui049FcBwnsEC6xop92NJdKXDs47EIg3xTmpszH8
X-Gm-Gg: AR+sD13F1esQz20ENEv2jlGB581h8F77d0v753wpi5EALlUM8GtwsIQNW6EOqi4anhz
	2KErmbT34JIZIXLt6ky/uwdGvVWuMISYPRysuCi3ScsFT/3LmAPGDULTj+1rB54A67NZGk3s0fG
	MxJNUcjjryXNmr5IXheFfUZ5p8+IPDik+zY+NqcQRs+HEGwqCBs0K1431HxJ5jhvtv3H/2veR3M
	aUC2LRiepjbV4Krinah3KrDY4d0bIsbp0vEHvajiSZf8zbplbErFARH2AVVZs+F8VFQ48K6D7Tn
	P2lOZ0T83V6koN0bJAVQCACNaPDbvdsS8E3TmJ0QXyOCmgwBDJLKg+2HxYrKY/zYPRWVDQQ71iM
	KLxCj19zR/4guwTLWiLiojcAy2urAxiSkNOJUiQVV2QIm1hxubCpiJGM3hyO+GkAMwUyNtHJ0gM
	pMA22yy0xzUSCI0b+bUVWRiLdGLql/nT/qRGuq3OxreyLv7Ilwuk429j40Copxbbx8I/R6gvOFP
	FBDvU91CB/CHyr0g4uCyKFw/rqdpEZBwu+wmdSsRKFW
X-Received: by 2002:adf:e195:0:b0:475:a4ae:e630 with SMTP id ffacd0b85a97d-47f623364bfmr18309880f8f.37.1784572038601;
        Mon, 20 Jul 2026 11:27:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e65644sm30464561f8f.16.2026.07.20.11.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 20:27:17 +0200
Message-Id: <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Matt Bobrowski" <mattbobrowski@google.com>, "James Morris"
 <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, "Stephen Smalley"
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
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>, "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260708000956.46138-3-dwindsor@gmail.com>
 <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
In-Reply-To: <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>

On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
> On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
>>
>>
>> I'm sorry David, now that I'm seeing this function again, especially
>> with the LSM specific bits extracted into a LSM function, this absolutel=
y
>> belongs somewhere under security/.  It's only callable from within a
>> BPF LSM callback and all it does outside of some BPF pointer boilerplate
>> is call right back into a LSM helper function.
>>
>> If the BPF maintainers aren't willing to accept that, then we will all
>> need to find another way.
>>
>
> Where this code lands doesn't matter to me, so I'll stay out of the
> decision of where it lives.
>
> If this kfunc goes to security/, would we also want to move eg
> bpf_set_dentry_xattr similarly?
>
> I'll roll v6 of this series meanwhile and we'll see what the BPF
> maintainers say.

I don't think there was any preference expressed from the BPF side. Logical=
ly,
one cannot be faulted for adding a kfunc to set the xattr for inode in the =
same
file where similar kfuncs to set xattr on other FS objects / entities exist=
.

The question about bpf_set_dentry_xattr is thus valid.

Anyway, I will leave it to Paul and Christian to decide between themselves =
where
it makes most sense for this one to live.
