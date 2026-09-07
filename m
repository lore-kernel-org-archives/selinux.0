Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A423D4123
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792020; cv=none; b=mvnHl0+OfEdeARCUwSyHtDwV/Y/t9fM0LZv4a9aLoffoopzw8QcocWGs+nPnaMzFHeYD/92qOmm5p3z50a8WvgFATqFFT2U15b2eHJ5P/A763O8E1/OTDIDNyc0vAXWTIY0v0kqKF/qpCf6TRSAng/uKzQXsITvo7EWmVfor3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792020; c=relaxed/simple;
	bh=3riO5LF0LDQ75LkWbWV2i4SFadXEYv5vGvj8f2UtOgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BbpMy5HEZTkNG6kOI+Tjs5aWfsnUoPoxsIV8P8i+l+v+OEg16Hj2VAQ7QRO6GUN7xdm4xRYnPiyUtDz3qF9o4BPtd/8ZHW49XwmO6pxdlRNEG6525k2xQtQpqDj84upCIeQeTB139SdzerYb5RFE9zufKUZoPGGHp73+jHAeH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqB14JF9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqB14JF9"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a6868f18aeso5274936a12.0
        for <selinux@vger.kernel.org>; Mon, 07 Sep 2026 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788792017; x=1789396817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RuGYW3h9PJYNaiCjKHB/faSczvFn9W4fzqCSPNsruxY=;
        b=BqB14JF9/W2J7fnwtvAf0q2KWeZfVojpXybY8rR6XB9tKuf+jf34UQVVi3/H1SFdjk
         Rjqppb7y/tlBAcNLyAgBAGNI2w+YX3dlcR5L2PtXJk0t8EEQEp1n6HMt2gSFnsvIXaPq
         E4CjgHoWIek3PPxn0ksEZmbbR+RlRQOKU39dzxn9wZunhhHd0nqUqxamjrzvxFal4uZL
         6hAD1fpHeAzqyNUDA2enUDtK/VhmVtvqHAL9Ku3aMeuwELSilVzmpAYZa/Tu6nTs4q+3
         BxEaB6nSFaKJzJGG2jtUci1YNQeqMqjDpF7YnzS81cPa5lCbHJVjER6rSD0FOBhbSPGh
         jDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788792017; x=1789396817;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RuGYW3h9PJYNaiCjKHB/faSczvFn9W4fzqCSPNsruxY=;
        b=IwLWjaqnHuscjASw/YKIEzNq9DfLnxT2G7wLMw+OCzdylFRpNxDpeOA2opzUO3tPOA
         Ua6rt/BEigQxkwfrTUCtEFJkvR6efZr9vJ5zgedgPTak1lrPAZTIqiiCaYUjaf/XDG7H
         QfmYVZu06Z7YaWS9pMIow9PeLuqMHWhO4Lz8VpVcTcjq+oQt74PVjLf4/vi/hqATEpgG
         yBx83MEYp3ONeSrfDwDv1cLBn5052jwYPpNos832xu+iSlcqb694VCcYz6Axu/jp+CwO
         cBGxKLzm4TNAK7RjyrN2v7wLXY1uGBRkAzyxdERsRBPensTlmwDlXG4Yr5oy2OvIPiH4
         Od3g==
X-Forwarded-Encrypted: i=1; AKwUvBxhEkEIrszn+DUrxqbPVd9BbN3LhBKF0mkgDJFG1k+oxyVC0mUBwuAee3TJp+dldbgbIlxEu8qp@vger.kernel.org
X-Gm-Message-State: AFuF++m2JZIXEK9nediP2NnDznxtVsk9TnjCkrYSjNY3Ti/NnoHPbt4d
	iAFs+PP0AZ1Z+w7tYraQ7ez9FKy0UyL+Mbw15ggZp/cfb9LELLxWGT5r
X-Gm-Gg: AYBFou1VWy2B8zTWYD5XjC80PQaZbK9Fymk7ole6Di0eOTmW4QqHH5wfzxVvAMFVWBF
	qlZk+QfQ4VCDAgWBgjKRBnQrF4qzmCumcu3ulv7EdTvGfWJT38pG2yqxLvjCso2EQ/F/YnCoNc7
	RB2II0nscnVNYRdVQ3YqAaR/BJNfayBcftm7Z/kSQ8Pwa56w7NbHMMPMYzLRo6QnsZnNGaf4/sm
	1UHdQneBJ3wTobaGYSvxrPI10b3f7fYdTII9t3cuRp0LaJ2pBY2eB/hyMPWBRPIy9McyUu8FFOt
	pEJLRO07d/3XPNHjHt1PmCZ8hD1Q89C8ODxau0V42QR4QX3KKXlyIGkEwM3qujV11rvY0fOXFqq
	LKworTt2+XcmRCTMe0YSwlTqENE+JKXTOZlzrWR53JjyBO7fU9R9rLndxJCsHK9d1rF5mjlwjx2
	3pZnvqY+wpRUPfBFjVcAIzMw5CSe8QM0+0xny5gjluLkm5ensq285qQ/GNZqcgSGb7qJS7ER8=
X-Received: by 2002:a05:6402:3706:b0:6a6:7818:b18 with SMTP id 4fb4d7f45d1cf-6a7e90a9981mr8187671a12.22.1788792016878;
        Mon, 07 Sep 2026 07:40:16 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20a41sm4438279a12.31.2026.09.07.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:40:16 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10/5.15/6.1 0/2] selinux: reject an unclaimed class value in security_get_classes()
Date: Mon,  7 Sep 2026 17:39:53 +0300
Message-ID: <20260907144009.162239-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Backport fix for CVE-2026-80912.

Bryam Vargas (1):
  selinux: reject an unclaimed class value in security_get_classes()

Christian Göttsche (1):
  selinux: avoid implicit conversions in services code

 security/selinux/include/security.h |  4 +--
 security/selinux/selinuxfs.c        |  7 +++--
 security/selinux/ss/services.c      | 45 +++++++++++++++++++----------
 3 files changed, 36 insertions(+), 20 deletions(-)

-- 
2.43.0

