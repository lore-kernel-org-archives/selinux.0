Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349D37D13D
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222159; cv=none; b=qEdgNqAjmv1E83ZiH7N3S6GxluQ34z8AuygFV/N9QLMQbpHPTxl9DWGIiCIiXK3sWZkSBBZAA0h6kYbLgdRVG22GDUrYAIbJnezzLaEVDKrewe9IV2xoa5U/22jjgf6+6ofL8UtMGNeZdXVInYovBydssIK6asVG7Uxa9Fc8hus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222159; c=relaxed/simple;
	bh=Blu5gmMmUv3BTs3+mItv7yUPWILyNdeoGvo7S0nLdMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGVaFtnz2ON/u3xY4D45JzMVQ5cwvy7unj5KLznLO+hItF4wqjbppyfuBhycTKRf/0X18/VMiU9cSUnveD3pmxEU9YrfNrRYSt6fUZGALsO7Jx8yzXEFEofaRn/PPHCdQcATbNdGBaS99WlrXMXhcqIfXaJXIMLpFrCCBTlCQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WA0aRY07; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WA0aRY07"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222153;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/t6uj07mIuuWeAadCbmRJMoCd+E7V0MeEz2Ih49vLg=;
	b=WA0aRY075BLJ9jaifVuST8O4fR9nu8tUpH7BOihvLEw0w7anbVwdnuWMQJyjIbCWPB24qH
	K/1OoCL7pvdwu9HWcNbxWMx1Cvti0ICSXkiwLNB0xIrLU/AxYqXix9kiUmWUGo3H6EOJNh
	t2vhc6pawFqZDAywqv+FEaIQebN1Qyc8tAr7NOkLz+8rDJFscgVwJZ29eGo+40gujhm7We
	pgmutzlhO01AdQvHAkeSRVrDkQQBGK0XLvUomhmaxjqGst5tSFcwfPvrMJ2JJivA8hVsk7
	MATLIY/X7eSyB0wK8RrnuDWkkAe+1bhRKoUortziLCSe1gFRlOYYMC0cm0jJiw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 21/24] libselinux/audit2why: use public PyUnicode_AsUTF8 and Py_ssize_t list size
Date: Tue, 23 Jun 2026 15:42:10 +0200
Message-ID: <20260623134215.98273-20-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

_PyUnicode_AsString() is a deprecated private CPython alias for the public
PyUnicode_AsUTF8(); switch to the latter.  Also store PyList_Size() in a
Py_ssize_t (and index the list with one) instead of truncating to int.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index cae13f19..2e1a98a9 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -330,7 +330,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 	char *tclassstr;
 	PyObject *listObj;
 	PyObject *strObj;
-	int numlines;
+	Py_ssize_t numlines;
 	struct boolean_t *bools;
 	unsigned int reason;
 	sepol_security_id_t ssid, tsid;
@@ -339,7 +339,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 	struct sepol_av_decision avd;
 	int rc;
 	int nbools;
-	int i = 0;
+	Py_ssize_t i = 0;
 
 	if (!PyArg_ParseTuple(args, "sssO!:audit2why", &scon, &tcon, &tclassstr,
 			      &PyList_Type, &listObj))
@@ -379,7 +379,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 		strObj = PyList_GetItem(listObj, i); /* Can't fail */
 
 		/* make it a string */
-		permstr = _PyUnicode_AsString(strObj);
+		permstr = PyUnicode_AsUTF8(strObj);
 		if (!permstr)
 			/* not a string; exception already set */
 			return NULL;
-- 
2.53.0

