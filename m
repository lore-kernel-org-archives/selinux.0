Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B5BA38
	for <selinux@vger.kernel.org>; Fri,  6 Jun 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749238781; cv=none; b=J7rp9Q+9DUa4eQ4zclosb0WYypnnd1Q3g8bGkeFLXx4GA70Jxjli1VpfSmBfzOgM5nUOhXBOxAfECroIMal2oNMBfshfIPwEfDq7lbhrZXmKJSHWU1ZbRQibFcNoQzkosXJzet+WkPO1MisksJWNMeXyJ40/Zt2Pku+Ma/GomJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749238781; c=relaxed/simple;
	bh=4/YJDXcBdX9ts5mV/Fd+eaUgcbAJYOHZF2uYXnML8wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qpbaaIa/2JmmCu3ibzPLCE20+5Qehjuz2VLQaDaFktt7MLd5r8HCO6M5dnL4fakPYpO7mN576f0aRp7fIyAc7XKIN+GljxPJhu228iTLUmpYWtYQoLf9C0OMThFil6BzjMl0XbxhcnDuAGH6Ribdr37PaS2HprWFjDWx7o7M0Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx0et/ub; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx0et/ub"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso1845060a12.2
        for <selinux@vger.kernel.org>; Fri, 06 Jun 2025 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749238779; x=1749843579; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/YJDXcBdX9ts5mV/Fd+eaUgcbAJYOHZF2uYXnML8wA=;
        b=Tx0et/ublGGIj/Y+2k7BHpPTUpuKj4iCo8OopddJNkVqN1O0HWEGCUCbMSsGjOM8SR
         Ciz+0nHU7pzuNRZq+NWlMR/LrS1PgsFIT5SosFdVjfls/HvBNIMazp/ju/VyBrZc8Spx
         ijNLO9qJzJ1nm3vZ78VC3WlNroQQwkVWYDVUwkx/6NSi8XZG8D7EaupjVelsxdL8+Bxm
         F2g4yZBXcif7ujvz+oTwhzdIX3LR+C8At1VekR2CbyoZeaf/g5ptiKDys3o2vu+HNGeX
         KzMPd/dSrohYDWQUU0uPLNl8wyaByRL/8ITzMwMYwLIQfNbbmy5OURa4+Of12GwkDucr
         1e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749238779; x=1749843579;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/YJDXcBdX9ts5mV/Fd+eaUgcbAJYOHZF2uYXnML8wA=;
        b=gXNTB66y3ie5jaseQUlU9xAvWsozoKSy9nIVYWa5icZVsXbTfIY5IA9vCu2wBWxXmj
         +WTk49OBvN9XorbpkmHLTsCDUbYakwUA0SCOMIcSe6vxKBK4v44xEQnDnVqKYXvHaf6j
         I8kEdnGN3LIXHIYbsnCUXHqNoJisjwrwEBbGLhEVh5b8FD3pWT9XQaKth783pP6bzfom
         miT3F9xkn/c7us+ZriX3WRZPbeQRYwIlBYO9bN7wA0/ylRBb+rLZkt0AOxFK35dBQYwv
         br1pHIDhwhUzjSdlGmj5ioqo+jOAzSluUEgjgFPskWhyG9q/2RzCRJnQqvR4ODcCscOO
         ibdg==
X-Gm-Message-State: AOJu0YxdnclS6k9m6uSkpObP7VOULhiFgXMBymY8YcQl6MoNdx+CAaO5
	bgbvkDPVg4mVddwvPjkGYkM6HHhZvGqnlrhgB/dHbVLgOrpDhdkLRtP48S5tR/YYP8kQiCnyYod
	E6MUQDQPztZG2VJUjwKAldQBDCUsIqRoJVeKM
X-Gm-Gg: ASbGncsK5lgTILh6CDxGVAu+/zAlvYBgLtomuK4Gcg58C8XkT00F7XtBjkB0oAccg/w
	OMwf6zI7mf2Zk53Bvq+T/yKQueTSDuBHkjYXE+H//SlDrcoevUpSW2+U3UxiDBTs66+S+913UPk
	mNcE5BXpJ38jttl5h3PdAQPESiho/qL5ju
X-Google-Smtp-Source: AGHT+IEwvZ/rvy6USKDotmROeH2J/+1+pN3T6noyQYMTmLJxqQrphEffAuZ6MV708nbvrsmz56IGXDiOas2DQ1ryZGY=
X-Received: by 2002:a17:90b:390e:b0:312:ec:412f with SMTP id
 98e67ed59e1d1-31346b3fc52mr8027020a91.14.1749238773881; Fri, 06 Jun 2025
 12:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6P6oH4nUMwhFs=ctDekm3CHVtGgp+gx0QCjxZz5d4TCA@mail.gmail.com>
 <CAEjxPJ7RbPCdJsO=CeRSisa+1=eLNOSkVWByGb2sdF1VUCLCCw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7RbPCdJsO=CeRSisa+1=eLNOSkVWByGb2sdF1VUCLCCw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Jun 2025 15:39:21 -0400
X-Gm-Features: AX0GCFtzlenOBGUVtW-hbya3cLNP_DKnBtdF6hN6vAg59ve_UpXzGm6M8m2yJAw
Message-ID: <CAEjxPJ5PHAU-_ru9=zN_iuvLGEGDxL_T50-fW4XecnZ6p2ww8A@mail.gmail.com>
Subject: Re: selinux userspace wiki
To: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 3:05=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 5, 2025 at 3:03=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Since I created a Getting Started guide under the selinux-kernel wiki
> > [1], I also did some refreshing of the selinux userspace wiki [2],
> > moved the Presentations and Papers sections from the kernel wiki to
> > the latter, and cross-linked them for easy discovery. However, I had a
> > few questions about the selinux userspace wiki:
> >
> > 1. The Home page and the Userspace Packages page are at least partly
> > redundant in their content, and the actual list of userspace packages
> > modified for SELinux was very out of date (I added a note to that
> > effect and how to query for a more current/accurate set). Should we
> > drop one or the other or somehow combine them?
> >
> > 2. The Tools page is likewise quite out of date. Do we want to refresh
> > it (and if so, does anyone want to do so), or drop it?
>
> Sorry, forgot to include the links:
>
> [1] https://github.com/selinuxproject/selinux-kernel/wiki
> [2] https://github.com/SELinuxProject/selinux/wiki

I refreshed the Tools page, deleted the custom sidebar that was
(presumably unintentionally) hiding several child pages, and moved the
Other Resources section to its own sub-page,
https://github.com/SELinuxProject/selinux/wiki/Other-Resources
and made further additions to the Presentations and Papers sub-page,
https://github.com/SELinuxProject/selinux/wiki/Presentations-and-Papers

Feel free to suggest others that should be added or if you are a
maintainer, to add them yourself.

Another question about the old content: the Contributing page lists an
IRC channel. Is it still correct and used by maintainers? If not,
should remove or update appropriately.
