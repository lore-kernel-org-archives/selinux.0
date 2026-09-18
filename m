Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BE238C16
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740747; cv=pass; b=YBuXpRiY/2IFJFHOoJcvL10pSADCu0Ikc9SW8BTV1Ylzl570eu/UKiPHGzZq6FHSNb+UDxb3o+sOhkoWfGuYp1D1rWP12yJ0csh7I3JCIJIoQBLYVkaLD9b4l32dphB1h9yRl7gb1owIldFpSeXKwBn/9wm9rp6uRbf8hYNFOl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740747; c=relaxed/simple;
	bh=T19Cg/YCAHJ5I00G7NZkLucNbJt+sRi4OcweP7kxdaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt56jf5Unb73wfYUme2BREvTa5j6GIywa+tvLBBTDp8NEHtJpO7fWE/syY+KFzfAanrZMf9QCou5IWOL8DvT3pJAvQaAeRYQ6lZK1IH8TR08t282cuAjtddY4dcudEaBlj8A7vaffb8v2i/rkUxd0rmXyXhGEKxQHU770ZgkAzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEZ+YQ6B; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEZ+YQ6B"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae7166ebso416564eaf.1
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 07:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789740745; cv=none;
        d=google.com; s=arc-20260327;
        b=WDH57O75UGsncPUagj8lrbYxBlgvuXwtK5zuMegYldxxHlClrwf5ALA9TKZRDVDriW
         tFU1EwYw1g3Uvyv02s8Y8CsO6b3u+M17GjvJ1DUxZOqPob5yWnVulWwrN+ULnDHo9mV4
         V7inHyNajJyn22jVBUrOuCLv0af1JtBJkp6cQnN0TIim6c7GU6Z6qt6ujSPAWOR4lHoA
         IW2h9ulcjA7ta/35PFgQzFfqVc1HtqxPACLpCCIdsDWShUtI24DVnXVRFAfix43wz1z2
         wyUewq81591+IOK001KijQyzn0p36tXiEjQiBX8HsxHN8R30JESskB8VmSO+/heaS/u9
         Eo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T19Cg/YCAHJ5I00G7NZkLucNbJt+sRi4OcweP7kxdaw=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=oz5LhGaWhDO9yBrjEwTdjaoA/2INdAYHAGd+hIOjwPQJrYbwynO6Z+eDyxFt8Ix5aH
         b8VbH/Xg0DLQNdIj6hyQd5pcn46x82B7x+vy2HOnCYGQAGaN7splSewWTx9MsIE1OBqQ
         GDIfpBQBlm3WY8Bg2XcN3r4RAiVoQjl/JOBE4P2TNjP4NPBm7dVtzmMnnjCFR//wA1RA
         +69buaH8lg639RK0dbH1WDk2iQlGB0MII7RfQay9ocelIqHtBFMrTTvUxpUk+60S+Wqe
         9+XoZ/WMI7ntKpndzLvgFf8blM+hloareYReo9vz9WpH6TEFVuTdLbgvnsVLidInDTry
         FgQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789740745; x=1790345545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T19Cg/YCAHJ5I00G7NZkLucNbJt+sRi4OcweP7kxdaw=;
        b=qEZ+YQ6BH7jrrrWyB+OcWPHRorLXt7srSO9fY5F8nbfcp5TSdbxUwq7myNQWdgb80T
         7Pl13jslhZRQ6Ro244+eNnlWVXLc+S84/39t9HtZqJo0OcQGcnPFTpxihNAt8Ffd66pk
         //3HWrQ4k65oeiSpHwU0BUjFUzE6LGBYrVhYHO26mLoan7LgfYumBDfbIJjjwzXJo0e0
         csjGnpTKP5RSwylkxJFH1VotuufvRsf3KSc8oNsqcv2j0kAsh24GyEGbKEbC1PEfq9/8
         2TU0A6u+AVZA3ZzlajJ+yQ8b9CRa9nWT0Grek4uM/8zXjD3Ylk167pYzCMoOnR2Z3YAN
         1tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740745; x=1790345545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T19Cg/YCAHJ5I00G7NZkLucNbJt+sRi4OcweP7kxdaw=;
        b=0p69H/VVcZYCEOZRYkLoSM55kbq5dl9U7W+woV637zVhUq0IGtP6pPIO5sOYmA6PzY
         bRj/wlGqGcDU6IhU3toJ1OxXvB2tiD7jwBwrIl8oeYPFxbiifiy102bDzIpZZn1msrMK
         ZmevE1eJ/0iHZJqO2AOoQb6VCDXKrYG82+tITxgpnF/qAa3+CzMb+zvBl+PKkk1Yu9PD
         1KRl47USoRJKIZkOboJ0kpOADxg3ZFtAUb8fbGYTIRxz/poka03eUqh33vJoP5/1kOjr
         dGkt62uycMRbwQB9EcIiUZbbOvi20kIQFAslqsQ6LpnB6Cn99laE1KtAXh07XdX8uFsu
         tfhg==
X-Gm-Message-State: AFuF++mLPvKYGuYqQoLDq6WTOWOGXsoTAfvenlCkI3SajVbM+ZrTzdOX
	vSIfxKHtn8+yeAs/tyB2JXRzsNbEgE4+ANLdGaGyWVsZfnqwecYdN1D9Baw2FyfGSgaPTjCB03+
	sz6Kj0hwe3Tzp2RawbmmWkyuY7z2TI3A=
X-Gm-Gg: AYBFou2aL9WP4Oyj1x3JyiSk329BDtOkywoPC27tIPc8u1R5AtIk1HL9LX3xPkYmUXf
	JM9rv6r86jAP6kk/0KWC3jXU8ibDNAygNKFZOl9wT8N/ZZ528o2L8Rgglp0CKtv0NaDJDFyQh/1
	DI86Xrt6hRNUlpi1bQ6P0clC4G9FQh5suZYI7LSDNrG9tijD4T1d8JUc6Y9cOXdSO+WKmNTdRi7
	LdDiB8tiVYqkhwnRVQ5n0PFJFJvofMNjokBWTDQD9DzfzjEORUqSdurBNUZ9IH+waa05OAHoSGf
	MvBa5HSJ/CkcxpkY8x7rjInXnC1uiMCM65MXQAkTH7IN8VHnuMgQbol1HskQ9pvWlA==
X-Received: by 2002:a05:6820:6aca:b0:6c0:f44d:fb9c with SMTP id
 006d021491bc7-6ca9cb5f9fbmr2182787eaf.47.1789740744650; Fri, 18 Sep 2026
 07:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917142038.60637-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260917142038.60637-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 10:12:13 -0400
X-Gm-Features: AcwNN1VnSD_RZcZ9gF_nQB2uy4TMYwPOvhofUcLlhEbL5WxwhGbhxvSjwPlh1jI
Message-ID: <CAEjxPJ5k_XHQu29tNhzXWRTWG_feQbGF=gpDWP71M_Z4JkmcLQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: reject a policy that both rejects and allows
 unknown classes
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:20=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> handle-unknown is a single three-valued choice - deny, reject or allow -
> but the policydb header spells it as two independent bits and
> policydb_read() takes any combination of them.
>
> libsepol writes exactly one of the three values
> (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown), so no policy built by
> the reference toolchain carries this combination.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
