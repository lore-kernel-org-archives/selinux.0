Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693418C06
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749150209; cv=none; b=ShE+vaim1UqAhSnAiZDG97LvpbM5ruGq2Z+4iLLwIGi7IB4qgHxjU3kiho3OpRUR4bb/j2SgKMCvEphnPLaTkp+64AymEiTvsfQ7DUusiNo8Bw3VH66JDimwFP6veh1FrgYmRlWro8FipXPkYeHTPbko71q1WBUPccoIk3mieks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749150209; c=relaxed/simple;
	bh=jF2GxeDfCmtOKwk0s6YQuGOlAbmau0ufchEO5co6sq8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=u2NENtx6Jyu2OIAa/jGnOtgSD5mhlFSfwoalot5ie110iIqzAUwk+UFKh54syjWoPuTqomdX00wVBJ10Na9KRW/MHerIxPKUtuDFwGxlL9zI41qpfjCcu5t2+XfjH5EPY3woTciFvP7wegNU3SN/8atDHDrRoO2yJmZawxzutQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqn1peSg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqn1peSg"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-747e41d5469so1573307b3a.3
        for <selinux@vger.kernel.org>; Thu, 05 Jun 2025 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749150207; x=1749755007; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jF2GxeDfCmtOKwk0s6YQuGOlAbmau0ufchEO5co6sq8=;
        b=Wqn1peSgYLqywgHh977yCV8kcmHYA48hTg1QG+xuAN1pDhegsyze7dYopXKFJsVl6Y
         x4DmfRMpQboyP6vh1zKBrK2ACHOCT2urla7ln43VJad0roe6yAfeArOysjYwIur4U7f+
         biKgvA+f1zf1i56DvP4mMV8/iRPWWu3krS4Pk5F7P0Qh3LiaVkh1R/BxPPgozmKD/eCT
         pr0Wd78rjx9rmXjjwj8PWWpChjCoj+lYBY0rk+v5Dj7heUUFD3jQlNY4msDwTEi+2WSS
         buduQa4xPEWo6lAviN1DdOsymNimy5q91qYUttcSPk4nCs42casNZJTx9qM7FPaEhQ0y
         /nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749150207; x=1749755007;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jF2GxeDfCmtOKwk0s6YQuGOlAbmau0ufchEO5co6sq8=;
        b=ECNS9n8gCl3NicQFZ7o5SB4lSxZL8p8bOurTSTNlFHoPYOKh3/6XUby02PD/stq7Ze
         89u7yDcoflX/wOcQvZxg6QPsEfb3OUOZnG78S4UCdfy6I87PQMYB0igD1da0nz53kvvX
         koVh7ezY9wSD5POQDt6Z3MBnHKmo4TwlMwVr6zdU551f+939HeuGULG2nwdgiWycfe7w
         ewBWQa71xql1HUlX02B9uMFyZNli/X2RTaSiO2x3JWkCJdjaBmliIigW83ohofZvPjak
         2W9PvXEVtUOAPJoH/ssLDZt5T++wTPGwg3/tVfnovme1Ig4grzD21NBodr9lf3epj0ut
         MrwQ==
X-Gm-Message-State: AOJu0YzCOs1hi+t0a8o6wqCKhATpk/Uti7qYDjNx1hwwW2Ry9fkEXRJu
	SLq4J5a63bUU4qa0vGh20a8okK2+W9Rtz0oRDeJhcXBOgIsghs3QRouEKX0dzqPPmcQ1+Mo6EXX
	j2C5sCVFRFiC8Zks/fmRw345eGGhPxCK4Zw==
X-Gm-Gg: ASbGnctfLn0K1jx4LKn8e/LHWlI1PGqmHR9D3m+vt1WKpn1EYQ9GKt/7G5IQQHXfncI
	htlysF4kk9mTzAaqNZerwPsZvv55XesjqlyUODKdxpNmOnqpt+3NbJAivvuuUzjBzPhRdhgiyjv
	r36WyBCfCAi2PsTm8F2LnRw2XxUltbMQZWeyx/LYWD/b4=
X-Google-Smtp-Source: AGHT+IHPcBa20SkbKdMDbVWWqWo5bMsM3OhVJNPilxgOUcF3MrXIeqGTHL53GiYGMzJyqlU40GpmF9hmvuo8uFFQRZ0=
X-Received: by 2002:a05:6a00:4f82:b0:740:6fa3:e429 with SMTP id
 d2e1a72fcca58-74827e9cbc2mr1030779b3a.11.1749150207530; Thu, 05 Jun 2025
 12:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 5 Jun 2025 15:03:15 -0400
X-Gm-Features: AX0GCFvaVTI_MsbPi1cX_AdwWr7q7Z87Ms6beqZeQX6pmKg7H5XKMtNGL8ho0bo
Message-ID: <CAEjxPJ6P6oH4nUMwhFs=ctDekm3CHVtGgp+gx0QCjxZz5d4TCA@mail.gmail.com>
Subject: selinux userspace wiki
To: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Since I created a Getting Started guide under the selinux-kernel wiki
[1], I also did some refreshing of the selinux userspace wiki [2],
moved the Presentations and Papers sections from the kernel wiki to
the latter, and cross-linked them for easy discovery. However, I had a
few questions about the selinux userspace wiki:

1. The Home page and the Userspace Packages page are at least partly
redundant in their content, and the actual list of userspace packages
modified for SELinux was very out of date (I added a note to that
effect and how to query for a more current/accurate set). Should we
drop one or the other or somehow combine them?

2. The Tools page is likewise quite out of date. Do we want to refresh
it (and if so, does anyone want to do so), or drop it?
