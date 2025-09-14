Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B6DDAB
	for <selinux@vger.kernel.org>; Sun, 14 Sep 2025 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757827998; cv=none; b=qS+KByCJLnvqvZ10Fls9RkZE9CbocdJ2rO5sVKXoY3UvQ8tCDDjtSuPwpX61GkcZZVD/KuQesOQDGaPrnzWnOrk/d1LMGbpTHUFyX1C54DVFDuI6cHenVbCd2cXuB5oZKupPfHyf5gR3HE6rx+nBjE6Od8ahI7J9o/rdnCrKf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757827998; c=relaxed/simple;
	bh=KYaWW2JGRzIYjW3y0kfrdhfWOAUIv+klc/uKthNQTYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tuIEUi9EZuS4QEPJuijzf2pM3SX1ZhXoSZPGshMPJ3c5cwsMYNSfSplq0G8T3pcUXkWFugLSdnbRE4HGLXYXnmP/ImcH/2CFATefaotHXo+7vKK98wj/8nf8kbpX0YN8H5S54CD+/yj5brj4HTFqGoO3Zlv+xXwgC8X23cS24+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=KW9onGlh; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="KW9onGlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1757827790;
	bh=KYaWW2JGRzIYjW3y0kfrdhfWOAUIv+klc/uKthNQTYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KW9onGlh6TtPuX3t54F5+Nc4uBqz7MYKGBwT8D5uc4i6Lm80yk45ElGRAR79+zm4v
	 Le6KpXPUfKpi9mjjuc8QmJ5GqU86ZyMQKJcQDtK5IrVk9NGw4dEIiUWnKNnWPArUbH
	 UYqCZR6wJSwU+s4DfwG0ERc98M2kkqZHNg1XGwe8=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id B268E1DE40A;
	Sun, 14 Sep 2025 07:29:50 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Ian Pilcher <arequipeno@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Subject: Re: File access macros
In-Reply-To: <78602e06-7db0-4e0c-9415-75098682e58a@gmail.com> (Ian Pilcher's
	message of "Sat, 13 Sep 2025 16:00:08 -0500")
References: <78602e06-7db0-4e0c-9415-75098682e58a@gmail.com>
Date: Sun, 14 Sep 2025 07:29:50 +0200
Message-ID: <87frcpfvox.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Pilcher <arequipeno@gmail.com> writes:

> I'm writing a policy module to allow containerized and non-containerized
> services to share content.  (Basically to give container_t access to
> public_content_t and/or public_content_rw_t.)
>
> I don't normally make much use of SELinux policy macros, as the
> documentation seems to be rather difficult to find, scattered, and
> sometimes conflicting; instead I usually just use the denials generated
> by the program that I'm confining to determine exactly what access it
> needs.
>
> In this case, however, I'm trying to do something much more generic.
> I don't really know exactly what permissions a given containerized
> service might need, so I'm looking for a good, standard set of read-only
> and read/write permissions for files, directories, and symbolic links.
>
> It sure seems like this must be a solved problem.  I.e. there must be
> something like this macro, which Google Gemini so helpfully
> hallucinated.
>
>     fs_read_access(<domain_type>, <file_type>);
>
> Thus far, I've been completely unable to find anything like this.
>
> Am I wrong that macros like this exist?

I can give you an example of how the public content feature might be
implemented with an example. the refpolicy ftp module:

There are two scenario's there:

1. by default ftpd_t can read(only) public_content_t and public_content_rw_t
dirs, files and symlinks:

https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/services/ftp.te#L251

This interface is defined here:

https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/system/miscfiles.if#L915

2. write access to public_content_rw_t is conditional in this
example (with a boolean):

https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/services/ftp.te#L16
https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/services/ftp.te#L260

This interface is defined here:

https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/system/miscfiles.if#L937

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
