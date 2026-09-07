Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998C41F7EE
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815247; cv=none; b=hffNdIVs18bKO6meqlkGPBY6ANEt5YlXuETTFPZFfoMBFRP38nm+8FFcqRW021El+7Fsd57RPqKgdoIDe9wgV99Y1H6BRvPs5yZXHPDVItNxK3oQ7G/600ZOwPU1xgRO4bOVspRqC970Vqce4BJ1N378d2xNkWLnShCiBbi1WMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815247; c=relaxed/simple;
	bh=Su/in/0mdUCLi6dImCiv044LBWd5ioD5qbI/WEdFKaQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PwKxJOyJ7HIJIrRlgY5rWdHjrQKsX5K9EfeT8fM96aXzMqKgv/Ng4mPd7YHzD2N1crMDRRdEMU45qxNw7NOGgfCqMtMhDfqFTfuQkW5LeWwUBBhCT5waDNw91PfZpuvFelVHicYGAU3H4WjdDiDCVmrRh11/a/Ae4GJm34YuybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXkquI1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXkquI1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184DA1F00A3A
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 21:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788815246;
	bh=Su/in/0mdUCLi6dImCiv044LBWd5ioD5qbI/WEdFKaQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RXkquI1L//LK9Af5Isc9LrSvHfF9F3GcNsfAjPVHUCPex3sDYjTCDTf04oVEmdpCH
	 x/Zwx38Nuv9RMTqvaTa450bVdjicWGSTX+0NY+6DJXkTARlp9S7Ve9Gu7AgxPB1fOv
	 kL6NbsK6ktp2SmWMKTjL0mKkQxwfx4kGdVnk8ilInrnohlz/yLuj8Z9HwNhp1uUPLS
	 m8pAu8dT2h1Qcqe2Juhn4RdA8QRVNvp3Mq3GpGr8Qf8Ep8XoBvBEIAObQ3/D041fv8
	 mkRF1tx1v7LPFVmIxNobS7qpNalHjP7cMcOhKHQh5T46wewfGZ9cjxwY7RhLzPDG/i
	 U6Pyq0rWifQxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] proc: refactor /proc/$pid/mem to use struct as
 private_data
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260907-selinux-pokemem-v3-1-0bafbaeafe50@google.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-1-0bafbaeafe50@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 21:07:25 +0000
Message-Id: <20260907210726.184DA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Refactor the handlers for proc_mem_operations to use the new struct
> mem_private as ->private_data, rather than directly storing an mm_struct*
> in ->private_data.
>=20
> This is in preparation for adding more state in mem_private in the next
> commit.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Jann Horn <jannh@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-selinux-po=
kemem-v3-0-0bafbaeafe50@google.com?part=3D1

