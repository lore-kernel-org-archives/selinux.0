Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199303;
	b=RV6hn4DU0LYnXnKH7lfC/YO23cIlONYlgswdBGSxhic6RDYvx5pBUmmQts9vrkuOfYgJ
	 Egh8WPGKd9oyrFRnRjkORtxEY3lNSwrRuYO6Y/3msExsOgrWny6ToQ4/RNzaNm8VTFqHR
	 yJ4XqHMppdoyqOYl5bxGGhHfhC5D534lc7M1z+t5oPeSILgNLAMvxTKEAlnMJLhwh9GT/
	 rZTAkUkSgpoY/LcelYvU9SpheKfU69V0PsemcKTqziLmYt7NOeCOMOkATD/SqdjRHG8y1
	 whpPHC+rQdeZtb6XhGxNwCmlqaUD1L0WceSD9XdOHc/waO5n3xMWUnUCm84fceW8O7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sA7PLiVIuJlpPbl9kbkv0QHgu2LVtAltGoWMzMuXNIs=;
	b=GA+BRzDkLXb5h8y+EAOYu8EM2jwNz4eTb7jpavogFKn/1dUMfzeAn88ROeBUOjFDCYyz
	 hEOBqGb0FPV7pOPtPYcqt5SQ9kVXFGWawL1pA2CbEbmcQHOfThr+Cv9hnR6aqR6AilsX1
	 jPetuJ/yMyAPVAqZBeAWVTYHBJf0C5n0j0KgkgwjDQyDl1MOwsGyUX7/Payj+iJ9yHgc0
	 yvxwCc1JekonLLAsww3rvE4Mb2tfBlVrqynWpQgDMrD+PC8AbA+ruSMRr1CkwJLDt5Syd
	 eLhH0rK5MDl+FZMRJAAB99vq8SJAeGivbRenxGHqmNfLn1e6sX/ND7ueCbhYAmX6ZyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a5+GYGYZ;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D8606A334
	for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 18:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C60D8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a5+GYGYZ
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-55c38cdd5b7so6827181cf.2
        for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 10:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795199302; x=1795804102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sA7PLiVIuJlpPbl9kbkv0QHgu2LVtAltGoWMzMuXNIs=;
        b=a5+GYGYZYHfUB1AJTNbAii1ONaXzyum+JKtS6SWbfACRyZ+OtonCTrpI+pLzddg1Zx
         eY3ivL/UMyUzgCOM1qUBPKE1QoWQVECjBSB2pBNL8Vg2Lnjx/N96QPRwy68XYlPmlDfh
         viNL4+GTx+VRMSw7HEXn/7P8DqOtyG5w0evailPmh+xZ6f2PwZoCR3TzRZeng5mA1xT3
         LdIuAcXu0L5BwUR2VBx4KysLpwUBXV1LEVo43VcY6zZGBunNrtDgQrB9hxEKwTdLwXJ+
         XElxC3MCwpAFUy84bf6YB4NqbMvbc9p4Ue1WMb8Ku/yVnFsATYiwXSf+B/sIi0Ym9EHR
         /g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199302; x=1795804102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sA7PLiVIuJlpPbl9kbkv0QHgu2LVtAltGoWMzMuXNIs=;
        b=Lyk+MxG+QHC80wlTAb0HociYV2lfdfXBkVDnsiH5wlXHCMeSq4/381X/Eioe8eHSW2
         zP5nO3GoVnspPSD1qVm3+5lRLcQQz/u7YrXg6V3dYF6k+Y/NjnjdRf22cKJ99fxH/Zlk
         3jsvBcoBzcWqbE+/b2rcmnV7FS9KXPPuKya2pWZBakvjwroEe3AllIK9+aADpX6pr+G6
         eOafjBXfoHOHOKHcPzUQcI1RMx+XJZqIjsYxeaEc3+WvpbIuXovWMthORhjTn9to2SwI
         Jk9YkqYxr8mYaJ1gZBbQGGTpQMCkpVY27L9fnlO39/SH6VhsgitC0Ds16KDHIkgPVcwi
         BHUw==
X-Gm-Message-State: APuU4Z/lqB52a+jikGokqS3HBRKJ5Vayv8Mc37jzJBL/Hb2OOFmDhzk1
	hIcZgTwITvJlbKIu1Xf6fy/TUKXZEzM3rf2YFkESF03qDIYAomaEe5nos3YEByGk
X-Gm-Gg: AZFdTZfDiR6BIi7E8kFMIM/bnW/wnKoxEqI++anctRnR+tT2KTn0OebyLMBPqnArpJK
	jTqVL9hInK68lg6+KApI5FyuI4J4sbrJ2uh2VbWrhBlVkXUSX2BzkOOoxE4Nc7mjIdA8zMgluD9
	YSVQgY3lEBvm1H+JLx1vMemrOAJN955HSYPsaYp2mxncvbdDa5s8PDiZCbj28Wze49zbHCfZdNM
	cAxu/5MjuLGdFRATeiZJpFbuymXLOmMQ8blMAIAjukyrEXFvmJoIwyPzqEzCwyU4fg5fukLnGb3
	rgedEFJujZbIG8idKDLKYYNrokmHNesMw5AavQjwz3eSO/ut3lcoK3YpNiweIHxva7YoukR1zpF
	GeV/p9gnypDGAbRM1iZ+i4Kiyx9xU+Mpcym6hTfTgydAcA6rJbHmh8ZNZCBovWmFsejKgJi/MEY
	rzZ/t17dfXocL9XNZA+2qvXlWub5gNtf9EndEzItjPNCtWjD5t4Mu28dThdKWw561xi4pj9Br7t
	I95C1HrhR6UY8CFKwkPRRe1fo+XT7E6+P8PTXhIwU7mlxxRKKIVGbYLl9j2ew/IPmEtjeiaPi8K
	lOT/QGngIuFKzBbhWAPT6r/51zJpgDfybyAE21rRLKHkk8th3IiuWOpvxdiVH4NSFTGmVkdLzsM
	g4Z1s4LNzWQs+TAh3AbL2uC4M340DvYlHXUsGwlYoXN/wzNPePFYvcXzLzaByJTrgHCuP/AaIvf
	A5FoVkixKkec/++NIdxtMior2hEe8orPw8FjveSqjQg+sPwg==
X-Received: by 2002:a05:622a:5e10:b0:55b:d100:efcf with SMTP id d75a77b69052e-55d769337ebmr75513341cf.9.1795199301500;
        Fri, 20 Nov 2026 10:28:21 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7887b610sm28733251cf.23.2026.11.20.10.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:28:21 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/3] .github/actions/build-userspace: do not require Asan runtime to come first
Date: Fri, 20 Nov 2026 13:27:58 -0500
Message-ID: <20261120182758.38923-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120182758.38923-1-stephen.smalley.work@gmail.com>
References: <20261120182758.38923-1-stephen.smalley.work@gmail.com>
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

The test scripts run host binaries while LD_LIBRARY_PATH points at the
instrumented build. On hosts where coreutils is a single multi-call
binary linked against libselinux (e.g. Ubuntu 26.04), any such helper
loads the instrumented libselinux and Asan aborts with an error, which
kills the script. The runtime is still loaded and initialized as a
dependency of the instrumented library; the strict ordering check just
rejects it in an uninstrumented parent. Append
verify_asan_link_order=0 to ASAN_OPTIONS for the sanitizers job so
uninstrumented helpers may load the instrumented libraries, instead of
chasing every coreutils invocation in each test script.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/actions/build-userspace/action.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/actions/build-userspace/action.yml b/.github/actions/build-userspace/action.yml
index 46e67bd3..2e64b09f 100644
--- a/.github/actions/build-userspace/action.yml
+++ b/.github/actions/build-userspace/action.yml
@@ -101,7 +101,7 @@ runs:
         elif [ "${{ inputs.other }}" = "sanitizers" ] ; then
             sanitizers='-fsanitize=address,undefined'
             EXPLICIT_MAKE_VARS="CFLAGS='-g -I$DESTDIR/usr/include $sanitizers' LDFLAGS='-L$DESTDIR/usr/lib $sanitizers' LDLIBS= CPPFLAGS= OPT_SUBDIRS="
-            echo "ASAN_OPTIONS=strict_string_checks=1:detect_stack_use_after_return=1:check_initialization_order=1:strict_init_order=1" >> $GITHUB_ENV
+            echo "ASAN_OPTIONS=strict_string_checks=1:detect_stack_use_after_return=1:check_initialization_order=1:strict_init_order=1:verify_asan_link_order=0" >> $GITHUB_ENV
             echo "UBSAN_OPTIONS=print_stacktrace=1:print_summary=1:halt_on_error=1" >> $GITHUB_ENV
         else
             EXPLICIT_MAKE_VARS=
-- 
2.56.1

