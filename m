Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31BC3F660F;
	Tue, 25 Aug 2026 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663646; cv=none; b=KmC3kf14l0fih50vbwfW9I3IRqzIJMBScqMfXI+vXh09B4GoLsCTTJ83E+utLKr9NeSCo4tLcbfckk/xyaf8oca1RyzOVSClsuQGeVpWhRn056u+K4OE6ztWbwGZFzSQZ/CGWadgglgyRxJs5fdoYSZcfui2+ti96zogI6an/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663646; c=relaxed/simple;
	bh=WSbPx2tUZbRu/qOn+OqHlNLqWX/99Z1mgi1ERRvrn2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNeb5Eu30LVkBSkhvJd/QnNuL3IcMptBtm6X2YyDOAaJzUQxXtAeWh0nAEtVo9dVL/WQY2zTPjJ5Eg6naN5+mlf+Z25fr5T4n3f3GvQtYaJJfVAD/iFv0V9Mxky6MiL8wjlT5fKhAx0WAkQ7NNWA+SZfaatm8kYTKg+SEX4aB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLCLW8Lw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLCLW8Lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6656F1F000E9;
	Tue, 25 Aug 2026 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787663638;
	bh=WSbPx2tUZbRu/qOn+OqHlNLqWX/99Z1mgi1ERRvrn2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PLCLW8LwKGQQc6+ECUqIuD3meOvOFAgJkXETzVPo81Dd8bahEAa/XTzkoMN1dsdJg
	 SHMu/2cgkDEWxogqG2CUpDmb+Ut3T+ZdgeLbUVA7R3seXSaBKgbYgO/RndyJyMHdsH
	 mTnsmG0tFUlt/DwxY3LYSy2Ft5aeqzMChHUJyskRZPxGdAGKfLK5Td99EwqNK5OcQC
	 Dcwip5wSMg/SvGwDtvcuEi5sYW0xBTjuBlFu/mNIXW3r+sFFOPkuuwgJY/04hoyqdK
	 g95BoWK774XmOkJEkVEW3VEPs2L+uBxBBFRNYojnR13IDarQfhW372LPXGZ3k6L0EI
	 zRUnXSNBCKxyQ==
Date: Tue, 25 Aug 2026 15:13:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <20260825-passt-semmel-primitiv-37712c04e6c6@brauner>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>

On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
> If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have no
> good opportunity to block a process from overwriting read-only code in its
> own address space through FOLL_FORCE writes via /proc/self/mem.
> The security_ptrace_access_check() LSM hook is bypassed when a process
> opens /proc/self/mem because this is considered "introspection".

Useful. I ran into this issue just yesterday in:

https://github.com/systemd/systemd/pull/43511

Btw, it's kinda annoying that PTRACE_POKE{TEXT,DATA} still allows foll
force writes even if PROC_MEM_FORCE_NEVER is enabled. So ideally there'd
also be a hook for that option.

The other thing - though not directly FOLL_FORCE related - is that
process_vm_writev() isn't subject to any security restrictions other
than seccomp filtering either.
