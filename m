Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3D637AA78
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230680; cv=none; b=jWRFZ1Vnf1zc4oqmf1Tsx91+jKEikA3ptKXP6w4p16k2aTZ/2Dj2HTT3QMjdqOZ9OC1WFo/AHrDxQjzOx7tgpdOf824CLwXJpqIqRvqBPSt15cwh7Kt3Un9v6NzDceE9kApK4aFGegU2YK1DkPFlUsyNTElxAxpNRxiMUW2LgQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230680; c=relaxed/simple;
	bh=zTQrUq7URO3/MEITOHugXRnMLjq7Z+3uGNRDbJkV+Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUPXAdEI8MLNRcoeOHKFyMjwODZDD5z1M87f50fPX/dwGNlg4lgfNtizhxKagy2WtddLCxuOOdB87/c1WUZjmJ9VP1xQKNvWJwNjikRl4mq1g/q+bHx9iPH0C2H5NEiq6+AzeBB22XG8X5ao4wu5WR01CQVXEy4AUEsQ1mEHamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToMRUnvO; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToMRUnvO"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e65e18969so70567385a.1
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784230672; x=1784835472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Arl/qQFMWh0VD1UmBZTnsMZH05vLfi5ptwFG/9sJ6dk=;
        b=ToMRUnvOHmBOx6UYx2ynrQDRzNX0jLLwY83ZogHxeV1YbQPgpIcwBQRZC4sOFZFXpH
         FAJ37ZamjvSzbsCz5XQO+gYILrgYtwbGK9mpRCwnblmGNu0qzUJmKLCtIMuVtD7ij5i+
         BJuonYM7DVB9F4VhLDG1npdmGoU0B3dE7Mjbm8+JVRDNYzTVq4uvWH6cCtdm6GtSsUq2
         VP+1KmFRFAAUGx6JREUbY5TNtNKD9iJnhC1jRvGdHT0pJhkkgUox2ROjHuoygOZGs/9f
         pHM3jCJ1YZ2CbH6V6YYnKnN3kpPaoy/xnndm+UdwUSalgJ1YaBbMoNgDjY6Ya8hSAQ7Y
         PnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784230672; x=1784835472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Arl/qQFMWh0VD1UmBZTnsMZH05vLfi5ptwFG/9sJ6dk=;
        b=Dlkdth6hHoTOiHDc6/Clk+Vx1XJ+N+/xNAvxMuK9PPWrk4xhCmUgwMvsiJwrWYQ0v+
         i6eoSm51BowZvgfxEZN2JZdCitWLg8TKrkDbvjuxsICrTpTazKg6p+fUIOKl11MWRTla
         8OCXCidqlWXEhGhO0RRbmCYYbyhxPGNEplKJ9Jk9uRm3rbGC+0MgVWO4OPuPegqXRgk6
         8NNCR7LaKQDs6pAqoaqdCzrIU6v4VeKa0pyFA6XRMBIWQtTJ7yET54qd5BT4YUIV8KZ5
         g4jZG05PuT/cEdnk32di/6NLhnWuwwQAlyJHN1eYVs9ig2c/MHzjaHBtztOh44SJmMNj
         q6UQ==
X-Gm-Message-State: AOJu0YzIeXSdAMSqyApDvk/2vJi+p4RDmTMZIIqGt6HRqh+kitga8o6l
	96p5SmjV2PXBlE3n1BfDq2WX+Pk2orFtNmW0Pa70J1vhXQNtTg1rQs5lTBUISA==
X-Gm-Gg: AfdE7ck22XYhTry63cBAGzg0WTqmfkGWvOqgkeThl1eGE7icv6kz+qYKYjO/O63PMEF
	M+TaE1M4re4aYtAPvpIIqDuMD82xaFf2otCQMt/KaZrykvPYcHT8mYe4G4/z4V1gnihaj7yS2MO
	NKIEFwikSKfWuxiZVuHbthZIlVnbOjoj3U4DXhsjjDjOmOru3DC7ZNfbD1xYhn5kGwV9OlHCiSr
	z5Q7cEbwzB0UpE//eJLD+2YTFjWJzaN1evHublI3CrqKgsI5BKcChpFUvkmmQ7iXyooGnopTCIx
	qgHpqhoZ+v0WNSX2x9AlJ8uXMv2dXxw5Vu9TCprw0upPduQePp1WzV6M3BK0azJzBTzl/Oh9YUR
	0Ke/QxlRd4vqYEVo/lFHvVi9saZBFJVgaBj5GZ/lISis7KLyMwGlBustyZqiMS4OziDaVJTlfn5
	F7h93F80FPMcQX5PopgOuv2DWRRS9Wk53dDXTK7GyvJIuz2YEItnILn0oeA8qWbANFMPknriRQN
	HO7Sw==
X-Received: by 2002:a05:620a:400b:b0:92e:c0ac:aeb5 with SMTP id af79cd13be357-930a5fa8dddmr393306385a.39.1784230672505;
        Thu, 16 Jul 2026 12:37:52 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b492ebsm1987760985a.9.2026.07.16.12.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:37:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/4] restorecond: copy homedir to avoid overwrite by later getpw*() calls
Date: Thu, 16 Jul 2026 15:37:35 -0400
Message-ID: <20260716193737.11366-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716193737.11366-1-stephen.smalley.work@gmail.com>
References: <20260716193737.11366-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

homedir was set to pwd->pw_dir returned by getpwuid() and the
referenced string could be overwritten by subsequent getpw*() calls,
e.g. from utmpwatcher.c:watch_file(). Create a copy to be safe.  NB
Intentionally not bothering with free'ing the copy on all the
potential exit paths; it's small and will be taken care of at exit
regardless.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/restorecond.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index 0e973d83..6548634d 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -206,7 +206,10 @@ int main(int argc, char **argv)
 	if (!pwd)
 		exitApp("getpwuid");
 
-	homedir = pwd->pw_dir;
+	homedir = strdup(pwd->pw_dir);
+	if (!homedir)
+		exitApp("strdup");
+
 	if (uid != 0) {
 		if (run_as_user)
 			return server(master_fd, user_watch_file);
-- 
2.55.0

