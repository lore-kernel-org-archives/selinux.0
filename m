Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239056;
	b=TflfqFZWnLhq/gxd96FfqbEaHis/itGmuVdjM/YIvY1nm/jq5iyQAww/W+lH9tAiBHrg
	 Zltyo/n7mYBOSp1GZ2BQRTnvSbPJMc0lgoIiAWTc/OvWu0kUArEoJqc9/EXM1PYnOGmi8
	 wkF/i9cyUjPcFljyO9W+84emGCj7th8ifwu+OSVdHOdGStiic13Zs5azgBM9u4ypDGxMI
	 nWtsFU7DDITX9k+jY4hLdOtYPUYSjSFa+aic8yPxOEGHZoio4tOkcYm8e9I9efHhcwH48
	 Ei9ojEW9zXc4+1G1ETsovNAa1bqtOmSTSs6Ge/NmTGdDkl48HelBGJmzbxorBDWFllw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239056;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hW6wfeqmoAxc3Yu9fzvIVde+QhFWLglYZDvJ4xpFErk=;
	b=Bop5SB9+grHxFTo3QF2ekyMSC2VwYIobL3P8UslGdg06sFB7qK1zE4busHoCYblK9m/c
	 NmjHlniTvkAowfMxuXpyCJviZSwX3uU97sMc1/KzmKVYfXFWIt7gTseZs3oiotpRciynP
	 M1MN99vcd3sw+iQHQFKwU5W1Vpo1RkMbHay5eghEUvFiwyXvzHIkQH/VNJD45xNwI0wDC
	 /h8E1+qQbfxS06kFpuBH59SjIXlItmb0Tw9rkmP+GfV7zGlaY6oOJ37iQtdLjNZ608w+W
	 Gxme+gLoYp4G87yrzDpB8Tcd4k6zBnpjZqL7u53VMbt4MyFBoOFVhoco3JTRHOAJy4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M98urHP3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5B606A32A
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M98urHP3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE761F0089F
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239056;
	bh=hW6wfeqmoAxc3Yu9fzvIVde+QhFWLglYZDvJ4xpFErk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=M98urHP3LdXp4LTmq92F1lJE/hBV65Ns1/c0PJJOkaenviIoqB0LgdrKRTOB6nHwX
	 NYNkrxMYO9Le1gWUb5RqX/MqEWslblp4RCTouEuRIUft6xB5t0pD4kipQ+0XhQTs1o
	 PzoXV2M/MCwMticMruf92uaSoLDDdVlaBZiwbSEfFqAXke952XYghaDpt/jFix6jBe
	 aV1vxHULiHXpZ736E0sWIVea1VIyHNwB18A2rH/HuNCy5m9LLBN4VEsvXOISVPDtBr
	 DVuWBrpAxB362GsKeB0gIaJ9ayF+V/iJriD4uuF79I95YvaLhCuOGlhcSJAbsXtVZY
	 XpNqqexBDi7Cw==
Message-ID: <sashiko-outbox-205174@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] selinux: keep pending boolean values across
 policy loads
Reply-To: sashiko-reviews@lists.linux.dev
To: selinux@vger.kernel.org
In-Reply-To: <20261109153802.76176-3-cgoettsche@seltendoof.de>
References: <20261109153802.76176-1-cgoettsche@seltendoof.de>
 <20261109153802.76176-3-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 15:44:15 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> Setting a boolean via selinuxfs takes two steps: writing the pending
> value to /sys/fs/selinux/booleans/<name> and then committing all pending
> values via /sys/fs/selinux/commit_pending_bools.  A policy load in
> between recreates the pending values from the committed ones of the new
> policy, so the subsequent commit silently drops the change, while both
> writes report success.  With concurrent policy loads, setsebool(8)
> therefore occasionally loses updates.
>=20
> Carry over the pending values of the booleans present in both the old
> and the new policy.  For booleans without a pending change this is a
> no-op, since security_preserve_bools() already transfers the committed
> values to the new policy.  Both the pending values and the policy load
> are serialized by the policy mutex.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109153802.7617=
6-5-cgoettsche@seltendoof.de?part=3D4

