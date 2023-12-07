Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8F840CE
	for <selinux@vger.kernel.org>; Thu,  7 Dec 2023 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="w1TmOPVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079EEC433C8;
	Thu,  7 Dec 2023 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701987374;
	bh=x7Msa5KxC6fbX8OfKRbGiVYjEzRJe99UMLXIj//PDWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=w1TmOPVtLT1TocjllBEAoMPYQ74MWKK1qNLt8wUzsWr+chGw+wlzMZjEOIUHXoEc2
	 j0XkFEYhmvPO1hu1MP9vWZxn7dGwnTMMNODANMWDlzio5nbvTdYCrleum567mJqxGT
	 V1mpKJtWGHDB3ZEDkfeCpAzjhxepJHkc1/T1LaPM=
Date: Thu, 7 Dec 2023 14:16:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
 <selinux@vger.kernel.org>, <linux-mm@kvack.org>, <david@redhat.com>,
 <peterz@infradead.org>, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH] mm: fix VMA heap bounds checking
Message-Id: <20231207141613.1d7d59d8c151729e25be53fa@linux-foundation.org>
In-Reply-To: <20231207152525.2607420-1-wangkefeng.wang@huawei.com>
References: <20231207152525.2607420-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 23:25:25 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> After selinux converting to VMA heap check helper, the gcl triggers
> an execheap SELinux denial, which caused by different check logical.
> 
> The old from selinux only check VMA range within VMA heap range, and
> the new will check the intersects between the two ranges, but the corner
> cases(vm_end=start_brk, brk=vm_start) doesn't be handled correctly.
> 
> Since commit 11250fd12eb8 ("mm: factor out VMA stack and heap checks")
> only a function extraction, it seems that the issue introduced from
> commit 0db0c01b53a1 ("procfs: fix /proc/<pid>/maps heap check"), let's
> fix above corner cases, meanwhile, corrent the wrong indentation of the
> stack and heap check helpers.
> 
> Reported-and-tested-by: Ondrej Mosnacek <omosnace@redhat.com>
> Closes: https://lore.kernel.org/selinux/CAFqZXNv0SVT0fkOK6neP9AXbj3nxJ61JAY4+zJzvxqJaeuhbFw@mail.gmail.com/
> Fixes: 0db0c01b53a1 ("procfs: fix /proc/<pid>/maps heap check")

I suggest this should be Fixes: 11250fd12eb8 ("mm: factor out VMA stack and
heap checks").  Sure, 0db0c01b53a1 may have been wrong, but is there
any point in suggesting to people that they backport this fix over 12 years
worth of kernels?  Or is it the case that only kernels which contain
11250fd12eb8 need this change?

