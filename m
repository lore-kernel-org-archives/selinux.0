Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53063261B9E
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043154; cv=none; b=ndC2yrQtjpOqUcEJeUR/6cSV7TrGCEE/ibUiHmRwEwLKYcJtr9qKhsiY6wS6kdSi4x7FTploq29hiHKd/BHP3ZdMsBVlF69ABzehET2rcKNPl4W7RplizajPV9uY5LdmwBW1NILz6sWLOFyP3r37SorOlRENFMHU2oHxR1y2q4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043154; c=relaxed/simple;
	bh=OG7woXpf64EQnlsNrRwtCmBx4ZesGn+CnjLUdzE+/RY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pExrPdR0QEk/dR1YNQtPcWCua4j+A8AW2Wwu81Z0DVES8UR5n3KVittQS0WDlWEIkRPxI345RgebjMGCuOgRb5UqCwLLwW5jv5fe8dPDrmLATUb6X11xgnL8tOqpYSurwu6lCT/QRf0PASyC2TnplNwm7y3CLjB8ctYb6fTpR5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORrcLBmk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORrcLBmk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so43778015e9.1
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043151; x=1792647951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7CZMJMc9iC8j2l5jw/IbClzEm5hpIaeRAhZgHrJNq4=;
        b=ORrcLBmksgA6KcMReHubYfOhV4I19nDMlpXNDgL663gq1pKndD26z9ZBSPGorsEnPK
         9cK7L0gLb47ovs0NP4xZ2MlEOtD8exo1256b0kyAgyCzDD7TdE7GrfsZxb+LUcALSyL+
         jjSFp+3iCDZxIkiu66DudthmW8FuShD//uKCKGf6jNJiwtKCNqWrA8lkQp/jZvL5bOnZ
         ZBpLrzLjp3Fl18JmuTQqkQ/0CGIRzT/SReVFoGHxinUhB/eZ9aQ/ibZoUPtmGtEVW0f8
         kYcReZlwbTsN55NKxOy8I+5c++wa9rRSiXsPv556YcbVmz0fFHY+rQg1fzoz5I8w718O
         zo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043151; x=1792647951;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7CZMJMc9iC8j2l5jw/IbClzEm5hpIaeRAhZgHrJNq4=;
        b=OBwScy7wPTiCO6fmvCzqDuRd/mJODW/t9bYa2PjclUNrhL+ZgqEp799NogiKvnaQqz
         EuDtX4cTxF+73WRv36u0svSxHcMSZ8odSY9ps2HtwGxMwz6u9OxWtKCu5HmGNUUZ6vk2
         xT18lr8CzWqKq2wJjfyEm8Dif2xyf9hTy56FNuMawih+03ctovqsR19E86OY1m8yr+53
         L7pnD8vJxQwbXTeFzlAf1+UKQXfp/RCyS0I1NNooQLCo8YVcfYk7bezoGJsVP2/MKPUq
         b3aCP4iFUMLEIrFfvAm7RxoVVekx/cLjuNJ6+YGW0NrkBV+vPeXOmExODZAbl82bY94W
         zx2Q==
X-Gm-Message-State: AFq9FYLJLTXu7vzOc2qviZznnE81hrM/1L/VDk3WsPQv6IPulQgOWMTx
	6SnQnZU7SgU67qZzkjVv1LWIssU9mrJ7jUC+5sL9/Vm+nnsG+R1NAM7qHqBE7A==
X-Gm-Gg: AYBFou2W0dIcM8Dm3oC/5x9Yxdl2QCXX/IOFP0meJYtcK8lmKxbZNviuxFP9xrm6A/D
	Rmy9EVwmUsvecatuKiegET5l/gKODQHqBcBU8Up5/K47JYue6FLj27572oGsoRjUDSLxX2+0azc
	dP5OrVs8jGdLg/sQlTK1kpy3WoDqATGUeeLqPdSdW7NuNpdR/5y8yAKeb4C5adYFfTIRqCbVACI
	fsWLxkIl6BUzjRdk3UAGscYVlnfLteK3ygZ5JfgZRU2OuLEkRRUjm6BL+giUcXERgYOwIAufTN/
	6E66b3RmsWkBIEUUMk1H1vQOReHixQx0nHOh3DShW5o4nXO7dElOkerfQ7OMJhpBB8G36T3uDS7
	QgI74K8YxectzMZt3xTSjqTAtMSpw8zJc2rv8h9yerl9Itp+kp5TxgzA859qso0Nutkraisswvx
	3PTM8eTRAguKf2emgCWIqclUO51YeDjoq1kCro+AOtuIiaevRU8pM+1837Xu10BPT08EiyNc4Wc
	fbbHBz1AXo6B6Y=
X-Received: by 2002:a05:600c:8b78:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4a18e47acf5mr405691885e9.11.1792043151549;
        Wed, 14 Oct 2026 22:45:51 -0700 (PDT)
Received: from omos-acer ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbb4a30sm41982805e9.15.2026.10.14.22.45.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:45:50 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 4/5] tmt: work around missing rule for sysadm_t
Date: Thu, 15 Oct 2026 07:45:34 +0200
Message-ID: <20261015054535.844874-5-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015054535.844874-1-omosnacek@gmail.com>
References: <20261015054535.844874-1-omosnacek@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The avc-check test currently catchesa denial triggered when the
testsuite is ran under a confined root (sysadm_r). Add the rule into the
system policy as a workaround until the rule is added to Fedora policy
(https://github.com/fedora-selinux/selinux-policy/pull/3465).

Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 tmt/tests.fmf | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tmt/tests.fmf b/tmt/tests.fmf
index 75484f4..8f37bb9 100644
--- a/tmt/tests.fmf
+++ b/tmt/tests.fmf
@@ -28,6 +28,10 @@
       unconfined_t|'')
         ;;
       sysadm_t)
+        # Workaround for missing https://github.com/fedora-selinux/selinux-policy/pull/3465
+        echo '(allow sysadm_t self (netlink_iscsi_socket (create)))' >/tmp/sysadm_workaround.cil
+        semodule -i /tmp/sysadm_workaround.cil
+        rm -f /tmp/sysadm_workaround.cil
         ;;
       *)
         echo "Invalid STS_ROOT_DOMAIN value!"
@@ -189,6 +193,9 @@
     set -ex
 
     make -C ../policy unload || true
+    if [ "$STS_ROOT_DOMAIN" = sysadm_t ]; then
+      semodule -r sysadm_workaround
+    fi
     if [ "$STS_KERNEL" = secnext ]; then
       semodule -X 456 -r base
       env -C /usr/share/selinux/devel/include/support mv all_perms.spt.orig all_perms.spt
-- 
2.54.0

