Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F43101C6;
	Thu, 28 Aug 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392844; cv=none; b=QV26cH5ERGMB+7MRfMD6Z/H1wwlI1JW3eA1hv1qcgzVrkkeCf2FNTmK56ehrz3hWB5Nm5LW7qcCOIeUPt0nxq6Ni5a76Y+QBDI0NCupJnRNzYtnMg0TLLpVyzroXw/Y43hHVRpA2ng4XMbvWcXpLT/nWZaWak9OX2K3eiVaU92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392844; c=relaxed/simple;
	bh=gp62qsA5sCP4pj8FC79K4xeX06tKfClCajJqWLJ9abQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSGCp2ibWqf6Ex81w45RXTAGwdhigaG6kXa/f7xpunSIRF0oQwviHvHu9VQgWOifp0lnQqmQXPIuw0dRDnSn5LGfke6XaKhKjUgs7TLqzxkHypvMoNfKmOMEIJgn4cM6ObO5B63AfDx9Xn70aXMnwwR2pGcANaqIKfzno6o6OaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NGzwkZWd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NGzwkZWd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=63fVgPj0dBu19FzzCkTktPqPtLpDcCZYhJHlKuiK014=; b=NGzwkZWd3jUW+MVaoOX2lFIM5Y
	jmBb/Ikm2qiKcf2l5ll36mpL87G1rh1GhTRXX6mxM9T0NwBFvGFse5LMniR+4P3Izaj51rm3ry1Li
	KqNwMJ5gY6PdfVqquMKO7UYJ5fj4h+G1f7d9myCc1DV3I+RLJjaTvQ2lUJaRRXCHSwTvmDxs5bhjY
	6BgJlM/k1Cf1kL+ytgAfWZLHFrTBGuQdJ8CD2UQjNeAZcsbjH38uSTdOs6JwYs7obwFG0cHOR1xub
	+hWOFWFCMct8D2+Bei4ytIaa6qLfmdPVWmgJWnvOnRC/63IjhI2MtLOpzaqcaE5SAV17KsmOhT6cQ
	ZffuRfqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ure0i-0000000BRXD-3HRg;
	Thu, 28 Aug 2025 14:53:56 +0000
Date: Thu, 28 Aug 2025 15:53:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v2 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
Message-ID: <aLBthEcK1rDPQLrE@casper.infradead.org>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
 <20250826205617.1032945-8-vishal.moola@gmail.com>
 <5ee2b684-94d9-40be-b01c-b0538ced33bc@redhat.com>
 <aK9Ogjn71JoOM3w3@fedora>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK9Ogjn71JoOM3w3@fedora>

On Wed, Aug 27, 2025 at 11:29:22AM -0700, Vishal Moola (Oracle) wrote:
> I imagine theres more of these lingering in the kernel, but theres so
> many callers and I only looked for the ones that were calling
> page_address() inline :(.

There's only 841 callers of free_page() and free_pages()!

It's a bit of a disease we have, to be honest,  Almost all of
them should be using kmalloc() instead.  To pick on one at random,
sel_read_bool() in security/selinux/selinuxfs.c is the implementation
of read() for some file in selinux.  All it's trying to do is output two
numbers, so it allocates an entire page of memory, prints two numbers
to it (while being VERY CAREFUL not to overflow the buffer!) and copies
the buffer to userspace.

It should just use kmalloc.  Oh, and it should avoid leaking the buffer
if security_get_bool_value() returns an error.

