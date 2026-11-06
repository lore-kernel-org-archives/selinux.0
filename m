Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980815;
	b=TPqOaiYLGiyVOJTQA4u4EIZkynRPJkq/uvAWV+XVMKhFkFKoVEVD80eqIb6b3lvA4A9J
	 SEjFxwNIXjJNTVBC8uteSzgrlHkD+DrBnhec4xtVF/+WiCIP3zJ9DeR5mhB1Pq4apHNPV
	 uY9CnCH59CPpU3r+xtz8vLtnETmWF/Fshy2ij470qJ+KGftAPMcwjClVaK5HREgajcXNv
	 dfLB4K2yGTafNGDLcFXJM/wnAq98TZUCInDX0VVjHxrla0xa+2OIi7bUV+1RDOPi93Nvd
	 niDPCvCNPCMFOk+Bb2iTpKEhr3RHcOhM0RTjUMyerrdc9Gyo84e1W3qd57kZfTo+okw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NsLM4CxJBs6Xn3z75UzZ/aPTdhlq5Q4DYpJAtQpgQhY=;
	b=di/AaA3d6vPtczQTZw9LPJ/LlCDdW5rXpg7vbD9+9C61T/jPWiS1B3ykuPujLxc8D4Fv
	 9j+KDSjFjr4AX2dAM0NSliPBoYIPU+HlacYV2oTXPuW7RCBtJnFiDH/d8BEtwlX52wyFO
	 7CAiHcq7pSUe5yT+u6JQ5LhWSurkoYGAmj70+HqJ6FdVqVTrJevrH0jOt/6vIDIsokMNP
	 rJPl90nDlHLLGgAA8mE2POuQh3OWaHcQnTTVM1/UuT5uimoirpx0qH1i2VkJYgHrssV6z
	 NKBOBWQTZClGXb8XUnpksAXAIPZjt2bdT5yo71cWqkunnNNtJCtkB16uuuXXTVbBkvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAoTS3iU;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AA606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 16:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB0AA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAoTS3iU
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53cd0c8614eso5560241cf.0
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980813; x=1794585613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsLM4CxJBs6Xn3z75UzZ/aPTdhlq5Q4DYpJAtQpgQhY=;
        b=aAoTS3iU0H9fwgUWam6Fs9vFJfakZIlgnOuhnH10qWG3QSytvbIkxl31ASH3dpwrf6
         R1El2E0MRtsq+8+usZw029jBxXS93OR2Q1pDCRGnoYth5Z4H1d5+4XJQ5uUsl7vFoCZ5
         GzR3wJFy1ABSabRPp8DLiFTLqlp6TzWqfDDqIoKd6Y+xO80Vq1d6yLyx4d3Si4ssVuOc
         xXUJ0Sq6RMWZtdtCJVReUNyE9d4tfsRiYmMv10n8YBDVDUNUd0idB+jhMyyNsNOOHYcg
         57ADfkvDIJ6Xa3Pelz37PBYm14M7ccj0vv/ZBrJGlPh8oM+DuPNtX4oidEBiW3Rc7Z1w
         pD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980813; x=1794585613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsLM4CxJBs6Xn3z75UzZ/aPTdhlq5Q4DYpJAtQpgQhY=;
        b=x/H7UPxqt/QdYfePJVFJXY/XFFVbN1TEXadfpAnz1lueh7xoRA4snzD7mnTh1DBz7K
         CF97aQuWMkWgUtsZjSa0ZIIuVgH0KCfj313i0Fa4sUWBP+o3MSAKlKWB+T73I7e6dQfU
         mZRoQ5gL8f9vPETS7kuyzveb+ljVBfXSVaWjs8WKYfMatfOIARQE6CdFZR/JZyYR3PDJ
         c7Qnhifmn+L43Cf+VGnVI83zM95JzzFds3l90lP0noLlT7b1McmJyc/KJlLbSrq1v8ZO
         qIA93gfpaUm66fN2ZBxlNjHPEjznJN5ooctHWW6te2jrlGIldSpPLGDRTBPA+7NWpyQ4
         e1iw==
X-Gm-Message-State: APuU4Z+mlwbKYe7ZQ0CA8P4tNyNHDO8VnoNYTnKoixRfbbU0d9P8LVyG
	OJoFG/N2bVIQox8OcsIOWtIwE+KESCrMAstZ9/7P2kpkKTzl9JZe6Kan2lqyx4eH
X-Gm-Gg: AYBFou1S5gxFpAY/IC9OIJprrw7+5fWoQmpSP/oOr6L1fWQo4axmM4p3Tvm/HSQTuaX
	LSDw4Rl+Bg3owTzy0apAWq91Wd2f2Iz9Q+w6f+3e2OZxkeSCEyKHHTMUhaRcc8WkMid10m1DExj
	hBAEakKnVuL+XboJT70IL+j8VjO0KCW/o19AriJrTan/M7M7984quPhrBOVxS41ohkjzLWGoq09
	QdCUkclKW2Kl/5tv0p20xUbRtWituMYfNIr9elKaSUtlm1780/2+NoJ7jBbExQgazR5QSwW4ThX
	1VaQpOirej+akTCl88gGav8+0hxwwoI8M948oKQ8+VScs/ST75dqImxZWHWTXWBUhWdG7+wGIJF
	Y2exFcu7fJj5KsfNmiPT+lZE810/OKxZpVp9CSdkf6ozwSk9MF2wqCoH8URjJS2GSg8UZPZ9vcj
	y66SEJBjIU7dKrL8bDOJzdqlrto1IuJElLMHtfc2fO4r0BCaJBJQj6Lw0R3jNHGaIWm/aI4n2W0
	oijyidJAZhw29ECLegCuGUEDE3S/vYXSOQvrVTEORwcaRiJWdNUJfozX5YatONTybNe1ZTeeGNS
	dzGfWlvlbPnJiPUp6IHUVUe7DHyhOtMPhfqh2AJzVHofQQb7vJFh0A/4DYTbqSSPGocDOPOBD/H
	ep1J7tCBwxNrFVNAIFFOGjKqzcchHkJ93+SiAMwHgVfP0rW1BD44r2sPZzsKeseykQnt8Vikh/X
	AWQCO4d9HJgSBsThC1wWrjNsleuRVZF1JC7eYy
X-Received: by 2002:a05:622a:550e:b0:532:af50:8d7d with SMTP id d75a77b69052e-54e1436910fmr40674941cf.33.1793980813000;
        Fri, 06 Nov 2026 08:00:13 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e231d0710sm23900371cf.2.2026.11.06.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:00:12 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Asif Nadaf <postasif@protonmail.com>
Subject: [PATCH 1/2] libsepol: fix permission value collision when linking an undeclared class
Date: Fri,  6 Nov 2026 10:59:54 -0500
Message-ID: <20261106155955.199062-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Asif Nadaf <postasif@protonmail.com>

permission_copy_callback() assigns a newly-added permission's
access-vector bit from dest_class->permissions.nprim + 1, but never
increments nprim afterward (unlike the class-level case a few lines
above in class_copy_callback, which correctly does
++(state->base->p_classes.nprim)). If a single module requires two or
more different permissions of an object class that is declared nowhere
(only ever required), every one of those permissions is assigned the
same access-vector bit.

Confirmed with a real checkmodule-compiled module linked via
link_modules(): before this fix, two distinct required permissions on
an undeclared class both get s.value == 1. With the fix they get
distinct values (1 and 2).

This defect is currently inert: a class that is only ever required and
never declared can never satisfy is_id_enabled()'s SCOPE_DECL check, so
any decl needing this path either fails link_modules() outright (if the
require is mandatory) or has its block disabled by enable_avrules() and
is then rejected by expand_module()'s "class vanished" check (if the
require is optional). No currently-reachable code path lets the
collision reach a policy that successfully builds. Fixing it anyway
since it is a real latent defect that other, unrelated validation
currently happens to mask.

Signed-off-by: Asif Nadaf <postasif@protonmail.com>
---
 libsepol/src/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index ac9a4f2c..79da5be7 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -167,7 +167,7 @@ static int permission_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 				    "could not insert permission into class");
 				goto err;
 			}
-			new_perm->s.value = dest_class->permissions.nprim + 1;
+			new_perm->s.value = ++(dest_class->permissions.nprim);
 			dest_perm = new_perm;
 		} else {
 			/* this is case c from above */
-- 
2.56.0

