Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB43B7742
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020442; cv=none; b=rbzaqNzKdTBpxf/MSos2kOmCOv3Oaf5Xnr0lvkCbM6O0FsTnAcnnCRrTXcEElxBe6zGNI41O1aGmje4LB38pmGsYTx3NIivIozDtLumzSorpeKeTXw2L3IOrraFKzNXlR1Kt2S1Zgj+Gg4niqHy42s4Vp4PrlPjSCLFh0Qvz0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020442; c=relaxed/simple;
	bh=pnXiCS1u0wfbIprXaqN30m4zBsCIEUhFT5DnrL2Lj88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4jvlu3MeFSIRXXp9ohwQ4zTTIKmQbNjDZaEtymLDFrPGdwmc3gZ4eRCcTMVTpwUUsMNeOSW0Aq9W3osP2Cm6mwtBRI4Fgzcc/0/Q6BO2Cap/VIOOnKINS3vUiUT7k9fyBeUD9yMN4xXzNJuJSEgaljCOY+4liHqsFUlxGPknXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKziv/my; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKziv/my"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd3208so31942026d6.2
        for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790020439; x=1790625239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6sHcw01JvkCEKyMqna4ZFDcGfCtXURBTIE4QGF+TPA=;
        b=VKziv/mykXxCoYycnoQH3VBAvKt3fh8m3WGvGljSZCzQKC2T8YPCPZ444jN/vNsreL
         oMgHgWPQF8AjVhJIhRUkDKeiG5jMVRLCGwJ7BvjUPlDaVIyuORQ2D76v9SF3mB/dPirR
         BVnffOopXW7J/r1/Ob7y4EGkTcZWwH4UyNbqy7iPLFfRZ4kitCj81v4dD5dcVymeJaYH
         6pgK52p8m1OLGFqRaEShKw1w3mhpB+FWx5Us5txhHnuPu9RyiBHfYt/bjZv2T0VgWkyr
         Ni2P+7o48Y4x7WtJWlQ4HSVFrZ1lgP1foUMFhsUXLK9iRWBUc7IYWUK4yrbrtK1w2T6V
         B3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020439; x=1790625239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C6sHcw01JvkCEKyMqna4ZFDcGfCtXURBTIE4QGF+TPA=;
        b=MLuWrFot25uhn5HvenElr4loAq+mbN72fzltdmdutuVmtNH0ZLElItV+yQKYR6PJqi
         H7PBNyrR5bA/b916UMydnXcSt0IJuNzJp6zsGhy6dyO3yURAAHnn8KHLzIX9VBV1MCV/
         Y2HDvS/8xEDQMWWeanWmrdrhxhIOk5yWAWuNyDLN3YNjYK7uRCbZsT0HMnW45ut1JzR9
         cJIl7NDOHNV2fTA3w7t39qI7IEuha6x0vjxL7SkBMD6tz/Q399XQ5lBJ0TbrLAO7DIV6
         9Jv/xI20JQXWt5BuEjinX0ILGkPj9+Fqohr4OCDDrL6KeDP137fUi6wGOeRiQLdDI1AH
         qDNg==
X-Gm-Message-State: AFuF++ngg5LuM2LPFBjxn/GSM5JjRGpvSuykHhWzLOUI6bTGW1XPHW0C
	yZsDzOPajj7/rzTC9IglHZeIGrdw0SrdZJyKt6MGZecLBmeIJyLWS+ETOZb8Iw==
X-Gm-Gg: AYBFou0Ctv3mf1RmKBBtoLsEHSG/30cWDh1o0I6OMtoSbW0tuxHMfZcqQxChRx7i0L6
	okgft6j7HwI0B3BU4L5M1Iu7EjJN0tdyVMx8kjpFKlJmwqXRHuo4Uxu7xW1pY2i8/Ni/yyRl3lS
	GkZ04UFHCSublGRpnJR+bw2gt8WvEcf4wVI/byX/+O7UbQUJRrCZmV8XbIO+o5RM0d1/eArOSX5
	itqni6XNJrX6Xj14PV7btm6JBE3Q7I3p0uHVy1L/oSmnx2wD7tGNhVzU0j0WewOG5FrwiMoJsdO
	bJeZ54ulczY4cKZaHOBrojH5enQC8iuwFV8JcMWaEZHi5uqoyNCmE6FkYyltsSIXySvEsCm/eiO
	Xr0rYrrKTYX3WM7pfgCujSRqVKr8mxIBZaASiwp9udO/LaE47eVlxwA+uz/Ga5IwBD3ijwOCcRY
	UMTkD8IjbsXHF7Xygz1OvmIODbKk9MADk2EnaZo5qatfeO4quzPocaYns+mb/qUDTn4fJmIEHNi
	XZmPALz9Q6Wwc/qKnFI+zfewrMexlGYVQy8npNpF+J0GyV5v+4GAABKNYyNoyP/UvE0KBBI3kKz
	rMzuvKFMxg==
X-Received: by 2002:a05:6214:459c:b0:910:6f50:8931 with SMTP id 6a1803df08f44-913fc8ca5ccmr19548656d6.20.1790020439172;
        Mon, 21 Sep 2026 12:53:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a8a0c0sm74709906d6.36.2026.09.21.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:53:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/5] libsemanage: reject out-of-range ports when parsing the store
Date: Mon, 21 Sep 2026 15:53:38 -0400
Message-ID: <20260921195341.25227-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
References: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

port_parse() reads port numbers with parse_fetch_int(), which accepts
any non-negative integer, and stores them into the record without
range checking. A hand-edited ports.local line such as

    portcon tcp 65537 system_:object_r:ssh_port_t:s0

is accepted at parse time and only rejected later at commit time by
port_from_record() with a message that does not point back at the
offending file or line.

Reject out-of-range ports at parse time so the diagnostic carries the
filename and line number, matching the other port_parse() error paths.
semanage_port_set_port() was already equivalent to
semanage_port_set_range() with equal port numbers so we can unify the
checking and setting code path for both a port range and a single
port.

The commit-time check in libsepol port_from_record() still covers the
direct-API path.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/ports_file.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/ports_file.c b/libsemanage/src/ports_file.c
index 3db78a65..1a1adeee 100644
--- a/libsemanage/src/ports_file.c
+++ b/libsemanage/src/ports_file.c
@@ -115,9 +115,16 @@ static int port_parse(semanage_handle_t *handle, parse_info_t *info,
 			goto err;
 		if (parse_assert_space(handle, info) < 0)
 			goto err;
-		semanage_port_set_range(port, low, high);
-	} else
-		semanage_port_set_port(port, low);
+	} else {
+		high = low;
+	}
+
+	if (low < 1 || low > high || high > 0xffff) {
+		ERR(handle, "port range %d - %d is invalid (%s: %u):\n%s", low,
+		    high, info->filename, info->lineno, info->orig_line);
+		goto err;
+	}
+	semanage_port_set_range(port, low, high);
 
 	/* Port context */
 	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
-- 
2.55.0

