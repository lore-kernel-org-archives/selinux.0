Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786CF3B6362
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571142; cv=pass; b=nHD7q7lRSnsfKDToo+XlOw4WEobaEX3s8pGUu/wMgHhLj0gcy0SvDol2tF/mcdvcM6EQBrxN7EvW0Cj1MlpAnnbV2qNoe9qx1MStoSUc2YZiODA7d49MIrMyS2RFhz1gVD8HrvyqLJWPA95Lf/rbojX9wcVbUFVX/wHWBPIJTDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571142; c=relaxed/simple;
	bh=1JX430VNbqj0hZ6Lzk0OOAcmh3W6k774gqZhhQCrP/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd0ZVUAoP2KtKx8mAAmC5omdZHGcOt5wwaywHONueYF1FHOgXMO0aGrYBsZGhrIBh1vZlCKKM6dDLoB3PbyNh4uZowyRl4MTh/NsbEIGd7iC5iVe2KlzDFzzcWJAxAmk0zo1DOev0/THCUP2PImvQ/1YN7AF4Uh12Li5NDfWfyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWLp4eZh; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWLp4eZh"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ce98cb8165so43252095ad.1
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 11:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571141; cv=none;
        d=google.com; s=arc-20260327;
        b=kXY33lpgqhiTxglxnOoACXUEskX1eYc7Z7wmpSoykPRLMyJJ6iA8MaKRcO8rPRZXfS
         TyF3gb9oez84tRJe59ueHM7ftJZolp0o4vjk7dtM8b7wqJNDeqKYuB2v5Y/4xF4vPmT3
         caGC9BL0fOPn835P2KNiQ+p9GzMBJloZiyVicm6FlT3fYLTDdLc7wf39zCGrobmK1xY2
         Dus9rCMlwGZypiZEHb5/6yxICGi+ia8w61/LcZvlCFVrKBLE2InjT+BlyaIicLtK1e5d
         8qLCQ6gjNWDfAyf+IMt4wT/VETU4VAguUT/z1NdIcZJ3pFSG8nzkYo7VyX+9VgL1TP60
         hQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        fh=sevfc5QRdcO2Xoto7U5z70Ydi34gpqAVzYpD/yIYySk=;
        b=YswKiZ9bcXBjen06+9o5xZNK7LCei45+ZzldCkOoPT7GknCy4KLB6/vs0GOkHlXGoR
         MPlDgnCfRbvq/x3SYmBerQsziHl99q/n71Z0M7RRO/R3RWgiFDr6RJTM6X+9jVWkcZBu
         PaeIEONWuvmBtho8mtUZ6NwAJqyrRWHahfrQSK2Qikz/O5ksqfZk4cK2EaPJA+rDAlj5
         ZpyQUOX1jiXDjb6L2eeDnYiCTIif5wvXR0jnAG1O+eBPYre/IeZOrxC5nC5LR4nKYiBJ
         eYHpTL0hmepk8nVJg11H7woq8xL8B8pn7yZwmiVfb6UUf6B1ps4XbxCqrvG2bz11BTsT
         KWKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784571141; x=1785175941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        b=KWLp4eZhCGEaAiHAaTC37TOMSNgeCcmI9tjMngAHzbisyIIl4DD9oLzg+2o95wMPsv
         hE6y6Jl2R+fRW6GE7j8EoS1lgNSWUYXfvXHSml+nSoWRFyXNmaPRqI3r+WomGDlOOfse
         KEN5FUQx/u367rVVi8P++/X65Pg7d86mfGno+CcG8y5Z4Ww7bl3cicaMvNnU94ZyGf31
         tgRqMiLTY80YuoEfpKD/fgdKKmmq0VGW5CPlyeiyORPA5gn6NnDOHFi3fY0LAKS55pS7
         zlCeCbqa0b/kzaq5RD9bgq2lWh1NGTSIzn4cGQvlFvEodoT9KXZhOkSsuPwxBpSCMOZq
         b47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571141; x=1785175941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        b=Zt4C5NYBMbzPMapXexGTavF41RqQMryw/C5HAMxNyoj8kkP+uXFl234RDCkbASJ2WY
         PSS8I6z/Gp1UMXghnT1ldc+adFfiNcw3sylKLWY3uPtNfUT2KV9B8nkdQccwFN0QEMJE
         zPOPekWh0WRU3tIssehQ01t4RMuSTmQeeyvcTIJS3CqSmtmWTr0+bBvIEzBvr8dijYiK
         M3jJlUkXHXbarg/swKre9CJcMWfACM3we7cplg5oW+phBHPIeaIASHMnGZdWxiOU0HOb
         fNHU9/l97fRTXv36SqoJMqStEr8UTZhK6v/tDqVrNkcaSbB4fhHcbo3bqveydUhc1Gdo
         yRZA==
X-Forwarded-Encrypted: i=1; AHgh+RpDoojXombjknCR0mlQqmRykr4nrsi2DGhru1UO5m6EgK/khsEAvXEGr72GSOmaiNBZNP/HxsPR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2ZFYAGtfcmd+2As7jK6I4OYBN1Xp18LOjf+OzBaQJEGUSB3y
	ekkTDvSyJsO9WOZgZAlmd18XzWDgYlSFJf4v8cqwcU3Ud0RvqTMrbB+k0AJaXEEn5UGM03kPeLB
	dBeao82IQr21aoP9ydEchBwpNi8noWqY=
X-Gm-Gg: AR+sD11800bGk4XUmLR79Z81fqUukOTUDcfIfVOZDAf7/bO/imt17VVDNRiB9MFJJn2
	tbmS6vR6UBXE8xnT2VF5bNIrLAmV9Uaic6UlvbiYyVsfccmh75ve/VXq13eFQiIGfOZDrA4JRK8
	1yM9IMGt0YAJwxguJp5CZ3gCMZxDzGWfZemRA8cxFePI4eLlP+xuMgxBbHjRT4hVUEMBpK+4Xf/
	KspnkzQ0lORl1zxrgnUPUmTOglYsw7qmQbAq9BbJXD4zATuw5/BS13AM/x+y3sOgIbw6So5uH3f
	Q9zB3Hh6oW7KZEft
X-Received: by 2002:a17:902:ea10:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2cf1f29ea6amr213030675ad.8.1784571140752; Mon, 20 Jul 2026
 11:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
In-Reply-To: <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:12:06 -0400
X-Gm-Features: AUfX_mxSx6cvDqWkeZpCRVrryYfuXxFSwFH_5FN2Ivh39vzoR79SkwFUGoqzhZo
Message-ID: <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
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

On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
>
> I'm sorry David, now that I'm seeing this function again, especially
> with the LSM specific bits extracted into a LSM function, this absolutely
> belongs somewhere under security/.  It's only callable from within a
> BPF LSM callback and all it does outside of some BPF pointer boilerplate
> is call right back into a LSM helper function.
>
> If the BPF maintainers aren't willing to accept that, then we will all
> need to find another way.
>

Where this code lands doesn't matter to me, so I'll stay out of the
decision of where it lives.

If this kfunc goes to security/, would we also want to move eg
bpf_set_dentry_xattr similarly?

I'll roll v6 of this series meanwhile and we'll see what the BPF
maintainers say.
