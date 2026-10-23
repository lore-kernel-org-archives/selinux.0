Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781412;
	b=uuRlnIXzKJYP5ZyEMdgMqTt4yefeApRxMQFd4vm2eteavn2+yidYHCUnd7O9CwjBSEhb
	 I/jW/Dq1Y5mg/TSTcRB4Q2t/NTM+cJYEXib8jsxuW1+ThJcD0Cy5MEUg2H2hHwa8jfy7X
	 CwM3RjsQCKVouBzGUuAScs/unDsPe1TXTFsevJ7aS4UiwksgnR5QyZEquqxAhH1mUgIwS
	 WOepxEK8REdHiMOU+BvOP7xUXCQ5sVgV1THWEYgo6SXxql61krmn5jKkwo82F3x8zpaD/
	 nWHvKlQkUl88glmdakYSn/VMZPNgHjNKpsbDjXNOqas7/sEosmUERR38h9XQxrch6yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=I2NMPXemvrYaThAydloCRFXdD/kg0bGqfivS5Ekz6vY=;
	b=r5AqIWozluUFzogdrMW6WzFVDVnJqXQoJIpYQ3YDFqodI36IzAFE9QiufDEnX7862DpD
	 gbVYYn6HAGIHQkwk+gTLd4v8ziagHvTPAnrQt7max4Bn7ZMV7Z1f5v8wwAyr2YE9I2tNd
	 VXgx5GO/ugBLaXaSnXM4UhK8/MbKTVUmGuM4f+vaVQ/TLFHNhbaHFnttX2ZTSD0Mg9qw3
	 dQgs0yTaA0MwxSaND1ohhp0N3JVK5L9f0ZYagN33vPt1ANscnomvgSUlYUL1o7xCMuiDu
	 3CSjAANHupYEptTopmxLRmEMxj0OXrbryYqJ5356LZbC9KFU5VszV70CxTRZHpBrMSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lN3U7cCJ;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554B606A31A
	for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 18:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9554B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lN3U7cCJ
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f2493c28bso99094185a.0
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792781410; x=1793386210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2NMPXemvrYaThAydloCRFXdD/kg0bGqfivS5Ekz6vY=;
        b=lN3U7cCJW3v1WwAzrmQUETT+HwvPCzC5YzOHIaM1nGlEPfxKPOwdOYvAiSW2oUrSN1
         eQkn4ce7/njqrBzaYq0m9++JJCqXucqSlvx6+daUaH5iVfX4C1Z5XLpkhwyOutrZxf4T
         vlQC6GeDYFi3u7RP0jB+02ywRZf0w49h6kYVP5u8ULEyzg3WyaIL0wa/1z+K3NrvzCda
         QcVH8TTkakt3xZ1wnSnAwqpVMPpsPGU2PtdT1AetyIVJvxFP+Co11CGzZ1+QbsIdinyJ
         qo1n3NkzQCD/Rn82hgN9GxJZkOqZe3vL5E+LIt+rN8X5Hs4LRoQN/eAbus3HjF1t0UUF
         DnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781410; x=1793386210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2NMPXemvrYaThAydloCRFXdD/kg0bGqfivS5Ekz6vY=;
        b=eLiHaWfgXYGqIvAyJdlKvTI9EtZ1UIaGAV6H0kOw9fz8B7lQe/rAgleP5qg0jOYGmj
         6Ng3D5TlOk0QwJKnGIpmRChaxBHbS8b1sFeE1as7OaPvZoQL7/mGwqBQS+Wvt+jjv4UX
         ShkcEiIh4Aj0mFTgqb5l/+kg84jszHVPmZbGA+Y62h9MbJC5IZ2RDb0YFL1zEM2NjDNb
         qtDhYcN2CJFDZ/6esA9D63eFk7sabAOnxITcPCbtaGfjapuUCwmx3dnFuiXLKWivAkh4
         rGruFzvyrrmAKQ0+96gnAHLudk1dm7fEKHgYVFDj7eHtKfT3CMwo/g/K1gKUgptduY4g
         jsaA==
X-Gm-Message-State: AFq9FYKldFBHvNF4L7aoxO4pPcEmflQDdtbAbug7nlpUI6j+fNLyPD94
	t9qpefrAuum5hftkUwp4yByUB7/QkxKVxbFjX3Czk5REOQV5eT7mERrspgrwzwtk
X-Gm-Gg: AYBFou2sw02HQfRUs1WBxlRYqQiiWiGT2qoTyj4qykUQylP35H/XbbARl6zPrFPtgGh
	B7lhS3NWnkQq8dfzKeIRm/ySWnczT2pF0vwlN1VrKny6UPDU0wzghU/rEzlvVFSu9IKpwGPFGPv
	sDAc3taFg6ukPAOWyPWbOLtPP3iNbaeadTHcxJOxSMy8VzXMEGsGPk0/RYT89xb9uGNn3V2paMF
	G133MW3JtwlI6foqfSYEC/6PJnXLi3pyuXFdgSVBlb66+wL803b7HWE0dLMtOorf0ZBtVn4B9pP
	0t05xp2pVs2q4xz/jj1QKywSHJX6mTcMvPsIGyyQPJkdz4lGNkwCGumn1FkzmNu3ObK31cB8kxQ
	bHzElbM5mnjMNb0Ez8diAEyUBznMGO3Hhvj7Bl3NTRqskFo47ANaXUzg2PuBTuK8Qz3wXF12sTh
	xF2RZi0HOgE3riIG3V8UtMXKi/Tm3bLMZtD3r6OvhtuL5OwnjZPIyNFb+55X6eKxbwCfIpWhbPV
	IGXMmvGiqKdE/Q73zV8Pc2S233gn0LdQ8oKrxFwrb51nkBvvW9CVGk4MxhGBeff4Xi+8GkiOhk5
	zvmkkMGWheA2YT+EvISc53t27ae1zA2PiMPpMs9OokEGBPOljEFa5DIr+JSKZ4teZMnZHHKKHzW
	Ogpzl3bPRDqRezfaHBWl5K6DgmbxO8zeCNE5LaRduPg==
X-Received: by 2002:a05:620a:2b92:b0:93c:c2c2:40eb with SMTP id af79cd13be357-93f6f84ff78mr556788885a.66.1792781410516;
        Fri, 23 Oct 2026 11:50:10 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b1c97esm86280285a.30.2026.10.23.11.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:50:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cathy.hu@suse.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: clear freed keys during component merges
Date: Fri, 23 Oct 2026 14:49:56 -0400
Message-ID: <20261023184956.62086-1-stephen.smalley.work@gmail.com>
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

clear_obsolete() and load_records() free the current key after each
successful iteration but leave the pointer unchanged. If extracting
the next key fails, the error path frees the previous key again.
Record key constructors such as sepol_bool_key_create() leave their
output untouched on allocation failure, so cleanup accesses freed
memory instead of simply returning the merge error.

Reset each key pointer to NULL immediately after freeing it. This
keeps cleanup valid when a later extraction fails without changing
which records are merged or how errors propagate to the caller.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/policy_components.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsemanage/src/policy_components.c b/libsemanage/src/policy_components.c
index 767c083b..cd4b500a 100644
--- a/libsemanage/src/policy_components.c
+++ b/libsemanage/src/policy_components.c
@@ -44,6 +44,7 @@ static int clear_obsolete(semanage_handle_t *handle, record_t **records,
 		}
 
 		rtable->key_free(key);
+		key = NULL;
 	}
 
 	return STATUS_SUCCESS;
@@ -81,6 +82,7 @@ static int load_records(semanage_handle_t *handle, dbase_config_t *dst,
 			goto err;
 
 		rtable->key_free(rkey);
+		rkey = NULL;
 	}
 
 	return STATUS_SUCCESS;
-- 
2.56.0

