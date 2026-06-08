Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D6381AF
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940980; cv=none; b=JBQkQvO+Yq7X1lJRHAGwL8IowHeS822wjk/GNRr+KRztWH01R9tAbL7n2V4dVuLpggZE7+o2uoZzoyPcM0wpmBzrCKqRoGJzRrBtdsOHl1VwHzEYkEns+jNr6GpCj/IsVn5SXSeRHUlrpXP2yGlcy+qEUnDa+gV9XG93L+Hy9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940980; c=relaxed/simple;
	bh=GdHMoNP6bh8h/894oTjEBd/klg9Y5xtY4wOMIppnxNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhJIiXn5AZNw+lpdVz8OfkPGN/rutPUMkTkls7386bfkmJ81lH2U7WQoCuP5kw9JnVEmKOAMWX5MWa7j/z1AfHewxAYzqrj5F9HGZjWoWkGU6rL2gSQQ5OME6fAmUCbEaNOIGscBIZA2CB2RQm4YzsPmUvsPqSDYZgOtjV+gfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5eDwZfV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5eDwZfV"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51780bbc560so41516651cf.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780940978; x=1781545778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmtNhKfuH4rL9GkNcPOaXFb6h+vtm5fD1syys1ud2NY=;
        b=Y5eDwZfVAsLJYtUUlrKHz84YWDl1i+dRjpDwfO4GvkG35sGF0FVxl0p0Co34WBddmB
         wXuBmcODLsPjvUBZler2PuuSvHa6rXU+AnUOVVPkSa9pmWiI/PKq1dXdEzd9RqGfdleB
         TWvNLTfwvLr+M4RT0wvml8V+LwK3apj7IP/s6CZ/I7HBjoWfFA/v0LKakhDGCq4q97FZ
         VViNRsB1W1PWBj6R+/IbngCLGFEuhLDCY8tayYJU5xdjKXu8im6HDFiEJixmzlCSx0pl
         nXnf+wwRU0Q+TtRyWuC0YQIzLwMdmcaUpWir8rLH4MppOJRGqVb6UB8zpcM0wkWGQx1K
         Gkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780940978; x=1781545778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmtNhKfuH4rL9GkNcPOaXFb6h+vtm5fD1syys1ud2NY=;
        b=nO29ISEPLhetGKrPIUWXVZ2aNmW3IGn231cLl4aXuFm0tEBwsn13FLOOyca3QHxgaT
         vS77MJXf/VBQF7k/7FaBtjpxdDxeQxUPkv0zqfePA+Tlec3oL+VZ+WKj9RVV+8A6Pw0G
         4r1TeXuEi0dzqNkd2kqXtXl5RiO2vD5mSIipZPLOr9omUbOH8Dc2XtjsU2eucqEcGDmN
         P5dOlFALvJ9hNo6hCXrdOhawo52YL12YZ9+L9IlS7pJ0N0Gj8DmlVKAurg0A4zXDJHKY
         29GHZLB9G2v9dNnoEWxLrTfzSroDNc2c1WU2oE6ZxZq2IjoXrY8oOoZzVjyTAobuqQFq
         GThA==
X-Gm-Message-State: AOJu0YxqJ4zXSfd6JviSSEo5sQue0vuFKLdtBlFF4hQ3Y7kSiW2MyMPR
	Sg6Qi/my1mVVERiRwqUiyyC7POTXXEQqwvWAVkGpKIefs4lNYHY/wIz1seH7ZQ==
X-Gm-Gg: Acq92OGIJrjuMpY1Fqb9C795gIYSuNFbJS7hcwxOqVJaxYGmPobrleN8PsKkIEZew8z
	HwQwX20IUwwJ1ZTH6N7jWVY07mbE1NIZe6Srvb0CbY8dpdZaXO6K9PtZOzt9U0v83f0fMrnGXi9
	Zc9kuEXdIalOFKf6B8Dj/iEKtMMLOg0J7gC9jyB7TG7fi/tEJJx/jIH+lryJ3II5P4RxvRV7gst
	0/5xea1jwzdVDC+kurfnkUfMZUj1XGu/DHQpkLdeN+ah47+3L9eJqatHaehaCF1Co1EqsKwMPNC
	qUGCph5Lj3K7jR7uqBJ0U+szrzmp7cKeBPxiuMwNX+fi1lM0Z5eqM6a0ZTCL5saPpuB2l7NOlHt
	RQc0Ij+CsveRzhVcaMXhNgNfLAosA55rpBFJs0A7yHaIGzbV3wfTxaRpM9jZvZM3UXErQrvyiz5
	U7zzxxwboutG1Aylfefp6TJF9DB2fweYwTyY+qKjf8cBkzRlnOpxqpTtwtdSBoBtRi7RKYXCDdc
	4/V/rzOqp9ua1h5S0Zj+BrlY2FyAbhECVXviJHg8JH6p9o/
X-Received: by 2002:a05:622a:17c7:b0:50f:f030:920d with SMTP id d75a77b69052e-5179881c7d5mr156362711cf.30.1780940977851;
        Mon, 08 Jun 2026 10:49:37 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd053032sm177174846d6.24.2026.06.08.10.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:49:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: label_file: prevent num_specs overflow
Date: Mon,  8 Jun 2026 13:49:23 -0400
Message-ID: <20260608174923.315337-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

num_specs is read from the mmap'd binary file contexts file
and added to data->num_specs without checking for integer
overflow. Add such a check.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index ac0a3ab0..0c0499eb 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1042,6 +1042,9 @@ end_arch_check:
 		goto err;
 	num_specs = be64toh(data_u64);
 
+	if (__builtin_add_overflow(data->num_specs, num_specs, &data_u64))
+		goto err;
+
 	rc = load_mmap_ctxarray(mmap_area, path, &ctx_array, rec->validating);
 	if (rc)
 		goto err;
-- 
2.54.0

