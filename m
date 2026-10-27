Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114209;
	b=JKwpf9oQEpY5JMJCouGpPZ+qspotRt25vwXLzAPFjgvac5aROeVqzQCvvK8ugs4KcWWH
	 TTkxZP0nj0WSRSR6V1GSTkFaqj94Ao2R7TBOSgyxVw88+1PcOlDSifidzfNqCxw22JgAb
	 prZlc8aBMrBNGl4DFIhI/GFYh+XqMFqmaLAaysVbONnGhp4iUF/5v9ek15d8XZCuO4huk
	 teofmN4r7HOsyWzeKyuq9cmwZj+059/nPEBdifC13RjReHUda8FqCyIqXPWrzdPp6uNBK
	 dL9STUJE8ZoSZ33e/TMahZqjQhklEd2yVjLZSQzeIF9zNC4lMv8lwVJDWbwumfA2THA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114209;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D/Qc1k6A6Rg7Lu5jIek2kQfaTtXie1OB4lk6Z6z0Uuo=;
	b=LObsXKWTICjugYZt0qIw7KMPelgw9P2Md3CVJDzk76V/GOr1UgeyOnyP7mdI3fKEX17l
	 O89Q6ZheEBj4xyCLa14Fb60yszh1rB1Y7suS6Ul3meOaZtntT+U0Fc2RXcVm+W7CD4PnC
	 An9XWBnsH4RZd8Mm6ar27YWw7Yl3fwH0Js6bAHcCTC0yilUxrJ/psbZfLUdRbjh2ALLfY
	 q9va2K99dOv+Nhn6G9tq1Yxb+1I0youwpTiEsN9h21PUk/Bw+nFN8kLoaRdKHyF1ls8Tc
	 Pz+v5h0BDwuMVBWdmVcntaGxe1wY+AUe5i2VaskFFVkf5FI8C6mf+3YxRtByQaqXScQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ix1yjtJW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20B60A2601;
	Tue, 27 Oct 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ix1yjtJW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9711F031E3;
	Tue, 27 Oct 2026 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793114208;
	bh=D/Qc1k6A6Rg7Lu5jIek2kQfaTtXie1OB4lk6Z6z0Uuo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ix1yjtJWWO9GfyUQDsm568FRFQhU1oDyH8d9ceZzDwwj/Eax01d8wC345uJiIGWXl
	 U/NuC4VDTlIUHWWq7wCodsl34YJ1hZoCOW6gSF92BuPnGO6ogHzVSRkrL2CODV+xYB
	 MdElZASNBfcYvxAZJqmK4ncxZPy8SWh9h6wWZ67FvT9iJnwNJY+VMbKsJ95xazMvvl
	 ci7nhefGfke9boUbvBvnrphk4Gowph8FW0fNxUpEd2JtB/PYZUSJJO2vW+iQyBvUsZ
	 TBAS63nhpnvX2upBtl5agK+FmRuUF/FhjnHScw7fVlHEAR2bIBM58VftI5eeKw7bbe
	 LcInSQUCyA9JQ==
Message-ID: <sashiko-outbox-186821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 18/18] Documentation: Update landlock doc for
 metadata rights
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-19-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-19-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:16:47 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Update the user space documentation for the new
> LANDLOCK_ACCESS_FS_READ_METADATA and
> LANDLOCK_ACCESS_FS_WRITE_METADATA access rights: add them to the
> example ruleset attributes, extend the ABI version fallback switch
> to remove them for ABI < 13, and document their semantics in a new
> "File metadata" section, including the fact that only explicit
> metadata changes requested by user space are restricted.
>=20
> The new section also documents the open-time semantic of both
> rights: metadata accesses requested through an already opened file
> descriptor are granted according to the rights available at open(2)
> time, like for LANDLOCK_ACCESS_FS_TRUNCATE, whereas path-based
> accesses and O_PATH file descriptors are always checked against the
> rights of the calling thread.  The "Rights associated with
> file descriptors" section is updated accordingly.
>=20
> Finally, the new section warns that most of the time,
> LANDLOCK_ACCESS_FS_READ_METADATA should be granted together with
> LANDLOCK_ACCESS_FS_READ_FILE and LANDLOCK_ACCESS_FS_READ_DIR:
> programs commonly read metadata alongside file contents and
> directory listings (e.g. with stat(2)) and do not expect such calls
> to fail, while denying only READ_FILE or READ_DIR does not hide
> metadata.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D18

