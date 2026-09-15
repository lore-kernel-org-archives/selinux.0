Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3C3A7F68
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507708; cv=pass; b=lmYPCHkl2y/wBeSrWu998aGbAHknTzJXkzWGjYY/fs2NLHZU1lw+5WSeWJCW9eDYy2MK9yIM97uC1JyAnf0ch33Co0KtAbXNaAsmt3ly8S2dIpQz1muS9Kg6URDTcEQVLyEqk8aF9F9eR5yTfoPs3kNePnjKJzTEEIkefe5LZbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507708; c=relaxed/simple;
	bh=MaTGcg0D4AG1SW4KEc86VXhMsHtbPl/dww8BH5mPny0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI4Bb+xvrBnazPWytv26a/DVYTVESmMBEcM5QSuIPj1Fmzao2wwKVcdVSepIHKB7MPs4Kt8rFZHXzGhNokHIXU+uGy4XEftnR1CuHbqO91Bkm+CW7S5IzbOzIFCuC0oS71F8to8KTEKvp+YanocZUWnnKW2FU5RUgr8c+Aa5EvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NMe2lRBO; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NMe2lRBO"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8623e5d435cso43394b3a.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 14:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789507706; cv=none;
        d=google.com; s=arc-20260327;
        b=Bu/AHDhACq3f8cjx2yZ4FSXaZyd1JLFHElQTpjS5f4ay/HJZ1v26XJoULTzAKhsFSK
         5eaGGEp5728EbgvOux74RVAsGuQy5q1lpEYN23T2TfPZrzuBrnS9KYviwiLivZs/dO9x
         GmpfXHy3bsDcOD6Okm1VkNI1u2gsjgiSbi72a95WtNUZYfGRI162kN8ZbtpQoY5x0Svc
         GpPia4Iu/NzZ9I/S/N3WTU2v8uCaFoXdKtxWziRD87kWjXLxiRn/Zc3drXp2B5VuLC5S
         qecIbfAEHoqM2q+wNNR3KwoU1wIkoUq2a//zvFH/PqYn5UNOprVgG9M0lWuHwo19aJup
         TYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YajaT/d/xu2vopkCx8VekWbGX0fqDMZpZ/UeMEj9X8k=;
        fh=2keL7pblhcvxGP9hfhhKXVR5IF4eUq13LRJZi3BxAKA=;
        b=cSbd7EZoYZIxmLQfRR+U5PSP0Bi8CcIUQWYmDRQsUjWyJmm1c+ZS3g513Jz543Fo0c
         LYtAtowHiuC+CPIbu2sg40/80hBlY4+doRRWVP6O8aJJuwdYqmZhWqKG6jGlnn225cBv
         i4rsBo6n3/Uap/n2oeXnaU5N1/4FoIuJV8elAxxKB5RaeB7esR34xXIS1CeHfr4lx0eo
         9JRt3qQGa89gRICnL2QyzgrzLe8c78kHlBCaK20Yoiv6TNoD47ewz2x1xWkg7dogdEYj
         EzuQVUC5J1Bmtf1I9XLtvQfVANrN9EUKVh5DESYQCCd16CwObXm/ipgJimibkHC6CvK/
         +ptw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789507706; x=1790112506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YajaT/d/xu2vopkCx8VekWbGX0fqDMZpZ/UeMEj9X8k=;
        b=NMe2lRBOmLRr6iNgAJmds83FMbcioONSKQ81qK1zreROJDyCU2Il8SEe60MqWvYnhP
         B6Fogvqi2TcRnf9vpt5nkg0MwFt6Ewj00n17xa7WzOEhLfvui9hRJgXn04BfE6UgWk67
         NmFlgwJrOXsd1GOQwXmlvZY5qT+VVm1wc0aAaoyBdf4bg3fsv2iqpTFW3nHSyD/SCXYF
         pXtgPgvVXBCtTFn+6++4MXPAeH/7xL4cRhEGlzbppSM6OG/wLkuFmymwivi8HS+eHlZm
         EIEi+Z3S5ezePOg8Q2nc2w74RYj3kpoVut98iMBfaXEdQWVFthboQyZS61TkhnwzCzZt
         umuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789507706; x=1790112506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YajaT/d/xu2vopkCx8VekWbGX0fqDMZpZ/UeMEj9X8k=;
        b=2GEuJliLizg78uV2DL5jpb1/4bZDNifbuX2ezAGJA54t6gKLVTNnaDYe9yPaHFQtuZ
         hy+xPkePz9bfwtNr1JoabApqTulWXY3LlRFQta7yxNa6p3Jz5sah9NWstgkV2sap/MNr
         14ZWo4QRxKBSJ3i+P0HLKX2O+5rf86YDy6YRMavKYnXm/JKaUymgCKPGdBEUnPAuRuFK
         3oAqxMshZvmrOzV1Nid7XgPRPsXQmXXFSTWdyYb+zN5Utix0i9mUWEtSGqbn2c4qfeHr
         5lyzQIsf0FzcUXfcD/VRsGmFM8KWYCh+1OWNm09MiQbCI17Dx0zluH49SBm2qy7U46BX
         jr1g==
X-Forwarded-Encrypted: i=1; AKwUvByuivM0Xab/7JddSzu6qoncr2dDYyv4Vgcl6Bxd0IpuEZyF6nr8CK0ppJ8knFrd1LEKrwVz7Dj8@vger.kernel.org
X-Gm-Message-State: AFuF++kXwj2UMIdxEpGVxdFTGIv6XcZUYObD55Kz1b96I3dqtz8R2yxp
	UdZyi56aXW/Ah5XYnAFM+IjsoZtadXC6vPn7Rf/L/prOkPcOneV27V99pAXmJ8ZuL5ssgpf7cbz
	dbktFq+2SOCIL1vwreFjh6t/18UHYYS/39+osEAZn
X-Gm-Gg: AYBFou2gh2lzxNX65xcbd5SWNFtrQlOnIfwM6+/BlG79bQP2w76uLn4SpT9OoadhHuk
	zG/RrqC1ucOaqDwxCiKMR+qZmMLSvUdVIalwwz6IAXDHv6QsVinZJBQ/a6FC8nMjRgUG0r4rug7
	5ZcXSUDG0H9Jx6Fvqh8/LZ83mQ9Zp7Z3zzrD/yo4q/A7jmaZwHBAsr5vnriccQ5r3U3pWaWb8sI
	0O2i2Oo0mz4IByVU3ax4vHlEuf9txEBf44KGuTdT546EaUH4qzhH6Bp2Yb65mr2vRQ6DbIVXLAs
	M5RXiingcP6m/H82okxWyBg2GqXJgYOXrdGBejTjRleE1+U09nm3EGfw4t7WHyVqhqvHhX29BIg
	s2x+hjn0WxLg=
X-Received: by 2002:a05:6a00:a213:b0:851:8bde:7861 with SMTP id
 d2e1a72fcca58-8723208d530mr47523b3a.1.1789507706022; Tue, 15 Sep 2026
 14:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911163734.22981-2-stephen.smalley.work@gmail.com>
 <CAHC9VhS-TiBkOZWR7xgCrPnpxozjzM+y5vpgbPU9=R_C3Ta2WQ@mail.gmail.com> <j4p63tm4s6ipdlphfo7u4zg7dirgp2o2wfsxvicbdxwwdkxfit@6lyk76wfnysl>
In-Reply-To: <j4p63tm4s6ipdlphfo7u4zg7dirgp2o2wfsxvicbdxwwdkxfit@6lyk76wfnysl>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 15 Sep 2026 17:28:14 -0400
X-Gm-Features: AcwNN1Ubsr6lvFEo487R4nTunnn6SRioxMKQeBplPXvxDvTsLTNv_XLeOyvemmc
Message-ID: <CAHC9VhSY8Y1O=tpFUQhcY_GN42F=VvTfO7JqcS-ZKXRfa+1uhA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: mark status and policy inodes as immutable,
 drop status mmap write checks
To: Jan Kara <jack@suse.cz>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnacek@gmail.com, ljs@kernel.org, jannh@google.com, cgzones@googlemail.com, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:15=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> On Mon 14-09-26 17:17:39, Paul Moore wrote:
> > On Fri, Sep 11, 2026 at 12:38=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > The selinuxfs "status" and "policy" files are read-only interfaces
> > > that are also mmap'd by userspace. They are created 0444 by
> > > simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
> > > O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.
> > >
> > > Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
> > > tests IS_IMMUTABLE before the DAC / capability checks, so all of the
> > > above are rejected at the VFS layer without ever reaching the file
> > > operations. Since a writable file can no longer exist, do_mmap() clea=
r
> > > VM_MAYWRITE for MAP_SHARED mappings on its own, and the
> > > sel_mmap_handle_status() write/mprotect guards are dead; drop them.
> > > MAP_PRIVATE writable mappings become permitted (they were previously
> > > -EPERM) and CoW harmlessly to a private page, matching how
> > > sel_mmap_policy() has always treated the private case.
> > >
> > > The sel_mmap_policy() VM_SHARED guard becomes redundant for the same
> > > reason; leave dropping it to the pending "selinux: reject writable
> > > opens of policy file, drop mmap shared/write check" patch so that the
> > > patches do not conflict.
> > >
> > > Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> > > cc: ljs@kernel.org
> > > cc: jannh@google.com
> > > cc: jack@suse.cz
> > > cc: cgzones@googlemail.com
> > > cc: brauner@kernel.org
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > v3 implements Jan's suggestion to mark the inodes immutable rather th=
an
> > > implementing open-time checks.
> > >
> > >  security/selinux/selinuxfs.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > I'm mildly concerned about marking these files as immutable when
> > neither of them is actually immutable.  Yes, userspace shouldn't be
> > able to write to either, but the contents of these files *do* change.
> > While it doesn't look S_IMMUTABLE should currently pose any real
> > problems, I do worry about the future and an innocent looking VFS
> > change causing problems with one of these files because it was assumed
> > the contents of a S_IMMUTABLE file wouldn't change.
>
> S_IMMUTABLE bit is about permission checks. I have hard time imagining
> some VFS code would do some assumptions regarding data based on that. But
> maybe my imagination is just lacking :).
>
> > Unless someone can promise me that would never happen, I think I would
> > prefer the !FMODE_WRITE approach taken in v2.
>
> If you feel better that way, then sure, go for it. It works as well but
> you have to separately handle truncate(2). Overall I wouldn't consider th=
is
> less fragile than using S_IMMUTABLE but it's reasonably robust as well.

Okay, since my concerns are only a gut feeling and the S_IMMUTABLE
patch does take care of a few issues at once, I'm going to go ahead
and merge this into selinux/dev; I just hope I don't end up regretting
this in a few years ;)

Thanks everyone!

--=20
paul-moore.com
