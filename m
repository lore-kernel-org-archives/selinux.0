Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42855484251
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362119; cv=none; b=uugY45ddizd+sfb2OmRy8T3WHoXpi6Rr84wXamhGuDFmSevsSUZ7M9iLMUCmcQhV5t/blWG9wRF+6i6n53GWaAp3xESxci2+0h2/5GoSd1TgO2nwATqH+/bVq4F+SrHQZGJtNB0FlU5EeT5bLtJb4dxdX2Tmgt00bYtvE1rQcbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362119; c=relaxed/simple;
	bh=jGJsUW6AVCHT0/6iGw/Q+hPZ7cWa4isIZ3BQwPFrp24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNGdsm4q24Pf5ETM8lDDf0re93MPgRVviZ8S7uo7JmYLPcP0DgHfeWRhDjRaGSb/1RNXkwwezcFa2UPTIcGnqsI9rYek7rDiJxyci35hvykC+LCwNgQlnCZ9T64Qgs+Wrw3Q5NF5Pru3VLNba1PQD3mxi7i/C2Q8L6lgYSadIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXeFjQrW; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXeFjQrW"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-934956bee57so177018685a.2
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362116; x=1788966916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7mAHVk3RRLEQ8YFSe7j6fRyScAQnVUsvzOFULezuuAw=;
        b=UXeFjQrW2rG+XlcJFBX2RljjV4RMMzf//F0TN0bhgg/hSkEaXX2A+s/i/FveuZ4Hpr
         uqD3ppy7rNAUXapPj1ABJ7e6qW9lUuVkYlN/M/rs0TQoHMFWM5LMuCI7mFMzBmtxr9Dd
         AzAZ3rksq7oSqdzL2w/EIPaJJs+TBt/NlyHdP+WSxYUZPHeNhivNvjWstPbZetFDkQhS
         0AgakATqHWJeAzlSPIzmSEpEhB3d6KK8MXZPAvX/bLFmZ2sPdJKdu4Fv3Q+ONL9LwSmC
         jiKzvIUUdGoosjsLZsFBDpLHvr6P0NXGUDo6eW4S0H1ueKXD7Es1uBHMYTLgwpFeoBoo
         IVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362116; x=1788966916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mAHVk3RRLEQ8YFSe7j6fRyScAQnVUsvzOFULezuuAw=;
        b=n21VmjPikYOs5f0xHBjScsj6vXO93UB79RsK2FHEBcNmnG6M4BxLFGObf0jkFlIfVQ
         onJM59f+/WNnQ9z5muOfWTg4ABiOsTOmLDLNx6eco9bJC9oc9HQjsJo7r2gFadIJf9nX
         i96CzJPvuzgUVBtL6QHgRpzpX906cJ76iCpATP4pkBbpguKSe7kxoeuVy92TOqxA1bMj
         qE4Kv5V1qfFQ29D3yO/7E1KYWXxQHvNEvM3UFziSGYiDYFsZ+bSk/2RE12iWpYTLUyv7
         wifvWnGNwoBQQ7gzrKP55BnPiPh2Y5I87FqPP2prZdm+NfKgiaDsM91tL8Ockhl94pyv
         yMeA==
X-Gm-Message-State: AFuF++nJ1ZDX1PbliIJ5H++Hq4ueHLcffyE+cqNMaj3knRizW044o0ZT
	fcU7fZssgi8PZuYrwtdfVaiSHRuxUUuGbjogMxXYuTsA/9Jrmj/JCL3MsLrWtg==
X-Gm-Gg: AR+sD11xC542UxYeSVFqrrudr0YJ2X0PIBvAx66vtrdIy11ZUsrPttNsD/oCMHhYed4
	nwFlKGX/qqJ+LDS7h6HHgV1yehNpyO7OxYnguegI0hnw9H5oTPBG5mECBh0D38gjKvNV62r/IYJ
	PZ3Xxr+o8kohKcbrVrAgsHCu1RjoI1G8cd1WKqWSdEFTDnA7shnNdYk9rjfcf9JBo2LlEhs7tOP
	cx4XmlgVOG3Tw5TpRbuc2q+D4s7I81o2AIklD2LuC8oTCMG4xMjZtlPUp0Y9jPSVI6tmU2pyYy3
	HOsKL5vSMIOYQG68ZV/vRJXnlLJyuB7alzjz5Qq5hMYLD8OJ03VWrCd4GxbFRd79riVparkxkuL
	aELeDjImfc1iSXSxtVbaoaoanKTwqaENBIC3NwTLA80YTqZPDqODGCfwJeSNn9RcchVmknzOFj5
	HV9D9nkYRSUWjnIUrSx+ccYfm3Tp8lFyyPEhHVcAIEgWex11KJXKD2QJx7GUyyIpnSK0gDfvoG4
	zG8vJWrz5m0y6nUMJyazed2vYuwwqjedZw8+TXDn7Vwe6KFCa/2qRqtebNUu13M
X-Received: by 2002:a05:620a:630d:10b0:92b:8a7c:f71e with SMTP id af79cd13be357-93960df1bc4mr568570785a.15.1788362115789;
        Wed, 02 Sep 2026 08:15:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f17eefdsm229299885a.11.2026.09.02.08.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:15:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 0/9] libsemanage: add ro-store-root and configuration-root search list
Date: Wed,  2 Sep 2026 11:13:57 -0400
Message-ID: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is the second half of addressing:
https://github.com/SELinuxProject/selinux/issues/33

The first half can be found at
https://lore.kernel.org/selinux/20260901163513.43186-1-stephen.smalley.work@gmail.com/

This series adds a ro-store-root option to semanage.conf for defining
a search list of one or more read-only store roots that are then
searched for all read operations when there is no corresponding file
under the writable store-root. By default there is no change in
behavior.

This series adds a configuration-root search list to libsemanage so
that it searches an ordered list of configuration roots for
semanage.conf.  This list can be overridden at build time via
-DSEMANAGE_CONF_DIRS=. There is no change in behavior as long as
semanage.conf is found in its default location under /etc/selinux; the
fallbacks are only used when it is missing.

Stephen Smalley (9):
  libsemanage: accept a list of read-only fallback store roots
  libsemanage: add semanage_module_find_path() and use it for reads
  libsemanage: list modules across every store root
  libsemanage: read the active store through the fallback list
  libsemanage: create the writable store skeleton on first transaction
  libsemanage: create the store root when taking a lock
  libsemanage: refuse to remove or enable a module owned by a RO store
  libsemanage: search /run and /usr/lib for semanage.conf
  libsemanage: document semanage.conf search path and ro-store-root

 libsemanage/man/man5/semanage.conf.5 |  36 ++-
 libsemanage/src/conf-parse.y         |  57 +++-
 libsemanage/src/conf-scan.l          |   1 +
 libsemanage/src/direct_api.c         | 458 +++++++++++++++++----------
 libsemanage/src/modules.c            |  63 +++-
 libsemanage/src/modules.h            |  10 +
 libsemanage/src/semanage_conf.h      |   2 +
 libsemanage/src/semanage_store.c     | 185 +++++++++--
 libsemanage/src/semanage_store.h     |   6 +
 9 files changed, 611 insertions(+), 207 deletions(-)

-- 
2.55.0

