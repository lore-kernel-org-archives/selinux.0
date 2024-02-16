Received: from becquer.dodds.net (becquer.dodds.net [207.224.24.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9867A38F
	for <selinux@vger.kernel.org>; Fri, 16 Feb 2024 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.224.24.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043145; cv=none; b=cWsG3MABNLstn34y7pdBGmKdSZIFTifoF7miJcvHBtcNCQrwWfgXXr+u48jrI3M7zoxsRP7KdYJWDyBHKgG80b8XB6UyHi099qndstzYmumndifKlAvX+eZ+L/geWRx9ebfJLxg4iHRucxq6f6o3SAaJrNz7Edga/APxRnDqfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043145; c=relaxed/simple;
	bh=vUzl2ocfT2ukpaaz5kbya/cSTBLKNrEOqI63696erhU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CKjofxPsNloncPa/PwCShAlHZsLdDOp9oPcDdAKDYHkRQl1OyZOGO7QzHYLbhMZTGu+8Z5TOh493EXvk3OKGYnWM1FIbFZgGVwYfshOt1NLr+1SAYbFqag8NGlR5yJBL7GlaSsaCkPSH8Jpf7D2eh8uOjOs/Mm9LRQRr6MR8rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=none smtp.mailfrom=homer.dodds.net; arc=none smtp.client-ip=207.224.24.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=homer.dodds.net
Received: from homer.dodds.net (homer.local [192.168.15.41])
	by becquer.dodds.net (Postfix) with ESMTPSA id A3AD024FC8
	for <selinux@vger.kernel.org>; Thu, 15 Feb 2024 16:18:46 -0800 (PST)
Received: by homer.dodds.net (Postfix, from userid 1000)
	id 226D5D2E; Thu, 15 Feb 2024 16:18:46 -0800 (PST)
From: Steve Langasek <steve.langasek@canonical.com>
To: selinux@vger.kernel.org
Subject: [PATCH] Always build for LFS mode on 32-bit archs.
Date: Thu, 15 Feb 2024 16:18:42 -0800
Message-Id: <20240216001843.24839-1-steve.langasek@canonical.com>
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

