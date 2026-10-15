Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782683E2AD1
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043156; cv=none; b=GrnLwoI2Ic72I2SrevjJHNRScf9z3IcfyrVFnnt+avXxHHqHzhcz5Zk4LruWpJFv1ReTbiqvGLSTL6+qTErM1c4D9j2IZt8zlxnIQmvLWsnDoR5mp7CI2ciAZ7AT9YPnr8HPjnsBRcaMvIGgM/WQgXtC4Hvubt0l8bcRDCsvqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043156; c=relaxed/simple;
	bh=/VZclTB/OoAHjpFrtQdVz94lx/Oqmktg5Vv49EicwSo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JK/XM23Nxep8JragRKhkgtpXC293L4IGWuX0Ay/yZBPCex3XtxbrACrTLYwzf3/FRhJYUEngsI19gyEN2wLLhAbtB+PyAjBuuMg2ntn2L5OOExysXKXqDsdrqom30+l/ardhIMVaFn41Y8HHjIEoAH/Gl9mCiSCScLnzJvNToQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohBVrCrV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohBVrCrV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so41472215e9.1
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043154; x=1792647954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1aGwDDbUxf7sE3W/qiMuka7/rslvAbWpEKegWRxOcg=;
        b=ohBVrCrVhoneDWmuXAMnogI2z30oS4w1lgiPAlWlMkTYFJB8lOhrB+0cFW32rnESJY
         h7co9xiTuLUuurI7QgcQrDeprP/YbHZ1c3Erh5uVRYQ4uMCsXVMzVu7mlhLNe58Siw2/
         Y8xvo0bFfnAbdH5Sw3pIxsIWCvkJ7UjpVlBZIcGXqcdXJnA4zEO/KnF/bJGTHJReQFCk
         5C6lb/t87siRssX38Kp4fvT8mz+pKjZIMukAl9V/tzXlTu22kMRbgF7HU82DkHC4n3BT
         1lslhl9sVvlOLkU4m+2J5ykT2FcIPA5sQvs/rKHeiq0i8YhKl6jDK5ZXBFEVlri/ATlH
         zG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043154; x=1792647954;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1aGwDDbUxf7sE3W/qiMuka7/rslvAbWpEKegWRxOcg=;
        b=0hwdtpdoh4Wetb227OMCo+w14K4P3wr9LHFNCZEgxr7GS1hzj/qtd0jcyx6SsCTv1d
         BtJvAHWPl0JFCxgSQtdW8/HJyhrlpq3sWXN6H/PWEDWnUuMrnp4T1lcPL8D7Gx6xDR7K
         XA0xcBK0m44yEcm9imbRuyxPBFmNI63BHAGXMsmLEYw5v5ntFqVSq1G6fBjD0UQQCvcd
         kfNeIsODFAp0UkX9EAmrmj7j8n3/3Q5XG23Rqjux+q6zccCnZL82z8CI5Nx4RKi4s44o
         0oPEGTa4MTBPqp9mGtxX/YBkld8GvCS6E4/X11pCAQUuiSTHGV7Uroiq7kc9+A7IT98O
         IWuA==
X-Gm-Message-State: AFq9FYKZiOH/ovoQMC31Kyjddx3OhNvRfTjWrflJomEu2rF+qf0IvXfL
	8MRt+glxvg1+W+sKX3rizxvo0AwP/oT6gHnVS0ISZHVy3r1B+lp+2wqJ0HDZzA==
X-Gm-Gg: AYBFou1U0XlZOIvIsv5DS/bvNTZHWqlya7nib01LWSIzhuIrLTda+1CpnrLPZl0WxdU
	CTD8f0MSHEJfKtmHAYxmi0ekKkVvvp6FGCB/MP3aGXPE4cx0rXYXC8Xve/3usb/zmWEyxIEaUKz
	BxUWhr6l298U/X5AifFM3C+69cHQmCBZClaa1Ccd4Ex22Q30p/T82g9POu/hxnI+61bevDEEYr5
	z1wc3H5likpSxmzOtAMEl7/GLCrXnWClr7v0yyaKSaiLIvAcyZh2wj3X/ATq2u/4eTbHYQLwXHn
	x2owESpZaLfraviO73rEAehK0hyp3zj/X5M7D0QZgBYTA7Cp+wGBRlPkSoOV1ZzU3yH+t+vI1cS
	ye2EkG/ADKwvXYddN8Uv/36jvV4q6aJ1KmOYOIWWPREgv67PITDfnTmbNczdud8Bom5nMU0VHAc
	tyKKAxE+6USY6I3yYhOYhKis4kIemxhQNvCPD68TdYH3OUH63Y6m1fRh4ci3+fbKod8EPzwe5F+
	CT/HblzzBbKbiA=
X-Received: by 2002:a05:600c:3e05:b0:4a0:2391:6540 with SMTP id 5b1f17b1804b1-4a18e4cdbd0mr339855465e9.25.1792043153520;
        Wed, 14 Oct 2026 22:45:53 -0700 (PDT)
Received: from omos-acer ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbb4a30sm41982805e9.15.2026.10.14.22.45.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:45:51 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 5/5] ci: disable guest setup in Testing Farm requests
Date: Thu, 15 Oct 2026 07:45:35 +0200
Message-ID: <20261015054535.844874-6-omosnacek@gmail.com>
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

Our usage doesn't require it and disabling it saves around 5 minutes
from the request duration.

Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 .github/workflows/checks.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
index 82837c4..1f3af86 100644
--- a/.github/workflows/checks.yml
+++ b/.github/workflows/checks.yml
@@ -28,3 +28,5 @@ jobs:
           compose: Fedora-${{ matrix.kernel == 'secnext' && 'Rawhide' || 'latest' }}
           variables: STS_ROOT_DOMAIN=${{ matrix.domain }}; STS_KERNEL=${{ matrix.kernel }}
           tmt_plan_filter: tag:ci
+          # no need for the "guest setup" - it just takes a lot of time for no benefit
+          environment_settings: '{ "pipeline": { "skip_guest_setup": true } }'
-- 
2.54.0

