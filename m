Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782316;
	b=c8dTCI35thODo8CL/Res+MvxCXc+c6UetCe0beJxDWFqJ4Laic034bz9Wb9cXu+OHyAz
	 cTv5WePyCwy2LBQdATq2IaYlcbVGgV/2SCCxv3TbG46SJuwRtB/EiEkNpcQqf5Cz1TTc4
	 hzHtDL0NFyuGvEyc74y4gGow/MH8dRu40EKC3cVr0q+JiO1Q20ancctLFCHOB8LgwzlTf
	 t8DLWGXjsWPkuul5wLbO+rxUbZ6bI9iNNeBZxOFQqlz3Qfb384K3uMZBrUxEKSiw5DQsH
	 B5MOm4veUGLaCQt3TIVR0NhKi2NfNQ12e6Tx9w7Ap4YpIyBWQJ3K3Ff2Igc+21qiLog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IFmNQMu56sincwYNNXrSRRq0O6/t7cnt7BoJf1qtRbY=;
	b=wlpL+SpcP6DcxJqwJ3bYArFJX/8+0f1xXLwD/RkG6ocVf5IOwT9Gk8sinYI/e71I47wC
	 qxDygGoDg5RaKT0E8LyPxGD8XzYgUoADYNE6aiSo/oO+coIQ1mfSXVao6TjCpCyZAVbMN
	 rfUA1UpME1BErTfNljImVymdPzNcSlr2trBJBRPqOI2+pSfNZTQdWcMO8LOT2vVWUzMYF
	 /YGCGRtyBsjPfjNzNdBQDpXq11d53Qd6Wpdk65tAJIb5kKLwBv0VEi5qNBwL+5V1H3UxW
	 TTrrGDANdEGGm5kM4Zvr58XcZmxJv3+A6ykbOF404amfrnR2HDpf76zu4SH8xGv+qqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N6OZGvY4;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C0606A31A
	for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 19:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 149C0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N6OZGvY4
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5364c951da4so10408171cf.1
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792782315; x=1793387115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IFmNQMu56sincwYNNXrSRRq0O6/t7cnt7BoJf1qtRbY=;
        b=N6OZGvY4mXi2UqU1bj7Dze0AXmp9CxZF22KEC2MVClhuHSJdSF1bVhnjzo5fqiWtcn
         43zQLc50qbNdptJjTXxT2U+iyaqKS5+hSr23NuyY9ias5ylMK+lJuJe6pJ77t+wmCGYA
         sqkQDcZGtNc766g0WY7p6ZyF99AxD6jiEaGQtSmJZJM9PfRZTB/J8fOBam451Jh6Sq5f
         QxUO7AZJ9iwVncjN+HWDeeJqs1TUFfPtAcIyR8Fd8bbd7alGphNjncWzQCgdFgIMk2Ie
         ZWaeZMaC0wQYqV+/ejTAzOXvf4mNwAd8xcxIr93dd2ll4Ts5vaNxrAsQPAzTntiX0w+0
         eTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782315; x=1793387115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFmNQMu56sincwYNNXrSRRq0O6/t7cnt7BoJf1qtRbY=;
        b=Ct94Gzz83EOvvLwKEthRP8TrsYwST+dg9LeyoGY31Usm6gHn8RmLnI9XX98EHJKGt7
         DFcdLWdVmKPmWUYf7KM5Vfj+J6Jb7YoNmEIVIYRJNkBgvB/lI5XStJailaJ+ALrwDRPR
         ziupB1RnoGDDPEguotANhhy31X/8ZkGGKNuBMaDUjLli8D5iQNit2onPx3Ed8HZ//n6Q
         Np6XID1oNFdqQMFO8LM7ZdbULGaRssm7AS3C38nRryxdS1+QLQYuw93VvEQG3xNoh7Fx
         alh/JJV7ofboYyd12c83mrz6HtXxDxcjBWa6XK7FCmBNvDdwku8QobWGUracuM1qXAoO
         bICg==
X-Gm-Message-State: AFq9FYJ1uFLotCmIORj1RHJK1XUqLdSMNeQ3Xeh9SDVyUC8p5QteOzaC
	YoF75o+/62JVHPLFSKitFzxpqfk0Ggm2WLWpWbkptOb+QtQKQtd1z1R8WfZMc3UI
X-Gm-Gg: AYBFou1jy8itN9DMyheek8DypuD8pSyafUrw1/AMs0lmviZQF9SIE6tmoIyvIFmKnoQ
	zyHlnyBuzkneAgZjdm+L07r8MwTmkLFQVbxqvSnGMweyN0FFL1OBdERZ2rK1SxBSCOj3j01YQKN
	kqfw8prGeQdev1BlRWvStR/wGFx7eFDfw3DMpJUOvXweG0SjfB8G7/C/Ui1nmvqH7+MYT+pWR9d
	r7JZJAn8t7PaAV5FtwZ6ZBkA7cGYp2KYNsUZQ5O9eJn6Cf9utG1cbZtJNtZDtmmIAEcaljAhESs
	BNV5vjZQnTX6LCaUmgGK7PZTelgQ7vtv1Pfma9TBisHNijKNUgN3Xjy195eOpGX9aRXr6vzMODX
	LPmC2Qv8HrdhnWyrpxR/266/QRnnQ4b9T+vMoMyeK/eLMMit1CJd/jl1jnLb62R4FFjm8FBhXT5
	1qhfu2uuDp4h7v/+eRWIHCnyS5RdC7M0+EntCmgcTd8dyHs+vTY8ZDtnWJLnndkWUbodBYcjiul
	lbBZ0S8qFn33xfev3o2OjEbenV5tFU6YDL9X+ApxDuFiMUkweJX2+ZqzbFWghJvD6IDKhIyttlU
	xojPsqculvGFmTIBXwxqmq7AghooFCMtkkpMSNU8dP81rOOXpgUcui5LGc/iCuc2Nff9KnZhseU
	kTphHIjZs6+H/XgeaW6a7Ter7mUnOPFrnQfPrjpriqWM3gRENH/TBBeaIJDffLPk=
X-Received: by 2002:a05:622a:17c4:b0:530:fd73:6c22 with SMTP id d75a77b69052e-536c1f3cf3cmr46453401cf.0.1792782314889;
        Fri, 23 Oct 2026 12:05:14 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c518csm1300781cf.8.2026.10.23.12.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:05:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cathy.hu@suse.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: clear the policy file pointer after reading a cache
Date: Fri, 23 Oct 2026 15:04:38 -0400
Message-ID: <20261023190438.62456-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dbase_policydb_cache() frees its policy-file wrapper after successfully
reading the policy, then queries the store serial. If that query fails,
the error path frees the same wrapper again. Clear the pointer after
the first free so later cleanup can safely handle a serial-read error.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/database_policydb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsemanage/src/database_policydb.c b/libsemanage/src/database_policydb.c
index b33b6531..f65b475c 100644
--- a/libsemanage/src/database_policydb.c
+++ b/libsemanage/src/database_policydb.c
@@ -127,6 +127,7 @@ static int dbase_policydb_cache(semanage_handle_t *handle,
 			goto err;
 
 		sepol_policy_file_free(pf);
+		pf = NULL;
 		fclose(fp);
 		fp = NULL;
 	}
-- 
2.56.0

