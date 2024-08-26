Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB9C54656
	for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668233; cv=none; b=LHqHnB7blyu4IlvyWE49gYPVhHR2ua5VAu1wPTDbFACkDLy88bFhqR945yFZlXKx615OoTE869+cu8+6bUBSNti8AwihUdLPI54mb4VxPpQ/snsvqxxocHXa7dwDEOn0bABQNQW15hGOqfNf6jUIoBQg0pnsrduR+cnoBkUuyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668233; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:Mime-Version; b=HGDjHsxmiSATQN1J4MGSi89Sx3Nwr77DHZ3KBfkbj34FO/KIx/Vowliafev61BvtrgRyvx/Sa8Kvk4TjcSsWIim6qZgPPm6PL2q8k908qS+11G9Dn8tGTBjjH0rYAqS4eUekSvSjXk5izmEF7ZLcMAYFlLguP9vq7F5+D9eFsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=RNGCdsIO; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="RNGCdsIO"
Received: from [192.168.43.2] ([109.54.128.216])
	by Aruba Outgoing Smtp  with ESMTPSA
	id iWzRsyIduqJRSiWzSsYotU; Mon, 26 Aug 2024 12:30:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1724668226; bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=RNGCdsIOfMvM66/r64ptjc2oysRs/sMh705vlkA7sCj0OwY1+TRmIyNqlk3wCjtLc
	 VFWVZik5L7U5PeeN+IpiSoarhAxVvwb5UU4EVx67/nLtcaey9yAWWfoCIvKsF4jAkZ
	 WCRmxckTxlOIrStJF+dPm91z/7nvnoVmDm9c9BusaUW4cJk+imvsp0OnIehNBUTYAy
	 v5gC7O8GGiXshQh0bdPGbL2Q5mrVChu3cn6KquCX4NJHb5Hmbc9Q6aKCwVNnCQuacQ
	 CW0otntb4A5MC1y4sX/h7bLjrP5XfG8MwuXN+VybmgBxO7i55ddTMbCWvsJZn5Ugpd
	 jpMRF9V+p0fjw==
Message-ID: <1724668225.8264.12.camel@trentalancia.com>
Subject: [PATCH] selinux: mark all newly created Internet domain sockets as
 labeled sockets
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com
Date: Mon, 26 Aug 2024 12:30:25 +0200
Content-Type: text/plain
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFRsd+tARVPeb6tenWl8nECjuScc0jK8RUyG3yzALM4qlB+XIhWKc8559b0gqbFFQtt0OoKl93/GTP76C/VoaNzr9vmu47XY+F7b6lvJjQSGapLDQZRT
 G4F454KOl/gBfhGnY3UqFL9e9nk7hQpsBCG41W7xbQf8uBmiqgn6jxN6vmvNaYasb6dWWHiX/FPV9BbANBZg4XzgciF8hODiJRzq9FbPLXC7XOEHiRdA3X4O


