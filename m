Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD9346A15
	for <selinux@vger.kernel.org>; Wed,  8 Jul 2026 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480352; cv=none; b=G4wGC685b/J9ZyDhumuNrbSsstmKiCmsK0wVqwarTYUAJ6N6ABm7+szGXcXy1SqZvgyiMOhLSjTMy/M/+u6vmRCHGdbConoIT7ssx5zycKUrvOIPDNyUxs44Gv8kUZFFsyAU/jk7dlJNnxDGxUSuXvg1hgHJVFysn0ViDKvNzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480352; c=relaxed/simple;
	bh=Pfob3D8mbkTTmUhLmKjlXVr2c00IRc98rAq6J6IGM8w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AD2ZZZ4PO7ie4Si9xwcVc1nyq/7uhvEELlY1eDeeJj7lt1j7Lkb9zlk/rBuxKr2lcx1CjHwdE2JOtfWYWqmYdhCajGQ3hNsQybW4zf5fkjnoZJ/IgMv1B/Nws73dEX0WVwStEQCS0jlBiDJdIDqEeE6MgMZf7KOMPO7ffCQcg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/Fkq1VY; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/Fkq1VY"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-493b829982dso470195e9.0
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 20:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783480349; x=1784085149; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pfob3D8mbkTTmUhLmKjlXVr2c00IRc98rAq6J6IGM8w=;
        b=k/Fkq1VY6aeB5pCEiugfcDxREjIseLxREzoYRra3lE9/nqbw3tzGUDUwgcfTQhdPsO
         6YRANdwssFS43X6i5wjYdG1mWrE/DRmgirvreyqiSlkwWfdz4a5eCsDpZRC+RTdSPmw0
         s+W5PsJt+eRo2JyW4vt8cm8j6o18Bwrkmz2tCwBaIMcyksROnhGmOYOIVuwU8XGA3Wqy
         P9nmOlHdFf5X58K68DiuTgf7FFiW5HMU1uSojZ53q8h1A6VVKcR3ii21saKSMp6KCCIm
         4KgFIa31hmpuSnLYxbi7pq9tr33pEdk0kCkz2ENTEr0iq5VKs6yKz183SaDGqJl8eQ5U
         mB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480349; x=1784085149;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pfob3D8mbkTTmUhLmKjlXVr2c00IRc98rAq6J6IGM8w=;
        b=kmElSRYju4H4MmECAlv1wrX/3pUEAMK2X9mQM+liwTFy78zi5FS2WHUNlUIejVwL8W
         NlGA1rNDCA3yNPPhfBJs+HjkjZ+rTogd0cN2e766YiuPujA00N8Evu0uAeG6p5pNppyY
         N0b7K2EotPxvJv+ybikojpUIrF3i67/0VGOCKBTFFFGbUyevItyoAENqH4gs5cyBfnbz
         cUmWpjspzAc6hjIZfV5TlhQGrqePsomoIkNBLXL/cNg3OpJA3OHxUakYJ0rGX3bZlz6w
         1k3L9ROyto0Zj1WUkip+oQctPGSQqh5Kfn6Ygq65jonTWhQxUShFzk8GEZ1PahQ6PTHP
         0ULQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpce0nvWdzr/qvQWyn4YI9Z6I8upEQkW3KkPHJm08XMic4ctbjaKNsmvDgG4iDkHMGgVczIPGQG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DuS5TQa49GUkMQ41uFKx3YmHyhPtRweB12JohnDLvBvJLQLH
	6CwW/VIXbGksdSbUd4AEvoQxawND1pcOArTbE6/zjlVSI+Qlcq2J1t4a
X-Gm-Gg: AfdE7cln/acSMwXkqsXEFhoPcPddctugYosLSAqY6Mz/lPeCg9VL44exEVUtzIBzTld
	kh9DacIkaw5RDVd4dxtP3TmjD94Yr6e1P2f8xpPk0vDdzMHeEMbgJ9A77Bc6DK4jw53LoVtsDjK
	2vPsHev470Ckh1PxgT2TjLUWB4sDX8s2xCzOP88qJtRtd+ps5pay8UZbGDa10WwKTBNV41DWGoD
	VLbv6vqjYHmObtdeIS4JkQSp3Q51KuYmdraS9HRYw+Cod6uZnLYY2kWi0MeIc0PD51c7/6uTwcU
	XMlVAIIPA/Ru7hTtBNLEVZv/MuFC5g5MZ0La2i2cRj0fn2OEzkgRYYI7u7bNxmd9tmUR7PVZLQ/
	U9Mv4z9gdHU1XWO92oOzcEGzH+GRPo+yjau/s2VfSzdiLbSvoXlikuF1+5s957HdF283a1tIFct
	C7hyVqUcRyaEVwsfbr4RxNvrTBiAR27LmJy/LSxfdAmckY5C9IiW7AC13t+9Ypaqb3kAgqSWrWJ
	CQwtbvaylv14POf7TNpDSpmGXy+d2fg8nnBWsX5ZvePt8f2ZZfJZnc=
X-Received: by 2002:a05:600c:6085:b0:492:454c:347c with SMTP id 5b1f17b1804b1-493e6859969mr4220535e9.7.1783480348874;
        Tue, 07 Jul 2026 20:12:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e610532fsm19286465e9.0.2026.07.07.20.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 05:12:28 +0200
Message-Id: <DJSV0P2OINKE.34OCOC34KFEEF@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 bpf-next 0/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Matt Bobrowski"
 <mattbobrowski@google.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260708000956.46138-1-dwindsor@gmail.com>
In-Reply-To: <20260708000956.46138-1-dwindsor@gmail.com>

On Wed Jul 8, 2026 at 2:09 AM CEST, David Windsor wrote:
> Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
> extended attributes. For these LSMs, atomic labeling during inode
> creation is critical: if the inode becomes accessible before its xattr
> is set, it is briefly unlabeled, which can disrupt LSMs making policy
> decisions based on file labels.
>
> Existing LSMs solve this by setting xattrs directly in the
> inode_init_security hook, which runs before the inode becomes
> accessible. BPF LSM programs currently lack this capability because
> the hook uses an output parameter (xattr_count) that BPF programs
> cannot write to, and existing kfuncs like bpf_set_dentry_xattr
> require a dentry that isn't available until after the inode is
> accessible.
>
> This series introduces the bpf_init_inode_xattr() kfunc, which takes
> the combined inode_init_security xattr context argument and claims a
> slot in it via the new security_lsmxattr_add() LSM helper.
>

There are various CI failures in newly added tests, I don't think any of th=
em
are passing. Please fix before respinning.

https://github.com/kernel-patches/bpf/pull/12730

E.g. both test_init_inode_xattr and test_init_inode_xattr_slot do not have
expected results.

pw-bot: cr

> [...]
