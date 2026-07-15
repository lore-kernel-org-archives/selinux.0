Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8943A9632
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132461; cv=none; b=Rb8XaeoQJn/k++lcw08/IHhSTgzlWMoovCFtnOojftw1JiqXRmdHHhLs/wy01NgPEAfYj/H7xTcSRyRlMLBEb0HMQt0TkJKYqOdNSQP1DaW28A8pJMHiQfvxm3aDTLK+xPk1qET9jAHowLtdDOBUyzPkRE6phou9LycOCqgcnW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132461; c=relaxed/simple;
	bh=rQB+dxirbyI8Bq/oLeD5LijdIIYzYUIFA6QkPnowy+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbYEp1MlTx5y2OTiaO9X6zN8kmD4Wq5DaVrJibGK5Wu8EWZkcfVk4zP41EPeU/czq6e1cV7nwq9QKl7t7nJAD5FnnIbaU/0mUs8vUox0CierBmiIBMZHsGHAZo7IdnUlD3uihQ11Al2ANbAMPy/x85o/onP78cz8ypuGpOI6k2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSdBztsy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSdBztsy"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e67555e24so175156685a.3
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132459; x=1784737259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8HnhoKe3pen4JbgMrn1q6q5t82++805OkSD+beNey20=;
        b=YSdBztsyqhNiaJrk9Q4W1xWVlhGUq6DLxmwg6AQvzbOiOnHkmc80onFCVBkPzpmodV
         ybKXGMqlGcGTwqP2lFGi6zVNP2KgruE5FtLTf+GSVekD4SNR+T0DvuHG0kCOpMDqoXut
         w/sEvBIfbpRrSiOkryY12qdlRmfVs+rRYwiTPkRUfAZfuC/U37Qr6UU9EuqQkHNdF4gl
         5RsrU5vNoQIeFUsV4xyzSTrDRqMKEMhySR+b8rT7QZ+t8zhZzziWic/3IYD5/+FejATt
         ZAIItd5PmDoQeLSS3fDpaAGw9mAb+PlPX8CDy7RPg9CMu6DXeFPGDO1+yLSBIed6TFwg
         w87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132459; x=1784737259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8HnhoKe3pen4JbgMrn1q6q5t82++805OkSD+beNey20=;
        b=qY7dbbWytoa7aqWgoK/NYxqPd+oCl11oEhi9utewiyNtTSeDc1yz6Ze3GinHfvuOmn
         p1aZ5JN2z+AG4/byalLQDDf6c4vvhXhEcptqOAWQe3rvw5ZGPzDfY0O+vc/eU8Rp4vSG
         nQ6tCrTtcPT5j6/fzH+k8fAYVhgtoJjR7l8oIkv1PZrtK28OPE9Y5aDycmJmZ79CWtk1
         VTQz0NJSZNSCqd1NfKm88Zrnrh3WKIhsHB5e8gRmJr2Js4sSCtYpYdMv/OmiBC7/SDmP
         ltbFOlmEwapwlCXzfL2JKWhyKpNw2g0u83QNXGdD92NLq/1KR2uFGEqvbSFh46qynuMQ
         Isjw==
X-Gm-Message-State: AOJu0Yxkt9+yvMsuNA5hKCLJaZnh607lYMykNfSY01q0Vl7K2PbmIws8
	UqIedeGl8dRO5ap2WaTqpRqmGJn3o6uH+qbUT4QRq1KIB1TSCsfPJ6EqnTaFQg==
X-Gm-Gg: AfdE7cnDaigb5lSODOWpdJr8rpu/1UxiovY5muLTRtjVMlukt/MD9ru3xUspz0YDegM
	NxQcj/cFfjJ/EyvnLLrpE4gIsPHYXxMjxM2QSbnUwJKfT89mE+ljFnzbWmm+sVWZjQxWdUoidcz
	LyL2T8P2DG/55Q0TU2ZObbVdViHKTEmB0BV3kTf/Ef0uZclZH4aVICtjXNIrbjXfTk62x78nEvp
	F0f4MfmRekcCk9X4d29G0QhNZa7Fyyge5pg9iVYI58zaoQ95BjieekA/wmrfzi9CkyFT3wrQ5fi
	tBfYBV0P7efxnKnxFOMEzLGngTgRCqbA/IMUvZEJ+BPigQ9IJo4oCJqNbfM9PUphcvRXoCyS/TB
	L2nN6m4XIEmTXrvvMNTJhe24zbIoh0TOXr6hlK4jBNpoIVLl5Am8Czgj58DWJlzWwRTgX78+drf
	yNnuquVcuhLAXKIKrbQxXyv7PWshTiJB0UkIVOcfGWRrDLuTWYVyLDEYugYr6TrpWvXYnwA4Go7
	APnHJcad3HQMsynlaXpQluDPk4=
X-Received: by 2002:a05:620a:1728:b0:92e:c118:18cf with SMTP id af79cd13be357-92ef2cfab43mr1908377285a.90.1784132458749;
        Wed, 15 Jul 2026 09:20:58 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1694855485a.30.2026.07.15.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:20:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 10/10] sandbox/sandboxX.sh: quote the command line arguments
Date: Wed, 15 Jul 2026 12:20:36 -0400
Message-ID: <20260715162037.42329-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
References: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
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

