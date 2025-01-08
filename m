Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804B13B288
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324940; cv=none; b=qrda5UiEc1gWpedEHHxoIxxKQ3xUKqpVFbBDvNArZPJQAAwc5CGKItaABKioyAkX+R5zDKcaO4ElzsFpVC/wMJK8r9tvSIKi9Bd2qwaM8V/ci4VSJxDuvn3Z/sd5gqjeWN7PjKhiQ3L3njzAnkiepqwA7PCQiygBfkwpx6ZFk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324940; c=relaxed/simple;
	bh=iFc2l9ojBC+1iJjv733GLDwkMzfButJHGrSrXrfMgcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Op/cRkL8L3e7TK+oAKrTqMQ2kgIC2+WInNnUnfEapIJPr8F072kDprM5Zx84hLf9gIQl2q3BFtrXriJQCB0rX5atUKYMwkSlWJqI09yY6SdCyCEnt9cNjIYZvanOaHzxW4ZxhdXOL9I8Rm/ep3esZ+VnNOeTVYfFbHFWJYjd4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Honi2Gjx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AfZlunG9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Honi2Gjx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AfZlunG9"
Date: Wed, 8 Jan 2025 09:28:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736324937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9PhVI0UYvwMOydfGhwZxzvEQ0V4T587Bf/6THLsWhdA=;
	b=Honi2GjxGx4uUlc40FrpsIPipYeM6tl3v1Hz0TqJm7hH3I0msoUR76fDLVvZd92Z5O092x
	i0nPahSJXhhaIXC+efIpsZ2z7cgZ5Iu3yOPpV/35oNL0glSyHotnrojIRBFSbn8vk6WCBo
	cDfbnAs54ghoq0NCgWIuB51/mDwUIE8HEf+4nHLcmiezqfYRX7azYt7f4gKv4QXEoA6TNt
	JuOUJVHo5vvlNvWhWjaZrNd/Xwx+jHk70rDFQno/46W2DscKQz7XQPgzipa+39cvWSXdjE
	3uXBP5DIcOLMZvSegNUXj5tRJUFbOUcCG4CRg9qdTs7yLa4WyjutuWt8mtaG7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736324937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9PhVI0UYvwMOydfGhwZxzvEQ0V4T587Bf/6THLsWhdA=;
	b=AfZlunG9rS9Y/1JaeK8UGvRUokTC9eixgXPYYY/TtLaKYoLjBB0Unk2Z78An+gI2UVPo7E
	s5jamzIQ/+oJhDAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>,
	selinux@vger.kernel.org
Cc: Bram =?utf-8?B?Qm9ubsOp?= <brambonne@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: selinux: error: =?utf-8?B?4oCYTkVUTElOS19S?=
 =?utf-8?B?T1VURV9TT0NLRVRfX05MTVNH4oCZ?= undeclared
Message-ID: <20250108082855.PkG-_BaT@linutronix.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

since commit d1d991efaf346 ("selinux: Add netlink xperm support") I can't
compile a defconfig:

| $ make defconfig
| $ make security/selinux/nlmsgtab.o
=E2=80=A6
|   CC      security/selinux/nlmsgtab.o
| security/selinux/nlmsgtab.c: In function =E2=80=98selinux_nlmsg_lookup=E2=
=80=99:
| security/selinux/nlmsgtab.c:188:33: error: =E2=80=98NETLINK_ROUTE_SOCKET_=
_NLMSG=E2=80=99 undeclared (first use in this function); did you mean =E2=
=80=98NETLINK_ROUTE_SOCKET__LOCK=E2=80=99?
|   188 |                         *perm =3D NETLINK_ROUTE_SOCKET__NLMSG;
|       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
|       |                                 NETLINK_ROUTE_SOCKET__LOCK
| security/selinux/nlmsgtab.c:188:33: note: each undeclared identifier is r=
eported only once for each function it appears in
| security/selinux/nlmsgtab.c:196:33: error: =E2=80=98NETLINK_TCPDIAG_SOCKE=
T__NLMSG=E2=80=99 undeclared (first use in this function); did you mean =E2=
=80=98NETLINK_TCPDIAG_SOCKET__MAP=E2=80=99?
|   196 |                         *perm =3D NETLINK_TCPDIAG_SOCKET__NLMSG;
|       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|       |                                 NETLINK_TCPDIAG_SOCKET__MAP
| security/selinux/nlmsgtab.c:210:33: error: =E2=80=98NETLINK_XFRM_SOCKET__=
NLMSG=E2=80=99 undeclared (first use in this function); did you mean =E2=80=
=98NETLINK_XFRM_SOCKET__MAP=E2=80=99?
|   210 |                         *perm =3D NETLINK_XFRM_SOCKET__NLMSG;
|       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
|       |                                 NETLINK_XFRM_SOCKET__MAP
| security/selinux/nlmsgtab.c:218:33: error: =E2=80=98NETLINK_AUDIT_SOCKET_=
_NLMSG=E2=80=99 undeclared (first use in this function); did you mean =E2=
=80=98NETLINK_AUDIT_SOCKET__LOCK=E2=80=99?
|   218 |                         *perm =3D NETLINK_AUDIT_SOCKET__NLMSG;
|       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
|       |                                 NETLINK_AUDIT_SOCKET__LOCK
| make[5]: *** [scripts/Makefile.build:194: security/selinux/nlmsgtab.o] Er=
ror 1
=E2=80=A6

The commit introducing this is part of v6.13-rc1 and we have v6.13-rc6
and I wonder why am I the only one seeing this? The bots must have
noticed it way earlier and yet I can't find any report of it.
Is this a typo that everyone keeps ignoring or do I lack something that
auto generates this define somewhere?

Sebastian
