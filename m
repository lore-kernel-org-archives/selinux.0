Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653A2DB78C;
	Wed,  1 Jul 2026 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888201; cv=none; b=PCYXlQL67wPWVRcwbggQ6OxU3+x7IdiZ5LXCLpdXI2HCf3Lm1OnrXaQtbgK83+dvP5b0fN3gPko1SnBRXcIR6nn+PbUDe8z06Ab3NrLDKn8dgr1/tJ+N385MSGJbn+9QjxZbEfCabJsa29nvlsj76Qhr3eJ2qx1Z04EjlupuFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888201; c=relaxed/simple;
	bh=kjlnVBznBOseM9UP5zY0DXq4bEV3+d814uIFnyhCo5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of9jcJd66HX5B7LIzFLYYXIViSX9qIYyHiYoIJyVoSyX4zC5xwVVegp8sTIbI1OF4mBkmy9yJUsXjF+FUevmhn1whZnYA+n/71npJNj6cSda/W3rfp8AjGFVjsq2ngSQ+rRYdJ3ZnevdzDXHl+rLqr9CEqHGwdMqalW3nH6Ug5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aA4rPkef; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aA4rPkef"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ioriP2gEeyVn3ipjFWADEj/Zp7oTvxHczwXt6ZKvbjc=; b=aA4rPkefVXIzaiRC/qGQDVQNg0
	N77yQvxg5yukOhDaCrk6vdSXw5YNywYGmhH/VYwrsYevV3BrwrC77h+7d7imIy8rsc3oo+QpYOJH3
	BY8a/cCDeqsO3LiQebkJ+GDGkscf4StZPaGFWmdaDrRSUvcENqGVctmPb5l0va+ULb3RswdTpRPf1
	gMTI6l42nlgg8CUPwqatAybGkPJlb5eFTlvTt3cPQnP/g/ZupRxrd12Y+EftdJTOPXvxh2cKw08Ag
	u5Wygo83HKv8t1RX4/gYXe9YShzV3CQe4ECrGO4Kz627C+hZeNsKTfKZRels+KNAD9CXTajpaYcrX
	J9WBAb3g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1weof1-00000002RTP-0igx;
	Wed, 01 Jul 2026 06:43:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 87CBB300402; Wed, 01 Jul 2026 08:43:01 +0200 (CEST)
Date: Wed, 1 Jul 2026 08:43:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test amd ibs: avoid using executable heap
Message-ID: <20260701064301.GH48970@noisy.programming.kicks-ass.net>
References: <20260701062321.517351-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701062321.517351-1-omosnace@redhat.com>

On Wed, Jul 01, 2026 at 08:23:21AM +0200, Ondrej Mosnacek wrote:
> Making [parts of] the heap executable is dangerous and is blocked by
> SELinux on Fedora/RHEL even for an unconfined user. Replace the malloc()
> + mprotect() combo with just mmap(), creating a private anonymous rwx
> mapping, which only requires the more commonly allowed "execmem"

I do not understand. Ultimately malloc() will have to use mmap() to get
the memory too. So how is malloc() + mprotect() considered more
dangerous?

> permission under SELinux (things like JIT or regex compilation need it
> as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
> begins on a page boundary, so the result is equivalent to the original
> code even without a memset() or the page-alignment dance.

I would argue that having RWX is a problem, you really want RW->RO->RX
transitions, so even with mmap() you want to combine with mprotect().

Obviously this doesn't matter for this test case, but any halfway sane
JIT should really avoid keeping RWX mappings around.

> Verified that the test still passes on a machine with an AMD CPU that
> has the "ibs" CPU flag.
> 
> Fixes: 35db59fa8ea2 ("perf test amd ibs: Add sample period unit test")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

The patch is obviously good, simpler is more better and all that. But
the justification really smells.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

If and when we get AMD to support IBT, this thing will need more
changes, but alas.

> ---
> 
> v2: fix mmap() failure check (found by sashiko-bot)
> 
>  tools/perf/arch/x86/tests/amd-ibs-period.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
> index 6a92b3a23ed7a..32713f8fcd5c8 100644
> --- a/tools/perf/arch/x86/tests/amd-ibs-period.c
> +++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
> @@ -46,7 +46,6 @@ static int dummy_workload_1(unsigned long count)
>  {
>  	int (*func)(void);
>  	int ret = 0;
> -	char *p;
>  	char insn1[] = {
>  		0xb8, 0x01, 0x00, 0x00, 0x00, /* mov 1,%eax */
>  		0xc3, /* ret */
> @@ -59,18 +58,11 @@ static int dummy_workload_1(unsigned long count)
>  		0xcc, /* int 3 */
>  	};
>  
> -	p = calloc(2, page_size);
> -	if (!p) {
> -		printf("malloc() failed. %m");
> -		return 1;
> -	}
> -
> -	func = (void *)((unsigned long)(p + page_size - 1) & ~(page_size - 1));
> -
> -	ret = mprotect(func, page_size, PROT_READ | PROT_WRITE | PROT_EXEC);
> -	if (ret) {
> -		printf("mprotect() failed. %m");
> -		goto out;
> +	func = mmap(NULL, page_size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (func == MAP_FAILED) {
> +		pr_debug("mmap() failed. %m\n");
> +		return -1;
>  	}
>  
>  	if (count < 100000)
> @@ -93,7 +85,7 @@ static int dummy_workload_1(unsigned long count)
>  	}
>  
>  out:
> -	free(p);
> +	munmap(func, page_size);
>  	return ret;
>  }
>  
> -- 
> 2.54.0
> 
