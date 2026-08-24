Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738317A2E8;
	Mon, 24 Aug 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592786; cv=none; b=NDHsXab/REXdMnB6kn77rl14Aull7RpkxSrnEqrLoz3UjqpIDhIK4M++Sg2WfzqBRV9bL638T6BNYqWG+NyQQeCBsjrVH/CTRkoc0poKHnwBi712x3F57aLYGXGa2Br/Lx1I4A46R7gG9Gut6k/beJeNpxGbnXnPDR5jSVABwOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592786; c=relaxed/simple;
	bh=GkvqjvsDn1oDFxklV8JSMBNb3ViHt0ekqMbiDBpjn4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgGJBPkuwCRJ6UHijkdx4cFv8n/0t0WPkklp2XDGQ2bp/+fr1BKut4+N0JpWCCSWvYWCWymj2YjvSFR+lZaxtU3FF+CQgj3R0A2rrnj4h0YB3yTbUp89XpzPPdx/4apRVVYAsM/sPcopW0TykyxqdCrz8hIfjDm2ONFpEwNv1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+i5MaxE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+i5MaxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E2A1F000E9;
	Mon, 24 Aug 2026 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787592785;
	bh=vcIvVs7PFyhard8s6CMxssi4jiT5qkPDU3qCnhbC5zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d+i5MaxEtcU+1yCT63EDnh+FmVOdipnlTw5o+j5+bIk0RkWQJZ5MsnAnJ+e01sAXG
	 zkHmxUCnj4mUOhx+PPCqnMIme8zX0W2GkiEcrHGZpJz0D/u6cu/U4Y9tnmQJTHJi3t
	 +K7W+TWEXIfAMePCWIdapL8BF2BoBjsf8SDh1KO5oREt7kNHq2+F5IFWecnfzskri7
	 iwrnmyF2J/WwBN7ESlzJ8GKgcP4/RVbWDUVQMC4sEbHgRfuRzd80rJPKmeVcaGMCx1
	 vTkuAVFd93/g767RqV5KKJYWcLFWCcuqvyplXssHHb7tEDuWuCZMRM7Cm6Me1jpoOH
	 BCjbYn/UG+WYw==
Date: Mon, 24 Aug 2026 18:32:59 +0100
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
Message-ID: <aox7tVIQBMuz-xFO@gremlin>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
 <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
 <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin>
 <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>

On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> On Fri, Aug 21, 2026 at 8:52 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > OK so the whole thing is:
> >
> > mem_open()
> >   -> __mem_open()
> >     -> proc_mem_open()
> >       -> mm_access()
> >         -> may_access_mm()
> >
> > And:
> >
> > static bool may_access_mm(struct mm_struct *mm, struct task_struct *task, unsigned int mode)
> > {
> >         if (mm == current->mm)
> >                 return true;
> >         ...
> > }
> >
> > And what this flag is carrying is 'hey the reason we allowed the _open_ is
> > because it's looking at its own address space'.
>
> Yes.

OK cool. Obviously do agree with David that calling out the ownership aspect in
the name would be helpful!

>
> > I did wonder if what you're protecting against is even a process updating
> > execmem _it_ owns, no fd shared anywhere, as something LSM might want to
> > prevent even so?
>
> Sorry, can you rephrase that? My goal with this series is to let LSMs
> block a process that tries to modify its own non-writable executable
> memory using /proc/self/mem; I'm not sure if that answers your
> question.

Right, I guess my confusion comes from David's clarification about passing an
fd, perhaps I misunderstood that being somehow the _primary_ thing you were
protecting against.

>
> For context: In this series, I'm using "execmem" to refer to the
> SELinux permission PROCESS__EXECMEM, which essentially controls
> whether a process is allowed to create writable+executable mappings
> that can contain anonymous pages. Additionally, it blocks creating
> executable mappings of S_PRIVATE inodes. There are other SELinux
> permissions for things like making a VMA containing anonymous pages
> executable (FILE__EXECMOD and others) or mapping files as executable
> (FILE__EXECUTE). FILE__EXECUTE is granular, it can be granted based on
> the security labels of the process and the file that is mapped.

Ack thanks for the clarification.

>
> > The sharing a /proc/mem fd seems like that's a pretty dumb thing to do in
> > general :) but I guess you have to protect against that.
>
> Yeah, it's a kinda weird thing to do...

Yup :)) but I guess we have to account for people doing weird stuff...

In this case (I do mention it in a reply elsewhere I think) it does seem
like perhaps you should separately check for current->mm != mm of (what was
originally /proc/self/mm)?

Or at least it seems like a crazy thing to be able to get full access to
another process's memory (that it... gave you though).

Anyway perhaps overthinking it :)

--
Cheers, Lorenzo
