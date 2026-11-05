Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915164;
	b=o71KSENTvalyaA0kGJI6LeN2HPSNVJEJ600UGtiUBkFBBpL270LQtlyVtn35yEZCZ9Ts
	 J9i6PF284MazslYHXO95Ft6LPdyfdUd686Fw7vXVMwjddrigjwLcRpD2lqO7MJjJrpdvb
	 SaNAtje4b+vxnhBPGaNkECJLJSmSsjAzRA36QYAfmzk3U3xt+aJdR60RFBmiDivSoK2J4
	 dlDOLPAiQXI/XTJup1rUqS8hxvBJCm1jCUo9Pod0lU7sD0hR6oUZAhG3iJKpCoeaOAN/d
	 bhyX2XvyhfcMSDtvfSgoY9Fe1tVHXNhckntQe/afESujOZxE/mpjF2wBaVy2z1N+C1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O8jTA2aiCfAucz36DtfWfItbCNYaQRoNNcij1JI0koY=;
	b=WKWK5iamXMxYfs01zQnSNh1cRQcTsEUZS+o/QfHJJ++E4GN9PDcQoutkrsv/qgPM8fFO
	 OJ553UHUDxOthNmC/xmk5PChWr8nKWxf+Hx5RmEVamy+nYOWgTKzpQy2nOl4q3squBwEl
	 oTXm8CR341/7rIYmZEOVBQYKS78IfHKDEDhDEn3BppeKsSL1X1fQ+y4mL9ETrpfc3uzs2
	 xo0gsUkOG5wzCzvNFC472S1l+FlOEVVBZyQvi4CjPiok4aIQ9jlomJ/IrbQ0NyHWBZoqs
	 vAgAjaZEricx5WD/SIIuoK7MXOuisSvkKK0A3i2sr4Mgzh/5GJs0kNA/ZLBWUpReWvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xe7ebI2y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977EA606A32C;
	Thu,  5 Nov 2026 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xe7ebI2y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10DC1F0089F;
	Thu,  5 Nov 2026 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915164;
	bh=O8jTA2aiCfAucz36DtfWfItbCNYaQRoNNcij1JI0koY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xe7ebI2y0bEnKEQw4VxnzHHuFx6Lb4zUeeQ1HIjYrOvIUc8BsNv4eOrt8Bvt89KNM
	 LoiKnHuFWiABSdf9ibspRi01MoZoc8g+u2Qldt7gEMPiIEZjNIyMJhSKLpV3K4u23d
	 ZUZ/6jzgFzQBxmxKNmCI20ZCx1HciQr8MvaWrIN5vvv4NzzOb+jHbuitE9MZE583cL
	 GWHyulA75dMPFV+77DB4izYRm5ijbHCJPmTVRzqNuXtU2uld3oThqddBdA89aF9bAE
	 5FQ3Ae5PdDX9BHQuoHKapP5JDPZuC1ZSHxWacSYieJTOd8agWD0915KKPXrsdNNdSw
	 6XUPyDnhi/8NQ==
Message-ID: <sashiko-outbox-200267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use
 vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:46:03 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D13

