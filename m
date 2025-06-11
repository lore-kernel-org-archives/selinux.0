Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7851F91C8
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660365; cv=none; b=YRKLuF5/fsn0JFo/kQWUdkXG+wjhYD9gNxP+Q1Kffjg8kT9aLTvO/XJFyyNFtvD3R9FlhNw+KrBINgupRFLJoP5VBzgGTHk/4o9XYa0l2r/5x7T93n2faxB8ngNOp6xsjzKC7eVJyD/blYDu9FdaIpPiCBxyiFArAjd7MhW2A14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660365; c=relaxed/simple;
	bh=pkKDuG9F/PO5bN+P64pH0veJmNFk2QULxXE5Xm59Gdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=s13JRoh6HsVrMurR2zxjS2WnWlO1e6udKIkqWRTIRnge0x2Atl8BJE6+HoF+qjAK5rgtBYyWUR4eLNkJ5SJM9DfMtMDWFDGViAh1UM3XTBm8detWsBqLdrKAqQ0KkORQW0WvLkQUajsJzYIjtD6VzWdioEssOXLgQ7bVb060vkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZxFMm41y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZxFMm41y"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e447507a0so55444147b3.0
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749660363; x=1750265163; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdrGmLlMp+++NJB2hEUw9p0lUJTgbbNuI91dUhP6v5A=;
        b=ZxFMm41yZo/q3JiTGh0wjF2QTMlXd2B6W/g4BwoJaz7qwlfR38Pk8K153z+dBQsawi
         4pOFBfVrnnrtRLT+Y/UKVsT5J4hx6p1OQ7HT2h2eqd2p/75OYkn3s+4dIVrqzxXOfxih
         BxU2zVAhkGQO9ZD+UYGjgfhbf8YBKvMJFBwexsC9LbjBVuMDc+xxn6UIloTIjZdcfpWc
         gddCzvs1830xWRpi1WYywEVOe7fgsEgHBXgo8LEtpeHQGV3WY9qCSlrQHZzRt21aDsWf
         OzZDpHM1+iP8iXgTXyaIOt2IXokyhRipSiJfG+vgwJ2MnokH0/HymFNUO/j8H/VODkZe
         iElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749660363; x=1750265163;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdrGmLlMp+++NJB2hEUw9p0lUJTgbbNuI91dUhP6v5A=;
        b=vRArq6XIQGgQmUlrPul/e0BMhEOoJnreSsL82hFGWFVshfyeMmFEQgC92vK+Iah/S/
         QzVhMQFtpmksnyG0VzCUxhFBonhIYoCIkYxst/Dzck1cUiSsxChB143fNWXeQoJ1KyYY
         7TfpUKkJl2C5URz0aPMUY85uu0H+JHhFXWfVP07g969xRkSq41Z81hJv1NfzormAir0g
         hUAvKp63KCMVYda9M5/V0QwI+nuCDdqj6r3h4NKfU+uH57ycW6wJKH6Qec2hPJEmlDSX
         ujR4RroOeYq4bmC74j66TsbyHv6LAT6ElxOKlf/MxxBo0YMu+Is7xi2aeE7+gRckPxwP
         CNNw==
X-Forwarded-Encrypted: i=1; AJvYcCWzC3LN0hx6Bfx3/dIkaGm9A5oYFHssRSbVRwz2eRNNXRC4FWUDaVfm3Ubc3wBX7Wu+adYSEF9W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy295eTE402NZ5VZ7fsSi1iimG8WGQXOR5avkz4sPRbhR1LIfRS
	BCxSGHwuMboL85ZzlqAdfts4rBYo/Pyqo/tMP/vCMM7Lpli0Y6LoTkx/wm3yDaZG95CEagGCT73
	1xS4N3fDgDpjsm/EQjEdHqwpgGenp8fAYNfc9fbUK
X-Gm-Gg: ASbGncvw19iSCYF9vyuFyAMSlwJBqjeMpGZrxosaxuAl3iMXNd6Xn9gHc0E9S7vdVOf
	sdYl4faxfCWXsi9b1W0RCHlrd3QvDd6b5XPmpbCKDM+nRXuLbcc92BFG5W8+jwew3NWpvrfzHgk
	2sF4Nyo5KvuIvg4yzNOho3Ntxtq2Jm9CSrj2uNkaMBk5c=
X-Google-Smtp-Source: AGHT+IGws3htnGlVgU/+WackH+riDIx4X4Dxb0tU4FsO2xWxOUo6VoUcfsGOrhSHZQpu9DbYXPbHdLoCiR2XufjouQw=
X-Received: by 2002:a05:690c:d07:b0:702:52af:7168 with SMTP id
 00721157ae682-7114ec4e044mr7273347b3.2.1749660363121; Wed, 11 Jun 2025
 09:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhS9P-fgWac_sJ_dq6_AQf76RGiqLAmOFnR_4NZ83KQogw@mail.gmail.com>
In-Reply-To: <CAHC9VhS9P-fgWac_sJ_dq6_AQf76RGiqLAmOFnR_4NZ83KQogw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 12:45:52 -0400
X-Gm-Features: AX0GCFto4vJQW4gjqUVGKEc-i0EmSC5qmILck03v-0mF7PLhHzpPBHr4oZKoFWo
Message-ID: <CAHC9VhSae4Vhypwr+hkAvddQ5_DQ90-jaS+pWPqJwPjk_dzMZg@mail.gmail.com>
Subject: Re: ANN: LSM and SELinux trees to rebase to v6.16-rc2 next week
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 12:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Hi all,
>
> In order to pickup an xattr fix, link below, in the LSM and SELinux
> trees, I'll be rebasing the lsm/dev and selinux/dev trees next week
> once v6.16-rc2 is released.  Currently each tree only has one trivial
> patch in their respective dev branches so the rebase is expected to be
> trivial.

... here is the link I forgot to include:

https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.work@=
gmail.com/

--=20
paul-moore.com
