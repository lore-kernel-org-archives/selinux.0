Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8DC1836D4;
	Mon, 15 Jul 2024 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051342; cv=none; b=RKGQXUbOwzlNJJknChYLJ83KDR1xq51EndL2FUCZcMJw6sHiVyouFeBEpjqD/3haJxxtOI/NZe5j3CNjw4z9JxfLeDsVOBLzg08SMj5kXfJz6zIGPGTCrf52XBpHd2hSjtdfUyQiUGWM9z73EwA+dJgGyvaxK13oenazzuSfOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051342; c=relaxed/simple;
	bh=zzuThzXYlJ/GaRfHe0avY0Bw+EU6dUkMNpcSbCAKOes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huU7ipcxBeP5hWkrdM1ucGnlNaFZgE/1AdBxK126LKSR4jCziSYkJUmU+WGBpgLY9RJAnLVdGmdezHnrz6IOIbI/iC57YG4g2kAWxfHdsqVVEXf5Jf/uNHMZ2t5rKomwZd24jOANoKYJdvABKWdey+CtYq27BrbHH/vK5k6ihJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2YjZkkd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2YjZkkd"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c7fa0c9a8cso2759753a91.1;
        Mon, 15 Jul 2024 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721051340; x=1721656140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qkf5os42Dm8jX0sOdellctfINgtVkON6TdrliUvcwxs=;
        b=C2YjZkkdz6xe4599m5rlCo7AJ6bQVAcE81AAMwhyQnykmO4xBbiQwMVVz6QtqQ5Gp4
         elKO/C/98gEdhBLlpnrf1TPoHng4uShj8ZBl9hHytyFrFUMZVNwjemVjF/PfL0UG01lC
         BYNXMwjTLkjar3nQ2PpiyO+7huADs6bELoTTvd1qCuqbXd1rHesZCCBBAL7aQxx/uQMs
         rRRlAowrTxZROuKxQnbph6XKuI9HL5NxBSLR7p+AVBBNTWyy0sglsclr2bqzdReWGIOz
         if0qplBnUOAy8ECbmP5ZjYV0+EXQfhCmX2vHg3U6p4KxUj2eX5sM2HAj1Xi2JAfXTk0z
         C7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051340; x=1721656140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qkf5os42Dm8jX0sOdellctfINgtVkON6TdrliUvcwxs=;
        b=qT/Y7yjjbDd0GxQamjz1aYOqflzRGszWJHx1sDMTbAmBA7L2CQ1L1kMGuC5arKomaE
         3Ftrr5zc+PgjP01TRoq6ihPZ5S01RmDwzcFshv2mNLcXEw0A95fO1GuF3RAj9uWdJK1v
         1Fvu3Vd5yYGsmnu208rCmIJd1hxfynN6ncxWdB799Lstfa89aDg2oSfme/esvOS1Z143
         fsV522r2E0wy5GRmvw07lYO1mVmnSMxL4gLTHYK0b6vRNCCRZAFiZkNn5mWQFtCUmisw
         y8cPeW3rJIo9HFVaCRgvIvzBUd9hfzZn1oL1zsvQQCbSdVPqGvNfD+fSkfgY622DAPys
         /AVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTVnX7uObLv01bP91Z4iF49lFXgnR20qHoqWSKnqIs1ebDf9vqnlf0VwFBVZpj16Jl52Ejvk61gTcIyDkIi6M4sPQtBXSP0uSiOQCpkSwHQtNFCF+b5fAD0wZkMJo0XZySxguzqg==
X-Gm-Message-State: AOJu0Yy21TUEywHnFPqtBOXKwNTkpHcf+lts0iZoHeUBjZvOPoTY/jJz
	prBxynSV7vIDqx8ZsT1H74oUZ0Up9wXzl+MJKWksEf8NPC+nUj2q2dP/HHm/C2QCdOIx5SR9+dI
	cxZstjc9YxlMO2ubKlwf6VOHS4+o=
X-Google-Smtp-Source: AGHT+IHeR541bjAyXv2mzJ6Kqq1p3KEfUX7Ote4V8WvlSlLE3R+aboe3V6yUd6n4Kr5vKPTDvXJSnxMOCPz7tSHCBOc=
X-Received: by 2002:a17:90b:3d2:b0:2c9:67f5:3fae with SMTP id
 98e67ed59e1d1-2ca35c72bbamr12256088a91.28.1721051340039; Mon, 15 Jul 2024
 06:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715014337.11625-1-guocanfeng@uniontech.com> <CAEjxPJ7QqEG+wyQfuPeDu0JqvjRCvbtVzZ6qtzwc-YwGz=mLjQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7QqEG+wyQfuPeDu0JqvjRCvbtVzZ6qtzwc-YwGz=mLjQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jul 2024 09:48:48 -0400
Message-ID: <CAEjxPJ5pLoGYWJpn5PijRzFVGkLeUcm=m_1AOSe6AXXWiaJ0ZA@mail.gmail.com>
Subject: Re: [RPC] Topic: Issues and Testing Regarding SELinx AVC Cache Modification
To: Canfeng Guo <guocanfeng@uniontech.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 9:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Jul 14, 2024 at 9:44=E2=80=AFPM Canfeng Guo <guocanfeng@uniontech=
.com> wrote:
> >
> > When calling avc_insert to add nodes to the avc cache, they are inserte=
d into
> > the head of the hash chain. Similarly, avc_calim_node removes nodes fro=
m
> > the head of the same chain. so, SElinux will delete the latest added ca=
che
> > infromation.
> >
> > I question whether the deletion logic proposed in the patch is more app=
ropriate
> > than the current implementation, or whether alternative mechanisms such=
 as
> > LRU caching are beneficial.
> >
> > In my testing environment, I applied the above patch when avc_cache.sol=
t and
> > cache_threshold were both set to 512 by default. I only have over 280 n=
odes
> > in my cache, and the longest observation length of the AVC cache linked=
 list
> > is only 7 entries. Considering this small size, the cost of traversing =
the
> > list is minimal, and such modifications may not incur additional costs.
> >
> > However, I don't know how to design a test case to verify its cost.
> > And I cannot prove that this patch is beneficial.
> >
> > I attempted to simulate a more demanding scenario by increasing the cac=
he_threshold
> > to 2048 in order to establish a longer linked list of AVC caches, but
> > I was unable to generate more than 2048 AVC records, possibly due to th=
e need
> > for a highly complex environment with numerous different SID interactio=
ns.
> >
> > Therefore, I have two questions:
> > The necessity of modification:
> >      Considering its potential impact on the cache performance of SELin=
x AVC,
> >      is it worth investing effort into this modification?, i think that=
 in most cases,
> >      this modification is not necessart.
>
> I don't think it is desirable or necessary. The current logic prunes
> the least recently used bucket and intentionally reclaims multiple
> nodes at a time.
>
> > Verification method:
> >      If making such modifications is reasonable, how can I effectively
> >      measure its impact on system performance?
>
> The selinux-testsuite exercises many security contexts and thus should
> enable reaching higher numbers of AVC nodes.

Other, more real-world ways of exercising many security contexts would
be to launch many containers or VMs on a Fedora or RHEL system using
their integrated support for per-container or per-VM SELinux security
contexts.
