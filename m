Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934CA210FE
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667590; cv=none; b=sJbIIrsAVdSgYCMTwog1zTS8nUDCeNSkiZmCHBUbTiOwuTS5F/irxIFlWJJ+UgtEsWu5CRGvMWXfk/1LM0whsJeUklmgvRSasOxdGeRnIHItocvDghQ8n4bdqez/TGVadne6fjauiK4dA3yFsBH6cgxqZjc2p8mZVtmGqmwwWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667590; c=relaxed/simple;
	bh=9g3zWjacXY9yAiyjAJJZuEKjloyNlGIzsfzmlsD/p50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mD1gTSkXCsosfGJCxLAcKPq0+6q7D3KGXDklqrX6B9usNsC6drii/KEWPxvjUhlLY13oxzNqkcUAVzCr6pv88+Ryhswra/HgsBFIY8YundNWZH6XfADFw8bL6DBoyqtOZ6OIQsokwNaeVfeSFsTy1Wi3PaKGfr4L+Vq5CifkAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XaLrbA3j; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XaLrbA3j"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso5152792276.0
        for <selinux@vger.kernel.org>; Tue, 30 Jan 2024 18:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706667587; x=1707272387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZdvENlLRcApd2T67MYqo9J3s0IjigqVsNbUgSKEM18=;
        b=XaLrbA3juqJ7/rhuVXN3NZ9/josykqmvYmsxa/GwIy75UomqGBDdo93dIx43N0jzJS
         lJ1NDRWQlZ3JOhonRnAIPgGDIs4l7YkHL/uzJOct4/u9g3DcDvlD+/oGXs0gxBzUOq9b
         u7+N+QUzNcfAl4VoxzIqnUWAIy5gEoqfgzpfWP6yEzFiGzchT81li8BdEznhWHZN0Nir
         hPygUuxzA0PCOowYPTvObaE0ppLuIMh/MIquP2wFHoatgdmqwqOOsQ3kz774lv21X7gR
         NE1V8Z4EskJgOKLrZgWYH40pcQTvVSGFy+6v6Yh0R4l71cZF222DhV8UN6J6LQM8FW+1
         fTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706667587; x=1707272387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZdvENlLRcApd2T67MYqo9J3s0IjigqVsNbUgSKEM18=;
        b=jRMTd5n5ndCRP+3pau7/EDYcXwS6Sw1NvrtdZx7QkEHuNzwUsWraydXid5YBZMyxLs
         98x6Ga2n1Vo0VkWjKebG1Y7ascIe7+fH+Plqkth/ka0rh3bdkzem5tZSeV6PMecx1qr+
         W8q/zXhwWLHbEmkjT5pmUsO20m9aS4hDJ/pMQ24L8Yv3eabiJ/ru01f8nEDVvPj/Yr8w
         WEzu/8NDLWAv9niIK3bPb+w24/uRIOWW1PdWDgIh9kJlsJ2a20sbuxHs1wPuyVURJUKu
         iPWURD9NTLsLfgiLCjcn57TYOSzSPH+B1hKdYnJZgN8f7TxPFyoe1OmYhLI6KjTf97XC
         GC3Q==
X-Gm-Message-State: AOJu0YzRH/YA1PScPrSe/gAlBjKTTEWm1R+YGTqKgQ9U/eGIJcDH+98T
	lSRYTYYmz1gmcE+3oVO+tlAjgxlAjuDRg04h7hbzjg4aKSiuNRRqtrnNjC22Qv8IaqOkDcx6Jqp
	xeTHKknCZhRvweD9Niwq/SOBzYaVODt0+Pngb
X-Google-Smtp-Source: AGHT+IE737YYBvQ3Pul890Pk1OpdRVeqvK7t8FBJ1ULHG2/iAxR72EdAX3aTOsm9KGR/net7/hWOilqhOWg08e+YBDU=
X-Received: by 2002:a25:add8:0:b0:dbd:4dca:7082 with SMTP id
 d24-20020a25add8000000b00dbd4dca7082mr356154ybe.34.1706667587505; Tue, 30 Jan
 2024 18:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129133058.1627971-1-omosnace@redhat.com> <CAHC9VhSzdvJ2DAgV75Tdxk+tOLuhY-vM+BTT--Mfn6xoxVKbxQ@mail.gmail.com>
 <CAHC9VhQRSWMRAg=y5cUx9+XLG4A2_+WSqJN1RgQQ8bF=VDwnWw@mail.gmail.com>
In-Reply-To: <CAHC9VhQRSWMRAg=y5cUx9+XLG4A2_+WSqJN1RgQQ8bF=VDwnWw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jan 2024 21:19:36 -0500
Message-ID: <CAHC9VhRa5q3fvWUD-Dh-d5Udq18XqFwR4AGUzSow6Ur+_TmFrQ@mail.gmail.com>
Subject: Re: [PATCH] security: fix no-op hook logic in security_inode_{set,remove}xattr()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Jan 30, 2024 at 7:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, Jan 29, 2024 at 8:31=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > These two hooks currently work like this:
> > > 1. If no LSM registers the hook, cap_inode_{set,remove}xattr() is
> > >    called.
> > > 2. If an LSM hook call returns 0, the loop continues to call further
> > >    LSMs (and only stops on an error return value).
> > > 3. The "default" return value is 0, so e.g. the default BPF LSM hook
> > >    just returns 0.
> > >
> > > This works if BPF LSM is enabled along with SELinux or SMACK (or not
> > > enabled at all), but if it's the only LSM implementing the hook, then
> > > the cap_inode_{set,remove}xattr() is erroneously skipped.
> > >
> > > Fix this by using 1 as the default return value and make the loop
> > > recognize it as a no-op return value (i.e. if an LSM returns this val=
ue
> > > it is treated as if it wasn't called at all). The final logic is simi=
lar
> > > to that of security_fs_context_parse_param().
> > >
> > > Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  4 ++--
> > >  security/security.c           | 45 +++++++++++++++++++++++++--------=
--
> > >  2 files changed, 35 insertions(+), 14 deletions(-)
> >
> > Thanks for working on this Ondrej, I've got a couple of thoughts on
> > the approach taken here, but we definitely need to fix this.
> >
> > My first thought is that we really should move the
> > cap_inode_setxattr() and cap_inode_removexattr() calls in security.c
> > over to using the LSM hook infrastructure just as we do with other
> > capability hooks in commoncap.c:
> >
> >   LSM_HOOK_INIT(inode_setxattr, cap_inode_setxattr);
> >   LSM_HOOK_INIT(inode_removexattr, cap_inode_removexattr);
> >
> > ... of course we will need to adjust cap_inode_setxattr to take (and
> > ignore the idmap) parameter, but that is easy enough.  It looks like
> > cap_inode_removexattr() can be used as-is.  Modifications to the only
> > two LSMs, SELinux and Smack, which explicitly call out to these
> > capability hooks looks rather straightforward as well.  Doing this
> > should simplify the LSM hooks significantly, and lower the chance of a
> > future LSM mistakenly not doing the required capability calls.  There
> > should also be a slight performance bump for the few (one? two?)
> > people running both SELinux and Smack in a production environment.
> >
> > My second thought is that we *really* need to add to the function
> > header block comment/description for both these hooks.  Of course the
> > details here will change depending on the bits above about the
> > capability hooks, but if we need any special handling like you're
> > proposing here we really should document it in the hook's header
> > block.
>
> A completely untested, other than compiling security/, patch is below
> demonstrating what I was thinking ...

... I built a kernel and did a quick test that failed spectacularly :)

Without looking too closely, I'm guessing I forgot to take into
account that SELinux and Smack don't normally apply the capability
checks if it is one of their xattrs, and installing the capability
checks as hooks means they are always checked regardless of the other
LSMs.

Bummer.

I'll come back to this tomorrow with some fresh eyes.

--=20
paul-moore.com
