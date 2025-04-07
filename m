Received: from dd44826.kasserver.com (dd44826.kasserver.com [85.13.151.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362C1DED4F
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.151.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036946; cv=none; b=DHvUZh5zkASiSOdfDxDTR7obq5ZrMeitOf2eTA5nuYj74aSLWSK/6L69EndRb8fEC6t9ZJJgs8AWVJ3NXgAodskIVY3OD8Z5KLFsB9TY4L5cyAQifBpqFgf8CFo2kgzgHRysw9YCUX8MSJ4jTZE4VFancUPoedRna3K4b2iCYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036946; c=relaxed/simple;
	bh=KK/fnnK/+u9kIXtv+ABWta3LfPjAkueRWRE6X2qqHys=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=UcIVO1RJWupW1KSiv26+Dy9uYVf84vM6MAuHIftuRW7X5giYgY7AwMV/eUfwY0tA1OHL9h3UBkld0kkEYs/vSFp9X+LiPa3e4O29FLIqjC/eTddBDL30CUfz15dmfahpu44Mos2S2rsSKrQrM55DZtNf0zagL779Y3ZcoOmSyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=o1oo11oo.de; spf=pass smtp.mailfrom=o1oo11oo.de; dkim=pass (2048-bit key) header.d=o1oo11oo.de header.i=@o1oo11oo.de header.b=dp8/HZ8C; arc=none smtp.client-ip=85.13.151.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=o1oo11oo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o1oo11oo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o1oo11oo.de header.i=@o1oo11oo.de header.b="dp8/HZ8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o1oo11oo.de;
	s=kas202503061048; t=1744036933;
	bh=EvjgtlrSLuG5Klm05crzRnjleNyedMA+i4cL6DsTW7o=;
	h=Date:From:Subject:To:From;
	b=dp8/HZ8CrMMrFbbG5aA/kAy9KU5sOx1FlE8ol80qxUPHMXgX6qmPA3+zQ7X3ge5l/
	 QZNRV4f4TJ7Z73RnTzxKQBCt2qGWUMRS56jcOFuKqTPOK4yyv20mw18z9dV0TWwXWm
	 ncUuDU9abMLPx8VPctsY+ibGq/vkyydst7m1bO0Ts+TCjVIEt8hje3jLpx3HIxVIgW
	 j6VZyBv3/7wWiKZiUkOFWs/wr6Dear6mz8pP9PHWAu8jlYK4oISvbw2F/UyE99FBiF
	 HSAFxEqUL+uzWG+fPGKOGI+2siIeUN1jPtELvRIAvzFr/OoDaNaj6SfYjaocLhyE2N
	 w2EB4o0//GHMw==
Received: from [141.24.112.25] (wl-l6-25.rz.tu-ilmenau.de [141.24.112.25])
	by dd44826.kasserver.com (Postfix) with ESMTPSA id 25426B6E0258
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 16:42:13 +0200 (CEST)
Message-ID: <ed009068-754c-428f-8ef3-3b79dc9ec8b3@o1oo11oo.de>
Date: Mon, 7 Apr 2025 16:42:12 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Lukas Fischer <kernel@o1oo11oo.de>
Subject: AVC reclamation strategy questions
To: selinux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

Hello,

I am currently trying to understand the AVC reclamation strategy.

The code and old discussions and patches I found [1][2] seem to indicate that
this used to be LRU-based, flagging recently used nodes when they were inserted
and accessed, and clearing that during reclamation. The `lru_hint` for
reclamation is also still there.

To me it seems though, that the `lru_hint` is currently only used to cycle
through the buckets during reclamation, wrapping around at the end, as this is
the only time it is changed:

> for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
> 	hvalue = atomic_inc_return(&selinux_avc.avc_cache.lru_hint) &
> 		(AVC_CACHE_SLOTS - 1);
> 	head = &selinux_avc.avc_cache.slots[hvalue];
> 	lock = &selinux_avc.avc_cache.slots_lock[hvalue];

Since insertion chooses a bucket only depending on the hash value (based on
ssid, tsid and tclass) without considering or touching the `lru_hint`, I don't
see how reclamation is still LRU-based. To me it seems like a more realistic
description would be that reclamation starts in the bucket least recently
reclaimed from (one after the one reclamation stopped in last time), which might
still hit the most recently inserted items, if the hashing happened to put them
into that bucket. This message [3] from last year though states:

> The current logic prunes the least recently used bucket

Which in my understanding only works if "used" means "reclaimed from".

Is this understanding correct or am I missing something? I tried to find
documentation for this, but the specific functionality like that of the AVC
seems to not be included in the SELinux Notebook or easily available online, so
I turned to the source code and the mailing list archive.

Thanks,
Lukas

[1]:
https://lore.kernel.org/selinux/20090212195043.25599.80206.stgit@paris.rdu.redhat.com/
[2]:
https://lore.kernel.org/selinux/1234534359.24702.22.camel@localhost.localdomain/
[3]:
https://lore.kernel.org/selinux/CAEjxPJ7QqEG+wyQfuPeDu0JqvjRCvbtVzZ6qtzwc-YwGz=mLjQ@mail.gmail.com/
