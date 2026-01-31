Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AC1CAA65
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822372; cv=none; b=B2W8+wWR5fQLY2ZGOBT3W7QSlo4USrP8ulTYk3SMxUVW5czfmMNeCS2IUfWRGUXkM4T2e4zOlDwFaCxoVEbeqtFh84Wb5f1Qo+bqtuvubKC5225e8S0F/n399YPfGWbZCFNuOWWNZoA1wlBRst16w59CXjDyPjgRN1dkjtHqJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822372; c=relaxed/simple;
	bh=P/AkJ7VMQl7xg3h+SCs73opP330uFlSO7pps2YFNAtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/bmilEJvLomMODgYWVdUyaZAbWHgMteXYr299/drgDEAg1/4+De15MdGTFbyypnOQ/dzKR3vOu/EpvlBuxXzye0StMnF3xI/RsZxdd9mELAU3j3xE2yC+TgxCl+Lku9zdu8w77kFBg6M0wJrX4CZfLTZlMmWthToLclQeppe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NyYlK1KJ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NyYlK1KJ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-385d75e1a79so25327671fa.2
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 17:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769822369; x=1770427169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPpl6A64UKlYlKR2j1fRkib4LdNnz2WqgktVIjm2uzU=;
        b=NyYlK1KJhP7aeqIj1M+Ubf9iBqV55DCi1wSHjceJlfvfPLR0Xf3+PYqALoiduXpf5h
         2xQ7pDMHvtd5jmkxm3p2D0/qBaF1oOGDanemNi0/glySD0EDwsC46pKArbCrvo+Q0Ah5
         XetBC6H66afKtd53ETCCLa/gkAaUQyqMfsV9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769822369; x=1770427169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPpl6A64UKlYlKR2j1fRkib4LdNnz2WqgktVIjm2uzU=;
        b=C9kBotFsveIz0Qszzvsfg+OhMrWSvuOtP5antYLSeEbh27hBithgPk/KYZ+ucrcHJU
         YBAKnsWAXQ5PxSWx+GXyyACtEMJaWRbr69zceMCf2g7EAufcCvgU/7NCG+qbxk3KC5jt
         5/xRRd3OPPdJ7hDjw2BPnMyjYD0bRKY2gW/2ipJO5w3LvXYzt7wtg6A1k34m1U5sNiSC
         mzJpzsDMjK5uViniuZP6JX6zYPuOr7EUWkHuVPE61wHzjgpx2PpAVy199sRJ0WBiwyB4
         ujDKZDlQmEGaPs2AvtqTwciM85evmdCQO/FGk51kCQg4J5nPXVAR+jbZ5DHDWtfex8ee
         J1bg==
X-Forwarded-Encrypted: i=1; AJvYcCU6i6bzXs+aC3cOf2bgrKJHoisiJ32lTAxMHGNxdWJlF4uThhUR8aTEm9kH+lkf7uJlAyD/rVLu@vger.kernel.org
X-Gm-Message-State: AOJu0YwFhea4G7nwFOd6HWF5ReJ7TrJ0gBsrozi2XOEpoe+Ej2txeE16
	d02eDvtAMGSTXNP4SqjTTvz4DsBxECBk5ThUpZN1qclXVdIPm4yUrbm9QN0tnHb3zjXbD5Fate4
	dJhYkjeD6AA==
X-Gm-Gg: AZuq6aKwHfYvZB+6/5f+daC9KsKHFWXBl+T7IYsWwDoWouW+lrrY7DkGH4GWSAwvpDM
	oEMGK7NE6LqvX4g6EVN7WdKyb8aD8Y4pw/QLW1s5/xFxfkYrZWRyDHWjMXErlkcQCycwStCCI1o
	zP3WoxWioULsXP+z6KOUW4IDLvHQjuCGOslz9T1khHOh2UCta5ZQp0pCTo1qCSZ1yYAPdiXgzJa
	V/iXQanExq1eMiuBQdMzWxvyylWu/aCux0jxLOemMN1Gkywtb+q7poGZHL7+wr//a6EQntPqBOm
	lx3h4soMJQI6ykACuZLLNrv4D3UOThlYv57NFzWBrlX9CZrFo15XJOs7jTlRb77pYZppEbf20bg
	x5RrkYeKnoPktV6v6mGkg71bgu+v1FUG+KVrWo31DkY9ZLc4ibyYGAUzXn0Zd0EgWmqPn1aOyGP
	+Cx9/LoYh+RC7bSGjN6faS5nXsgmXfSRk41YPPSpxS+x7wFsyPXwONMiP9jZV3F6fA
X-Received: by 2002:a05:651c:211b:b0:383:18fb:fdf0 with SMTP id 38308e7fff4ca-386465f25f0mr13734841fa.22.1769822369181;
        Fri, 30 Jan 2026 17:19:29 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38627876ab6sm16316301fa.49.2026.01.30.17.19.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 17:19:29 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-385d75e1a79so25327571fa.2
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 17:19:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXD9iRo9LCCpgPK+vts+tld7tPWDixKKDjZUa89lvmRHx609DCReQognBaCtIUlq8iIgfDt5Qna@vger.kernel.org
X-Received: by 2002:a05:6402:35c7:b0:658:ba49:96c2 with SMTP id
 4fb4d7f45d1cf-658de54e61dmr2863591a12.6.1769821915767; Fri, 30 Jan 2026
 17:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV> <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
 <20260131010821.GY3183987@ZenIV>
In-Reply-To: <20260131010821.GY3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Jan 2026 17:11:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXq-bPyKywNOw7z6ehrVReyS-hSPuQkJvuhJWfXGFm=A@mail.gmail.com>
X-Gm-Features: AZwV_QiG_nByRrd83VYAdhaCU5_carsYUlImGLyJR9w-28CTqo3phlyWLRwFL8I
Message-ID: <CAHk-=wiXq-bPyKywNOw7z6ehrVReyS-hSPuQkJvuhJWfXGFm=A@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Samuel Wu <wusamuel@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Jan 2026 at 17:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I'd rather go for a spinlock there, protecting these FFS_DEACTIVATED
> transitions;

Yes, that's the much better solution.  The locking in this thing is horrendous.

But judging by Samuel's recent email, there's something else than the
open locking thing going on.

          Linus
