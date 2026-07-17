Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F373876BB
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313672; cv=none; b=ViwJZFbcep4DqOrkaTNXsdKJOsjQshkpWjMPe7SkiAOyVmqZ5JC1mR0k2FY2o7wZEfSjFKLSLBcpjxOq2O/9Pdr9jRIDPi5P66p4p3xg3L1YxtbmFB6iPuM4QiZ5x0UWeRFeMXLwtdELngg2WcaVqitFn2aTul2Mw7r5B5OMT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313672; c=relaxed/simple;
	bh=h1Wpakb8lm2paihv0uaXwx5G686Fcn9dUF1r0BbTR/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojIyMwObxhZ00c+QHlRH8iwzU2IZAdNJArvUmaH/B00GFo4Z25WNvLYSFawItJCq/ioiY6Ysqpt2ZpVvASG3/uSYLglS/IL3SAFBLeZoN7rqGjH4qnUnm9Ffqa2oK70Eg7PZCpmipg1/i9FQ2DQsnIoebkw4Z/P+Tjbh+tI5NII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU/JszfW; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU/JszfW"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so36340276d6.2
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 11:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313668; x=1784918468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEa8eBReY6Fv68yK9XtJ3qlVRlZT30x97oi77dA14Y4=;
        b=hU/JszfWNZuqJdocoT3DzrkTXcbN9NEjJqn0wAy5x7zq3gj/tJzZ7VjypU4HQFNiMV
         zxn0epUMrD0t9ypTMRu3WRm5ZX94VAle8ep93q+Q6rpVzstK/j2CQUYH3Ysx/CL2iDil
         aaodoUAoPv6y4MZuU9qEzLNXUFXR0HNzYIatderxZFTBU7rrYrVK+6/Hdw3SyL1NnATh
         EMJSnPt3Qs3Jpkq5OgPPaTNzyg7BXCyzPHNnNi9C+4bVqPnenCoEDKMbV9mZsKhYOq34
         BdJVwbIqLLqs1WbM8cN3xMX2pXDFAZtf51i5+q6d0a+/fPiPOFCXAKxs16k6JWW8oD2h
         tugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313668; x=1784918468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEa8eBReY6Fv68yK9XtJ3qlVRlZT30x97oi77dA14Y4=;
        b=TVwhOM52l5WWENDPSbyUkM65u5KMETp9qisVIVP2fUn3sBACHFME3iMvFCh7fhWDj+
         m9mVd5oGs/hYTGG2TSjZ9E6uYRrrqRrlUSoA/CpxVIhYxwd4c3FWMUGbw5jfrKO9abkx
         bHasRh4DdElnJpHkO/bqMsSjgo1rGrWiJMjk4igkvUt5Oo+zPksJjCnUvntv//rYvJzW
         OuYD+R+xM/2xV2DSMj+QUdZP71ihYJUPdaSu8LrP/qKiezYIs3ZJeSOITT3+xf0VpFxy
         1doKXSb44jbhvwn9C8DrcQJMENkqoknNqqflnMf7z1CxXVrsLoXsQdRn5kJ8i1CWecoj
         2C9w==
X-Gm-Message-State: AOJu0YyltJLR/+m29I2xKloM+CbhsvESF38UX4IzH8pLeyJzO0G87RqQ
	rH6p84Zcwq4Sb9MO9nC8M0D6YmRN3UVQ8ULapZHlGlEXErJ/jMXrmCe5EGkm5w==
X-Gm-Gg: AfdE7cmQVMa9J5ML05r0DVYCQvGKFaZk54OcjGyrJ3gqTkl1wYt8km2G/mdJ63lfMaq
	wtoHXNb1LTm+ZwO0yu5cZtfXT9i821fqxnmEzzP8V7wQQyEV9ORTbW5DIZgEN6SWM3KxiIobzdy
	QYFJ+RXHZwzF9GvhT2ynrcEYhiS1UaGN8gcZTuz28jkolk/Vk+QHY1+nTMbttsIR01/AbbHnMLr
	erXPzgdYkVpdLuR9n8/n2MNrZ8Im7Ye/osaxBa7MaMhM7LgMsLTzQRWak9qBMjyvpYRsMUzrYCa
	96UgyzFswrzoSd1FJHqt0G5LJosyU7CfhbaVgLXtzD2gewg59pRJlRuX8e0m/uG2yvW9QV1knon
	NGR3d7/TW2b5ol9X8Rjktei8uhInGg44cuQx3FzFsRGK1BEF/bIGVOZK4VURryAdv+8IXKC4cfF
	uXUS+ANPDefocA7OJk4DKWU7plq/OI+v6gi1HGV8hx8csla+x96nqucXuE2+lM6BQ/QGhVRnXdu
	IUHdg==
X-Received: by 2002:ac8:57c1:0:b0:51c:1b46:47cd with SMTP id d75a77b69052e-5213aa6d7fcmr35231411cf.12.1784313668383;
        Fri, 17 Jul 2026 11:41:08 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm22756576d6.30.2026.07.17.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:41:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 07/10] sandbox/sandbox: use slicing rather than re.sub in copyfile()
Date: Fri, 17 Jul 2026 14:34:22 -0400
Message-ID: <20260717183424.20324-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
References: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copyfile() rewrites the leading srcdir with dest via re.sub(),
which treats srcdir as a regular expression and dest as a
replacement template. A home directory containing regex
metacharacters or a destination containing a backslash
will mangle the result. Replace the use of re.sub() with
simple slicing and string concatenation.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/sandbox | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index 4e7d56fd..3368a95b 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -84,14 +84,13 @@ def error_exit(msg):
 
 
 def copyfile(file, srcdir, dest):
-    import re
     if file.startswith(srcdir):
         dname = os.path.dirname(file)
         bname = os.path.basename(file)
         if dname == srcdir:
             dest = dest + "/" + bname
         else:
-            newdir = re.sub(srcdir, dest, dname)
+            newdir = dest + dname[len(srcdir):]
             if not os.path.exists(newdir):
                 os.makedirs(newdir)
             dest = newdir + "/" + bname
-- 
2.55.0

