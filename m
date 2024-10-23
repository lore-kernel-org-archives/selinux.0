Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F132914
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642457; cv=none; b=oSvrKG7t+QGmec1w3WQiJpt9QHlu8w897w1vcAbONDkhTh+Q5LG9L+GlgTaqaiHO1i3pqo9jIWDvkzLVL7Kd5jsttCQJAje+a4gPbeM0ZB/gGik1AF5rS0jmBAGcxML0/ibesurv2X1jSYon08n0eP3JeipBWyYRClhja0IicxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642457; c=relaxed/simple;
	bh=odY+y3UzaTo9AY0ajrF8E4n4kT75AnnIjuT7joNLwEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyxbB4JbeGESYhF/Hg2YAXMoCAyKFTY9GeaK5lu2E22/ythDL3WsJclgU/vk3FPy+/5yuTP+xK5eSi3ci52fMIn4Sf6VZoWaahT87CgzgeJnCFHCoTvqTPsKCwR7kMVanvDVSBi1gqyhVzQS4z2x8xL9RIibyHcG1Q+FFoOEuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Fprj+Cco; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Fprj+Cco"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e290222fdd0so5352135276.2
        for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 17:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729642454; x=1730247254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0nkODUymzcBaZ/BR2ZkBHf2AEcpK9fd3W2/+PYst7A=;
        b=Fprj+CcoFwNy8u4rRJE7XEecCol5BfPAZ260rZ5b5VsI9ST+1+d/K7ImdKHSjUxXP8
         o8uNMf6jRxq1BI6HKL6a0cqO9+aMK5yDUHCtsuKGf/jrP5Ays5cTbjwiaOGvQkynIeiF
         N4ZKUntoTs5ZXLNZ4hIKyiGUX4rNCtAnCYFiu8RmN8ZIj5St6wcXAk/1os4Hj6o/k1/E
         mvO7JeuT+lvZIsCoU7nLJ+25o061MK+5rQ2G6gjN1yvSSasf0mQ4Ro37mvNFaz+jRa8v
         IRE8NDyog2NVpDqTe/SBki0wVqgT/pJTMIJz8qtE1M4dNy0LtFkG0AcHxg7mjCEJBv22
         p58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729642454; x=1730247254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0nkODUymzcBaZ/BR2ZkBHf2AEcpK9fd3W2/+PYst7A=;
        b=AB/kJ10mCT6bAo6lvY81LOO+2OVsuQxz8AeFkTnq1i06ogxReo0BOfgAUL9ES2ownp
         G88OWUHpGWagbU9IfOauM12pzF1ZCOLAQrEKztquS4niZ5mIbMtfaOdO9UImIGRPNV8N
         9ZiEvzq9wncy3DOTjGsYXHe9J4EhDV/+2k8QMkTHd+BJSiHGULZqUjGsNU4/coSqn97h
         3NF1OoJolZDdE4kzDpjN2fSuRrWnZnH9PkFBiHthWIZTfdnaId8bdA508bFPCqpk9He3
         QPax51W0z2cG2dR51T7twvaDTrauR+V2jZKr7D/cjCTg+ouizOv/W3mAL5c8QfVCaOyu
         vuYA==
X-Forwarded-Encrypted: i=1; AJvYcCU6fR4hCyA1XpJMJ61H08MNNiG1rZE78oi89Uv7h7mCko4wO951vVlevo4PG56SKZiclyn0Lob9@vger.kernel.org
X-Gm-Message-State: AOJu0YxemE1R/P9/CdANu6m4er5iidvvXe2NWniTk8uT7rFTzfiRxVSh
	5zB2WpXdNctV9peP8cPV4tF6kFbM6FVwwSiF3Rpuxy/f4e0gC0v4fEz8f3uZP1jJfo6xdE6vNF6
	yutnGZO8Uka5VL5hq40DApCIxhYlZijmeJFto+dBsZ8NDpb9YjdhC
X-Google-Smtp-Source: AGHT+IGOthNoHG/n67oHj9DXSU7ZYuv44uXKjcZkYQzs3ANqfoU/9SGpEZtRYIqF/9Yun/Ssc6QU4YYUv5OYGhzf1SE=
X-Received: by 2002:a05:6902:18d1:b0:e26:1041:498e with SMTP id
 3f1490d57ef6-e2e3a632d0dmr774166276.13.1729642454617; Tue, 22 Oct 2024
 17:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7JTbEk-=r=Lnjm8MFC1VRn49wWjLUKsfSk=eAryt6S6A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7JTbEk-=r=Lnjm8MFC1VRn49wWjLUKsfSk=eAryt6S6A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 20:14:03 -0400
Message-ID: <CAHC9VhTUWcZFr8HZg3gHnqgZ2PAUazpRX71Jpue1b0QUCEJKsw@mail.gmail.com>
Subject: Re: testsuite astyle options no longer supported
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 3:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> tools/check-syntax in the testsuite is calling astyle with options
> that seemingly don't exist anymore on my shiny new F41. The end result
> is that it will generate a diff deleting any C file from the
> testsuite.

I ran into something similar last year with the audit-testsuite and
astyle v3.2.x (may have been an issue with earlier versions, not
sure).  I should have sent a heads-up to Ondrej and the list, but it
looks like I forgot or was distracted.

> Invalid Artistic Style options:
> indent-preprocessor

I dropped this in the audit-testsuite and it didn't seem to have a
significant impact.

> max-instatement-indent=3D80

I replaced this with '--max-continuation-indent=3D80' to get a reasonable r=
esult.

The current astyle (v3.6.2) call in the audit-testsuite looks like this:

  astyle --options=3Dnone --lineend=3Dlinux --mode=3Dc \
    --style=3Dlinux \
    --indent=3Dforce-tab=3D8 \
    --indent-col1-comments \
    --min-conditional-indent=3D0 \
    --max-continuation-indent=3D80 \
    --pad-oper \
    --align-pointer=3Dname \
    --align-reference=3Dname \
    --max-code-length=3D80 \
    --break-after-logical

--=20
paul-moore.com
