Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59C431486;
	Mon,  6 Jul 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357101; cv=none; b=F3Ij00ZYHcbA9KYn+OVkcwSGqZY9gyTz5/vke9az7MMQHILTh2mM40GSqMpPSDYVV11AcRGCVKsyZsrOCPVloO7wS/ua6v1MY8UFFor+H/pqjMay/8Rfb3rH4UfXZQwLQgE7yx/MEfBzG/tUVQfdMNPgDwh1dNMSMdDOGwhI078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357101; c=relaxed/simple;
	bh=77wbFhcr7p9apS9IJTmHg5q5lVGn3w221pBzdjTGNsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bs2sMUsKSYzFd7XfDVfLrcmiBgJ3tRVphU0qZEvxzgp+9Iw2KT7vel5QhP7NUqevRsKMPQi+M1828s2xDwl6Vg2hzfvCNFXFCJOdbfVR10xeJhzyKJ7d8QL5oVBbJq/bnGwIEouUPaU6KS/rVaclqdCYWbVCZl2HAhkT3ciUIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6xEjxVq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6xEjxVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B70E1F000E9;
	Mon,  6 Jul 2026 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357099;
	bh=HSAjB2ZTDG1hYk+rvmYS+nVFiMQ8amcquXd99MpIuvo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=R6xEjxVqr+E0/OYYl5E9J1TRJ/LBwfOl7LjdOFrMXUufrFHvsV0Mc6yQZjzD8eYqG
	 pmBJqdxcaOM8oUPTqTKitcHgXIjY29Btv549NA7mmBu4Zu1bwChoU+AfcElWqnRW7X
	 l/S2eFJYypv/uy3MBCboSDmLsVk/ATlIrm9EvY4GE83wN8Q4Vkofgho779cOpnUGz5
	 Y+1ZIYQx6JvMoOZgxlCie0Npz7ekAkUFRqsqs6VG059H/rPsz+b2eNUFEYwqKuPg8s
	 Gf5AAtZzxGscAg43LNSFI4HeWf8AyXF15669rxhq2zFuVz/Onb3uaZqe2lfXIe9Z2B
	 5uEsFNiun2oXw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
 linux-perf-users@vger.kernel.org, selinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260701062321.517351-1-omosnace@redhat.com>
References: <20260701062321.517351-1-omosnace@redhat.com>
Subject: Re: [PATCH v2] perf test amd ibs: avoid using executable heap
Message-Id: <178335709933.2202965.9164645344141346476.b4-ty@kernel.org>
Date: Mon, 06 Jul 2026 09:58:19 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 01 Jul 2026 08:23:21 +0200, Ondrej Mosnacek wrote:
> Making [parts of] the heap executable is dangerous and is blocked by
> SELinux on Fedora/RHEL even for an unconfined user. Replace the malloc()
> + mprotect() combo with just mmap(), creating a private anonymous rwx
> mapping, which only requires the more commonly allowed "execmem"
> permission under SELinux (things like JIT or regex compilation need it
> as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
> begins on a page boundary, so the result is equivalent to the original
> code even without a memset() or the page-alignment dance.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


