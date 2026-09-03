Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB984BA9E3
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445805; cv=none; b=r3QRanYZpr5H30UKwm1/scaYGoZW+4BHDJUq0pKIQK14uu2BQs796UsBjCd/zka1Caeu6sgN0sTOEJyVcEAD7rdYstZKGDRTykNvm/Re7KHeXNJ3LIZyAQNtrR4PoCCPo3p6IQ2LsXeyQRNVlONrYchd0ilBfjPd6CuTB8tAfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445805; c=relaxed/simple;
	bh=477CFSHZ6R3hMYgI1pWSyWLx2QSberMQvkwqCRU4bTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCbvYUdk/G6VdHFQ+Ryaumb0wg3LKvtDkxIztf75j/TgSOpHt5IOsehtmtdNeASAwa2iaIW3OjGEIth1eBluMpZ5mmpHPdzGSeySm192WIzxeob1Nflfqja19KF1XfXlpXG0MPNdcMC7iC2yHWV+853yMZsya2D7/DZ4mn2f5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ourc6WjB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ourc6WjB"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2a449c57so29911611cf.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788445790; x=1789050590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Am8zvnnxpm0dwiiMg6+jtMP6xfcmL3wbb6L2+VYL7S8=;
        b=ourc6WjBOfIkzmAC4Ia25A+siWmCZK36DSFYvBRdPMptDgrB069R2S0UJqMgLVdFfQ
         oldFcyrDqyC3DAY+fF/825A38BVnlHoHAZ8RGjD72wBosucXmbJHKt8D/WA7RIwKevhM
         2ZPRAfxlXti4fJFCCmg2eslcUp6mJgaEtrTDcTNsv+T05AwWYUAw6i8iSu+bOoGrxhR2
         i11kz9EZ0eGia/pj4KNQIOyZtpAsznAS5NDtxaLE5IJ2o6y9PfpoGWxGI4YywhVGGkvs
         95doBNHf3nxNWHaU5Pm7Tnfm/ek7anhK2mQRi/vO2bRB2KX7ZTbTHjuNW2eA7qcfbQXL
         0Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445790; x=1789050590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Am8zvnnxpm0dwiiMg6+jtMP6xfcmL3wbb6L2+VYL7S8=;
        b=iBti71HXquwZSeSPKy1h+DliH0ch81abh/a762IeJ02Gn9BPak1/7mWTXuXZGzpq9w
         oMd08oiA2p9ESFRUjNLTI0/p7qV15+5afAADPojiM5psKhWTOMEgB3GO8enB2gqGzArt
         g2NSgrXCRWqEmAg7LxEcKdQsNMwhtxZwHQlLOs5wbTJ5kxl9yC2C+lCdNVL7BsSdSdyl
         Ni6bf3bcyUdCYvXjZt2oA5mDhOrWFc7q52cV4ltEA/xolqgSkOn3S7DlVMVb1FSQOCbW
         I6LqUQKvoK49ZeMXoTyf/SDmbAx+FmH28pptnYItxh5q5o5Zw56ZhYZA4mYTMmxN8FnY
         fPPA==
X-Gm-Message-State: AFuF++mL/VL1kQgXF/jnMfskKRm6WBkeizGy2v5ny4ZPK/BcziK6na/t
	37r0KDv15k7CqnTg1hNA/Bx+hrkosoDdigdF0DYtCpgh4HOdBOVAKJlhEPJ1eA==
X-Gm-Gg: AYBFou0yVv206syRdwq6pkJaf3pyh4IF8vd0OcvELRVQsf1l9XMgonZeIG8AkpYRgRR
	xfU2Po8LUMJUsw42txrgbNBzjYEUbwfS6u+lEzYA4+HR2d+oLornzg8rx/MX3fWPrrmB5GVmjON
	ZqZwIEwPLrA8rF4lZCtNp89nhm8N2TsAYKfsILdlsd/TCOhmo8mCaopU7e3jav8fuFsSuyQJqDO
	auzO1fsnLbfVBoYm8Hvmk3o87RAIJmrYzJLG+jYFTKyBeWAsZgpwiYNPNz8fzQZx5hUIdE0MmFu
	PwVKiMVs2QkbZ22cnrbm6C3GFtUg9tfZ5aNw9NNqm/d+ZRdYNtm/xi7pHLG8xJti1Tm65mUtjzS
	ZSaGF9n5edA4fnJ6imlRtWLYXw8xBhhQkOXkHgGkbeIwwEoCjpt2oDWTwdQYpH7RNrc98ff1v9y
	7X8t/UCeNBK0DR80K0DnOQ7jolsnD2+wDMiVTaOrs1mg2U+pBeznqjpzFouo/MdYh1lRTZpeNQm
	zXiHhgkmdcK1d1n0pbQuwECPZOqZ9d+GBknydA9NV79t+J2MGcSMuEaJMmNkgODPfSGCy5MMGs=
X-Received: by 2002:a05:622a:5519:b0:52f:b1b6:a4aa with SMTP id d75a77b69052e-53036b4f3c5mr167223611cf.4.1788445789115;
        Thu, 03 Sep 2026 07:29:49 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530330282bfsm43110841cf.11.2026.09.03.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:29:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 0/4] libselinux: add a configuration-root search list
Date: Thu,  3 Sep 2026 10:25:56 -0400
Message-ID: <20260903142600.19723-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is the first half of addressing
https://github.com/SELinuxProject/selinux/issues/33

It adds a configuration-root search list to libselinux so that it
searches an ordered list of configuration roots for each configuration
file. The list can be overridden at build time via
-DSELINUXFALLBACKDIRS=.  There is no change in behavior as long as the
files are found in their default locations under /etc/selinux; the
fallbacks are only used when those files are missing, e.g. upon a
factory reset.

The second half of this series will address libsemanage but is not
necessary to merge this half.

v4 drops the /run/selinux directory from the default
configuration-root search list since it is not required to support
the stateless use case and it introduces a potential risk of
any domain that can write to var_run_t being able to inject files
that will be used by libselinux. Distros are still free to
add it back using -DSELINUXFALLBACKDIRS= but if you do so, be
sure to create and label /run/selinux appropriately.

Stephen Smalley (4):
  libselinux: add a configuration-root search list
  libselinux: search for the binary policy across configuration roots
  libselinux: fall back through configuration roots
  libselinux: search file_contexts files across configuration roots

 libselinux/src/booleans.c                     |   2 +-
 libselinux/src/get_context_list.c             |   6 +-
 libselinux/src/get_default_type.c             |   5 +-
 libselinux/src/init.c                         |  12 +-
 libselinux/src/is_customizable_type.c         |   2 +-
 libselinux/src/label_db.c                     |   2 +-
 libselinux/src/label_file.c                   |  49 ++++-
 libselinux/src/label_media.c                  |   2 +-
 libselinux/src/label_x.c                      |   2 +-
 libselinux/src/load_policy.c                  |  24 ++-
 libselinux/src/matchmediacon.c                |   2 +-
 .../src/selinux_check_securetty_context.c     |   2 +-
 libselinux/src/selinux_config.c               | 179 ++++++++++++++++--
 libselinux/src/selinux_internal.h             |  40 ++++
 libselinux/src/seusers.c                      |   4 +-
 15 files changed, 283 insertions(+), 50 deletions(-)

-- 
2.55.0

