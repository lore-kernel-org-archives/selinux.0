Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB7264612
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781447817; cv=none; b=YC0lUYvnl+9npEuQhRTTgtleplsj+OggaVbeCnxzAi5ubNfy8nUwmqoRCMGBoTDSd+1873k7+vWEPBcUBZ6nG3d9ZZYP9zflC1RKifkNwPeQ8heO+sAyS6vXa+yHK+7j1pP8Jq2FakAV85xlg5RMFws0J2qEzn+2kRzBt2xga60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781447817; c=relaxed/simple;
	bh=9GtIV+z/Mpa5Tz2vD2bh224O+Gk6E5SNeo6b2O/ijbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN0nmkjkb0cS6xCVCeHPBpaLxomZ69XV5IMi9AX98rwBqU+u3sjzXeztXftHua/tM1Ov24G1YLRwSio9cBmggYlbrlgCJb9b0GSgBqQN1IW0roImJRgz/N4DS8vuTXd7VE3crqLQIvUEV1KPzcE2jy/O91vVf3mf1Ojk4AHu4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=K9NFfr+c; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="K9NFfr+c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fVGppv1MphNrnynYYaqQXjcVXZCRQTdPiThMrADns0c=; b=K9NFfr+cCUNvue90r1qJSKLN7C
	G4FK58n0UKKCL5XP4s9/GjrWSd9yU39A59goJdoSLnKklhG+EEKuRpGjmlyQAuIWj/emlyWk4led5
	qrPaYqp7k3MUHvPUO6+9RyuxERAz69rlZlJlLuVnmTSVYKJSpEU9j+tg1b3VxawrF//S3dqmmhfFO
	A+YRVJd0EC8bjVnVSzeK8u77ukzUr04k/LWc74op+AMEIFcOCEfUXFJeKBc0jF1FZ98OCe7sSGuRR
	60k9bqvltKfAwWqX9MVur5D37rs+TeLIYjxkRV0fuQIjcvO2MNbpBVlDdJ68Dhaxadm2qzGqda/VN
	C1m3RBNw==;
Received: from [87.95.76.183] (port=4493 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYlxF-00000008PB3-0ZQa;
	Sun, 14 Jun 2026 17:36:53 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 1/2] policycoreutils: use null character in strings
Date: Sun, 14 Jun 2026 17:36:44 +0300
Message-ID: <20260614143645.55809-2-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614143645.55809-1-kalevi@kolttonen.fi>
References: <20260614143645.55809-1-kalevi@kolttonen.fi>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 policycoreutils/secon/secon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index 2f2b06ed..6d4bff94 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -373,7 +373,7 @@ static int my_getXcon_raw(pid_t pid, char **con, const char *val)
 		char *tmp = strchr(ptr, '\n');
 
 		if (tmp)
-			*tmp = 0;
+			*tmp = '\0';
 
 		if (*ptr && !(*con = strdup(ptr)))
 			return (-1);
@@ -422,7 +422,7 @@ static char *get_scon(void)
 				    " Couldn't read security context");
 
 			ptr += strspn(ptr, " \n\t");
-			ptr[strcspn(ptr, " \n\t")] = 0;
+			ptr[strcspn(ptr, " \n\t")] = '\0';
 		}
 
 		if (!(con_tmp = strdup(ptr)))
-- 
2.54.0

