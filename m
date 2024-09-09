Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1A188CDE
	for <selinux@vger.kernel.org>; Mon,  9 Sep 2024 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906199; cv=none; b=GM3nkeXhCklAsB+cGK7PIxNDUyCZOmd7agG5BL68gmiWsI4/Jsb/1DiXRhG24X+6Nc6dPHdcd9YhBmzBHioIbhZFlgZs+a8P84V717/uiodgLuzgoMjJ+ZRon9JcZgZlEXgGhSAdWQPmCC6vC6WL33vyRu6pX+iY7716deJPLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906199; c=relaxed/simple;
	bh=hRz6Efr91Clx46MD3mExjRxZT8kdCRLBwKtBuEtdgtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mjk0OMR6Q16Jvkmak1BH+ulddwgeNsFWq2JHdqCoffXEW6W9BLedhMsZe1LxyQzPaLc4+v7Ivdd6z3sxzKmYZShDHLEPYSl/q9V2CJeq+rhFJD0JxoewgF8a/6GA4uys0WjRyoF+nvRJVZSj+edf3Wn1gnDeBRpIT3cIBj7iNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LzDSGkWC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LzDSGkWC"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6db4b602e38so29941007b3.1
        for <selinux@vger.kernel.org>; Mon, 09 Sep 2024 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725906196; x=1726510996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgmY0kbaKktLPLiiIRAv0o0U+kqdNewIzcrHSYTxgsI=;
        b=LzDSGkWCw6ER+AXQmVMDGiF1rnJBjMHPeKUsrzO/8o/k2cEsT70a9+SgpMAHMWeUKX
         9AMEhg2JFgO0/RIX79PWdXvdv7kxKcYjBC0TauIw/+65fLlOCGHTjBVmt9JK2+9BZQHO
         xmlFtoNgYVNPfTBr1Q8A30G1+FDHVsF0NLFdeNTKw7cdTSI03pReqCqLZF4i7AWFuL/D
         1Dm1le7bWriyIdDMdmYmecKhAsdRUdijTfLVcQ+r3syKu+/wg4KwvicFPlK6NVWaAne3
         D4aZwoOPcSkGGrp12U0qwZ08Q7N+z7KBae3f2cJsOU8vxlc2p2mgq0SrXzMYDkyQaL/9
         DMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725906196; x=1726510996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgmY0kbaKktLPLiiIRAv0o0U+kqdNewIzcrHSYTxgsI=;
        b=FgY8nz0JOXW+/chWMjiBG/wC8bAgqBFCNb4Iwuc7/s+UUqg+O+G2wM4/mBavPeyuvC
         V2jY1RVdMNgkqQ0GJMOEWtgliKSNFLgNXRu/LbSCDoClN00KpvWEyVwCPs2DzuJX0a55
         /4VxT+8kliVh/pwD+7FSsHvDd1eAIWWHfJ64t1or6sdEB/9V+/NS1VUTJomFJhrl4zLS
         ewYMwu0NgCtp79WLmX49DXnCbbi4Oi7MwuJDg3QqMOOoSK9/L8FIpobHU2nfM7BOxOID
         I1kEuU6pNR+uGMI44bXoNBAfd+rZsLkAhuFWbWMBd0GApbDYfZ61v0mB+LazXwXHqluo
         i+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNfpuXyZ6Av5giZ+V2gobr0gNTPMif6WEEX4soLxiDE0Qecc3VACe9CHe9JzKwiUdFg/RHSwlc@vger.kernel.org
X-Gm-Message-State: AOJu0YwNL1vzTAYI/i07TqMyLw3Mg8s+ZB4jSZzT0RMfwkp2JuTDjQun
	Xe0N0heSUqkRvGQLm++FDmHhk0Of5wqNnq3Ea2YIJHUeuAddS/MN/tupDmzu/N02vGafsrX8xyg
	I8zZBa6PSwmG4m4RhbXEudHKSYayZ76h3G7Ge
X-Google-Smtp-Source: AGHT+IElvH7ixPuebP2RKFtUqKOky0nJpjhOYnvJ1gZFGL6UyrqOk2Rx3KyTRAwJBcUPt/io6xI8CnJurxfM3zJ74yg=
X-Received: by 2002:a05:690c:83:b0:6b4:e3ca:3a76 with SMTP id
 00721157ae682-6db44f2df69mr153236987b3.19.1725906196452; Mon, 09 Sep 2024
 11:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQvbKsSSfGzUGo3e8ov6p-re_Xn_cEbPK0YJ9VhZXP_Bg@mail.gmail.com>
 <20240909113535.vomill5z4v5q47rm@quack3>
In-Reply-To: <20240909113535.vomill5z4v5q47rm@quack3>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Sep 2024 14:23:05 -0400
Message-ID: <CAHC9VhRUhVg4Frh1Ms5VRyKAW-kEd62rUsoavDL7oCu=cqYq-A@mail.gmail.com>
Subject: Re: linux-next commit 0855feef5235 ("fsnotify: introduce pre-content
 permission event")
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 7:35=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Hi Paul!

/me waves

> On Fri 06-09-24 10:42:39, Paul Moore wrote:
> > When you are making changes that impact a LSM, or the LSM framework
> > itself, especially if they change the permissions/access-controls in
> > any way, please make sure you CC the relevant mailing lists.  If you
> > are unsure which lists you should CC, please consult MAINTAINERS or
> > use the ./scripts/get_maintainer.pl tool.
>
> Well, it didn't occur to me you'd be interested in these changes but you'=
re
> right that we've added the new event to a bitmask in
> security/selinux/hooks.c so strictly speaking I should have notified you.
> I'm sorry for the omission.

No worries, just something to remember for the future.

Thanks.

--=20
paul-moore.com
