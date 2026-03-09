Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5E33B97A;
	Mon,  9 Mar 2026 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082021; cv=none; b=OWLBKy4VOGa1vd/CBStY4FSsPpAxZHstv4WpUaq9VeLJmMRY91hnrplLshDNzEqpf7TYlllCULTsC9kXrcbinaDhBjw6U7nTbsK8wzLnA/6+6HWPS0x6Y1S+iBxdYJFedZYVvGnTj7K4z+A9LB+7NWedjYQPenBNrYXtK/daSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082021; c=relaxed/simple;
	bh=+bMjZ8Vo4m+a7FuP+U4CPBrUmYTQPXKH26iyQTW+bFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZgnUepDbeKJce0jgEss/fzJ5klktWOjSqtdkticwgnJnG9cV32Em2fBURtVDYRwhuROMKfAZaJGmI/y07BqTWiiJ3TwJ/VCvYKs5jLJdNw4NfG2aYlnGUtIVMdBuJhCbZ0os0E3+mg3fXYXzwb8Im0FIU5bhaXTqrYymuFuHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=F2eLy7Nw; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="F2eLy7Nw"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7C232206DF;
	Mon,  9 Mar 2026 19:46:58 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iZuGXOEbcHlJ; Mon,  9 Mar 2026 19:46:57 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A101F20538;
	Mon,  9 Mar 2026 19:46:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A101F20538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773082017;
	bh=QR8Q13yK/RELlmqdMNXXbphCopfRTBePEGeGm6QTCZ8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=F2eLy7NwT82ySiGP4Ibi+vCDE9Ti3m8JTJQJSjfXqqJHlNc8lhqFxcsBtpcERFyzq
	 +HQJn99NrQv1u6u+d3W8zNd0r6E95FyqUEjpmBY5ORrEdWHZxzrOfZ3lwtF3NDr64v
	 hd8rz0bJknpSSXQlkVrR6kVv4iL1AkvUDymXivp2UQQfTcMNSmrcz9MA8y/sQsmi3w
	 jzob2aeox4HBhTZ/w1/GB+pRUItF0apMEZxkTR8LLXnuu89fMsw2gaYGQCAB5TAq/5
	 B/ZCGWmR/6BvgA8h8RGq1cMt+qH9itucgwk8vlnI7cGVe2eYcgxZtjGl4Z4o1fgise
	 qTYesS3BBH+pA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 19:46:56 +0100
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
Subject: [PATCH ipsec-next v6 09/14] xfrm: add error messages to state migration
Date: Mon, 9 Mar 2026 19:46:46 +0100
Message-ID: <migrate-state-v6-9-9df9764ddb9e@secunet.com>
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

Add descriptive(extack) error messages for all error paths
in state migration. This improves diagnostics by
providing clear feedback when migration fails.

After xfrm_init_state() use NL_SET_ERR_MSG_WEAK() as fallback for
error paths not yet propagating extack e.g. mode_cbs->init_state()

No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
-
v5->v6: - in case dev_state_add() extack already set
	- after xfrm_init_state() use NL_SET_ERR_MSG_WEAK() as fallback
Link: https://lore.kernel.org/all/dd1d5b341323d6e0f93057c214adf4fc51c3cbd1.1769509131.git.antony.antony@secunet.com [v5]
v4->v5: - added this patch
---
 net/xfrm/xfrm_state.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 85a5567af5b33fc70c48a7205b334b2ab3c0ab81..96f700dedb7ede063ea6a7951be5b05cd14451b4 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2130,11 +2130,15 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 	struct xfrm_state *xc;
 
 	xc = xfrm_state_clone_and_setup(x, encap, m);
-	if (!xc)
+	if (!xc) {
+		NL_SET_ERR_MSG(extack, "Failed to clone and setup state");
 		return NULL;
+	}
 
-	if (xfrm_init_state(xc, extack) < 0)
+	if (xfrm_init_state(xc, extack) < 0) {
+		NL_SET_ERR_MSG_WEAK(extack, "Failed to initialize migrated state");
 		goto error;
+	}
 
 	/* configure the hardware if offload is requested */
 	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
@@ -2163,6 +2167,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 		xfrm_state_insert(xc);
 	} else {
 		if (xfrm_state_add(xc) < 0) {
+			NL_SET_ERR_MSG(extack, "Failed to add migrated state");
 			if (xuo)
 				xfrm_dev_state_delete(xc);
 			xc->km.state = XFRM_STATE_DEAD;

-- 
2.47.3

