Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C133D3310;
	Tue, 30 Jun 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845165; cv=none; b=h3nSbIp9EsLZkZYWu00ko7MI+HdV8nAVVoUxMedswqTCZ3bsVhrunIH8LTnF14R8MGBanbzwSP0l1AS/ET58j6LbMIcCq4stiTnXTKQwjgmpbkAI9UGTmc8i8oWT/7nMR19zH4U+QIn+HLreymTbWrohQD8FE+1Frsf/LjgFiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845165; c=relaxed/simple;
	bh=BpLQST7ZYpBBLqOMKyvL8YdlIfG12pwc37pkqYYsQwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AHrzk7THHTyjcc5z2QI+fhzI5sQjqSdhIReb92iUnQ50ENRfi/aqH2nVBfiiJT62pnvHB7AtAUCEyXmwyuqeQoUWsAqLOmbBzPr2mSoCAXLgCXz3grdxW7rXjrbvhAxMl39NmVTBJtQjiHEQjUHWZ2Qg/3OJ8GQlNqqTlVYA4bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWOl9KfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWOl9KfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7C01F000E9;
	Tue, 30 Jun 2026 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782845164;
	bh=BpLQST7ZYpBBLqOMKyvL8YdlIfG12pwc37pkqYYsQwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FWOl9KfHzs8T1h5ckzHE0TSvbwwBNv9BNCwoePQ2B+y+tlrGPE49X9YaYdaGDtYnP
	 jbaZFlMfGj1Wuu7GPnD2BZ/V3SCA1u+qM/f3zXj2D0zOOryNkkXu/aSx+WmvL9T9aw
	 82fuwG5iVdId2IKpG9rn/XjfiZF2vnIDhACnmvFdCMkOmmqgVfvyzQW+kXX+nqmt3Y
	 oFuNrl8JnQ0RZ/r6I+o6By4H2LhpPPXzLmV2W+126Onm5e5UOw+joXzvSjtBkQCRCb
	 lz1uU9xxR0IMEF12jEN1v6VvQnFbL0nRD+qy3SSLIxcv0fwM6hfk8S75+/U1KWPxmY
	 1gsQBI02TL4Pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 1/3] security: pass inode_init_security
 xattrs via struct lsm_xattrs
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260630183956.281293-2-dwindsor@gmail.com>
References: <20260630183956.281293-1-dwindsor@gmail.com>
 <20260630183956.281293-2-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 18:46:03 +0000
Message-Id: <20260630184603.9A7C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> inode_init_security receives the LSM xattr array and its count as
> separate parameters. For better compatibility with the bpf verifier,
> update inode_init_security and its callers to consolidate these
> parameters into a single context object: struct lsm_xattrs.
>=20
> Signed-off-by: David Windsor <dwindsor@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630183956.2812=
93-1-dwindsor@gmail.com?part=3D1

