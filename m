Received: from mail-oo2-f25.google.com (mail-oo2-f25.google.com [74.125.231.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331073A4F58
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740625; cv=pass; b=km+g4eB5ORNP49J8K7xhTF3+TWuR1RMPObR+JCVvlsG7sjikOD1FgK+Qo+7jhuToWmFyqnkTA6b/We8iKbjX2lMnxKgeGEc1zj4jpXwXykOBLqYLfltZU3hXwj5bvAC8oPnAlRm89jEgVonn30u34wCWfukSM5fr2HRxsABDUOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740625; c=relaxed/simple;
	bh=pDhfueW/eTItbc6zBt9f+qDQD+P2qbpAzIyAaH7vb8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBZ7XvP0KXak64wRCXelnm7czr3F2dO8Igz20PN+SzFWwEyxmoVSispjM4hjH4NDSAt0OyP3ZUrMQ/wOqsqpnJB/eVti8B+jvVc/lUWTCdjfTrevUABo6glvGivwwZElY/anJOlQ2Ph8JfXdFxUmkUZLu+lU/NJwQMUQP9jBSDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbMW3oVd; arc=pass smtp.client-ip=74.125.231.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbMW3oVd"
Received: by mail-oo2-f25.google.com with SMTP id 006d021491bc7-6c901f4bfffso437311eaf.2
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 07:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789740623; cv=none;
        d=google.com; s=arc-20260327;
        b=Zx5CByQtJ2vm5V+bWGW5NiqhuenOTFwOR7vOTxH8vP0qxFtEDILtX4OHhb+JmjJ5ox
         +8e1cmj83NomJA0JEO8E8cMCn/V3v7PpuZgDCZxbq66XFov1s3rr8pLzrGk6YkrBVvj9
         gqSm/BeUtn1GJYLPvJbjWaRL4/NazWbL1CimEDby6VAH6EIlwTIvRrLjCAJrhwSI7QEQ
         7mTHPIWwTw3Hr8wCMIayjrxZUlS0T28vG31/Br13TT3t/3gXD+2amtsa/ehLWjgfWR55
         IJHg4VpSFpHnMXV76iEPvW3JQ11RO7HSABBxtc50WiOG7FHjbH8RRC3eDi9riL21QQBS
         51+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pDhfueW/eTItbc6zBt9f+qDQD+P2qbpAzIyAaH7vb8I=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=LTmtciCc8jfzTyI4rZ0CDiRE5SJ6tLj/08Ci0EHXBLD1fMDhBtsgn3rK8oSZUVF81V
         kmZVr3ZxtIuna+fCiz0A1avdDqlFpDGv6uV+F6ftXatcRidTc8kCCB6lT9Ql6OaHgJ3v
         Gp3n3lAjo4l38S0sU8DTYvRTIfsy7WFqoJkQzOTdjbEU1AY+dAyaqovEZpq+PVC7qA0l
         8zsxjet20itHCeG4m+iu9ZMjIVpAXy5U5Z3mnGgGbBZicV77sv4NJEXMWMLH9rY9XY36
         xbKfS7epwX4Jsus+n7o3vcyTn/AaUZ/bTVQjhbtpU8zjhUYfzv9qWNqQoo+dNCKSXR/p
         xC2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789740623; x=1790345423; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pDhfueW/eTItbc6zBt9f+qDQD+P2qbpAzIyAaH7vb8I=;
        b=MbMW3oVdqfOo0d4BRGtUSHA8vO1YFYRuHVnCYk/v9lBUo6qFY+mrJX7XNRfnX8QliC
         2D7RXQGhzKgsN5eXQNcX8rfIXD5Da7aPQqr7/eOyc+9TjvyIrYIb/9ysPD2R7HZKykPx
         Ilp9/ysbXw30Y/cZKHUw9aXZtn3Gk4tSG84JQMsaLS0OBbe2POiti/88lzQjH2M1UvkQ
         Hx3Eoz4vNuK3wwlOqtLVJzoSJQXCkgDsq6TXicQTdKQPoeBGShIKbU1ZHygWVWwE1B8W
         d2Pbnm4oiCZkSW10MCTemOEWEhNoFUOShfQXDOYr7RP0Ja8WkS3A6cqC1XI8gSygAqc3
         wyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740623; x=1790345423;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pDhfueW/eTItbc6zBt9f+qDQD+P2qbpAzIyAaH7vb8I=;
        b=U/1Q/Jbe7EDOFqRDiaLlCJMw82cJC+JYvVcazeGC4mD464i4ZsUDr6W8F/pdYBOkCs
         jxfFf986DPuweQ0AkdxzvMi+h3bJJ5os6tX/NqNo6kmn01+U2TKfkkAudlGxC7sb4lKR
         11JT5kYFUnTSPsVc4u9LYmJddpYOIxYfLTOX7QrTheA3IAat398vkR5DJXJ/ztemLB9+
         /70FX41sWHlFLmraDB/8l/oUe+dd5HlniHHPGrr+aq0dclgqb5Vtk/LsUCzWKumJVDJN
         7A64EuHU55hTsyG/7P1jdzmOoP2Fnr9u6i+BZsScJZilMpncNT+w5WB8G3XGfgcYgmSk
         9Lcg==
X-Gm-Message-State: AFuF++k5sRWagHTPvS0+v1dpXIGCBcz8K6vyVmzcpTgnmkge/d4cDbm8
	ngqLQek6D6e4oDwq5DIxrT4jOzFH3fK94cBOLERvaLTyko5Osmph2WVuuZC3XAqxqu5XRqgisqP
	oXKAL5RX3DQJ4Mmi1L+e9L4spJ04+DaU=
X-Gm-Gg: AYBFou3FBFBSO5zvMcINo2OQg7i50R9XUg7RRYSX948o8ydxysguarP/PJsYBn/1mKM
	m3jHY+F/j4uOeV0EOoeSlYCkR1K78k6N7tdU6e2cpPCXPfLitUd9QbNycuDa/TvZeE3/mowMkVE
	xTe+gyL5TR8NJSdb2EpC3gilx9O9vpc8V9NLgUtU6f7alnM0PdyACHRZssVZSRhlo7NXNAL/cal
	kRb1J4md2RNuy0abLO21SgFm0RsfEJYapbx8Caf6rPtGVb4CsGu9QCIDHaUJ9s1EA9CzEy8iyS/
	Rp0WJ4OIBKP8sehujhpNnMUk+1RcYAU+NgGGRsY3UDpds0CBP2w8q0k=
X-Received: by 2002:a05:6820:1518:b0:6b1:5c8b:c0b9 with SMTP id
 006d021491bc7-6ca9a54755bmr2756405eaf.3.1789740622841; Fri, 18 Sep 2026
 07:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917141317.54719-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260917141317.54719-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 10:10:11 -0400
X-Gm-Features: AcwNN1V-Unj3I8WtlgvVw73-XNNI81dnbd9oGLn0nVy_IH1wvmctXAARk-HA7ys
Message-ID: <CAEjxPJ7gH2gGh6yCb+GYzoDPhWPMyRPsJJEofOqBR0kXrmWk-A@mail.gmail.com>
Subject: Re: [PATCH] selinux: constify avc function parameters
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:13=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Constify read-only decision structs to ease reasoning where decisions
> are actually modified, and where only processed.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
