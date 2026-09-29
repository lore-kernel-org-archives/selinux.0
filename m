Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010344D2EDB
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698282; cv=pass; b=qm+K6VCGiJ58PgTwPoBiPRNBFJIqI5W9X/R6WFsOFbRYFxZ5ZOJxeabOFBktTQxjhc1ZO7VCjhcgG7aD3suySi9cQ6E4RamVhcsng0YrspEtkia2xHSLQ8oU8x5Q81xf0asgGlt6xGK536eXFit+pSBMYRNKbTaqKcPEgoOX4aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698282; c=relaxed/simple;
	bh=wHl1FDABhM3yad/8+p6QXIIxMDXjz8ZSygcALHcwGio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCNefAda3lKFrOFTqoXsOWcixNuOhKrvBjRonNLEUk3rIQqlHsjUjst1q23e6K6ev7ZGB1vTFmKHEJgSrXr1LUTuBIzk9r4sABgbECvtyeb0LoH2oGr8Pvb6qoBNO2O+baRZwLNfWyh5XekBXBS1V9E+z1juHyIgPyLoeyh+GWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7Pf2g5G; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7Pf2g5G"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab46253999so7964517b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790698280; cv=none;
        d=google.com; s=arc-20260327;
        b=BaFeJGw6aTKQxcFwy39LEVZCJLlLwtn5RSYD6FDSswiGAPiIh2o5QCbuQl8GOKbpZa
         bjkQVuxw+ml6axXQLdEPf1mFH8Vzs3cFB4nO3z2vJBXiMU8TZsy/iAnnU1KfclbpWjCl
         OGY98k0jte5Aogt9YBzwwgOFW9kdCDBU7UcsjLivRGwgn07haRRC4YzEXe3XoyL0fNkx
         9G43vQSK0lTuNGbuXAft2L6cWsr77HSeDRbVyB9ympueF0Tq9R13nOIecWfdvq/28GeV
         1JWUaRK5KlqeRvX9BDFhz1PkDGQSmZKx0SUewEI0jNX6c4cEtSha+UFTqCx8MxWB8ShR
         EvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wHl1FDABhM3yad/8+p6QXIIxMDXjz8ZSygcALHcwGio=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=jtgE5T885slH8a643qXBz87+9ryTGoP/3CLDXVywdazjhufLigF/39jKmTARwANmdz
         Pz0QTME+o3qHW0EiqDX7fpOmyuCIAcS3AZqYPt7br8xDDMJC8awNw5ln31jGZisGrssd
         Is3OGbrvpdpkpSqJk2XU9URPpfJDT8e7b+9tgREFwETqi+lVytSL2Mdeu7SPnJQfO07X
         X9XWAdH9K5ZGRcsHExUW2X5dw8iaDRUZ76N0NXUGIVN88rp+jOEsDGKgNdur1ly8MOgY
         vDLtCe5rsZPHzZZyMI6qk8Gg0Iw8/Zmc1crP/AFKXYX5GeoGxhhw1qAB1I3qtulXU7jw
         fG9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790698280; x=1791303080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wHl1FDABhM3yad/8+p6QXIIxMDXjz8ZSygcALHcwGio=;
        b=a7Pf2g5GMUAnFhbejtyiafGYTwYRyphnFDevFKBkDS1EJucC96Oy0knwL8FZAFhtXh
         Nx3wd09Ivl+i5fjgfIRsWjRanhsf7w1ADLKEiurYS/lfS5KBK4KFcl1uJDKOdpBASghm
         atmOYevewWz1JH7aLwFI3K9325G258lbTFpUg9af5nYLmGvDDF9yU2NBijjP6qU7RoFd
         HhTb+VOAVH9oG9TnvM5yVO/jYugZTLRYrT/54KDCuJ99NTLAXbVQRQmB9mjOJ9Ps4EGL
         NlGQZAqOtj2tdDuRbkeWMwmf61ZLIOa8OYSbenLB+Gx3J+kKekpIZ2elGiYyRxm15/Zo
         4qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698280; x=1791303080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHl1FDABhM3yad/8+p6QXIIxMDXjz8ZSygcALHcwGio=;
        b=YV+8kTNpfYZx92qceMmeY6/HWDcn0GgO7Kvl98p8Vj7IBgPuLbhEbZDdh9dVgHYHrf
         6Flj1lvylkxqdaURntcQkhGKtCT3uzH8YhNyWoKCi5xRQxEPIvPoJwzDcFAjW6+qzQJH
         phnCu75/OJZCoCYrUQ48ReBr7YUa1To1O+1A7m88Jp9YssBL5Q7pa6aE7wT3Xyb1nurE
         MQut8rbTfip6xYMi4FDFgOt9TVVR3RfTGZv9q67Brn19Xp29Hoh9URBJMuLdbKAYmqQm
         kljWNSfDpDEisUxYd8hR6oiMbnLVElX3hme6l+MzDvvp4KT5v3Kusr3jQg2+CYMxjwvA
         xiHQ==
X-Gm-Message-State: AFq9FYL0V2SMYqyhfhIEvNPTin1bjGBzVCtKjOTn5L877ppEWzPh+lGm
	Me8dU1mWJ/4proKULe0+mXlyNT8XLTXRA31YtvdDOpzCrNC47vaBzy4DpSldC+VmPvruHe7iC0+
	6ywP4GkSxLtMQvR2JMDzsCLmOfsy7WY0=
X-Gm-Gg: AYBFou3zcoqmydEGyf2vMOraj7quM+qs8Bp0VX4IgZH8YA5BcsKMxBv3auJeOsxyQrU
	mKBasKuLUHDno1jCZt0FWqwGKgLvTONaXWqtmj25xCf5fIr/WoMETDjl0PGW/sixCEalogmq6kR
	BSSKpXWPMuVdL5BBgAAWXx1iR85pPoB09oa/1GR1myoNiIv9eNsno4UnZzOZZ6PNTv/TA7BFmrR
	qdeqy4oxttDcfWs13xxC14TlM+R18CszgNVZxA2pVe1KqTYXqzSA75iyqwCsp1/ebcnSffEPUHX
	qiPojwYZ4+mY2gqDh7EC3EId1k2g+BdkUNdQh2x+zafmzafz5s4RZlw=
X-Received: by 2002:a05:690c:e0c5:20b0:8a1:275e:40b2 with SMTP id
 00721157ae682-8a64ad4af54mr58987227b3.68.1790698279963; Tue, 29 Sep 2026
 09:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-31-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-31-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:11:09 -0400
X-Gm-Features: AclHuK-qaEizWMjZwMkI2lkDzKjS4zvbZkAP1czivQqYSCwyoYbHAtMLn36lTDI
Message-ID: <CAEjxPJ7HzFWfakcuTJ369jz4O4T8X6fxujJHwwHKnd=JJZ3tHw@mail.gmail.com>
Subject: Re: [RFC PATCH 32/32] selinux: drop unused policydb parameter of context_write()
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
> context_write() never uses its policydb argument.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
