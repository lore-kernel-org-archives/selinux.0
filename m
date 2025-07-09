Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3E1F2BB8
	for <selinux@vger.kernel.org>; Wed,  9 Jul 2025 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046547; cv=none; b=UjarWGbaQqbcfSs9zdPsqazFYbFuGUnSP9FrXXH/n3NR/hU/De64z4pwP2Zxx3RuHhdPg69h4eHbfmU/Z61d/6wRP90CHFoSdtM2Fi8GdT7nG5MCIRAVhFUVuBNkG4yM1U/HCW84sR4bhYzKm2zAVO9NGpSdM+xFE/QAwftD3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046547; c=relaxed/simple;
	bh=agjPMNG/F6YnwCnYkEVpdsRC1q3SYow7MPG/ZrT2hUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO7Xta/XBjaABkMNqHG0Ntq5j7CIVtgNyLceG3vXhzdgUxoKCyLp3+j558xxVbGbsXWKLTpoGDDBOcs9J0tI9hW6mh+WnkW6bHad64N6Mrn6NBokST3NU7QUEZaGLGKzxBI1HK6EsQqZ3KzBOebH0guluZ/7qhcbgVT4MY7HN90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eO/GHUWD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eO/GHUWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752046543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rw1y6Z3wkV2wCYySgrvVw8bXfwoM+cRig4r0ZhfEodk=;
	b=eO/GHUWDxvMiGfN6pw0QD5HQneI9i6wjHmK+INuSpFikRJmHFULZ+pvLpBFwAzcxRIEHwy
	K7TehTpPTYTslt5QxCZpDON5GWH8OD7QHpGlFpKiUuyF+2zgB1wen85u0aS99rEtV6utLh
	qQzFOEzzy0I7+T6MsYFW/uiCZeo4YUo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-OlX1nBsLPO2mQuy9f5Jk8A-1; Wed, 09 Jul 2025 03:35:42 -0400
X-MC-Unique: OlX1nBsLPO2mQuy9f5Jk8A-1
X-Mimecast-MFC-AGG-ID: OlX1nBsLPO2mQuy9f5Jk8A_1752046541
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311d670ad35so4800271a91.3
        for <selinux@vger.kernel.org>; Wed, 09 Jul 2025 00:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752046540; x=1752651340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rw1y6Z3wkV2wCYySgrvVw8bXfwoM+cRig4r0ZhfEodk=;
        b=SG6rLffuZKg8eDQEbGy6/o/RY7FoR5b0GwTdeQN2yzwyzBKeP+GhYXi2wwwlyUPzhG
         9/SjMmH/lYqWQwU211h4p1LysER6uGVIH4W1+qLzUx0AaYfIA+tfHP1RostTTXvj+n6J
         oWtVJUrAIIbyZwIa0I2p+4wM9pZd0dxFmgxUmiQ/kwQCstqMUYMfascHq8b9yNU9j1hM
         2hmp00Uk7oNOVHGIz4ivtkwWcoi+IQ2o5x6H6ElJ8ws4TZIAvI2bsTZ2Y2y76jPiOxnn
         d9opQCxWjfdruy+gNrQdc0XhfBGlznN+fMXbc8JvDz9DUw050m7fWDKBW5i2FgmDNaCt
         f+GQ==
X-Gm-Message-State: AOJu0YxQLFb3ylPw6Pi5Rx7chmGDePTEiLIvtuW0Jp9Lsvz921XCv3Fz
	3u0yLToHN6Ekk8epyZ9znlaNfp74O8dgots72nsOl2F+I/IeMDf+si3bO1/tuKCz/znQIDJ8mxA
	4Ec4+2tXE8OS7zCzPObK4tZTxoatS+VERulbLIO4d3dcN5Rm1mrledjBsTQv/GLIPF0GYTlYRYO
	VkkfZk4fdUhqapev+patV4kSFiGHTvQqWAfwAPxF9iIs/W
X-Gm-Gg: ASbGncsXnjTcm3Nu5DJPKVsAPLbs249PTg4Rf/E6qQ/tT4TNaoaC6/Pryra8N6EVKLJ
	pc+MwYhHaMiSdxyG10/yiiLKbMufgZbnkgQhU+vAIt0iAB9z4Y/gAOn/Rjqloo3EJBcsecUXKsI
	2tVw==
X-Received: by 2002:a17:90b:5410:b0:313:dcf4:37bc with SMTP id 98e67ed59e1d1-31c2fe4fd84mr1931423a91.34.1752046540415;
        Wed, 09 Jul 2025 00:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhBf57qUVAsp4s1B1+ovoQ2c+L/ZBL9PqQtEpE9tTRv+IVUejryZZIu64H4FQWNsgGL1jMg4yYhIAACNnEATM=
X-Received: by 2002:a17:90b:5410:b0:313:dcf4:37bc with SMTP id
 98e67ed59e1d1-31c2fe4fd84mr1931398a91.34.1752046539948; Wed, 09 Jul 2025
 00:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708210748.8782-1-paul@paul-moore.com>
In-Reply-To: <20250708210748.8782-1-paul@paul-moore.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 9 Jul 2025 09:35:28 +0200
X-Gm-Features: Ac12FXwMQQvhrxuVQ5hRW3O7DP7SB4moX05tNJnDTWxUjqzc9cUjx9AG3q8U7YQ
Message-ID: <CAFqZXNvDNAtukRPhKFiQmN+koHOevx75qGCK0uE5nWX+afTPqw@mail.gmail.com>
Subject: Re: [PATCH] policy/test_secretmem.te: add anon_inode perms required
 in Linux v6.16-rc5
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 11:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Starting with Linux v6.16-rc5 and commit cbe4134ea4bc
> ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass"=
)
> secretmem's anonymous inodes are no longer marked as S_PRIVATE which
> means they are subject to a number of SELinux permission checks that
> has been previously skipped.  This patch updates the test policy to
> account for these new checks and allows for a clean test run on Linux
> kernel builds with the above mentioned patch.
>
> It is worth noting that there are still some capability/ipc_lock AVC
> denials when running the secretmem tests, but granting access to
> CAP_IPC_LOCK proved not to be strictly necessary for a clean test run so
> those rules were omitted from this patch.

That comes from mlock_future_ok(), called from
secretmem_mmap_prepare(). The control flow in that function should be
restructured so that capable() is only called when the other
conditions fail so that there are no spurious denials.

>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  policy/test_secretmem.te | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/policy/test_secretmem.te b/policy/test_secretmem.te
> index 357f41dd7574..32cc78d01f67 100644
> --- a/policy/test_secretmem.te
> +++ b/policy/test_secretmem.te
> @@ -13,12 +13,12 @@ testsuite_domain_type_minimal(test_nocreate_secretmem=
_t)
>  # Domain allowed to create secret memory with the own domain type
>  type test_create_secretmem_t;
>  testsuite_domain_type_minimal(test_create_secretmem_t)
> -allow test_create_secretmem_t self:anon_inode create;
> +allow test_create_secretmem_t self:anon_inode { create map read write };
>
>  # Domain allowed to create secret memory with the own domain type and al=
lowed to map WX
>  type test_create_wx_secretmem_t;
>  testsuite_domain_type_minimal(test_create_wx_secretmem_t)
> -allow test_create_wx_secretmem_t self:anon_inode create;
> +allow test_create_wx_secretmem_t self:anon_inode { create map read write=
 execute };

The { execute } permission isn't needed here. The test always calls
memfd_secret() in the same way and it requires just read+write.
test_create_wx_secretmem_t then mmaps the fd with PROT_EXEC in
addition to PROT_READ | PROT_WRITE, but that doesn't require { execute
} on the file, just process { execmem }.

I'm going to merge the patch with the extra permission dropped, since
it's a minor change. I'm also going to add a Suggested-by for good
measure, as Shivank originally drafted the patch. Thank you for taking
time to formalize and test it!

>  allow test_create_wx_secretmem_t self:process execmem;
>
>  # Domain not allowed to create secret memory via a type transition to a =
private type
> @@ -30,4 +30,4 @@ type_transition test_nocreate_transition_secretmem_t te=
st_nocreate_transition_se
>  type test_create_transition_secretmem_t;
>  testsuite_domain_type_minimal(test_create_transition_secretmem_t)
>  type_transition test_create_transition_secretmem_t test_create_transitio=
n_secretmem_t:anon_inode test_secretmem_inode_t "[secretmem]";
> -allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_ino=
de create;
> +allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_ino=
de { create map read write };
> --
> 2.50.0
>
>

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

