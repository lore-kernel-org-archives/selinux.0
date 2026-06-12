Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1893EB11F
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270638; cv=pass; b=GRkkC16kQF9zAowSz68dhdkwheMq9837yPxacftsJ5JnzVuwgd0prVAjLbUsYUhWOrXPd6FfqTno3Yr1LLG/RRYJdT0PQKY1mehKursphUrd0EN7VoxBHKsGb/mr/xWp56WCFQ1AFI2oRG7ChKyx2DHiQktJqcyrIe5n5wu0p9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270638; c=relaxed/simple;
	bh=os3K8F3jaWho4Pnjh13GgcLapPWTLhxu/PxpyEpuTHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1rWSIlyI4KmnKZeE+dsykYehHNfi7rGpQS89hw900YyWwW2YfR6jAAYR+PH0mVNHNQ9OYHGjrY0sj28juJNYziKOqK9uE2iHRv9NP5Arz4YzP60//gfA1DwJ1uyLamFTS1tCll9h5UhzNHv3+SrselyfV4HD3eoxY2BXU3+q3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dikDHk4c; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dikDHk4c"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c85ba774551so364367a12.0
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 06:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781270636; cv=none;
        d=google.com; s=arc-20240605;
        b=b0TMOcyg3S93uMAMTgPZWNUTAD7cTClSgS5v60qrHtEe2xwhMuvUB2F38k0yvxAKZx
         xI/rbtgYtH0r5xOE/zl+RiIVNNRC2DgtDUSSGiEz7f+DWfZSva6kF922AT3tSN0znnIo
         q0RpUhhSMNtzrd4HrWKH2kOgDMG+pG9kwxJ1XHHQ2jGk4ceEa/GXg2AjoRBz+FQwZ/zm
         WJZqjkcDhhRFJfMKseU8JcYke64kioypdyN744TnyrRSEiY3qaqbFTzjdejCOD0/Th+X
         b9kjQkBK3nQXAPwBaYIeh43vtS1qAood+Dk1tCVORSTdcX0YIjyky9CHnzr6ZmmVtbE4
         L+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eFWv4wfkBl9eYFIPP6J6PoMsN/EOAHZz3fAoFUJ66ow=;
        fh=Br7Q3QYCCAjnvhHaund9vV2LCS9SOjHrWaBcZeLdftU=;
        b=FVaRZDyZSwdTjQqzNV/1QtdlSjuK+dyetyPWWy1LLndLc3L5bPkh4nkJGGJBZpMJC9
         s1qT1E5Oxqjz0z1+sPzmf7rcRa7eGhidpqtbDE/cgqTXcizGKfbo+zGBghy9nDLQEZ68
         YKhiNdKYfvwOyvCQcjz10hlurB+TFAHNBQJHVetfJwF1dSZujCneB5/Akna7wSnuqS8U
         vXvbm8YGSNGJiZmC+YnyGZmK2F24nKCgcH477JMsR/7xTx09w8CExzIP4rDoRQFlRB2f
         NVC1hdf8UJcbhwJfj54aMqiIIxouwnkRsNW9vr16JlSulSLYkfqqB3dp7K7SekoEys2J
         sedA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270636; x=1781875436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFWv4wfkBl9eYFIPP6J6PoMsN/EOAHZz3fAoFUJ66ow=;
        b=dikDHk4chzC1D7QoK2LTLMg6tKkrR3U1MQc4IFKVn9Zk1rA2rtL+VBHPWvHuufvL9u
         6gWM1VKBUyzBV6/LW2H5qU+ld+zKfFOzZ9rOYrYgl+tIEkuCqgQSunffV1bBbXYKXCcS
         9iI53wXEp6mntVvL5hHWHMIofJQ7wUlwniRv0G9nS8PBrLVPQI6CNU/dd6Owj/Co/Ioe
         ix676MG7sKUUzoiMod0W9YZ7y8QFs2dL/tjtS3s3qCXx2SqDeQFV+H5RkoXKi+Q+arjz
         k7/HkOf5mh7qHaB2necST2LamA5KXamGZWQpEax/EX2N3jRm4H4LejzPgG0wCGd/MdZh
         SWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270636; x=1781875436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eFWv4wfkBl9eYFIPP6J6PoMsN/EOAHZz3fAoFUJ66ow=;
        b=H4VoN8iiTjqzQkH1T6f5PV/z0g0NjAIxEn8TqyhGb50I1cRp6FIVBTAQU6G+gXF9Ra
         5KWQTgjZUD/q/urKigfjf8K+qNsmy6P0C3AfsGvIA2r/MOtNFZYmGK36M7iA7BlRMyf/
         xuKzojDYtGw5pYS24azeI0CNkkFWi3m4Gii2kFPIYegCldEPt9926LlKjFNpU6GrOHiJ
         AgNNwFefE8izkCQ+x7LAgJNjtWPhW8F6s4PMDAM7VdUt5e0cuFV7L3KQFNYjKxftE20c
         3XT/cc0IsVz5C5eUr7qe8A0aK85p98L0uEPmUFYfKCxMpDI1+bzLQrvQLdu5WhRGLbT/
         DdhQ==
X-Gm-Message-State: AOJu0YzfIPU4/iXdUq+iKQbzt3DbEat0mmkwRLpI5ZfWEtJ/DLCVE3VH
	2E+SGsbh6eb28d7Lyk+dnPJBuFG0xhjFPSl5IVQK+dyQsOfvAkpOghy+19BwvWG43FsNj+ChF7W
	JGa5pZwvor0Mcnhf0LbBUjivAX3S5p6o8yPf7
X-Gm-Gg: Acq92OELgA4aELmnC7SoyiRCLyQlIgVZytZ14l8tZvgLZ+O9C4z+lvSlQfVUChaK8M3
	90PU2o2htse3FnacrmJguRl2z5ud8ZernEu+PQ1ztH6H7ZI8NDMq1BTIwFy2OnD8tHIhYS/iJ+k
	BTlfUSlBy671iw0beFm3zXuR/i/blH67ixIu8TEFT3nEUtk9+C+AZ+An0xmCUXzXM42DUYyqjtp
	iQArED4ofhPOmVOOjSs/PC6s2S2pt4YAPqm5d4H3FA79DOyl0gny9Z3HXkPD4AN3pm6MQOE9+ce
	/IfMdHk=
X-Received: by 2002:a05:6a20:12d6:b0:39f:216:f400 with SMTP id
 adf61e73a8af0-3b783ba832dmr3506032637.14.1781270636456; Fri, 12 Jun 2026
 06:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610203137.411393-1-chpebeni@linux.microsoft.com> <20260610203137.411393-2-chpebeni@linux.microsoft.com>
In-Reply-To: <20260610203137.411393-2-chpebeni@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 12 Jun 2026 09:23:44 -0400
X-Gm-Features: AVVi8Cd04BR6mIyUN2fvf6xE8ONqaKk6vkAtKvwEYGxSA6kYej-bC3fFLMM4Go4
Message-ID: <CAEjxPJ5J4zaWskh3NO7Vm1KLHUudEB_Jsg-DSTM5RU0_-RVHFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] CI: Add explicit output variable for build-userspace action.
To: Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:31=E2=80=AFPM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> Downstream users won't have to rely on DESTDIR being set in the environme=
nt.
>
> Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  .github/actions/build-userspace/action.yml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/.github/actions/build-userspace/action.yml b/.github/actions=
/build-userspace/action.yml
> index f5d21b7c..03f9e0a2 100644
> --- a/.github/actions/build-userspace/action.yml
> +++ b/.github/actions/build-userspace/action.yml
> @@ -16,6 +16,11 @@ inputs:
>      required: false
>      default: ''
>
> +outputs:
> +  DESTDIR:
> +    description: The destination directory for the build
> +    value: ${{ steps.config-env.outputs.DESTDIR }}
> +
>  runs:
>    using: composite
>    steps:
> @@ -64,12 +69,14 @@ runs:
>
>      - name: Configure the environment
>        shell: bash
> +      id: config-env
>        run: |
>          echo "::group::Configure the environment"
>          DESTDIR=3D/tmp/destdir
>          echo "PYTHON=3Dpython" >> $GITHUB_ENV
>          echo "RUBY=3Druby" >> $GITHUB_ENV
>          echo "DESTDIR=3D$DESTDIR" >> $GITHUB_ENV
> +        echo "DESTDIR=3D$DESTDIR" >> $GITHUB_OUTPUT
>
>          CC=3D${{ inputs.compiler }}
>          if [ "${{ inputs.other }}" =3D "linker-bfd" ] ; then
> --
> 2.54.0
>
>
