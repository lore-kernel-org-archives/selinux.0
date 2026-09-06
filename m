Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B23D34B1;
	Sun,  6 Sep 2026 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700666; cv=none; b=VykHuMK1Pf8Rl1ZblJ92CzljNwkNoFfS0zJoUvrIgseXn0Dxdk8IQo7c+MGLKY+YFZ9doHCh/wd8GwUemc9d5k/NLUrqXcfhVwWH0HBIZWF3Gv8CMrKu17CutgVnvehFgrfvuFWjl5Xve3MJrLmnL/K9K4Eghw8+B3z0c8OVFUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700666; c=relaxed/simple;
	bh=D0FaACf4q4n3r3gf7FXUFvBtcMrXr75njKBABaQ3R1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0+DP3lIQNX5gnfNaZn/PTg7gqzbQ26LliCDAPUsl5c6PDGk6U78eP693oU2BonchdFRTdTYrZAYRVQlC9EG6wSCPmq6vAZAfTWxtb8qVXzfjgp7GTlQJPzp57ChDtHApcwh3cB5iHHEXQoQe77yJyMQH9eDyFrXpybgM7ZBA00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=yQsunP0/; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="yQsunP0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1788700655;
	bh=3LkcXQtSzbrf3ko1AWwc7Rtqjxprv0a9LonbhhPuV3Y=; l=2288;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yQsunP0/lzwfVSguS4jH5CqEwGB63LaVIxkhOi80AVV5uvZIEf09rmjOMLYJcH/81
	 JNWJ1GxtNHFFL6OkG0NdpBEp5r6U8NrRGhk+C0f96NGZzsoB0iIJm0FB1znVEMM+c7
	 LrVsNspjaV5DuVbSNISpsfeKPKxzEnsdxbijEe0I=
Received: from liv.coker.com.au (unknown [IPv6:2001:4479:4303:3800:7ddc:5054:982c:268a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 21112F0D9;
	Sun, 06 Sep 2026 23:17:32 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: SElinux list <selinux@vger.kernel.org>, selinux-refpolicy@vger.kernel.org,
 Chris PeBenito <pebenito@ieee.org>, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: kernel oops on recent policy with older kernel.
Date: Sun, 06 Sep 2026 23:17:23 +1000
Message-ID: <RvCmRlQYQ3uewSzEeY0utQ@coker.com.au>
In-Reply-To:
 <CAHC9VhT+k9qWsA40APOi4Q1hg8M+Ft_A7D3epdBW7P2QczPf6Q@mail.gmail.com>
References:
 <L8sbFRgfQca4r8AaNEEfTw@coker.com.au>
 <CAEjxPJ6SQcdEDFfV3W7Bk5JKbAxRp+9tuvr2yhUdDePmeXNAKA@mail.gmail.com>
 <CAHC9VhT+k9qWsA40APOi4Q1hg8M+Ft_A7D3epdBW7P2QczPf6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 2 September 2026 01:35:44 AEST Paul Moore wrote:
> > Date: Wed, 22 Jul 2026 21:04:27 +1000
> > Subject: kernel oops on recent policy with older kernel.
> > I get the above when loading the latest git policy compiled with 3.11
> > userspace on Debian kernel 6.12.74+deb13+1 and Debian kernel
> > 6.12.86+deb13.
> > The same policy on a 7.x kernel such as 7.0.13+deb14 works correctly.

https://www.coker.com.au/w/

Below is the kernel message log output with Debian kernel 6.12.107+deb13-
amd64_6.12.107-1.  The above URL has the Debian kernel image and the policy 
file.  The command "ar -x linux-image-6.12.107+deb13-
amd64_6.12.107-1_amd64.deb" extracts the kernel if you want to use it on a 
non-Debian VM.

It's hanging not crashing which is an improvement.

[   10.414520] audit: type=1404 audit(1788699747.392:2): enforcing=1 
old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 
lsm=selinux 1
[   10.530653] SELinux: no sid found, defaulting to security isid for /
booleans/aide_mmap_files
[   10.535475] SELinux: no sid found, defaulting to security isid for /
booleans/amavis_use_jit
[   10.537368] SELinux: no sid found, defaulting to security isid for /
booleans/allow_httpd_anon_write
[   10.540012] SELinux: no sid found, defaulting to security isid for /
booleans/allow_httpd_mod_auth_pam
[   10.543230] SELinux: no sid found, defaulting to security isid for /
booleans/httpd_builtin_scripting
[   10.546402] SELinux: no sid found, defaulting to security isid for /
booleans/httpd_can_check_spam
[   10.549244] SELinux: no sid found, defaulting to security isid for /
booleans/httpd_can_network_connect
[   10.551298] SELinux: no sid found, defaulting to security isid for /
booleans/httpd_can_network_connect_cobbler
[   10.554654] SELinux: no sid found, defaulting to security isid for /
booleans/httpd_can_network_connect_db
[   10.556863] SELinux: no sid found, defaulting to security isid for /
booleans/httpd_can_network_connect_ldap
[   10.559776] SELinux: failed to initialize selinuxfs
[   10.568734] systemd[1]: Failed to load SELinux policy.
[!!!!!![   10.585074] systemd[1]: Freezing execution.
] Failed to load SELinux policy.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



