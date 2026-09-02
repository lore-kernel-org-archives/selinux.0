Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9849F123
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357819; cv=none; b=M1D53SinFEXRk0ZLDo07n9/c4QL1GzubLdT6+IcnNpp5rJ5lU3l1s3pkers4ouVRDCgUs8GHhDtaC8ONtW4N1YjzBIvZkwX206Oou4cJoJ+pGOpTK10jL5ujStFyZchVEah3/jwxnJr9RczWWdKpbRpOIXFLdBFS3A+FW30BQPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357819; c=relaxed/simple;
	bh=aACwltl1ZU0WbD3tq0kXF1wvq126MYRhnrVC3XwoUi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRCiBLhWJ7YkL7mYpAVCrnHSbs8e8eh9yDUxdNjJq9HZiVWoFFRNCPJprYZ+l1NY2nwXuqkA1wuB/UB7yjUo4NyxX4evoWSBFh5faY+NQ5LY70U/cO74liai7X7gPNW/MQQzJ4FoHutQr/HSmvnvhmYj7HaI+SnFXdY0yQQJKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNRdOLc2; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNRdOLc2"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cd8e45460so14908506d6.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357817; x=1788962617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XW5bsunI5tFDnMF7+O8o66VjrM0zG8UGo/I7d0UClRQ=;
        b=TNRdOLc27QjGdbNnEYm6JwCyD77FPhp73/h/VM1aBaQQ8zPtkQS7tnGAHeKVOxdkcx
         gZJ31PB68Nh6tBYtTr9lANQXXn2adMzXr3xhtMxxn/wkO3F+lXxt0hoM3r7a0rua7NJ9
         Obk0kuz09cIS65F76i00KA1FwwSNap8BomnkM6Ol2HT6makKUMDqAHj7FUJT1PsYVEl6
         Ce9DZLevCLR5MSd7eEhmIFYjiVOIKLwYyXowfj481kQnHYlWP2czQMbKcV6FtC/4+LtM
         5e4BSDxLD+fAPiSYdSa7Cswjgyfok05+Wr0n6O+VTNN2fvGYFgEJx1qQlbVjIezzxvz7
         /tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357817; x=1788962617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XW5bsunI5tFDnMF7+O8o66VjrM0zG8UGo/I7d0UClRQ=;
        b=SDLz8b2g32DoHUps7W5Pw9raS3to63oWF4ajUcVLdmxRZ4QklTDh8jX8h/nvFmOwFB
         AinqweDauwPBYY/2Lh4mzaoeelUt8PQtQn7wNnErQ+TUAD8DlQ4J2jl1cIihv8/FY+YK
         i2UhfUlcq1JtiQcJIXE1qwhJ7Grr3z9CAZhkeuaOXBwBno2Z7Atbnr7qjOYdPqORbJm4
         wx9+gg33BYxeJ6TcPX2UM4JFLAu1hqDIVOpxW9DbrIBbXmdObP84KkbGiEHKGFSMXfiM
         gIx/+he50AzjofzU85Uxo+Z7SObfIVnc6EkN4zLiAoEWLSuMvXxXiU9mBk82RhRdtnKX
         bx8Q==
X-Gm-Message-State: AFuF++nXzMPKrN5B4F/+EEZgIDsquAnOnd1CznxSHAva6NTgcnFh5wyC
	12sGfhgNU1FddOHDojsdCuzwI0WTMn3Img9J69MYKTsb5Zp89xk84UAv7rzFjA==
X-Gm-Gg: AYBFou0ocaEXdzMkXqK+Pt27aoRMPQUmUaViLJ9FA12hIW0zQTRUIS37vMWakQOg/Z7
	WX62Rqy8dQVpZHPgHGNiP0BnYSgxy46loKNbpJU1D3vr5KN4uiBJd8qoiSrhBu4GScnbYklR/9M
	i7is/QBQsxcon2hikh/6z/0fUbwtrDeDS5Ujyb4SY7rqxrf16S4AwyZK7NsPkb0r0KtO/OXHZKJ
	cMAtGbo1cws9HwP0t6fpy3v4KTsIidZkUdKE9I0aW1deTdgZvQxeS8hc2ZahhcrPyDq46+cQV3B
	5OOcZRJ69WBbtm3rn4cwdJqLAW2m3bF+ilrAUN86SmN4AvVimio6Jndyi6OwhZ+YSHXu59U2Aw8
	S+IOuFRXEYyULn/0Y0dV5WTi5YoLMkfwC6wBmlBHNoVDGHKxCpd7Ioy1XTYZEsGjbtUOto2VBnC
	myGoiGt9Q7FdtO9tjib5CKlreuDpVEOzg/dFD5fbidkPquRvZqB/ziO/rbYX5fOGfLGzfZ9DxDh
	KigJrB3enQ+22ZEOu+xMmZjixz6FL2+0IKSJYL3HKP/NZCkt6PK4ZBd/wqJLz47
X-Received: by 2002:a05:6214:43c4:b0:908:949c:4adc with SMTP id 6a1803df08f44-90ebaff0fb5mr72244856d6.10.1788357816698;
        Wed, 02 Sep 2026 07:03:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee316f7sm18790446d6.19.2026.09.02.07.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:03:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 9/9] libsemanage: document semanage.conf search path and ro-store-root
Date: Wed,  2 Sep 2026 10:02:11 -0400
Message-ID: <20260902140211.53084-11-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
References: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new semanage.conf search path:
	 /etc/selinux, /run/selinux, /usr/lib/selinux

and document the new ro-store-root option for semanage.conf.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/man/man5/semanage.conf.5 | 36 ++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 74f0d34f..2e560dec 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -5,8 +5,18 @@ semanage.conf \- global configuration file for the SELinux Management library
 .PP
 The
 .BR semanage.conf
-file is usually located under the directory /etc/selinux and it is used for run-time configuration of the
-behavior of the SELinux Management library.
+file is used for run-time configuration of the behavior of the SELinux Management library.
+It is searched for under
+.IR /etc/selinux/ ,
+then
+.IR /run/selinux ,
+then
+.IR /usr/lib/selinux ;
+the first one found is used.
+This lets a vendor ship a default under
+.I /usr/lib/selinux/semanage.conf
+and an adminstrator override it under
+.IR /etc .
 
 .PP
 Each line should contain a configuration parameter followed by the equal sign ("=") and then followed by the configuration value for that
@@ -35,6 +45,28 @@ Specify an alternative root path to use for the store. The default is "/"
 .B store-root
 Specify an alternative store_root path to use. The default is "/var/lib/selinux"
 
+.TP
+.B ro-store-root
+Specify a colon-separated list of additional, read-only module-store roots to search after
+.B store-root
+when reading, e.g. "/usr/lib/selinux".
+Only the
+.I active
+subtree of a listed root is read; the sandbox, previous store, and lock files always live under
+.BR store-root .
+Module listing is the union across all roots, and a module at the same priority and name under
+.B store-root
+shadows one from a read-only root; installing at that priority overrides the vendor module and removing the local copy un-shadows it.
+.B semodule \-r
+on a module that exists only in a read-only root is refused (use
+.B \-d
+to disable it), as is
+.B semodule \-e
+on a module that a read-only root marks disabled.
+Unset by default, in which case only
+.B store-root
+is searched and behavior is unchanged.
+
 .TP
 .B compiler-directory
 Specify an alternative directory that contains HLL to CIL compilers. The default value is "/usr/libexec/selinux/hll".
-- 
2.55.0

