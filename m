Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241582;
	b=AGviLyYVYRICLKw8RE82jt55FbnT0a3kdils86t60Btq0fh92YnR4mYZQSAC69cLhgyR
	 NhOs+8X41x0/R6JF7ma964JsPJ+9MQFyR04Koe7vjVeik46RL+y7y2epKvkZZkRRSvExJ
	 X9kqEov/C4hG7iJSCv2gmnET5hh76IiVwlzWQpkQAAL+HnBfazw5XFZFY3++RHYOvJPK3
	 TCt/JhdDsi69QDrPUzC7Q5E22fbgQQxL57B6UpASFPKDMgZ6mpoBluNJuVtHYfIMkNyvi
	 lyHGIwZUjjCf4wcJlaaCBRUtF8z5MoUTI55JH6y2jEHth1qMoo7R+1K++jP1D5A5TEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=QBbg5/LmXhRXkqvrFfgfEtZQxAOw8GKV2D6U/ZLdAOc=;
	b=kBeEKRcWM+D7TYzR2IoXU2K8o1WqKzjUr6LbM9WbXvxVkK9KttTyswGlMrcnsH7orC6D
	 s/TLioOpbmO57/pKnAh0ptiAjZyFVGBAkL6lH6lk64p3hYR59ySes7aFGRLeECSUH1BtZ
	 1XnqGHPrPfSS+zCdPwz2jabGh/KzdNtQaAVjrwavo05EnVgPDLzeqGU1iSoFY8WVI6XRF
	 7X5ar9cVDWDQZi2j8wCl6YAbm2ubYAmnh+RkXH/dPXJZ54pz8/NFIOLmzqeX/73gUVLgs
	 OT+9nzWCh9L6XaWq4zlYfRkNE7rXHsUaqkw2isO8J1/t04wdGcZmK8hOY3DyGO4UPtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASFWGINQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47D606A321
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A47D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASFWGINQ
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b336de3d38so7394117b3.2
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 08:26:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241581; cv=none;
        d=google.com; s=arc-20260327;
        b=UYpjw61gXUbXv3/k0WTlPHWetk1wbTO+aeAI8rNw8VDTbxx5Qyw6H1E+MlSn7OkFFf
         CgsFsp7EpqhWDtado+9CfTqcai8D3Y/lYBXpLNo+efxY4SSnoK7H2rGZJiUfPxeDwyPM
         nVY/diIu56i3efR7cT/t9lUZtVnr5FeqjB/FThvobHXPMXnsxMRP6t3F2Z0oyzL3/p2T
         /vGLeO2mIrrTdTzy3eLbCzxAurELLHaX/4ATZPT7hIwUM9I18lcocjarzwCsc4TG/iCc
         NYfXr4PYg5VpRAayt7c5l0C9fC+pESX23nGrOMh383b8gmneSLiyo//Hk6MvD6/VwQtY
         fGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QBbg5/LmXhRXkqvrFfgfEtZQxAOw8GKV2D6U/ZLdAOc=;
        fh=o4NAU2CFCwsduo82xwTJCpPE0LyXQN8vgfWzXifkzQE=;
        b=dpi8eOgXlKn1LFlkPcbCTrXw0DLubHi1PxfDfnKKnCiUbRgsMlcS6BtOww/WG13kjn
         FsnIouOEL12DGGEVC0SRhAN9YA5MucWD0zUbDYIXdQctWUZDl9xLg/Yl8DmvgxJ0EHoS
         w21r75KIRnA6GVnpEPx6LHhJ98EF6F9GWxxvNBlimjAD90LimNU1GutdSj6fswgbb6p5
         82N/orupA7mab4t7BiXM+L/5IvdjAWuO9Rs5EXeHyz8Brq7amE3siNwvHf6mZc9UYDb8
         r7tboYYyeFmYoDn6UdJyxQTCtbhGZgZ/YtyGfCemo82XSaOdCvGcG7ML+EzWTJ0xh1Oa
         o4Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241581; x=1794846381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QBbg5/LmXhRXkqvrFfgfEtZQxAOw8GKV2D6U/ZLdAOc=;
        b=ASFWGINQHk9vISS7HQcRZNb1sE8GRsuKPNOhFKWZTihUqPKZ11dHCSoth9wC4UzBjw
         sJ8oM0fs/jxg3Q2NSmpjVBgx4mP1KFK/KMwBk9c8yN4naJqtp83mC2BgM/u6EVHnI+Bi
         YJr6EztRrSuhHec9uGJuPQ6J92dA0pLJQkQhqUkY24WWlUc0RukYpkswVed2MixJFm+n
         8OHbh+pQ9Eyh8Vt/OBOuU5mHQosqlKgSfbiYWDKH/PwuitGVs017uJy49V69SzN6LPQW
         /JiMdenXDgo2IzPjt8Zqq3rNov0x45j3XJxtxufEUznKXQrTmmyDHVfNA/6wPCpoUVyw
         a7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241581; x=1794846381;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBbg5/LmXhRXkqvrFfgfEtZQxAOw8GKV2D6U/ZLdAOc=;
        b=1WsvSoZVV6TkaeQZu5ICrnCCvNThbtnc5kmGsaZPxLjj9NXHiowrQNkd846hPmFU0U
         jcjXgzygenfFCq/kDyWpkwpQvV2v4D79aaYK5yjVu6vEvw/mfNq04cBdYiYyb8VeUU0i
         YsfwL1pTnzNJbuRMb7451jzvJKf/LDwDYydi/FZ98p90ClN7v2LgFEFFabNjc3CQOwZ5
         f9HWOjliOweaPKOBEnwGFxVyB6G9tCod44J+TmL1ZuTmHFytFu4fsvZT7P/sA3MTenYP
         oJbpeNpsuMxGE9nQovvvC5DhHr12Sz4HhmvR/j1mi/7+a18BUrmyLcM4fOKudW/8MMLC
         Qkqg==
X-Gm-Message-State: APuU4Z9UjMJejoqjhmw90oTlbxEr32NxvV8AYhC9qAKecSB3W/F2UdxW
	g5GVhQYXLcUNEeXcxrYT7szvHcosOSE6opSir5Jp7LAfF+KIScLbMLPD7nS6fldlqXqeVm/FbMa
	TRkaLpG/dFyu1+vjMhuDV8H006oFtuhRjktXJ
X-Gm-Gg: AYBFou3EXmH/OMGI5slaIqtpv/bTlJNiH153CWXLzPbY2WqhQKFhqtYN8wOkNmMyO4/
	lVSIwGq4rglEDrkYha78oghtIbB2Ly5YJsyOoycTOHHKF/HrftrlhzEKFW5Sb2eXHZEOGhWI3XD
	UWK/UWLCsOWq0/JLeXz43pljDyZ3FUA2SCM+ibUUB4WANVes5uPxSvReKM0pKk6rLHjZIDkHMEy
	p7TTrVXN9lP5zDObec73xWlO8IUKxAakXY6XxPJeqQaJiFK0INNqL+i/YL4EYUqfa1KmrOA7YEC
	lV8MIAeyfXLxdTsJYnS70Q+ZSOImlOUByFHv6HnSFBivLtgJrBCQ7eC1fpRoxtLOxJmzaHvvx5E
	fUrRLHBVpxe3Ke6UVfhs4649JF3+DcxkH6bq0j8MaVFQx0KrGIoVIUPu8pPw3u1B2d6pxscjstv
	6ihkwDS/ygOs75JhUZynGEK7/En/eWY1DZub5mjMWLj3lcyzDhZTEqwa2Sh9ZIQuYJHBSo4VJHK
	vGvgRGH
X-Received: by 2002:a05:690e:4146:b0:679:8c5f:3fd0 with SMTP id
 956f58d0204a3-67c564394ffmr56852d50.19.1794241581363; Mon, 09 Nov 2026
 08:26:21 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106181033.252493-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261106181033.252493-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 11:26:10 -0500
X-Gm-Features: AclHuK9HAyLpfGlgD4i5B_XYsWfp75TYUW9zx5n1xs1WtT5sIvq0mbxh2Jc5ofw
Message-ID: <CAEjxPJ53OUs2oNcZova3T_dwtX_CU2poxF4zjMx79q7Du3iJgA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: apply requested level to failsafe contexts
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	Filippo Bonazzi <fbonazzi@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 1:10=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The level-aware context lookup APIs replace the range in the starting
> context, which get_context_user() then copies into matching
> candidates. When no candidate survives, get_failsafe_context() instead
> returns the configured failsafe range unchanged. A NULL starting
> context also hits this path when the current role and type have no
> matching entry.
>
> Carry the explicitly requested level through an internal list lookup
> and apply it to the failsafe context before
> security_check_context(). Keep the configured range for ordinary
> lookups and preserve the existing ENOENT validation exception. Route
> role-and-level lookup through the same level-aware list implementation
> so it receives the fix too.
>
> Add 309 regression cases covering all three APIs, explicit and current
> starting contexts, per-user/global/missing configuration, rejected
> candidates, validation of the final range, and failure/retry at the
> new allocation steps. The test uses private configuration files and
> wraps getcon and kernel validation; no host policy is changed.
>
> Reported-by: Filippo Bonazzi <fbonazzi@suse.de>
> Fixes: https://github.com/SELinuxProject/selinux/issues/508
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
