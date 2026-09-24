Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389442DA3F
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285796; cv=pass; b=WRGaP3PRG8k1l7TLjXCEsSde/YJc0qR5gSYad9a2X+jydDLUjNGqJzmrcokdWYtuXwImKZUDrPyU+0TD30JEus7JSTNL8y8XSqyvb2bnQls1J9R4JQDE8jPs2WbHV2reye2StF3jBBniuIJCt0VOF65LZofoYomRyZXPgbIbslE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285796; c=relaxed/simple;
	bh=aDk2K6w78dSvqwQ2/AlnAUE366L/6EP1GMIWsKybYS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US4OqJFgzMV1Z7xVsZCOmcvadJ0AoQDjhZoNJSOc/4fl53FCz9edmrm059rb6xbCKEJDRnLYYlO8lQq5HrRhJnFZP0mN2AYGlar4V6zLjaAyq60r9YkZI9KCDrwl2yTCvT2cOmfNm+3sDl9hbxfIUC3+b3mAdFLEuq4S5Y15Jb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ADkKLAYA; arc=pass smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ADkKLAYA"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0abca97c0so193018a91.1
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 14:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790285795; cv=none;
        d=google.com; s=arc-20260327;
        b=MBTY68on8iOGc9wTOAT0EJ2o8tKnnJkxecEcD5rA7KFhN57qYPLUt4mNmP/xDHXI+3
         4xP3eDElFV/mExKaW8bh6hJmNPgBcpPfOhKQuZBps1LKtnEDpt14kNnIPmWAf56ODCxE
         bfF4y4/HgTKf+oBBwDu6NIXK+nBY/gvDre+UPEXWke0yXbEy/4ntplHULJbXxr2nT55R
         T8hL3O7g4xdf9sJvj7R1dx86pIabZslxDCyE+D7Sps0F83/yFQd8WIxnBDLmjxzLJP+q
         xHSHbKDcrg/el+4Uxb9OiFtrmlqAYyXbcJK5curX6z12HGVE9bWHXVugY/M3sipzGxV5
         JBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dssqRKDGIuDRXlbJbi8nie5VqkWoj64ZMk3jy1vbHe8=;
        fh=peJq4QGnpc8aQOJcAiUIRK/KKMPFdxft1Eiggs9G9JE=;
        b=dm+UHhLs0hHWhIcBlAMucHdG5SqATe155ivN8tiMJNHzCeHFk1Z9ZfBvaxHziAWaQ7
         krVK3NKQgYJOrOlOH64Xjy1DQHumb2qhUuK0cyoiJLr4oCZLfDqtkfiEXuEfJp3x9Gfz
         zwgnP6n9AplAPUsej0WyG2xHVu1M8dsYlRcCcRm/d1Jqls8XoNXLFxtBamGoVHDP7QQT
         7tMq54nR+S2GjVSFXxR6m1ilbcmbGoMks2jdw5ytnJmFvdfSIn2b0LUWPglzgsv0NHAw
         XY9I4+n/bwSIWx7D3hDy8WERixK1eiAmBm9kBjNCC2QpUCNIkuCuArnb4K1TMf6Iz5pr
         HEww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790285795; x=1790890595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dssqRKDGIuDRXlbJbi8nie5VqkWoj64ZMk3jy1vbHe8=;
        b=ADkKLAYAKKRCEVKg51dFT/YgHqnFuOKY2Nyy7bjZBoTCihsOzkHlGiA3Ba1NvTuTY/
         qWN8oyiHoOXhQC/0goGg7lHV68fyTOh4BpTotlosUS4A04Z86O5tkOQO5l1ww50r7KFH
         bCbK3V1nbaAA0OeqyEM1yQ8IQpZQnbBqdovOTav5ODvaYW6ZaHU/kmYLyVF1a5wbbOb6
         fHddQ0wd80jKtWVNscBdMRas/kmM+K/v/TPetquYNcwTqMPHG1iHGVatFMJzebGlGNVJ
         cj08fHAelezFa2czcy3sjcPESTv47s975id5NbSlEB92FHzPqU2BYg46c34FYvJlRREp
         3MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790285795; x=1790890595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dssqRKDGIuDRXlbJbi8nie5VqkWoj64ZMk3jy1vbHe8=;
        b=AiCbZlP9OAUZVs0rl+vDF0Fj/ZsCkDgIIA08GyjDzpmkjxfPsP9jjE2cukC8Ft4BfN
         0EVXWEkW3kTlpBYxl56O0IjIZeBGDWdWKu4XR5fqKZ6CwS9xsPc0Buv4Xp/HGAjnq+pc
         crTLxDKbF5mMEh0EVSQCqzMdIOJyehNdY7+k2c13Q/8v9KXp/uWiOXfokEqgEJtXFs0s
         cDDCOzL2v8i+GbClNlKmX6p0nlm2WhJmVOcRrm1XqJ6qw9TeN6alknsJzv1mIxKAmwq5
         ZAaY6rHWFTD1LabAkeu6GQreB389bC7oeGnR9XuvR3Hvj8P8ly3KhchnN5I6+abbizkk
         1V4A==
X-Gm-Message-State: AFuF++kwKMzwO647OrYJg/lp2e8T3WPeF5ktUc4hHdt5pqlHnkZDSL+o
	CtcFP/xwDsaZmgjN9eTwTMmqh029aulyKKG7O13OI28J5mrSCaZgfVcv+PE3WJVsSXN/dScimei
	RxqptibYAPrBIF0xOFZPhImpnEBMnYHUrHuXeE4T5
X-Gm-Gg: AYBFou2b49D+17JXBW3zER1Acoxn4T2084JFxZTwgIwOnt7IeUPFqiDw/deKevmpJeX
	o2B92WaPJoht9cI1ksSRHvUl+SRebcmS7Hr8zY2uGnOEnKkFOIR6bfTZjJiq/8hN3uabkgzOLi6
	cHAtBHVx7Mi8jGn/tQK6YoYavAvvjwI+dZCJr6QLgJwqsT4L/RvcjW12Z39ZywpN8h64mLXvKK0
	CPvhBDL8hbH/E722HNS9wWOO7t1xzSMx6zEdWcrkEXosXAWNPmGzMaOEdzgBlJvRMduC/RveTgu
	Z22FHIBjxvY/N5ItjTiAyCQtDva7iKIZ0SlesOY7J+WKJXBpvwXg2SmhaGWSdEzB+nCQqmMydMN
	2yOvyhZt4yy8=
X-Received: by 2002:a17:90b:2ed0:b0:39e:4498:4863 with SMTP id
 98e67ed59e1d1-3a0985874c2mr3832861a91.10.1790285794838; Thu, 24 Sep 2026
 14:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917141317.54719-1-cgoettsche@seltendoof.de> <20260917141317.54719-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260917141317.54719-2-cgoettsche@seltendoof.de>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 17:36:21 -0400
X-Gm-Features: AclHuK_pwN4WsO1WCVkUtBDSHDPiO1SqUHJ53bx8Hi6DK9MvJqkM0mp5Bmczm5w
Message-ID: <CAHC9VhSLo+h-9cRQ-GdN6MxVyCD8=VAC6TgD9HjahV8=6DLdfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: check neveraudit in avc_xperms_audit_required()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:13=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> avc_audit_required() returns early for a neveraudit domain, while
> avc_xperms_audit_required() instead relies on security_compute_av()
> (and security_compute_av_user()) having already zeroed
> avd->auditallow and avd->auditdeny for such a domain.  That leaves
> its "else if (result)" branch as the only way left to audit a
> neveraudit domain, and makes the two helpers read differently for
> the same rule.
>
> Add the same early return to avc_xperms_audit_required(), so both
> audit gates state the neveraudit rule directly and the extended
> permission audit path no longer depends on the auditallow/auditdeny
> mask having been zeroed elsewhere.
>
> No behavior changes today: avc_has_extended_perms() only reaches the
> "result" branch once the identically computed "denied" is already
> nonzero, so that branch was already unreachable in practice.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/avc.c | 3 +++
>  1 file changed, 3 insertions(+)

Merged into selinux/dev, thanks!

--=20
paul-moore.com
