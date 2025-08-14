Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7362302769;
	Thu, 14 Aug 2025 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178041; cv=none; b=qBgKYcbA519UqCC+8Sk+jYCalz6dVMWLm99gVZCYFCfqlt/RXke+hwkHs6Uaxisnq29aykJ7RHZb9gWefJC0pKzUaBItrl2rcYgTBvN5MIFV5ldBL1NcY0hmVctriSatdKHRQPgaZFNQUpNOi1Oud/tD3SWO8n3DG3szSgCRWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178041; c=relaxed/simple;
	bh=o/lV0c/XhamZ6IAcdmeEk6c4v1Gf8CmfPrqobccYEBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTiMES0WPavZS/dgfScI2yQqnVt9/Z/Qi/HuNbV6T49it267YS3o4zQYbBfaoIuiTQlxoBBBQFdcZvsBVEOoQiiMB2xTYEDrj8y+7esMEhnwDuNvrv3QJBmeYGXnlvKlvOC6PY87zd/TKcu9MIwxYhf4jEhDOI+FRPdsxxCbOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMsJr8e8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMsJr8e8"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b1098f9ed9so6474921cf.0;
        Thu, 14 Aug 2025 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178038; x=1755782838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4bCnlr99OE4sZ9tGac9RJY64px+kEU2JOgwxjoTj2M=;
        b=nMsJr8e8uRYW1AsEVYHq0oX1/2HHDELCtoCRSpRsSUpzlPuvaKAqOhubvhTs17fIEc
         W3u7rJ8S08Cod81tZIsSjTlUyDnqqoNssSCWSHaz9KcWa5OTloqo3h5irGd4etSiVZBe
         Z/vt3PyIj1bKWpqViiQuu5oG0gnWEtAFzHXNgO5FQPMM/DZhm4xpf/RlUGzuLV1dg/WV
         WWJD3v0Q8kPOouzsUf8VMIzFJm1X3/U/0ecyd0sEFH7+1Mm/C6inxY7y+0MhUDY6gB28
         NMqdAa+YixUvzU/MObaXJ5d28dcHBJ81x4Znx9tKRjZ0kDsxCRm7eapC92eti3PKBBjF
         6Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178038; x=1755782838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4bCnlr99OE4sZ9tGac9RJY64px+kEU2JOgwxjoTj2M=;
        b=aqucjOEECoCRmbrTt+FSCt76FT4j4FzulS4W/pH/SRIkS/bhmQpHj6OS+pK72GZnpG
         x1m/cPRLH37EcNtCfN2ig3NS0EWDpiF1DRTVaQsE0HDuwcaCW71z2vz7muTxce08r1st
         dj46Z2Ri5CbnUpRlhh1y5yeerTB/qkXgREqgiRiJ2qfGrnNx5UVUt8thmd3bKS7mYTm9
         vCbBVvQyqW7bdJ86PnKc0lE4XChN9HwKjeNn26ZFGgn1uhEN0XZTpMTaAcFq6ltrlGPF
         Kx8wxWlQX+Ttnlb/K4JZHDJFOsdaj0rgTYPjDloEo1q0GVnhNvisKQnYAD8RbnsONo06
         8DqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1C5O7HTAq1fPZjiY20DXusYidZfeSW9eEUc0lo7oUjXAEKj59pEsRGS/ogebOWqQB+gtjR1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfC1ToyHganlMczt0eRyVSJdyzvkGFoPO2jzJMxdI4qvFyqSRd
	B/rANEJm71BDLR+nXwyAirZqS0HzHVVYxakDfi8cZbOKrDdcvS6WheR1t3ADsw==
X-Gm-Gg: ASbGncvgtVJgUBzaPx0jVLdqEEH3VNUi+5WNi2mMJKrdRzp7IU5M9MKvWIRXg+LPJ7Z
	x4iHrkzt68yrpnJ+XstbPGsZs68o6ocjHu6vDGfrwOoJavAV9FJtdFI+JaE+tefVOHViZWqj4H/
	wEAxBUzGglAe1Yj7DIqbiZSYdXD1+wH3eLrASrCs5i/CqBt6pPoZW2IVJhDWSgatNqv/Aejcyh2
	fCQgIhXDTy+QykaqQsS0Mt6tiNOo0c/fJTjZ8XfEykqJGS8nc9paDaVq+84upCVZ2DHrH6Tvnh2
	Ijev6oIUTmO0qpFnhpzdJuQMc31icX0vR+ILUteFmkXa+1YgQia605dlJj7H8W+oKtSkICbVLxD
	VEsFTXQVDb7YhqjOBfukKmQycO6tusyOF4CusQYdlVTB4Gx9LpTw2kEiFZ9ieeP1MrRkUm954B3
	hB2mu/Pm0kjkt3OarlKxtlOnS7UA==
X-Google-Smtp-Source: AGHT+IEsMbXvSBN3N454px9nRGN6T3ozfr2ZVvi83RFArD3EQAT9C+qAhgD8tlCyaM5PzxT256tf3A==
X-Received: by 2002:ac8:58ce:0:b0:4b1:fa5:c5f6 with SMTP id d75a77b69052e-4b10fa5c657mr26015251cf.25.1755178038364;
        Thu, 14 Aug 2025 06:27:18 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 15/42] selinuxfs: restrict write operations to the same selinux namespace
Date: Thu, 14 Aug 2025 09:26:06 -0400
Message-ID: <20250814132637.1659-16-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This ensures that once a process unshares its selinux namespace,
it can no longer act on the parent namespace's selinuxfs instance,
irrespective of policy.  This is a safety measure so that even if
an otherwise unconfined process unshares its selinux namespace, it
won't be able to subsequently affect the enforcing mode or policy of the
parent.  This also helps avoid common mistakes like failing to create
a mount namespace and mount a new selinuxfs instance in order to act
on one's own selinux namespace after unsharing.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c8bc0c34a248..d6c8d8245c3c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -150,6 +150,9 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	int scan_value;
 	bool old_value, new_value;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -338,11 +341,16 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *page;
 	ssize_t length;
 	bool set;
 	int rc;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -795,6 +803,9 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (!count)
 		return -EINVAL;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	mutex_lock(&fsi->state->policy_mutex);
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
@@ -899,6 +910,9 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	ssize_t length;
 	unsigned int new_value;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
@@ -955,6 +969,9 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	u16 tclass;
 	int rc;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
@@ -1042,10 +1059,14 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 
 static ssize_t selinux_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
 	ino_t ino = file_inode(file)->i_ino;
 	char *data;
 	ssize_t rv;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	if (ino >= ARRAY_SIZE(write_op) || !write_op[ino])
 		return -EINVAL;
 
@@ -1486,6 +1507,9 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -1542,6 +1566,9 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	ssize_t length;
 	int new_value;
 
+	if (fsi->state != current_selinux_state)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -1673,6 +1700,9 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	ssize_t ret;
 	unsigned int new_value;
 
+	if (state != current_selinux_state)
+		return -EPERM;
+
 	ret = avc_has_perm(current_selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__SETSECPARAM,
-- 
2.50.1

