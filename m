Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CC374171
	for <selinux@vger.kernel.org>; Thu, 29 Jan 2026 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728009; cv=pass; b=RyHgSNlU9UuxuNxKPsMm49nLGVhvXikLPdwmtNXnjVseCwbhODUGZ+yEi7hfw2Dc7idnAa3zY/zf3bFMogF2eNoli8HD3mpMCa5RPcMDZ9fXm++wIDuB8esSkqr4a6A0yuMxcvkM84lUiS71psWFSJVxfXmDyQ92q/C+yF3xwmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728009; c=relaxed/simple;
	bh=rjhov0GaazkCkB4BJQ8rdsawUcuL8ouqck5WKEqQ570=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEkbqsq6reCZwnnT0ZljabwNyf2Mul4D/oLouSYxgHasJn7j9Yh/gWS1mYvMHhutTTMogTX/bivmmUVLrC05HsxiPESJ/E3nlEpqNYxNTvRyj/9JPHEQvQ7EGnMlvPG5I0ORVAMcmKoCz/ubxPS/A6eGO40ZAj979DRW7is6j/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NN3bmjiX; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NN3bmjiX"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3543e57a229so32979a91.2
        for <selinux@vger.kernel.org>; Thu, 29 Jan 2026 15:06:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769728007; cv=none;
        d=google.com; s=arc-20240605;
        b=Ftpomdvt6Vp+Gp35TwPPcvj8YLYauvlSh+vIh67bG0jueau8GHcTOiLZxPu2QnrNuD
         LMNqRlh0fYwaSjAIamUr6WxRTcBqVKBn9DoKJAqBFIB2AmwpO457qo6BI0pOJIOLg6YC
         Z2gRt/1GJa4nVsqOwQtC7ZjoGPvo7QmfcqRvKUh6PFycCtGbdeUk5jNZstsxkU1vaDHm
         brTQnl9WS0ZgifA+iHc3sht8jtKHNcinutmsR/+oSmRbwBeDNKDkaaFytXTRj5SEwTkB
         sYysP6pCnioDAwHjbqc+6JuzDz6ITrJIcZcAvChNOsJkRJ8Q0Ge5+e0zSSL4Dnw/9Yd4
         D8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2FgRhUI4ULyQ5DXrJKYAevPbTbBkxgDEbQDJd5wdBQ4=;
        fh=1QPjcOo3uvxsFadn3QjxvsyHTTLm7peKgWbaQOAHB/o=;
        b=PPZoCZ6XOWAA2BaSK9yhwwc//Tg9QUPRtAhq97EN9fcTKnG+/kXPNSTz5xKIs9WICt
         WGJUEWeHFU7VOV8s77m2zv0FwfST5duTh+ZbbJZ1bESXIUD8iNSqC//ku6sCHEpp8Gdr
         +M+iAOGHTIKk7YhTP0CxNk/FE653lR30wrGiLYBx9RqUJNL7HxcJgEczm3ffCl16gN9x
         z1YsdMf3IVix/P8Fwtg/vDOq7f0YizoSfxSBPOLHzJdP2c+Pq3yG1DjvKn9/rhBbBb8/
         hGqAs86Rj49E77Xv3ctCqa9W/w3MUM2YHUGd8Wi6cGPnYXQzXHmJfJTRf9GF2Mg6FwgU
         KB0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769728007; x=1770332807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FgRhUI4ULyQ5DXrJKYAevPbTbBkxgDEbQDJd5wdBQ4=;
        b=NN3bmjiXJ/1Rv0kUuYchAl9y4jCWJzaiPufbucyLnNUW5M9flMkq1Y1DGpUydxcAiI
         qb6HH2WBAe5GVSiGL5+rUimTErvV1CP3qxe+Go3H23xqJJICSalnAqvHBc7JjTr+u//O
         1RpmkBBfFBTyrAwGUFe3aSE5419JmQk7rD7CXkF9CaSsDciWjPMzSQSj+S8K/c/XJt/p
         /WYk7AhwbQTQnjeRgtZ6Ikfewos9c47YuuuSV/cJ1MY7lt58nccSyPGHxdSy7lr9cEUz
         szXTR1CA7xO+xvPYHUB6kIaVxcgDr3ixzFjfnEU+CYEpCILP8NcPI3MpmO7GnEJQDSgD
         jkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728007; x=1770332807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FgRhUI4ULyQ5DXrJKYAevPbTbBkxgDEbQDJd5wdBQ4=;
        b=orgH7QeZ4TuuH5iDcElZ3hK5ffgN+Wl1emS3BDM+rX9quNy2h1TEUX6q2laguo+v/A
         ABaVrDa2s7pmqRn+XBdP2sTbprUrgAZ0xXu64l6Sg4xU+KoFGw+pi14dgmOX/f90OOFT
         xQ82cZ6SAjcj6JGjkjZbWDLVOYLFRngd9r7JKfoKl4RWZQjQfRMytZpCS8kRGx+dgunv
         I0wbszG9swZpacbX/9ndypFL6TX3/TaLIFOnEllybPAryYIJOc6x7Qx2sAEEvZHUC0Su
         nxZoqrdxnN2nGV4RNb2TVK9hOSpPx4glktniqVx4FZetuCiBEymErM3oXwVyaJyI3PZx
         cScw==
X-Forwarded-Encrypted: i=1; AJvYcCXzAd6tZQlGqBKN1m6QzPnP5WGsU2OXlzY+G3yBrK8q7iZgDfi0tF9HEDJEthbywvyEU0NaYvQj@vger.kernel.org
X-Gm-Message-State: AOJu0Yww3WICIN8ZG0RaMWeS2h3Lhv0FMqvfne7jLmTSC6MzkzeONWDT
	O8NO8rCn0JV2jGPZUcdtf098Kihid0EcYHxAgTC9SARw54eglq2fnC/LNeBCqB+6MZcYTHfj2ds
	LdrGe4AsyINrzdT68MAbcxxG1lbxlpSBQ0Wnqi3Ux
X-Gm-Gg: AZuq6aIrVHqUejryPNFUJJ+i/qR3k76rhmhzWGStmcDdoyhRRstQZdJfToWY6ejqQJa
	LCscj/OfyFXE4W73wN529DzC9vr2BD+08mPPJ9NRFgLEfLD5VXNH7UbBkgBHQid8oLotdtUst87
	PybTFiAFe2H9WtV4AxKo/HRQ4YSc/UPx33BdIYQ4JyTZntxnu7jrBHI+T4XP7ieYK5X+sQ9xp56
	jxculsIc1vt1FAVNgucyoLK3l2RlFtTzWzGrsj49PlLyGjwgj9M+nvx2Xx5oCFSyuJJzOo=
X-Received: by 2002:a17:90b:4a8b:b0:340:d578:f2a2 with SMTP id
 98e67ed59e1d1-3543b2ebe3fmr942700a91.6.1769728007348; Thu, 29 Jan 2026
 15:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017202456.484010-36-paul@paul-moore.com> <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com> <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
 <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local> <74286aca-a565-489f-ad2c-886c650ea2bc@suse.cz>
 <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local> <CAHC9VhS_y2gy2nAK7C-OpchME0pzS34-QN2bY9t5SRBXArz8Xw@mail.gmail.com>
 <5392220f-c29e-4cbd-8dae-59fbea4c6491@lucifer.local>
In-Reply-To: <5392220f-c29e-4cbd-8dae-59fbea4c6491@lucifer.local>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Jan 2026 18:06:35 -0500
X-Gm-Features: AZwV_QhVDVaLZs8JJVAmxYQR-vhXYvsk_Nd5ubbkE2VXzkBWSDq2lgRuz96U7i4
Message-ID: <CAHC9VhSqpqVT4oFzvFpReJbh247mJnAz6U9ax-DS3oapHRnf=g@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] lsm: consolidate all of the LSM framework initcalls
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	wufan@kernel.org, mic@digikod.net, gnoack@google.com, kees@kernel.org, 
	mortonm@chromium.org, casey@schaufler-ca.com, 
	penguin-kernel@i-love.sakura.ne.jp, nicolas.bouchinet@oss.cyber.gouv.fr, 
	xiujianfeng@huawei.com, linux-mm <linux-mm@kvack.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 1:59=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Jan 29, 2026 at 01:31:05PM -0500, Paul Moore wrote:
> > On Thu, Jan 29, 2026 at 12:11=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Thu, Jan 29, 2026 at 06:02:00PM +0100, Vlastimil Babka wrote:

...

> > > But that's future work, for an -rc8 hotfix ...
> >
> > Expect a patch later today.
>
> Perfect thank you very much!

A link to the patch is below.  Assuming I don't hear any negative
comments, I'll plan to merge this into lsm/stable-6.19 tomorrow and
send it up to Linus early next week; this should give us a day or two
in linux-next and then most of the week in Linus' tree before the
v6.19 release.

https://lore.kernel.org/linux-security-module/20260129225132.420484-2-paul@=
paul-moore.com

--=20
paul-moore.com
