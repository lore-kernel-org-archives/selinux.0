Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07117C6B
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646376; cv=none; b=IKrRKaQp8KNn9eLeLlvN0cadMlje5FmXVbU3b108W1n45+H5QM024QZBItJwVxIBunRGbbgKqcEZ7bmvjushQrpgDUFRXWJVReUwOxZmbZ3HF4HHSoeQPQe5Tr0MddRK55GaPqJGFthObY05htSZZk5dRBwRKgRLNHs5CgHFgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646376; c=relaxed/simple;
	bh=tcrITvstVPWqUNMXOjklZvF1JQjDEVmnZpkWk4emGkg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R/T+VPWh/bALeIohxyaQpocYQj3lVRm6rmGXbSRF3GOxR31EoGMxps7DTMxXVtgB9syiwyt8mMGElp4ZOY/3RzhNe5kUHPVjnfoaHNa1dkN8rgTLLqgR0g+7a76+bnXRtmx+uJ/JTf3IgxdsQgc1Xl+nBkuvPYLoauFqMLZ45Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E7UWyaBQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E7UWyaBQ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-787a43e2e2dso17527885a.0
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646373; x=1709251173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ti7Wtt6FNyMHoA0q/IaFb+RzVArJTohC22ALQH6kPI=;
        b=E7UWyaBQqjJznecEdPoXffpdcjBqAl1WYSh6+2rwJSOU9H+cvBezoyCPooWLa1+AeD
         T0YtilKnewYtNTrn6yQWvXwbxh3sAyDhXOFqFUkGY04q+6Zg+pAT+5LCNMgeZcToVaMq
         KPWeYskhM2u2/jt4b3j23GTkqPORAuhkkGN//E1Em+EGLy0kdbhcFraEOwU9+CocF+wi
         lBSdd9vFAdzU2K6U39ssXiZElqo+TkJxQ3bc1w9nMoloj9JtxQQfSnh+kbH4J1BsElIL
         mjbDmF1H7un6LqsPGXB7SKVh+atTdiydhfEdl33DHPD0x9H2vsGlmYkXqFHaTUysWCJh
         rsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646373; x=1709251173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ti7Wtt6FNyMHoA0q/IaFb+RzVArJTohC22ALQH6kPI=;
        b=Z/jatnV/fW8JpcbI3VhDq0SHxEarGbrlZBRw6L4TlBh5kiaFZPGcOZAMB711Gx+zF8
         5NDBbczJoVSMH5n/5RDFo0E3rVxA26ytpZYmyySu6XsdJq2VnaL1Yz5519mS3SzMVDl6
         bHbQ2PBc21T+b4f2vNBPhEnJ9DQiNmpPiF+53oZKJw7qXqMiv6/hu3uRkkbTWT5EjRX5
         GiiyAwwCErmwKLfTM3wuO2pabfvmCmDZodKAX387CeBe39ORVGf7XNLDSHrgMuHbeMFJ
         7xwrSiqrxjGdsnz81vZer4+nP9Uv2Rf76/TcuSOpXyJoBP80qp+bsNjZzG7HvhlfvOeB
         dn2Q==
X-Gm-Message-State: AOJu0YyoGXy9tTCkWpsNhJH8mE3MY2eBUlTjwjnaKEkqL3wQmGkUPFMo
	+BRbbgqXe8tcr7QW3ZZe+r6QCo/lXvcXgevIFYaBp2mTkEwGlZP7oIyKpNjaagdFve3VQlt1ChA
	=
X-Google-Smtp-Source: AGHT+IE0eIXpBZLFXdhtxekoYB/8xdNrP01ohrKWqggolqmCwoX2OKX8ZNja39EcsuWG1eLefYZLFA==
X-Received: by 2002:a05:6214:2c03:b0:68f:69bb:4b9c with SMTP id qq3-20020a0562142c0300b0068f69bb4b9cmr803058qvb.43.1708646373420;
        Thu, 22 Feb 2024 15:59:33 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ma12-20020a0562145b0c00b0068fcf0d5b4fsm515727qvb.145.2024.02.22.15.59.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:33 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 00/21] selinux: fix style issues in security/selinux/ss
Date: Thu, 22 Feb 2024 18:52:18 -0500
Message-ID: <20240222235708.386652-23-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continue the earlier work to cleanup the SELinux kernel code to follow
the Linux kernel style.  This patchset focuses on the selinux/ss
directory.

 security/selinux/ss/avtab.c       |  105 +++----
 security/selinux/ss/avtab.h       |   74 ++---
 security/selinux/ss/conditional.c |   68 ++---
 security/selinux/ss/conditional.h |   23 -
 security/selinux/ss/constraint.h  |   61 ++--
 security/selinux/ss/context.c     |    2 
 security/selinux/ss/context.h     |   41 +--
 security/selinux/ss/ebitmap.c     |   56 ++--
 security/selinux/ss/ebitmap.h     |   42 +--
 security/selinux/ss/hashtab.c     |   23 -
 security/selinux/ss/hashtab.h     |   35 +-
 security/selinux/ss/mls.c         |   83 ++----
 security/selinux/ss/mls.h         |   58 +---
 security/selinux/ss/mls_types.h   |   32 +-
 security/selinux/ss/policydb.c    |  405 +++++++++++++++---------------
 security/selinux/ss/policydb.h    |  192 +++++++-------
 security/selinux/ss/services.h    |    3 
 security/selinux/ss/sidtab.c      |   69 ++---
 security/selinux/ss/sidtab.h      |   36 +-
 security/selinux/ss/symtab.c      |    4 
 security/selinux/ss/symtab.h      |    9 
 21 files changed, 706 insertions(+), 715 deletions(-)

