Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7D53CA69
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695606; cv=pass; b=HlqR/Tu2Mo7q+U+aFFy3JV6mb+u/J6sBPhJdb6ErXKC7l7jtl6TdboI4cuoxZY6IdlyoblPil5mow3AeXWOLFDvA+45Evz8C4mvpeapp4VJ7mVTkUR4IQPORh3TeFFZfGRoO1sHmgVrksjGeTakP/MmuemeuSF9rEQINnakc4JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695606; c=relaxed/simple;
	bh=OS2KPBs0PsT1S+FM1H5fIbjbPRbGRQeDbfckCM2qM9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRsyuTWAcYRIbOS+ky23PVkZH8On5fu8guBgg2+WXUFGiO6SRoSeJWOJMBrpnuALfiWBD58qrADmYZWJR+eOu53n9qkLbFj8FBWRobMSCAyWVs9oIPN5cwdpjC2jQphFa0/rFh6nO53XEcODz8mfDZ+zHYDoF2cX3P3LU0Kpy40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ9dkmwS; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ9dkmwS"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e532bbso39025547b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790695595; cv=none;
        d=google.com; s=arc-20260327;
        b=O+3o98RyEhIGcWbTt2h1znzE1fuZyuNVRfxMc3YFTvuct8Nslsv4gjkN4rAemc0IAo
         vppfxsyAhgAGY2P2tGmJJExv3oR54TBWvOiPvy8Yrod+kFtsmteBC+j3GGYq57Ayv1cK
         YojYte2dq+SaLX80YnPmtPfngd5Dldn6L3Q5lqGS8ARb7U+gCx2BPPYeLHEzVhz30Lb6
         JCQTDfgAEJBBF0nXQ8KqE6gKPLnks8GkgRGbfTYgWJ8301d0tpfs/yZgoAM80ahZOrer
         2DURTfBEEdMtLXWtEzG7Gf7zb6UGXHNExd++9xSMg4ES9sBm3CztrohFgHKwnqdHJ3RE
         Bxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OS2KPBs0PsT1S+FM1H5fIbjbPRbGRQeDbfckCM2qM9Y=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=Q1XNpOaN8WP5N42noGIXRoi0h0aIDgTxbh970WZlIQXEg2DW1SK6advb/MTMLSW+Xl
         9gKq8UI//JV3uOa+rF6tLTg7ZTktdV8U7CxkFl4B9GFO6dmbk0IgZM5N+wtLMs0loagn
         zDqJJr3V86II3B3aXeDHXFiNm/NgHKYxRZXzeKIsXf6orLBpbj97jj8DL0cFB7DAE5Ib
         zZww+NnbdpwnEi47gQ244XouuNxWotmrA1j8cwQ2zStqCuubQBHdH3eaVfwyrGDkwmkm
         C1UBPTw3BxzyY9b5b/8c5emfNzseL+NQdNUq+BcOPDB4uLqUBJVfMlsPMug29Xc2q0YX
         5PRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695595; x=1791300395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OS2KPBs0PsT1S+FM1H5fIbjbPRbGRQeDbfckCM2qM9Y=;
        b=PZ9dkmwSnH9CxLGEOXCLsmch+5MKF443nu0CjrWZrwYklG3kFm2xz2tGPRc8HTEtIb
         gdPkqebCXiRSCQ0btr9+41FzRrKweYUXHsUlCx3lljj1BgT/nSOTvvJWWyS9LD/klKwJ
         QzkNZXc85vwmluLZxE1WYq72RS3NYujm/6on432SvR5VYDYhiUVFHDTc5nPaixSOxrHd
         DHcemZ8aOCFgoYMYjPdLtTVWcF/ny70QE9SVvcRWRhLM6v+dIRcuYoOVAIS6R67u52Qz
         ktKO5ttx0+/LsyBVsBFE71uqgKTVz/tlJAy0yEsdy6Qw9m51erDPh/r39MW5Ejj19xsn
         Z82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695595; x=1791300395;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2KPBs0PsT1S+FM1H5fIbjbPRbGRQeDbfckCM2qM9Y=;
        b=2RpGWxpHfTaXXfEtpqmXsdhLtnJ3/l14KdBOwkn7G83ms/s2d+v/yD5qEm3VDrnQQo
         uucLzfT0grrJoSXAsBbjf7C8Fg0Fte27/uudSF1xh2/pOnSWuvI+QVRgKBkpAyjifyCf
         hFbO+FWGEbaTn/nUF53TUIEa0IivOwgHIbxacKht5gP9vQ0sJAeo53zky9seDng7lgnx
         PtJyfJEMAwokUE5bZQEuFgYXmUGtkMvvDf4nc9B3nwbxDVPR+PcIJJxyZTeQ1jBnWtWW
         /ZUD9GnwG+BayW6O40oM56a5JEWLjHeRzV9ik1EB+SFKEq7clJkHT7+gJZ8NiRSuxGTN
         /fnw==
X-Gm-Message-State: AFq9FYLeAakw5y1DWKWp7poNXr0mVcy3QmNqYwaX8NrTWOllkVqwk5dv
	QlHtiSnFP/twnLRsvCRDx78gbo+PQ43qisLMj5USG9/87EVdp9AIsLNxeGfz7vo7eiuaYsK6lb+
	qsv/nLTokFi5HjoCjLFdJZ8/lTpyaigo=
X-Gm-Gg: AYBFou2B/0saQZFR11apTeLZq40BL9xvuU6kpUFfxdcDQlXMNPtJNDofHs+Zg5+Hygf
	R+sc0dgDcAhZogbod9QcqQPxEl1ioE2J9DvVbFAJByNKjmcjY/YW0BXFDXQdJsRDv0JARAlVxYg
	M/SHQqkdNwsOnMSvGVuZXPECMC9eDX9fHvkBsB1LIRUzeaNGQGmcy4e6Y/np2qKeFopcsiacoii
	ksfmQ0lK7bdOFCbQDqs7ZTGr923wnP+3IfPi2CTR7hOBHVtF1CyxB4hG3MKIhGeYzZZAcpmdAXn
	j762v1BsvciSkQ8t/XD3Pm1Vxzr7rAK78TjxJpMUgXMNnMfPoG3N/ew=
X-Received: by 2002:a05:690c:6e87:b0:8ab:318f:143e with SMTP id
 00721157ae682-8ab318f166bmr21426467b3.24.1790695594987; Tue, 29 Sep 2026
 08:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:26:24 -0400
X-Gm-Features: AclHuK9Zy12PVsKjwCngSxwIYNDYZLCJ50jOq_cLybLS0WwfAGIOB4oGJDAJEgg
Message-ID: <CAEjxPJ6+R+RHbMsQ7JZMC2kcA84rf+i=K=4n0iX7sMNSYitdpw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/32] selinux: use kfree_strarray()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Replace open-coded loops freeing an array of strings with the
> existing kfree_strarray() helper, which also handles a NULL array.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
