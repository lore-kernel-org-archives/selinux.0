Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F632EF665
	for <selinux@vger.kernel.org>; Tue, 17 Jun 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171193; cv=none; b=ID2NXmt6T8jyIL8yWxbPN0Kd4cBqCCIZ5IBBwsQm1tf33+3C3rcOz8BV5dlMZap2yYYZFo1vnpME77OTov6cjBZPloCzGOLHkL3aC9EPpFgUE4OlJ78IYG331It2jZWvUxhI2Ut5WYB6o2mlhixTyhFhaHLcy5ni40bjivaD8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171193; c=relaxed/simple;
	bh=LRkmpPSzaUUeGnTXOWoHZMoItgfIQsY8lBTYW400EOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eW7WMcNEfFzEVI9Vl4zb3/ZueSoZn3opXYq+5XcwyKhYlu2ILk9LF76EfOuka+WlLRWMVO/eByRZPG7c4Gbm3PGPQKBx2ROaZUbB+x/IRJMRhe/80uM9GabVuCu0GhvkyQDYuzQv8w+JJAE3+yU3MBcK9G5T3VbD43Oodgtdml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OllbdpJi; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OllbdpJi"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fb0a05b56cso113362206d6.3
        for <selinux@vger.kernel.org>; Tue, 17 Jun 2025 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171191; x=1750775991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MQs8NUmsdbMtsrZMdUAh7CuToa3L5lHMdco9XdmbEE=;
        b=OllbdpJitilkJUBkD2ZnzK7xt7GqyYzMRs4x5AZwA0kSMDBxCgEy9t1sH3YQNxYxF3
         9TWw83+opb8g5HPZBQbJOGJoDgRzD0ekIUvC2GAaRQWvHDqiJ80c9E0HoP5ZZvKJEsab
         ivmPaWT9NHlrdmK3sTHm8AH05WvqAchEM+guJq8g3tq4QtU5nnZeAhOFcIryUKgXb8KL
         zBje5cXQCfXvttllG4fNgPr1YlnKOsFriCCaksBsC+BxG1LCJX0xPV5JBliEFrXELzZw
         FWL3ULEelzSWofmwtQsm98AZgPDo6ICX91rlTqCEzLi8hzDO1z4Gw7usPRyE06L4Sd9Z
         6quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171191; x=1750775991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MQs8NUmsdbMtsrZMdUAh7CuToa3L5lHMdco9XdmbEE=;
        b=P0AyBkAfFbStG/Crlk7vx13RPtskuNo7vwBGqcDBt1OPpLAxbrgyJiKP6zVvpDxscz
         z/YcUWm6Xr8Mswtjv80RORFX/HbgzIWr8yIyaFDEIHspV+2Zyh5DwNkQTwkd65cc0qhC
         YM8mpqfB0I83ZxSmBTYPNm6b5kEZCCGrerLZIF1PsK6umDMVNFmm+XFzTTvfO1uXND36
         Yr2zGGes0dARiVARrKFiNa+lOhwaIDcfmKcYI3uS+J47FDVJxJwGyce+MhAx6cvbRfDr
         /2AbMlOyngDqeM3GnI3KDaWAKBlkl3tUf6aZYAMDML7ji95hHGAC7hEIMVALnbZTEj4F
         71nQ==
X-Gm-Message-State: AOJu0YzQ4wZ7A/U06TJLDAWKKZC2kiPL2LiQZzbeIppx3tvI+BHf0Vfu
	RkaxomWOpY6F8V1oss0oNjjE1K/KTPakS82hWHZAl4uUuH6SPd2kdRBdiD3+5Q==
X-Gm-Gg: ASbGncsumlezoEEQlN/c6Tzao8y4Npv2QI5mIZ4VLqsKo/tWUNFAlWjBv2rNKO2jsvC
	qr84MDzCLypUiz5JbOmINv/uOSvS4E5evYQ6i1qpYKcIM1/1j/UvdeCBok0gaCY2W39bPYTPYQ5
	UjipKxEBD9KusiXkxXBjDxTyrud4EIGpAz89n0AbwxFmyDUHWtWBkVy7Uus8/TACArWyqWXtegO
	i7zWIpERKxRnI0TaTsQ6zLDC1cnHY1Hlpe7Ufc6n6NhKkXaN8DtSb12SzOVvljnt1DgFqmqPC+Z
	aUEVQS2WwoViS9UJbMKHrJOuEvScQX/gvxUPRk3nke7Si1HJA6nmN/2CqWYtRHsN5j3fFf3s+f3
	/z1OQsz8RU5SHfOIyPHh3lk3nXAImKeO3JODHTMzB/LucxiCfJuU11lvXQvp58hQi2rqIkiGVCK
	74c6ESJbBKAteN6kM=
X-Google-Smtp-Source: AGHT+IE8I+M/FrER9TRGRsL8Eh+1DHXAqjEFaVsQaTTPb7qlMujWXhQ+VSwDtaFwKTd28tQmUFVZnA==
X-Received: by 2002:a05:6214:2509:b0:6e8:ddf6:d11e with SMTP id 6a1803df08f44-6fb477d9a0dmr191418686d6.21.1750171190899;
        Tue, 17 Jun 2025 07:39:50 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b20abasm63006436d6.1.2025.06.17.07.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:39:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] Documentation/admin-guide/LSM/SELinux.rst: add links to resources
Date: Tue, 17 Jun 2025 10:39:07 -0400
Message-ID: <20250617143906.22706-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add links to the SELinux kernel subsystem README.md file, the
SELinux kernel wiki, and the SELinux userspace wiki to the
SELinux guide.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 adds a link to the SELinux userspace wiki as well.

 Documentation/admin-guide/LSM/SELinux.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/LSM/SELinux.rst b/Documentation/admin-guide/LSM/SELinux.rst
index 520a1c2c6fd2..22b9f91b220d 100644
--- a/Documentation/admin-guide/LSM/SELinux.rst
+++ b/Documentation/admin-guide/LSM/SELinux.rst
@@ -2,6 +2,17 @@
 SELinux
 =======
 
+Information about the SELinux kernel subsystem can be found at the
+following links:
+
+	  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/tree/README.md
+
+	  https://github.com/selinuxproject/selinux-kernel/wiki
+
+Information about the SELinux userspace can be found at
+
+	    https://github.com/SELinuxProject/selinux/wiki
+
 If you want to use SELinux, chances are you will want
 to use the distro-provided policies, or install the
 latest reference policy release from
-- 
2.49.0

