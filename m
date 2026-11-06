Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793995389;
	b=Xepj1VmzTraPnRQ1wD+ztJdCXizVrzmjKcZ/yz8yVp2atJKu5grRQuSW02vfzPA2Z8gu
	 Qnwe0jB+Dau76IICjE4inscAnMPG+dCwULUogAb8JDHguK6VLE+lwNk6YksMgpToGPNqD
	 cfKgWsfc25QAuc/gbXxysMPR/+SsQz5nvkX5g+msuEcTWNbTDau2KRTRWBjEFsMKplDBq
	 ThbhVWGxYNsAKwugKmtUbKmoBXANxymNyO0T0U1PXtkIbktmsOVNRig6+HL874XMri5Gm
	 PL48v1ens9S3QrFEvO3LLOkjQxV7V79uziaP/BfILQN3TyVnRg5ZgTe/aDGpDJSRkPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NVPQJSVcF2e1JNY9pxERpCQpwpjW4iNLyKNTjzf2iNk=;
	b=5j0zgFRHa4KIk5P+DO1zo6Mzs8Cs39vAIsahDz9ffom5Cl6wYhRudGTqZKfLNFKSMkm8
	 W1NJ+7no522vcCnST2kL1GZ/BlrtY9kvId0DJMjRZgiQfS+HgALLlRUgaEvvoHFPrUD2H
	 3l70ti5KrtYApJtjZjIqOC8oir7iEtfkN6tGatNrINa9CZJTwV85L38VMmIOy0rNgP54l
	 2aOB7NcPZ95a/v1EJPZVIQ9tTNBJQeuL996BReYE8faRp7Bn8sg0di1al16l8IiRxxrnq
	 ti/cbfD5sTG2wob7KTogebdBQ+Ts89HHacMMa9pa2d7nASUhFz/R83TCWC18hJocGJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNWR+wFm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E95606A32E
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 20:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10E95606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNWR+wFm
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67583c777abso27747d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 12:03:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793995388; cv=none;
        d=google.com; s=arc-20260327;
        b=F+Rkngrjca29wLC0b5TlcecjkA5vCGOrKGeqJz0UodRykrjwVvmkAhdnMO+6PlsHmC
         O85rtsT2Flw6X+C6q/vGX2yAh8zfi0IukNM9JBEamfLWeBNmneJJmXAiDvgnjfeHk6nq
         zb3McW2nmBPMngzq/10mpvpIA5ttqXB3PQPiEO0+fp7EiBl7yKlRQZ23ugT0jU2A1Jvw
         iQ4fTcHHEV8PB7v6ScjE1W8UEP8vQMkO8LoVnQDKfi1VuKM7fJl+mbwVt8UABMm52Nt5
         osW5gZgEyKXHUDjKSiUeKhV2ndRaLMtVXmx5X7OnWSxelLylZXGb/jb8elW0tl7gpz+x
         HpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NVPQJSVcF2e1JNY9pxERpCQpwpjW4iNLyKNTjzf2iNk=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=dJm+wBKsMndsvma8HTFc6vpGQe2V8XvXCTVtr4b+p2Q7FvHsZYHhajNgL4X0oaer9w
         USp33tCb4jLT4uSTvd/3VjBilarnrTwmhdcYNMAEQKJiM1vafpBdfUUjNFnb4faWi3ID
         y8CaoB6MU8y5ljEW2xlXEZEm0nsFogQmLCWCFXt1ANcYdkz+fsq7PtUvBSbRU1n1AwvR
         gcp0sqiA8rH/WeNRRd1cTNZ7EsFpQsyDphYtwsw5D6sENZHNaJm74mw+aZSwIIxlaSzP
         cojPvlcG9i6zQiD9ZTGMBljy+cefuPzFJERZj/TGdX8fb7OAPE6QSXJUtjiFJQAjV3Jn
         uIuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995388; x=1794600188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NVPQJSVcF2e1JNY9pxERpCQpwpjW4iNLyKNTjzf2iNk=;
        b=WNWR+wFmsFfrwN+JSsPvLWFN6HYfwWx0+wBYsEr2zuywBkNnj9x9kLiNkNcSDIOTjl
         Cv6oME91G1G0/FOCF08nBQhjTuZPIOQbRa1t17vCY4vCkqGImody9CmaPVjtI+NdxR5K
         rT0JXzpYZuKraF5QuhvmjMbi6bJf8gvXNvOoMoPOtRxnbjuped/732+ej7GMcA9qvP+1
         pOvhf5vo/GdKqNuLcOpZEPz/GorKClvHAdEit9NLzPPp6ZxsFV7lqtSgDQt3CWCTDojI
         QplQ/9tedbiCbJA/Mx0UAh+k89Rjq4znd1xV8tc130JvjQRY991pFmCvAJ/xH12b/XV3
         tD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995388; x=1794600188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVPQJSVcF2e1JNY9pxERpCQpwpjW4iNLyKNTjzf2iNk=;
        b=P6VAEEp51BzOHg1AP0p3TabNZrDP4TqhXFnHJVHadMb3Nn3bHP+51wSHzj3UkRkWHa
         zQg4qNpPHEOgkHEMM8TIqq/vte8AKdZSS2s9A+goxEca4Y5Mom09dyVKoyIIqYuNZsTR
         B5hqbE6BUK4rVpccFNTL6ZwAL0mKq8ddOQACqZtTKFKfe8bMoqwTwbllxQwLm1FSG1Mp
         3WKGVlCmHsvKXJbZ9OC7NL8eQAmJsfmTEXF2lMOzhxj8Z0+sOb3C+3M2qy9yPIAfemDy
         Tk77yWgLmpNtogYJFiC3F9nwiBzpGGcY7DhFJ3s608mobdrEs1xFw2K/hMCYC0OagCpV
         Vh6g==
X-Gm-Message-State: APuU4Z82CGTmkvq13VFDvI4jINpBwCO7P7juY54A9E+Wi2i3edh/W2NL
	oNETX98TvVI86hkIN+fnOWdNNYc2Ys6vY8cmJ3lZ6JS/mbYb/4w6Cy18wk2Y7OhtQ3tPXquYHWS
	jrYXVh5b4waxBNpKcVa2Aqq3smk5xEutMS9ObC78=
X-Gm-Gg: AYBFou0JcYlRzzffrF9mWFqIQjn09mm3KKDQ+dN5LDk0o2m1sqSdQNqbVYxwN0sHt2m
	DgCDs4JDUTWq/1bckriEI1FH6NLUZvY/YLwd8zXhXVG+mAIOfSzjJpfVgRciiFIaiNHObT6N0D6
	caPxQygmoeCX2ZpR74NhQ2fo+nQmrm3/0/EQBY0KbtVPD9e4+d9FGhvthLVD3bEjkiJRQTQc6bH
	dB2a8ZDJen4U/0PjuAXsmiBRPvg+jTDmEHW2e//OcInHkrhxXZhHcSup3v636qxDbIe0hp1fqP5
	0BxyOwEH7IBVIfUVD5hLEcSZd3PaWoOOVqe94P1yZgikl4g7J/Tt8nDjepJ8iMylhiueMr6xWXD
	+QUeDdTMxLcTV0J/9VwkPfbLagKHjIWvnkAHUowP8URByNhndYJqGmFREosqIUYenwhy6QpWFlN
	7+i18jaHw9aRuoc7SY+LaLlSSCPd1I3utFcobMOxzgRnvn/ojGZeXM+vkxM8k=
X-Received: by 2002:a05:690e:bc4:b0:677:c90f:46bf with SMTP id
 956f58d0204a3-67c29ca3230mr16503d50.17.1793995387892; Fri, 06 Nov 2026
 12:03:07 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-12-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-12-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 15:02:57 -0500
X-Gm-Features: AclHuK92-bvnx_H77vSfPFONQEpIWzZcyZxc5XX1EL80sAOmfL5Z_I281Vyct2Y
Message-ID: <CAEjxPJ4vXVffgs4KG-xaOeeS=Rr+JQWu+O5N+t5sUtKVoKTK3w@mail.gmail.com>
Subject: Re: [PATCH 13/16] policycoreutils/hll/pp: report output write failures
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:35=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> pp writes the CIL through stdio and closes the output without checking
> for errors. Write errors of buffered output only surface when the
> stream is flushed, so a conversion to a full disk succeeds silently:
>
>     pp module.pp > /dev/full    # exits 0
>
> libsemanage treats the exit status as a successfully converted module.
>
> Flush and close the output explicitly and fail on errors.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
