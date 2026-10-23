Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780862;
	b=gUaiH0juqxOJh4l95Bq90QDySthIMvLfNDGP75ztjSSUF7BmxqkSU2W6mxUMXwHSIoLk
	 d0GLFQcaViSXujGeIgXTZYhKoAEylU2jpmuh7y8zRa4ZFwYMCC/X5qymkJPEFkB5r2MvB
	 NNwl16uiMxzG9KXIqBtSz5M7QpPd8nxKAGsB9seqvwl73cFQgMfjzoJWYVhhPGtIQxHMn
	 5YDHC77wTVLQDFx6yOe4A9qAH9pXGZR9v9bkP9HkJKvj22iPTNxEw9vLCs/9jhroe1Vol
	 CdGSi8lK/jNP1A1gJBvk1WAiv+Hi8B9VzbXu98tJOGmctDCKyAibEox0qfT6s+R+ouQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qDhlNeSbA4SUsMn35b6n2Jy5uDtFzgV48+b8rX40LE4=;
	b=VCcjw3p7LUf0XjqOIuaD1fDNaBzq6FlilAGmgV4gkAL31T77B3hWj6c+/uIYPO5qO3Or
	 q6q/sahFJifWTnm402Gi/C+gpsf106S0Qi3ThQhzQS+T9+BLqxZNdB9heIctW8R1Ko2+g
	 o1Teg37rxru0mno9HzIamBkfJo6X6G/IaUGszfPJ5M9Fob8CYl4xz1ID7ts5I2HvhkKPk
	 gu6lrn7rw923O4OyRXbQL9q8R4GD7oQzh7Rn+aCoNK0ACiBUJdfmFQNgf589HSd5UCmR/
	 ftO5z8KZnGxnnB7xk2xUEk3Tx98G8bXTlgjSHG1gO1AuG3gO3ap1DtkxKf1crHyUIhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LwKNSBZX;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C4606A31A
	for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 18:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF8C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LwKNSBZX
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-917b78dfe30so17003646d6.0
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792780861; x=1793385661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qDhlNeSbA4SUsMn35b6n2Jy5uDtFzgV48+b8rX40LE4=;
        b=LwKNSBZX+3tmO4wuuSb/00EAAKUFMqnbuWcRxanL8y64Xe0dJqLkvLmaF8WP7iadQX
         pK2DV33UZKV8ghD05QNmKxlg/XDlplAd9BTJCNqhjg+ceQfaFNciQfGPfCXdjg/RJZlQ
         5wSBR+pjHvxp4wF4gE1uSjRx3oPcz8/Hyt3usdERR1YjHpBYzlcD2Dz3sP2zhLDDNr4g
         5PGzxu2l/hkNOnthlcYVSasaSxsHB25wJIUqENPD63OSUK1x2m/KU0Etl23D/KTdyHcX
         gsxMv3x5G+1DYExFwcr6ghSwSmjbJwHGhRiLCFBnBZXIx3LaiGLISR2fVudLL97glIZm
         Z6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792780861; x=1793385661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDhlNeSbA4SUsMn35b6n2Jy5uDtFzgV48+b8rX40LE4=;
        b=nO/UknoHvHwxi0U65sxft/iXOU3zIStmOvNqfEK26ZDNI/rphAryD7WX71nCtFZ0RB
         DXc/QQIT4JfkiJGJG7jxeVstuzygalyXO+Rvs+5N3Rl2OaX+qayrvyKCql1Htj9MSk7h
         aAWpG43AsJqJt4ZL8wClm09J7thtRbajhGbroYux/mSyxXNwwM0J/CfNJawkjWIE0YSN
         JnlMcQ+LsOJLmDRIxLmon2rc6TAKg+i8UV5FwfEsQBek4vuBjS7Pb9hOqfOj+kjp1Rr2
         qEHcgbF1smDTpPs3JjSrX6YRIf4GR2SjoX1wvalakkTxgUqgbQVBIII3rKpupVR7U6+u
         auQA==
X-Gm-Message-State: AFq9FYIFmGv1kcSo010fjYeLj1p++tBr4Xo4ZmSMgwONSX8Db6Moelkg
	HczZuJA6uq4oqNRgfn8+1qsEhI2kgqpujCEjF/RaOdtHpikAE4g8sxkQNfW2eMP/
X-Gm-Gg: AYBFou2iwgEEmu4CTh4l0J4TCPXcTfBfge4yCo8ty7m2DuhXwiEg5t0Sbr/HadBJBPl
	6Bu3ahfWv+AOlMpnLQyQFBYv2ftgJzRi2LLxtVi+4Bxv1rbI4iiVYFgIdHkbmkdTbn9DPKg9Q0K
	XSrmBxNVvUS1FX4Xii2acrV9tWTypTJJUWQyVefsltmXFVdTSZc4LzQd4J6SSOZCGGDIG23bCbn
	DBkPdEeLv8k1EP9NZlOCyqhDRFuPsVNF04xGVAqnpNyJ12+t/2xsT3mun4gbudD04y7yJS2W1Yi
	3YWaMO2/o/PWFokI8bUETedvb4hXJvT0dwN5UJBYjvTLRxGuiZjMGbUbsRxDVEWDnT+jz9E7+dd
	lbxoP32s6LkTQ2EDvfGvdI++9BwYWe7ctVghE/23hldH8rBopyt2aIgW+rRUK1b+du/V0LE7GxL
	B2A0Ej9Xf1VbnfnvfpthDppi1J1acmTxDOhPrhjAKOrZs3OvSJi8gFG5/AOgKuFSQMuQKfPqCnp
	gLC/PGuD7WvGcecpUnyGvE8MZqF08M2wrbNRna4kS7fbH0Jh/CGmZD1z6uA0NB/6qjTURC+qRNe
	UuxNV0cAh6JLCU0TOTqPbO+8Ya5/PVYCTZL86GB3se255ow4DtfkVyqfz9HhEXvJluxlVQVBlMr
	ecfHHAvStTJQace0oMTZqag4OdZJbWt9IgmQXFLjw2YtLpgFtl+mvaY3hKOerbCo=
X-Received: by 2002:a05:6214:76b:b0:919:96b8:d1cd with SMTP id 6a1803df08f44-91c3a9cdfbcmr42657206d6.26.1792780860515;
        Fri, 23 Oct 2026 11:41:00 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c0fd12sm1662536d6.17.2026.10.23.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:41:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cathy.hu@suse.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: release the transaction lock when setup fails
Date: Fri, 23 Oct 2026 14:40:46 -0400
Message-ID: <20261023184046.61448-1-stephen.smalley.work@gmail.com>
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

After acquiring the transaction lock, direct_begintrans() can fail
while creating the sandbox or final output directory. The public begin
function sets is_in_transaction only on success, so disconnect does
not release the lock after such a failure. Destroying the handle then
loses the descriptor without closing it. Other writers can remain
blocked until the process exits.

Release the transaction lock on both post-acquisition setup failures.
The existing release helper preserves errno and resets the descriptor.
Leave the lock-acquisition failure path and successful transactions
unchanged, so a failed contender cannot release another owner's lock.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 05c9392c..db74fe93 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -422,12 +422,16 @@ static int semanage_direct_begintrans(semanage_handle_t *sh)
 		return -1;
 	}
 	if ((semanage_make_sandbox(sh)) < 0) {
-		return -1;
+		goto err_unlock;
 	}
 	if ((semanage_make_final(sh)) < 0) {
-		return -1;
+		goto err_unlock;
 	}
 	return 0;
+
+err_unlock:
+	semanage_release_trans_lock(sh);
+	return -1;
 }
 
 /********************* utility functions *********************/
-- 
2.56.0

