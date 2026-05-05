Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F253B27F7;
	Tue,  5 May 2026 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955713; cv=none; b=CEydlmz3up7iANCFz24Hg7FbpcA6rjZuwNO2/gI9MJPkTZB6jPDLR5svAj9TR4jUpr2pEtCy/2kNdJgp3HuLZ4ro5j5DP/xoOf3EZt4CZVDNivm75qzgjmdok43xIJAN26fNyOfjaU1tSDiltNkeHNTBWxkMRUHfOo/9xGmauDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955713; c=relaxed/simple;
	bh=k85Lb0EkJOE7jCBRZ3O3D0QyYLanbcAFDOkK4FNDVDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nuk5zz2coev+b0qfyjUKKkPrWsjuyYwW7JXVqJQwriF8OvSU6p/ikNIAngbSFvt/bw6tGoUjq0SBUI16aUK0R1ychJ0Do3PWS53XvD8mZ/vSllRIeEy0nktr6PIAziEihEsAwHb9DhS1VU0toJ2EbbAy5xZit3DNHDtGlCfwKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SwGIwIIg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SwGIwIIg"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 422F820049;
	Tue,  5 May 2026 06:35:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GvDsNgVKF_VW; Tue,  5 May 2026 06:35:09 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5303F2053D;
	Tue,  5 May 2026 06:35:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5303F2053D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777955708;
	bh=ZGPyCivM/hHNN3pgtXPz4zcSVYr/zXmtyGyPKyRcWLI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SwGIwIIga/XcmSoinoiVzf/TTS1BMYMpHGV/sO4oxMkAD692xRt8FnnIHx77Man2a
	 Ykwv5RUPyLwFMQBsC+Rr4qffd7mJd790P0gsZRK5iUI5eZwztgX0MvL7U9bbK+3zxe
	 getFBipYypr64rdMnU6hQmgZrRXnurv3rEyKMkZpORVo2TT5gDcW3KY+fUMFRXtaaB
	 tNkIFkvXMagN8JTPC11O/DKczK/Omy8tA63d6eNe9S6VBZ9ZPvcmV5dPDSFdE5DoYs
	 STJBWX90An5i0nBjQlu6j7h4aMljk3YITp0HUHauvYxR+yTJ/tGslZuaou7XIsSn6z
	 +CIQ89GdIqLdA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 06:35:06 +0200
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
Subject: [PATCH ipsec-next v8 14/14] xfrm: add documentation for XFRM_MSG_MIGRATE_STATE
Date: Tue, 5 May 2026 06:34:55 +0200
Message-ID: <migrate-state-v8-14-4578fb016965@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v8-0-4578fb016965@secunet.com>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

Add documentation for the new XFRM_MSG_MIGRATE_STATE netlink message,
which migrates a single SA identified by SPI and mark without involving
policies.

The document covers the motivation and design differences from the
existing XFRM_MSG_MIGRATE, the SA lookup mechanism, supported attributes
with their omit-to-inherit semantics, and usage examples.

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v7->v8: unknown flags ignored
v6->v7: update docs to reflect the flags
v5->v6: added this patch
---
 Documentation/networking/xfrm/index.rst            |   1 +
 .../networking/xfrm/xfrm_migrate_state.rst         | 231 +++++++++++++++++++++
 2 files changed, 232 insertions(+)

diff --git a/Documentation/networking/xfrm/index.rst b/Documentation/networking/xfrm/index.rst
index 7d866da836fe..90191848f8db 100644
--- a/Documentation/networking/xfrm/index.rst
+++ b/Documentation/networking/xfrm/index.rst
@@ -9,5 +9,6 @@ XFRM Framework
 
    xfrm_device
    xfrm_proc
+   xfrm_migrate_state
    xfrm_sync
    xfrm_sysctl
diff --git a/Documentation/networking/xfrm/xfrm_migrate_state.rst b/Documentation/networking/xfrm/xfrm_migrate_state.rst
new file mode 100644
index 000000000000..66e7f2e729d8
--- /dev/null
+++ b/Documentation/networking/xfrm/xfrm_migrate_state.rst
@@ -0,0 +1,231 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+XFRM SA Migrate State
+=====================
+
+Overview
+========
+
+``XFRM_MSG_MIGRATE_STATE`` migrates a single SA, looked up using SPI and
+mark, without involving policies. Unlike ``XFRM_MSG_MIGRATE``, which couples
+SA and policy migration and allows migrating multiple SAs in one call, this
+interface identifies the SA unambiguously via SPI and supports changing
+the reqid, addresses, encapsulation, selector, and offload.
+
+Because IKE daemons such as *wan manage policies independently of
+the kernel, this interface allows precise per-SA migration without
+requiring policy involvement. Optional netlink attributes follow an
+omit-to-inherit model: omitting an attribute preserves the value from
+the old SA. The ``flags`` field controls two exceptions: hardware offload
+is inherited by default and can be suppressed with
+``XFRM_MIGRATE_STATE_NO_OFFLOAD`` or overridden with ``XFRMA_OFFLOAD_DEV``;
+the new selector is taken from ``new_sel`` by default and can instead be
+derived from the new addresses with ``XFRM_MIGRATE_STATE_UPDATE_SEL``.
+
+SA Identification
+=================
+
+The struct is defined in ``include/uapi/linux/xfrm.h``. The SA is looked
+up using ``xfrm_state_lookup()`` with ``id.spi``,
+``id.daddr``, ``id.proto``, ``id.family``, and
+``old_mark.v & old_mark.m`` as the mark key::
+
+    struct xfrm_user_migrate_state {
+        struct xfrm_usersa_id  id;       /* spi, daddr, proto, family */
+        xfrm_address_t         new_daddr;
+        xfrm_address_t         new_saddr;
+        struct xfrm_mark       old_mark; /* SA lookup: key = v & m */
+        struct xfrm_selector   new_sel;  /* new selector (see Flags) */
+        __u32                  new_reqid;
+        __u32                  flags;    /* XFRM_MIGRATE_STATE_* */
+        __u16                  new_family;
+        __u16                  reserved;
+    };
+
+Supported Attributes
+====================
+
+The following fields in ``xfrm_user_migrate_state`` are always explicit
+and are not inherited from the existing SA. Passing zero is not equivalent
+to "keep unchanged" — zero is used as-is:
+
+- ``new_daddr`` - new destination address
+- ``new_saddr`` - new source address
+- ``new_family`` - new address family
+- ``new_reqid`` - new reqid (0 = no reqid)
+- ``new_sel`` - new selector; used when ``XFRM_MIGRATE_STATE_UPDATE_SEL`` is
+  not set (see `Flags`_ below)
+- ``flags`` - bitmask of ``XFRM_MIGRATE_STATE_*`` flags (see `Flags`_ below)
+
+The following netlink attributes are also accepted. Omitting an attribute
+inherits the value from the existing SA (omit-to-inherit).
+
+.. list-table::
+   :widths: 30 70
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``XFRMA_MARK``
+     - Mark on the migrated SA (``struct xfrm_mark``). Absent inherits
+       ``old_mark``. To use no mark on the new SA, send ``XFRMA_MARK``
+       with ``{0, 0}``.
+   * - ``XFRMA_ENCAP``
+     - UDP encapsulation template; only ``UDP_ENCAP_ESPINUDP`` is supported.
+       Set ``encap_type=0`` to remove encap.
+   * - ``XFRMA_OFFLOAD_DEV``
+     - Hardware offload configuration (``struct xfrm_user_offload``). Absent
+       copies offload from the existing SA. When
+       ``XFRM_MIGRATE_STATE_NO_OFFLOAD`` is set in ``flags``, the new SA has
+       no offload; this flag is mutually exclusive with ``XFRMA_OFFLOAD_DEV``
+       and sending both returns ``-EINVAL``.
+   * - ``XFRMA_SET_MARK``
+     - Output mark on the migrated SA; pair with ``XFRMA_SET_MARK_MASK``.
+       Send 0 to clear.
+   * - ``XFRMA_NAT_KEEPALIVE_INTERVAL``
+     - NAT keepalive interval in seconds. Requires encap. Send 0 to clear.
+       Automatically cleared when encap is removed; setting a non-zero
+       value without encap returns ``-EINVAL``.
+   * - ``XFRMA_MTIMER_THRESH``
+     - Mapping maxage threshold. Requires encap. Send 0 to clear.
+       Automatically cleared when encap is removed; setting a non-zero
+       value without encap returns ``-EINVAL``.
+
+The following SA properties are immutable and cannot be changed via
+``XFRM_MSG_MIGRATE_STATE``: algorithms (``XFRMA_ALG_*``), replay state,
+direction (``XFRMA_SA_DIR``), and security context (``XFRMA_SEC_CTX``).
+
+Flags
+=====
+
+The ``flags`` field in ``xfrm_user_migrate_state`` controls optional
+migration behaviour. Unknown flag bits are ignored.
+
+.. list-table::
+   :widths: 40 60
+   :header-rows: 1
+
+   * - Flag
+     - Description
+   * - ``XFRM_MIGRATE_STATE_NO_OFFLOAD``
+     - When set, the new SA has no hardware offload even when
+       ``XFRMA_OFFLOAD_DEV`` is absent. Without this flag, omitting
+       ``XFRMA_OFFLOAD_DEV`` copies the existing offload to the new SA.
+       Mutually exclusive with ``XFRMA_OFFLOAD_DEV``; sending both
+       returns ``-EINVAL``.
+   * - ``XFRM_MIGRATE_STATE_UPDATE_SEL``
+     - When set, the kernel validates that the existing SA selector is a
+       single-host entry matching the SA addresses (``prefixlen_s ==
+       prefixlen_d`` equal to 32 for IPv4 or 128 for IPv6, and addresses
+       matching ``id.daddr`` and ``props.saddr``). If the check passes,
+       the new selector is derived from ``new_daddr`` and ``new_saddr``
+       with the single-host mask for ``new_family``. A mismatch returns
+       ``-EINVAL``. When this flag is not set, ``new_sel`` is used as-is
+       for the migrated SA.
+
+Migration Steps
+===============
+
+#. Install a block policy to drop traffic on the affected selector.
+#. Remove the old policy.
+#. Call ``XFRM_MSG_MIGRATE_STATE`` for each SA.
+#. Reinstall the policies.
+#. Remove the block policy.
+
+Block Policy and IV Safety
+--------------------------
+
+Installing a block policy before migration is required to prevent
+traffic leaks and IV reuse in counter mode.
+
+AES-GCM IV uniqueness is critical: reusing a (key, IV) pair allows
+an attacker to recover the authentication subkey and forge
+authentication tags, breaking both confidentiality and integrity.
+
+``XFRM_MSG_MIGRATE_STATE`` atomically copies the sequence number and
+replay window from the old SA to the new SA and deletes the old SA.
+The block policy ensures no outgoing packets are sent in the migration
+window, preventing IV reuse under the same key.
+
+Feature Detection
+=================
+
+Userspace can probe for kernel support by sending a minimal
+``XFRM_MSG_MIGRATE_STATE`` message with a non-existent SPI:
+
+- ``-ENOPROTOOPT``: not supported (``CONFIG_XFRM_MIGRATE`` not enabled)
+- any other error: supported
+
+Userspace Notification on Success
+=================================
+
+On successful migration the kernel multicasts an
+``XFRM_MSG_MIGRATE_STATE`` message to the ``XFRMNLGRP_MIGRATE`` group.
+The fixed header is ``struct xfrm_user_migrate_state`` copied from the
+request, followed by the same set of netlink attributes that are
+accepted as input, with the differences noted below.
+
+Differences from the request
+-----------------------------
+
+.. list-table::
+   :widths: 25 75
+   :header-rows: 1
+
+   * - Field / Attribute
+     - Difference
+   * - ``new_sel``
+     - Contains the actual selector of the newly installed SA, not the
+       ``new_sel`` from the request. When
+       ``XFRM_MIGRATE_STATE_UPDATE_SEL`` is set the kernel derives the
+       selector from ``new_daddr`` / ``new_saddr``; the caller's
+       ``new_sel`` field is ignored in that case. The notification
+       always carries the real selector of the new SA.
+   * - ``XFRMA_SA_DIR``
+     - Present in the notification (set from the direction of the new
+       SA) but **not accepted as input** — direction is immutable.
+   * - ``flags``
+     - Echoed back as-is. ``XFRM_MIGRATE_STATE_NO_OFFLOAD`` and
+       ``XFRM_MIGRATE_STATE_UPDATE_SEL`` describe the request that was
+       made, not a property of the resulting SA.
+
+Attributes in the notification
+-------------------------------
+
+.. list-table::
+   :widths: 30 70
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``XFRMA_ENCAP``
+     - UDP encapsulation template, if configured on the new SA.
+   * - ``XFRMA_OFFLOAD_DEV``
+     - Hardware offload configuration, if active on the new SA.
+   * - ``XFRMA_MARK``
+     - Mark on the new SA, if set.
+   * - ``XFRMA_SET_MARK``
+     - Output mark on the new SA, if set.
+   * - ``XFRMA_SET_MARK_MASK``
+     - Output mark mask, present together with ``XFRMA_SET_MARK``.
+   * - ``XFRMA_MTIMER_THRESH``
+     - Mapping maxage threshold, if non-zero.
+   * - ``XFRMA_NAT_KEEPALIVE_INTERVAL``
+     - NAT keepalive interval, if non-zero.
+   * - ``XFRMA_SA_DIR``
+     - Direction of the new SA.
+
+Error Handling
+==============
+
+If the target SA tuple (daddr, SPI, proto, family) is occupied by an existing
+unrelated SA, the operation returns ``-EEXIST``. In this case both the old and
+the new SA are gone. The old SA cannot be restored as doing so would risk
+duplicate sequence number and IV reuse, which must not occur. Userspace should
+handle ``-EEXIST``, for example by re-establishing the SA at the IKE level.
+
+If the multicast notification (``XFRMNLGRP_MIGRATE``) fails to send,
+the migration itself has already completed successfully and the new SA
+is installed. The operation returns success, 0, with an extack warning,
+but listeners will not receive the migration event.

-- 
2.47.3

