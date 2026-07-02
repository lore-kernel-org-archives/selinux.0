Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09B38E8B7;
	Thu,  2 Jul 2026 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987441; cv=none; b=TfrOdYj4ApCOWtYewOnXYKhEU7X1XFzT1t+qeNVOs7r2fsJYdsAxskqAzm9qFR/dT8NyTrrD4y/e4epRIUugMcB0yTlQUClsz9tJuBKCzTiZ/pWOtS54C1q0KL/3H9AnCUF5h+3Xg2wU3Eu78bcJDW+5vIlQSvsivBkKmNSl9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987441; c=relaxed/simple;
	bh=WTBYsz4ZaS1DVALdvxaIeZPepf/1W8DTfblmBUdX01s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+iBY9ge+NZ/WUOXTGpzKkjgGcvQxbQSv3mU6iX3Qc/eWNQ0FqGYUJq8VBlsW/NmqoG1lbuRsV7sQsxUlTUqXA8gnOrHSl3Ro4Be4JPfdLIqDDjDQkZp1C6OYBEUlwnsztuUP2lz7A8Gy4o/oUa0JjhlKiFE28IeSLDAXqDH4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MbP96GwI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbP96GwI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vdTUCBlDoAAZa4gMQtBsKpBldRVI4DFTRKl4Ea/6yQ0=; b=MbP96GwIBDogEMIqEKuX5+waA9
	dGaBbG/ArrknfO4zQB8+4aqRM1rcom+XlGLcmwA1zSq0V3ktGQbWR6FK1vjuLocMvu1l2KuLUgnxk
	SAuuLw3Xwq77iCXEhvL3O1H1Jv/KVLzyUO4zsqHOcHJDldHx35l9+IpFGx3IHimDcqho/UPdziI3v
	lCFJco6lUO3jia1Vjmh4Ics5mnEGCwLHKflcj+aiUjJQ6n57pqv83VB/K1VTFFBGYSs2xReF8cOHB
	1n33S0J7wi7g8fzUrkvT37eopTzyy1e6QAMhv0e6aSN4FJlNPB6lz6RhhbD9TAl6DZT2iJKaQus2o
	Icszsldw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wfETi-00000003fJc-15Bk;
	Thu, 02 Jul 2026 10:17:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 563B7300402; Thu, 02 Jul 2026 12:17:04 +0200 (CEST)
Date: Thu, 2 Jul 2026 12:17:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test amd ibs: avoid using executable heap
Message-ID: <20260702101704.GG751831@noisy.programming.kicks-ass.net>
References: <20260701062321.517351-1-omosnace@redhat.com>
 <20260701064301.GH48970@noisy.programming.kicks-ass.net>
 <43dd9d9f-2348-43c0-8af5-77ef260c64a3@amd.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43dd9d9f-2348-43c0-8af5-77ef260c64a3@amd.com>

On Wed, Jul 01, 2026 at 10:29:04PM +0530, Ravi Bangoria wrote:
> Hi Peter, Ondrej,
> 
> >> permission under SELinux (things like JIT or regex compilation need it
> >> as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
> >> begins on a page boundary, so the result is equivalent to the original
> >> code even without a memset() or the page-alignment dance.
> > 
> > I would argue that having RWX is a problem, you really want RW->RO->RX
> > transitions, so even with mmap() you want to combine with mprotect().
> 
> My original intent for using RWX was to generate sufficient Icache miss
> samples for the IBS Fetch unit by overwriting the code prior to execution.
> I am wondering whether it would be possible to achieve the same result
> by using CLFLUSH with RX permissions. Something like below (build tested
> only).

So for a test it is fine to have RWX, my comments were mostly aimed at
the IMO insane SELinux policies.

CLFLUSH+MB, and on AMD MB is serializing. Thus CLFLUSH will flush the
I-cache and MB will flush decode / ucode buffers IIRC. So yeah,
CLFLUSH+MB should work fine; if you want to go that route.

> --- a/tools/perf/arch/x86/tests/amd-ibs-period.c
> +++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
> @@ -25,6 +25,7 @@ static int page_size;
>  #define PERF_MMAP_TOTAL_PAGES   (PERF_MMAP_DATA_PAGES + 1)
>  #define PERF_MMAP_TOTAL_SIZE    (PERF_MMAP_TOTAL_PAGES * page_size)
>  
> +#define mb()			asm volatile("mfence":::"memory")
>  #define rmb()                   asm volatile("lfence":::"memory")
>  
>  enum {
> @@ -41,10 +42,16 @@ struct perf_pmu *fetch_pmu;
>  struct perf_pmu *op_pmu;
>  unsigned int perf_event_max_sample_rate;
>  
> +static inline void clflush(const volatile void *p)
> +{
> +	asm volatile("clflush (%0)" :: "r"(p) : "memory");
> +}
> +
>  /* Dummy workload to generate IBS samples. */
>  static int dummy_workload_1(unsigned long count)
>  {
> -	int (*func)(void);
> +	int (*func1)(void);
> +	int (*func2)(void);
>  	int ret = 0;
>  	char *p;
>  	char insn1[] = {
> @@ -59,33 +66,42 @@ static int dummy_workload_1(unsigned long count)
>  		0xcc, /* int 3 */
>  	};
>  
> -	p = calloc(2, page_size);
> -	if (!p) {
> -		printf("malloc() failed. %m");
> +
> +	p = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

RW

> +	if (p == MAP_FAILED) {
> +		printf("mmap() failed. %m");
>  		return 1;
>  	}
>  
> -	func = (void *)((unsigned long)(p + page_size - 1) & ~(page_size - 1));
> +	memcpy(p, insn1, sizeof(insn1));
> +	memcpy(p + 128, insn2, sizeof(insn2));
>  
> -	ret = mprotect(func, page_size, PROT_READ | PROT_WRITE | PROT_EXEC);
> +	ret = mprotect(p, page_size, PROT_READ | PROT_EXEC);

RX

You really need an RO step in between IIRC, otherwise, depending on arch
details and mprotect implementation details, it is possible to have WX
overlap.

Notably, you want to have a TLB flush between removing W and adding X.

But again, this isn't relevant for simple test cases, but does matter
for JITs, esp. when they're embedded into applications with lots of user
input.

The thing you want to avoid at all cost is things like buffer overflows
(write primitives) to escalate into random code execution, which if
there are RWX buffers around, is almost trivial.
