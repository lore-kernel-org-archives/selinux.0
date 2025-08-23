Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19ED23E346
	for <selinux@vger.kernel.org>; Sat, 23 Aug 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959878; cv=none; b=B+knc6nj2h6q159dEvSIbJaZs2QsY9kuKI8PXsuHZHw9Hb4WdpzeO6bLECnBVLOXboze4LPqbMMUobdt4MFvot48zObwqix+RHl9GqdzzTHhe63tUlQ8eOp01/iPFoz8bGvDJNtIMVYmhaFENgizabp5MUCBOBijYxnkzc0IB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959878; c=relaxed/simple;
	bh=IZkXIb2hwuwbL0K9pRSlpUepinAZXtvlKRuQOxIzQk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QbD94NzZaMw/HP4D3WeE+8ndC3bl9YnFQ4uBYB4QdQC45rJpGDMhBN/8pKewjQNIGuVQdzuJSpHUdKyCrJQdFjKn1mC+EPOw85FV77+81IR07ThRXbY1rbgWTEtRgrMbr/wMBRIgxIBvGaZwsUPg+IxUCONiF+4TscDKFqYSPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=EgwdXe74; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="EgwdXe74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1755959864;
	bh=IZkXIb2hwuwbL0K9pRSlpUepinAZXtvlKRuQOxIzQk4=;
	h=From:To:Cc:Subject:Date:From;
	b=EgwdXe74XRXOzKy1QZvJmYUIDGve4rADFN4+AohjfeYDD0k/+n9JTOpWL9efVa6Wf
	 UPJ9cSM3R9i3oz0Je0W8fPau1j+QRyHAtorqo+V8Q4SjG8fXaJPMISdtiMm0nrwau5
	 uWkxRxWifqdcWQO6rcUI/YllUzQdcbS0MhKViNjQ=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id ADBEC1BDD18;
	Sat, 23 Aug 2025 16:37:44 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com
Subject: fpp cil-policy
Date: Sat, 23 Aug 2025 16:37:44 +0200
Message-ID: <87sehiyuh3.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi

Someone on IRC asked whether there is a project that can convert
refpolicy to valid CIL and leverages CIL features such as macros,
blockabstracts, class maps and permissions etc.

It reminded me of FPP. I could not find the code anywhere. Is it still
available and if so, where? Also wondering what happened to that
project. Were there any blockers?

Thanks

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
