Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871331C9DC6
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624463; cv=none; b=dYm+G5UUtGkK61bJGy24FTFtNma3pVz6w9l371hQqCKhLSTMn49HyzjGxQSfPRy8RMyMuAM3kz4hpDiWbfVMUC+1qA8UvH/nUpChq67EyTlxajCYM5wyLCRy1DZUqmBTgVSrqWgkL632VqFX9mQ376J5QW5H5VfUnFWlYaDJ0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624463; c=relaxed/simple;
	bh=//1CpTxAYNvTDgaSCqn2f07Dswj7PehYDuhlNai42U0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qSARqa3pw221kNqnU4szLv3lS/n8lUYqnwsdQyV5zg7YeOVnuzJUzL/4m3zMmG397tfce+iRxjN/TeGq3C9tGZzo/QP3EPaagc2vqeF4BpQMPc4fRE7xgm8DU8Jo5Mj42hWtfLGUUfAMK2gD2Lc/0D72UFEi/1UqJnl8gr2Os/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CONkqHjk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CONkqHjk"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so4290402b3a.0
        for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729624462; x=1730229262; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=//1CpTxAYNvTDgaSCqn2f07Dswj7PehYDuhlNai42U0=;
        b=CONkqHjkGxe97d7DlsOeHkvqQ5l/Mol0OujOs78DUMCf7PVLAoygQojYmgJs6bLvHT
         hKJSHGs61HAmkFSmjVesb+6tm7McLepvCExNZtH3xM5I6wXj/H4I6NoQ0tOQglQnfPdL
         BTlVrYzb4m46YJFnR+e2q2G7zfaZun9AtnzExo6nXe8G0uA6iQ/1fTyTs/YqY6gJC1dt
         cHsUeEk4wKeWpVhnCukYJXqINylosPVCpgeonxmuWelnlmTv5UqADenrmDX43rcF/MC/
         yg9ml2aN0pSjLHLBlty9HJA+PPP7zN2fSHWkWEIfHBqVT6HtQ0iNe32GZ6tV9GpRgyDY
         rVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729624462; x=1730229262;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//1CpTxAYNvTDgaSCqn2f07Dswj7PehYDuhlNai42U0=;
        b=CtZy+Q1XYOrp5C/omagOOdgHY0PBqDD+LRIyNIXsfW+HhgX9YwMd6iiQLD4mRUKkEX
         PeqID99McFfxy0D3+ZG2xw7yK7YoCvCoEQn6VrWxkxeDm7PESWJd0FRMOXErtKlB4H/A
         Bpr8ocAfQ7tnTXrpKxinLOojvHtleOWm73OKdSQ83VGR3uesxwXgYyJcVc0fpafl5q91
         Xud/IeakJwnOXKreeSkiIl1W+WK1JlPQBoexgq+xiyAa7cDn0Os0VPcPnCI07Uxk+qx+
         neh/fbVMaujcLIGfRvyMg7H4+l0hnWor4c8M4HOUhC9SJGIt6DLGJtcP6P50PT8kQ6Li
         8bFg==
X-Forwarded-Encrypted: i=1; AJvYcCVnC9oBsMn4WX+FRvQcP2lsaCdFf49J0Qjx6AF31nbKiXa7ZE7i4iA3MsID+RaQwG8Y8TQQv97a@vger.kernel.org
X-Gm-Message-State: AOJu0YxVb68Y1fWqyiNNHnL2zGdX6rPjmRzzUwEoZYiOXLE/Jk+xh5T7
	DkDhCD4nFKgdlcVfR7eB/h8VOgebR2ix6NqmeelfzgUXL+aWOrnEPg5KzlykaXPRW/UvLODqVZ4
	i9QOpUfaP/SIMvuQAvZR+1oG85Vg=
X-Google-Smtp-Source: AGHT+IEoQMbahAA/S8GWgxgm6hBwJw599yJUXq1bXpHkPiytH/C/2Oc3pPMpRqS6UcaArvL6pqU4bGCk6JfUCXLWUII=
X-Received: by 2002:a05:6a00:852:b0:71e:3b8f:926 with SMTP id
 d2e1a72fcca58-72030b677bcmr407164b3a.22.1729624461679; Tue, 22 Oct 2024
 12:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Oct 2024 15:14:10 -0400
Message-ID: <CAEjxPJ7JTbEk-=r=Lnjm8MFC1VRn49wWjLUKsfSk=eAryt6S6A@mail.gmail.com>
Subject: testsuite astyle options no longer supported
To: Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

tools/check-syntax in the testsuite is calling astyle with options
that seemingly don't exist anymore on my shiny new F41. The end result
is that it will generate a diff deleting any C file from the
testsuite.

Invalid Artistic Style options:
indent-preprocessor
max-instatement-indent=80
