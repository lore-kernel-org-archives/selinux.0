Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878E1F130C
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814583; cv=none; b=iSzEPy2U7NS+Vcnh7cRb1JVUsTIgin9lEpjQL5m1DAcG5SUfqY+XHWHyOTXksiWZJJohRaO1HHMRqR+IdeoMtJRDe6pTd3lobY77o7vyBpgYZLFH+AHR6EwiVjTH+suujqPlopTIzpKk6Eb7zfHGcZU1/3vsPUYOUXUdWmi0bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814583; c=relaxed/simple;
	bh=nQa75EiYN3ygFHWP5CltgBdCU2YvLoFl9S3DeRklaTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ6EJEc+i0kXBNndDRfDx4h+Kg32T0wUMBCcmGDP5Ad96dDT6nOAdABD8Qs1lB8r8hQmY3XoeJrfL1MZY3d5CaGLBcK0944hKg7MfUYxl8mIKaZHHOijFaIp0F/pdezPShClvzJw4Qzi11ExE1ohzAtj25nakdIH6goGw1V4RVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Nz8L175s; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Nz8L175s"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 01D2C3FCD7
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814580;
	bh=sxXlT+NKuH/R8o+IpND8qEtQPr3+MVFoHvHlcLQeNOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Nz8L175sgLMTMSxALgPazVZslWuxpLOb6BjhTDWtsIVrXJqWcOSJqrv70oAUpBspR
	 fXe7NKhmaFroXjEbbUAcHVS6X6hZZUgY70gJfhebRcByyz9Ree2UWlJRT5uZSSaz4N
	 3Z3+Fuw/I70K4YaZjfTuZugMRCmfUvpkwG0GjRLu/iW/iLCnRcdbS3rALEmvZSfYVw
	 h4xNg/WP62ONN0PIM9BbNixBubVfh4RqG5FynkbQX65CCJYwRNxJGeKETqOkAL+23p
	 yaPwRgU5vykJbTrr0/wHJuAdOpmlTxzn38N//8zk9tsYYzXXKuk2nruAW6uPrMBYpG
	 m8xrz/2CTCRTg==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so535183a91.0
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 14:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814575; x=1742419375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxXlT+NKuH/R8o+IpND8qEtQPr3+MVFoHvHlcLQeNOw=;
        b=nhHQn0kgtDtJDUTEPSI+/i+3AjtvhLMH6YlyZWzPeUrxNOkqvsks8m+4g9jx8FQjQG
         KoacxPzMSGMlp2JF+Hr263aOyggvqLAeDnnnhLQLjUtsbZ6+vAl5T2Jr+1ZJ+3eytvW2
         Dzwf/+iIXX6OCgUKujTlQNawOb/t6wvXfpTQffh670kk+eQaXt9nBS4TplxYe4qLKYX5
         6Y9bd/4gpy7j2Z6alsqOTsoAgtLnuHwUVGBmB4m4MrNt8ZJ6qtkvLrQAS13pO7a2lTIp
         yM0OK/2ybDxN6RenerBKCIab6ic/MeXExRbvzGosz7UQ9ap8SmVH9JcSebgsB0TWk2iR
         axQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1eh6aqgI4z1yHRM/U/GEt++Q1JpTXUD1CeFSi56ljGOOZE9G8EElDo8XvqUfnQZCXOQiRS/lD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FuH+GbcQ89Gtq+F4d5O8GBr/GXbirYin0TBs77ejwriLEUk+
	+GegRoSMjwJvOR6jetF6Q9LgNgwkeRgpDfGWcir+yMCqEHekVle0U2r3Ml0ovG7qdh1ofEQYi8O
	zSTwjNxStIRPq8YU3Kklkks8MzfnPtD1k6c69UgjFkQTotZJ7KKkZWkwMzF+63PFeUWgrn5A=
X-Gm-Gg: ASbGncvwm3GQH+IZa0BJE394yZNQRuSHYEmjVM49uGutUR0sa8pHohsDwd4tcwZeLR5
	MD1Vi+WMUSkoZhrvP/hsrMbIBZc+w2+QpV0N1dosEf/A2n6Ycr/Stb7+FxibC3bmmXCSp9oS7wp
	BJB2tGIJEsmFQY02ZWS+lu6Zdp+5Qgg0wfDqejmy8cUoqblWGd26swXGIzejU9DvwMS1A9PTDR1
	AgYmJkGimjt2PfSbOmqtSOp2Z08nAhdF1RQUpoEqHSYP/4PJOdKIp4v4iLjoGF9Wdvlrz/c9z5K
	DXCh6IV5cvlhPDT1JDYlIzbYSV/48BK8sj/DUPqG+p5a/R0lhBkdOh42qoxC6GKwmWEosCs=
X-Received: by 2002:a17:90a:7345:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-3011bcec36fmr4989220a91.27.1741814575228;
        Wed, 12 Mar 2025 14:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7VJ3I6Ag0U5c89zoKAvdV8xkokC+gkGPKK5VTC7ZbVdDme14D+x+zHYl4u3ZWPKhOLxMFvA==
X-Received: by 2002:a17:90a:7345:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-3011bcec36fmr4989199a91.27.1741814574931;
        Wed, 12 Mar 2025 14:22:54 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:54 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 6/6] tomoyo: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:46 -0700
Message-ID: <20250312212148.274205-7-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312212148.274205-1-ryan.lee@canonical.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that O_PATH fds are being passed to the file_open hook,
unconditionally skip mediation of them to preserve existing behavior.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/tomoyo/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
index 8f3b90b6e03d..efecfa7d15b2 100644
--- a/security/tomoyo/file.c
+++ b/security/tomoyo/file.c
@@ -762,6 +762,10 @@ int tomoyo_check_open_permission(struct tomoyo_domain_info *domain,
 	};
 	int idx;
 
+	/* Preserve the behavior of O_PATH fd creation not being mediated */
+	if (flag & O_PATH)
+		return 0;
+
 	buf.name = NULL;
 	r.mode = TOMOYO_CONFIG_DISABLED;
 	idx = tomoyo_read_lock();
-- 
2.43.0

base-kernel: v6.14-rc6
