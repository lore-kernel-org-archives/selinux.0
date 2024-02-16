Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1863A5
	for <selinux@vger.kernel.org>; Fri, 16 Feb 2024 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043597; cv=none; b=c+xyzLU21/aXXGGdtHmW0AqLyhvdrOWHhlFsnu09M6UepetrhzgaEadiFMNM4pvUp35EsUO0CXe3q2K+vrNqklhwIEGv4H4KwLNzhVTmzNFIaY+9m8vEefk4aopNsj5NX5D6D25OyuuVlQDlHtPGgIbLHC8gVFJmcYZiJXYRi0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043597; c=relaxed/simple;
	bh=vUzl2ocfT2ukpaaz5kbya/cSTBLKNrEOqI63696erhU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NnZVTMImm78OCxUbFMnhlQha31MZzwzqj5tkkTtlegGM4pg3MlVvhJBV7xWNWKwUq4icTOPnJ6uQnTw0fb7/+kYVI/oXKdpAreO72TjW2z//lSXmPo25jY48A4f7XVdHxCy1DpjT+fJsIOuP0PGWLyyA3WX9vFmmEgtt6dtySqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lIcB8vee; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lIcB8vee"
Received: from homer.dodds.net (1.general.vorlon.us.vpn [10.172.64.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8F7833F5D4;
	Fri, 16 Feb 2024 00:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708043586;
	bh=fvWpcprXTBjXqK9/Jb4db9p7FT2Te71j3g8fAsnEuRQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lIcB8veeMtHVp2oCKE7NmyNLobqLPs31DSnSKBCU0CCZWUKF2uJ+nqj5SpGb1RXlS
	 pz+BmD9npPEaAXEmhnCTu4Fu4AHJnzVCTjP8K95dxhVIpnmM+SEv8x7Hs2PGbH2Pdb
	 5UGhYudbDpnkaRY1sHzHTV0E018+mg+4b/HDdDopds6z8sFNcpiweAmI/Kt2iSfr1c
	 PhaGw1hkHplRFBTsLsOSPKhf0g+K7Fsbnq5YbR8j03pN69/otqh7eBHAO/85AOPknu
	 dYUJObnma+9MlnBhyExgkiOOlRxkKf3FU7HgD5VKgRa+lzKjEB0ERHk1AHD2djWAEJ
	 8dng4arHd5dSg==
Received: by homer.dodds.net (Postfix, from userid 1000)
	id 77DB9E94; Thu, 15 Feb 2024 16:33:04 -0800 (PST)
From: Steve Langasek <steve.langasek@canonical.com>
To: selinux@vger.kernel.org
Subject: [PATCH] Always build for LFS mode on 32-bit archs.
Date: Thu, 15 Feb 2024 16:32:51 -0800
Message-Id: <20240216003252.29057-1-steve.langasek@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

In Debian and Ubuntu, we are working to move future releases of the OS on
32-bit architectures (predominantly: armhf AKA arm-linux-gnueabihf) to use
64-bit time_t natively in anticipation of the y2038 event horizon.

While for most libraries we are taking the approach to rebuild in-place with
changed compiler flags and declaring incompatibility with previous package
builds via the package manager, libselinux is a sufficiently core part of
the OS (as a dependency of the package manager itself) that this is not
tenable.

Therefore I propose the following patch to libselinux to make it dual-ABI
for the single LFS-sensitive entry point, congruent to the way glibc itself
handles such changes.

The particular implementation doesn't use as many asm extension / symbol
version map tricks as glibc to make "nice" symbol names in the resulting
binary, it just gives us matchpathcon_filespec_add() and
matchpathcon_filespec_add64() as entrypoints.  If there is a preference for
more glibc-style handling with symbol versions I am happy to rework to
accomodate.

As this problem has been discovered rather late in our transition process, I
have a bit of a time crunch on my side which is not your problem, but I
would ask that whether or not the patch is ready to land, we reach a
consensus ASAP on:

  - whether it is acceptable to introduce a new entry point for this on
    32-bit architectures
  - the name this new entry point should use (including symbol version)
  - that it is acceptable to upstream that we proceed on implementing this
    at the distro level in advance of the patch landing upstream.

Thanks!



