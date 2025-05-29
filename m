Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F5C147
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527733; cv=none; b=hS+xt3w/i6z2V01/JktJTpqq9FH4FMzWMmxyJt3uvwCEK9+rKlmiGUt0GniXX3VWPcfU2aOKbtatMPyBORRzVUl2sjvNInpk1cqrr9FQlNz+rSlaqgLqKG8K/HbVi6L8bd9g/EWtnpyzuwltjryDk1eabtL9yrbdgP9w8SFav3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527733; c=relaxed/simple;
	bh=JAOo/9a4DheYeFMg4KGAotQeRDTkj1TQeT/WTSoebNk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XtIxaSZlf6tVwK8vFgs/7+oCjANQk1FMT43wt5z2eK/6R3fWHOrJGk+RGfblJCtR1gLW3WioRLIB7ZVvm2yT5r+BiWgCcxvSVqygYtyeLt33LUDR0ySrVRZUSHpFXmyITbJciztbYUyeQu1LAmXrCaifT4SfCNk2tR4G/8ncNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=hmi1p/U+; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="hmi1p/U+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1748527439;
	bh=JAOo/9a4DheYeFMg4KGAotQeRDTkj1TQeT/WTSoebNk=;
	h=From:To:Subject:Date:From;
	b=hmi1p/U+gcQ8rBophjmqgH+gdffJI6rn2BSdvVHy9Kk+nTMTf6QBv0kfFlBr2WCNL
	 1QcWx9dGXU0/ZBQBgklPegC+Zu7QiuNQ/B5O1gzP/tW+mCdzLSPKb2NaLm7zhY6fsZ
	 ccmEAJnwt48Ig0WzGPg74q64sUqtZ0zxuq5HfNS0=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 6E9F619CDF7
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 16:03:59 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: selinux@vger.kernel.org
Subject: possible regression with filecon equivalency
Date: Thu, 29 May 2025 16:03:58 +0200
Message-ID: <87ldqftsxd.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


This worked a while ago:

root@nimbus:~# cat >> /etc/selinux/dssp5-debian/contexts/files/file_contexts.subs_dist <<'EOF'
> /foo /usr/bin
> /sysroot/foo /usr/bin
> EOF

root@nimbus:~# matchpathcon -m dir /usr/bin
/usr/bin        sys.id:sys.role:exec.file:s0
root@nimbus:~# matchpathcon -m dir /foo
/foo    sys.id:sys.role:exec.file:s0
root@nimbus:~# matchpathcon -m dir /sysroot/foo
/sysroot/foo    sys.id:sys.role:unknown.file:s0

What happened?

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
