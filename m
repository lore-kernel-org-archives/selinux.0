Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4D403AEC
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768002; cv=none; b=oCdUvqZhzNrD4xzIMhz+lutI6NvUxIDKVUX9sWO51zanKFucaqSvqOhSi2KzGjRQIz91aTatpSg0SiJJYhftlU1LXzbHDwoV+vwvFe0JKE/ZpxRi14/9/YvfSM1luZL/TVJuOwE7M8HiUFhI2wectfFgwZrZ2r0RuV+aoruvz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768002; c=relaxed/simple;
	bh=rp7fakBqRF1kc4oxOMtgY3NrK1AAd0DtUZuDjR9zUl8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BtR/X2V85feL+DK1yQKfCcS7EzcbnHcVS6kRXuwg7osRcxm4F6JTBkCRqIGYC8lk5mwMT9Q+I1pqGYJwvCJWMNYGuXKMJ4KzFsxLGZpcTILgeQ13iBnpo+OKZSOiOoH+Zm4F2dCa/Sg8AHwlevraOwTi3j0tGVTM1+ctXI1m0EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcnqItMt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcnqItMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05FA1F000E9
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787767991;
	bh=cVIoQ0xp6egoC8arXrS8MSPgGEdY/dI3LFBTXfXLCZo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jcnqItMthugN/g/YofP4fJQxAB3PIC+e4GFaKek+4MpTRs+YsszxHXcuuBpw2ENyp
	 NoCICc8/5a9HSM+7CAC/cTootKlkLeIjts4/A8WWBT/KLGY2MmeiFDemPyD3XyTMZf
	 9WxDZH4FQZYbc+Mmz78ueOdOY2U9BVIcnRZC1YTMygClrFudEggPu+PZxLWHxO7Jcn
	 zvaVPAdDBfyuk9X2sdWyoyaL02gmKsbfp+7YinZ7ZFHdQUwdB8oTV+cmiP60M/UzxM
	 wTkfhuZEipZYj891Re2TKx2ZQKKJjEW0sG9fWGNf/bxg8FbNbHdy/I3JzqnISHJcwA
	 dDkaJ9fbHjcAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] FUZZ.md,{checkpolicy,libselinux}/fuzz: document selinux
 fuzzing
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260826180113.6262-2-stephen.smalley.work@gmail.com>
References: <20260826180113.6262-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 18:13:10 +0000
Message-Id: <20260826181310.E05FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Memory leak of the first `lookup_all()` result because the `resu=
lt` pointer is overwritten without being freed.
- [Medium] Missing argc validation before accessing argv[1] causes a segmen=
tation fault when the utilities are invoked without arguments.
--

commit 3407307096b8d3c23806a403bce9d2bd0c25cc80
Author: Stephen Smalley <stephen.smalley.work@gmail.com>

FUZZ.md,{checkpolicy,libselinux}/fuzz: document selinux fuzzing
   =20
This commit documents the use of OSS-Fuzz and CIFuzz for the selinux usersp=
ace
project. It also provides helper programs adapted from the fuzzers to assist
in debugging fuzzing failures using tools like gdb and valgrind.

> diff --git a/checkpolicy/fuzz/decodecheckpolicyfuzz.c b/checkpolicy/fuzz/=
decodecheckpolicyfuzz.c
> new file mode 100644
> index 0000000000000..99ab150c03833
> --- /dev/null
> +++ b/checkpolicy/fuzz/decodecheckpolicyfuzz.c
> @@ -0,0 +1,41 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +int main(int argc, char **argv)
> +{
> +	FILE *fp =3D fopen(argv[1], "rb");

[Severity: Medium]
Could this cause a segmentation fault if the utility is invoked without
arguments? Since there is no check to ensure argc >=3D 2 before accessing
argv[1], passing a NULL pointer to fopen() could crash the tool and degrade
the developer experience.

> +	if (!fp) {
> +		perror(argv[1]);
> +		exit(1);
> +	}

[ ... ]

> diff --git a/libselinux/fuzz/decodeselabelfilecompiledfuzz.c b/libselinux=
/fuzz/decodeselabelfilecompiledfuzz.c
> new file mode 100644
> index 0000000000000..b5abd83022377
> --- /dev/null
> +++ b/libselinux/fuzz/decodeselabelfilecompiledfuzz.c

[ ... ]

> +int main(int argc, char **argv)
> +{
> +	FILE *fp =3D fopen(argv[1], "rb");

[Severity: Medium]
Similar to the checkpolicy fuzz utility, could this access to argv[1] also
crash if the user forgets to provide a file path argument?

> +	if (!fp) {
> +		perror(argv[1]);
> +		exit(1);
> +	}

[ ... ]

> diff --git a/libselinux/fuzz/decodeselabelfiletextfuzz.c b/libselinux/fuz=
z/decodeselabelfiletextfuzz.c
> new file mode 100644
> index 0000000000000..35f56761cf777
> --- /dev/null
> +++ b/libselinux/fuzz/decodeselabelfiletextfuzz.c

[ ... ]

> +	errno =3D 0;
> +	result =3D lookup_all(&rec, key, mode, partial, find_all, NULL);
> +
> +	if (!result)
> +		assert(errno !=3D 0);
> +
> +	for (const struct lookup_result *res =3D result; res; res =3D res->next=
) {
> +		assert(res->regex_str);

[ ... ]

> +		assert(res->lr->validated);
> +		assert(res->prefix_len <=3D strlen(res->regex_str));
> +	}
> +
> +	sort_specs(&sdata);
> +
> +	assert(cmp(&rec, &rec) =3D=3D SELABEL_EQUAL);
> +
> +	errno =3D 0;
> +	result =3D lookup_all(&rec, key, mode, partial, find_all, NULL);

[Severity: Medium]
Does this second assignment to the result pointer overwrite the previous li=
st
without freeing it first?=20
   =20
Since the commit message notes these tools are explicitly designed to be run
with Valgrind for debugging, an internal memory leak like this might genera=
te
false positives in the Valgrind output, obscuring the actual fuzzing bugs
being investigated. Should free_lookup_result() be called before this second
lookup?

> +
> +	if (!result)
> +		assert(errno !=3D 0);

[ ... ]

> +int main(int argc, char **argv)
> +{
> +	FILE *fp =3D fopen(argv[1], "rb");

[Severity: Medium]
Is there a missing check for argc >=3D 2 here before accessing argv[1]?
Invoking this utility without arguments will likely result in a crash when
fopen() is called.

> +	if (!fp) {
> +		perror(argv[1]);
> +		exit(1);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826180113.6262=
-2-stephen.smalley.work@gmail.com?part=3D1
