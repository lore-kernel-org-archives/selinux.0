Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792181C0DE1
	for <selinux@vger.kernel.org>; Fri,  2 Aug 2024 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587241; cv=none; b=KeProGn7nz93alvPzZYlOs6vhIFGxZVgnYireK/Vs0WldG2qpYaMfPJIYqMkZ9SOPERR6sMblzk048edSJqth5e5d0LuSfXdodikKyv+xfURwn/VIqZLB0ib1Mtt6efSutB/UHhpnOXZs6q8h5/Z94ZEmpoQsyXmwd4mCYjPWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587241; c=relaxed/simple;
	bh=xyCQOE3txo48C+ENFVyZ9g+ZYqUdNt+x2MvSEzU3d7w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hWwMjV3SuF5HnLS/zJkpedu1h0kyvHuHdv46GALDy6FWD4qfb5t4qZ2Eu4Y/pvr9dAW3QfbK5p+mBl4f81FQGhyAkHmjpsJK1VzlK6E+RTrIinosUULbF8DIWXtRhU0M3nOUxAlpI7iekLFSlxGE5GGJXPSG5JrymmTnZP8t5lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=dqJM4/iF; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="dqJM4/iF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1722587046;
	bh=xyCQOE3txo48C+ENFVyZ9g+ZYqUdNt+x2MvSEzU3d7w=;
	h=From:To:Subject:Date:From;
	b=dqJM4/iF2am3I/fg3Kq1E535hMLCn/YVuvYmnynC4xZwAdBluNvU3VD5I8IvtyK4Z
	 I17Tb6elQPRpgu2zNeQn/bJvDoPezcTiwtf2VbLupdXcF5WJSbpBgj09vbp3Ggr5ph
	 heO7yvw8X7bpa1dWejZleaiu8XBs7MqBpcNiLj6Y=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 237C183248
	for <selinux@vger.kernel.org>; Fri, 02 Aug 2024 10:24:06 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: selinux@vger.kernel.org
Subject: monolithic policy on a volatile root
Date: Fri, 02 Aug 2024 10:24:05 +0200
Message-ID: <87y15fe3iy.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


I think this question was already asked but I could not find the
discussion.

What would be the challenges to support a monolitic policy on a volatile
root?

In a volatile root scenario there is only a non-volatile readonly
/usr. Would it be possible to teach libselinux that if there is a
/usr/selinux and not a /etc/selinux and/or /var/lib/selinux that it would
use that instead?

The challenge I am currently facing with systemd.volatile=yes is that
when the policy is loaded from initramfs that systemd-tmpfiles (and
systemd-sysusers) cannot properly populate root from /usr/share/factory
(or created) because they rely on libselinux,get/setfilecon and thus on
/etc/selinux/contexts/files. There is a slight chicken and egg situation there.

Often times its not a probable because one can do with automatic type
transitions but some of these files get created atomically (/etc/passwd
and /etc/shadow for example) and not to mention that these libselinux
linked components might get confused and noisy if selinux is enabled and
enforcing but there is no /etc/selinux.

Duplicating policy in initramfs and /etc, /var/lib would invite
inconsistencies and is not feasible but if the policy is readonly and
thus monolitic then this might be feasible if it is not too
ugly. Actually in such a scenario we would probably not need a policy in
initramfs at all since systemd would just load it from /usr instead of /etc.

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
