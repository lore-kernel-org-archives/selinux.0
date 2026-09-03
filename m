Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92F4B1487
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443458; cv=pass; b=rmU7Oy0kL9XJmUpQtfzW1TUaDNi+n6p4HEQyYSbjykenCj8avnDjBtti+7tq4WvqjhDSLV6WMFQ6/mFxJAmbDgdabsRbXsx/VhLNxTRoMIpn7Ag/4JYlqtj5yOnhyMEPHF5u1IXFFgjupQC+6PeSJjr2tfUngf9ObVUyRvc4szk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443458; c=relaxed/simple;
	bh=WHKz2An+tl07sa8d1nBKcvpW/RH3QlxMUF3Rz8eyp9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORE5tSDUbUdzkYI/sWFmjeHwsyZtPDlMdPuLMlBxB2UNXQVAiWddCVEV2l7pbHUbakVXLMiPzWLM75sUJI3dNdGdC7jcXjoP73CL//MJSsREQY9Bmgu5vIVmYIQHiMS1ZMEA3NIIXPM5/BjInh8VfVI0kA63xX1RW4AUKleK8WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPEk6u7D; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPEk6u7D"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4472500e25fso1137749fac.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 06:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788443438; cv=none;
        d=google.com; s=arc-20260327;
        b=YqrxpXMdv+trX2xJJhQOpctWQwIBanqwq7f8oMSuvn4t8mUB5nyAB197BPnEyrjhFA
         AQWoLcNeUQOhva1NERtOeoOplXVkBL0ZpZlnyHZ/XyDquRmKHJnnP1rPTfKg4mpCdHI8
         wGLLvNRBQjlNEy198TLKe6FbQjLgSUBiSIP78N0GbjJ1CvW7dF6vmqyTH4qnnoOAU6QF
         qsueuvkK/kFrK9G23ZSgZbtdJMoFn+4moykh9/SwW0pnExdjv1QNY7hEjuaBSbhOdwK9
         VeyKy0uz7kxO1yxyB0PogXxTXCl7udhZwvDpp6Fon3DhDQJkw29CHAOJcWWuRKsdP223
         hFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHKz2An+tl07sa8d1nBKcvpW/RH3QlxMUF3Rz8eyp9k=;
        fh=aUbqRQkq61ZAI0AgKTda9vTeDxp/LdA3hosIEHHauP8=;
        b=A5rKFcCNOgRR40pxqxOFzi4UPPcqaNIOmVpCqh/PjJFiVrm8P53Q5MHjbcc8VbGcST
         DDfGLnfdWYcUmvOiS38YuYAECO8KXX9VyV4IZxG5BNcEv4QEy8djIyoQ2MNuqq2LLw6q
         kxk+aUuRGRqEhuZUolxAugVzpWa2Y74l5wCj+v0JghpajV3tTe7uke//29UZL5ahWlAP
         vKk+5CQ8lMpiYSUulDe3v6nQgCCKv5hzSSDXkg1iBzhyYTmaLNEa0smuaHaj0E9VNiUs
         FfcRNnOs3u7kxe+qLk5KXLTJ83+TYb6GFyOU2JZHrmB3yCILWLbtvIMOWSVLfbNiEMMf
         qgqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788443438; x=1789048238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHKz2An+tl07sa8d1nBKcvpW/RH3QlxMUF3Rz8eyp9k=;
        b=GPEk6u7DM/watBTob/8y0C0rNFj4LoHEowaccgRKcyuNG/F3EdIw+PdtJK9Bvj53l9
         gdKW4BhOS+jE6WZENybVPiYfkNntjslj3w7qcx3ZprSyVF8Q1zF6oDImYG6pPM6cRYBm
         YkqH7QnCl5ZZfLHNJyCWMoY2kxPUmnsRx0qwbc9WPFCMlbdNd0Ii2pfPz+O5Xi2v/lff
         yKfN88iOeUWVsBXwC1WJwC+bC2L7dRQhrUfakxb0TVMNHXhb5CYFX/XflQWc4zVoskej
         fio3XCgUqPfd1lS/QB85PPHqxTrGY0qtkEpHIXb4C0upW88qG+lQ7CKiH7d0byM52OpL
         joeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443438; x=1789048238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHKz2An+tl07sa8d1nBKcvpW/RH3QlxMUF3Rz8eyp9k=;
        b=JNhfFwwaqgKqamx54cOfXNEVu9wxn4qWPAoHBQwalqeQDWYJtrvTjvrsr8P2h/rQgs
         O8aZ57UALSm8Sq6lELfk5eF0h1Uz8KchKuvnFokmgQeBj4OWIY5U9VosESS/+Y9CF7HB
         pifLYNPH1vojzuas8wdGu7pqvIx7UWZaDRVQrs5Cr7fh79cXIZIe3xJq7DY+w9lgN9Hj
         IlLlpVrwMzj1+5Zc47PcbJigZ6uFJEeyodMeqaaBVETu0rCYW0wTVWbHJ50bxt2GcrtC
         0j++awXMOLeZVoH9xKDzd6yRhUsveiVIrV7/FQ1+0XGdPGRc491ou/7Nb69eYgO1/MuS
         EE6w==
X-Gm-Message-State: AFuF++nqfF/rM0BNvV7j79WANQd4yR2N6hyM4zgoy1+6rLrq+/oq97OV
	cc59AwN0tvMFNPdfK8+6AZ7CthoxXB8/7lMCW63ggdb0wQrHeFuQVEKHRonwIQEODm2nn7gZHZj
	dKvm4w3bFbLrOlEw3QXqvjtU0gxeYc8c=
X-Gm-Gg: AYBFou3mficeZclouYNNWGusq8oWjbf7YCtbFwR8if59dMjgIhP2aJHh74zQFfPLaxf
	al6tJaMSYH0wnxbygKel7lYoUxE4OZ4HiPmGf2fswF3ZkbAUFQtVQHd61WW6PGza0r/SNyCPuDq
	EK17CfVOxPYtoNoUwrRh17cM1Qa0409NxgyarJ7R5K/umPFw0/IvJp+tJvd05GE/WKNsvIvm6jm
	zZ1I8ER1dFOv0+UMJ1XJuhvvHhVjXSaeYVOgbNGBzOFL05/17GQy6g9l5lmUw5njEtX//C2aaGd
	7JYQ3iDfYIOoBGY+0sxG7AQywwHS7dbY++ug4uZQt/eCZM1yCYjKs5s=
X-Received: by 2002:a05:6870:8e18:b0:45e:d529:40cc with SMTP id
 586e51a60fabf-46f88c3413dmr11880829fac.18.1788443438247; Thu, 03 Sep 2026
 06:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903113538.72942-1-cgoettsche@seltendoof.de> <20260903113538.72942-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Sep 2026 09:50:27 -0400
X-Gm-Features: AcwNN1XosO_psptElnxnXxRw30VXy5yp16X5Hpo0FFgP_yUTAfanAYmm9ZQT7xM
Message-ID: <CAEjxPJ4WX8SszS_SXgBP52csfokZLNFVkWmE3rDBJuDk5etU-A@mail.gmail.com>
Subject: Re: [PATCH 3/5] selinux: bounds-check role and user membership
 bitmaps at load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:36=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> role->dominates, role->types and user->roles are read as ebitmaps but
> their set bits are never checked against the role and type symbol tables.
> An out-of-range bit is used to index those tables later; in particular
> role_bounds_sanity_check() passes such a bit straight to sym_name(),
> reading p->sym_val_to_name[] out of bounds on a crafted bounded role.
>
> Validate the three bitmaps in policydb_index() once every symbol table is
> populated (roles are read before types, so this cannot be done in
> role_read()).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

The check is against nprim rather than defined so an unclaimed value
under nprim can still hit sym_name() =3D=3D NULL and pr_err() prints
"(null)". Not blocking.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
