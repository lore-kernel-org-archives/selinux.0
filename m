Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114041;
	b=jvO/plmH8UVTGujsLPFbTHRpwlCWC1PQl+jhwMl4qRhd3jABwA1sERhrNNbts57U6HU8
	 k8a3f7fJPAUqLrlIfvwv+lkPRClJ9gra2W7KkF75ZnBUeJoeHuwGeiNYPzFWRHItEd/sN
	 8UwqgeveXRpiYov2IgqU1xKkLloqgz1sbiQTjavz9RO9agb/YVxFHTHBXclpjS8KlPzcA
	 MiSzkJ+UrpZYoFGCD0Cd5HeUiIQWj0iXPSr4u4fNzM1TWZaU9smNH0ip4pMK3ampcIgQm
	 DMG/sXN+ON4BcP9AO84cjXQL85AlTzTP2nLCPhLywPyO1/cKhZbTchd+n1tKM1lwYew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114041;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OEXLKJg7/OBGpszmdxgFL+cxKpMPXn5L7spM7nWukX0=;
	b=JuB/oBacOVn3uw9uJZtddlCeeII0n9N3lbDbD0E1HLBc75qM8XhrTL74/Y6c/OCE/ykC
	 sTLdCuTNFdeImKo+nUwnPkwq8NI9xk/VJ/5tyiTPQri/yxe51VLMZbpwYapofVPxA82RY
	 Yn+6ZIXSB1B1AFnTELPfrVN8E5qOsIcUmH80ax25ywUaj0N6TLklLvkhGePLro6EOC/zV
	 FDPZI4AB2/lroEJOURBPVARnpjDfkhKz9xJtuOCvo2woOhG0RUEqctBCGstp/GugrdvnA
	 TPNOfXIHBRbllSp7R5OT1OyO8DMMx3zboz+0iC8v72r9fdWiCcjJaJMNnt5+ITCE3VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eI7RHgfw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34E606A322;
	Tue, 27 Oct 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eI7RHgfw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11AF1F01825;
	Tue, 27 Oct 2026 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793114040;
	bh=OEXLKJg7/OBGpszmdxgFL+cxKpMPXn5L7spM7nWukX0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eI7RHgfwtB09exqPlc+xy0vjfkwOFr1G3qMdngxLPn6sIaXcwa+cwMRdwn1UQUGQY
	 GXf0as9O2TeR9AV5xwmaCzrIq3K0fEqiBLNe83ObJB7QveH7pyytx4Ofv0LNpGXA5z
	 LBcZe2pGAIYtT6s2WUcvJ5DEoZTP+82UCJlwjaSF5HTcbl9bQ839tfUYP5K0R+ssBf
	 WJ/mDN4BV/O5h2G/ZkcKiVRekPo/9oLOzaUNzszgsqXCNBgh2HT4jUgJdzcMH57972
	 KnfN61lPjh3yYcDEvnW9NvW9czJIHrM3/g11XaH88WDyPyFqE8Gt8DHrLMaXt7tJfF
	 2XkksikNIpy3w==
Message-ID: <sashiko-outbox-186815@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 17/18] samples/landlock: Add metadata rights to
 sandboxer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-18-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-18-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:14:00 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Handle the new LANDLOCK_ACCESS_FS_READ_METADATA and
> LANDLOCK_ACCESS_FS_WRITE_METADATA access rights in the sandboxer:
> READ_METADATA is added to the read-only set, WRITE_METADATA to the
> read-write set, and both to ACCESS_FILE.
>=20
> Update the ABI version fallback switch to remove the metadata rights
> for ABI < 13, and bump LANDLOCK_ABI_LAST to 13.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D17

