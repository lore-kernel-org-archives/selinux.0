Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF224FECD5
	for <selinux@vger.kernel.org>; Thu, 17 Sep 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648414; cv=pass; b=tMBGn8N1U0+7pBEarhmOvXj2Gd+9u3OfZHwgeweBvWdRZRuDsm8W5TjGy+yxaGqzEdouKoZr3K/mpTbLPZNHlRRA1WQUVIdCL2NNY3HHi4x9D9xZTiYBe3xMAx5oM0KDtkdRQRQUZJ4srUoU3H1CqD4wcv1oIaYii+t1jvMRV4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648414; c=relaxed/simple;
	bh=Se6cIo1WFHWGhsSW7dFOFqAPQlL/ICnwyOwCsMaqurw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH//U/4fZPV5wa+Usne1wDY84FRxyBiqfHm7M2nhfZmUpCCKdRvbNTcwwjb4d9aePk+6Yo8ZofEBYTYv0TgSG5LNaEr/MgkcYRXEpl+aBq+Xz1vSkdVLX6bkE0/vTt1xB+igbhl00qRtbG3jXd9lxZy4koAi34W52f4Rnc7AunY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj9prMRv; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj9prMRv"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46a63c34533so756011fac.1
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2026 05:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789648395; cv=none;
        d=google.com; s=arc-20260327;
        b=CT5MYlFKdcXxRQpsTv+2anEgSjNmNsruSd6Y/VIP9u+wLnU3XT18RVUi0yD5n+irhm
         Il3xgdCacIl9NTO83io75FDfS3lxTlsimnKboHBkIp2pVSma4TIBxHbn8WDt5FU0iEOY
         Vf1jF+UsqJCKR2VEohWdrll20+ZGOngq/64POueEPtJd0ncvZzEB6rlKVgap2GB4ftpu
         pCGUFNEucYcnhOuA3itOYCxUL2/1KOdr2KubWA4JiawPHLwzCyyaiTqKyqxoxZ0Q1APw
         uhBWv07OTxZs9HxWPIhP8tIZpjQBzO6rQfxYIJeGis83+wlwkpbgh11GkTZ/IrEuJZlw
         AY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a5RnbFbxHgKBbKff3InAso/l5VJgMsZywjDBqqeb7lM=;
        fh=Bp4YT5ebI2p4Z3OUCaRwIZrtpDw6BKlHYsWCaJCTIpw=;
        b=ngShXewiR+v7vRJxgMln669R8f0DuyHIjG+HGht/F8xkN9pAC+oaDlc9NcsznP5jn3
         KnHcSnhMY83Iw1EakOHhThNezS3mzVE2So8TFVru4UwC7xc3t5SIFbZyqgThAkTh60X4
         dsitk6snB21pk1OHqiNBUDR09+kV/AoxvF+tSe4XY/JEmwLqBx1RwRJdbP5NpJazEMI9
         hvbmAOkWXjibpnQ2eS//mOLE/cPNfdgKDkQbZtfHfeG4LF3OZXr9wBQTZDwqzclpuzC8
         G7eKmt4jIZk1aSztIQYorpmp8LUZick/GAnsKfts49AvjeQ7kTf/RCa1NeY2H0HZqBlJ
         hIHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789648395; x=1790253195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a5RnbFbxHgKBbKff3InAso/l5VJgMsZywjDBqqeb7lM=;
        b=Vj9prMRvcqxPugwY6tLnXDtt4ASZbtcayZDboq1icnQ46bwHrHZuGMpSz0b6MOSgNq
         hov5xuD2Z5cwtSqejFDWQFdSZXkj05ZoC45q9PuQCU5NoFtxP/hAGlGIq3RmxOkcgk0x
         RruKDjpbF444FZSnnADBRThdaUqOoIOU3sScEZ5e5rye6l8Dtr/uqGoXTqsg978+xqyD
         kHBv6x8YC8X5lUlY697RFBkA0AkQrSy2SxroJVKKGF/UqqZjxjx52ipp7nj+snVNwW87
         u5hjHjuPbSxfD3v6ZFfarWL2i6RvKQ669AfoNSOXYudVU/Luf/ujGMWmz6PPnzdfNhBS
         Hh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789648395; x=1790253195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5RnbFbxHgKBbKff3InAso/l5VJgMsZywjDBqqeb7lM=;
        b=utS0Y0QoGQUme/bxuuk6l8QHs+YQg0xuHGWCqOofob7Nc0ryurqOHO7uZjyjgEQj+M
         vTUq0UrC/8Tms4aoWTdTUEH5bZznSEMAHtt2n1nXCUArsLrxRfbsNLqFoAavlQw9CItQ
         2lKhx8sLtF97S8kQF6NwmvKW/jHumHY5dcsoLfyBAQ2Fi0MJjYhiYSVaZgZIAWCYy875
         6d5jYmTa87uQyPYVRIeed+yUGP+6u6PE0wAM/gZX2JoyhE5eT6sBJ355X79CfeeURX5a
         gOuvnr74DTdWfBvgCsgQjGR3mKvfbn/tdj2W0+Nuh8El+lFFAhYLEB372O7y6+mJD2Pz
         jsoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNBh3jrc/YaZGKh67qr65ztZAVty5lHGZEDwXIVDZT/fKiB5kcxbmS2ug56LpWNXeKsH1357/h@vger.kernel.org
X-Gm-Message-State: AFuF++kwUzj/QhuFmh7/6ZxmxZs7lx0PWl0bEuxh2HziErpAAJWIzqZY
	w75cyKlH2TV+zGwJdAuFJpKwSEU5CdmiCbPMy60bcb8RtkMA6D9oEa5heG3m73tgF/y/M1hvpwG
	PNaKu4sqe0uXhTrWDD7wF+Uu7DZTttFY=
X-Gm-Gg: AYBFou2OLsv81aogWbp5qc7WE7x50yNpkhUrM7EnoyFS5FyNRSLfN3pwF9oq8RnOUCs
	M6Erjdq13t7Jqj20Go+6FSyOBzBs05co3pidXdsdBnruk98F6jWnOXYpWl00XXd0/JD7vx6KvPN
	Gksc7zcoHl3NZ11WcJXnfZHbFH6TDt55I29U3Vo2faZV89a47+TTjgJrieq8f/yUGaLVZHQcd47
	AAwn6D8aZ6brJ5+i2I1gfzCBkg4/RuIRfQieRpss6FPa+M2vbKuwwnil0x9PO56IS9z73dquYU7
	ZGd2WhdTmQqc1TodoKvy7hFe0iFOjpQF+fZvu+8KBM4JK9Pu9Ad7iIK6nFIf6zIkzg==
X-Received: by 2002:a05:6870:b3d4:b0:475:a1ec:9621 with SMTP id
 586e51a60fabf-484778f2bd2mr6009481fac.35.1789648395563; Thu, 17 Sep 2026
 05:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <L8sbFRgfQca4r8AaNEEfTw@coker.com.au> <CAEjxPJ56+YkfCgt_08NgD+6pQsvDGrsUgx3o5eC-U1ZmE9pfqw@mail.gmail.com>
 <CAEjxPJ7TLMCPkE7fwKrSp_FKJ5xm=7YpNu8LA4GM1-EFkjsamw@mail.gmail.com> <DG4uy2aaSG2YnBe-oDHGFw@coker.com.au>
In-Reply-To: <DG4uy2aaSG2YnBe-oDHGFw@coker.com.au>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 17 Sep 2026 08:33:04 -0400
X-Gm-Features: AcwNN1U6P3XBGjbogfty40Hxympgw5852WzsOnBk5Y-9jNjqWxBnlj8Z4Z54DEE
Message-ID: <CAEjxPJ4KTvpC1g6uE9fJwrm6oVE62bNM3qir1bQ-MWMQTWJpqg@mail.gmail.com>
Subject: Re: kernel oops on recent policy with older kernel.
To: Russell Coker <russell@coker.com.au>
Cc: James Carter <jwcart2@gmail.com>, Inseob Kim <inseob@google.com>, 
	Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>, 
	selinux-refpolicy@vger.kernel.org, Chris PeBenito <pebenito@ieee.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:01=E2=80=AFAM Russell Coker <russell@coker.com.au=
> wrote:
>
> On Tuesday, 8 September 2026 22:42:59 AEST Stephen Smalley wrote:
> > It appears to me that there was an attempt to make checkpolicy aware
> > of the genfs_seclabel_wildcard policy capability and have it
> > automatically add the trailing "*" to the genfscon paths when it is
> > enabled, but I don't think that works for modular policy. I do not see
> > such wildcards in the policy.35 file you provided, not that that would
> > help with kernels < 6.16 anyway.
>
> Thanks for that.  I commented the genfs_seclabel_wildcard line and it wor=
ked
> on Debian kernel 6.12.107+deb13.  I'll keep that patch in for the Debian/=
Forky
> release unless something else forces breaking compatibility with older
> kernels.  Being able to upgrade to Forky on a Trixie kernel is the expect=
ed
> situation.

I think it should be reverted in refpolicy unless that is now the
minimum supported kernel version for refpolicy.
