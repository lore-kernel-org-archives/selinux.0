Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8D35203D
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272286; cv=pass; b=LMaS1crq1tXrXtFmf4OrE6Cr6C/N3NNlU5qBH/eKV7Qyf7Tq571AiQIW3PwMHgGlaLInF+bY9KqdEn6AfEr1smNsYbJMkGa5zgqfZjJow/dyPbAOs8awAXE2nFw4uOGcPxiryemJmwyqjFLa7HcNdz+c8ihQRrXXX7vqbBmgPms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272286; c=relaxed/simple;
	bh=um63X+16A9jofajbe3HhB842Yt6UbVaWRFX9njxMUlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yq4DDmM3AF11/fQK4iGlbNW57ojFM5E8rdgjggR9DONbI6lgci5itydgiNjN8GnmNGs5XwggK2kSBnhowjn9IDU7cNOcEGTOIqPKSne73Hs/tSNdBhmHrCzjNQzzmDSumbnJX+XpU94qVrt++tSN8YPTDFqkvFyj8k8EqGBfiiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN8dbJ+U; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN8dbJ+U"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-46adf49ff3dso1102508fac.3
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 07:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788272283; cv=none;
        d=google.com; s=arc-20260327;
        b=hbMgUMJFEoi/NE4M/65we5mmwuc6xkWiu7LQmDv/8Q22iQTizaui5uCQumUnIiuF94
         QPHsCyPJ2n9MxIqEKEsD1o5hFQvRnE152V9oivYK/UUPwXLqUdK0RsLL316dZ5cI+rlh
         BOBfk02mW0ceMjsvLBu+JSNsi0cEr4Lw8BilN7eXd4OKGZyoZ8t8YyB+XtESgZ185fa7
         5I62fTGK8uz+HORB6mXmGTXOcFf/sZ0iWbMSgu3sqVhR0fhyjip69kN7MeWTKXZ9YvtL
         6A5Bf+aGYra7+zeHfq+R4AhLXQ5TX5VfDrBg6g+pqFbLwB2ll6HnRdT/YXqj09hcjYO2
         94SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=um63X+16A9jofajbe3HhB842Yt6UbVaWRFX9njxMUlA=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=A6JLxtWDBKzRKDKG3yr93oj7UYPGEShnFRw6Rq9PKwHxtQZyVgTg2oxsxmvbq7mABy
         vGzgn4QSdOecaX/X2TzbBMnxAXtqRvimCmONfMCErMHeiXc1H+eR7kTH+FYFtorcb6Xh
         5ZbfUAY/eGPi/uFWoRrKmDH5FHJGHTY6RMM9fU5cB2x39HPhvFhB8PIzhDx8nlUd9f+Y
         k5KXeUfB13QBooIVs1WSRz8pqqIiVMwCTeNCVSfWmm/6mO1GCcySD78DM2h9S8ucSsNM
         gExbYSYYVm0YxAtAT959dtIr0A1TTyZEiUpOqQ3o/JK066IPq9wwEkmqTiNLDKT1sjBn
         IJ+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788272283; x=1788877083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=um63X+16A9jofajbe3HhB842Yt6UbVaWRFX9njxMUlA=;
        b=QN8dbJ+UNymY34Cip08eATF1E5OQ61+U0vmz1DcXBFcEMZyqroADeXI/U/gL3FRWIG
         xE6q7NBZ0yLTfzG6Q0eOPzZIkFoPIw2QCwpBAZfZ5++N9fV+s1V2g7Ne8fXkKAa6I0hm
         u3ty15OzfIVsr1V/1jb80/87BZjbVcrm4upXPGg+RoJN0VvLdiE6PXLqQHl7BtBF0z9S
         1FTobF5PI2hF/ago9ai6fDBuJUs0tWwJsiST/jZoXRrhb2BRW0Qg5ruAD6SgmbxF+8H8
         XJTQYOqa7kT0pEevz3nXefCd0XwoOdcvGu4hRY3PLj0rNNi7N89wmzkDJlgaMkHXGARa
         8r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272283; x=1788877083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=um63X+16A9jofajbe3HhB842Yt6UbVaWRFX9njxMUlA=;
        b=oT8V2FisqPyn7ygCFg6QJfQDrbZngCaMbFIrRki3j2O8aK04wd7SooDnxfxTCX/qkm
         OYdq131WgMLl6PJLoJ0/pyh8mURGFsEi2ijpuzeiIMLrbubvggF9ON3Uf6GotbNJYhuN
         0l7/SG7rdvHk7u2dtlULm/q8om7oatrVk3NXq9zafbq1Ih36Qpvr/XDlYK+pXNbLmn2w
         mcnmwpDQgQk91PMhyd4yJAgfwArCMPybnKN01JJs0epztg/0ZtyJOIx4UiSUNN3ZHbCS
         /pg6wjp2tdKnKoXlIeJ5d1rNO6hjOjE/yazDPhTR3+sj1Y6SrNpTNBO3rnybYg1s4FW0
         Joxg==
X-Gm-Message-State: AFuF++mafWEaKoXJdM40iDwj0NqPrg0W9COMElE0xkHndpl6CsB9zhjm
	XYNNcYDxAJNBliN6MYxpbYa0V8LdH0k3dpoSxx7g1y59D7CFla1PYLJa70RGzhUKPJiLABvQBlX
	qINXaediuQ1N0dpbeqWNW3XhZXRU6i4U=
X-Gm-Gg: AYBFou2eo7oM/fy2wPFs7BuGjtxFZ1DT6CGSINhhTnLpsnTaOlTAm7W8Gg3l/hnOEF7
	k5X5kW2ISre/3B/Skb2/dcaAn6yWyWH3KiyIIBusDSLozPcgqWVoEkWyYL/RFAVtpo+iL9yLbrr
	DfGjWHUSsRdwHwaamH6b+sl4kDF2P3/+AF/y9NwPcEI4gG8rocFCq8qDKLa8w0pfsCD8LjMWnmL
	2scvT48WNNgz3WLBWWzePK5/O7VCi9fdQ+tSbesD3Ty15ErH0zB5Ncg4Jbap3r516KfsF0GOkob
	0Afdu+xpjUl4qeFSIIgwMVzyPdpRqP0DMjMb7Wz851Qx
X-Received: by 2002:a05:6870:c151:b0:463:ef96:b995 with SMTP id
 586e51a60fabf-468360af6b1mr34076703fac.8.1788272283495; Tue, 01 Sep 2026
 07:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831185851.80078-1-jwcart2@gmail.com> <CAEjxPJ5mvrtTvpEmpdPss-_Tr395TsH5rFRreK3SRMZSa7D9eQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5mvrtTvpEmpdPss-_Tr395TsH5rFRreK3SRMZSa7D9eQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 1 Sep 2026 10:17:52 -0400
X-Gm-Features: AcwNN1VEj1mIF1HAV3XNAqd593-7dgZKxjmtrrWYaH9gZrnuhgEMweeoDdxxB_E
Message-ID: <CAEjxPJ4Ajdrs_iMxze49aMzeDF1WJoXy0nZu2ZYgBkKaFzGucg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/tests: Remove non-MLS downgrade test
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:26=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 31, 2026 at 2:59=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The non-MLS downgrade tests are done by reading in an MLS policy
> > and then just setting the "mls" field to 0. This results in a policy
> > that could never be created by checkpolicy or secilc. Changing the
> > mls field does not change the fact that the policy has sensitivities,
> > categories, levels, and mls constraint expressions. This has limited
> > the checks that can be done during policy validation.
> >
> > Remove the downgrade test for the non-mls policy (that is really an
> > mls policy) and just do it for the mls policy.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
