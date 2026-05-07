Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C5175A74
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175152; cv=none; b=FJ3t5qoHE27Vh9UE0qIHl0GzKzjt3FYd/uZ/a4k4CsAfl6jPuLt7ZRjsy3kbcI1rE3M39enAdf6y6f0KgTgykuECh+yIWCz/ZUA289yarwozUVXeIG0k6DmXvT6MNJVwbBkYwpRghnbS+tDjrsilIfJT2SxpDs/05ygt3Pkjc/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175152; c=relaxed/simple;
	bh=GskZk7FS8FtRN1/SaRRvT8KxcdCL8rUc0yPMur5XFTc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lniozZSO1dDqfPGmxvzrHMvsuOmfsmyzZmqvecfut39SpvxBcA8p3mPs1ROJefV+02wKWxQNFUNuh2bVWgaL1A6j54B6Zi7XnpmHovfyWUCzcU1pXl7KNSEOGYIHRVJo00uaYPMeMbVHDNqQyyEgrbQpxlYkRpyTwMKSzaCz0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=aTsmlvWQ; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="aTsmlvWQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u8E0M58FVMfsZgNnSVlNk5zn7CZG9dGyJySCM6dA3j0=; b=aTsmlvWQQdISogcv9SWj7DDb2n
	CkBmTTZeNQdo4X22+OcGNmD3nEWDm3EL2mt11Y+ehdOE7nvzQdyt+GJihM6nT7ghnI7UlJpBwyDn8
	Sc3D62IcK5idiOHVjRs8JtbJj3HLoMNilMExFrr7RtiCP05OIcXWbR5MTAMrjSFnwpbEPGO0CY5Im
	cW6GRhTpNMreHUAAQjTdAiJHE6VAMJD4E9fv3JikyuHbXy+G98+vRRAA1ymr53viA2ddicncELzEB
	MNLFrZbTJqLuczib+zsuHRH5WwSzbSIs3fCMIt5qA6f8JjHGYhq9kFolcFDfIe5cr520y+Pq7Dfg4
	C3bJA1og==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11685 helo=2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wL2aJ-00000008FCj-1geV
	for selinux@vger.kernel.org;
	Thu, 07 May 2026 20:32:27 +0300
Date: Thu, 7 May 2026 20:32:25 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux-list <selinux@vger.kernel.org>
Subject: SELinux userspace coding style
Message-ID: <afzMqTAtz3aHEx9f@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello!

According to CONTRIBUTING.md, the following applies to
the SELinux userspace code:

"C code should be formatted using clang-format, using the
.clang-format configuration file at the root of this repository."

I guess this only applies to the new code, right?

Inspecting the userspace code shows it is really a terrible
mess of conflicting coding styles.  Of course the correctness
of the code is the top priority, but compared to the kernel
side code, the userspace looks almost like a jungle that
developed without any consistent coding style during the
past 20+ years: e.g. sometimes people use braces with short
if-clauses, sometimes not (even within the same function!),
sometimes goto labels are indented, sometimes not,
pointer definitions vary with their use of space or not, etc.
 
To be honest, this is *most annoying*, but realistically
fixing the whole codebase would probably create a chaos
of patches that would be unmanageable. Especially for
the security related code, one would wish the situation
were different, but there is no time machine and so it
is what it is...

I randomly picked just one C file and tried:

  clang-format-17 -style=file < load_policy.c > l2.c
  diff -u load_policy.c l2.c

It sure produced lots of changes.

br,
KK
