Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E43B8BC7
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364163; cv=pass; b=s54LwA4tiAuzhVAZqdGpkncw83SffHzR0ItfvEop7NEGvvHf51N9vKJTSLDoZbnFZfQinwsdjLp49iVMpvtPaHvR7h1alBMFs2H2Z8441EZlZOhVaAWJtYi5BScSyACqaHHS80UIfS5RUhZ+phKTvy1IsR+LeT/77DGyJpvwy40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364163; c=relaxed/simple;
	bh=hSH8WS3tS188wgjPpb9XXLrB3hGxxBwgTc0dNgChtLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEHSVwTvsOEf39w5y5TcKhnF+jz19228sbZsc0tVHnQbQ9AXngZa4BnOyUQJYFM7UN7J6+z7+XXM1V3hGOKIYPbWGlQKVTvuis9QMPm76bqlIUvIN6xqVAIVPZaW9K8LR+xBuKlCkK2DE4VRAyN6W2YN16lBM01k6Ie7jfu7ygY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfSBSscG; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfSBSscG"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e532bbso11419627b3.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790364157; cv=none;
        d=google.com; s=arc-20260327;
        b=iEnbFVsDNy8ISvUyJiA2P9806jCs56s8q029oh+9QdT6lQd/nwHq8/TQEL9kqpJWfm
         O3WVHltmufU4TKMbnHzlfbQA7tCs4mFdoAeYHUiY5RyWIZ5AKah1wVQthgVD0oEDKPke
         ZUi/RaLKQBH9CuWvBiLFmgrEFyTKCM7ydqNS3LFGsNptQrF9WMFtyeM6II53L/u5v7Xq
         XwiB+2yzhwvNlrpO6n4pSqo6xY3r28Jwd1+qKjhZYtlQe33vFS1VpcUQXUh9m1ve8m2R
         c84nmK7Ibp1u1iTfwPNn+GmNbGJzPPyOjSjgMaVQUXVgq4wCmTqrM1P9A7btSeC25Gqd
         dAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g2priry9EoO1WJwfxzLFd2g+exYYwHRw9p216PD52wA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=QYHZLtzp7qHe2bjaitUe7Xz6M0M9mJn4kcBgvw6UB+uB4WXIJagUPwtu7reeOx5b+G
         MXA8swMA6HxgvhyH6QdwGybAkeLgJqHDOATioyxzzaLvNsybdKe4Fsjfa9vbYe2xWRLx
         G1M92h7KI54MXVIqj1wGqPJvUaNQsEVx5hVxJQ+WY6YuohXCuUW/SeaJ75PoPkJwQx9F
         7awPqKew7WVBRvVF0IrWuZ84cOZDWjfx94CgUfWIBV9vusOCaHLRYRNC85BFamBfshc1
         IDe3cTKY1B8Uh4BiH2km5gWNnb9AGpIbeIqKm8ME1gREpsGt3UuT24xCYgkF9Vk8R4a7
         /Z/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364157; x=1790968957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g2priry9EoO1WJwfxzLFd2g+exYYwHRw9p216PD52wA=;
        b=cfSBSscG8UqHQZkSBEaU1zJx2chBLcpTltZGBu2gHN1l5a9NVABkJJSubzu+0Q7ERD
         8lTcrh7vlvvdL2tniDACH6RCRS0bir9h83En03IIkpG5jjYHwjG1i1smNiDVeNZJP1pa
         74WYXRbKhr1oi3HvkUZWVrWrvehsP/eLJ10yw6055crW7TAt71ESTgVqVkFNJT2BLfzI
         JrBuDG0DlBQb0Ocuhr7GCeEjS9fZ6z+4CkQCfQyTI4VVSR59gaw0PbrA14X4tLbzu7iO
         ltrZgGBNEbiqZKNerfL94qTV9Fzg25z7o2NCwVyIZ0lQByuJ5orAWTGaMfIBMepxLWnv
         SZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364157; x=1790968957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2priry9EoO1WJwfxzLFd2g+exYYwHRw9p216PD52wA=;
        b=J/sVaDMmGIgfvS1wRL56bRVg1XCjT78tsqUDheFCYdgsv2q+dximn73DuJDAdfELdp
         R947oFRbAbYV7bBT5i3h7J0cfasLaLX0f+HwEJzSU2hZXbcsawl6+kUSKFMqxHCshgUq
         e/oxhx+p1OWOHQvDD3ccW70clWLbiqH0zsxyp+Qb3k0r7PtQk4SWaUHVmNLCx6/06i7W
         TDr+lyw9+nv1Gz5I/NXwpymgljy93FijuO9CALXo6uDQuhdbwLkvNC7hx4WPgdarwPLd
         X3jLh/dV0Ch9odNjw5a6qwxjALrSm1wHBfzxX50jTtKBPu7WCYDLNFOmtrm2yoKgPHxT
         42rQ==
X-Gm-Message-State: AFuF++kln7gXtNiw9LcKSA0sqHIG782F2qCpad+KUULXMIrOTosQJXyR
	6nT0An8bJTOZQbnBX2c8Gya2nILghQgK18lALFxjeocDUtfhErbM1VtwASaNKEQLk58J/0E5WQr
	ftkBKZNnzKz+YRW1gAWd49STV6Oor/oq0fvXE
X-Gm-Gg: AYBFou0EleeYfo7tgie0H+8J8ai++ugXZhTNzKohlaSX4nQ8hh7aWqoG4jmv9MVmxNS
	YXw8B/LfVxrxZugKUnZLdqz3yneLgyzlFmEuX9m35S+dFBzqj7bgiiKX99uW2CXLfoBAV+3Kwl3
	6M10O0JFHgFTPldfDsvXSpyeVD3EiryjLJB5fN1d0FU9j7936lXAVa09gqEuhsXs9GIee2YkPUB
	vqiJ0bqO/d4/KSTxEDvsPc2URbSFVF07lSxDFMgbWMp0+cjQgs0/fU7DGadKAeRdJKM4vWWqnqu
	mjFSHQaa0n7kqqyMq1Wvqc3bmGSFEPYhFX3pF/G5uRPuQgWNqEWIglgAhXZPXy2etGtLB9iFGng
	3
X-Received: by 2002:a53:ac9d:0:b0:674:a69:249f with SMTP id
 956f58d0204a3-6740a69257bmr1591624d50.35.1790364156587; Fri, 25 Sep 2026
 12:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
 <20260925171755.2029271-20-cgoettsche@seltendoof.de> <CAEjxPJ6Kuxfn=-ShTD3r6FKS1exVV19XgE9a2HW1YELgToRZUw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Kuxfn=-ShTD3r6FKS1exVV19XgE9a2HW1YELgToRZUw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:22:25 -0400
X-Gm-Features: AclHuK-whFOh0ikEUd_kF055i_e2CpnLAZq5fu30fyscX7Vfl-WypZe_r2YbheI
Message-ID: <CAEjxPJ4=-U0sYUsBV_vOL=gf3zowFpGnjT9qn7DyXbAZPhQKRQ@mail.gmail.com>
Subject: Re: [PATCH 21/21] tests: drop headers from Makefile dependencies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 2:27=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 25, 2026 at 1:22=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Clang does not support header files included in the compile command:
> >
> >     clang -g -O2 -Werror -Wall -Wextra -Wno-error=3Dunused-parameter -D=
_GNU_SOURCE -DHAVE_BPF -DHAVE_FS_WATCH_PERM -DHAVE_BPF    bpf_test.c bpf_co=
mmon.c bpf_common.h  -lselinux -lbpf -o bpf_test
> >     clang: error: cannot specify -o when generating multiple output fil=
es
>
> This also drops the rebuild-on-header-change dependency (make's
> builtin %: %.c rule uses $^, which is why the .h ended up on the
> compile line in the first place).
> For this tree that's fine, just flagging it so nobody adds them back
> for the rebuild trigger.

But regardless,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
