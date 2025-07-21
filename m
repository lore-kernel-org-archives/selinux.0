Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E3284669
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088003; cv=none; b=lgTpUAQ+rkTt4poac4ojVOoYWtRUEmvJV8HSkJhNL4/srrZX640mQ5bV5Ej9Nhsqar09tTaHNEPG/u29wBBoLu40pc10pCEdPlFVeSKk2YOFuPHh+BXNCo82YI5ZWSWrSNv20irz8nJjEdIIKCrLF7Vyelci0728XZIQ13dyTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088003; c=relaxed/simple;
	bh=naBDr1ZvWNiKBNg8OMv3+8JqtOzFjVoBOZpBBOFGKDY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jRceHMGWTY/EtGlWzxQr7r1OqiVl//J90KqZQKYTi7WK5trnn6EzXWkp27uKRuiqrneH1raXXGGPbk2OvoSNcZAZuOrS8UkgdEibJSAQ6dKun08En7e4QIZ//fvEQXkdDwSeOnF+Q8Z6G/RA3tiKI9lFq3OcJfKeMAl9roxzjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=fSkXH33J; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="fSkXH33J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1753087671;
	bh=naBDr1ZvWNiKBNg8OMv3+8JqtOzFjVoBOZpBBOFGKDY=;
	h=From:To:Subject:Date:From;
	b=fSkXH33Jz4M25ZpBbNQsMnZM8v1L7C0MS3auEusHIp0Pn31xsQ+zvU6ErKwSO57RF
	 C1lugMLKrViGcmReG00uGiEKbMYSFeg4liju2jsSswLeyYWJDpO+8XERANKWpvoXr1
	 BbcqggcHrV0aBaCDb7o1rjaJ+8SlFZqSBEkpiF4w=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id C47BF1B38E2
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 10:47:51 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: selinux@vger.kernel.org
Subject: systemd.exec(5) PAMName= with libselinux
Date: Mon, 21 Jul 2025 10:47:51 +0200
Message-ID: <87jz42dj60.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


systemd has an identity directive called PAMName= which allows you to
run a unit with a specified PAM stack. The issue here is that in this
case the "session leader" is always systemd.

Thus you get into issues with pam_selinux because since systemd is for
example always associated with "init_t" you can't really specify log
SELinux identity foo_u in with foo_r:foo_t:s0 if this PAM stack is used
and log SELinux identity foo_u in with bar_r:bar_t:s0 if that PAM stack
is used.

This previously was not a big issue since this feature is pretty niche
but with the advent of `run0` it became an issue since that relies on
PAMName=

The problem is that pam_selinux is often already used to start the
systemd --user instance, for example:

/etc/selinux/TYPE/contexts/users/foo_u (/etc/pam.d/systemd-user):
system_r:init_t:s0 foo_r:foo_systemd_user_instance_t:s0

So you can't add the following because it would conflict

/etc/selinux/TYPE/contexts/user/foo_u (/etc/pam.d/run0):
system_r:init_t:s0 foo_r:foo_shell_t:s0

Ideas? Suggestions?

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
