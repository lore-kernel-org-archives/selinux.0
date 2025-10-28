Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1133FE0E
	for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664770; cv=none; b=jRDJce3FgH14UqKqNlxEPTvv7bJPkwDkJ38QdsMNh09IkQRtCPxi4RNCWxSTayRi4WwDP9c81WSdz4Tbl87YYqP88PJ6ng5aL9ql5k741p4w3SVDbWfCT4lbzuFTK8ZyjjJvd9WghUR6U8otHcvSpQWomoUpJXdKKHTPdwOz+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664770; c=relaxed/simple;
	bh=fUCoX3aa1gH/6VKApKUBqTC1klIU9VW4cpbrNN/bA+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulM13uVRix+fKCiNnicGkv4pMZVPfAWiK6aTg/Ry3yV5CyH3gk02baKLBBvJJB1GazFI7a6OuCUSn6kz4qjL9ekMoq9oFFxIOnT3nu3fIcZ95pW9eyMcQrSbkRKtmn5Fvyp65Vs2SqeS8PDGp9whgJmPz6hImtMKAiM4ztM1vO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1KMvyU1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1KMvyU1"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34029c5beabso1173994a91.1
        for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761664764; x=1762269564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUCoX3aa1gH/6VKApKUBqTC1klIU9VW4cpbrNN/bA+4=;
        b=D1KMvyU1P5VL5YeH2s/+cQDbKy8l/T9veNJry08ydzNbnJ3EugIH+iQdBRqYaOUfZV
         tinkGBJvIECBU2SX1AtWforr9fTvL2CIPToFaw5KtUZz8cPvKzIQAa+hguGyup3gSs7K
         0i1aRqaTmu/pIq7/edrpcqw9YWt3lUD7ndPNxKIpPUqClabhLqkHqJd20LXyn7HIRVLq
         ehvwveMJ40ysYeVBaldizZcrFSMCM3oNjmq+/l/FcdmJXomqOhuXZ/K3AWuOgfz9HtTe
         pVg058cZWvAvrCvyjEVATEDrYA79YHCS84b64e/ky1eMTuQzkSzGyN4txaptSorR4BG5
         wNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664764; x=1762269564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUCoX3aa1gH/6VKApKUBqTC1klIU9VW4cpbrNN/bA+4=;
        b=XUBtnTZsvANlmUfEtyxVxzdrPy3yJA8vwYUU0wqX7CCWHhHgHzQrBSEtGWejfaRzRY
         L5Z5UTphLe7AbjmMEv6EZ9wREUj7bvjaO+8rmjUZGzTCjOP29OTCruc28UHiXJoE25kw
         QDtXUhIyjXQHEhbQMNO2Ncmg5pms6aDJsMeVUuTo24UkUat+byq9q53OOWxSBKrQc5J4
         KBx5u5EZcdPRHGsB666eHT5iHiFhYKSnKygLsta0wh9XhbtY/1Urqi309qFHiQxN3UO4
         U7XZSmKueiAQSFF6sbh6qXUl2Dx9AlJBEoLZOUAX5zud64cIuOTma4fA9xZGlhoOfMRr
         QgJQ==
X-Gm-Message-State: AOJu0YyuH2yR7lHOqOaU2in35XeRPVwjPU9ID05OoFBgs4OVvvJA+m81
	vBahnrgdPoRKutmNAeVNtsH+TtFdiQIFodJV//Ifz2FMnRg9U+MOndLN7xLaz/di4iDJ5eiVKCv
	R3Ag0ofGxb9Vz2NfgHppa8AK4noDwkjs=
X-Gm-Gg: ASbGncukpWe35MoSRbG0/foJPuVdsqE17TZq4FwzojQzcqdyjT7/ESAFQCqFPanaMZe
	et4IydbXgTB0vfcJfhcr5Zr2M//U5zeUVlmoM3pDLJ5bAcqQRZ/FQyC7lnzz5l2dBJMmVrnC72+
	YhqhbmgoEHn6WMSVfPFOwaaTlLHc9cisRwEg+hWeWGTxfTGsE0kgMeuYlUr24QlFW4v1t3QM3VK
	M/GcfQbvJn+qw4foJF8YL3KnrUVRpWDbWE0ZnB90IDEXtjqh05rBKVix5l7
X-Google-Smtp-Source: AGHT+IGFGFnvcHFxHSyxf6rdc82OdULlY32xviphPpWC7QYykvyo3rRtVYy6pGCzc4MPFEE7TB9t+uvd1DOKPMbisw4=
X-Received: by 2002:a17:90b:1f8f:b0:339:eff5:ef26 with SMTP id
 98e67ed59e1d1-34027c04a27mr4441422a91.30.1761664764030; Tue, 28 Oct 2025
 08:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025162001.300193-1-cgoettsche@seltendoof.de> <CAEjxPJ5-hWa6-Hb_k9-BgHg44nw8A2s8nipCUS0XRbg3i44bUg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5-hWa6-Hb_k9-BgHg44nw8A2s8nipCUS0XRbg3i44bUg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Oct 2025 11:19:12 -0400
X-Gm-Features: AWmQ_bkPpw5OKleeedOv_Gk04tEPFlISZz82dDFiXNFr3zSzVr4-YrC_NmiEnZs
Message-ID: <CAEjxPJ4wr6ieV82F_1Enb9jXKG-siuJFox_jUs8Wvo7-DFRFkg@mail.gmail.com>
Subject: Re: [PATCH] secilc: use correct long option name for -X
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 9:20=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sat, Oct 25, 2025 at 2:21=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The long option is called 'expand-size' and not 'attrs-size'.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
