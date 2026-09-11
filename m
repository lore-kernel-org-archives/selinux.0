Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB34A64EB
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145828; cv=none; b=GAT9LbHuFJ6ZdTWz+Fnr8ZGukn7F8dL/CSw/KQ6309MGY0/vHB59ScIhdLku9+3ZMiprgpyytIxcPnoaVmGm7uLh01ef0q4trXu9yerG5pO5YJGLVgry54xY7kkpKvt0YWv+LaV+iraggpssWOKlzERGzzoQMk0ta2ndhnxzt8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145828; c=relaxed/simple;
	bh=OZzC6tnr3Jqukzr/ELycPSEzdxDjj1gm/qhMsYXnI5E=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FLOT5Zlyr7TNsWfjzEOxWF6GcuzDK5AIiZUxE2+grg7Ve/mQdHHOX60ljTltO/rZLUXyfvjBbwY8fg2l5uT8XIAOq7LK3nDQgDF4NBSz5UUaihLM97PVM6wnNlB4X+36QvOgtPA75MvYB8h9O0mSuWy27iGoaiVTAzppVZDe8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0LQxkou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0LQxkou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7292F1F00893
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145822;
	bh=OZzC6tnr3Jqukzr/ELycPSEzdxDjj1gm/qhMsYXnI5E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=D0LQxkouqOyX8ZUyQrxRQT8qiuetDERPlH4yUNusxiRO9H9k3lXNgtpYQ4mdGwHkX
	 vDfMTcqt4dVlKOhfbjHeClOUQuTiBJClkZeQVKMOG7/f0tsMN3yPMHNCgvXSJn34Ob
	 QrqUEGP3qSiiRK0kPLhj+Vrch5d8lltUZU5NppiHzWSYGq6G5TkRVMVT6GV3TrQv3M
	 LySz6xRzpi6EdYDjkISd3/qCjsU/FnGbZMk7pGpfZastRV38KP0DKoWLe1Mv6et13n
	 c/FroEm5+jHlqjs+g7fWK4SxWA8/7OYZgxV+SV9vm5N2RvWgocK3gkQPEAc8LMQlFg
	 +6xsROcs5Xhuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] selinux: mark status and policy inodes as immutable,
 drop status mmap write checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260911163734.22981-2-stephen.smalley.work@gmail.com>
References: <20260911163734.22981-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 16:57:01 +0000
Message-Id: <20260911165702.7292F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> The selinuxfs "status" and "policy" files are read-only interfaces
> that are also mmap'd by userspace. They are created 0444 by
> simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
> O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.
>=20
> Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
> tests IS_IMMUTABLE before the DAC / capability checks, so all of the
> above are rejected at the VFS layer without ever reaching the file
> operations. Since a writable file can no longer exist, do_mmap() clear
> VM_MAYWRITE for MAP_SHARED mappings on its own, and the
> sel_mmap_handle_status() write/mprotect guards are dead; drop them.
> MAP_PRIVATE writable mappings become permitted (they were previously
> -EPERM) and CoW harmlessly to a private page, matching how
> sel_mmap_policy() has always treated the private case.
>=20
> The sel_mmap_policy() VM_SHARED guard becomes redundant for the same
> reason; leave dropping it to the pending "selinux: reject writable
> opens of policy file, drop mmap shared/write check" patch so that the
> patches do not conflict.
>=20
> Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> cc: ljs@kernel.org
> cc: jannh@google.com
> cc: jack@suse.cz
> cc: cgzones@googlemail.com
> cc: brauner@kernel.org
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911163734.2298=
1-2-stephen.smalley.work@gmail.com?part=3D1

