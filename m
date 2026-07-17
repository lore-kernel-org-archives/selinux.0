Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB5386559
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313674; cv=none; b=merY5YAp3pP8mdVP4s8pkVhj6SHEHHDk3p2I9vKHnpI4yydyaEtNFB8Oen1MKfPt4bN31K/VgPsrsdLCAxBZ8P7g+BBLqZumfYVXUauZmfrh5nnn5SWCTOMC8cq7ikERGSchzf7Hlv4cV0acD7MrhJXGAONL73hnzEEAuZm8l5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313674; c=relaxed/simple;
	bh=KKjZKT3/jEfdoG9IkD2xJmg4ZLstHnpVvbj0OL1jDuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnpE9Mm/M17vVjAIpfPmFoKWN5eyFnmF2kftUUiIytFjsP89zSojr0rFCwdMaNAd6THKOIweSf9eOE0rg0D+GekV8rn/xkTZ1DTJfLTJfw/YF8HwYjjtgTivMbGjztLnFRoSK2/tdSe6dbygPgGa7pG8S8vEzITMy25aDHVkFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+tuBMj5; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+tuBMj5"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8edda5d56a5so84586176d6.3
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313672; x=1784918472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8QHIFcU5WsBfnp0KyAjDwiZsl0HoIuCcaKlgek+UMM0=;
        b=P+tuBMj5qpwxstFb17RD+XQ2Xy7NUDUTBfptwILCLIIsE8NTEWKY8dBPkO4OYSCj9R
         FisdvVC2fkxyCfwJc0vJqZfGZ588E9oxbuWddT5Fnj89UmqiqkYINKBh3A0xmmARbtFS
         CVfdkglXsXB/Qd3lbQjjcGy2qT1PwAw1ohUDoZUHnebexJv8EHoWABIefzP4LvviB9to
         qvqZcpwaPJcpKfSzqWw+rnUib45zpHvc5YHt6UK3MMfhUj1Rjy3DMlegFgnHgnRerSS5
         njOo5CHEmIMM2ppuu0mSd3/E9d1RPXni/l8Uvt3Ur+rbH3YmsIdKVtqhehURLjD4plIc
         eEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313672; x=1784918472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8QHIFcU5WsBfnp0KyAjDwiZsl0HoIuCcaKlgek+UMM0=;
        b=oAUAbO8lpkkxsIFCk80/3Wi8tbnBGBYig6BS9oMaiAJXsdqPtnQ14g3S+JkrL1Yyg7
         D0IHAigRyO525Q4SJ7Lo/Xr/pBGM0oeJbkIbfcI37yU5GD9eTg3vJQsHVpQAnYQ96Lc8
         997WZLdHjWu2IlyOuq7nJvwpPYsbOXSWqmnNk+PMqTwLttyy346BiKQdNzAni4beXYGF
         X/59awt1c+USExAmMlwEKX+v86xJw2PPhj2P+KllNIb2CE1aIO2NI9EtWObhAY18yxAo
         nouLb4efB93Lj2gigzyEtUATlxQ6Y1iDrYevaxNK0r29f5k1zblR9KmTDIaLmWr2HeWS
         4OwA==
X-Gm-Message-State: AOJu0YzlQ7M+A6DfWLK9Rs41Z3aeC1JWxxKH7tFqryK2Pvk6l9ePFNoE
	AHrAT69sfp3u1PThU8DuHwJH90+pSdRSlHI/DFCeikcsQQv6tTeQMNcKbrMqVg==
X-Gm-Gg: AfdE7cnImIVAGwxsK0BCpW8qybQdxjiPulvLX3EVnyHI2vc2Xc8RTljHMT25jOdjgcm
	ceRfNihNzgPlX/0dpraokpycPjsiqVsq6SFbTQJ7XAKncodM2OaHX6B4fTsof6fm+ZFo4loMJBz
	rb8Qx6EOV6QKDthF959sBvapQoD3vNKpR55t15w1wCXzclvFy1kYeHJ7+agX5/QDFQLbYzBSJxJ
	B87+wAwStLkaMj9YOSvAH+Du0m9kpgf1B4kz4SKkmB8jeZFoQsdpL/CUsP0s7+zZznwxSJwAhjS
	R/n/JUvFGJRad7MS51ujTDoyhClxEVbkb6TveaYW96YSIWS7+GuW4JBY6+f4Fq1LynrlUHBAa7G
	pBSk6iF6CbB6hPQ62cCadwJtwWtZeIK2fnXe434CJ6PzqPgwCplBxvZW+kPUsncOFdq0EnrIVmd
	2F8nyZLgKbLoowI1lz3xVmmxMFwpgOEBSQMdX/2uTh4Li8TNkF6XbGVQYG9AegyA8Bi2pybhMAH
	zqYoQ==
X-Received: by 2002:a05:6214:4292:b0:8f2:940e:2423 with SMTP id 6a1803df08f44-90778312382mr48143176d6.11.1784313672042;
        Fri, 17 Jul 2026 11:41:12 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm22756576d6.30.2026.07.17.11.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:41:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 09/10] sandbox/sandbox: clean up the runuserdir
Date: Fri, 17 Jul 2026 14:34:24 -0400
Message-ID: <20260717183424.20324-10-stephen.smalley.work@gmail.com>
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

sandbox was already cleaning up any residual homedir and tmpdir
but was never updated to likewise cleanup the runuserdir.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/sandbox | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index 8c15d659..d909fc44 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -532,6 +532,10 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
                 if self.__options.shred:
                     self.shred(self.__tmpdir)
                 shutil.rmtree(self.__tmpdir)
+            if self.__runuserdir and not self.__options.runuserdir:
+                if self.__options.shred:
+                    self.shred(self.__runuserdir)
+                shutil.rmtree(self.__runuserdir)
 
     def shred(self, path):
         for root, dirs, files in os.walk(path):
-- 
2.55.0

