Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80924187332;
	Wed, 13 Aug 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091063; cv=none; b=VMRD3cJaEyu0pzYw1VZe8ZSwP8rLWEIg7gWFUA7RGICeHbOHn1/72G2sxbvHoPdVgm8VZDP8WawmlDVGjR+Q6SDXgLRFJ4envfbbero5FSnqaAyVg8+oZfdhAGxAe3+Rjnhb5egoyu3E9z3pThzM+UI4kubak8B71eYTa3ZMEKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091063; c=relaxed/simple;
	bh=zzEj9cfqbd2spSJTYTHqtFNTblZavGAp656fzwWKmWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfDHFRQ7pxblGO9A+Ga4EocM2zLyI+02n6FascAuB9S4TOWCWuMA+vrZMd0JGYDVk7UB2xAOnTMJgFmvbFH5AKUGkTyL/eJaLH3KCcwekmpf0ba0hZyC2dn/zuQ0ElKABUo5I6QkYHRIGXXDH/OFQCweTFhA7q/SQ6dwlRGvamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tJand2IK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tJand2IK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NqnMKRewUhK+QutzEosxqVjfhtOVe9aM8YUWyA7VAJ0=; b=tJand2IKWK2LpeSVoQ5rvnu/mz
	6O1eb4G6fU5r2QX9dJECNoLgKV4IJI3RjgcZ4dNRpzidLPgYneXBu3VLDpCgmb8/Yh/6ECJ4gMQ8S
	/s3oe2KSouY+N0Htk+szxFHiBPB9Bh8LXZaISrn+1ry7FJJTvoy4MX/ugQjBcOJPaI/+68Cc1PZ9A
	hXwVANoFMsKyIxe7JBrtxjTyCQu7MKG5wu6D8NvDeYqeIYp6CTjhwfus8QvGaVAj6x/PTOuiotv+Z
	DbENhdZm+Q6P1SJbIrRZ88WML5IT9upAF8EsHdC0Ykqy+/nbiF+0mhsoh/fhA5UyBQD0mlCTtT9Zj
	rbYGSAmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umBMG-000000090UJ-1PxJ;
	Wed, 13 Aug 2025 13:17:36 +0000
Date: Wed, 13 Aug 2025 14:17:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Sterba <dsterba@suse.com>
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Remove remainders of reiserfs
Message-ID: <aJyQcAyOrp45D84g@casper.infradead.org>
References: <20250813100053.1291961-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813100053.1291961-1-dsterba@suse.com>

On Wed, Aug 13, 2025 at 12:00:52PM +0200, David Sterba wrote:
> +++ b/Documentation/admin-guide/laptops/laptop-mode.rst
> @@ -61,7 +61,7 @@ Caveats
>    Check your drive's rating, and don't wear down your drive's lifetime if you
>    don't need to.
>  
> -* If you mount some of your ext3/reiserfs filesystems with the -n option, then
> +* If you mount some of your ext3 filesystems with the -n option, then

Should this be updated to ext4?  ;-)

> @@ -587,7 +587,7 @@ Control script::
>  					FST=$(deduce_fstype $MP)
>  				fi
>  				case "$FST" in
> -					"ext3"|"reiserfs")
> +					"ext3")

... uh.  Maybe much more significant work is needed ;-)

> +++ b/Documentation/arch/powerpc/eeh-pci-error-recovery.rst
> @@ -315,7 +315,6 @@ network daemons and file systems that didn't need to be disturbed.
>     ideally, the reset should happen at or below the block layer,
>     so that the file systems are not disturbed.
>  
> -   Reiserfs does not tolerate errors returned from the block device.
>     Ext3fs seems to be tolerant, retrying reads/writes until it does
>     succeed. Both have been only lightly tested in this scenario.

"Both" is now orphaned with the removal of ReiserFS.  And the ext3
sentence has an implicit reference to "errors returned from the block
device" that is now missing.  A wider change is needed here.

