Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439CC4A6CDF;
	Tue, 15 Sep 2026 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495271; cv=none; b=i0KA0rULC7F5shvm9I0NjaBicSpNvO1EQFT+hhST6uhL5e/lWhpIMwHG/6bFaZR3O6LymMTxPI0W+cxKhI94bdPypdNF0x9MTWhwjgOi3uUeUUkO9g2GEO5gdcSaTUiCzZy2I/sjn6Kp1Bv/chifkiBgm7FKOVwS7plUwV+I7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495271; c=relaxed/simple;
	bh=iIZLoDqXxMktAMEBaIDCQ5iIRG2C1WV6/eMK4NZLDg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V11z88kWRpGW22UeWd7vbOhgRuCyK9nYea2XGva94WIKkX1s2SDTR44LkzRFyLLB9o5iQqURZLem7dBChj5jOly+LnjsnDiZM1fy8dc1Wsd4SEPmNFSNzf1HZhcitgNVaVHorc1FZhax5S/xSqY/Lr0tGU2DTMfGY5hQ3WsW9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=dscaF1NX; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="dscaF1NX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1789494834; bh=iIZLoDqXxMktAMEBaIDCQ5iIRG2C1WV6/eMK4NZLDg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dscaF1NX2NbXq+YtHK3AUKzHpTOJgr3cDN1KoC28VPzOGgJnIOEkdSWsE/FZj9Tip
	 TC6/m4mLqKLIzClBUmNnCvhwU9U3DbOUHJCXmPVjHCazP80EFfz3WnOlHZYpR0EwLn
	 Xsd63CX8GVUcnxt31CLdzzQ3tbY3lL4HzSRSQLgXG0uxaPX5VrTHZgLeVFp63+gNFV
	 nSJGT/TbBZr+nHBcCjmGy6DQDDAHtN6hpDlHfozn9VzePQP6hPzqbvclSK1pqTFiBg
	 By2ADcD6C5yaFnZhO7u7lGM99HoZ2RO3vgIAGG7+CU30ZDPGOOkGOCNWcK632EynYY
	 5paIVEPOdY0fg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B602B5FC; Tue, 15 Sep 2026 12:53:54 -0500 (CDT)
Date: Tue, 15 Sep 2026 12:53:54 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jann Horn <jannh@google.com>
Cc: "Serge Hallyn (AMD)" <sergeh@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Jeff Xu <jeffxu@google.com>,
	=?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <aqmGMv8CtkCVmyNu@hallyn.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com>
 <aql6gyQJoxEjx0xY@shallyn-amd>
 <CAG48ez3THXFA=jF_R-wRNsEA=BfD8X1=pHm7dtVnbOto+rXW3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3THXFA=jF_R-wRNsEA=BfD8X1=pHm7dtVnbOto+rXW3w@mail.gmail.com>

On Tue, Sep 15, 2026 at 07:44:23PM +0200, Jann Horn wrote:
> On Tue, Sep 15, 2026 at 7:04 PM Serge Hallyn (AMD) <sergeh@kernel.org> wrote:
> > On Mon, Sep 07, 2026 at 11:00:17PM +0200, Jann Horn wrote:
> > > +/**
> > > + * security_mem_foll_force() - Check if FOLL_FORCE is allowed
> > > + * @subject: credentials using which /proc/$pid/mem was opened
> > > + * @opened_by_owner: whether checks on open() were bypassed because the opener
> > > + *                   has the same MM as the target
> > > + *
> > > + * Check if FOLL_FORCE is allowed for accessing process memory through
> > > + * /proc/$pid/mem. opened_by_owner signals whether the opener's MM was the same
> > > + * as the target MM, meaning the security_ptrace_access_check() hook was
> > > + * bypassed on open().
> > > + * (Current current->mm does not matter for this; for example, if write() is
> > > + * called on an FD that was received from another process which obtained it with
> > > + * open("/proc/self/mem"), @opened_by_owner is still true.)
> > > + *
> > > + * Note that this hook is only designed to be useful in the opened_by_owner
> > > + * case, where the subject credentials effectively also describe the object.
> >
> > Given this, would it make more sense to call the hook something
> > like `security_mem_foll_force_self()` and only call it in the
> > opened_by_owner==true case?
> >
> > I only suggest it because it seems to lower the cognitive load
> > when looking at this code, so it might make it easier to maintain.
> 
> I agree with you, and that is what I did in the previous versions. :P
> 
> But given that two relevant maintainers disagreed with me, I changed
> it in this version.

Ah, I'm sorry.  Didn't mean to dispute a prior decision.

Sounds good.

IIUC it's already in a tree, but for the record

Reviewed-by: Serge Hallyn <sergeh@kernel.org>

thanks,
-serge
