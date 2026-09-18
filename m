Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66850E59E
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748388; cv=none; b=XUmFvbm8XqNg9rI/4dC70nQ91CkC85z2IQry1XVQ17ox58/1/r6swGhgetZGmPnvr6NElXHrN7ftamzmZsAxHb/QDpwImM3zz5Ww02rB+mUA2besFqCJMY+pIInz4nwZK/bqmJ+qvu6wtONIj0tTkiCCEBDggt4wSOWurUVjRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748388; c=relaxed/simple;
	bh=aKDRweExIDpFoOPqCxqQ1of+wQARuE+wnmvfC1VF/qE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a8U6YARr/SC6LoFNRODbh5Oy5vvJr0mnNcLPfgs2FF24Ckgkrz7AaVU5zIKH20T0iTYnAiKcqSYg+8jqEgwFpSmymGnmI3Dy3Rv03JM/cOrl9hISTBBb2TmNvw+tMEI7hvJVXl5pclRvkNkGmHJbtMjP1884MAgE1BYX8eRQL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REI0acSl; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REI0acSl"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76906adso11569471cf.0
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748385; x=1790353185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1gwRe20gh9UwQ49ALwQ0TL0JTMplMzsDtM1zrlBEN5I=;
        b=REI0acSll06CA4v5Vy/t6VLO6AosZ1/2Z13qUvZdQ4Y2ZxNi9QckjkywRyg9ia84TK
         xq8C7VIsdzao879mju+dvrz9QtM0CNVW+EbenZPQNTaiVgtAxbXXLf/vytaFGyl51XS6
         6mIDm/tadDvqpG5qZv7NN1RVMFSILnVyGmbDON70NHZYa5J4rJ9cBNPTopq/4uYQO2dC
         A5rMQiBWq/ismi0m10t1Bwz2LAvsJoGiIyql0SiomOTqSgYi0BWQGNOoGVrTzbXhEE7g
         EoWwxpJS+mK6a0Gj0glVaA6HWfyZwEdZcUIEsGjbzibNrCzz6adC2H7OR1YUkXX3ojcP
         1isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748385; x=1790353185;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1gwRe20gh9UwQ49ALwQ0TL0JTMplMzsDtM1zrlBEN5I=;
        b=H9xooMiaJo8+B1ssEo5u9rZ1G1x95F1BAdidgHhWybEHoH0atnydFQZl0QWmMu03nu
         NL1J2S0YnC+uA6/4va7dfu231qSxc1+ziN3JwobCHzfVGHTGnKVOXo296Ir/l1bRqnoz
         3qmIVU22GxSNgHKMFge5CbFkz+XxZxr9hf80KfK/W7jvNmtZG0pzM5dtgmjwseFlQPX5
         FyOsfRBQ4IPyugolR2JTUkaN/ilBo0S3dZr/1ZoTC75iIuviWaHWRHjEJtPPLNIPj4Qm
         lXIGmka/f0rUxF4a5//xamuxuiyLNI7iVRsJnHFll0Gm8l1k1o+79U8I64lncYTjDXlp
         83Cg==
X-Gm-Message-State: AFuF++np3h272sZEKX7EDM9/l2d7SoHxUALCs7DWvUvAkpObmZxrJ8Q7
	RihFYP2scERZFJq4p/+VNM2Cjsnu31booMPbbwXtbbeB0OBUHTw1WH94d9c38w==
X-Gm-Gg: AYBFou3det7X4LKCftv09+4LYkbBcPfnb95eFjOwbjQ0VsdXdWR97jwKe06grw2gqTd
	tKLt2vdUsdWfL7QCtT110QGx85I99st3Hw+Rp+WPhkwUq4s6Nk4B1qfoZxYunf+OZCIkCfulwA5
	JPqZA/q8m1IbxrRGawbJHviSG2XgntdHAI1678WN6lDJPnOrBSnqtegRcY/7nY6ycVf4ZUiGScI
	Treiigv83psRjn3SoWjgzWleGFLYkFY6QEYzDXuKhuETbKNmS/KLQzusFDNRo34nqOVQZbu74FS
	K3cV9oKbbNaISEKfGWEiP1i3Dv1sW2LNB0SP+eT69FlBBHDTDve4l07B/s5/0EPowq/avnBc4Ka
	WDvA3CLZmgtivi6J5zXE8Xrixms4x/y8VunUDe1HQ7VYlsy4tYI/Y1oK+V2w8rD8e5OZTgNseDE
	XUsYTghF5R+TTUYzTWoaWG3HfYy1WtjEv8yyNkGu8LTYcoGc7dv8Jmeape2O2mK46R17maBmjhW
	5mUB8IYQrX+OO3PP4VeTWaTvM+JTFP/luA2Xcwhtl1NlO+Js9kRx0T9cEelBU7rJIZ4bjuV0ajG
	rkpffEg0JQ==
X-Received: by 2002:a05:622a:418b:b0:532:9d80:3fe9 with SMTP id d75a77b69052e-5329e3d16d4mr45360701cf.56.1789748384401;
        Fri, 18 Sep 2026 09:19:44 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9125805e1a7sm16010856d6.36.2026.09.18.09.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:19:43 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] python/semanage: update semanage-fcontext.8 for fixed regex anchoring
Date: Fri, 18 Sep 2026 12:19:18 -0400
Message-ID: <20260918161928.21194-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit c42116d304b6 ("libselinux: fix incorrect regexp anchoring")
fixed #544 for libselinux but did not update the semanage-fcontext.8
manual page to reflect the updated logic and flags. Update it
accordingly.

Reported-by: Stephane Chazelas (@stephane-chazelas)
Suggested-by: Stephane Chazelas (@stephane-chazelas)
Fixes: https://github.com/SELinuxProject/selinux/issues/544
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/semanage/semanage-fcontext.8 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index 66956440..85fda43b 100644
--- a/python/semanage/semanage-fcontext.8
+++ b/python/semanage/semanage-fcontext.8
@@ -15,8 +15,13 @@ This command maps file paths using regular expressions to SELinux labels.
 
 FILE_SPEC may contain either a fully qualified path,
 or a Perl compatible regular expression (PCRE),
-describing fully qualified path(s). The only PCRE flag in use is PCRE2_DOTALL,
-which causes a wildcard '.' to match anything, including a new line.
+describing fully qualified path(s).
+The regular expression is anchored at both ends,
+so the whole path must match; a leading ^ or trailing $ is not required.
+The PCRE flags in use are PCRE2_DOTALL,
+which causes a wildcard '.' to match anything, including a new line,
+PCRE2_DOLLAR_ENDONLY, and PCRE2_EXTRA_MATCH_LINE,
+which apply the anchoring.
 Strings representing paths are processed as bytes (as opposed to Unicode),
 meaning that non-ASCII characters are not matched by a single wildcard.
 If you need to match a non-ASCII character with a wildcard, put it in a group, e.g. '(č)*'
-- 
2.55.0

