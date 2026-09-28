Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859574DA9AF
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605457; cv=none; b=Jj5nVA+sF7Pj1awDCkElldsVEzD0joOToVrfhI8kHFgunx2uLAOqRrYobxvKtdubxIyG3Qf70pADwnRFVdtqEF98QyMECvP7xpctC8e2Vtd4vtY5jheDqL3zoD+6VrruZXeSeRlq/fdvgGxqDrwl9C6pnC0+XhH0LVOl4Noin3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605457; c=relaxed/simple;
	bh=zYPlro2bOLwkzEBEvW2W/OkbGIEcrpT7h88Z3HoREeQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EbXda/ploPjdNYbw+u9pkbpfPjA8Or6/PHaMNAtXxYep3T7TnzH18bVg02fM56bw16twkh2rjR5cTSGi1ROQx5UoclAVUmvXVlfKWxSut7xyYj6S7/K42Xs51lAXw9A828ih/x0nvQGMAY7nHuapBI2cfrBb+7m+EkRN69lCjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9timF+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9timF+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0201F000FF
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790605455;
	bh=IZ4iILKagCbp4i68R0wCz40Dz6HLau6VPuhbn4GjC88=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=K9timF+4pHcbAOoWPHL+GFiDvwN3ZfACE9Xud8v6NV0LtP94y8uBfHH2R9loz255J
	 pJI3QG5fdJP+/tZdNMfzs6ZSEaWjTL6cCMaLDMorUJN5orlFxABntTOgSL32o2kv0q
	 7ZuuctPeYe53yQq8VOpBJuPb7IN/fjXO8BZE4V5Tv8ooXLGzFG6Uik9odOmRq94iqp
	 KbcaYVEkWB/qVcvrH+KHgWPsenrASShVs8bom9a3SUQzaSfQTAno9q2PtoP5r92h3l
	 d3jaejsz5U8GHBGagjNRLbogPmGBbx3BLgp0macdAznhjDgYsHBMwF3KdXW3oLgZB2
	 vrAmqu6OFYLKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: preserve NATIVE_LABELS on already-initialized
 sb in set_mnt_opts
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260928141917.17577-1-stephen.smalley.work@gmail.com>
References: <20260928141917.17577-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 14:24:14 +0000
Message-Id: <20260928142414.DF0201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> When an NFSv4 filesystem exported with security_label is mounted a
> second time, sget_fc() returns the existing superblock and
> nfs_get_root() calls security_sb_set_mnt_opts() again on it. Since the
> superblock is already SB_INITIALIZED, selinux_set_mnt_opts() takes an
> early exit without setting SECURITY_LSM_NATIVE_LABELS in
> *set_kern_flags. nfs_get_root() then sees kflags without
> SECURITY_LSM_NATIVE_LABELS set and clears NFS_CAP_SECURITY_LABEL on
> the shared nfs_server, silently disabling per-file labeling for both
> the new and the original mount.
>=20
> Commit 3815a245b501 ("security/selinux: fix SECURITY_LSM_NATIVE_LABELS
> on reused superblock") fixed the same problem in
> selinux_sb_clone_mnt_opts().  The reused-superblock path for a plain
> second mount now goes through sb_set_mnt_opts rather than
> sb_clone_mnt_opts, so it needs the same treatment: on both
> SE_SBINITIALIZED early exits, set SECURITY_LSM_NATIVE_LABELS in
> *set_kern_flags when the superblock was already using
> SECURITY_FS_USE_NATVE.
>=20
> Closes: https://github.com/SELinuxProject/selinux-kernel/issues/69
> Closes: https://github.com/SELinuxProject/selinux-testsuite/issues/92
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928141917.1757=
7-1-stephen.smalley.work@gmail.com?part=3D1

