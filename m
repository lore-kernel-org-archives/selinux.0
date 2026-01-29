Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152D288535
	for <selinux@vger.kernel.org>; Thu, 29 Jan 2026 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711478; cv=pass; b=un7Ib/MInrxEhYzHlu2A3o+G8lGWx/TRWow28H5Vxqq9I7XsGN/mR1vnpLU498cKzWzio405kkDJhF/mDTl6lhrNqknW+y9lfkDM1ai4oGPtRDOTlIxsjpBhluYBQxmTuI8dHKrSIkFr3AdC118Yqz0Kq3s1aw4PvlR/pQYHLdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711478; c=relaxed/simple;
	bh=Ncr8iPFpMGCLqXwGz8eGHHDAxANhA4AXkI9FgNfxy+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoeVMxGOxW7iiUOcXnEm/69C1LdS72Q3uTmKmC7eKhceSPaG6UUP/PJpsKjpeZ5eyj+bEn/+DSIF/22YAZk4RkzRS0njHOnelPltAhbY+q+8e+sMb+j7V+j+SVPVQ8L+cdSO/xEFD3oXLGNo2PZh8JclxgJ2t+/BlH6Nk/QJaVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X1qGmbCk; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X1qGmbCk"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29f102b013fso13284765ad.2
        for <selinux@vger.kernel.org>; Thu, 29 Jan 2026 10:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769711477; cv=none;
        d=google.com; s=arc-20240605;
        b=UWC/X45+llWSLTExU5LMpy/Q6CT6/hDrLa+/QU6frFmu6Pb8H40FBve81tdlOhBhnJ
         dCHsJEIAFU9LPySqVNhhCkJXSi1VuyW+26tchzR4cDXY+qcyQRVYx7FQYfEMz1pQasVV
         OIrlBeWNlEksxOmLQW0jLnLy1cYrjLf5YsJ9FevkBgLQ63Vzbcalv0t1b9KlE6tf72mK
         eI75ISdFU3zhX/72hFrB7SJbE9K1DNvumamUVYpkwdteUGp14njDqlU+xtywK0GMBX3Y
         Uk3MIZMI1l+O57D/pyQMiCh0wMKHlXIUYwp40f4XNcM38Ke44p0k3ts4Wf8EnbPVr/li
         nhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gaMEmesNW/2aeijf2CTvDdAzAco5YKTscfYAQiEGCu4=;
        fh=cdm1N/ZdgxbvWBQKtC+2en3sXhKL/WrskCWqDJ2oc50=;
        b=ekL97HV5fZJnTtqW8uY/YhfAxS1tXgwuO7USMp5eEpnD5YmiL0oKxK6aT0HUmDBWMj
         9nLCS86XawJeG9CsTg32jVh8Ers7XdnFSqMwrRmbVtHcCueY7RBq26EggVqg9PkqYhxz
         G+1B29DoyPirUg7yQDoYwxpkI+ETcewXbS3xTC46PP6AYwqPrqJK4G75g0HZ1Hlh/3tg
         nJKDOFgxYxraFA2sDWRCrU0zc0jeB5cVJOIxF7leNHHFtN2VEBUFg38Xxrx01x7UUt0d
         95R03dTQpPggnCQA4af0+EKWLyg7GSFSsK8cyKnjJ7+kfRy0evPaRzWoo2sp/H1r366W
         OCjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769711477; x=1770316277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaMEmesNW/2aeijf2CTvDdAzAco5YKTscfYAQiEGCu4=;
        b=X1qGmbCk8McqlrmPvQOfTsgOcXqXyjcTTbQ2lfy/7HcHA+dRHM1Lx5fLQGK6MRE0LU
         /RKiY4+i/O6I6nmzCxzc21Ssln5oBRcFpKRXYe5ouOzoIs0fxP5uCaaF+/HAKs2M5knK
         LrUX77EFYutKMd8FZfXre9ZZMlnnJw+HmI4t019wcsfivnZN4mXok5iQN4h32cwnJkMI
         EZxvZdEuo+5alm8VHOr4RpQZCvBWwj2eEUrXUyplGY0QS/Yo39NBK/w/Ci9p9r/Bh29q
         d7UJ/yQNOF/BKEMYmxmm1k0/Z7UDxkcW2iLM1NmPguPt7wDGXPt6pSO7FlyDvWs0Vcct
         6ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769711477; x=1770316277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gaMEmesNW/2aeijf2CTvDdAzAco5YKTscfYAQiEGCu4=;
        b=kD+w2FPToLrOYKcHryfJXBSwb27L5oQ2IzzsURks0/A5uYEk/wcju4GzxWnbwFak9y
         /eMMgOW+scQo/WQhmm+7M4tNXsw7Hk8j/YzmXs6Q0jKci4lfuwTr2QW6ySRNMSGD8D+L
         03PznnoWX3GcoH5pnnZLmgbYVw3qRLR3BtpiBOR3WqcF6YrS64O64vzYIhC/kPGFgj7Q
         SjXYO0vtqyNkLbfJjP7qrodbOjZZWwZyMZdr7pHrd0oJk7uSj1ux9HOipk/TeUAVqVCd
         hnw0ROumxEYBW4Ly5qprz2cNPS9YK5qRRFkZyZGhqwWxlKlQC+Q8eMBydZTE/CXBZTPw
         x37g==
X-Forwarded-Encrypted: i=1; AJvYcCWmfEdxXiTdyRjeblTV76OsOvyQPEoFik70Th6PFmwpVPQmc/PC8xsYPimIM8FlrBoVzefU851B@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMq86oyN5uj9+RSNoENm5WVo7Z7JzYuXJoLZ/zoF/nXqi1H+f
	4nBwpbhuyFbtRe1q917DZO+KaujtqaGCy+5VJxkRiKx+UmdC33+TV2BzSEwo258sRJ1aDu5KEaF
	u8E3YNOtmVqEf7vux7ipt+iGB4BA0qzG5ivUoKHqU
X-Gm-Gg: AZuq6aIxecl9WjxOww4/C/Ms2UEJWaucH7wCLkYVGka7ZL4BooZNubaHp5vHmUTakfN
	6sEnJEHWmiMBJcZJh6qG7YQg2rb77d0VeoVtEg8BerupGJ1qrg6NCCLiBUsEzxEQrs3BFkXY7du
	HOD08YyCTyK7lwPzBahTRQTHaJqO8iMT8vVlTimRF7aAsKIvhWFBgvAK/lWnHbJGodiw63l4tpf
	jituMbS/8Ad05faSgwWNP2FME50dFKtH+pmrxk1ajTNQBXu8SpZXN7l+nqLPP7UZM0qH8M=
X-Received: by 2002:a17:903:f8d:b0:2a3:1b33:ae11 with SMTP id
 d9443c01a7336-2a8d9949210mr973325ad.53.1769711476784; Thu, 29 Jan 2026
 10:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017202456.484010-36-paul@paul-moore.com> <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com> <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
 <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local> <74286aca-a565-489f-ad2c-886c650ea2bc@suse.cz>
 <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local>
In-Reply-To: <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Jan 2026 13:31:05 -0500
X-Gm-Features: AZwV_Qj91bihFusy7ufZpFTlJZmfomzjnqMHFZc12ATcxs7ntbmfJHUq6C4Bs2Q
Message-ID: <CAHC9VhS_y2gy2nAK7C-OpchME0pzS34-QN2bY9t5SRBXArz8Xw@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] lsm: consolidate all of the LSM framework initcalls
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	wufan@kernel.org, mic@digikod.net, gnoack@google.com, kees@kernel.org, 
	mortonm@chromium.org, casey@schaufler-ca.com, 
	penguin-kernel@i-love.sakura.ne.jp, nicolas.bouchinet@oss.cyber.gouv.fr, 
	xiujianfeng@huawei.com, linux-mm <linux-mm@kvack.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 12:11=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jan 29, 2026 at 06:02:00PM +0100, Vlastimil Babka wrote:
> > Agreed, the mmap_min_addr should stay visible and applied unconditional=
ly.
> > AFAICS the only relation to SECURITY/LSM is whether CONFIG_LSM_MMAP_MIN=
_ADDR
> > is used as an additional lower limit to both CONFIG_DEFAULT_MMAP_MIN_AD=
DR
> > and the sysctl-written value?
>
> Thanks, yeah we should probably actually move the non-LSM-relevant stuff
> out to mm to be honest.

Yes, definitely.  Send the LSM and VM lists some patches after the
upcoming merge window closes and I'll make sure they are merged once
fully ACK'd.

> But that's future work, for an -rc8 hotfix ...

Expect a patch later today.

--=20
paul-moore.com
