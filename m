Received: from mail.asenkron.net (mail.asenkron.net [187.77.111.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F0372B3B
	for <selinux@vger.kernel.org>; Sat,  9 May 2026 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=187.77.111.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778352158; cv=none; b=ruzf0gvONFqDS/bbuZL3C5lTfQrwvITsD+yGyB2ylkc50rLnSpuDB8gDz/5EFzaY/MxoJTVVruYUtA3CWpGzzA1tXF/q/i+UHCqrc+t338Fm4RUYxjew4DD4lPJtSFZ7ZuykISAaxLAgXGCmjZuiYcxexhQzLDQVO/aykPh5W/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778352158; c=relaxed/simple;
	bh=wwX88cX6cZHDSSS6Rg9RqE2RlMFISI/Jhy6AMOnSG/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdSczw1lTdFW4UeMWL0aAm/0lZtmyTFdLhldW5Qyk32NXPp6bs9idJYzxYkpIEWNdbKzsORHpk9gK/gzk/nXMoBNhWfEqWBdMK+zJQnLfl0Wy0OBBc74T9PkEOWnH1GztoEjROBCfotg0DUtNGuN1sl+Vpz5nykI8tyQi54b/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mecesoft.com; spf=none smtp.mailfrom=mecesoft.com; dkim=pass (2048-bit key) header.d=mecesoft.com header.i=@mecesoft.com header.b=Mx25qRMZ; arc=none smtp.client-ip=187.77.111.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mecesoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mecesoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mecesoft.com header.i=@mecesoft.com header.b="Mx25qRMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mecesoft.com;
	s=202602; t=1778351633;
	bh=wwX88cX6cZHDSSS6Rg9RqE2RlMFISI/Jhy6AMOnSG/M=;
	h=From:To:Cc:Subject:Date:From;
	b=Mx25qRMZ7/H+Om5q5HmDz4/TBluuinqtgATTP5BpUONIwBYjlz0bH9F2eu6X+ZPgI
	 0364A/dyr8ExDRECpulUp29+mbG+vilyUGcES3uWoUM4C9UxUJw5VC/tXj8XTKjq32
	 2a6t+aWPQ/3ZUHOzoMuC4x8EInmUW+wgKgsKZWKlvH9R4SDG/qzvYaPpZbrDoU97+y
	 Y38gXxHPG5ST8t8aMHHRKVTPDpU/94IKF/7sNya7UxO23dDcceXxBkSukOabDf8d/9
	 Ts3H4C3j7EUpo5esmqErd7c4TduQDaI2kfVPhO2HZTwIzzYOSRcWWYA8cmwcEHnOYn
	 ehrjc9Oa8MnwQ==
Received: from 69a92467efc5 (unknown [78.172.218.147])
	by mail.asenkron.net (Postfix) with ESMTPSA id 0B11A84305;
	Sat,  9 May 2026 18:33:52 +0000 (UTC)
From: Mustafa <muhammustafa@mecesoft.com>
To: selinux@vger.kernel.org
Cc: Mustafa <muhammustafa@mecesoft.com>
Subject: [PATCH] semodule_package: fix wrong variable in error message
Date: Sat,  9 May 2026 21:32:44 +0300
Message-ID: <20260509183244.10658-1-muhammustafa@mecesoft.com>
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

