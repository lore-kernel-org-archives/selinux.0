Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBA3F1047
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859949; cv=pass; b=ZLcqOSKjzSC5Q7mdZBmcJP2WMUBYUUb58EEssdiHZ0osw0TZ9Fc+nVi6Axw6WfWpxfR17K9Wc+B8sH+M4GrrUtSIKQ2DcefjS8ySQdHozLagG+9hibskzBeo5fZWHkmIDThbq1uq7iafMxmv/az31irlhlmsttP2lUqJ9GW17I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859949; c=relaxed/simple;
	bh=LONOaKXSh/L9dM0fUN6y3tIlJ1bd7gQxiezYwdCxSck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAmpX7W6Xw2ivOlMHQr//evtZE/0Dn91m/RfLNzE94ePFfo3al9OHrzVfFDMT/pPA6iLu1syIc1yBvwBA64231m1IF+y3DxFHLxdb+7kxQ7iBGcrJ7MoG/gn2wcmbLOsPSqGeSsvS6shbFc/bQkQaXyA9XEIt8rpC88HUSnXz28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CAUoAlnI; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CAUoAlnI"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso78990b3a.2
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 12:45:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787859946; cv=none;
        d=google.com; s=arc-20260327;
        b=fsCGT7SixEDPOQT9wzvRTftzNMcnbVQmhleoz6rRWMUomukMab3Hu7j6pXOzJDaKkK
         MEuZPSUHJio8IJYWB4JmTXM69hPbuLcZm4GPeXmTcRQxQsMUZKoqCKStHme8wNMGHSsb
         0Zhbp6qw4Vb9ZRqRjLTegkde59oqxCTrrB5pnuvPLSBWOMaRO7shLqEk3UybOLdTv8ZZ
         NoVNDTparreg/ThQ4htxMxrQN63+ILwbV9M0fLBHKwEJk6HiSkc8ulU9NMyycFFjl9pi
         pUGFceb6hdGD5dktpkBLpBA5fFfKEPss1c2bn53JOrEBdR6oL9rAOc5ly3/vqnwMHRPn
         cOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CNkov3gmlX/LZbpzD7CdYnvdkwgpHnSs+aPVaResc2g=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=ORnMuzqm49ci7JridaIVR3wL7mZPkmMF6HYHOpWYCEzLsEpBfetnsc/XHhsiuhY5kH
         Pm6d2KsjMznD/Dy4VYj47z9WqvySq6rbkX3o47yJLB1YSI9UvOeGC1jiDathDMENJmOs
         QX5hA+wQ2sEUL1U3xTOQ4GHsqPIGHoHdjTbaZNwyyyX74wR50W7JC5n4C32fa0sgXdkN
         UP8m2zQw4lWJrgIOjhTn5QEY2jA5w0sIOXuxkK9Ekrue9yToG6vB1VNDsbhbOZdQ4R94
         hJZ/ghnLGPLvUu4SK1DEmaUv2aBnI+zNvyaa0+Wkb5rTZKKA6QhKKiRpA1lBut1yCrfw
         s8tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787859946; x=1788464746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CNkov3gmlX/LZbpzD7CdYnvdkwgpHnSs+aPVaResc2g=;
        b=CAUoAlnIQUouzCs9pe0zzNRLgmIiYrQfMBuXvbAfedOtBo9D/vXIBiNyTqttikoLcK
         9ALFoxFZuEu7H2JVG2VcAINPzVZPGaDDfi/3EyLAFef++p44Oo9g7UhCubBxeb363kBR
         G1oP6Zl6ZIUUliUozfwKEjrsAVnBKz2HmH5PKVVqHLxZtOWI/oS6ofhrZggM0I1zS5q3
         9PO1TKbzMuOYd8WDfXAxmzETPRg5S8RhW6LTheIZ9B/hSXk5tolbt0If51S8M784+Uzq
         dKCg2XsJ5xUKcI6y+YO1dzY+X2EnP36ez5GvhaIaHMnznrMMPOaDqrzppRfW7hsurdoa
         pdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787859946; x=1788464746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNkov3gmlX/LZbpzD7CdYnvdkwgpHnSs+aPVaResc2g=;
        b=PWZt9ZZ8HmFuP5qUgb4G1DbhyEvG4nF0JXETl2z/6TO6to+IpJxiV48hApcG0OIZoN
         r/rxvvBwIc2oYkwM4dcj7lwePM4JLZHggu8pG9Xec0lI+5qMeFODF7wTIKnsvDKte6lk
         UWFwcMurpijBFUpi46JWcphlQcEyCJ4aI2RQEsjFalAz92suEbPiT5zoIgT6vMbC5KQa
         pEOloQnTtTghnoOEaZUyBeO0Iv4U35DNJ+YCR1bXHgI/hqgFdYV51vePFMJZytPn2DfW
         f/fydfpaMg1jZVvHqEKSHTbvAjJUJ/FyE6hgqMo1u/FIFS6+Qg9+XReR7UhhcRP0KjW0
         X7oA==
X-Gm-Message-State: AFuF++mCFExwnUPSs2jHLjfbAUPsNryo4PKCl5YHRVU8TkidjNjUugzN
	8my5dhZqOSK+rHv8piN9Zz3Zz4+pE4RnaTQ9kklg+njjj1y7mricVdQi3rVpgojnyrSrLHJifmU
	7mSzof/avodO4NdKT07FzkZlvdggjuizd+JMEy4+6i2ITCEADb7EEEg==
X-Gm-Gg: AR+sD128w5nZeyEycOxz9rt4vjDNTuPsuWK4o7AdaHAa9VTjg3NEVh7fGwObEdbBLZ7
	oMdtRJHh9utTNphsgrwOVA9TP3gSsSXc1Uio8GaMygp/PaF4LNVSK8QIVw2+gzTu+nvYTThBIO4
	0PPWSDfPxe6F/gaIlX8SBv7GiLGuYIxYQkaznsds990dvqbiwmbyObdKmnYVkAhLIr/IW+x5Uvv
	t2C8P0a4RCIUXAn8UxnokuMjVvu6FNd27B7ejJHSSKzK3hICLRDgIDlJfPq8yOCK/4BOqKOfrkY
	Z48op4Z1z3qAVFmhwRyBs699XpXGn9RG+iu8Ti6qP0KI
X-Received: by 2002:a05:6a00:a87:b0:84f:b01d:3693 with SMTP id
 d2e1a72fcca58-85629730a59mr2402140b3a.15.1787859946071; Thu, 27 Aug 2026
 12:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827151203.108111-2-paul@paul-moore.com> <CAEjxPJ68+3+OJnm3Kwh06CN1dqO-9mWM6HDc5ufrN3gK3sG6jg@mail.gmail.com>
In-Reply-To: <CAEjxPJ68+3+OJnm3Kwh06CN1dqO-9mWM6HDc5ufrN3gK3sG6jg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Aug 2026 15:45:34 -0400
X-Gm-Features: AcwNN1WVyHwIa3hOaAxwwCZJeaz6t-f_ubKEelno4vIIhR4t1-aWmpUPs6EHuT8
Message-ID: <CAHC9VhRCQ5Y7C5R_jra28KUkwcWVgL+2+3qHzQnyt5Y3ZW-Y+Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert selinuxfs inode numbers from unsigned
 long to u64
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 12:40=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Aug 27, 2026 at 11:15=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Starting with commit 0b2600f81cef ("treewide: change inode->i_ino from
> > unsigned long to u64") inode numbers were changed from an 'unsigned lon=
g'
> > type to a 'u64' but somehow selinuxfs was lost in the conversion.  This
> > patch corrects this oversight and converts selinuxfs to 'u64' inode
> > numbers.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks.  Merged into selinux/dev-staging.

--=20
paul-moore.com
