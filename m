Received: from mail.asenkron.net (mail.asenkron.net [187.77.111.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D966331214
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=187.77.111.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775040; cv=none; b=hWqM0Afhx+Q91xsHcGmHv+4oRMextR0KH4wa8Cb9F1ECdEXg6Mdsc3KEMiWkIhgOx/35/PgFNDYamaJmwR3Wrh5z3OvF6ZaRwUK+h00Zr/AJzu2PJSoK0E1LWdDkVtv/rUbmAWGdvSgg9f31fn2DI9xfGWzytooLPghREv2MKsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775040; c=relaxed/simple;
	bh=mCEtJBhwzFPOLR8Dq5LTJ6zSY26yQ3Wn+y4FcKrdHmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6ypksC4cXI9ZLU7g+VpPuDEAh/qFcMZK3baH1rBDHD1gDH+Tc1BEJ0R4LdtbVAWk6nol5dpK/CC/eRCifn20Iy68QDUg6vQCRtq0pUuISJInQAeicCm8NS3ydSCtxu9EuGZVitLTjuf2LnQJdgthfFsCFfvIovU4LahNL/KMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mecesoft.com; spf=none smtp.mailfrom=mecesoft.com; dkim=pass (2048-bit key) header.d=mecesoft.com header.i=@mecesoft.com header.b=E8CwPIUE; arc=none smtp.client-ip=187.77.111.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mecesoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mecesoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mecesoft.com header.i=@mecesoft.com header.b="E8CwPIUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mecesoft.com;
	s=202602; t=1778775029;
	bh=mCEtJBhwzFPOLR8Dq5LTJ6zSY26yQ3Wn+y4FcKrdHmk=;
	h=From:To:Cc:Subject:Date:From;
	b=E8CwPIUEcL4GzI6qKk2BoIRtnoGU7AlWKCMKJgsXiaJT7cH6dZM/Rhg2GkLbvXCn4
	 nXhNGl5I4fxVstA+770sVHyC90a9MnhMPWXeZeJO055QaN48DEqTqHlIPcT+Wm+2iS
	 a4xbIX/iUCybXsi5cFTdnoLCJ9JAYFdONktAdJk6Lz1VUeyoq2BH7hc+THaOcBYgHS
	 gnu8/jA1b3wUU7v5WnOcm+X49hLkfF3XGLCtKmV5jSx4463C8WSnlHkYRXRdSNVjqd
	 BItfcObMX7OZzJTaL1/BKdGnwnNA25KQMFDwVrVub/jtWxiTxOH3Z/aaWW9bLAa+vK
	 DidzjtULIVl9A==
Received: from 34f84639efcf (unknown [78.172.218.147])
	by mail.asenkron.net (Postfix) with ESMTPSA id 1471384315;
	Thu, 14 May 2026 16:10:28 +0000 (UTC)
From: Mustafa <muhammustafa@mecesoft.com>
To: selinux@vger.kernel.org
Cc: Mustafa <muhammustafa@mecesoft.com>
Subject: [PATCH v2] semodule_package: fix wrong variable in error message
Date: Thu, 14 May 2026 19:09:43 +0300
Message-ID: <20260514160943.5332-1-muhammustafa@mecesoft.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'outfile' instead of 'argv[1]' in the error message for
sepol_module_package_write() failure. argv[1] does not reliably
reflect the output filename since argument order is not fixed.

Signed-off-by: Mustafa <muhammustafa@mecesoft.com>
---
 semodule-utils/semodule_package/semodule_package.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semodule-utils/semodule_package/semodule_package.c b/semodule-utils/semodule_package/semodule_package.c
index 4cb6f5a3..b81b7e42 100644
--- a/semodule-utils/semodule_package/semodule_package.c
+++ b/semodule-utils/semodule_package/semodule_package.c
@@ -266,7 +266,7 @@ int main(int argc, char **argv)
 	if (sepol_module_package_write(pkg, out)) {
 		fprintf(stderr,
 			"%s:  Error while writing module package to %s\n",
-			argv[0], argv[1]);
+			argv[0], outfile);
 		goto failure;
 	}
 
-- 
2.53.0

