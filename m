Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E443314D08
	for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254393; cv=none; b=aUME3flSAYtcubrhC2N51BrCJMV6VryDfr6Pi4g2AMfmwJMWhBXxJFo2btieAfYuXxJ9KSqEMuiLwQpVAgCSwPTUZEbagI2p/1nEdfvTHXZON0+Ndy0GGpkEuo1LJPhmqAHmEYiFGZXmpBxMehcDyNgMTuZxifykyxZuoVPZpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254393; c=relaxed/simple;
	bh=lNDowtUHSkw+k/WpEDgGge0SfGDSJL247zcNQSwuyB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kwn99D+XnSbaqt9rTNouNaC28sj8iZh9pzDLWuS6DzkwNeQIKcwomr36qanqzv5Cir7u09Mlq/d7IWzIi5M4LCcMj3fdkcqnaXIPEbLByF/cdQXSvEK+oaid2nuZyQ/gg5p+fyZsW0u5YZDpOzebdyFZ+MNX7LL7EYM0NkeziRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGbwzfUd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFHNSdXo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGbwzfUd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFHNSdXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771254391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8u7jdAWRJewFqAbMnC4XSsYdyNIzBSqiconhEF9G/OU=;
	b=YGbwzfUdoXX9hbcnZEmgpMtCOnFDehEiq7YmGUP2OjZS8T2k0GyRjSO9IkgwzVI2+pDHtt
	lDVeGVZDGmSIfsa3f5uta/2Uk2tCEzSzbtB0jsYBYstvubu/pgbc0H+wxp1mlN+GKTxSsH
	dSME3zjQqAD4Oaiq+Ua6yxsZeqQP1vs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-x5QMB-OdOSuJC9mEm65jNA-1; Mon, 16 Feb 2026 10:06:29 -0500
X-MC-Unique: x5QMB-OdOSuJC9mEm65jNA-1
X-Mimecast-MFC-AGG-ID: x5QMB-OdOSuJC9mEm65jNA_1771254389
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435a11575ecso3341663f8f.2
        for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771254389; x=1771859189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8u7jdAWRJewFqAbMnC4XSsYdyNIzBSqiconhEF9G/OU=;
        b=NFHNSdXoOfWF3rPDPk7ZrUrna2Bg8IYU1164qW8o8JylggKfSXWmTH8wr0zwe9r2fq
         TJnwL3Sj0JI8+cuJv684XWYuodFAcbQyheSaoMW4OGbhV2iASGf/Rn+kjfawNUwF4q0Z
         V6bCHdiFvATH6b4FY6HMrK7nRUIJaVs2ONqR8DT32MBtkkYno8rygXU9B551Gj9VkD63
         s5h/8GIvv+l3MTJobzGVzFMhnFqZ3CUonn9ULz+XeVyWA0XE+BMwMfd0Y0zBYIEDteZT
         Q4/v+Onx2GogJ5hllVdOak/o8R48+3rQBF10IG/ql9nDb4DG6Jt8gCYFLykavQg/n75k
         31hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254389; x=1771859189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u7jdAWRJewFqAbMnC4XSsYdyNIzBSqiconhEF9G/OU=;
        b=O8VxsDV27U0DVeccm2+Y/LOlYKLiaBfjR2QNbT269oV/6PfY9up4ZQXK5plrGGkpjt
         K9WkCev5KBhpM2JyFpRITSL7dDV0X0jsyb+BwJaGfTgK8GD00c7z3N9MFMZwvi6n9ZQ3
         yJl7UktUxvQJT7knz0NzPVuzcheKSDkjxk/Tx6rmy9vGtJKuKlpxX9u4Fx2Qm5VqaEaY
         rYu415OQMrLC5xTz2JZtoHdfemLpVCZFrYDIATYuN8RJ+GLK+97et9HH7Y4RXAFXIT0E
         +VV97K87LEaQ0XkEt6oLJxTJaKZYDdgGCmhl8rqJ3fHKUDQKfzMv04gc33NGLwJaxeN9
         qWjA==
X-Forwarded-Encrypted: i=1; AJvYcCWVG4g4czo5/M2dX56DCdgM377QniWIW54OPK0Pj4//y8iDoWy53McoxDNVROGJLgVK16y1ryxX@vger.kernel.org
X-Gm-Message-State: AOJu0YyHEQlHzNbqhhMVt9m9CEngEhoU2D2rQHCCsuMrxTieRv65ImYf
	k4gtJDAJF1U50DFwqvHVyaP98tGMbpWdTeoeI8wd8E7eq1TqWIAb74Y793qEQwKPEj+ODzcLeIJ
	1dSAVOPzFaKAO9x/7fdZYoX69AtyRmDU34UMpEnbVjc+bWVDUs2XUeSlLjuw=
X-Gm-Gg: AZuq6aIBcUphn2qaIeEXNJhrREHUIZNIrhTs80BS6e7loMhoj2HUBEXcrpp7I87MECX
	Gy8/dtotUW62RmZh8aeAAYoUbovGkJb78oei/VkDv9ik9I0tXHHzIPBNji7jvxtpbz4fgglPgtR
	ntK46NCkOxBJToR2eT1bzUo7Jvlwni//EokkwKIh/5HyVmAK2IKdKkudDXWzlR+u3TLC5wOwrVX
	iiicxCJfemF7HdcihB6/VGNpyt5JlBXI4ckl2z5vckk68gGz8Nml7V94ZMw+3mvfZgiRqB5sGJe
	MTnuk59s3IK7zg7dpqYrmOask/Jti2Yf3oxSy92kGtD+r3dWMXTg8+kpJpK3kJevjyUayqgnCdF
	I0pyjauuL2uD8l9Wq1arEkBOQVzzRfq8xBaYs7DuaO7JTgssf
X-Received: by 2002:a05:6000:178b:b0:435:a2f8:1533 with SMTP id ffacd0b85a97d-4379793d97fmr18660424f8f.52.1771254388680;
        Mon, 16 Feb 2026 07:06:28 -0800 (PST)
X-Received: by 2002:a05:6000:178b:b0:435:a2f8:1533 with SMTP id ffacd0b85a97d-4379793d97fmr18660369f8f.52.1771254388191;
        Mon, 16 Feb 2026 07:06:28 -0800 (PST)
Received: from fedora.redhat.com (109-81-17-58.rct.o2.cz. [109.81.17.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc9b2sm25631899f8f.21.2026.02.16.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:06:27 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fanotify: avid some premature LSM checks
Date: Mon, 16 Feb 2026 16:06:23 +0100
Message-ID: <20260216150625.793013-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restructure some of the validity and security checks in
fs/notify/fanotify/fanotify_user.c to avoid generating LSM access
denials in the audit log where hey shouldn't be.

Ondrej Mosnacek (2):
  fanotify: avoid/silence premature LSM capability checks
  fanotify: call fanotify_events_supported() before path_permission()
    and security_path_notify()

 fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++----------------
 1 file changed, 23 insertions(+), 27 deletions(-)

-- 
2.53.0

