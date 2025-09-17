Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECDC202C30
	for <selinux@vger.kernel.org>; Wed, 17 Sep 2025 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071346; cv=none; b=lE+bkJOSgA9aHSAxS/kXTDseOU1a8qWQyNcPU68TnUW2z8AI+11EWvBS0zzFgD3Gvb4axDNipGx21YqlPEvzthMGe63MdIo5Lb5lbeq7QlswiGh898QjR7BSDFH+pUIW7ztDFTcOi3yI/HpmLEBpOCZHfDMo/VsnNV4ulMV3Q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071346; c=relaxed/simple;
	bh=BUtYNeWBlf5QHi+IaMjeNB93VcPuCp37DQN4gnN67q4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CygZzE9vSHJv/CQQ8ZT9+ttMYIAMyKU3GGR+ItJvE7VM3OLoekQpaftbGkBsO8PJReIvlWbDFL1qHCLvS5xlP2Oiuszu56Eq2bDwjUuZtkZaQ8bbv/USAzpDrraECK0RQp52FZfq6Eo3GNZNtGNpPxmGjzr9AGoUZxRJe1u8LJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zze9Nx/y; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zze9Nx/y"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ea409597fe1so2324465276.0
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758071343; x=1758676143; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aANTVr5axolQ7BbjwnLuDvhkzbQohdfLxP4+qHFFkZc=;
        b=Zze9Nx/yMv9i9K9HmyB1tiJMq42YlgZCe/4u7vPBFeAshXaqGPcKufgKokFr3+TtIY
         Ri8PZoQpFKttoy6BJP9oDJeB+PwMCwIrRj5Ptm6s2ucSndS/mT+TCGfmRxZnJZFqRlRi
         XTOMCZMvAh3RFTu2cFnNCz6VWWFhWp4QBqm9UyrjXBrZelk1Hpsx/tGmx5pYgZbR/F+d
         hn9RvIl+dnzVLPHusZgqfydoN5JYI/MN4gtMzjq5oBycVQs9QwCw0b1ak01RhX2VWKLH
         XfO1ni5D5TrQdBMOv4WCYU03TiAqaeQEA7k5IoDi8KTIZjq+/KUjO3T+e51IbQpzo/Rp
         OtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071343; x=1758676143;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aANTVr5axolQ7BbjwnLuDvhkzbQohdfLxP4+qHFFkZc=;
        b=THrtKdbJs0/Zdk0XxpfqvjJGLTljCE2AuR0Spb7u7dpNDEFbOHE71Hmzx2wvicLyW/
         joreG7ejssjsuXXxTn0b3SdQiHKyOdh+64XkMcpES8E9/kbmH2jewJjF0lIrGuKZV9F9
         xWP8PNcq1QX8LdVgK6Lw2Ncx7laSlgDkxWly5yezhZlHVhn+hNGkrKTaZj7feD7ntbVS
         WOCKR3acFPKhvVyY8YT+1ALp9ZFDDtrAXch1JA/+MwPP0vdNY4DBy1EuFapVCJhO9QeD
         ftBDN9Px4y4QeaWO7JzMGGYK8OErCZVWMa6ytJnfwS8vZWF4MTC+cuUkDa216rTflwuc
         OSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW84VWTou7azHB+P5fJvsVBpIm/DzRsFkU4nPNYTsRRCz7YY4Gbl8Le1IS3L9jO1VxsDyqjQzyg@vger.kernel.org
X-Gm-Message-State: AOJu0YzOyfJvKtAsO1n+b/AW1TBotLSyfdqj8ZFAff5gCWScQZI/3EQB
	qMeXcWR0vfb6ySmw6GeTP7eeoD3ieg63o332X37KJBYpRt/CbOPTmmDpBpH44RxKow==
X-Gm-Gg: ASbGncud8a+/KcWZR7KR2cQOqRbe61bAX5BnIGb0keDKtnwr56qrPHRhvODLrjClW5R
	OcmekOAT6tMiogW5D/PHKOv0q8ruwSDbnGgkzRQV03v3CP5y2koZWphvYHKdAxxFrxoa0AFBLqP
	bQj7lWEoq9KxLf0KDTIjhKZo18SQQA5cPf6YbwRUJHmDCZgvj/3p35JzbOJRrA4fgR9yh+CRoOK
	NiQ52un3DAGxsZC29bZ6Zu8vFJplXXXAD2I3PN8YKGw4wdg0PqfsucsHSyFfsMOqds6wOKG83aC
	POMMdt0u3j8/wJxsowm5N/7E+I4tOFSERhe7DPp8cCFokNd6JsrlxEqOhEQH7CG+8DOeM50BPfC
	7ncIhWT7Lqt4l6MqqM4AC9hQm4Ro6NRF9fedZPhGu5jQUGy6gNapAuDvzixsVDqET3A/t8Vervm
	ntLx+M31Rt4614KkMlo0V344W0
X-Google-Smtp-Source: AGHT+IFGR6+9Hx1aPuBvMpaobAq/qWl23NruMocVjrvxvIXrOI6tSCiwuhhjzQFtoMNgnRtW9cEMWw==
X-Received: by 2002:a05:690c:dc3:b0:71f:b944:103e with SMTP id 00721157ae682-73892c5726emr2575027b3.47.1758071342433;
        Tue, 16 Sep 2025 18:09:02 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-73266fe1782sm29375867b3.46.2025.09.16.18.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:09:01 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:08:47 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
cc: Paul Moore <paul@paul-moore.com>, Hugh Dickins <hughd@google.com>, 
    James Morris <jmorris@namei.org>, 
    Stephen Smalley <stephen.smalley.work@gmail.com>, 
    Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
    Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
    linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
    selinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
In-Reply-To: <CA+zpnLe8Z=2qY3rVCyZXyGPOaO2a0V2BVrdMkuwKs789igGCzw@mail.gmail.com>
Message-ID: <b266fe61-7a7a-b13f-a73c-f30f5edc22a3@google.com>
References: <20250826031824.1227551-1-tweek@google.com> <6afc91a9f5caef96b2ca335b6d143670@paul-moore.com> <92255d5e-7e0a-6ca3-3169-114ae7f6247f@google.com> <CAHC9VhQejS05C8AExkh32GidBdzXjauKPP6T_3eSGZDEwfwDuA@mail.gmail.com>
 <CA+zpnLe8Z=2qY3rVCyZXyGPOaO2a0V2BVrdMkuwKs789igGCzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-746452338-1758071341=:25424"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-746452338-1758071341=:25424
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Sep 2025, Thi=C3=A9baud Weksteen wrote:
> On Wed, Sep 17, 2025 at 1:26=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > >
> > > So far as I can tell, seems okay to me:
> > > Acked-by: Hugh Dickins <hughd@google.com>
> > >
> > > If I'd responded earlier (sorry), I would have asked for it just to u=
se
> > > &QSTR("[memfd]") directly in the call, rather than indirecting throug=
h
> > > unnecessary #define MEMFD_ANON_NAME "[memfd]"; never mind, that's all=
=2E
> > >
>=20
> Thanks for the review Hugh. In our case, it is necessary to expose
> MEMFD_ANON_NAME as there is a string comparison done in
> security/selinux/hooks.c (see selinux_inode_init_security_anon
> changes).
> I would argue it is cleaner to reference the same constant. The
> alternative here would be to have 2 copies of it, with the risk of
> them being out-of-sync at some point.

Oh, I'm sorry, I simply misread your patch, and thought that the
#define MEMFD_ANON_NAME "[memfd]" came at the start of mm/memfd.c,
whereas it's in include/linux/memfd.h just before mm/memfd.c.

Yes, you're perfectly correct to do it that way then, ignore me.
(I do have to reflect on why three instances of MEMFD_ANON_NAME
are safer than two instances of "[memfd]", but you are correct.)

That does lead me to look quickly at the security/selinux/hooks.c
end of the patch: I don't particularly love what I see there, but
that's none of my business, you and Paul have constraints to meet
there which I'm entirely unfamiliar with.

Hugh
---1463770367-746452338-1758071341=:25424--
