Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36B2745E;
	Mon,  9 Mar 2026 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082072; cv=none; b=hmlszjIsjkwO8k2M3NNeRv+VsLrZZGVU0qo2sNj3tnDyXf4KGmNmkw27GmXDKfl0rH+1yrKR61Q1SAvde4pthd5aL6Ba2F3nbzSYIe8kpc7V8C2189LY4yIyBMIe7IRfyOmrG/WxpRSUlGV7oG7GgMuyjGzJF+F6Bz9Y2z9Q+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082072; c=relaxed/simple;
	bh=xsB/r3qOE/OQ+/BJxTSb5dND+3sonmeJ5XkT+x8aITE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nm1eJuprJ4IezuU/5MOLWCPTbnAthTrKgQ3EM35wu7f9a41d8znhwHv96tlP2205EJT8Bo9n+YaSA1NIGPK7anTkB454L80nsjrSOg15CJv49a8CIoSkTDLvHZNwuQ1x+O210wHNPQIXlMZNQ7qlgyGz7C5qjTnMM+9QjEI0C/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ClR3M7Aw; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ClR3M7Aw"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E574F20612;
	Mon,  9 Mar 2026 19:47:49 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1v00vC2oOZ5v; Mon,  9 Mar 2026 19:47:49 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 27C7020538;
	Mon,  9 Mar 2026 19:47:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 27C7020538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773082069;
	bh=+zNliWaMa9sPXEJu+7k/iqbvxt1hislj2AXZOyaP+dM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ClR3M7Aw4XHgT0gOz1DTKc0OkA0vUwPSvoloU9etS2u97S7hVsAAt4jx+D62jMnS0
	 qUsaKkIu5x9aRmw8Q1rpAgQTrZ/T/dSfxvW5T7Yobf+NEeMRRnLpQbdrMdGHPin7+B
	 CiO1aXkeEgv6broce58KRhcSYwc36aPviVyYzZz+/Qp12+x68XS5miR4jUtg6CzvvP
	 Xpg7l3GIMv8KaPnhgBHN60xa9rjN3LQYVxEkh7N5m++2nbYcVbnc3cHEJzxt2FuCXy
	 7stY15i8xNbFAqW8g6w0ow2IrQjVWQqch+VtRNB/IMyoJsPCoxHEv5d/0tHwlTjsWZ
	 QocRZZumqPDKA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 19:47:47 +0100
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
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<selinux@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chiachang Wang
	<chiachangwang@google.com>, Yan Yan <evitayan@google.com>,
	<devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v6 14/14] xfrm: docs: add documentation for XFRM_MSG_MIGRATE_STATE
Date: Mon, 9 Mar 2026 19:47:36 +0100
Message-ID: <migrate-state-v6-14-9df9764ddb9e@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v6-0-9df9764ddb9e@secunet.com>
References: <migrate-state-v6-0-9df9764ddb9e@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)

Add documentation for the new XFRM_MSG_MIGRATE_STATE netlink message,
which migrates a single SA identified by SPI and mark without involving
policies.

The document covers the motivation and design differences from the
existing XFRM_MSG_MIGRATE, the SA lookup mechanism, supported attributes
with their omit-to-inherit semantics, and usage examples.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v5->v6: added this patch
---
 Documentation/networking/xfrm/index.rst            |   1 +
 .../networking/xfrm/xfrm_migrate_state.rst         | 129 +++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/Documentation/networking/xfrm/index.rst b/Documentation/networking/xfrm/index.rst
index 7d866da836fe76642d36d8bf9a9c11757427453f..90191848f8db907148d610e14572f4ba43390114 100644
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
index 0000000000000000000000000000000000000000..a218dd6510ca17df3f5a88adb55b9a7de26e6c35
--- /dev/null
+++ b/Documentation/networking/xfrm/xfrm_migrate_state.rst
@@ -0,0 +1,129 @@
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
+the reqid, addresses, encapsulation, and other SA-specific parameters.
+
+Because IKE daemons such as strongSwan manage policies independently of
+the kernel, this interface allows precise per-SA migration without
+requiring policy involvement. Optional XFRM attributes follow an
+omit-to-inherit model.
+
+SA Identification
+=================
+
+The struct is defined in ``include/uapi/linux/xfrm.h``. The SA is looked
+up using ``xfrm_state_lookup()`` with ``id.spi``,
+``id.daddr``, ``id.proto``, ``id.family``, and ``old_mark``::
+
+    struct xfrm_user_migrate_state {
+        struct xfrm_usersa_id id;       /* spi, daddr, proto, family */
+        xfrm_address_t        new_daddr;
+        xfrm_address_t        new_saddr;
+        __u16                 new_family;
+        __u16                 reserved;
+        __u32                 new_reqid;
+        struct xfrm_mark      old_mark; /* SA lookup */
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
+     - Hardware offload configuration. Set ``ifindex=0`` to remove offload.
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
+traffic leaks and IV reuse.
+
+AES-GCM IV uniqueness is critical: reusing a (key, IV) pair allows
+an attacker to recover the authentication subkey and forge
+authentication tags, breaking both confidentiality and integrity.
+
+``XFRM_MSG_MIGRATE_STATE`` atomically deletes the old SA and installs
+the new one with the sequence counter and replay window copied. The
+block policy ensures no outgoing packets are sent in the migration
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

