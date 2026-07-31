Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1207E442B1A
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511855; cv=pass; b=MInuEcgNEw36Bmet9E69+myXR3Zp2K4CVm1HN8J7uPIee+A+DqbJsUMp+HlzSjKjvMXxbCkpFmDhEgePJ6Or+Mf/m3qjT67gaalfCyDzehy3tz4DKmDXyG98kLBN3tXSaWf9xMFDh1mGtpGFqzCp7tEvKIaEddZS3cxchqV6MsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511855; c=relaxed/simple;
	bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bev1DAMh3QlUnKW7+7rkEndKBM1j+/5tKo+F4xVrqy4Doshcfn0nTCv0FrKMkiT8zMIcu6PSmLB6byTHt0S+kP62m/hK0f7CQMNa5W9ICQkUHkYKzxqWEQa5jR5KD/36t4xVow9nQAl772YGf2QCj/XJ8h3/frlPpDlV2RsihJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv7almrz; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv7almrz"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c1372f84dso6100571cf.2
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511851; cv=none;
        d=google.com; s=arc-20260327;
        b=TVSaSD5+gGqrEB1eMIDORrN6XxXVLKSinBbZMOXWd8JnMPQ6kOSW/SgO6MBrPnCd5B
         qheG2utpgeOGn9oAN2LcZDPo8EtDx9YbQIcXVGL2YE7x/LQ8V4dhqJDPK7/XkYeAoOkg
         M0YCnW4YAWt0sdkyly/y4rTO8etZdaEjOw0Sh7djF0/VfUt8/dUKkN/TlD3DUEaNCSzS
         8N7RWMFddMzBpQ9s05H1/skbqsPyj4jXBM3Gyfy18Pc3xV7hVSOYrrrG8zEorSZeFIt0
         zHGBKvdg8ZMo/2/uDBkChSA4275FQBFIFqclDKUqdcFTank6jyRJdHiioRvrjdvYNEYQ
         5M8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        fh=Ps4Lh5Gl3mlSomNhTjsRVZ760opQe82kVxwYCLR/d3s=;
        b=lrSdcUt1BpZ6Ca9Uojv/wPVNNUlhBADHGsnviNJtBhF6m5VmwqGctwHTwr8+ORvQL/
         cHlaG8mKPz+9xvisZcaLvT/hjXfs8ELPuK5lUC2lEH2kPqvRg5Fp9x0TQKkqccoF+Pb5
         KS1PJhE3P7uQiduGVrhKoVyGajncQSCMUV4F3eoE53nfxWcUECmsIVB2746A1Yez8J88
         o850Yg7ynRTJ9Zcmz365eQ6IPiYd98qzrnHSjCPWRoO/32/aheGvy2NAb2vLG8MiPNL9
         mbI8yX1ElAqX2vUT6Hkv769Lg+j9sNc16uUSAXFG7M6eDQI8YHu2eghDzR6VvrXJrk6y
         zJwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511851; x=1786116651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        b=Dv7almrzLgInu2aUvUTgDuu+AvSYoQPoJXwtqMKfNk2NvNgNV0ChgtOEbKITkDLxY+
         IK3lol9An0jJKwGRheMIA+9coU1UPxmoAQXv745nA3ijvQYWSKJZRN8CRoniQeol38ty
         TMd53QOjEyExUV3Dj2NhzYMcIEB2SYh1p/oTzzwX2fZkKSSZpAtVpZs4neDvUFx3FpTD
         vXMdnAtoW/r+VnbMyBqM44EFfSx+s6qUJbqq9+5447JTkLT55aJd+QYldBMRk5bXcXUS
         vDUN4pPibTIVAwUfmZ6U2mv9dGMTQrLPcQD1aCC+5XDH/zI3oiiwu0b/0yey5Qx8xxjK
         0a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511851; x=1786116651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        b=IyQ603KwuGdcVpNorGcNc4JDU2225tYqUqigqpqVrE8/C/ncW0NzGKoNt7ojxovSVy
         yqyNXnvfldFw+C2wlYtyteR5xCfJ/Ot0hmwhR3efz284cMeLuJ27HZDF5dTDQ+KtGBNj
         9o8zNFkeoythygfhRtg4L+uyLZWzUkp6ZSIXrQToDLoy8U8QvofJakl/QRzpbucPdAGi
         n3Hx+4u/eijzjkENZ2ex9e54HmfDWekBU/v5FJhfQ73k4SO6R/LgXedyCWY2V1qrle04
         CBVqDtp2W9eAnZ7pOB1xnqfUyJomIFSC4DYcAtOukDpMqu6Pvw4zQVZPSujI5ziDeDsB
         fu3A==
X-Forwarded-Encrypted: i=1; AHgh+RoAh/jZB+kKsR95pGWgAs0EWtPoLK4MgK1TJo0K5CFB6QtBFLsHaIh0shSO/cNyX0s60NHHBMs8@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+eHda/VQTSTY0NOUjxBZ9VecCyeszgnMjOXrf7io25YJj+Ox
	ySIEqwR8H4vVo1SwnlxO1dO4r929QDSQIJziRhu7kQDkPN9hIISk+I7+i5iwNZZ2JNCAP+CsTaO
	CXIeG/5GTpLpJqzSjX9h6ugyuNyl7uc0=
X-Gm-Gg: AR+sD1162vgsOlr2SsAK7sOhuQfYjpmKk1YCyG0+/wdhNapWFHqddygY0fgwfBmmsew
	tdpIYGxOAUQpCqv6/gJASUR11ej5+HbiXvObYO3TWLdy8Jm97Lx/gW6eq3fxiYMNvrsfbpC/dS9
	ULUzJT2owSCRX2h0c9mhkugNCxPgldT0Of86z463GDXukF9ZKFTUIVO4BpnJAmEH9djpM0vuNB3
	OOvxgS8ukV7lw8v/EuVx8aGVbdqCAI2zByEEqDl379vG35wiOlYEO+0KMwdO6yFI5OlnqgJ214g
	K4mTEGAco/BY74r/5eGiW5kB+9u0J2arypMFYkkLh0sMP+GEBMQTtgDq84lo1KLuJ6To5fKH0ZQ
	=
X-Received: by 2002:a05:622a:2590:b0:51a:8c79:a2d with SMTP id
 d75a77b69052e-52b56673ed7mr13843131cf.1.1785511851030; Fri, 31 Jul 2026
 08:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com> <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
In-Reply-To: <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 11:30:39 -0400
X-Gm-Features: AUfX_mwCzstzsX_jENhs2p3EGP2HH7m68AkpKrdRcMR6AmexYou-kWEv9wNOVLk
Message-ID: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
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

On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
>
> Okay, it looks like there was some confusion/misunderstanding.
>
> My understanding of Kumar's comments was that he was referring to the
> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> not necessarily the new kfunc you are proposing in this patchset.
> Kumar is welcome to correct either one or both of us, if we read that
> wrong :)
>

Yes, after another reading, that does appear to be the case =3D).

We'll need v7 anyway to fix the ocfs-related UAF the bot found.

> However, regardless of Kumar's intent, speaking as the LSM maintainer,
> my stance on this is that the kfunc you are proposing must live in
> security/bpf_lsm_kfuncs.c to be acceptable.
>

Ack, will do this in v7.

The Landlock series currently up for discussion [1] is proposing
placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
go there?

[1] https://lore.kernel.org/bpf/20260731022047.189137-1-utilityemal77@gmail=
.com/

> --
> paul-moore.com
