Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F3432E97
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174841; cv=pass; b=L2bxjUrrmD0i8Qxm63KIuO4H3oU+rIxiCP4WHselswp02Xbny+pyjwTwBjsp+cRNFw66aQi9/A4CQffnTc++fRbNggwd0Ixm6bCxBOFqhUBFyAvfB7yXxldKN+JY4yDC1xc5bEaRYOsrtQSex3C7UQqomsKkK8qsQErcQoKkbCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174841; c=relaxed/simple;
	bh=YbCEkmtzEpd9MF8jhdyPab/pYqT6CO20l8vOEnh9cTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxE3hgMrXaCmhUmnaZIENNEXjkq9er15m+TER9Vo1P/yqzKLToTlRLFGfJuA44tYiYYXLMAUdwGVHRSKIzjR95StSNdWu3zPL8hzkM0Y4DL12sm1TkCSw0eDPW6rdEp1EgYc24oZHQReFrE7N0CjkjxgX1hGK/zmberk0GO0LUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T97M06AR; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T97M06AR"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-455a61c53d3so1583678fac.2
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 10:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785174836; cv=none;
        d=google.com; s=arc-20260327;
        b=r8Wq6sGMZlMFNsJRCv8tMCwcmml2I9Hhci241ORBjxJgn9qgOK7XbBLZAvN2d7tJdO
         CsaDpr6xFXEJrGuHSG7RfzdzhLo+TN+6h9OXoz0X/K/fKZ7AM/iTDdLHnmW+TKnD3e1U
         Q04L1E0JIhJxcJNZgo4k3GXYHhuqrCyvtwcnP6XvB/rhzJAJyjiDBXZLapmP6d5s8knc
         DgTOvUwmQCqPH2nQkmkrKf6IdGOz+UqyLgA5DO92Exdtqp5gufOHuaKlPcqhMC+giko4
         EHoihEDYP+ol7vCLq9DjttpJFcK+9IV+L0jS3hbnX/yDa1Cd8i2b1/aTVbFb37fNUUs7
         iLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=asDuq7HQd+y7fPIyFEfFs7ZHMQwfmfn+DJJvegVruQc=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=CXfAdK5yQk0Q4mERc+XP5KbnpSmikQFRmWhbRaf0Cs2xlx7KgqwEivHKSI8JVFuUQW
         2bRkxJX4pVOs9/6cG2704K2ZIKf365lJ1FuwYvmqE9ZrasXyAWSmhJ2etOFJaohEFXun
         jJB9claVhmmzKnMXzZjKz5yN8mxjJetSOvLkaUDgDAL4S0v4j4NvTbB7LXWwoNNZyoCz
         /XvJr9h7P2E+uPFTfmivQJgWvsWHCWmQ37ojnvH5nfnDan8JbSlgFgn82Hq+mvXGefSy
         VIkBDTSJwvTV7h+9R6LWVZgkI5+l3C7qL5e282TLHPaLYKqz35zB2+bOZs7jvsMACUUJ
         9nyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785174836; x=1785779636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=asDuq7HQd+y7fPIyFEfFs7ZHMQwfmfn+DJJvegVruQc=;
        b=T97M06ARb+XowvboX2RUDZ5XX5slDMiEYmAWVAadqmKxigNxo/21hCGHkud8QJ31um
         MbWtkrAGdZj+cDDm6jhxEiKO+mDNL+wLE18eTVRmrgbrPsGnvIsYNjFXawu/vG1kyQ09
         gYaJtKif+CSr8jKF/Y0+8tJ5wvswD0pKbR4KsquYmHQ9F229+e9DqA3WQSdAuCxKchVt
         nCpUcgfWDZnd8w/LSB6vNHenVvzn7WOTTNl7Q/xjNzBA9cSKkOVOc+g5z3Ev+ZgJcaHu
         dBXWo4BHBi63E293kTIZ7h4eA446dP82Iq6KuBVc2gSLitMjhryF9ucccqgkJRk6Ol5P
         Z7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174836; x=1785779636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=asDuq7HQd+y7fPIyFEfFs7ZHMQwfmfn+DJJvegVruQc=;
        b=VJ1lqQyUo6s8tzk0S3bRXCWqKcnDPy0gkj2qx2OOsXn8uisjCC5UvhFgYU6V1hg6Uc
         xolkGsVUtbMoRN6VM8ccTCHMuV98Qkg1/Ahde5FR/jyFuduE1ugNQnXb38Vm+g4svI1X
         CPLKg3bJuJcq4o68XSJvWmhlt9s0bhHrQyyKn+sfsXOlEjlaNkYpH5ZOO91oOPdDbp0V
         JtZDDdDzMsERQ3sz6nGjWBSOU1zdDwblJIA4tOrSZH8K/FVAwGlL6Y76DGJFsxC9CF8t
         xTTPWmQKpgIqXd/U0CKf/R0Qi8SvKAiA8nTaT44Z+ZnixXwfKOW2DTCHQunkDO3QAdnj
         wubw==
X-Gm-Message-State: AOJu0YyUPe7PxQaw4I9lMDWf/y0UOpI/8JB1pWk1rgXGO+uwxwYO2oSa
	AmqVVLxMvmRa8KtMYurrR+Wmhoi21pDVhIrQpeTB8PXCMWFqNs5VlXIObNvk64KR6qNDcN7ct8A
	9ROeWoImkwUgMwUb4AmsjkTctO/xiAY4=
X-Gm-Gg: AR+sD13kmHqAS2+j2PRJRcs8UCmrlqaMx8+5cWm8JpoIMxRvFkLKlbdLPHAQ7nH7UmW
	cTL3jzN23D/QfVZzOM2Z5n28unfU4ihZC10mBq5bZ8yMJobgc75okhvnoWgiMjh/qai17BnYn+K
	q/9XOYRPwk6/Qbkj5IZbv8CCvCk2RLMlzfQ+NswZiqF2TsDIaR4oMrfLXcEWz9QuG2oajFPoMQ2
	M1bTjmN2pKI0dn/9cBU8MIG6SS3Bjnc6KvfhRAImBSNO0ulvcDn97OW+0fyHQ==
X-Received: by 2002:a05:6870:d621:b0:448:604c:bc63 with SMTP id
 586e51a60fabf-4585e0e89d4mr456827fac.18.1785174835892; Mon, 27 Jul 2026
 10:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727152518.2495266-1-akkohli@redhat.com> <20260727152518.2495266-3-akkohli@redhat.com>
In-Reply-To: <20260727152518.2495266-3-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 13:53:44 -0400
X-Gm-Features: AUfX_mxolYoszdfBHGJT6EsfkxbiymsAY-U6eRfse0LgQRobg0TwLkbGFzAwThw
Message-ID: <CAEjxPJ7UXCc3DWaAcpmVqL-Dz5eHCCsHWX+4dYkfw-CUFEhSzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpolicy: add robustness tests for large policy inputs
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 11:44=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> w=
rote:
>
> Add expect_robust to the checkmodule negative harness so oversized
> generated .te and .conf sources are exercised without crashing or
> hanging. Also cover a module with a large attribute membership set.
>
> Fixtures are generated at runtime to keep the repository small. Test
> size is tunable via LARGE_TE_ALLOWS, LARGE_CONF_ALLOWS,
> HUGE_ATTR_TYPES, and BAD_DATA_STRESS.
>
> Also fix expect_* to return 0 after counting a failure so set -e
> does not stop the suite early. Same bug affected the older cases;
> exit status is still non-zero when FAIL !=3D 0.
>
> Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> ---
>  .../tests/test_checkmodule_negative.sh        | 178 +++++++++++++++++-
>  1 file changed, 170 insertions(+), 8 deletions(-)
>
> diff --git a/checkpolicy/tests/test_checkmodule_negative.sh b/checkpolicy=
/tests/test_checkmodule_negative.sh
> index 6d289a4c..ed7202f5 100755
> --- a/checkpolicy/tests/test_checkmodule_negative.sh
> +++ b/checkpolicy/tests/test_checkmodule_negative.sh
> @@ -136,6 +150,138 @@ expect_fail_unreadable() {
>         echo ""
>  }
>
> +robust_exit_is_crash() {
> +       rc=3D"$1"
> +
> +       # Fatal signals: SEGV (139), ABRT (134), ILL (132), BUS (135), FP=
E (136).
> +       case "${rc}" in
> +       132|134|135|136|139)
> +               return 0

You omitted KILL (137), so OOM-kill would pass as finished safely.
Not sure that's your intent.
