Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9D7D07D
	for <selinux@vger.kernel.org>; Fri, 16 May 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410192; cv=none; b=HIH67zV8z5qZEftc1jNfv+gPDqzDMnos56PFk2IkMTStLe/C0eHFdWrfPJ1wnAlbZgtlTbYvF7Ltgs2Bv3l4BsLrKn5nJSBCr+1SrVRWQ2Kyt52dcnBx/0K7GMoaD91V3QY3XwEZq0ur4fcuDZnZ3apdTM88c1C0VJT1qi6vuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410192; c=relaxed/simple;
	bh=VxndhmGqDUd0Bg7xVucdtlXnkoxJbJ1j4BGZD+nkzcw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=W54DPE6WDlzsZANKopH74lrEs4PnjIuY1rEMahv3j1hrPGUpySSzWSWxlqCfKL+lTYD2/llru51oZyN52Pj5WnxWUYFJtrgd/9GRtXL13rw/a7qwm/ZZJHRhzluNnFx81UIQWdEPFFMKOMAoho1QyoDvmOnB/Y2Seb/J+z2oSUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NQe6z6Jj; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NQe6z6Jj"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7086dcab64bso21533787b3.1
        for <selinux@vger.kernel.org>; Fri, 16 May 2025 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747410189; x=1748014989; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+BYSKqWmEBLkgf7CL5SWr/yl8vFwEdx2PW2W19+lttI=;
        b=NQe6z6JjdYSgD73+dz5/aPzF88/Hw/EduCIny2kVOcMeu1Ce+e3PZZoSgALxDZJu0Y
         8MI8oJDchDaH0W+JL59F3xyiyeySoGtYypx91ts8Bvv1GXpqYqP5KRGmBEde4Pjvwer5
         Zz0ugD/BztcsJ1zXe+azJiZcYOlLAAmIDBDuEkgQw3FJQkxQb47wNM3xteLnY96+ZgJN
         qmxh2WFXcOjKP1NUsRKpjfMrFf4zOn6TUNMSZHDoCKjbporNaA8mjZdhaH/aw6UapNO+
         Zx7QKyR+dO7zBsZcOHjATkv1zMx1glaSDpPuEG8r2nzDvoOh0al3zhtLHqBA0Qs5Kjaj
         Q/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747410189; x=1748014989;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+BYSKqWmEBLkgf7CL5SWr/yl8vFwEdx2PW2W19+lttI=;
        b=edA+b5bBosaW44xszDep4CSkI/AX7K6dlHaGTjM6hKvDZc02GysBmQVw19f51ISnsc
         DUiKfRi8p/wImnul7WbmLn1XpS/LBhpgFVOGlzcYk3OHyYX69zZ4TJ8rIzCry8wH7pgs
         3nQ9z5sm36dPz/E+rWVPokUxAvaN+wfc1couCFezhZtn6HjKEC3v2r3oIwehgB8z54PA
         PJTJLG2euzHbowMaFrkdYwFB8bvyFEFegRslvzzgjaBWZ2MAR/as798+lzcVqkKgrn1A
         Qs1sXqRLp8UI9e1mfba1evtIAAeGUn1a7g1PxyoTGLa9E813CY6PRhV+8k2a0MOcjoCU
         R/7A==
X-Gm-Message-State: AOJu0Ywiwq6Cl4LF+5ZvbwQeFu6INvAzzMRZDIqlv+D7ogJEls/Nrrng
	CgKpIhjY5XQRerEmjweutnTMBlb9zKMCIJ33W/5s2LPleXE8YZRpXScKDKsqRAToFMlml3HcW4/
	YwqoO0L1oFvadOx4Rrx79HuKQgU5rXWttkMbRr8Wt++d2//8GFcHR1w==
X-Gm-Gg: ASbGncsMNfhaOTShSYDg6daVwLNsfV19I0JglEUruRtMOvmrAyE9tbmZ850kFYzep1L
	DeRESe4LWopElZ6+VL/ISve1gcGWZX0Gj+Pqiqsw0ep8pb01BdQkI1dcLyaXaJ1ELeyo6Axooj1
	XS+vGQX1HVm2fz2WzaogkDXhc5mQr+CFx+
X-Google-Smtp-Source: AGHT+IEzIHlU0qdyF26p9nWcqbO0kK+7Bf1Oht2q2vt4zVC/d3ChNojqpwWsA1ayG2Ocf1HjFcj88FN4GNtqosOsF6A=
X-Received: by 2002:a05:690c:414a:b0:70c:b7d5:afeb with SMTP id
 00721157ae682-70cb7d5b004mr4685297b3.20.1747410189135; Fri, 16 May 2025
 08:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 16 May 2025 11:42:58 -0400
X-Gm-Features: AX0GCFusfb9G7CgC8T6Rn-na4tDdVCZMQiUwgCsyKina2rT00s4_vmtqOQQb4BE
Message-ID: <CAHC9VhT4wrN6ProQmhv1pgF_TSPWOhbSf1WRi3Cm0_M0nu6x+Q@mail.gmail.com>
Subject: Recent selinux-testsuite failures in tests/mmap:109 (execheap/execmem)
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Between Wednesday and Thursday this week I've started to see mmap test
failures in the selinux-testsuite, specifically in the
execheap/execmem tests, tests/mmap line 109.  From a kernel
perspective, their were only 42 non-merge commits between those two
builds (via 'git log --oneline --no-merges 9f35e33144ae..088d
13246a46') and only one that looks like it might be somewhat relevant:
11854fe263eb (" binfmt_elf: Move brk for static PIE even if ASLR
disabled").  However, going back to re-test Wednesday's working kernel
on the current Rawhide userspace, it appears that Wednesday's kernel
build is now failing, making me believe there was some userspace or
policy change in Rawhide which is causing this issue.

Are the Fedora folks aware of any Rawhide changes which might have caused this?

-- 
paul-moore.com
