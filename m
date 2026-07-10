Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977C8381AED
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710830; cv=none; b=N4ZceR/v1z1XJ3CSv8xQAREvdFOsmLOIrB9vWiiHCYpDqlKruDd6yTMeltQS/IsCfFakMh9IDYIVW1klf2PiXgdQV3FX5mTD6QSLuecLeUOkk/FEbERYy9BmAR1hHOLtlJXvXphJkFSFq4TWibEOrN/qTD6ZmFAqxhxhL2LnF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710830; c=relaxed/simple;
	bh=gp5NkkfHOKOY42boLo0KN2jRdtnFthUkxT2897JpfS0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Csz0vdOzYjf816slYnUqqVDzL540D4MUp+FV/EAohZfMny6NMiWbWbyVXvP8ehn6vm92UIpeIqGQu1OUZBLTOhjZVTiO0HBkXX7v8xuhHt59KAfR7FOcdCvhMcNdNLokFwLwxJMQ4j76SjfwhvvoIhTjmNAXvR5knIcalCdb7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cz5rKfxO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cz5rKfxO"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso9087616d6.3
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783710827; x=1784315627; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iXDRXNekMT4tXdDIG0nF5WvZq2x0snU5hB+K47GtRY=;
        b=cz5rKfxOWz6nJLOyjsj4xiMfeouEyzHltPLgAJ3SorqLMGT4lwM/ULJewDgzBJPIbZ
         cJMKdvtWv4dZPphChOQFRWm/4sBQVT/z+nCMyGQwcAknWnqB0BMSrW/mkeuz6A9ZXGJw
         zUg/NnjcLja/9lF6U0/aH/bkfn2W1K4xJbUFtDdeDdakmk+Dudhhs9MPJhXC1qyyovwJ
         BrNqOHVjr1DGKkawf9JLAXSa6mtPj7EPL0c6qiquXyUp6L/1z3cSHUzvSinDOb7IyGum
         acX12SWbr5FvYVkAeHo69cGNk7IRuv1NrM4W+WzfI2k6SxH3OLB2OWOj/bPoKGD4LXkb
         UsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710827; x=1784315627;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8iXDRXNekMT4tXdDIG0nF5WvZq2x0snU5hB+K47GtRY=;
        b=XWVI1kqEVaAYKUQ8MNJNguCc4h830TOf1LvJXxnEAgRAc3tFU2W/agMG0A8QsjlqLC
         aGE99XdNaosIbon+8LcaObVBdnjvHfSocIDX690nFE2uOvut7MNHiQHkXfBtBXD61oTz
         fa7NcQ5XXsfxSqMfSTwRnER4bajIQ8zjHOdZV7fbX7VX+ugBslhaokEbsYZH4yaCfFES
         eVxDWZDRk1L4y7mpkFZiwwvOk6jjttxxGs7M1tqw89s6VYbGq6J+w0DQmO8INmjdOqzD
         j/T6vpMVsvt4LUMDLwNT8SPWDO2kMkE1K6IdbAk7k0AKonqFJRZzxmvBHsG4voOY7MZm
         1v6A==
X-Gm-Message-State: AOJu0YwbN0guCOmsoqlCaVJTnMeYYxUU904PWXJFFWzQT65WcBKwZPnw
	/mxzH9JoYjuCAWzulzB7pqFkGQgIjtl95a85KzfRaOzTQVgkr1/26YFf7USuap8lEw==
X-Gm-Gg: AfdE7clk6+6xFl1hhAFRd/X5pyediok4Z1XNSQHJt8gZK7apG9XHArt9K8Umc4XeU8C
	eO8SBZFWz++ulGwsaIw/KzmoqHyvyI4H1GkfGzKwagZtw4z3bnP2Uw6JnSEIVUa7Es9BKH8RQgN
	ETlLCzFRlDWcwlHZ4ESp42YfUjiZ7PhLiC8Qr7EWmYDcjXYlvu3eXIWJSWekWKzZdNii9wxckCB
	kckCg+fDEXEY+QntdSv2MjrFcrECcNzWPcZD57b20kGise8z/Q/3IiMp3etvd0JTMtNijtPQ9Yb
	Z/vEFuMxLhS7ADMo/arGuAXbKxzvjuDhzIEDT4QRlPdVACL+Ny7SmGtAqUeJktRtztb/dfiVqtt
	c2av8UYcgBSme0VrXhoXxNlRyr/eAXxAVBE6zWk7Iqb6fnpV1WZMuX5yE5T3tsK3kDFZOnjwV+m
	YhUIydNrZs1WhsXzPiZ98NLLOrcJ4xYpKTvkhQNd/FxsvfjhVVxO9diW+h+g==
X-Received: by 2002:a05:6214:5803:b0:8ea:7785:f3e6 with SMTP id 6a1803df08f44-90402c68bf1mr3453026d6.42.1783710827532;
        Fri, 10 Jul 2026 12:13:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm48371106d6.6.2026.07.10.12.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:13:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:13:45 -0400
Message-ID: <44e0f55f936543053d657f0a86a53bd9@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260710
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

Two small SELinux patches to fix a missing permission check for
TCP Fast Open operations and fix a socket lookup issue with SCTP ASCONF
operations.

Paul

--
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260710

for you to fetch changes up to 56acfeb10019e200ab6787d01f8d7cbe0f01526f:

  selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
    (2026-07-01 18:22:22 -0400)

----------------------------------------------------------------
selinux/stable-7.2 PR 20260710
----------------------------------------------------------------

Stephen Smalley (1):
      selinux: check connect-related permissions on TCP Fast Open

Tristan Madani (1):
      selinux: avoid sk_socket dereference in
         selinux_sctp_bind_connect()

 security/selinux/hooks.c |   38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

--
paul-moore.com
