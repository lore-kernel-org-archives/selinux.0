Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AA425CEE;
	Mon, 17 Aug 2026 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983077; cv=none; b=rorZF9InnNNjxKZm+4AzhI9T2S/cFTnK/DY7NWp81bWcTBAKv0FvSmh4x3fROOObd6dQCRYZRjEuYYMLZL/g7Quay+qcsskbukFm4bOTAMHKktVw3BBVH6Yw5HbHQ5+adIx6+Umbn4q4KJiEgS5TW4aCmvPye1izAUgz7Q5oTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983077; c=relaxed/simple;
	bh=Obt53M47lLckG2gGhDqkaZfC4eRYjLnCouCQ8bsRJGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HprkdBGe183jShdcstujt8gYFwEEnZV4l+caH42+dwA9obztpt+3wU4gekoWncczp1O02NqQAxECGJZca+4aruHCUHKODtfrBGIZfynYovQM28aVQPHjEwQzc1+lBn9Ryae1UzWipsAVVocW5iAIg1rlmNFu3GuxPP0e9hX4UYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ajznZYu1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ajznZYu1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cyYT80L107pjgE4IzqW5ERHv9u8tZWZg6H1nha6Ecpc=; b=ajznZYu1Et9vCvJNaMVdIYy1qd
	A42d6TFoTXLvokaXYg+dYPG+LbuPw/eh1mpICqFqUv0BZBK0c+5P1Z/Qk4vOHz3jpHLX0IT5rqg9E
	1iJhXKkCVK3obsO5IyNP2wbM8CvQyXUigkWU2z0jIyTdbhPIGwh3kOtOA8SbqvnKZc90yCDYVCUoE
	jvzOFiNMykkuhulWIz9vTiiMLw4me4Luxy+Bqusvik1mvSsU+N5tmGkGJr6JndLzEPgV3+b0rg7VJ
	PTqb9vySIhkNDALUeLR2No/t1/6i7s0TOLAq/8FewGSkiAeNjBxT6QFl0148lNrZ4+bkhKXTPqwIO
	QlQD75TQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvzvc-000GRZ-1E;
	Mon, 17 Aug 2026 18:11:12 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvzvb-000Dxw-38;
	Mon, 17 Aug 2026 18:11:11 +0200
Message-ID: <39f53732-dc89-43b6-bf50-2ba5c64adf38@iogearbox.net>
Date: Mon, 17 Aug 2026 18:11:10 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/5] bpf: Introduce LOADER_LOAD_FD
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Jeffrey Vander Stoep <jeffv@google.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
 Eric Suen <ericsu@linux.microsoft.com>,
 Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
 Sid Nayyar <sidnayyar@google.com>, Neill Kapron <nkapron@google.com>,
 Eric Biggers <ebiggers@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, selinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260813002618.3755631-1-tweek@google.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260813002618.3755631-1-tweek@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28095/Mon Aug 17 08:23:59 2026)

On 8/13/26 2:26 AM, Thiébaud Weksteen wrote:
> The bpf subsystem supports a signed-bpf infrastructure to guarantee the
> authenticity of programs [1, 2]. While this infrastructure is ideal for
> dynamic environments or enterprise deployments where untrusted binaries
> are loaded post-boot, it introduces unnecessary complexity for static
> platform use cases.
> 
> In the Android ecosystem, platform BPF programs reside exclusively on
> read-only partitions that are strictly verified at the block level via
> dm-verity. Because the kernel has already guaranteed the authenticity of
> the underlying file, parsing and validating a secondary signature inside
> the BPF subsystem is redundant, complex (because it requires X509 and
> PKCS#7 parsing) and necessitates introducing additional signing flows
> during build.

Note that the BPF subsys doesn't implement any X.509 or PKCS#7 parsing,
rather we reuse the same mechanism as the module loader has been using.

> Furthermore, relying on signatures forces the kernel to manage a
> dedicated public key keyring. In a decentralized ecosystem comprising
> various OEMs and SoC vendors, managing these keys specifically for
> infrastructure BPF programs presents an operational hurdle.

There is no dedicated BPF keyring.. an OEM key built into a kernel image
has no additional runtime key management.

> Thanks to light skeletons, it is possible to embed the loading steps
> within a wrapping BPF program (also known as loader). In turns, the
> loading of the loader only requires a limited, well-defined number of
> steps. This series introduces the bpf command LOADER_LOAD_FD for the
> kernel to directly load an ELF file which contains a loader with its
> data. By moving the loading within the kernel, the authenticity of the
> loader and its content can be guaranteed by existing kernel mechanisms.

Same issue still holds as described in [0]. Also, this sounds more like
convenience for Android offloaded to the kernel.. (you stated redundant
given the signature validation and complexity wrt keyring.. so what?
don't you have the latter anyway for vendor kernel modules?) We're not
adding yet another scheme/alternative for addressing signed BPF via
separate loader mechanism. Also, if you don't want to use existing
signed BPF infra, then implement it as a policy via BPF LSM + xattr?

   [0] https://lore.kernel.org/bpf/CAADnVQLxgD_7GYWZZ49aY2LqVYOy4uGvK2ikm7MJ1Cj60VPNaw@mail.gmail.com/

Thanks,
Daniel
