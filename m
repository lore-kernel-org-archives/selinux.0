Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E73CA4AF
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805927; cv=pass; b=nWgo5v3BVgHOXxmPp9FeDFdL0gdQpq19fNU9dvroWQKfNpRKsgdVr28+JTAsUL5LOH7NoAmbbxqWyAmVGhFifPW3AID7cEileEUfe/TOmeyfLBizIV9fXY4+gBZL5PUOsBRSCrylQ1gScfqbSEaXE2D7wQQpMsfbeLmz772MMeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805927; c=relaxed/simple;
	bh=6Yb7lHcyBL8jDQibBHnI6agJqDjlYgVvWuDXpFw+sn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KduNhXU+FYK8dn90XRo/p5uee5h0YZHjg3ikAlJqxwx5ozwnpBnyIfdcRMRzs0uT6WTrB6F7l289SusEDZ4z5U5rrQ2UZrqyffbDUWhKYDVkGhFx1r/Bm/I1rFeENeDZyOl+kmKTM61buwA2Ba8NxmHgvuiqRBLV7Y6YTdF6xrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLhqyMHL; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLhqyMHL"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-6755aad8a98so2397772d50.1
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 15:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790805925; cv=none;
        d=google.com; s=arc-20260327;
        b=QUYnzsoePJNNbsB0Ve4CYVMuvPJYm1LvKno++RmSrVRdvc8Nm3zBqbX463wO+UtKWu
         x3M26i5iWUr9DfS5Aaj2wxWbiF5iCAoR5QYvTOP2O77d7Vwqj4VE8Xs0tHIPbd2XmqFC
         Q1Cylor/NVFjtwuHc351mdaMsX2PUfjKEPnTpbLS0ogqRU7ZTx26iKQEVZeBcTmp68jW
         r/B0tdwn/guKtYISY5gXVYnG29rqxjYZSxlLxKYf09LbUjdPlg+F8GNLK2VB9i7LYLg8
         g7ykNggJ9NXLM0rVu+GoCVzt+/LCwfwXyqjw4xmXJT0m4iwnXlVUpTxiruEU7Zlqzjdm
         nOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Yb7lHcyBL8jDQibBHnI6agJqDjlYgVvWuDXpFw+sn8=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=pJsXHS3IhG827gbIhIIfWmxLMasZ9hJUt1+b1eZNF7nlBREf0m8/eKjzoZtpPP4qRy
         /Cn7EEAdbkMcpu59b18e+vHyiSMj/snzu9sIGCSXcyRH3JhUHAUVQwToAJTfRJiP47hV
         AgBVld09v0GUm/OCfImpxpbd9RhtMPMu5k2xzLwhmcHyE280E9wVW+o6VxPpA9FXHNwi
         oxULcbXefigS/TnMB6lWlcmAJTRUYuK9OJ2hBM16O57Psza7fDHz8gTnSIqNu3unfd96
         23c6g9W7ngyRWnRBeMjxhJhjbyWiu7tF7a0kWrhyP0WrW6tlSeLDurjXTiqAOeUcb3Kd
         5HwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790805925; x=1791410725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Yb7lHcyBL8jDQibBHnI6agJqDjlYgVvWuDXpFw+sn8=;
        b=DLhqyMHL2LAYJybOPPzB/ZIXe243K0IrkYB/2jXVNvyS8f2zdvTVZrXQGiAyQXswPB
         4W6UCB12OCUwStxiHVJp9vHKCRBqIOHMeQm4TYnG386EuXFPb6GuWeYPBhMCtVrJFnsl
         7weg+BLo2HIh23VM+Q8M0meMRR5QwgBrR1MT+iq/V4nL2Ug6LJqwQxrq8oxUgKyXncgQ
         O1VzQyjoI/kJ5Rl48/LYf4T36+4H1xH0D3TkABtdI9Y6Q3id23Rle6d/0qUUmrru5+gw
         kziIdvNQ9tjblFUT5eiRfCdFa6DBA+DKHMPyXPsobWQMMalfFtV4vT2RQ7/PmkSnvLKD
         Tezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790805925; x=1791410725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Yb7lHcyBL8jDQibBHnI6agJqDjlYgVvWuDXpFw+sn8=;
        b=zPkUh7wh9SJpESene2663MkBddjtVgfttki7500VHQKKaY5XgknPDORrlVQ9A7WwJD
         ZeVfoe8JpmyNzA5uQKfYztwzVUzSSd35ZlIRPdRs2hmf6eU8+H+LCDm1hmBPJn44QTTA
         mbaXUDvomXVygVbsh3K8dExxxm5ANE/0HadsNOoOcvRyzYeUtw0dwW0sqYHGEOB5yqcO
         Pwc8RCwNhX5y7rTQLv6p1rZ9HoVRjPXBY8DqcZfZSnHjUBM15WrqIKQV+gR8/1nCVCvZ
         0daznvGD5DeWcKVS0ffUjLcUsTde1sXXHQAnTQ4eEpZjj7IHrs31gWhFPi0BI49T6KHT
         fKbw==
X-Gm-Message-State: AFq9FYJCwcWStBynWq3fPzCoXrUr12iEEzPCNtKN5tF0EczqnkgT/BJS
	2zSR+llgIi9QBMeUMAqOv1r7C7jTVPJ3QFYi1iRsvUXf0bn8+bP6JCNLyXeKIwJ2/hNQHnr3VYd
	KsyI4NNLGX80293vvOLmSbI1ifPqImTiYog==
X-Gm-Gg: AYBFou0PIm/04rSyk47gNFAjK+zrAuXohXivNOt+6NVnGFq4NIsx95WvklX7Nw/8zL8
	sqflisevG5jhh4DTI/ELpVTG8NXxBCQxOLQvCMkUyISK5Pr16ieXmx5UBsraSw6yPLz//2TsS+d
	gx/i3OEQ4cUB4iPcK+GD9Dp1HPbft2ZxkPa73h100L6HlITDepq5cSgHoYbPYD7PpRvQRvTFel4
	31dwZkbMh5OyOph0eJFoLX84iMPo2Avi7j3SCbNGKi4XQeDEQpg6Qf5M6YPGQP1RbPZkuCxdv3S
	0MNmkiNo2wLl0NHf+yK7O2CAJYMHGaVmFjeL40sFe9xd671l88OhfWcw
X-Received: by 2002:a05:690c:1e:b0:89b:6ecb:c33d with SMTP id
 00721157ae682-8ac946bfee8mr17797847b3.63.1790805925397; Wed, 30 Sep 2026
 15:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-8-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 30 Sep 2026 18:05:14 -0400
X-Gm-Features: AclHuK--KzRcjhK3o1RSlQOCqIrhFUWK8_U-SvstrpBYg8EjOHvkcb3Jt-EFOaM
Message-ID: <CAEjxPJ6MOsQ2Y5HozRYFhxnU9LqOa2FHtEMs2QU54mLk=aOArQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/21] tools: quote command to prevent word splitting
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:10=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reported by shellcheck(1).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Still getting these days later. Please, cc me directly and preserve
previously given Reviewed-by, Acked-by, Tested-by tags when there is
no substantive change to the patch.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
