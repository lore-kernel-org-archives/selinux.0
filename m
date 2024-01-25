Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB86EB67
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195821; cv=none; b=bmFVHl+9jY253oKbX/8Y/GUdVxbdit26totmbxa/+sW6mXhVE2HlTnTP/77zsDPKS/yiDU6QuJf8DW+i69eMbe+jmYx1PqDtqTxBkE0Fq1N7XVAExG//EI6K65GoFaYldrpyezBmamFTqBQFSmjRbTdHfTYMnLb4XUJTwvlv/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195821; c=relaxed/simple;
	bh=Z4LvpRhYtCpFCxHDl6IrBz55DnvIdtDwnXS/Ri2X0mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pL8y8SZKUuRIeMrCnm2yJbTJe/Od2aYzE89BZMXNWW2ySo5bJCxplkiDpxQgbsXMkmhu+vyFvDmw5NWfTovLb2s4eQqUcbCzu3cwdaDeMFtAlhwD1h1XgaH5UIbz4A+r3ADOwFYTKc4N3zMeTPBuBgk5d+eaXWmSpJ68YTInXxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J1Nt6SJR; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J1Nt6SJR"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-362a24b136fso2079065ab.3
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 07:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706195819; x=1706800619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4LvpRhYtCpFCxHDl6IrBz55DnvIdtDwnXS/Ri2X0mA=;
        b=J1Nt6SJRMLh0XvaaVOU6JZmhNCDabczWJr0hxyL628rsYQgSzuERXKWrdky4qp4IpN
         BsSEYGJx2IGlUY4ebgG6236ojUDTmBLwFGgQzzVVb6nCmDi5MUIsLBUCZDfv3n3bNA2V
         CPpHdy1LyyrIkEmFp/JEJVF/kGoIyCG7JpmJ4E3KSucGV8v3ZPELZRaod8VLY/SRgyph
         yUlxInXqsxbwJUPIZI9cpLcba6JetnRWkCPxgThuV7ncXzBqRaAsSW6iEg1SZoW2Sh5r
         SjYElgfWGiaxXVylAMoWBV4f3Y/rj0fBr2Ycrzodas3eZhJZRQZ9EDhoexD8dNqDZjkh
         LMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195819; x=1706800619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4LvpRhYtCpFCxHDl6IrBz55DnvIdtDwnXS/Ri2X0mA=;
        b=PDqG8ZiLdus6qeQ8LXmqWoqzhy4hCz3n8LrUHKZ136wmPjR/OQRIR/kMqrLERnqhU2
         J17yZLQPYbz0vuiBw38LYB2B+uWAl0j30/6lgTROThpJFd6szSq1zSOT7h00TbdwWxLB
         WKo2HdcAKdt4ZEs9BtN+PfVFQgOhDfKMUkYVdQWdBaT2o3zoiTq2ypHtUVtysov8MXSH
         PpiIOyrPaJyBkpa9XtrxUhr2C+6tnX+aVJU8ZiN1zQ28dRXtWT7N2Z3oRlm8+UPF1xp1
         vChQG6a9QpqB1toPuuBcit8cUW9dyQCpX3sLou8Op7LonafJYtGIHBvktjrtaSLkiWek
         0e6w==
X-Gm-Message-State: AOJu0Yw5y/1C/v5uklv0urNg3vwu4X32LsZgtJULAP/kRp/M0Zun/fdM
	o4v8XOBRSrIRor8ySLNKuB0XdaXcPhP5iyRfAPg708k1UJN4vZqt0ifHnvPBv/csA0iDkpkNxGk
	XPChvHr6c0fYW69cDZrp9zHYxxpgkNyAGVY5xsY95JYU8yfA=
X-Google-Smtp-Source: AGHT+IFuJ/H7AxMBKPvzz7e9afDPVRJKtL5sBarYJQN4sPmOxRMzCpc4nZjftzqsbJUUOfiLhG29Q/dT2jYGkkezams=
X-Received: by 2002:a92:c150:0:b0:362:8232:b420 with SMTP id
 b16-20020a92c150000000b003628232b420mr1356403ilh.27.1706195818886; Thu, 25
 Jan 2024 07:16:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
 <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
 <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com>
 <CAEjxPJ5_SQDmR9b-+0woBLg25omtERSLBKawTV9AqLpZAHFvcg@mail.gmail.com>
 <CAHC9VhT_zOjJpg-JOaJQ4s9ybArfq2Ez_OiFAk0siPiqEC0KiQ@mail.gmail.com> <CAFqZXNvSn-Ct04ghSxiceKkRBgfyUeWJc3J0tjnU-Mm8mfPtAg@mail.gmail.com>
In-Reply-To: <CAFqZXNvSn-Ct04ghSxiceKkRBgfyUeWJc3J0tjnU-Mm8mfPtAg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jan 2024 10:16:48 -0500
Message-ID: <CAHC9VhQ4hopKwh6y=M2kZfgM=cdcWvqAbGAD9HMRhDDj88R_xw@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:15=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> On Thu, Jan 25, 2024 at 3:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Ondrej, are you able to post a fix for this?
>
> Yes, I'm on it. I already have a candidate fix, but my kernel building
> infra is currently acting up, so it might take a while before I'm able
> to test & post it.

Great, no worries if it takes a little longer, I just wanted to see if
you were able to put together a fix or if I needed to do it.

--=20
paul-moore.com
