Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926729;
	b=xryaBTt5whRW+wUpsA/fKLC7m1fSiIOBqF4UcnJdwR3hOYHg8Zz7vi1m0UqNZU3kZakS
	 C+Duz31acgWhH6AI9UeAvCWk5vwSmBfX5Vtsyrbz6oqy09TTAQXjGuKbzw7t52V4OQTNQ
	 wXcotiMoGMN5HexnOtMpT+4BB4EasoO4QVC0TWDVCTpjTokLD0xIxQrt123YsutVLx7yF
	 PC41H3ocbQ52iXof4/YC6Tixj9HKy+uFjmuCPKcciuRxLnxzXedDH9jdphQk64K3Z6xdf
	 TaZZkb05xkiBur0ngbFsnjru4xOJmoQpeNbQNjN2mkA7euvr6ZXqZcThlA19J6gzYaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926729;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3MYVLak9W1+VeoFjtTrDR+JylvoFdV5fmUycnWHciPc=;
	b=SHHhXJDI+YEsacdwkKAIMD5bWrKmd5whcSAp/ZQ4KuIaqa6IFHPU06fopjcFogWJpvXH
	 OHppLdAjRRtknuRrIIweB+cwVnjl6pQh6VLoWJS7Gj9fdXevIXg3M2pAe6YOXr2hFoCos
	 dSuUsoygPMrwlGIinl4rHmIK7YFuWsToehuqkWYugkV6fhS6jRBt15eM9Sav1nmBqmkt9
	 +r4Leph6qTb7YX3gstsEksb58BGQyh5K6ZGRwnZFKnBIeq/1z5WChOg7t8YWUcaJhkZYP
	 XJ50xiJlXHnfMLw35YdBoeWnFjrNvnUT+JbS0d6AIQ5Z7SxUizRX9+9PJu2+F0KWcXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jwSPlO9/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80C606A31C;
	Tue, 17 Nov 2026 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwSPlO9/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E471F000C5;
	Tue, 17 Nov 2026 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926729;
	bh=3MYVLak9W1+VeoFjtTrDR+JylvoFdV5fmUycnWHciPc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jwSPlO9/d8ZhHf2hcQkLEdGfAwqmBEzP1poC/ephKyX0/YA6Mg414Q6pKIqzpNz4Z
	 nGhP4SEw0/96L8GDb6QbYPL8QEaPdy9LK4f4AEEVM2RSVdXeDl95f3jvA193TpqBcV
	 +xTiNXLp2bYXChRzZKQ3OKY3SrP1Y9XIdFp1WrbjeOYz4AkVPGOHy8LFHAvd4mILIG
	 6xFTG08tlqFNZE9nksg9hvWlDjZtJpO0HG+9vgWNOlpNMwGCGt1N+k6/fXuKrEnPvh
	 /X+t8KlYGRlDYOyBzoDHaZagxtaAIYaIcrLk9PZ7jSMjgVmtSmPB43IV0dx+/1B2MU
	 9MrDOBRhk/dgw==
Message-ID: <sashiko-outbox-218983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 04/17] fs: pass struct path to POSIX ACL
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117150542.1169451-5-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-5-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:45:28 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> vfs_set_acl(), vfs_get_acl(), vfs_remove_acl() and the
> do_set_acl()/do_get_acl() helpers take a struct dentry even though their
> callers either hold a struct path (or a struct file).  Pass a struct path
> instead, with the idmap still as a separate first argument.
>=20
> set_posix_acl() keeps taking a dentry, as it is called from
> inode_operations->set_acl.  ecryptfs_set_acl() keeps passing
> &nop_mnt_idmap because its ACLs have already been translated into global
> ids, while ecryptfs_get_acl() threads the upper idmap down.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D4

