Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4F23185B
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747855829; cv=none; b=kIGCtBiXiC0Zqq4B9D6XtZ1tDGWLiM+f5fRcsPcyUa65R8uoeudxds+k8qasxlhhfYB80SNIwCGI5hfrGmm5rpXX2Gl4wwR5sPIaBXRrqy/ODcCnPX8cG4XOTVJrtw6yCSUVTMEgL757c91QKQ3fMkX7tQpJFzFpw8c4TOw0FI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747855829; c=relaxed/simple;
	bh=ze+2I9gYt4QMZyIahbU5Ps6OetGjTNUPPk2IUEKyuIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slacn5mHtw0nzXIsPYwxjsL/XhEXLZt58zm84qMj1Suz3yXDMLhQPKSaLAw+/2W9HKKgP8Y2+t5Bf9lM7JL36Zyt8WpK5JL/7+EJumjZyt7CNjcBd9wr699mn62kKv+epaG26liYl1ob8n4B7i30iuAsiSiHmB/HoDxAWT81p3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV5SI4J6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV5SI4J6"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30e87549254so7842704a91.2
        for <selinux@vger.kernel.org>; Wed, 21 May 2025 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747855827; x=1748460627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze+2I9gYt4QMZyIahbU5Ps6OetGjTNUPPk2IUEKyuIQ=;
        b=KV5SI4J65R5A0wKjd6sNvfKQ5XqYBMjWfingQ7AdtiFzwTZhY8B9WfA2HHnmnS3CZo
         3kEGPjzDtgbC5Yjnpb0cY961qX5HFjGr+1+skmgikkIX/FdI3Jfg33VvI0pdQun/2c3x
         f4p5jHthYp3Xgp0mvdaqXk6sZjcvrJOGoPpFyOwDW+iEJ6on8UjAtViSiaF7xvu9XXjZ
         s14FkBUPckH1bguFpY/07q+Bv2IIMGF0zK5Ei7N+pKppEuIG1+hwf2FMLj48AZxNvGEA
         cy+yPLiN90Q+5/TCSjFrfoBx5KnCGoS21rOjkQkhJbSJWBtouZxy0HHT/cbPNEw59d/j
         NTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747855827; x=1748460627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze+2I9gYt4QMZyIahbU5Ps6OetGjTNUPPk2IUEKyuIQ=;
        b=NFiXRvo3d1Vp4kHGTbmuCO4RIvpPEJVOscbHSlgcmV+QAiFJ6oELfWelAm5plIQaqt
         IaoZIOzYL0l5uxhh4RzCz0dpll9wJCgh0TvyGrXWwUN9u53+1blH1VzXj2Rf+uPQZ3qC
         nrK0SOf98iyZMXuy76UCTchf+VpB1TwuMTZfpR8ZaoyeTs/+g9N5yIZw+0b/NuXffqWr
         jO9I8bIePzWD8lrVCWiAyQiyCUi+hYen7WdNnU+uf41vWrISA6kZxnPISY5UjGnaa4vy
         +iLiRCMbG1nUO4/iVVDW7BHqhLLQnP0e/aE68qpLv68EZn9tvEq0N5n0DkhONZ7vLhAC
         bTKw==
X-Gm-Message-State: AOJu0Yzbt/CviQHKmkkrgkqdExEfxgPMKGe8whr3pAifi3Jxo/pT2F2x
	E0EzhFKUiXWtnZfUEJvcrNJQZ0aSrFK4g3z7N9u8+KDDBmjc0Ap4QkgPWV8gucpjYZHIbtjs+/b
	5sh1xVnBDVWBqvUNWpkhu0Di6WeQokVz/+Q==
X-Gm-Gg: ASbGnct7wVIM5WPrH1jfAvyxDDC99TBFOynx86f72N7y2DEbtzVuCr1EbEFBDbgKYZi
	kxr8o3Frup5YFPD8WtGlA8aZwEgB0Yz8+UUk6aNeBwkY8F9BenYdhISRlYsXQMG79DQLFRth3HH
	98ke9vWRE6vh4Q3GjYuxBWKa/1BEZub2Bk
X-Google-Smtp-Source: AGHT+IGVlfDv/9KSA1g6Rwr18Jdq0yWOTcaZzjtg5BKM22vHp0DnpueA0TpxvFC0r/ycDe5Hdx7slpxyfb42C9l14Lk=
X-Received: by 2002:a17:90b:2d83:b0:30e:9349:2da4 with SMTP id
 98e67ed59e1d1-30e934931cbmr38546426a91.12.1747855827389; Wed, 21 May 2025
 12:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a34cb17-3290-416f-bea8-bd743e18ff3b@suse.de>
In-Reply-To: <2a34cb17-3290-416f-bea8-bd743e18ff3b@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 21 May 2025 15:30:16 -0400
X-Gm-Features: AX0GCFvKBCGZ03LWXbuZwsKONZzyy6kbKB_W1epHCBrSDrytzJ2Ivafbo49a998
Message-ID: <CAEjxPJ621C3V3wiPwaYvUVUMs--590iGjE5Q=ZScy3wYuZtXQQ@mail.gmail.com>
Subject: Re: selinuxproject.org down?
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 7:39=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> Hi,
>
> I might have missed something, but selinuxproject.org is down.
> Is this intentional?

That site has been mostly unmaintained and archival only for a while
now. If there is anything there you are relying on, I would recommend
copying to the github.com/selinuxproject/selinux/wiki and updating any
links.
