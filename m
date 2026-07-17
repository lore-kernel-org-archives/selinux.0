Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09D3876A7
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313676; cv=none; b=gz3rR+zsMlrXNju4+ZXCBw+yR4FzXF3XTdSg21OdOBFzZAv7uc7QeatXRGkUA1G6O1G/j5OeDwtCy1n1VgdTcHkURBjNa9NGKdXC4moODDNDQn3bljo8yY3Gjvi/n6OCiXBFQB0V9HWgrQCVQ4kPlqCogPeRmhdJcRRIVB603Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313676; c=relaxed/simple;
	bh=rQB+dxirbyI8Bq/oLeD5LijdIIYzYUIFA6QkPnowy+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ8UX6OijP8pzr07wUyinQLRdF6Z7j3BiVPxRNnI3bSpINBUQ9BxHTCuZzfpsTQk57CbeaoYtfd+GhqYDkM1xce1tvQcTWCUVZUrTZ43F03JeDdu0DZncymDoT14QU7F6nke5/Bu86/KLls+jF3ZLZ5/N97BXp5LwM72pgKf0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFwXfAd9; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFwXfAd9"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8efbafa1bacso67904996d6.1
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313674; x=1784918474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8HnhoKe3pen4JbgMrn1q6q5t82++805OkSD+beNey20=;
        b=UFwXfAd9ZDTx53Yc2LoRgDiTccpSg0vf3lrMx7X9RzJzWiATZjBQghUK1CCq7I/+qs
         6wDU3e9IAV+CV2FxL6Zz42It2/EOzcfDZSOIR9i/j/qdNiGpXAHDYwg4kUElbRqnQM7T
         5b3/qcO0uWHHcfI/e1NwKN315RGLz/OiJmxoyMVxDuw0pR4y/gh6xeMg0fpBuoN1ZqKB
         07ShTcUpJCCkvr67A4f/ZcA52bvwAc/d/D/zEE/abMheLl3IGfSy4k4Rbw/C4jI18dJU
         I1XBqI+bnWodExs0cJP02y2+hGLGjfquJC5TB9zK1+tBBTU2odbrA6hHh6lxqqEGBdkA
         YS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313674; x=1784918474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8HnhoKe3pen4JbgMrn1q6q5t82++805OkSD+beNey20=;
        b=AhWv6Pes4ydjA9JjCBxAWeTvCprLD3dd6wN2kJI8r+bnte5xyK8ajeqCyKcIqVAp72
         cTnvJPnFNKA0AsoaLvhJrtj6T+Vq+3zSo9jPcdgYdzJ/cyl+UOgh2xcsBRoGkeIgy98n
         Tbt6jFqpOUEkPBy7bNvru6DDFCvR4eY/T48YsiaNWuSkHJs4DgXZLERAAyKnweiKHA8S
         pZxiaIbOTWW9hOqB1q28QPQEtulSAVVytv7+gYGVAigxZkkeCZ791xHRTpPNB8RgPz5a
         90oKuoiSR0UTJFx4Kg01PSmvZzjeFM1m1N8GEg9y4eicWEjSRyjYpXAz9dSajIRRJAH0
         S0NA==
X-Gm-Message-State: AOJu0Yw4KG/SXxrW52d4mRTfSIZmVFErDhWVF7iwJ3OKegiC0uJTDccc
	jMiWSX27ee40XVVU0V1u4b6Bz/pAdNromu7slRzk0wLttemk+C3iqfx7Q/WDMw==
X-Gm-Gg: AfdE7cnBPKb10H/zpyDMGMqPqKh+gXKXbGYXrShIZ1ZFEgkFWIJ1r9Slgyyr7/NSkVf
	TvVJ9Ziw3ENxJ7s+gTNxFpIISzQrjlq7R5N6TWJigQ/VhyAf8RLnSK13p8XkH4NLWwG+DRBx6PE
	nFg8wUwxsPePYoLmOes83wndR1+LY4RYNSkVLqB64QiqRMMbH7DLk+sMs5vOdyaAeahgRE1+qER
	LCihK50pwSe8UNCoqmEMqeKcM9O6JvcpnDkjKPTgIz8VOYlDpyeq/0kHIenu4nZKuFU/JzeLhlN
	d6Fx+9QBu5Z4B9NpNL49Zsxm3Kq/RamEAQsn4SwFU9qBfhIE7mUnM4ASZa08JAjb9c5wyHy65V6
	eYMuhA4KKja1fDRG5AjxnEdCbZqaXTFsTX//J+qaNlnz2Aamzn9WT7CAA/6nJs+x3NI4AXhrarM
	7O5ZeVsdBsfJzQ1+S7JzjX2dXw5g+pC5Tv7uFucBhlkiaJR47wVZJeg1hf+a0bXfsZba1tSz3Et
	9v41Q==
X-Received: by 2002:a05:6214:301d:b0:8eb:70e0:47d0 with SMTP id 6a1803df08f44-907784ead05mr46340266d6.37.1784313673643;
        Fri, 17 Jul 2026 11:41:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm22756576d6.30.2026.07.17.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:41:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 10/10] sandbox/sandboxX.sh: quote the command line arguments
Date: Fri, 17 Jul 2026 14:34:25 -0400
Message-ID: <20260717183424.20324-11-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
References: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quote the command line arguments to avoid misinterpretation
if they contain whitespace or a test operator.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/sandboxX.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sandbox/sandboxX.sh b/sandbox/sandboxX.sh
index 28169182..e733aff3 100644
--- a/sandbox/sandboxX.sh
+++ b/sandbox/sandboxX.sh
@@ -2,9 +2,9 @@
 trap "" TERM
 context=`id -Z | secon -t -l -P`
 export TITLE="Sandbox $context -- `grep ^#TITLE: ~/.sandboxrc | /usr/bin/cut -b8-80`"
-[ -z $1 ] && export WAYLAND_NATIVE="no" || export WAYLAND_NATIVE="$1"
-[ -z $2 ] && export SCREENSIZE="1000x700" || export SCREENSIZE="$2"
-[ -z $3 ] && export DPI="96" || export DPI="$3"
+[ -z "$1" ] && export WAYLAND_NATIVE="no" || export WAYLAND_NATIVE="$1"
+[ -z "$2" ] && export SCREENSIZE="1000x700" || export SCREENSIZE="$2"
+[ -z "$3" ] && export DPI="96" || export DPI="$3"
 trap "exit 0" HUP
 
 mkdir -p ~/.config/openbox
-- 
2.55.0

