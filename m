Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AF2E54B0;
	Tue, 17 Jun 2025 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169218; cv=none; b=AZBXbTy4nE2v6KKBKiT2TUxZKJt0WhtYV+cmGYTNwDHVOgrplyvGQjHSAmxnqQzPCjyBd2q3HmREPHxv58+BRNRn3xlCl/NG0u8WDwUki0mEOO1hxi2FBu4RZaUzpdCzYESFT85mlIPA7gPxVw+Tck66LJLa2JFaQTaKfhCp+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169218; c=relaxed/simple;
	bh=mOGDX97J7oPydwa9mkxx5aqzgviCKBjwnGibx9EpZBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqoLzOnsjpVfjjC9YvCmdyzmNVui1Ed5fxN4EKqcSnh5DEEuXdKMHO53fz4bMSrOp//EWWvdLZn6ISAJWCWKEWgaE6uHti9veEu8ADpt+wcP0bx8MGOcdSJEVmjkuWzT53aeb9Na7YHxnxI1NFXwJ96isi+pXheBQqPkSxJK0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0x1igf5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0x1igf5"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7cadd46ea9aso911526685a.1;
        Tue, 17 Jun 2025 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169216; x=1750774016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7wrybr/Y1YisaCMiTrrVEfWzHGSHRhP8j7GfbuEVjM=;
        b=B0x1igf531HbcfVFQTSBidgNV6jFV4B13Du2SXBoWQCZIcyjzzHYL0nVhsCyJIp4O+
         IrJV3aEEX0H9OPv7v5SLImE9t/Bh0/zkikUn2WEqDpeK1RG+gwjHi7UQSqy08iVVJXD5
         xmoT7IhfoorIgz0u1wsdbPB2F8Ma7IPr565IfdONasrjRRaeGpNrhaTZ63HABukmHLIs
         H7KYob5c8/Y/XOsF6JrSuNmJUfz482RWB3z/B69pg+k2N0iMLWfLZ/e73A3putweTctm
         nntZrhhyxhMJm+AMlHRfLgV2lGe97TlJPyquh2T2J4eaYJp/ZTFOLy/Pg7f13sRdcabT
         q4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169216; x=1750774016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7wrybr/Y1YisaCMiTrrVEfWzHGSHRhP8j7GfbuEVjM=;
        b=fIfyRUHD4TTxzGuOj/4eDRhL3phERY4rboUnS1MlGyvF0M3NmNoAry7C06Sr5jHO8e
         3Yxn7307VLDIEq8AHaF3xL+MECTQKOM8aQgDn0dRxU5cs+sdrc6KUQUCaTcewo7FZpei
         ftMlKlQTTz9kv8biLPp6gWMWssq2nH3ekpPqHG5XFBbn8HlWVCtb8aTGAqZ4wAg4H6/+
         1SebKeE3wnPOpuN7+VVDvDlISDPzElbPfo2VZt0Ji1JH6Ya+urr9Sv6KpaRRE6O+ddVn
         9G4xODW5fWWEAutwCSsGKN0Y03kV7SE5zESEtG8NWW8rcmYALCsKASQ2m5BxtPrjg+cK
         YpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8T+9JuCsj4Z/hFeawseM3HYVQRxGEdk6nZfeAwOnY1J9kcXPzesWrwf0pxqg3qEUn+7uonM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJ+cSlpE3USkyN9FQ40l/6QdHnfO6lRiJOD8Y7ipoLbKBsMdL
	Eltb6VONdvObiGyFJLnbQkyxSri9uSDIljfGtkqyQLtj9crvbvFbgCCHFWt1pg==
X-Gm-Gg: ASbGncsMqpmmlBq14E1Cd/cpf0D7BWnWSnaLdICBUjjVXMqPmViFMb1bdxKLZx4DVve
	wKsAdr/lsM1n9HUYS3/Nl7wprLJAHr5YainG3ZRt9uHBRz3r7KzbCoKgOP9nO2iCL0xihByedyu
	5HvHui02zWpW4PHec4Dh6CmaTJ9/UzZMCliOU8eWLOa56LBSo2S/DJqzhnTNISSfCPMwrJWUk7d
	bMBkBxNMBZ1+8BVc7v6IYw3YmT4wsN4RGR/Mqswc2ygfl6GqKFgvFCcfBXBk3vQi2J2QmCwtt7q
	PqntDqYDwjMjP2CUhEop6UmGptv+7HCdhvBJDXcL2MA/VclVhqkHUeLoBt3NWbHWsp5f+ISHi5e
	RoQFxBzUTavTcuNyv2hdWzWM8IlFwT0UPWdMD1kr+9fzMKrgjyIf5jWGYmbRMNspmvGOKxNvvWZ
	7/
X-Google-Smtp-Source: AGHT+IGGWPiMhQCxCelyvM7zqLz9xMhf1ck1cBoL9Ps4Lt+ZTniNqaIAo965jbI7/pJ78FS0DgIGLg==
X-Received: by 2002:a05:620a:17a2:b0:7d0:a10c:95b4 with SMTP id af79cd13be357-7d3c6c0967fmr1818361685a.1.1750169216222;
        Tue, 17 Jun 2025 07:06:56 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 42/42] selinux: disallow writes to /sys/fs/selinux/user in non-init namespaces
Date: Tue, 17 Jun 2025 10:05:29 -0400
Message-ID: <20250617140531.2036-43-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disallow writes to /sys/fs/selinux/user in non-init SELinux namespaces.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c7825db4e06f..7450ab7c92d0 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1371,10 +1371,20 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int rc;
 	u32 i, len, nsids;
 
-	pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
-		" This will not be supported in the future; please update your"
-		" userspace.\n", current->comm, current->pid);
-	ssleep(5);
+	if (state == init_selinux_state) {
+		pr_warn_ratelimited("SELinux: %s (%d) wrote to"
+				" /sys/fs/selinux/user! This will not be"
+				" supported in the future; please update your"
+				" userspace.\n", current->comm, current->pid);
+		ssleep(5);
+	} else {
+		pr_warn_ratelimited("SELinux: %s (%d) tried to write to"
+				" /sys/fs/selinux/user! This is not supported"
+				" in non-init SELinux namespaces; please"
+				" update your userspace.\n", current->comm,
+				current->pid);
+		return -EPERM;
+	}
 
 	/*
 	 * Only check against the current namespace because
-- 
2.49.0

