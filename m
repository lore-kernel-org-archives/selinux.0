Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37851E7C27
	for <selinux@vger.kernel.org>; Wed,  9 Jul 2025 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046892; cv=none; b=bODZaAkk0kzSRUO28A+P6BIEg87v/rVbpMGwLwoTbz4+72LqbIfB7ZsmfrH9Zg1wgOQl2Bpabr06+Ll7NCFYLl1Lovb9XrzEA9mPIfNkFHd10hTyuWKq+a0tQA9cvI2AeSestzG6ztdIApE3h/r1+957ek2z4cqP3pSUi5+sGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046892; c=relaxed/simple;
	bh=po7gBXPWT585JrK9CrjJ0sBV3kITzwM0ms+ECGX7VGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTIoHLcHPGAx6Yb/8Hmts+Pj+XvdGkT5dMQD9BHUQxWYgpgFdxFSi3/bgGWf1WUcKkxK5xTfGZkqfYGOFBn4dsA0Xoomk6LsoROSvvfHVs//IgUQFzgNUk0gztqbMRxVksykRjHCFh9p0DJVwULbRLdTiMVsjm5CgKFoG3VLa/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLfJyxnq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLfJyxnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752046888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pa8gIzcrHZQIlJO4h635lZI8AUoS7f+Sbk9Zv3nHBQ=;
	b=LLfJyxnq6ivmU/h/MY0SHYWuCcKBoX0RtlSZST3JiKKNhCMUD595VBDxA3U047LjXzFL4Y
	grPL+Q36ppIQI/V+vhtRSe7k4ewWgFujBAvWkMQD0dcU458XbEL/RQzBTn9XHxRvCy1uIM
	M6CNX2g5UvmDh1DkqgqXMi5XGwL1e3w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-kb4zC6-CMsaNj7d3ELqTsg-1; Wed, 09 Jul 2025 03:41:27 -0400
X-MC-Unique: kb4zC6-CMsaNj7d3ELqTsg-1
X-Mimecast-MFC-AGG-ID: kb4zC6-CMsaNj7d3ELqTsg_1752046886
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235196dfc50so7950295ad.1
        for <selinux@vger.kernel.org>; Wed, 09 Jul 2025 00:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752046886; x=1752651686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pa8gIzcrHZQIlJO4h635lZI8AUoS7f+Sbk9Zv3nHBQ=;
        b=Hgn5qK9SJLoSo7Dtim+4He+k6ghe8bw4rjOz7WA8NHsX5aeMH4zQ79WJe5eCVImfO4
         AXuvYrm4wQz19NblbCVlFDwZtn+XtmqKzRFIWIjfak3ycDaQNQekYxhjWkeE9n1nJFAM
         ++tNeujHSkeq3r4yP5/7XFRYOJLTQFNnM2CIQnjvgW6ysZiS8edELGnDnGLUc4Efu+pA
         kLpL8gfrFZCnWCteWeQsuKhQVg1OtXG9SwPHnAS9d7UNtdumYNFxENpHjYXm9Qg7rtC1
         AmifbeHS9Pz2sN+m7hOibzf/d3n3I8boEAqVZCSE9nQRcvESZ1JZ5stIWhjTW/yPoORR
         aZfA==
X-Gm-Message-State: AOJu0YyMyJM+JKadOEXzfDabx65oLFUE4Z/Mc8vcAB0G22iiCaMaRn6G
	vz1MadOzVy9DBw8KzBVAxJ8iz2dwNRvq32D1EHSNL2FrrnWCvi9TPq+pAcOgOX2UQtKCOqPE6yz
	wHtiQBGqgdPLQShsnoCc21RtQJLcOCAmiN3fI6969PipPo17tDx5bXs8c6HS31DgHEVXfAS/GPc
	b662vgLic2yjwRKFfd1pfIRL3Scp4OS5aEHJEzwI4Jv1hU
X-Gm-Gg: ASbGncsrGMYTeLsV7Ax7yhTBgwn7wQBr8XZS13y222GsISQ3rF/TFle4zHoaJXnEw4w
	dlIedOwSw+soip/TY2meV4O5ytrtHmqt6cBFKSNpd2WMt7qC9Ojih9r7NbVZ4VYK0Y0V1KJvqm3
	Wy9Q==
X-Received: by 2002:a17:903:2c5:b0:235:e94b:62dd with SMTP id d9443c01a7336-23dd1b2834bmr87520845ad.12.1752046885773;
        Wed, 09 Jul 2025 00:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6WfWZDTNi2AhOr066ZroLOFS/1eygjChVns2PotFRicTcapr12G3EafdsT77YPVqzV+bTUdyXZlFfIx5Tyis=
X-Received: by 2002:a17:903:2c5:b0:235:e94b:62dd with SMTP id
 d9443c01a7336-23dd1b2834bmr87520565ad.12.1752046885414; Wed, 09 Jul 2025
 00:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708210748.8782-1-paul@paul-moore.com> <CAFqZXNvDNAtukRPhKFiQmN+koHOevx75qGCK0uE5nWX+afTPqw@mail.gmail.com>
In-Reply-To: <CAFqZXNvDNAtukRPhKFiQmN+koHOevx75qGCK0uE5nWX+afTPqw@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 9 Jul 2025 09:41:13 +0200
X-Gm-Features: Ac12FXzQGruPoKREl8B8ItLXByQ82SaIoFJA8MawHU7S_poSokEdTkiaL8Y6rhc
Message-ID: <CAFqZXNs96RYi=tXcdrQ8EEQ_sas-GRCsyamkDu1rStp70Xh7nA@mail.gmail.com>
Subject: Re: [PATCH] policy/test_secretmem.te: add anon_inode perms required
 in Linux v6.16-rc5
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 9:35=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On Tue, Jul 8, 2025 at 11:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Starting with Linux v6.16-rc5 and commit cbe4134ea4bc
> > ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypas=
s")
> > secretmem's anonymous inodes are no longer marked as S_PRIVATE which
> > means they are subject to a number of SELinux permission checks that
> > has been previously skipped.  This patch updates the test policy to
> > account for these new checks and allows for a clean test run on Linux
> > kernel builds with the above mentioned patch.
> >
> > It is worth noting that there are still some capability/ipc_lock AVC
> > denials when running the secretmem tests, but granting access to
> > CAP_IPC_LOCK proved not to be strictly necessary for a clean test run s=
o
> > those rules were omitted from this patch.
>
> That comes from mlock_future_ok(), called from
> secretmem_mmap_prepare(). The control flow in that function should be
> restructured so that capable() is only called when the other
> conditions fail so that there are no spurious denials.
>
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  policy/test_secretmem.te | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/policy/test_secretmem.te b/policy/test_secretmem.te
> > index 357f41dd7574..32cc78d01f67 100644
> > --- a/policy/test_secretmem.te
> > +++ b/policy/test_secretmem.te
> > @@ -13,12 +13,12 @@ testsuite_domain_type_minimal(test_nocreate_secretm=
em_t)
> >  # Domain allowed to create secret memory with the own domain type
> >  type test_create_secretmem_t;
> >  testsuite_domain_type_minimal(test_create_secretmem_t)
> > -allow test_create_secretmem_t self:anon_inode create;
> > +allow test_create_secretmem_t self:anon_inode { create map read write =
};
> >
> >  # Domain allowed to create secret memory with the own domain type and =
allowed to map WX
> >  type test_create_wx_secretmem_t;
> >  testsuite_domain_type_minimal(test_create_wx_secretmem_t)
> > -allow test_create_wx_secretmem_t self:anon_inode create;
> > +allow test_create_wx_secretmem_t self:anon_inode { create map read wri=
te execute };
>
> The { execute } permission isn't needed here. The test always calls
> memfd_secret() in the same way and it requires just read+write.
> test_create_wx_secretmem_t then mmaps the fd with PROT_EXEC in
> addition to PROT_READ | PROT_WRITE, but that doesn't require { execute
> } on the file, just process { execmem }.
>
> I'm going to merge the patch with the extra permission dropped, since
> it's a minor change. I'm also going to add a Suggested-by for good
> measure, as Shivank originally drafted the patch. Thank you for taking
> time to formalize and test it!

Applied: https://github.com/SELinuxProject/selinux-testsuite/commit/72e60b6=
018321a3da9d5e328477e29ee7366e498

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

