Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2E37F311
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163495; cv=none; b=qmAteI09fFPnqnf92cDjTbyg/9V+oOhhYRYgVsJzDJ/wzKBYHK725epKu1RPlZBMepA96YsoAFDZUoDkddHgH41LXV1rrLuLuSTc24MCfrCqP302rF3fH64vdcFth5tHQrV3L14Zj32pRVQM61jpRgjyVM980yTMOCZD4JBPvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163495; c=relaxed/simple;
	bh=Q2PhFenj0/mppzk/vim8V7UCLPFmTplkSANYSwzbkkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ld+pLteG3eH/W6QAqmTylEmG17xgzseRmKyztVmFFWItzBVoh2EWGog/TQQjaWAtM8O8Mv2UMMty4DoxNHmF2r8iAKWnPnIINgJeuQGazp5Ciiuk55X6Rnz3VNmOKFJVZ1/v5uXvVnsfq12kwGhfY3atd5/wShORIWWHxNQXfXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT6yZGgl; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT6yZGgl"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfe810293so15213781cf.1
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785163493; x=1785768293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8AwQ2TNwg7hMg70DIpxLbbrKFJKxlJhoik6N/zzjyc=;
        b=mT6yZGglUCgNGqHcP3h0KmTKyZleBc47tnSu392Ly+Rbcwm3MvUOZWysv7WTQph+ml
         auVJ7iu+1woZes6v69uupfMpGFIGc2siMzGsUrNGXohfJuwHnYNOdIUksp0XLFbNAiDD
         aAG9AD3TwOkLjpFgrMc6btwI39BOfNDPhX4/TagRB0k/0PScyTtkbEZXpuN1yeVlQa7Z
         BvlCSTvbgeEnHt859C9hFWlbNfXysODu6FXzkE1iip7Jgb/ohXbby+OVkXBg+gJA8xF4
         Y4FyIm/2KPPTT4/OFBWOOJowzF1I4D6Gu7UtHzNofC1foiSnenS9eh1suevWTt1IS98v
         QGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785163493; x=1785768293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8AwQ2TNwg7hMg70DIpxLbbrKFJKxlJhoik6N/zzjyc=;
        b=Go1KzYVsc2VT5LKFQbPpGVEEhAcuzodXvr+WvxOH/gX4ljtGVJpCNhOLU5IRtTZTxK
         bzjbxt8shGSvWjWDbVYYLSWWqH7q3EfJTBDqBX7lk5isMzQlaObQ4Tncas3SO7AfvnLN
         u+6D7Enj2GUDDpOLj/GH4D0AIinKfRSAc9lYMMKAqit2auUMe1iESyH/07tsMgSCys/8
         QkeZtIfM2IqDCsAp2X3MpVuWPVUlgq+74OejjwP+PPX6Aul71krBYXaozw5oO2xCEyeh
         3aBw9robeheVtK6ePb49mnAxlg74Q+TKdTSEu50KkO7526nYE8YLanuRypLdFWDEDKrr
         jAiQ==
X-Gm-Message-State: AOJu0YxuQO6ej64VaDl5y1mypTKrgRdGTVxFnRyaiVPLn7lp0MaIxxcT
	NCXBObRhxz+sCBCVWbMpwVt7Gy5JideQ5aN0IgV0K/joC8Gyf01jprFoLqN4dA==
X-Gm-Gg: AR+sD12L/RhJnI1myo0lBykeWas3k6Kj7Jk1R1/30YqbsnPdyu9CIAnj0UlcuwJzZCr
	T6yfLoF+vUBLj0ENtOBW/R1iaUJNDCa5vWvd9lZQCr76Q0bin4novUQbzr+w+GTpzFAJgDGnZKp
	1qqMS3Ws8p6FSpmVf3xI6Ud4siz45Ha1E5bophUtrCuGF8LXEm9F7VxQ8iASnIOce4EDA+i9cAd
	nwBwYS/ocb66uCskVXBmulNSxO6pOKGKvEYKpa7lViWllLMv4HEm24lf4RGDKEBdfNkU1sMpeEn
	KXNJ9oydJNxOn7Gr+GKQl2GiDFlQYAh55K9Yi+ZLk3egVrkkY2PbPDQsidtu+E/K2EhRPaJ2HSC
	sa0Z0FriV1nyfP/zZ3mISZLWEh+XtCQgSccRatixCZ4+DFIjbl+0fWP/PlDqMErxHR5kosGoAyk
	1X1DjGemYjwBwAvJaDaRjyKxX5zIWl7Y9EYRgaRnhGelYCnbYQIKtV1i/ytypYKvoSN/eEAZwDX
	5erZw==
X-Received: by 2002:a05:622a:1351:b0:51c:7b12:5ff8 with SMTP id d75a77b69052e-529a872ae71mr83061311cf.84.1785163492940;
        Mon, 27 Jul 2026 07:44:52 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a2821c97sm54680831cf.13.2026.07.27.07.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:44:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: validate constraint expression attr and op at load time
Date: Mon, 27 Jul 2026 10:44:38 -0400
Message-ID: <20260727144439.6270-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_cons_helper() validates the expression type and stack depth
of each constraint node but leaves e->attr and e->op unchecked,
so a policy with an invalid operator or attribute value is
accepted at load and only detected when the constraint is evaluated.
constraint_expr_eval() handles such unrecognized cases with BUG()
so the first permission check that reaches such a node oopses in
the context of the checking process or panics with panic_on_oops.

Reject these expresssions when the policy is loaded, matching what
the libsepol validator already does.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/policydb.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ba1c9bd9e29f..c4a81bd31e05 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1332,6 +1332,27 @@ static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
 				if (depth == (CEXPR_MAXDEPTH - 1))
 					return -EINVAL;
 				depth++;
+				switch (e->attr) {
+				case CEXPR_USER:
+				case CEXPR_TYPE:
+					if (e->op != CEXPR_EQ &&
+					    e->op != CEXPR_NEQ)
+						return -EINVAL;
+					break;
+				case CEXPR_ROLE:
+				case CEXPR_L1L2:
+				case CEXPR_L1H2:
+				case CEXPR_H1L2:
+				case CEXPR_H1H2:
+				case CEXPR_L1H1:
+				case CEXPR_L2H2:
+					if (e->op < CEXPR_EQ ||
+					    e->op > CEXPR_INCOMP)
+						return -EINVAL;
+					break;
+				default:
+					return -EINVAL;
+				}
 				break;
 			case CEXPR_NAMES:
 				if (!allowxtarget && (e->attr & CEXPR_XTARGET))
@@ -1339,6 +1360,20 @@ static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
 				if (depth == (CEXPR_MAXDEPTH - 1))
 					return -EINVAL;
 				depth++;
+				switch (e->attr &
+					~(CEXPR_TARGET|CEXPR_XTARGET)) {
+				case CEXPR_USER:
+				case CEXPR_ROLE:
+				case CEXPR_TYPE:
+					break;
+				default:
+					return -EINVAL;
+				}
+				if ((e->attr & (CEXPR_TARGET|CEXPR_XTARGET)) ==
+					(CEXPR_TARGET|CEXPR_XTARGET))
+					return -EINVAL;
+				if (e->op != CEXPR_EQ && e->op != CEXPR_NEQ)
+					return -EINVAL;
 				rc = ebitmap_read(&e->names, fp);
 				if (rc)
 					return rc;
-- 
2.55.0

