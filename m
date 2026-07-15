Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807033B6DF
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132460; cv=none; b=RkByV5Lpx32J0kjLUSxsmqFKVme+pNLoPCSGQ+8tnVDzLLRaaPEcS+Bbwip1+CqLyp5vGI4z2IFwl33eLNM+KoLFi6AWHNzKrGOJKktwth/ADaWfH9PTswbZcEZikwHA4an75DhffxXTZq23oKXQZtrqZoOY+HpD6lm2ohkCOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132460; c=relaxed/simple;
	bh=KKjZKT3/jEfdoG9IkD2xJmg4ZLstHnpVvbj0OL1jDuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQitTScN2so1SOUbNH8pJ+ZBMqW13IuUxpGBkhdvCp5Qg5alMrx8rR3fFdi0miA8mkP0jiJUZlHGUpjM01nAe3zIgRe7lGbMAKvoJ542WkfHmgnd6OQ6Q/w1r4Meo1QUKrFgV311YZSpr2DCXlmGqJUN1c1FdyQX5OFuYbTqKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpgKfGsa; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpgKfGsa"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9217d13c276so382046685a.1
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132458; x=1784737258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8QHIFcU5WsBfnp0KyAjDwiZsl0HoIuCcaKlgek+UMM0=;
        b=IpgKfGsaiCba5sUwQcwTqZ/cHdE4/AWoESxoS4eND9ekuy/uWhIwgn6sQsNaU51HRN
         2RPPuimlcgYjWiwvVG94LJcgeN4lKN7TGzQr4NQpTCfL40h7JSZOsJdUI+wuHfEsMZjM
         f8XEDPrtrHq3OiU26NRQFeC/zkz8GCB0sHCJvhcPV3DBxSRwm55XAQnV3fqGMKlSvJul
         WG146ofca/9VSGtLynHngc98vFZUPUGbk4GeuoA3FTJd+q1IA2+f1y0A3D/FX+yahgRV
         ybE+8pXOODxSwx20ZpdR2zwu6/wGmNewAsi95Xt9Xeiot0S3p/S3bHNxwRrbeUjUfLKU
         3p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132458; x=1784737258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8QHIFcU5WsBfnp0KyAjDwiZsl0HoIuCcaKlgek+UMM0=;
        b=I2rS4tyZWhg9rH+GnEdeRNvGeac1P61iFwCq0U51hav1vtXUsBYrhgn6FaxvdWLdj+
         +kX04rUvi4HLrnSIF+SRdGNQgkNQrsW1eKLi+a6AjZOTw/AEcWgeTAruRpSmBTI6+dlE
         Dzu5DcS+1IR8x9L2tmWyAzeKbwpV7lq4etqLyR7DeqS11xOvgEwKXcX/CggVtC61X0QT
         S8WeKSuf/ZFP8kqkhihB9BF+Psvz9GFnEbIB284CX9f3sKQ68gs+0PuiBAqPZpFv0ATC
         QqXo4bi2m23F9GsQNwlnm3c3/kzdTo8pygr5VTF7F/lpOD/IT7iQEQSQWFGbDi3ycJuU
         z9Mw==
X-Gm-Message-State: AOJu0YyFUaFUDDQ2AkMqhzuv3hoW1f2JutW0+JgiXXTmy7064jOjzisP
	p6EeRI7ZB29PfpjT2pKPvamWtPGd29pbxfMfa1uuI1A2uXJS42SSwOgEg+9HVg==
X-Gm-Gg: AfdE7cmd5W+QO98NrHvKG5vlKSvZau43eBAFVOP0xxblGOCltLOB97TNtzVd1/WN6pd
	JSs6mCh+yw2+E9B41Fimeamv6zFAN2rEUQL886H8weP643qxQu/pRl9MODEb39KEe7aJuyJjFEI
	QBV56ItnrkbMu+GVI3HzYjU4jQrDMRm+/V0TnfprW6/bLv5KZ7Y3V6GzM5YwKhq4pBdDJYNJ43B
	S8chLzGcEEU7sVtqVRjUKN9BGXbeTueq1KuigPUfze6Vf2CFwglSyWpLBAtorPoFpvrL/pQZDZ9
	u/o6xuKrbM6dc6gHmejOAmq64dL3L2tRPOMt6JeLJSRLRsvCWRJ7lbied1WU6kwrxfuskN8sz2f
	/bizeonVUOh8msyJ8nL+e2E4Rkm+DcKlTUVBgBCrAw1dg0Xrqie3Q8F/Z/K5YswTA2pm67iR+Ck
	9SO09XOHwdxj07e/F3FEgkaOXQQDWTifgX75fa/LQQkLSwNJcWjXW7rzYyc0PzSOdeEtsc95lfq
	ROFUzkt3FCYwWjk
X-Received: by 2002:a05:620a:4411:b0:930:9bba:744a with SMTP id af79cd13be357-9309bba765fmr232681485a.71.1784132457639;
        Wed, 15 Jul 2026 09:20:57 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1694855485a.30.2026.07.15.09.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:20:57 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 09/10] sandbox/sandbox: clean up the runuserdir
Date: Wed, 15 Jul 2026 12:20:35 -0400
Message-ID: <20260715162037.42329-9-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
References: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sandbox was already cleaning up any residual homedir and tmpdir
but was never updated to likewise cleanup the runuserdir.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/sandbox | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index 8c15d659..d909fc44 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -532,6 +532,10 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
                 if self.__options.shred:
                     self.shred(self.__tmpdir)
                 shutil.rmtree(self.__tmpdir)
+            if self.__runuserdir and not self.__options.runuserdir:
+                if self.__options.shred:
+                    self.shred(self.__runuserdir)
+                shutil.rmtree(self.__runuserdir)
 
     def shred(self, path):
         for root, dirs, files in os.walk(path):
-- 
2.55.0

