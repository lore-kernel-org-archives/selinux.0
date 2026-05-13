Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722E201113
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680779; cv=none; b=ZDBFFr/LxsTprqGiBlrm9h/j+ewEI0Cy+EwznteRpY/EKkqR3+ORsxCqVgwM63qL/fhtZBJTeN5oloOhommVx4ja82QKibqbuAVDpTkBBCYCcAgm7TSu/h851CdPKjY/PqsMA9FNn307ddEWHNqU2HxnntV7q70XaQ/xg92DEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680779; c=relaxed/simple;
	bh=wInvCdL29slgxJmFFSrFuEx9ZwcbWPPJGSaEHsmcV7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGRlBhIR0244z6HG1sNzvgXo1+8u+g4KCJdyA8u3JvK1jp52c00306nAUvUX6EObCjcQh37iNi4L4nBVdUstGKE8isWSDlNhEv3JXxDprmyE7fiY1Pg9HKzRJrDYF9Djhg0uThxNpH/cwxncioloholZA/phXgCpl7g2Gd0h16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfNNS1Yt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfNNS1Yt"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e97863425so67348851cf.0
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778680776; x=1779285576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SFm4YueujkLa1T9sWLIxCzUgmCFC2jF7CnaoICASDUk=;
        b=KfNNS1YtZmchPaEXxXQE1qOX2wHDUtx87IFqWIcU446kkl0voDfd2gBIQMyXCRaShf
         SBNxs/F8kWkpGS54tyF3Td6FxCOUWLgEMxZebyJIMaS5Ypx39RtvnegR72/IrbO1Sa9z
         xeqI0qKRyexB2fYOXRNTKmp/C5fH9Djbb7DPvqH/DZJSUA1MQeyUFwF4rZJNWByiIzOA
         gnDd8c/ryJ5iAYF6xkW9mQUbsSXFPajwWu9DdT4C+Y1aqFSp7F69hpyyMPpAvS6wlJBC
         8J0/Vw6EgdO45Z/1jN/feLtj6lZlnItmJVMTQssMMbHixYSvg6HSwHwg6K1g9V+MWwFl
         rPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680776; x=1779285576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFm4YueujkLa1T9sWLIxCzUgmCFC2jF7CnaoICASDUk=;
        b=jcu4hpE9UXnEEdAoGPTypr6vC/VbbhXJdhLo/bBu3Q+z+6qhkog+h6GgaCDmQpyjJq
         C0P8G3lFgLFHQWrjvGaMb/35uIE8bqmmxY+BWIjmCtZ9X3ukSUAEG009oQO+FfedFyHz
         9SmxHNDxFZ2s+pPt1ZhYI85VQww8+GfnGARJSAZwW0LKVL+BGapDENbnWhfDelA4OAn6
         Ctw7YhvcWhUVGjaKYL62OvoTYrXDwM+ZULAD8hJqL80yBmwkcsk1z+xgkMyyp1JT3pZT
         tS/9fUK6oAcj3rFRrp6IVEquMsnMcOcGqdRbGibKeohhwMnpGuYSPSQa78+F5er+j4FV
         GlCA==
X-Gm-Message-State: AOJu0Yy5hl4hpTVLVgr7pU4xhnNJzAbgMbg4MdAgB31A9vinPkzZLm50
	kzMiKdhPiGzF27BmwzD4JjAILH7Y6Fxqch9eJrcNXD/BRItsi1cIjXr+V/r4iA==
X-Gm-Gg: Acq92OH2QtB/Bm7XtqvAlCe8I9fmMO2YJVqOa5noLXuLYxJ14J8jvWacaY6osXAkUr9
	t0cqLicenmzlbzAJjXPNBRRPqkMg/Hm/E5VBOpt+OFiJzGoJRumHXEoVcVTqe96aMxmP1WTTjLz
	+hma5g009kkRgmtyxAIokXzntN2KyPOBBo3hVWu0eq9nzVZWA9oSYMnVCXeY6/tWOw6CES3eq2u
	XaglqkbAkYMbJmR+irwcxwkioOr/BHCUKMOdzu/1P++TVVnAxeCyPj1KCIcEUvOklLSHAycXiGW
	5M2smDSzYoaCbtPfzRvKGtbormos+ATTuKIDG44z178fZa2LbKPl7zG/XlEhX8jmvBmX1LnAumk
	gUsGrwIbCpQL2keM2fbdvFx71x+Va6+xwMbdMrKKxzJSA6xTAK6IiJgWP5zs/o2ACvHTstaD/OK
	/LbJys1HLfOiBn1d9vHSJe+cU6t3PNZR4QLqKIfa+0Yge344GLZ6qNCnSh5R16c8DHGFa18LFRd
	zVgUsw5ZG/6NDe2MRna2hA7OGs=
X-Received: by 2002:a05:622a:648:b0:50d:83de:4933 with SMTP id d75a77b69052e-5162fe535a8mr38586951cf.20.1778680776482;
        Wed, 13 May 2026 06:59:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5149f5a6484sm123985141cf.1.2026.05.13.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:59:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: fix getopt flags
Date: Wed, 13 May 2026 09:59:08 -0400
Message-ID: <20260513135908.37763-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-k, -v, and -C do NOT accept an argument, and the optstring
was not correct.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index a48c8803..0dfc5cb2 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -776,10 +776,10 @@ int main(int argc, char **argv) {
 		{"homedir", 1, 0, 'h'},
 		{"tmpdir", 1, 0, 't'},
 		{"runuserdir", 1, 0, 'r'},
-		{"kill", 1, 0, 'k'},
-		{"verbose", 1, 0, 'v'},
+		{"kill", 0, 0, 'k'},
+		{"verbose", 0, 0, 'v'},
 		{"context", 1, 0, 'Z'},
-		{"capabilities", 1, 0, 'C'},
+		{"capabilities", 0, 0, 'C'},
 		{"wayland", 1, 0, 'W'},
 		{"pipewire", 1, 0, 'P'},
 		{NULL, 0, 0, 0}
@@ -811,7 +811,7 @@ int main(int argc, char **argv) {
 	}
 
 	while (1) {
-		clflag = getopt_long(argc, argv, "Ccvh:r:t:W:Z:", long_options, NULL);
+		clflag = getopt_long(argc, argv, "Ckvh:r:t:W:P:Z:", long_options, NULL);
 		if (clflag == -1)
 			break;
 
-- 
2.53.0

