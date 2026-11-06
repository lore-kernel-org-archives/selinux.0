Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793996426;
	b=LcBv9UzX2ah3BTORR7an//9zn7p+KsELqAkWkGkOEPeAjAsyHX+AFBnNnOY8CkMww2Wu
	 5558Apxmzv6sGr2QySIkB1dJzC8P5KsPhRxL/TQ/KWMToynCLUnOJY+895wPKY1yGxdia
	 KAD2YfNfiQSIMie8EdJYZmZ1JszRtvJK1Lbg8GBpvKUIbatevWH52CxoPhhfJplRleHUd
	 DY24CY594E4Esd5Rb6cWUBAvpBKCtwRHhWM6IYYJFn2Ihw1KAf3XpZA7vlZcyymybi5OM
	 9UsgQoKtpqS0ByZrP9SAa/SpLYo4nYfEHVTV/Vcli6OvxwezZGBL1xJkGINm/jVeitA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=wpwt6xJuMX2s3LaZujyWPiIWtEHcCb5wwiZrbQggSmg=;
	b=1TPrW0/6WZeOzww6UFLl4jfj36F4xDWQLd2cI/9gWBtAuj2LI3e1lU7YVQC5xsTQ5L4T
	 VlH02X3QBWEu/9otuHl8QxPD8vteikA8H1ayWqUI662hwxBw0XB/eCh4bIgonATH1lwoM
	 lsP67OYFHJ1XnM+81/pshXyk4foBEQ2wWPP4iV1JkWXGscFVjVOyVFDtWuk+nqyrobost
	 JgILF3RTOcW+KxsHsY649wno9cpTNAZJEkjjw/qR5+yU0NaL1WITvfImrybxwBwiEB/Dx
	 /gD3DSPYy7ODNqIL5E99Bn1D8HDQy3gFnsCj7T8Yg4kX3+gHG1+Wna9SCEa3tRy0EEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zwXUeiaj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A48606A338
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 20:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9A48606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zwXUeiaj
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6798af41644so897235d50.2
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 12:20:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793996425; cv=none;
        d=google.com; s=arc-20260327;
        b=OD6tGW/duPzSDOwlMs6W2lnQAy+RlRL9eFk6rv0WghPKsXtbfHB5MEhwKe1cErYgHh
         1D6peCFdAnsCUSZ8YBDmLjF5CYPsghg6uncQKr+HwG1NuR1tblEfCJY9uZ04/t5GhMDf
         DW7FMazRl+OWcweaOsbMoJc25PVHAetADeqUp5hXq5SGEv+rbOrSveuJ6hyfmLwy8f0k
         QPvoRqprKlO+5RGsEXzISg16Rpoa+Y7l1FC6z1GIXx/bMGyX3tdWYunY1SjmCTaRgi8+
         mClWkeeScWKqmKDu00M73yGhvYGlKnbbPWzNx9XV61lc5p0nrDV549jfBnFbZaJ71+aM
         hppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wpwt6xJuMX2s3LaZujyWPiIWtEHcCb5wwiZrbQggSmg=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=csB0VjC4cVAuwnjQuRVri0uOocgwPfQRlLcTBXvrwCUp2R3uszr2jZu/fq0tbijzvW
         6aLDCvh7DTIC12E/pu5NyuFZ8XS+H9FwHyUK/BQqeBttmvkZ80upciDsMP7eprI5lUDZ
         5+ljnwqiuUQ9M+jvlSEUJMKfH/2cpNYG4hg4adB8guY6d3TA/7yx4Qjg46Qx15tTOnAa
         lyRZxurxiLG89asb/MwWDnhKrK/DOd6gUmEFHI+t9dPCxYL4Udn0JQkKkjpTMIb6VDV1
         AWa3afDSwc6a8N214Swo4TgYmbru55QF7BrmjcGa0wjqocyiw6mT1N4zVDFxpX/D56FE
         6jKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793996425; x=1794601225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wpwt6xJuMX2s3LaZujyWPiIWtEHcCb5wwiZrbQggSmg=;
        b=zwXUeiajFar3cx+Qsm23ydFVG0nzqfZxQzoc3MUZft9oOfApSVkz6PNPZrOxQDGfOG
         wt9vIS4f2QARF/WkSKi5qZ4BUP7M90sqsetTOrKhXoNTa3xBX7HZmEoagWxVghE2FjON
         jVkqNRhtjMvsT1xcHm0wKKhNymNjMieEVptK1oEyjdI9HmF5gbnRfN2U7G7S/rJvFdUg
         yKe3I9rBljXnLWi0xMR/sD8Cmp+WflxxtKP7bCqCbtc9oWFjUEpVOPyE5OhnGmAwb3iC
         8p3wtv2WfNgybKO78Lrmr33Ls9h+J68eRQJwvopaEsLr68RvBWlMfsF+YkvREmUp4ffp
         iKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996425; x=1794601225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wpwt6xJuMX2s3LaZujyWPiIWtEHcCb5wwiZrbQggSmg=;
        b=NLXk6+llUOecMcc4QBJ9/we3LoUBao3UyDXbo5a2/qChqs1qT402mhD1tVD+l5chjO
         /4dyl40EEnR8ggCf+Iib5Wy+TcebpofWHn7hqRYVkc7JaJ57H2Yp3znWhKnMLFsMX4MQ
         hYX8HrpAnF1bOgoJWrYYt0VuM0vuwoUs6dgWfKCuMUkEMrXeSeJogdDDhB9XdsaBYOsi
         O6LV6WUhFLTe6DIxcPs7srkMwJt9fEIFKtpHkEqz/X1BFNv2TMqeBe01qGetcgyI8KsP
         jP7oSNuZTJRc2afAVTgObBPDm/LRLyF2UOLOttPOmkrsGSmCrGKDIEt/pUF6gsjwIjz8
         l08g==
X-Gm-Message-State: APuU4Z/gkhO6xwjpUCg4cubxBK+6Zv8GeFBguZnkFdlB1+VkT76BH/AW
	6f+nxH2MhqV4SYn8AGSITd2XFbDpUpddgQOP33AXoIUGWrU4MEhxyI79G757t6YctehsNrOuk6e
	d1ws0PN6C3THdKuuh5chlOqK0RvqgeaY=
X-Gm-Gg: AYBFou2ZGJCQwyNCzCVd+zqxNEge/j76XohXi7zo0nluRCfd/Jk/oypJuHws5fJVP+O
	fVj8WMQHqZ/p6CnXudxRa+WhnE4EDdwtsj+MVq8R/xMpP8pBdd7QFYZuJxr23Q5Iw4Cy92q6lgp
	DJqreklodtbT7bKaWA5IPNd1Pbhlu/otAeaNSMXMRcu47qJIuAG2N/ndA17ZlEadSEYtKcvVTqi
	yr+PiKsLXHrtL+GUS8jWqxsef+RY0lCC9Suv+y26Jx4t8392II2AZVUBtXIUqNL1rq5bZ6ap9yb
	6t/fu7YwIGjW6DLomcunPBCYeb7IBciyZiqVxk0QIt4wDKavQHj1Fkiz5XUNmnjcqrpJeg4B5Tm
	rdJDqls0rawDJZomW35WUP1crb/4JxiCGcRaOiPKbdqo6CmzlA6SonPTlM72lqHiqjqiEfTjGhM
	acbezlZcpbwdis9Rnwv/EPQSkr3EZZsGUXTdpDdeegRCy82aTNf3skCkVNWA==
X-Received: by 2002:a53:d34d:0:b0:676:933f:736a with SMTP id
 956f58d0204a3-67c145e9c63mr1511973d50.81.1793996424542; Fri, 06 Nov 2026
 12:20:24 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106135150.377761-1-cgoettsche@seltendoof.de>
In-Reply-To: <20261106135150.377761-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 15:20:13 -0500
X-Gm-Features: AclHuK80wVM9D5jvusMXErbRqd-bcz-pBKJpnUNYrkIvzGki8Q4hva9EaA5JEH4
Message-ID: <CAEjxPJ4B2BTF3yxzUsr9eu=1hSZZCPWZgrnPDSOeHwvNb-ymgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsemanage: make the migration import diagnostic distribution-neutral
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 9:00=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Describe the required Python 3 bindings without naming distribution
> packages. Include the original ImportError so missing modules can be
> distinguished from failures to load the bindings' shared libraries.
>
> Use sys.exit() rather than the interactive exit() helper on this path.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
