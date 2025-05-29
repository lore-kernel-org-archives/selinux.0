Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD7219E8
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528308; cv=none; b=GaTySuLrNQxzFTQQRKRap7nwl8m0vvc4+zxnKPXYquQ+9pPJIDR17teaN3caZwNOFXWMdBmqN/mqV/u7IrJ5jY/I43CyHoiNNvz36gWaCstwlUE3PtV+QQlZvA89nI+42D7UAkD55/MDtHyDC2Rnn8FmcIZuJ2HmIw4k617n3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528308; c=relaxed/simple;
	bh=g3OALtwYBChQN7NvbGYMvimZftVP1leuMujSpmlPWfU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mOravozoTFL2OTD8rWsBGQoG1/44QO7WQ/NfEGP7/MbpUbw1BRUkLOWYPC8Kh6GWeb2eCtyNBkO2sXMcyQlQ9QpvOCSpS2rsjLjwCmf5O87UAVg3S3t6zJh1FFOmYf79ORSlj24DKed2n6R4GngbwlRiaU706AngkwB2mppScOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=ar6Rw5Ix; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="ar6Rw5Ix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1748528304;
	bh=g3OALtwYBChQN7NvbGYMvimZftVP1leuMujSpmlPWfU=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=ar6Rw5IxCa6pzb0L1vxXur1z27dGVsMiIjYVO1TBJkuQaGkFAvr/BF++GPeCI4PKc
	 8+INqwz785DLrpQMr9E6Cnpcx3js2F9d2+Iy5+3VAFimdGC60mkjVUTZxXJSb0h1mH
	 1PQuFAd4UeaS7LR+uyJbRUjlkfm2RTsxi19SXSw4=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id C464119CDFA
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 16:18:24 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: selinux@vger.kernel.org
Subject: Re: possible regression with filecon equivalency
In-Reply-To: <87ldqftsxd.fsf@defensec.nl> (Dominick Grift's message of "Thu,
	29 May 2025 16:03:58 +0200")
References: <87ldqftsxd.fsf@defensec.nl>
Date: Thu, 29 May 2025 16:18:24 +0200
Message-ID: <87ecw7ts9b.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dominick Grift <dominick.grift@defensec.nl> writes:

example was too simple. Its more complicated:

root@nimbus:~# matchpathcon -m dir /
/       sys.id:sys.role:root.file:s0
root@nimbus:~# matchpathcon -m dir /blaroot
/blaroot        sys.id:sys.role:unknown.file:s0
root@nimbus:~# matchpathcon -m dir /usr/bin
/usr/bin        sys.id:sys.role:exec.file:s0
root@nimbus:~# matchpathcon -m dir /usr/sbin
/usr/sbin       sys.id:sys.role:exec.file:s0
root@nimbus:~# cat >> /etc/selinux/dssp5-debian/contexts/files/file_contexts.subs_dist <<'EOF'
> /blaroot /
> /blaroot/usr/sbin /usr/bin
> EOF
root@nimbus:~# matchpathcon -m dir /
/       sys.id:sys.role:root.file:s0
root@nimbus:~# matchpathcon -m dir /blaroot
/blaroot        sys.id:sys.role:root.file:s0
root@nimbus:~# matchpathcon -m dir /usr/bin
/usr/bin        sys.id:sys.role:exec.file:s0
root@nimbus:~# matchpathcon -m dir /usr/sbin
/usr/sbin       sys.id:sys.role:exec.file:s0
root@nimbus:~# matchpathcon -m dir /blaroot/usr/sbin
/blaroot/usr/sbin       sys.id:sys.role:data.file:s0

> This worked a while ago:
>
> root@nimbus:~# cat >> /etc/selinux/dssp5-debian/contexts/files/file_contexts.subs_dist <<'EOF'
>> /foo /usr/bin
>> /sysroot/foo /usr/bin
>> EOF
>
> root@nimbus:~# matchpathcon -m dir /usr/bin
> /usr/bin        sys.id:sys.role:exec.file:s0
> root@nimbus:~# matchpathcon -m dir /foo
> /foo    sys.id:sys.role:exec.file:s0
> root@nimbus:~# matchpathcon -m dir /sysroot/foo
> /sysroot/foo    sys.id:sys.role:unknown.file:s0
>
> What happened?

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
