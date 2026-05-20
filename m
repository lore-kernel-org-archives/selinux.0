Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C643BE165
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297168; cv=pass; b=Ee2kv1K9L3jGoLSZKmdQzVGSOU+fQVAseMVLYcwXUfnNCzA0rfUyW1sM5ruJzI0svk9u0905JYKW6kuMKlzXdjqb9v/BfdrWKr4LKznsGRXCXu4ZKoJi4qBmeuYiimNEuX/4+2fEzsNPbUchDdiSdFnv574KQViUKNFEJGMKIOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297168; c=relaxed/simple;
	bh=i6DXoiTX2kl5PG72Hq6qVXLg9hFjoGawY9pUz/Cwnhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFIySinnkqDxXBEiZatil6aUd8ArVvrIsbMQzk3B5/GDZu+FQFJhQu0exmM00tpv4Jv7HTpjZBibmwtVWGpEdnv1Swak56xGsHLxhGjbebKMHdKJgs8FBUHnUb8/+2La7NYg0SRo6aBlnd0+mre8/NNjvsEXWw+yeKXyv6SQIj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dIwfjcEd; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dIwfjcEd"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c24be9e4bso5443326d50.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 10:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779297166; cv=none;
        d=google.com; s=arc-20240605;
        b=fw5DASOneK/mk0pWks6ZOpYNs9+APGXKV5cASg1b3bl2GubOglzjxKnUGjkvbNTkOY
         LwzDTvzK6ZVjn/cuLJiMAauaDgu3lc0YQTk6uMR6XaZNrNeORlTy/q57JsqauC3pfK3g
         pBKDHFE+XykxKI0Jp5Z+IduNsiAcNY8yYy/2nJ5DZuyF9kWsqqOfrNvg3LOkuKV5Mfc2
         woRJaExl6wROVDNcFeao2LiXHOiPGl9cUIfkubpvpcd3q24+cF4agVJ76p7R5C/e8laa
         5AzaKVQI4qlcyfrhBG44SzQXf5pylldYlXmmz60Dk4O7P+LRMdP11LoekGH5kuKTSbwT
         +x9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d1oj9qt9eNBbgdQ0bOXWTA6TB+CGs9RzfM5j2mAeGpM=;
        fh=xmBstkTyjO+i5o2iES8nvQyMPDIL8tC4gmsuRrdlMhk=;
        b=kVR4moOUSRjT/GNs/HYqf2kku6qrRJIqSVmLriZ9PmP01RxkORDcZPe4THzAJSzS87
         o9HNch/abwM0s9uJ1O+h4ZlJ7UGjloy7PXPFRNDzQaE+6pO6FjZNhfWGcXfb+3l4nWg9
         7JnDDxzSNsGa2yf/T28krlyPyKrFwv7r320rLA6Tm2UnbDWUfSQJTfzFJ/dA9dWMnowB
         rN3BbhXm58+5W64uOtceuBU1i2VgObpwo9xamquT1WphFQEZJn+nXVr5Nzj8yo2P0FVD
         lO+R4hJVil+NU23bXU1patIXABpiUKL8XhSJin+l9Te1034jzFJkeGbgfwPGsuhcroBY
         uw6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1779297166; x=1779901966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1oj9qt9eNBbgdQ0bOXWTA6TB+CGs9RzfM5j2mAeGpM=;
        b=dIwfjcEd7YJMU/0DNqTEjGz/t1k9fTFKbaMhyBkUEIFLTBIW5ZCjXQdtI9shZlmpzW
         jp8JnhRwXZ0mki14c6yW3tmM8moruvSQ5m55G+Rr0DrttaL5bbYcev8igYypzCNKtIoH
         ofw0kbiq0N7nqEXMCX2jwKfYTpER4/NDFqrpRo+JDGb8wlfCMJOlEkIN9EQ1GBmfUWkt
         OYwwNn16asyxk7nwd3kOV8BC7b1zGb82dc5pH5jQ7ibp9NLF/SIM+mEj2ULS1PSYLjd2
         URcgFQSrmGjnsrsme+GnMIyi4zY3PvHwo1pLDBikh1vTWr0iSqxgSXUTbEGINJ2doBzS
         i5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297166; x=1779901966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d1oj9qt9eNBbgdQ0bOXWTA6TB+CGs9RzfM5j2mAeGpM=;
        b=Dc0XcipNteWDiOl8woa105L8doAu94vA/ZSux6uL8hMPvjR/0hylLTmjDPKfKThhgQ
         0NdzShz4lyncrA8hNn5q6dLUZt0t4mW4GZNGiWmo0/q4PqwzAds1LvZpijUDv71PtHrI
         /pFoMawUT+LeEb82ZMaoB6epbpLHHqtt+A5ejuulmHllmuGcmbMDQ6der45Qad1DcL7U
         9lSj3QEeR5x4icAeMSUEIDrBWtCpRuXXKAEHBC6A2NkORORGAjs3AzSvL0k/JqPDO4x2
         Vql5f2fnndONn0neUiKIQalp00lDvy+FoCW3Re9rBmVKGXWTOqV7S/hAxIq8Woxv22aL
         kG8g==
X-Forwarded-Encrypted: i=1; AFNElJ8bFH2LxOn9OPcTfLu5UeU2xrLdrl55axKCpMFMxyUyDzwc8JWIlMab5owTBzYFhrrhil7smKfc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8lnxxp/LGNgTLNUK0PYRsOAPFffsnK/7myrzHDBfJYE0PUYuG
	rWMZ6ChkPT//Ps3T99epI9UEl5q7sxo3FdSGReZagt21rq9UuCs7eB196VJeqZCrBXfIoHxk6BZ
	fMzQyMGPwGXiY+KJJyX7x9jjRTqHifBxRwQ==
X-Gm-Gg: Acq92OH4j49BDuy0UMmTAkxXvD7kWrNLtDhrraIlyl2wIqoFd3mIUYD7Gh60FJNcDsr
	EBYAv1h1ss71hcaKJtXRhWuqOrPUE5LMBJ03P8N+B/oFVrQPH2bUmAOZWfTFr/Ww+ZIefBnYk50
	0cKjz9aLvi3Inq5DKS5TJuqFXfzkrlrORT99Qgc7/S5nHtxPxdb8AM8cHL8HBn5z633WlRiTjpw
	VFxPjm2lhRl7sM7m4+0kvrZyaJ4CV/5sZ6QmzoFKPm/RIAwwLIa6kbv8GtIONBFeTyLRWnBIeHk
	eSCQCKll999FFPHOteNSS/nYlBK4ULHs3yN1fejOAA==
X-Received: by 2002:a05:690e:1285:b0:65c:2738:c6a6 with SMTP id
 956f58d0204a3-65e226b7b93mr23855068d50.15.1779297166034; Wed, 20 May 2026
 10:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507161633.15947-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ7ynbRQ0OAwFUj7RGH17WBpC9Ekwhkadu=wfq13XjAicw@mail.gmail.com> <19e462c5110.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <19e462c5110.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 20 May 2026 19:12:33 +0200
X-Gm-Features: AVHnY4JUP4O7v3PyHW6YriC1zUYrJGqT_tWIS7-6rDc6M2DnpRFq2xvlnV1urpI
Message-ID: <CAJ2a_DfJZzZUe7XoYM27gQSPgBsEnXkCL=GX70Nvys6XN7776A@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: tighten type validation during policy load
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 at 19:02, Paul Moore <paul@paul-moore.com> wrote:
>
>
>
> On May 20, 2026 11:45:57 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>
> > On Thu, May 7, 2026 at 12:18=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> Tighten type validation during policy load to improve robustness in
> >> the face of ill-formed policies.
> >>
> >> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Ping.
>
> Pong.
>
> Just a reminder that there are free things I dislike more than "ping"
> nudges. If your patch hit the lore archive and is visible in patchwork,
> it's on my list; if I haven't acted upon it yet it is simply because I've
> been busy with other higher priority things.  Nudging patches like this
> simply steals and wastes time that could be better spent elsewhere.
>
> There were a few of Christian's patches that weren't merged due to feedba=
ck
> and other concerns, but I need to go back and see if it is preferable to
> fixup and merge those before looking at other patches.  Maybe this is goo=
d
> regardless, we'll see.

I'll try to address the comments and rebase *soon*. (Haven't found the time=
 yet)

>
> --
> paul-moore.com
>
>
>
>
