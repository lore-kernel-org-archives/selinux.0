Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D42E06E4;
	Tue, 25 Aug 2026 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665367; cv=none; b=dHgHroqwG8gvRh8yVPCBfKJjqHQ+Rki+cMUJxXB1UdRGLx0Wmnc1P0ReLBp3Xn3dOVTDvpZIpLvSikgFdvpOOvq3IZgJzL/EU8fUu5mGE+3TgPHfOURD5/84SLDcPUm33NzVEsVcK+FUxqom5dNhRnPHGbhtKWd0Sub9V6j4xLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665367; c=relaxed/simple;
	bh=RAeO6nyzsto4THOPII8Lhn2KD/5f7sb4XDD8FP4is4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5pRYa0DkwsnHNM50l31T6iyRAZaQqWATCe7kvFZh6RFxh7NvZchRUDb+vPehB9JhbYumvH0c07CTcETfIVUOHxVv7cES1+J+rb6NIeKEBYhzlaYLRuSljuNk86V1jn83mY/isRXSSFLBdJR35JBx5Kbj83TQL/r+H+OEZt/UTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhBex4Nf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhBex4Nf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D931F00A3D;
	Tue, 25 Aug 2026 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787665366;
	bh=RAeO6nyzsto4THOPII8Lhn2KD/5f7sb4XDD8FP4is4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GhBex4NfYPWHAIis5wTwo0tQjKG0lEFiWWqT4AQg20VnPw65oPAP/ZjSBF87ydOy2
	 Dj5OuprDFDH9S2asvTA9JHcSPvk0+8xggfaitkr3FK2GGKPGPl5xETSIR0dVpWvAfC
	 cXQWCNYrMYu/fgRgUR5Zwg91ussB2GAA8VT7l1VZgOatlF0HnMgp+XrUnGGSYJYzOO
	 Ckv9lrJOtp389yjaUjC80xmQDUkR/SqEJd1GkGSkqmgmPzC12z0nNoHBt6esAy6l9Z
	 CiXZuotZstCJD+E81JYGtDcC/6JESfGN+93090PCKU9OCWimw/uqBIYF+n9m7Re59L
	 RwiIpFdanGSRQ==
Date: Tue, 25 Aug 2026 14:42:38 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <ao2a33Xf3U0kQmM_@gremlin>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
 <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
 <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin>
 <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
 <aox7tVIQBMuz-xFO@gremlin>
 <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>

On Mon, Aug 24, 2026 at 07:43:02PM +0200, Jann Horn wrote:
> On Mon, Aug 24, 2026 at 7:33 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> > > On Fri, Aug 21, 2026 at 8:52 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > > The sharing a /proc/mem fd seems like that's a pretty dumb thing to do in
> > > > general :) but I guess you have to protect against that.
> > >
> > > Yeah, it's a kinda weird thing to do...
> >
> > Yup :)) but I guess we have to account for people doing weird stuff...
> >
> > In this case (I do mention it in a reply elsewhere I think) it does seem
> > like perhaps you should separately check for current->mm != mm of (what was
> > originally /proc/self/mm)?
>
> I wouldn't want to do it for this access check, since that could lead
> to "confused deputy" problems.

I guess if it got the decision wrong somehow that'd be a problem? Or wrongly
OK'd it on one level but then that led to the fd being passed on assumption it
was OK to do it or something?

>
> > Or at least it seems like a crazy thing to be able to get full access to
> > another process's memory (that it... gave you though).
> >
> > Anyway perhaps overthinking it :)
>
> Hm, yes, though I guess that is kind of orthogonal.
>
> For what it's worth, SELinux can prevent such things happening across
> domain boundaries - it enforces that, in the SELinux ruleset, the
> process calling read()/write() on an FD is granted FILE__READ /
> FILE__WRITE permission to the file's inode.

Ah OK that's good that it's at least possible to check for this class of problem
so the rest is moot then :)


--
Cheers, Lorenzo
