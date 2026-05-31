Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724D14A62B
	for <selinux@vger.kernel.org>; Sun, 31 May 2026 05:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206357; cv=none; b=Px9Afr4KSpGg2W05Pw4WBL5Q992GCXQ2lBaeoD5sGAvZ7UJRNPCdbVYBqXgXPi8fBjqf3Gzl2epZIlluKKTv13zl571/gjJpw5QRgdU/0tcVVEt1NC/cdX8/bmcNXb0/4oAsS5MHL9XOY+eFNe/6A0G2MfFDi4HDooQQ3DIQvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206357; c=relaxed/simple;
	bh=5wqv2SCVv4NZ9kDsPToEbKadwXsmJTXOFlNTrPhstNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdN5Xyw+gCABOXo/v1jwRLRqCirmgu5Q+hJxIkOXPjtA1mll6+srJf/bviMO7n9K/HwlOLGsDfW5darowGWy/TQqL1HwxDYWVSpN3jImB1QMUSx++1/xRUb23+1EWBlH6tPRAcBlertxV22oCVpA5gW+Obcku7UIM3ob2+FSZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=cpv2jbR3; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="cpv2jbR3"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 771C1240103
	for <selinux@vger.kernel.org>; Sun, 31 May 2026 07:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1780206345; bh=2xQdoCIzH0kO8ET2w/k/T78cubl4I0m4JayrKnrYFUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=cpv2jbR3Rve/Mu7TajkVZl/05hl2CwsKOPC+GustrXj9S9ehY8zrXtOPCU7bIw/ZW
	 y+FAnrITNQ6kybKKhWUPA3L8i6BWjbDP5CdrJxbd2OXLjQZe8stxyZtOCHuWo3O8Lo
	 X//uWdTYSOm37528NVllW5jnYlHnc6VNlYDx6aecURlghSUPq26Jr/dHG901w5EvR2
	 9guvNEh5iqMgpPglo0Wvbok65oVANDT+dZW+WvPgJ4756OuWVteVS8USFlGK6Bkw8j
	 LLEmgp9Auc4FXhaoIf1Fq4pJwhyiHrhYgLbhm4dbBd5db+JL9Mg+vwIHh6LtXTH5yA
	 DVU+XGEZpwcGw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gSmKN6pB9z9rxD;
	Sun, 31 May 2026 07:45:44 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	Rahul Sandhu <nvraxn@posteo.uk>
Subject: [PATCH] libsepol: cil_policy: check at least one perm exists in a classperm
Date: Sun, 31 May 2026 05:45:45 +0000
Message-ID: <20260531054519.650723-2-nvraxn@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=nvraxn@posteo.uk; h=from:subject; bh=5wqv2SCVv4NZ9kDsPToEbKadwXsmJTXOFlNTrPhstNU=; b=owGbwMvMwCmc0Xus8aefgg/jabUkhizpU+9XzFb3OBDB8+jDTcd8Q0GdzF2BL65vVTD6b3zx0 7IdV7Yu79jIwiDMyWAppsiyfx/bjZKnc38fffK6A2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU MwQydIwYuDgFYKpvz2Gs097rvpClxfPTmoilgYHh1sW8V9duj/Lfvt38dTXX3+DibX9KWetuKbS 25b/58fTwU9FUxvpoj/B25YrJVw7f8Fov8m7jNcYMy/wdFbO2FlyMiG8PiLk5r/i+v8sBBoEFb5 5FzC+/xgIA
X-Developer-Key: i=nvraxn@posteo.uk; a=openpgp; fpr=BFBE06D874E59DFBC5E4EB88688DC681F94E204C
Content-Transfer-Encoding: 8bit

Kernel policy language does not support an empty list of permissions,
{ }. CIL expressions may collapse to nothing, so ensure that we only
emit a permission list if at least one permission exists.

Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
---
 libsepol/cil/src/cil_policy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index ca73bd28..e618ab13 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -653,6 +653,12 @@ static void cil_classperms_to_string(struct cil_classperms *classperms, struct c
 	size_t len = 0;
 	char *new, *curr;
 
+	/* cil classperms are expressions, and hence may collapse to none. As an empty
+	   list of permissions, { }, is not valid in kernel policy language, make sure
+	   we only emit something if at least one permission exists.  */
+	if (cil_list_is_empty(classperms->perms))
+		return;
+
 	len += strlen(DATUM(classperms->class)->fqn) + 1;
 	cil_list_for_each(i1, classperms->perms) {
 		len += strlen(DATUM(i1->data)->fqn) + 1;
-- 
2.54.0

