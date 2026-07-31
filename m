Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A339FCD8
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520736; cv=none; b=VkWwomGC2JB6DN1JOx7mLZIlWinH6InjuEsNRlLfcnyJVE2RqybvXLNMLvjsHBHivV8GCZVxelvU2nH3x+n5jAL3GlspQMU0o8KYW3ukIoUTWJvZRugG/DVjgJq29DLk6TdlSfmQEyRQZofEuv1ibYn+29xG7ACzZ0yaV/pmCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520736; c=relaxed/simple;
	bh=dDPvQJOHcymsXdI8ZJUsx1Kd6Mebb4kw8y3wREaFZRs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VdcoplZLUcnLUmXNppzEC8eLXG4ihZ9Z8571/BkHP1RA2W0WW5rqu+8FcIyamFGy37AnWT4qCanUjQZPcfVc0KqTqSXkdMR4s/kdcIc8eCApGXVLsOrg+65DRjKk5njSheNhfkA7LZM5Ufo2uzRPEo7P8ksHClRidjCj7lCDdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frWDncAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frWDncAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E621F00AC4
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785520735;
	bh=tmAiEY8AdehJ+IFEwCzp7ff4B65A1B77cyxvfAz6p/0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=frWDncAPttpi8V1X2l/F76j0feodsRRGujDPnMQsXEF11V0RVlAECRJrjm1K84K5T
	 bfnnHhqbGyo5uYW+T0JU9BzWV2jEAgI3C50VYuIvi6y2atF98KGU/+B5Sx13gpoK7i
	 3+JfSng57Ey4F1u1Z1kp2ZgFi3252rcoGgLpsK1Vdu38YjadoKZh5CfWGW/zG8Bc4V
	 RegyVJ7cqs/zdhnYTaRSdPms5HngYNIsl9gpILMZDieyGUzA3P59bIHXEUunMZoY/3
	 LJtIxxTgwNoM6GNDtoRLqjXfzzVIW321QSTjmxv/fcFVsYaU8TNhEi1mlyB9TJVPzk
	 XMvLyMCYPNVbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] selinux: do not cancel a policy conversion that
 never started
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260731-b4-disp-d32e997b-v1-1-0341d038ee47@proton.me>
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me>
 <20260731-b4-disp-d32e997b-v1-1-0341d038ee47@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:58:54 +0000
Message-Id: <20260731175855.59E621F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Partial failure in `sel_make_policy_nodes()` fails to roll back th=
e boolean directory swap, leaving selinuxfs in a corrupted torn state.
--

--- Patch [1]: [PATCH 1/4] selinux: do not cancel a policy conversion that =
never started ---
commit 60502da4772313c1b4e1e77b979bed50ee026bc3
Author: Bryam Vargas <hexlabsecurity@proton.me>

selinux: do not cancel a policy conversion that never started

This commit prevents a NULL pointer dereference in selinux_policy_cancel()
by checking if the old policy exists before attempting to cancel its
sidtab conversion. This handles the case where a first policy load fails
during selinuxfs tree creation.

> sel_write_load() calls selinux_policy_cancel() when sel_make_policy_nodes=
()
> fails, and that helper dereferences the outgoing policy to cancel its
> sidtab conversion.

[Severity: High]
This is a pre-existing issue, but looking at sel_make_policy_nodes() in
security/selinux/selinuxfs.c, if a partial failure occurs, could it leave
selinuxfs in a corrupted torn state?

If the class directory rename fails:

security/selinux/selinuxfs.c:sel_make_policy_nodes() {
    ...
	/* classes */
	ret =3D start_renaming_two_dentries(&rd, tmp_class_dir, fsi->class_dir);
	if (ret)
		goto out;
    ...
}

The function jumps to the error path after already committing the boolean
directory swap.

Is there a missing rollback for the VFS boolean directory swap and the
selinux_fs_info boolean array swaps on this error path?

Without a rollback, could reading or committing booleans via selinuxfs
operate on freed memory or scrambled indices since the old policy data is
freed in the cleanup path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-b4-disp-d3=
2e997b-v1-0-0341d038ee47@proton.me?part=3D1
