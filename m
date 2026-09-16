Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69A48EBEA;
	Wed, 16 Sep 2026 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549356; cv=none; b=S0IHWFPyX2AtiYnMESpWQjd+zB0p2Ou6fSt+9+kNHelEjiCm+VD4NRIonqTWZRw4/qcpc7iFuqtX22KLAlJ15JSLKT3DUrpKJoqjH2iiWHJacYD7JLE0lrRka4NcN5l7HeOB2BOSABvSJq5+BXADRL9s1t7wJRKAPhfE7IlwItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549356; c=relaxed/simple;
	bh=8vauvep3m4UJB6lx3WfhIXSt5pAt3GydhtesLfAT/Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1EF8WWuV97uh7/+SjR2UBDBw0KQ8jhvGGeqR68xXIZZHD4/NbxPU7V2K6xNn108R7Xbs4QqkuM7Pw9di4AcjAaGue/rYR4B4CtBEyCLZAo/nhQ+fFXP90eh9JkBXVcN5p0uDdp25k4TDdpc/ocTm9pQXJlcdi8in8ETqKUJjPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu0pWfdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu0pWfdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DE81F000FF;
	Wed, 16 Sep 2026 09:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549318;
	bh=ztMMMMv7bxzK6KlzZ8FgpSfa4Wm0mxmludXZFP2zroQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wu0pWfdD20WkmcJlHU0fRgfxFv5iUvN0ccfoP7F0VMVMYwoHsEoDYfn+nZMvEzV1m
	 KgsAJCb4zn+2o0fvKGnbBgVbre5Es7my0jYMg1cdlyvgH0yxuNUuZnAuZrzuEwSaZF
	 1yXsXOcY+4mY1yMSu//HjBM/KuFq2cuIsI8Ci83ETN+356JpDar6y/fUY4GlCRgC0N
	 +o1s2o/YNhIVKXnP5KjUeBL1NTnQNOaFH1DEQN2ZwHIrNc+TnmM6Ln6fgymfBBoCWZ
	 IGr8qm2BKp7AH7SO5nZrhRqHVCpNWTmOdiwF6Ins4wLxpoEYYHgWxPfMkHNfAg+wWW
	 nENUQt62KGCVA==
Date: Wed, 16 Sep 2026 11:01:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] proc,security,selinux: let SELinux block
 FOLL_FORCE for /proc/self/mem
Message-ID: <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
 <CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com>

On Mon, Sep 14, 2026 at 01:05:39PM -0400, Paul Moore wrote:
> On Thu, Sep 10, 2026 at 3:48 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Mon, 07 Sep 2026 23:00:15 +0200, Jann Horn wrote:
> > > proc,security,selinux: let SELinux block FOLL_FORCE for /proc/self/mem
> > >
> > > The goal of this series is to let SELinux prevent the use of FOLL_FORCE
> > > when a process writes into /proc/self/mem and the system is configured
> > > with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, and
> > > is still used by current Android devices).
> > >
> > > [...]
> >
> > Let's move this on a shared branch that both the vfs tree and the lsm
> > tree pull. That's the standard way of handling dependencies between two
> > subsystems that want to route code that touches both of them. Branch is
> > stable.
> 
> For some reason (/me looks at gmail) your email never hit my inbox, I
> only noticed it now while reviewing Jann's patchset.

Oh weird?

> Christian, can you explain why you merged LSM code that I haven't
> ACK'd?  We've talked about this in the past and I think I've been
> fairly clear about it; I wouldn't merge VFS code without an
> ACK/Reviewed-by/etc. from you or Al, I've been expecting the same
> consideration from you.
> 
> While I don't have a problem with a topic branch for this, can you
> also explain why this topic branch should live in the VFS tree?  There
> are more changes under security/ than fs/, and unless I've misread
> Jann's cover letter, this entire patchset is focused around enabling
> LSM/SELinux controls and not necessarily anything really new from a
> VFS perspective.

See the reply on the bpf thread. I think this just a misunderstanding. I
was under the impression that with minor tweaks v2 was already acked by
lsm people.

In general, if a subsystems hooks into the vfs layer and filesystems
that are directly maintained by the vfs layer then the vfs tree provides
the shared branch. This is not at all specific to security. It's just
more pronounced for notify or security because hooks are accepted
layering violations that place constraints on how vfs code itself is
organized.

I think this is just a misunderstanding that would've been easy to
clarify without the kerfuffle.
