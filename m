Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4138A725
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482536; cv=none; b=Q+/zp08IMvUzsiIuYhFYA3SCTne0wizA9b4Vpz5v5yiVHMQKtBbE2HGNzqekpkcTugYZFPVxMCHoqbCNf9vEECnXlef2M/f4wRvH0I5hRGcIR3cGPKJS3wW2WKLfHwZv4AFZPY5YNBQueA1d4Mg2mS6aiMsuMg5LSYGN6yPghIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482536; c=relaxed/simple;
	bh=bFG8Pm7y+rCxj7LLFYRb+T/eJcqdSqyR3EyBn+2yBoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czo82FjH7aHryQqZtHKnblXp/zsyKGA2Xd3RHA0vko6he/rvk3fMAGJBDvPTChD6+l5arBCqzjDVUrVSSBufeTdWME4VNO8fSwKpUwMTD/bjp6/GskzA22ZmCAMBvhm5GbdfKh0XDSUIKoBVh4nknHSAAVtD8TqX9X+QMSDQfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksll59iU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksll59iU"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb5c9ba82bso1873234585a.2
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777482534; x=1778087334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEoW4G6g3hqq8fT8TkFKK+m7V51raKP3WgAJD4HTNQI=;
        b=ksll59iUGzstBurVshkXJBTZ4+k8Pd2qWQcCb+9j2Q3kdWGtflljsKBPc14JXIgsRp
         OsGxdlhb/O3nbnxFzSd3gidBbAMk/zOOsKWAxQw2dmKhv6kZPisx8QsQJ70jP1nK5oOz
         Hgm+4A1Cag3wtgvBFh3957JmuowOjrM76Z5YExAlh/LH1cWOdUeFVczSzGQsHw1zIPal
         bQk/UpcHJlNmDk0LkfJBZqlNr8CVtNVdQj3pIJrUOXX8wejqBMDpsjIfqkeH/3gwTlNm
         qpIX+53or9vIoQZT3C6U57a2xPTaXwuvvQpf2drWcqstUsAbNpJZslsY+9zS92Ni7c+W
         veLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482534; x=1778087334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zEoW4G6g3hqq8fT8TkFKK+m7V51raKP3WgAJD4HTNQI=;
        b=CMHRojWo50EAfydMLD3Q4A+Hlo3Krb5KAgYdPqoldvSeX3xq3uGRp5hWSjAbKrdGa3
         wZPobyrbwrz1cBj/+2mpS7tQg9aULDdP6EVMbMtcmtVFaWdvunDtFBdvd1oKJlasW8X0
         LisUf2JW8TXBxUMvCo+QE1zmsQyzgLqPKyy4PhS9g2/47pEfLBoOz52P4NB762lKqXCU
         FDQtQW5ZR/VM9jRVtuIjtkAstEi4/kUG7Zj0xfaP+1TI+xSeshAUgyBrdb9PqFyXsjqP
         Y0W5oL19V3ukcST6bLYgIa1mLVAhaHoC/razaikpno/1q8OUJNhvcxyJ/lFXO3JZFUyr
         53EQ==
X-Gm-Message-State: AOJu0Yw7xRZ7Ch6dDXK1Ob3zc4ysvDBN28jr3EFmOFK4JxEME1PUNq1I
	qKtjPEg1zyxlXRtPJLBEQEVRhGrtOc3sF4zFk7U3YSLfgscqXKruKQ1XQ8t11Q==
X-Gm-Gg: AeBDievBZP6Eem6HSTkyWl3KW+2Zb1Ynhoy3Ie5O0BLG6fDu8hc9rs8ItRGHjH02MfU
	Y+UuG6Qig9MJoncxLCjsvZ8phJuR69pmfqW8rPEzESjT1HlZisRs28TLvzLnTheJrbxc7N52w1+
	AP5Cn8Q1tIguWxCAIg/LMjFoowqb6Dch4lQBxAGzUi96QiyYcHWtvGYwiX3Pa5mQS4klxYK6tbh
	FxvPybSfk9ruyPU674dGJB8b5CflvkoqS8Rq41EVHUB3QiUFp5RGjpN1NJhFYJJOdRzN8wizjTa
	FGBn3EpKEauEIBMkKDR1jiMmDW4Zi6cgK6Du9aaeAJD3iZxcJmDKrYBBB17fOVdlOHf/c2XdLZv
	jeF6MUP3Ubh/nvaokcaHDSFTu8iQuI1lUr2om36btYUe+R9P+jzWNf364ZYiR604tbyqU1mz4FK
	7rR9Gv3gpvv3ogc04LUmT3L3SCYL2EoX3ZGOD/ZxnYFrio7JcNwLhl/eXOx0LwAUoUn6IToBFzC
	e/SENThVykndrVVxHjgP2Oz/4CQqM00qKyldeUNjVBoEtQlgIjrey457/9hM58nWw==
X-Received: by 2002:a05:620a:bc7:b0:8da:384b:919f with SMTP id af79cd13be357-8f7d6e4404amr1164627685a.5.1777482534354;
        Wed, 29 Apr 2026 10:08:54 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93f58333esm225980685a.28.2026.04.29.10.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:08:54 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/3] selinux: remove /sys/fs/selinux/checkreqprot
Date: Wed, 29 Apr 2026 13:08:33 -0400
Message-ID: <20260429170833.2581-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429170833.2581-1-stephen.smalley.work@gmail.com>
References: <20260429170833.2581-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a7e4676e8e2cb ("selinux: remove the 'checkreqprot' functionality")
removed the ability to modify the checkreqprot setting but left the
/sys/fs/selinux/checkreqprot node intact with an error message logged.
Get rid of it entirely.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 63 ------------------------------------
 1 file changed, 63 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 5a80aff2a941..5afab8ac01a4 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -57,7 +57,6 @@ enum sel_inos {
 	SEL_COMMIT_BOOLS, /* commit new boolean values */
 	SEL_MLS,	/* return if MLS policy is enabled */
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
-	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
 	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
 	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
@@ -633,67 +632,6 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	return length;
 }
 
-static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
-				     size_t count, loff_t *ppos)
-{
-	char tmpbuf[TMPBUFLEN];
-	ssize_t length;
-
-	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
-			   checkreqprot_get());
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
-}
-
-static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
-				      size_t count, loff_t *ppos)
-{
-	char *page;
-	ssize_t length;
-	unsigned int new_value;
-
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
-			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
-			      NULL);
-	if (length)
-		return length;
-
-	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-
-	/* No partial writes. */
-	if (*ppos != 0)
-		return -EINVAL;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
-
-	if (sscanf(page, "%u", &new_value) != 1) {
-		length = -EINVAL;
-		goto out;
-	}
-	length = count;
-
-	if (new_value) {
-		char comm[sizeof(current->comm)];
-
-		strscpy(comm, current->comm);
-		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is no longer supported.\n",
-		       comm, current->pid);
-	}
-
-	selinux_ima_measure_state();
-
-out:
-	kfree(page);
-	return length;
-}
-static const struct file_operations sel_checkreqprot_ops = {
-	.read		= sel_read_checkreqprot,
-	.write		= sel_write_checkreqprot,
-	.llseek		= generic_file_llseek,
-};
-
 static ssize_t sel_write_validatetrans(struct file *file,
 					const char __user *buf,
 					size_t count, loff_t *ppos)
@@ -1864,7 +1802,6 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_COMMIT_BOOLS] = {"commit_pending_bools", &sel_commit_bools_ops, S_IWUSR},
 		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
 		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
-		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
 		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
-- 
2.54.0

