Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2AE55C
	for <selinux@vger.kernel.org>; Mon, 26 Jan 2026 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393968; cv=none; b=pDznegdIuLUfDlKZAo14hIzB46MHQISH4Vm94GncxYnIR7OlExPzDMw6x18cDuUGWV5F5UqQ4Fj/hrmQx/ZPPB3t4IyFE0p+Ny7T/nyVM0xmIxIMqvWPp9XPfv71Oni+fXZG+E97vyfUTY5U5cCUJTcKB3z7ZRnkgSM/geiqBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393968; c=relaxed/simple;
	bh=MlRmfdc9GbMqCdrVyiUE6KVf/C09y/ODN9WkQShT1cA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bkHrvoDhOC/1/2i8IAAYL+wQ/2ecTL6feO34K7mAV6N/8IA1o8vuAP8covOtDATZ3NnS1s6dax6JnAGGTW4KAx3YxgO1/Os67kmRtJbknbh07yhwcjn3ylVqCAPpUKuawAeNRmXJ2e3P+KiLHBhXdW0bWBEuGP0dduv4WahaUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b=iRo4ibRs; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b="iRo4ibRs"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b740872a01so5462210eec.1
        for <selinux@vger.kernel.org>; Sun, 25 Jan 2026 18:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20230601.gappssmtp.com; s=20230601; t=1769393963; x=1769998763; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlRmfdc9GbMqCdrVyiUE6KVf/C09y/ODN9WkQShT1cA=;
        b=iRo4ibRs5OuC70n/OeCG/fkp7aS8EgEOc7c7mjUdP2TTpvctq7J5kt+M4+pEWnKcoL
         nfL7p/WHfbguo90ERq1CHhDhjsrvLj+AX+9fYAOKODwgaicqjHmMDL2rgQHNDXfd5M/v
         XpZTqVtaZv/WtBJcNZex4Cy6nhgDGjbAfiqYN0LkzoqLpAIMs1ut/OWqlwZg6TR5CMuM
         v3/s7CGga9rV4HWOlI+1wKvsKqSiuYkld8KRx/7GfS/h/OQBGxcnV1NYGxvyn1wQKItK
         +tDZrM2KxIAAfZsol/GOtDn4OwRL1RQlieM4Pbqyb9fssgRmRznOAV0Farjwai3jYsWk
         9+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769393963; x=1769998763;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlRmfdc9GbMqCdrVyiUE6KVf/C09y/ODN9WkQShT1cA=;
        b=I/HQQnp8+tfS493kBwzATOFNysa7EAfm+//z8+T6zWZ2mxKnypSZVY77CPhg5o0UuL
         LHSyxWM0n03RgjJoMyKYOT5s3H5VgUtTyvpmLWCnuKC0Mgfod6ZB1eBLBQhgXCzq3g4o
         rJPQvGLrUsPbwAIwo+9IV2TlA4A36Akj8k8/0KcjPkJUYouou2PBw0Ve3BixSxoxRNoy
         4Z5m46zdMWQ/asAqNrrVQcc7c/OzY+amY30pEUkDg3nEGGCaW3gFaHFyLE+70g8OsL/B
         R9kVy5YvvgC2RSKlx5PH9F/j6VmvY3Rge0WlKg3105gm3fibLdfWw1/xIAXbdNglw1fY
         07nw==
X-Gm-Message-State: AOJu0Yxl1f2+Q3bOrIZn+yMdyMzhErNmGwIVAjFh7vJa4iDg7t6LJaHn
	LqMjRxDXdotq3PLWBxGQI+zoeTGFZ+USX7wrk5p1EllUD6vbPxg7HSw5nYO+j/hs9HZTWoLa1tK
	FWGGg
X-Gm-Gg: AZuq6aJIRJapqamlvPRs3872f2GN7UJRBeSGt59PsmB6hd0q5iiBcLGNxUZ9jwrPTp7
	Eiqt2uQ0ztxo2DjSKkcKXUXrsudt5NIEUw4OjCyrGGuzTmSaVbQZRcNiXuZpqUqO8ox7fMmRN3C
	5bRpLtb0zLjKViQ6R8z9viQZIR3cOh+ZTidr+SQ7pXDD7XyJ63wudYhkSxYTHizT7ID9WSAolwR
	vTwAGdGaJ7ZY05YcVHtGgE1XwP/JT8bHLBXNPWbSZAsZGPN+RLEINlDOODU/qodGg3x6SX+ng+P
	Wy4SW/woNK0G6bDYPbfO0IsNuO3C0ZnlaErs4X9EIgTJof2NIgBVaM7bw3mNDnPfDsl4LanRGG+
	f2/j/hqBBgE5e67sKAhCMkPPaZL2BNIlPnKYHsJpSsMd5b3apF+wxQiukw9KEEIaAJyqhRvuwjr
	fl6Wb9SyrUEIGn2jJJCWVMV3L+jaRQvS7d8jPhpd+9tjnjgWk=
X-Received: by 2002:a05:7301:1293:b0:2b6:f0fc:8c47 with SMTP id 5a478bee46e88-2b7643457a1mr1053609eec.16.1769393963372;
        Sun, 25 Jan 2026 18:19:23 -0800 (PST)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b73a9e1ad3sm11394603eec.19.2026.01.25.18.19.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:19:23 -0800 (PST)
Date: Sun, 25 Jan 2026 18:19:22 -0800
From: Jason Zaman <jason@perfinion.com>
To: selinux@vger.kernel.org
Subject: SELinux userspace release 3.10-rc2
Message-ID: <aXbPKpbIXh7_fpTM@anduin.perfinion.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All,

I just released 3.10-rc2 to github: https://github.com/SELinuxProject/selinux/releases/tag/3.10-rc2

Release notes are below, please send mail to me/the list if there are
any issues found.

With Kind Regards,
Jason Zaman

RELEASE 3.10-rc2
================

User-visible changes since 3.10-rc1
------------------------------

* sandbox/seunshare: Replace system() with execv() to prevent shell injection

* libsepol: Tighten checks on MLS range and level when validating

* libsepol: Fix potential NULL dereference in policydb_read()

* libsepol: Fix potential use of an uninitialized value in link.c


RELEASE 3.10-rc1
================

User-visible changes since 3.9
------------------------------

* libsepol: fix TARGET and LIBSO on Darwin

* secilc: use correct long option name for -X

* Fix problem with bounds statements in optional blocks

* libsepol: Fix processing of levels for user rule in an optional block

* libsepol: Fix problem with handling type attributes in role-types rule

* libsepol: Fix expand_role_attributes_in_attributes()

* Allow type attributes to be associated with other type attributes

* libsepol: Support functionfs_seclabel policycap

* improve semanage man pages: Add examples for -r RANGE flag usage

* libselinux: fix parsing of the enforcing kernel cmdline parameter

* seunshare: always use translations when printing

* treewide: add .clang-format configuration file

* setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC

* libsepol: add memfd_class capability

* semanage: Reset active value when deleting boolean customizations

* python/sepolicy: Add support for DNF5

* Bug fixes

