Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B3495504
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593656; cv=none; b=kQyvXQ+IyCyAFPdCnJqxZVOE8KmLnAkQAuMjZMlTOAtxgj1sepjraPZXS9CFOGGJPyJPvRMXH3r0fz1saXSMD1qcC//ZDWFAgt61FH1+0d8U++0TiwKTzPZgNv0ONNjnbr4BEWZVLKaBavqaphqHkfLotMj1KTHqWFLA4B83Jwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593656; c=relaxed/simple;
	bh=Da2oVOtj4kDrOVBQqN7nan4sVoTS+XLAT7I8gJ061g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHURRTg4M22Vx9S49YTqwWf9TO0DPtSkylsFofxtZkVAyHbc7jSddiwcfr5NqeAFZV+MGC1XIJPFnIIGH9L/KgMpRw6DbGdBAyY09UCOlPO9/SU6ffpIqpHKvu1CCvQ+b5QvSwOK5ZcBQ4U97J7DerMmdCcpmyCN5L8h5e909zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwfgH278; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwfgH278"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9157b949fc7so130651185a.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593654; x=1781198454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tfJrOzpiT5OX6edpJSuLiTYbzWVzPfqkFYDlgRZSvz0=;
        b=AwfgH278MLdcz4x8mE5uOxtLYVsssuppdft2AMfmzIDhJ8qaK608BzQ5kePf7k3do7
         +fp4O991VcxpdjOX7/ZI7a1fatrhn7TvYiiCTWwFc3V8dqRvz3xazxOZrFcA375ecrUt
         L7FofJyKgc0KgG+hMAHJZooU70tyLX8j1cbtwBjMhn6CXIQjiyKN9S0AFJP/HfMX/GgB
         B5YyHpeNwylVGaCIqQsNF5GsYmpMaYbZtn/vKX33MIsl88j+YL4d46CZ8R0xsIaHvayM
         /4paHNzIgx36CV6yysX/M25DJhv9L8XF03icNSGAPGMXUb+2ckzCP/+UF0Gagm5wz+vi
         VAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593654; x=1781198454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfJrOzpiT5OX6edpJSuLiTYbzWVzPfqkFYDlgRZSvz0=;
        b=qVNBy46KU6afAfDbYePa40V/mbML6WBJ5pZFRHhFxiDwAvcNx4AX7K0ZiTE3Iy0lWP
         rhoNvxxIrSkdh1x0WJvbWuxQM2XSPLUViUO61wbd2ODiB5AoPrx15J5x40isG5gsG/bB
         17UVD9zFkm99FJ0KMJgVeF1nT62Cu5HEYhuPK1/pDZMI+cGnAGGE66hmEPMiQOBepZQ0
         kuTvErdNEvvSnwiLWP5X0kz7DaOecU3W2sYqP4bTg+TcBQpX0b113my3espyWOLI3UbW
         nW7cHaYuiGpOuYYypUf/oHCGJd/clvt8nO042S5b2MydFxquTNenaCKOfH/ExtJ7qUEo
         hyRw==
X-Gm-Message-State: AOJu0YwmShdMexwkzbJMb2y/pQQUV+QrWvoNxPps2yvEci066sCGbnXh
	3CrN7mPDstuxn3zGHldY9mNrv528Q0F8EbuF3Nt5MWdimteIlZbfs8oMUEoV5Q==
X-Gm-Gg: Acq92OEOe9apLGSW9vCRdUDkU2nN9YN9P61WBWLRQ4O7X3RfPsdWaPaBmshS1BABJ+Y
	Gz43sBMw+KbyO9oLmCSQpwtcTMzBhDj3k9bBtIvGBhj6qEe3h1mOzjaKclS2WlWP0XFMt0JhIeY
	/1QDNt8A8+s+aFlyWbKxGfrJwQGvMBhDmtEE5KFk6gtDGfzuuSGzKwpmsbB3uSjHAgBRT+LvOoM
	V0xPT4wSxPSGSW+RglHKCfzhBlJRs4HYk/tVrLswTSEm1JDWR5+PjdHrqqymCJ0HoRvxZ7H7Sx3
	DuzNLB8D5OjCf3EAsjlz9ohrbdtR+41srdgBfDhpGITaJB2jb8lF8PyAWNctgWrvSJe3IYS4VOB
	vVT0L6SoZleMojosCA8CypWV396y/MVxJp7YGVhJFQNfAfXTvBgcrMvRy3Z2UTZ08y2mHISJ7rz
	XhB/Qj4c+YbsEda2QDVotiqvLcWvqpF3NSKv8X8GTq39RfAbm3Sc4RcvpEUPJ9tCJMbqG4CQZ/t
	nkjw6WwHbLU9oP/Q8SZdvfSTyOwCxgeYWSfg0htbmmuuW6M
X-Received: by 2002:a05:620a:28c5:b0:915:a14a:6837 with SMTP id af79cd13be357-915a9d8891emr5399885a.35.1780593654152;
        Thu, 04 Jun 2026 10:20:54 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381560sm645967485a.28.2026.06.04.10.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:20:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: audit2why: clear static variables on init failure
Date: Thu,  4 Jun 2026 13:20:02 -0400
Message-ID: <20260604172002.263518-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear the boollist and avc after freeing them to avoid potential UAF
on a subsequent call.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/audit2why.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 4e3fdc1c..2275ffbd 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -275,14 +275,15 @@ static int __policy_init(const char *init_path)
 	return 0;
 
 err:
-	if (boollist)
-		free(boollist);
+	free(boollist);
+	boollist = NULL;
 	if (avc) {
 		if (avc->handle)
 			sepol_handle_destroy(avc->handle);
 		if (avc->policydb)
 			sepol_policydb_free(avc->policydb);
 		free(avc);
+		avc = NULL;
 	}
 	if (pf)
 		sepol_policy_file_free(pf);
-- 
2.54.0

