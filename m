Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FF327A21
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519598; cv=none; b=jOrNopcLAlGhczohVogBMKj/dxM6J9L2E+zT2rs5NKZjJ67V+eI1Q9c0/kB1YMhLv987AIo1tJqW0oE+DRS5McfPxnWcepigF/XfZ26JF0hIwBbjy9AFdkIkbJddH/IZrCTk9cnG80YygrYeyirvkGnOAwLKsjKjzqea9wgXZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519598; c=relaxed/simple;
	bh=uRj2vFC2NIszdQIg/fUlIUi+Bp7QDPloOSSco4jZh+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQjIsUmLfK/Nt/1wjMkFmyzR9dQTm49adOY1P+whBj/Trl15Yzz0tklJLAPADAk7O1sFXxRl1J0uyVowf7cVlezjoioXHwQUzbJLsr3/Qk9YgHVWSFAQkiUCqg3fkcCZtyz1xsGdCwogYPpIYkT2HkzHgssf3Fl7C/unqqriNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fEXD49mV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fEXD49mV"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so4254941a12.3
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757519595; x=1758124395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggYnxQ5squSwNfvzzVZ6WVonpWDPmmYaZrdtlAXS80w=;
        b=fEXD49mVzFHNsVgDxnSqyNR9z+8/DTAfWviHumKA9YZnOiFPzUXBC0PkUxchbL9oZc
         2DwvTXkaQ10oym/5SOpGuhUi0TBPTgy7WYIMIe10HVP2xf1ZT0vaNQP36I9vZmUlT+px
         lVvRWsRwRq865+eoihuYi7oZPZPOxHKAzBX6UMlPSiPyFCSxNl/MBt1e0mLx6SH+jMcx
         p4I3NrZDGPMjuvL8iv694Dtk6mlWOVOMEj+U9gPHFgm+ytcB5aDE810HbgJ1ehBStDco
         SnQaZDCIjoXVHc+9uQAYeonpf8szR2iIxKnPol477gLV9QhMt3OP+voy/eqvjBKVAy8S
         //iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519595; x=1758124395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggYnxQ5squSwNfvzzVZ6WVonpWDPmmYaZrdtlAXS80w=;
        b=TicFl2DmovggyEiZSRxJpYDekcQnFzi7Oj+LQDYDofNzTbw0VSY4cyz2Gb0+dLZByq
         dx52ptp5kEcDs/VVPpAEWVEBHMNPe8ztcLzpTFhH4aYxvSMOEWHmgtmBBynPSUqcU35u
         B7gKLocXIrO0GTNPdRUE58gWNNcNJU7dH4n3e1pHNmaVc6aBeCnVLZ+Us6NIxF5iMMIH
         d7ONUwPK6q9vdrTgDtQ086PUwdZDXZiMEqXfI8yncjzntywwsvz5ppRiJdcG0bNLK80E
         uFMXi48NpTynFSckJY2XtOewjvHMDZlAxnt+NHe5X/HuzXGga6goi7UASNsXWls5RFOv
         cdzQ==
X-Gm-Message-State: AOJu0YycTbpG6CMO7KxtfRwfPoroIw9zDpISJSmIWUxRtFDtpZYWNp16
	mXBomOCpnWDXYqbXII7w+q+2GuH/41+BvkAgSJRX/z+0vP5f14MJrYFSRM3jP4YhKCTY15h0Bra
	Lf6xZjyhsryZfLf3w+Y/KAmMFTXzI1TnOEQAypm+f
X-Gm-Gg: ASbGncuFEr4uO2rXS7E1VspvuJKEOyC9VAADHLNjigEiwHGaxNAriVBeVCxNmTTMtlc
	7re5Gl2xmGf+pXdIJ9jmVvyH7uCoV9FGc4BKlN4K/5KQ0gqw5+QAL6EUD8q0fHmiYNRhicSmBWD
	LNtyRP3aFU0ovgn4JTcXm+mMBCPep/3iQTLwkrdWZ7yXlARScKkxa4UQMXIfnTozottP2Yw1VPp
	XLYE51MFoQHQ122hA==
X-Google-Smtp-Source: AGHT+IHa9GOrLQnP13uGSu+gYOlAwlbILzpTELSAVL36J/YKn4c2GrlhoNFreFQOnm7CLOIV5m2cqaZDPCNr4FCeDI8=
X-Received: by 2002:a17:902:f706:b0:24c:7bf0:6e6b with SMTP id
 d9443c01a7336-251751ea241mr196269955ad.53.1757519595113; Wed, 10 Sep 2025
 08:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAHC9VhR+5+B4Kx0zxFvZaiTM8Uw55fdA5d63+D7PV7Bj3tKPdw@mail.gmail.com>
 <CAHC9VhRXQWz4A5pN-y_nmgBC+Vwu0Qi6_Pb4ec4k3gEc1sgVOQ@mail.gmail.com> <CA+zpnLeC5XOH8JrFrP0rsqw9h8pACqJk1-=AgXkYkZ3dCQpnMQ@mail.gmail.com>
In-Reply-To: <CA+zpnLeC5XOH8JrFrP0rsqw9h8pACqJk1-=AgXkYkZ3dCQpnMQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Sep 2025 11:53:03 -0400
X-Gm-Features: Ac12FXwRaXXWs7_9JeqqEZgxq4wJ4932NCkuQFTuqHHAqntVQirbZvdjrWbebgM
Message-ID: <CAHC9VhT2KQYPaYkwM4ZJ46aQFAwF1t0p0o9vgHc9mkgwXMo_Gg@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:53=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
> On Wed, Sep 10, 2025 at 11:37=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Tue, Sep 9, 2025 at 5:33=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > >
> > > > A prior commit, see the 'Fixes:' tag below, added support for a new
> > > > object class, memfd_file.  As part of that change, support for the
> > > > new object class was added to selinux_bprm_creds_for_exec() to
> > > > facilitate execution of memfd_file objects using fexecvc(2), or
> > > > similar.  This patch adjusts some of the sanity checking added in t=
hat
> > > > commit to avoid a "silent denial" in the case of a kernel bug as we=
ll
> > > > as return -EACCES instead of -EPERM so that we can more easily
> > > > distinguish between a permission denial and a fault in the code.
> > > >
> > > > Fixes: 084f547bd8e3 ("memfd,selinux: call security_inode_init_secur=
ity_anon()")
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > ---
> > > >  security/selinux/hooks.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > FYI, as of right now this is untested, but a test kernel is building
> > > as I write this ...
> >
> > I was delayed slightly as it turns out the latest Rawhide dracut
> > packages are broken, but kernel boots and passes the (unmodified)
> > selinux-testsuite.  If anyone who has an updated/patched toolchain,
> > policy, test suite, etc. can verify everything is still okay when the
> > new policy capability is enabled I would appreciate it.
>
> I just did. LGTM.

Thanks :)

> Tested-by: Thi=C3=A9baud Weksteen <tweek@google.com>

--=20
paul-moore.com
