Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088A330644;
	Wed, 26 Aug 2026 20:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774963; cv=none; b=R+LIsfZBqSv1neV9y99SmBptGIoXkAdGmXwNqMmyQjON847kLahSAChryGRQj8LPYx5w9q7AHBvLi3FRSKTOt4kil1Th0vyxQZCCQ+cGrZKd/ntVKBUfnfdFw2NLMzUox2KmMTSN5aOxg32nqzt/Uao8F1HGsqI42Ig4J/ixMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774963; c=relaxed/simple;
	bh=6oqkaTEM9S/j7l52RLazJBA715w1Ko5ZFsf90nLvNU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRR+PYXJ5G59dudIaEFRltetG8R0lgGiSfKRMOu6RSl00O7SQQ0oPwNkvl4iweEEGuV2JyC8kqPs6xAdXT5NSD7vhKvSZwdWl+tPCvhiWj7bCqbrfy0ZM3QnievGJzDoAsGGLnLtmbmpL3VJnQu0tkJ1RDDqWq4++Cec3BcBbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHWrzaYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHWrzaYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6AB1F000E9;
	Wed, 26 Aug 2026 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787774958;
	bh=2sDgeesLpKAB2xvEY3jUwY4a6DtbbS1WI/DIirLVCDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dHWrzaYCeq5e1HdbfLQU3lJ1sNRF+MgPdO/VxJXSuA9JpvfQUs5NA/HvJeB/8uduy
	 5jFVBhVEq2B2T9biKDVU8gdpAkY6zFkBgDZGYsRoZGGYYImR0ii52fqdfU2kxijsqT
	 GLWJev9UzSVWc3WucEFTw14kNiYX+AmCLq3kKpc6/1hM3PqOQUl9WUCe1eZE2ktEcK
	 IRQN3iwmDkMydDZSPYJv/i1MWqGXnuFBYFC/TwfDSboWJapOidKEw4qnxkqTfNZan/
	 ZSojtWCOFYEMmYBePl6F9g+KnGcuE5UVN8i8Ceej1p5prnUgesmkCIgwkOj8LN2e/Q
	 +9g1//qL2vMlg==
Date: Wed, 26 Aug 2026 20:09:16 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jeffrey Vander Stoep <jeffv@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Eric Suen <ericsu@linux.microsoft.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Sid Nayyar <sidnayyar@google.com>,
	Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/5] bpf: Introduce LOADER_LOAD_FD
Message-ID: <20260826200916.GA3382628@google.com>
References: <20260813002618.3755631-1-tweek@google.com>
 <39f53732-dc89-43b6-bf50-2ba5c64adf38@iogearbox.net>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39f53732-dc89-43b6-bf50-2ba5c64adf38@iogearbox.net>

On Mon, Aug 17, 2026 at 06:11:10PM +0200, Daniel Borkmann wrote:
> On 8/13/26 2:26 AM, Thiébaud Weksteen wrote:
> > The bpf subsystem supports a signed-bpf infrastructure to guarantee the
> > authenticity of programs [1, 2]. While this infrastructure is ideal for
> > dynamic environments or enterprise deployments where untrusted binaries
> > are loaded post-boot, it introduces unnecessary complexity for static
> > platform use cases.
> > 
> > In the Android ecosystem, platform BPF programs reside exclusively on
> > read-only partitions that are strictly verified at the block level via
> > dm-verity. Because the kernel has already guaranteed the authenticity of
> > the underlying file, parsing and validating a secondary signature inside
> > the BPF subsystem is redundant, complex (because it requires X509 and
> > PKCS#7 parsing) and necessitates introducing additional signing flows
> > during build.
> 
> Note that the BPF subsys doesn't implement any X.509 or PKCS#7 parsing,
> rather we reuse the same mechanism as the module loader has been using.

BPF made the mistake of using X.509 and PKCS#7 again, but that doesn't
mean it wasn't a mistake.  These formats are highly complex, with each
"signature" actually being an ASN.1 object containing multiple
certificates and signatures for arbitrary algorithms, and many other
unnecessary complexities.  The kernel's X.509, PKCS#7, and ASN.1 code
has had regular bugs ever since it was added to the kernel over a decade
ago.  Just in the last week two more vulnerabilities have gone by:
https://lore.kernel.org/all/20260821192502.3942767-2-Jeremy.Jean@oss.cyber.gouv.fr/
and
https://lore.kernel.org/all/20260822212703.1019792-2-Jeremy.Jean@oss.cyber.gouv.fr/

Just because it's not in the BPF subsystem doesn't mean it's not BPF's
responsibility for choosing to depend on this unsupportable code.

I've mostly given up even trying to review X.509 and PKCS#7 kernel
patches, as they are difficult to understand and have little to do with
actual cryptography.  And anyone building a secure system shouldn't be
using them anyway.  It's nearly impossible to implement these data
formats correctly; it's best left for userspace libraries that
absolutely *have* to support these formats and have better testing and
fuzzing tools available.

These formats are not necessary to do signatures either, as the
signature algorithms can just be used directly, e.g.
https://docs.kernel.org/crypto/libcrypto-signature.html#ml-dsa

But in most cases module authentication has never needed signatures in
the first place, as either hash-based authentication
(https://lore.kernel.org/linux-modules/20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net/)
could be used, or modules can be trusted based on being loaded from a
filesystem that is already authenticated itself.

We should start moving on from the mistake of building X.509 and PKCS#7
based systems in the kernel.  It's not working.

If there is a use case for authenticating BPF programs based on where
they are loaded from, that seems very reasonable to support directly
instead of forcing the use of unnecessary signatures and data formats.

- Eric
