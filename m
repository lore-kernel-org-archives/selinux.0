Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B434F24E;
	Tue, 26 May 2026 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822361; cv=none; b=KMlj8nfKpmA86Evfp0gRKmoST4KkI6YfqFT1Zae/MAxGXqRMhiB6VJ6V30ppqSquaSXVnedonr2IWsmLraVFpzaE+GrTvX3S9ZQSstGTJQkyiRHldOx5cjIohaIpCe1P/rMk3fFu1c9/KkEK+ZQUiKFKaa8Vlg2jD6jVVjeUgBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822361; c=relaxed/simple;
	bh=42Aw1rTN14xE4hnuTcSAB7apQJvwstIrlU6Ld0P/5Vg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qclcDlVTvIuXcEal1diyg/KzyhLPB/1TkypY7Zaq0cEgdxaHOT7acEVZTGI1hUQgF9mz7XFV/DDo/aVgCA+0Y7ekY9ItKU0EN8yN9/JNzKS4pyE1ZjlrKO4i3fF+4oeZVkXMexx+qH7funC/2wZ7vnYwjzJAJ97EtkZ4vRuwduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rdjLXpq6; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rdjLXpq6"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 16C032069C;
	Tue, 26 May 2026 21:05:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cn9IVrGbIKur; Tue, 26 May 2026 21:05:54 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9DDA9201A7;
	Tue, 26 May 2026 21:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9DDA9201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822354;
	bh=B+0azCMTWvkD/1n8uLceuR74Ifghfoq2FT8mLT4U5E8=;
	h=From:To:CC:Subject:Date:From;
	b=rdjLXpq6ne5iTW0M9PGgIeWR4QX07VX5lZ3nfL84IRgVoKJ32EQH916sAV+VdjuoC
	 8UBiFsIlC0gtW4hqhas4L2RIHatn4MuFJSNCWsGvyG2gFil5Lwa1wwM/IC8hBhef+r
	 nOKr8t+JBn/fjziWcnPBFXRkBVfSnxgK4UwSjYn+kis3ivUZKedMRx/4pi7vmx/VaG
	 m+fik59P+ntyjtAG5fqDzXqXHo40bA4qeFWZBkpY+M5ClCPLXOq+n/5h/Ivt1LD6Ff
	 75GJPs21RA3cPJOHrHC1inMU0MasEoBQ41A2UTEAWA7caHia+IiEulpiXNnQFU8rsC
	 o+iRQw6hFA2ng==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:05:52 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Masahide
 NAKAMURA <nakam@linux-ipv6.org>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek
	<omosnace@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Chiachang Wang <chiachangwang@google.com>, Yan
 Yan <evitayan@google.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v9 00/16] xfrm: XFRM_MSG_MIGRATE_STATE new netlink message
Date: Tue, 26 May 2026 21:05:38 +0200
Message-ID: <migrate-state-v9-0-ad9947e4ae74@secunet.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: migrate-state-063ee0342680
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

The current XFRM_MSG_MIGRATE interface is tightly coupled to policy and
SA migration, and it lacks the information required to reliably migrate
individual SAs. This makes it unsuitable for IKEv2 deployments,
dual-stack setups (IPv4/IPv6), and scenarios where policies are managed
externally (e.g., by daemons other than the IKE daemon).

Mandatory SA selector list
The current API requires a non-empty SA selector list, which does not
reflect the IKEv2 use case.
A single Child SA may correspond to multiple policies,
and SA discovery already occurs via address and reqid matching. With
dual-stack Child SAs this leads to excessive churn: the current method
would have to be called up to six times (in/out/fwd × v4/v6) on SA,
while the new method only requires two calls.

Selectors lack SPI (and marks)
XFRM_MSG_MIGRATE cannot uniquely identify an SA when multiple SAs share
the same policies (per-CPU SAs, SELinux label-based SAs, etc.). Without
the SPI, the kernel may update the wrong SA instance.

Reqid cannot be changed
Some implementations allocate reqids based on traffic selectors. In
host-to-host or selector-changing scenarios, the reqid must change,
which the current API cannot express.

Because strongSwan and other implementations manage policies
independently of the kernel, an interface that updates only a specific
SA - with complete and unambiguous identification - is required.

SA Selector, x->sel, can't be changed, especially Transport mode.

XFRM_MSG_MIGRATE_STATE provides that interface. It supports migration
of a single SA via xfrm_usersa_id (including SPI) and we fix
encap removal in this patch set, reqid updates, address changes,
and other SA-specific parameters. It avoids the structural limitations
of XFRM_MSG_MIGRATE and provides a simpler, extensible mechanism for
precise per-SA migration without involving policies.
This method also allows migtrating SA selectors typically used with
host-to-host in Transport mode.

New migration steps: first install block policy, remove the old policy,
call XFRM_MSG_MIGRATE_STATE for each state, then re-install the
policies and remove the block policy.

If the target SA tuple (daddr, SPI, proto, family) is already
occupied, the operation returns -EEXIST. In this case the original
SA is not preserved. Userspace must handle -EEXIST by
re-establishing the SA at the IKE level and manage policies.

---
v8->v9: address v8 review Sabrina and Steffen
	- split const xuo cleanup
	- input validation

Link to v8: https://lore.kernel.org/all/migrate-state-v8-0-4578fb016965@secunet.com/
v7->v8: - removed the unknown-flags validation block

Link to v7: https://patch.msgid.link/migrate-state-v7-14-44eb2440b91c@secunet.com
v6->v7: - add SA selectoor migration
	- fixes to commit messages
	- white space removal

Link to v6: https://lore.kernel.org/r/migrate-state-v6-0-9df9764ddb9e@secunet.com
v5->v6: - add mark to look up SA.
	- restrict netlink attributes in new method
	- address review feedback from Sabrina
	- add new patch to fix existing inter-family address comparison
	- add extack xfrm_state_init()
	- Feedback from Yan : omit-to-inherit add migrating marks
	- Drop missing __rcu annotation on nlsk, Sabrina has a better patch

Link to v5: https://lore.kernel.org/all/cover.1769509130.git.antony.antony@secunet.com/
v4->v5: add synchronize after migrate and delete it inside a lock
	- split xfrm_state_migrate into create and install functions

Link to v4: https://lore.kernel.org/all/cover.1768811736.git.antony.antony@secunet.com/
v3->v4: add patch to fix pre-existing missing __rcu annotation on nlsk

v2->v3: - fix commit message formatting

Link to v2: https://lore.kernel.org/all/cover.1768462955.git.antony.antony@secunet.com/

Lint to v1: https://lore.kernel.org/all/cover.1767964254.git.antony@moon.secunet.de/
v1->v2: dropped 6/6. That check is already there where the func is called
	- merged patch 4/6 and 5/6, to fix use uninitialized value
	- fix commit messages

---
Antony Antony (16):
      xfrm: remove redundant assignments
      xfrm: add extack to xfrm_init_state
      xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
      xfrm: fix NAT-related field inheritance in SA migration
      xfrm: rename reqid in xfrm_migrate
      xfrm: split xfrm_state_migrate into create and install functions
      xfrm: check family before comparing addresses in migrate
      xfrm: add state synchronization after migration
      xfrm: add error messages to state migration
      xfrm: move encap and xuo into struct xfrm_migrate
      xfrm: refactor XFRMA_MTIMER_THRESH validation into a helper
      xfrm: extract address family and selector validation helpers
      xfrm: make xfrm_dev_state_add xuo parameter const
      xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
      xfrm: restrict netlink attributes for XFRM_MSG_MIGRATE_STATE
      xfrm: add documentation for XFRM_MSG_MIGRATE_STATE

 Documentation/networking/xfrm/index.rst            |   1 +
 .../networking/xfrm/xfrm_migrate_state.rst         | 274 ++++++++++++
 include/net/xfrm.h                                 |  78 +++-
 include/uapi/linux/xfrm.h                          |  25 ++
 net/ipv4/ipcomp.c                                  |   2 +-
 net/ipv6/ipcomp6.c                                 |   2 +-
 net/key/af_key.c                                   |  12 +-
 net/xfrm/xfrm_compat.c                             |   5 +-
 net/xfrm/xfrm_device.c                             |   2 +-
 net/xfrm/xfrm_policy.c                             |  25 +-
 net/xfrm/xfrm_state.c                              | 144 ++++---
 net/xfrm/xfrm_user.c                               | 468 ++++++++++++++++++---
 security/selinux/nlmsgtab.c                        |   3 +-
 13 files changed, 903 insertions(+), 138 deletions(-)
---
base-commit: a77d172177f3754ebd70123c78c75a6efa9eec2a
change-id: migrate-state-063ee0342680

Best regards,
--  
Antony Antony <antony.antony@secunet.com>

