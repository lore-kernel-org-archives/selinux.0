Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC296208D0
	for <selinux@vger.kernel.org>; Thu, 19 Sep 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778460; cv=none; b=DLBBJ9RDfDb6Oy64qHOigpdcFaJhWdwKhgMfuf80YAqqGIyLdtVq1LmHYuF+2AqHV3b2Gx00Wo0hFwsmNyB+PGXQPCIcHAX2VXXyZ8Tpdcyl1+b7NVKGX1qG3cRsPRayNVs36ASBtiuP/15a10mrLPT/KiztOdxF0cdp3dvpv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778460; c=relaxed/simple;
	bh=LLYF4HCt7wGpOmsf8gBZNr6B3FbRhbhRANn6W9z0PMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVAQ3eK+QQoFzdiTCtlZgmj1dGO1grVN4bWaCQSGWX1nu4wPjiIbXfOJarF3HOJCe8wl6o7NntGLqMqCVR9MYjGDkJbtoLCiYee4bMec2UmtBq9+KHZyVTp2781bnL8GESQaadU81xODdJxbVK/sHQ2HMnxwZRFGNctC90VlRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BUNJWpNS; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BUNJWpNS"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6c3f1939d12so10841727b3.2
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2024 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726778457; x=1727383257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNSalT2dJe/sVHCZY4JIrPde/S2tv3TfgE18cTWAoX0=;
        b=BUNJWpNSjhCRP06xzaNajVGU2J0GuJVRWobbkqNpHa+mrHQwBjgbaMoBzbosHfbr+1
         UAquV3isUU49PH8B/ZRyYJf5SeaJAlzU0VbdeYodVU+Yg0US6FI4UTZ7rNDkOplQpGyF
         4FNrZCqbvanw6PUJ37OYrtAqdL4qvhyl/mS9/ltou/wK2ATZQ9kC42+1IIi6fJ8E7c/t
         An/kcu1IvaIEJtuolAzVbxun0iKsqzIDwF44/NfetsFWJXT+waL7UunQMdad41y8N4Gr
         Zooup+eKwqGGUSukhgC0HQujEzo7t4pSVWs25r4XgmmF5K4rmEEUzjZhsQgs1YOlFegM
         wlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726778457; x=1727383257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNSalT2dJe/sVHCZY4JIrPde/S2tv3TfgE18cTWAoX0=;
        b=rv+lnmARj5pmkPHZ2Yan3LAB7TEHwTV6Jw4Ni3KaBIQRl4u4eOK2hKbVaj/GmpTS3W
         wVvNTEZZcBwfjR2hS3BtO1EqDXnMSGu4uv/b5pAaJTFVgp1jEkkO6Tyn1vm3wTNPXGTd
         lT/26ZXH1FCVlSJmT5JmcjQ8cNyCKRjDQA8dMtx5TYwcvkj0JYVx2CPjp4xspBtLTvxU
         pPADZ+ipVIpPQlzB6I27gNC+589Hxqe56LYka9wPmrJ5fhcKpqz7NyZE39gd0gp2oUBV
         MsXXJTuFQaiXXZu9+JoG5fpIZ1f0y1mBM6+8/j9QmLvAuUvMz+eOaOpOKbKGJfMoip9u
         Wtew==
X-Forwarded-Encrypted: i=1; AJvYcCV2DbjsbT72e3MJgBYaqZxAf7OLjPfSBDXXAzJCl+QmKgTvaV32F/brw8Qz1tpwFaBo3u72r0iu@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKil1OR+uYe1NiDd5VOeccWJEywNAfiqIEyDwwEluy24Izsy2
	tZQAYS23/Su6DeamY22gepdEOXpkVXg2P7y0ccFk3OALjSdGH39Q/e2Y1sa+LwPDCkOquNIAyB9
	TIOmPzZ+IubPM69evsZPWUF0p+mrj3FpIkGvzkDWbyUrmI4IXrA==
X-Google-Smtp-Source: AGHT+IG3NYcoIMq/6C5DjJRp3iiyYZFZhIAqjCV5eZ6PayC1+cE8btMaITffcm8uxjDoU34IrnAGWilz8n3KhJjjdtY=
X-Received: by 2002:a05:690c:6189:b0:6d4:b774:e503 with SMTP id
 00721157ae682-6dff2b291a6mr1939757b3.41.1726778456834; Thu, 19 Sep 2024
 13:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919155740.29539-2-paul@paul-moore.com> <45b4a802-6f4a-42fb-85f3-ee2b97c64c07@schaufler-ca.com>
In-Reply-To: <45b4a802-6f4a-42fb-85f3-ee2b97c64c07@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Sep 2024 16:40:46 -0400
Message-ID: <CAHC9VhQtig43rD=iiPLjrYk=fXEGN-ZuC3=UN63az_FE91YFVw@mail.gmail.com>
Subject: Re: [PATCH] selinux,smack: properly reference the LSM blob in security_watch_key()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 12:34=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 9/19/2024 8:57 AM, Paul Moore wrote:
> > Unfortunately when we migrated the lifecycle management of the key LSM
> > blob to the LSM framework we forgot to convert the security_watch_key()
> > callbacks for SELinux and Smack.  This patch corrects this by making us=
e
> > of the selinux_key() and smack_key() helper functions respectively.
> >
> > This patch also removes some input checking in the Smack callback as it
> > is no longer needed.
> >
> > Reported-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com
> > Fixes: 5f8d28f6d7d5 ("lsm: infrastructure management of the key securit=
y blob")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks for the quick review, it looks like syzbot was happy with the
patch too so I've merged this into lsm/stable-6.12 and I'll send it up
to Linus soon.

--=20
paul-moore.com
