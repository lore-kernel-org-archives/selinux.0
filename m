Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927332;
	b=c+rAkAd9C4fg+hPmbNRDa3/mzB77AduUvFnbGBmuAtwGxhewR+jag9Z6bTkAqlP5kcfG
	 MM3x/LiLKg8U5TwRsSGMbWRVk5pbzx20pea/Hd2XD451nWWJJT7kWkt5lItWohhmUTBWM
	 KrN/BONagmL78IrhRBtYwG4QDakBd0ss7yD7aj1UUi2zLu18fDAFQMJCf3WPib+ngx/90
	 xrlZZqS01PD/KNseTJj+euzd4fdtnIIYhy0lKbH1ieK63km7et14v7xrspNcNl3tcbWsh
	 fZPFjNbALiOicdsNumwiYYk/lqivwbZBcy2KiK8COsWyo2Qqdywki5DeiYa0W5aAlKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/nLvxcB5qqddgJuUWSyz1Omg6x4VKXmx1AIKiL1hltU=;
	b=jtI52BT6VGgs/00C8bMksPwjyFepyz/GGzKpxgc2icaHBW3Sg1Eb9T1OFugjkhw498HC
	 HscatF0b0oNdX/0FsDtbt/3S/GMRhChorw29l+MM3bPd+dTruARWgcp7T7r+joXhkQ2c+
	 zC/8SV7h5soRnojbYbgEWMNX6KNOAllVMxaAhWjS/juA6O5uYGRGZ/Z5InfF/3q2jKZkL
	 ZIahoqvaS1FrVfbNWzx43FtfRppfqABY/1pVSZUwM/C24+CbqKwyKGip/7NoX/7YHD4xa
	 QyeK7lIjtsxhqiNMxr26GTbngNwNvvFKcGT/58pYQt1vUs/Jc5ccykKVtIdYICzK+og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXIsIDH6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF73606A31C;
	Tue, 17 Nov 2026 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXIsIDH6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D581F000C4;
	Tue, 17 Nov 2026 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927332;
	bh=/nLvxcB5qqddgJuUWSyz1Omg6x4VKXmx1AIKiL1hltU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lXIsIDH6EUTSMcJZRcvlhB3NOhLDSPbp17ZFbFpfSlobwUUbM2f9x6T7oBmLK2zNL
	 o51i0x3rW2survravdMcHPP1M/ZuAYj8BC9frfR1rpRzHQi1c1pEEMo/s4I2I1YC0p
	 Ee1XmSHp9H4pQOAeFsjScQ47BD8XgRa66iYYN5aBLZyUSboWA7O2kOjCLwszMa3W9f
	 +ec3O+vT31Vh9Gch4EfKiauW1eI2H2N1rNjS/Sx3LR/p2vD1h7UZxHFpc2Gjiy+B+d
	 UGgODqasO94d5tGScmA/H1ZV6vYDAxsyRwDhIO3E1ULNegP4DK/WXLoCzqOSmWIPit
	 eWm9te23YuQzA==
Message-ID: <sashiko-outbox-219001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 11/17] LSM: rename the inode posix acl hooks
 to path_*_acl hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117150542.1169451-12-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-12-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:55:31 +0000
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

commit 98ec639d5946054ad6d9e19a8ef2e58b854df2a6
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: rename the inode posix acl hooks to path_*_acl hooks

This commit renames the inode_{set,get,remove}_acl LSM hooks, their
security_inode_*_acl() wrappers, and their LSM and BPF definitions to
path_{set,get,remove}_acl.

> Update the BPF selftests, the strong definitions in
> kernel/bpf/bpf_lsm_proto.c and the Smack audit function names.

[Severity: Low]
This isn't a bug, but no BPF selftests are modified in this commit (only
kernel/bpf/bpf_lsm_proto.c is updated for BPF). Should the mention of BPF
selftests be dropped from the commit message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D11
