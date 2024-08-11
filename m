Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBBC1798C
	for <selinux@vger.kernel.org>; Sun, 11 Aug 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723388305; cv=none; b=dfrTCtQFnLBD+gAYwtxrqEn90fXiSkHovGuvqXmNoOn27yLMze9WTxxkLwTe62jpiLLSwq9HLtQszkFPFakjvVRCiN3IjuVCzo546bamxUoYObYDEozdZhq/nl10yJcwSn0OtFdcS5bsLz0qnxfroY4qL/fPDGWk10ehleykbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723388305; c=relaxed/simple;
	bh=lqBj4Yjp9MPtkBQHCXhnHzIOGQ6dXMjwfWlGYtJ3sKM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KLqOayfU1k/G3YPn+VzjcFlT0MhDEl0OkAbevYg+fvSG4UkjGzj60S3EjKMdvN8tG2Hkvpsj3l3j/yndPOHdgei1ypYLOP4kPPSLGwsUPBxKxlqis5riXyi4OzY9gQpFqcNhmLc3yjhA83VXtn6Ko7yzTikVU9T9BNqQoD7EPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=e9+MbxWB; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="e9+MbxWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1723387984;
	bh=lqBj4Yjp9MPtkBQHCXhnHzIOGQ6dXMjwfWlGYtJ3sKM=;
	h=From:To:Subject:Date:From;
	b=e9+MbxWB2g7tJTE0aUSv0iYYjFmc1na4aYkdDR6P+SirqndESAaCXQpH+94YdeQNG
	 zzgJ76R53DRhrTNLHpIypI2GASTYvOsKfWJjiHZQ8BswwIH/gJBfPQ73dXIn+v4SYg
	 SqnhW5eXp7aXlJvtO2/dxoT3NoKQZG2ReaIrtCFw=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id E283F965A3
	for <selinux@vger.kernel.org>; Sun, 11 Aug 2024 16:53:04 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: selinux@vger.kernel.org
Subject: no period allowed in typealiasactual libsepol 3.7
Date: Sun, 11 Aug 2024 16:53:04 +0200
Message-ID: <871q2v157z.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Debian finally updated selinux to 3.7. At least libsepol.

It broke my policy. This is the change I had to make to make it accept
it:

 (typealias dpkg_script_t)
-(typealiasactual dpkg_script_t sys.subj)
+(in sys (typealiasactual dpkg_script_t subj))

Is this a bug?

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
