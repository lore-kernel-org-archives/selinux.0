Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE3326924
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227774; cv=none; b=tyuS24uCdh3+Fn65nVbg1uRx8BJvVdUFSJ66V/Gb05jRvpt5QdAnioNCxpbKJzMO18DAL/Vz7mLdkfs7pnMzU2EmRmjIlWicV+4lZg5JrSxHZLrt3X9eGr9FaXHY/CobcvwbHOGlMHBzhwjL4mMVIpJgR5B1oQ7uaOxsQVdQWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227774; c=relaxed/simple;
	bh=Ok4oCW6t2Put7I251b8UOMUIzy1usH6sMKgXjfZ0Sag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIfvGnxAaiPukRlMztFdBIXhTKYegb/J9nzXNkRuGgd6xTwfUvz2lxyQ8LX8azg4bKml8sTblGO0pfeAk3qCQkK3BHpJY2lwMcWNKt2cM2uxxnG6ojnFN7Ja6XLmH8y+cJtxZ8jFihmDJ01esANn5hVZECenDjpw2kCyCf8ygzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mvgg50K2; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvgg50K2"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2c8f43aaso63297731cf.1
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784227772; x=1784832572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ypD3qon+yTDMPxSb69pEA8jVs5ILG2S0PUrE0OESzDc=;
        b=Mvgg50K2+I9SfzFrpHmDhTEPfQJ4nJtovJAEjgudVw9x14lWnNTKUsHXUhZYCg0lKu
         QFWzpowDZr2wFf87rnCbE21JBezMmrDVh31t9Cyz+6eMafneaas673UoCC7e4h34L9Bd
         kmNGSH5++Vknfc7YhWqHvQt31E5wfQRAz3ccghZUgePYqf9wRqOAe+TLlCkMrfqZHX5D
         fEjek7t3IF7wHDingSzQm4gqnL9L10j+qURFceNRdq8q2RiBzMlsB908DLvGEM4tZfrW
         SGTcvwbkmv3B1Zsq/aZMSyGM1KTwu/jaeg9k+c1u+wyIrfgLIF9ia/q4NCFAtvQIJK6C
         e5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784227772; x=1784832572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ypD3qon+yTDMPxSb69pEA8jVs5ILG2S0PUrE0OESzDc=;
        b=VJKPOiZV29P1SNaf8S/SEVpqDdafQdSWBXDFUlkx5TZYlP9RcFRLyRmDxdS4ST1nFP
         SaHc+MAdJspe/xqs5C0AbRBCaBeLdlcJP+HbCFvhB1R2RitFUYt9Cvbu4mvbK/4YVb0u
         n3Yr/6gIww+IRgActSeNqf2kZze8Iy31iEncRlM3SRF2T8/iF++zpRB8ENejB2haxcM+
         rmG1Uo2viHVyo+VIkBzDgwRfN7WuS18r07cjXyY0gqthAwUibjdhvGCX7+G+tjM+NteM
         IJTGH+wZg6lK53GKcAYqnaVzuexqlLHSzk7ngQzN9ekkhRoMgG9ma4lVrqsuYmlTk3kN
         C6nQ==
X-Gm-Message-State: AOJu0YzSDIroCGOiduI/LAce2xbg42Ys9YQAdjWpDYoQSz7P2PriT1Fk
	jq0JbU6mqIMitCkAf424wbK+SVTfjXGK8O9T2kbHLL31YWD/iX9qY0V5Zwuy6g==
X-Gm-Gg: AfdE7cn5dON6ey/7DIBD7WPUpabwSq3QXhMniSXNB9MbF9+Gm8SM0SA00NfRvW8h7h8
	s7hYS+iV6oXN44wh9Lzsl4NazQ5wWsp68F61Qxaij5PBkPtwKQyhU+PKh5VyGMPsUB8KwH5UPtM
	8UhIVwHamJTSCpuYrU4zcvYC+b95r/Bg3imXqtEjTooy9m7yr/Q5Lbrznm9UJFRjt3GYY3wQQTP
	oXW1cqyw2p59VDxDjZgx2637JPyigjhHylt0mN6N38u1nS5LfRqXRZ4Uge2bBp67tfYaWQwZoQQ
	U43nMFUcB5VpcCHW1w4XwIFxLnCjLXZ1oBn88mXKXg4CFoNP764NYTPDgb+W4Db06bFoS05nF4C
	TORPUXPrkUxnWrTKeJryLKBBXuxDPYcFFxWMSdJou1ikqIWzo62sXx123OCQUKqVaznOBVcqBbv
	XEh2/fxYxMY/xXm/ZX2tUNykqTW3C0u6G2EzzhsZ9h4YAw2aWWG1bqSkIuewK5PsaesgA1q6rk2
	9uV4g==
X-Received: by 2002:a05:622a:259a:b0:51b:f40b:2fb5 with SMTP id d75a77b69052e-51e4ede808bmr97227631cf.17.1784227771800;
        Thu, 16 Jul 2026 11:49:31 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56bf455sm222390806d6.13.2026.07.16.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:49:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jsegitz@suse.de,
	russell@coker.com.au,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] policycoreutils/scripts/fixfiles: drop /tmp cleanup
Date: Thu, 16 Jul 2026 14:48:44 -0400
Message-ID: <20260716184844.10348-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The /tmp/{gconfd-*,pulse-*,orbit-*} directories are no longer
created/used by those daemons so we can drop the old commands removing
them.

The find commands used to find unlabeled files under /tmp and other
directories and then invoke chcon on their pathnames will re-lookup
the full path each time and is therefore subject to TOCTOU issues.
Since some of these directories are tmpfs on modern Linux systems,
they can't have any lingering unlabeled files anyway from a prior
SELinux-disabled boot and we can't restorecon at least some of these
directories because they have <<none>> in file_contexts. Just drop
this /tmp cleanup altogether - it is unsafe and shouldn't be needed
anymore.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/scripts/fixfiles | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index b7cd765c..b5f193e1 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -288,16 +288,6 @@ case "$RESTORE_MODE" in
 	if [ ${OPTION} != "Relabel" ]; then
 	    return
 	fi
-	echo "Cleaning up labels on /tmp"
-	rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
-
-	UNDEFINED=`get_undefined_type` || exit $?
-	UNLABELED=`get_unlabeled_type` || exit $?
-	find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) \( -type s -o -type p \) -delete
-	find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /tmp {} \;
-	find /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/tmp {} \;
-	find /var/run \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/run {} \;
-	[ ! -e /var/lib/debug ] || find /var/lib/debug \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /lib {} \;
     ;;
 esac
 }
-- 
2.55.0

