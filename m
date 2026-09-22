Received: from mail-yx2-f31.google.com (mail-yx2-f31.google.com [74.125.224.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E57486E45
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.159
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106282; cv=pass; b=RcGrN3Dfb6fm4cGrOpcJElZXf/vBbHIZRyh3Xj6jBQblYrOrKTqcJwoN9zS8DKuzap1rcIbwokUEbNDJ5XiyoiMgO16cCr6vydvoOBILSr6bvfF08hpOEXhyX5vXCtjHdPrCu86UgOjk3+THk8up6sBlezXkfH2SQJm9FbtCCxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106282; c=relaxed/simple;
	bh=UKoey3bUAfrKlMGbY8G5Qs24G3HLxrpPEibuXmldhM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/FgE6nBnb4fA4XcN6Bsw9Q0cNG6aOf/R6GnQl/jJCBCL0UxfAlBzRO79tZTn62JzGjoql6y+B4D2jNbmJQW7Wf7O22LV8b/8/81mDAwDUz8sVA/fGZjf7E7YHuHI+eZ2KE6J+PzYTnqlL9g2JD5tM/r6lfIC6L1y0ossgknR/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOmGWWF6; arc=pass smtp.client-ip=74.125.224.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOmGWWF6"
Received: by mail-yx2-f31.google.com with SMTP id 00721157ae682-8659af7454eso5520387b3.1
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 12:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790106280; cv=none;
        d=google.com; s=arc-20260327;
        b=MU20hn40VUk+duwgx1cw7flTBcRz/GmvajnlR0sochfCsWAxzEBw6Y4epkqTPORRvS
         UTbObIIPf98kY+AcJG/nENMKPX8rMkAtXdsnPVKo6/WeVUArd3nMX6ln1xmEbjV1TZVc
         SK2onghzniDoM8NENfDPyqyFKE2nuJiDfhnTjgkaDwn7WgZNLLwgANQxIKY7yR8tyHqw
         rYoCVB2AcQtPBkVOJgkPy0Z1RWTC1ph571hMoJAf3LXc6zXA+3Dx5UZycIlsH9sgctig
         N7NPrAuR0qCO/laFKn4MPMdSSEaOk35pQJmgZYtWDQ2t4azkMfTP3ziKclpjS14Ni0RU
         VV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UKoey3bUAfrKlMGbY8G5Qs24G3HLxrpPEibuXmldhM0=;
        fh=KcNbqYfh5/rp+3O/oy/Rn1Jlbpp64wJ640nU1xb/jaw=;
        b=Ikh+3r5/v69oz404UG3mqhjCRMvsDDkhEPjJ4tzBIoegqRhawJXYct411kiqip+0W6
         clZml7eD/x21gkFuzlBj+mqRkKLms/to+0KTO1Hp7f1Cjgy38x7oOs1CGcfplCPG4PC/
         wPJoK3urTNA+ZBaD9U4qeWR9dkXxKFD8r2twZwLi3K8V5xsF2bIk/boYs07IfMMsSqHT
         6TT45BwVzZlkmvLkofuKvIw+XttX+ClV3OXh7xwcK+58g+/wn3ypHi8GevJMpiDceigH
         Mmb7DpOftdTA+9q0wMormmp9r1/IU+RjBv4OOtUgSZn5SWkIXgZxRC14U1+jbu6euGEu
         1eeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790106280; x=1790711080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UKoey3bUAfrKlMGbY8G5Qs24G3HLxrpPEibuXmldhM0=;
        b=GOmGWWF6+8nbMh2yMnuBTBTf9QfzfcaCHM5ZlwYJLiGVP5JI4dPHNQQF7YDBaI4LFs
         G7dKPdNLZ4unFGB2PIA4tW/kPSp5QWPYElc6sVIOzc3DiUALtN5mXfP2kikW9gGHeSQF
         tFK1VQ2gHFVC+ASjQt8eYs4KZXvRslBc7UO3GH8td5ulfjVnNs/1hGU9vWfzzVxjq3jx
         7UqT5/WD644k1fPMBWSbSHkcQXPgh5AurZ+hxvygqeHA7D7lLg2YorThotlT6lcF+sCX
         V5vBUmF7N2aUKBP+GZCJPUTbygOQp3a3guCNAIFj/WDNL9a5i941amBSYfB0kWn1p7zB
         WVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106280; x=1790711080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UKoey3bUAfrKlMGbY8G5Qs24G3HLxrpPEibuXmldhM0=;
        b=XTrk2gRL3yn/RBccr7pxXcXdeK55dSyC3bTzhkdMiy761/nCFBYvZhHT24mH7+ZYsC
         Nb6Hjvl6xN8hXXG7YiiyewtFHoaEEqOiLBAA8wHftt5QbJ2HIQ9yaGecmdM1Npp3v+vf
         j4GOqjCIRYPCkD3T7PoL8BGXG3o6AbNqIBMJ/sotwJzswu82sBzliBHS9/ld/iFO2vCn
         9hsUh01E4zzNXw4UwqeWtnUBBP71KF6lYeIb0q3HevaJX03M6Lq7o1vbtp4wPrrO0OX+
         Vbpzpt+PYQtWTbhr6mpkpXNXAE8fwzrbNNrHzGGKq4dsyoZKtWQYUwACVNsRdeVuYq3e
         FxrQ==
X-Gm-Message-State: AFuF++mnNjCzp0zgaQsXY33KUtUJBV0K4ane1CzLTc2PL2ivdDwbOjSY
	TaO30Fw0oTgFH+R1Xzf7XfwxhZ36Dp7yhVLnFV0C1Zjf/h5nDS20hjII07c/wA7Tmxe+h/xXp4U
	wqp2lHmWqL31gWfn5JwBadkT+xNIgItaSIA==
X-Gm-Gg: AYBFou3sGDRfGxVqdV39F89gl1yp3dFAucK1Drk654EJkKlt8M/KdBGeA733HJWFOow
	rTKj2bJ590sNnW0NBi3xzjl7ShVmG4QVtU+IKBHQFvdBjczBQtMgWzOEFFsl0LA7oUdb7Q9Hrch
	ubkt2pORrgOAS5uZaL0nm+KHFpMyqqie375YMF5WAZJ3tbE7kd6UkZIpKyG/mkYIRETYCEnDm+7
	YcNantmrfBuQERITTQrc10+TblzbM8L+ZYRNt5qfBFi1B4gGvCEhGWfk5WnC5RDyB7RXv5Y2S/F
	FgHcjnVdX/Qqm3G7ZG5lMf1L0wY5p9TR0o7s+z6lgnIYjx8FTcKAiB0=
X-Received: by 2002:a05:690c:a7c6:b0:884:b55c:1bf with SMTP id
 00721157ae682-8a452876afcmr3344047b3.0.1790106279651; Tue, 22 Sep 2026
 12:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922161738.47551-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260922161738.47551-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Sep 2026 15:44:26 -0400
X-Gm-Features: AcwNN1U-BbpXKTb0XQyHo0tv-i5Q0fH89O2-McMb3eFHIZJsCs-nVrjsUfr9XjM
Message-ID: <CAEjxPJ7BUFJ6bUYF_+wKutDN_8+zqwFbCX-rvEiJo_pTxuuhyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] restorecond: search fallback configuration roots
 for the watch lists
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Search the fallback configuration roots for the restorecond.conf and
> restorecond_user.conf configuration files. Resolve both at startup so
> the resolved path is used for both the initial read and the inotify
> watch. A path given with -f is used as-is. If the primary location is
> later created, restarting the daemon picks it up, matching the
> resolve-once behavior of the other stateless consumers.
>
> These files live directly under /etc/selinux/ rather than under the
> active policy root, so the libselinux selinux_policy_open() search
> does not apply and a local list is used, mirroring
> semanage_conf_path() in libsemanage. The list can be overridden at
> build time via RESTORECOND_CONFDIRS.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series is merged.
