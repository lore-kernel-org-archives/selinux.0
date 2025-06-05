Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3F18C06
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749150318; cv=none; b=YEv3smGtrFVicgt9hxLSkq/duTcUJvOLnF8bTBverPcl+5iB7RkCfKFCFz7dv7NQUFbIlKOKpV6BSjcHtaznT5Rrp9Ynuaf3pWddMqBrosg9HzBh9eZtISlaraMgkTu6dGFay1wlrbBpcMIpYER1A1mJxYx2l0jqv9e4lgZwYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749150318; c=relaxed/simple;
	bh=FIkQOoxO8pjALBDWGu2RzM6BwHFdTioaLOoM2vcEnnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ePio48yedvAowWip54IViBZ6DXVCRh+/bpiSkvusemCp4icbS4qrthBes8dBlv5jUJwyGbCW94A4+CDKGgccyGgcjnqrHaOObaRt1b8EwE6MWW0MIcU3m5vkCWP1NMdwhRD5f9beiBqpF4sx0GPvAlWGjK34Do31g/iAtgwW3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZSToYxW; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZSToYxW"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2f0faeb994so1367197a12.0
        for <selinux@vger.kernel.org>; Thu, 05 Jun 2025 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749150314; x=1749755114; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIkQOoxO8pjALBDWGu2RzM6BwHFdTioaLOoM2vcEnnQ=;
        b=SZSToYxW6wrSA5ZfbslbvZTuyYT5vVDcEMjXlzhKP64mu37dDP2LSP+v/pT1d/VNA+
         HJR4RbOz1mUp816e2fpJ2f851rexQ9nrlvqHHkqxIE0EH4tM4I/odx+Hs+EiSVxazM2w
         ZYdFMbEF31xSBGQzVW0UI/s7rl4fO2ERp9B2RtC6qmFfMYs8qVWSdotFDsY7durQ+pjS
         d+S5P5pL4BlcFLeEbmuYOfo6PVRgLGm20u3UNgNLSsKWEpKTNN2a+Eg0CGAc1MBb2nYm
         SloKCTmLl11Xc2mZOkB772IFJYsAn3I3mmbAwhdveZ4fE+XeBzYOkPv6anuWg6pN1ebM
         bIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749150314; x=1749755114;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIkQOoxO8pjALBDWGu2RzM6BwHFdTioaLOoM2vcEnnQ=;
        b=d5W76WsWshFbETJKWuQBP0h+gZVupzYZaz+2p2uMWUYbGshKrL1rF8w0N/jAHWJZGU
         S5iL2gsSReHol/fu084XJpSGKqzrhr4AQjQSB7ul7voTCUvLRKQAMJ1V+PFCWh+WVmpI
         UUti49tNy7FgqrboU8gv+Gq0S9pnJvyxABNcwCkL0Ne74/TQUGiQCUoD+904xruMG9zS
         v8PHJ1BaTsWUAM52h/7Eiu+mTPu+eAmEMd2SWDqZub0Eq0Wwo/7QtPWhl+EWwL5UoLEN
         l78NQi6ROyy8ubpoCbdnX9sABAt/m4aQG7L6hxaU7HrSI9KFjNRl6jeXQa3dF7KDI6Pn
         ieGw==
X-Gm-Message-State: AOJu0YwMmq5lVD3mdkR3y+RzbcZyI5VS+IKHclzJITY1eIabgNAZrNJt
	NG5WmONbjhG9UWEssKF2eme+N6Wy9TYbu2/7744tGMxD0x9DGIWxOpD5fQCWzFpCAKLN6L9XCRB
	/4dsxwau9u1YN3vbC4tIv8RwtD+gtYjrSon4x
X-Gm-Gg: ASbGncu36IJqZm1qHAEWYaIla/BuTElhDzWMRApJv8m8rNetaBSO4Lg1De7Wlc5MfLl
	YurLz5NW71zYsrMd0IqwtlrNEUm7tJjkkrXSo0QxatyjblkOaZBs2kQDaRkZF5SE3aK0grJrFpt
	knel8zyt0tm/GHAFBZCivsdh3EumnC3EY3duDDU+gfkrBje+zpivas1A==
X-Google-Smtp-Source: AGHT+IG+SOV5zGwirNBHmsaQ3k9bg009XyBvpnV6rUuuBSJ4li111FK/sfc1831VbjnAssrAwe2q2hLHXTiPudvl/cI=
X-Received: by 2002:a17:90b:510e:b0:30e:8c5d:8e4 with SMTP id
 98e67ed59e1d1-31347405a40mr1317507a91.16.1749150313698; Thu, 05 Jun 2025
 12:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6P6oH4nUMwhFs=ctDekm3CHVtGgp+gx0QCjxZz5d4TCA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6P6oH4nUMwhFs=ctDekm3CHVtGgp+gx0QCjxZz5d4TCA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 5 Jun 2025 15:05:02 -0400
X-Gm-Features: AX0GCFtGDw8D8XsYELGMC-rr7BWDg6CYk1Y9euSeZm0bU5gI6TMcU3deYwVjREc
Message-ID: <CAEjxPJ7RbPCdJsO=CeRSisa+1=eLNOSkVWByGb2sdF1VUCLCCw@mail.gmail.com>
Subject: Re: selinux userspace wiki
To: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 3:03=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Since I created a Getting Started guide under the selinux-kernel wiki
> [1], I also did some refreshing of the selinux userspace wiki [2],
> moved the Presentations and Papers sections from the kernel wiki to
> the latter, and cross-linked them for easy discovery. However, I had a
> few questions about the selinux userspace wiki:
>
> 1. The Home page and the Userspace Packages page are at least partly
> redundant in their content, and the actual list of userspace packages
> modified for SELinux was very out of date (I added a note to that
> effect and how to query for a more current/accurate set). Should we
> drop one or the other or somehow combine them?
>
> 2. The Tools page is likewise quite out of date. Do we want to refresh
> it (and if so, does anyone want to do so), or drop it?

Sorry, forgot to include the links:

[1] https://github.com/selinuxproject/selinux-kernel/wiki
[2] https://github.com/SELinuxProject/selinux/wiki
