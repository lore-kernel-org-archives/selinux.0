Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927727;
	b=ao69lhcMsDChngjddWgkrmixEr2pdAC4Lq6jgwH0g8bWxBLbGk9HKGXQKbMDeFV/PJ6s
	 zctpNvRwGG73FDfrN8pRhecO3y5+4RNtx8sHoapkEHQFRBdJciTgHxeV2MmXVOu4HPuvz
	 caqgw5zrrE0aC5ElwjUcHImfILryAM+v8XQYo8oxhbiVthCxLtQ9Qjk7Q3UFL/ZaQdJSU
	 2ljNkrEV0bouI+XUsMF576m/e/Us9E4N4jFOL58sDYOYXwq/lO7kwFLRZIYvu1KO/ib+G
	 AMIWsylbe4iM3gYrTAPWh/Csq+iAnOKCPSWOROJWMedLbBgaO3oHk+V88J2Rkn32YwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927727;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nfRDHB5OcpaFrtfKWIV3n/24d2PgRuZMIExEI+BVbxU=;
	b=ifnvKlTvGaAUjEXffcDmSylX/tONll5+/1u3aUvzySRm3IF+8HIOk+E5/xlGd+nhA2eC
	 K6RS+8RvxQQ+Do6Q7p2LTDHtEmIAptOg+Pofa2UCb2kFYszI8eHqumRZyen60TUzpMjUa
	 AOsCiHPDAiptqcxd+TVipHlKueWFfJIBFLjLNbgZhoj1GT13ZzL3Tc6YokKAHn1KB1vfJ
	 heMpqs8clEqcpU/UjNyClWgBoLkvRiiGi20o3++Yx7evmc7fbQnFncU09rMDaB39mv8KV
	 od+X5sQWyNfedZzsu3/HxUNlh/7FDhn1wNMY2NJbsewbzhrDc+rjXBGumFmG0789MgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/3jTHRl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215D606A32A;
	Tue, 17 Nov 2026 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/3jTHRl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6369D1F000C4;
	Tue, 17 Nov 2026 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927726;
	bh=nfRDHB5OcpaFrtfKWIV3n/24d2PgRuZMIExEI+BVbxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/3jTHRlLQGXqI5B65XMm1cS1wgdj6xuiTupQ2sCnUcck3BMWWofYLXiVvSqVtppg
	 hIR6Pb3zOpz+7giSdSBhSlbAQSaL81rDBRp8NzYXTz0HBJcecAW9akveF4eD6vYSiY
	 NjxB5YOcTU6t8TgFYLqOh9rkQuRXhJW97KxU6AgGOwOyf4wCkKA36Dyg0bnsrzGyzs
	 KH14VDbonIejILQDqeLW22uJHO8NSvXymoGcK9K8zHtuX2yDGdxi3A9SbGGrdA9ZW9
	 GoGN3I491fWNUFq9Aq3zucUSY1zS5P5hw4yBTy2Gu9Fb7QoAJC8jUNo6iuc8NTcW2N
	 ZdVuapulspwqQ==
Message-ID: <sashiko-outbox-219010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 12/17] LSM: rename the inode fileattr hooks to
 path_file_* hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117150542.1169451-13-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-13-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:02:05 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] lsm: commit message inaccurately claims BPF selftests are
  updated
--

commit 27da61e3999728511dec6dab29db3e99aa1b60d3
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: rename the inode fileattr hooks to path_file_* hooks

This commit renames the inode_file_getattr and inode_file_setattr LSM hooks,
their security_*() wrappers, SELinux implementations, and BPF LSM strong
definitions to path_file_getattr and path_file_setattr.

> Update the BPF selftests and the strong definitions in
> kernel/bpf/bpf_lsm_proto.c.

[Severity: Low]
This isn't a bug, but no BPF selftests are modified by this commit, so the
reference to updating the BPF selftests in the commit message should be
dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D12
