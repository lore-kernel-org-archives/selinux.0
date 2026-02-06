Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9593DA7E2
	for <selinux@vger.kernel.org>; Fri,  6 Feb 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401065; cv=none; b=OXKjbS2tNYumi5NLc26VgEuIgoSi6yEeKRXbB6Ebu44h2B+9uMJ9rXXb+hUWe9rdwbsJUd1BNKKqnbAotmjhxPYs0/k6o7MRvqZJ4UNqVKYXUUiJFnWhaSWxNIcNmwe1wMPL972ZGjIUIlD0wFdkSXcB6rAaJ5oBfz8CSc2qxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401065; c=relaxed/simple;
	bh=7j57Kb9zrP0CR0LLOCCTX071fm5XUGcku1K0dLPTMBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GxGjs2h91j0qI7bdbvv/XcxXfHIU0gQxFLQHRaBC44DGssm0vr7B5+RN4wmwJplTwK5igaMf7UEbGMfkFGfwRruhMu3CCEGTC5qqp0utOnbzOOJzJclAxmPCC7tLhtxypX3LV2TvkG+fNI8mXX8HiCnK/QjpaH/4LgRFBtS7qO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AolOWp+J; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AolOWp+J"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5014600ad12so16650751cf.2
        for <selinux@vger.kernel.org>; Fri, 06 Feb 2026 10:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770401064; x=1771005864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T13Zuh8ax2XAoP2rJy96BUiZCKe9bDTomtxx5ZB6o1U=;
        b=AolOWp+JClR2cNZ6FAgL8x73pi73MvtpXYZeivWEA5kTo3C+SDLebUJLHTXvTaaWdI
         g8C2G0vSSdqwFfNmGL3dgrcW48zZxGmYuvkTg8Bm5vpdRoub6eZ6xOyyFhhbPNm0EcW/
         rW8TOTYkbbArJlAYqVNRjxXVoMNnQ829SlFaZ5NfJY+Jm0pPm9luESCkcMNPzYhFp/Lb
         h+pQqrX+rCUqtpJSUfcc0IKGRSxFTEBEiKuD7V5Tk7BDnd6S+LiGXsHDusnvUpXrNgpQ
         bdXcpV+bF5nHJYOI5AjnDht42SM6Vb60QIGlR7HvyB3Bkht8Xjq4QGnnhRJTY4l3d4DL
         MnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770401064; x=1771005864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T13Zuh8ax2XAoP2rJy96BUiZCKe9bDTomtxx5ZB6o1U=;
        b=o5mQpSPeKiGoX/nx3oAS79+KtdZAkEo8Ykfvymbdawv0VgUv4u6mBRV9r5sQve0SaF
         Ou9cXx0KSYoyCQ1JakbC8VS8TlxPI98rzkBhL8VStGXyVO9sFPxlBYdvrm2SW9RlrGyZ
         3bxUmtdDW4Xh6n9/zMUnLIsl4eFS7JUx+OWM24nXfaS6I5FIsk55hHhrZ5pQvtAr0cBd
         lIsYqkEWr4RIegnush3kXK55nHRcaMJQbFadt3cRcRA2Fjg068Lxl7M0MQmDnXiXrz5w
         Z0BRu/cT9MULZpNJqwB1ZS/A73qVumhQUnYUU1AmuAsRjTSoxWUNAEOQzdXrGlPlSDdm
         ruxw==
X-Forwarded-Encrypted: i=1; AJvYcCUPSbHIhHA45A2OyFbaHZIW/I3qzSpBTFRLu/dUeITm1YCrMQVXMbE8VPtybGQN8cb6pm/nbq32@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/uvgb06fHHt7AjQNBdfpgAoOVwai/62VkLCQpO4hOylPgHS/
	F9rj40rNWeRVL1OseB+uGoRR/GL2J9KrQW2knp0MvXPKIiU+QT8xW1gc
X-Gm-Gg: AZuq6aJFijO/dNzC4kYUkzg8SieSTUbgdskwyFl7YBD0VCjIuCuHqdDqdQwR9DqREs0
	Vm48avOYnL92psAD5RO9lyJP8ZX7/F6TCHAXFZQEf9tZd0JIofEGuOSNLOc/spnHI+HxtWWF1pR
	a1Cvqf934Wf34VST6X5lquV4BPgX1+1q88SRq/vyG5T2O0G+/D6kp7SEmwmRuBXJlXCrdTqgx6z
	L/oKxfzld7K4D6Je6haihVpk4EuY/ZU5Q+W222rn/Vd4JJihHILizoNZoTiQJoE+EIxHe54alq/
	51WiYY5h9MAvp/GNT/PzXondLJPPOZH7FZMiUY46DWV7ekisPBFPv8oS7Rf/aQzFBxjMWAc5zLZ
	tFaBP+VN8L+4VxG2a17Oz79sByW4cpFDq7pZkaUhZoL486136d7Yii1AAZp4i8Zjo734sp6xq4u
	b11kkzf8wfqBhnTkRPrYECxG6p/gGvDRlajAsPkDsQH/WbAIcOsc7uIQy5t5NGwV31DW/CUJaiD
	6KRdnZJj4kG1NRF
X-Received: by 2002:ac8:5993:0:b0:4ee:197a:e809 with SMTP id d75a77b69052e-50639a1f418mr41640841cf.75.1770401064059;
        Fri, 06 Feb 2026 10:04:24 -0800 (PST)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf3814csm21631946d6.2.2026.02.06.10.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 10:04:23 -0800 (PST)
From: danieldurning.work@gmail.com
To: linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Subject: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
Date: Fri,  6 Feb 2026 18:02:48 +0000
Message-ID: <20260206180248.12418-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Durning <danieldurning.work@gmail.com>

Added a permission check to pidfd_info(). Originally, process info
could be retrieved with a pidfd even if proc was mounted with hidepid
enabled, allowing pidfds to be used to bypass those protections. We
now call ptrace_may_access() to perform some DAC checking as well
as call the appropriate LSM hook.

The downside to this approach is that there are now more restrictions
on accessing this info from a pidfd than when just using proc (without
hidepid). I am open to suggestions if anyone can think of a better way
to handle this.

I have also noticed that it is possible to use pidfds to poll on any
process regardless of whether the process is a child of the caller,
has a different UID, or has a different security context. Is this
also worth addressing? If so, what exactly should the DAC checks be?

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
---
 fs/pidfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index dba703d4ce4a..058a7d798bca 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -365,6 +365,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		goto copy_out;
 	}
 
+	/*
+	 * Do a filesystem cred ptrace check to verify access
+	 * to the task's info.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+		return -EACCES;
+
 	c = get_task_cred(task);
 	if (!c)
 		return -ESRCH;
-- 
2.52.0

