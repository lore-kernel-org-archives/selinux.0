Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6551370D5F
	for <selinux@vger.kernel.org>; Mon, 13 Apr 2026 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102067; cv=none; b=bULUDfM+gFujCrF1vaYxZED+KMYuEfB6QL9Max1dD69AEpZOj3UJKKgoe+Zm+9b/94E03dYy72S8TbcTfwTGybh4BtmNslILgGNvfvFTgahnJl7KbNO8lf9mxUmTWJqX2SzpKkFiRmBaTnpuqAtEOT16XVDpbXy9vLM7hvZrXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102067; c=relaxed/simple;
	bh=4aKmKfcuMpta8XRtmOL2wsnSrbhmOGktEMvuR9m6f2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTGvSV7ZGXx7QL+U/zcaOv7d7zq7qHme7ePZAfC33hG/AqkmsK2+7y6agKWlfMqo3pDHlQ1bndzkp7J7tqG0mGWKIjx6XlyJMUiaIWXwB7I9ntFquLLwnXvVI1sTn21EfEPEVvv/KxPXYPJpEwNP3v5Q8i+o+S7Z2slvWL/V3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=lXRH9h6e; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="lXRH9h6e"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D75B1240027
	for <selinux@vger.kernel.org>; Mon, 13 Apr 2026 19:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1776102056; bh=MZJB1A369CkUgDfmc6ug+vbD8uwQJITAS6AhGEwvaWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=lXRH9h6e4rCqJHILyGsMcr478DbsWBIWXwrbL2UCJ1ft0YZ4ubrA5674wF6yeGs2t
	 qfUeKwWdQjJuKSTtEhGJc++ow0OcJh+T7LwzItL830Nej1n7u83YZHZetCjFH4id0a
	 Hq7nu60cMmnCAHTmHCsnTHOBM96wUJSQBgNowbs8J/hDJj41U/xOhFO1oeFnLByx93
	 LBKgK39os3vvrAUw5I5UKOyTP2EQkbrkX/AxN7kuY2Fo0dKjB668Vs4Rb05fEJEe5b
	 gs2VAmKFZbH8pi1t+uUTXbMZ0ZN1mdVONbBs7VnUpB4o8EW/HWMaVopnOIHW9PaiI/
	 RQQlUiMd+MwqQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fvZSm16ZJz6tvs;
	Mon, 13 Apr 2026 19:40:55 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@posteo.uk>
Subject: [PATCH] cil_reference_guide: update specification for valid symbols
Date: Mon, 13 Apr 2026 17:40:56 +0000
Message-ID: <20260413174043.3733803-2-nvraxn@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2871; i=nvraxn@posteo.uk; h=from:subject; bh=4aKmKfcuMpta8XRtmOL2wsnSrbhmOGktEMvuR9m6f2c=; b=owGbwMvMwCmc0Xus8aefgg/jabUkhsy7WrON8123J8cua5ric+6IqJ6mpIpYk9QDbX/bF2s3O 8d9UvrSsZGFQZiTwVJMkWX/PrYbJU/n/j765HUHzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn CGToGDFwcQrAVL/qYWzoY3gXcKB087II0wyJvAdcWlNOfo3h/BDFsVpxajOj+ye3O1XWUiYq/Z0 G3TVvub4opTM2/M0VePn9rMSn+htvP3Cn24ZohirdYzAxz1D9aCsVs6360ePTpx77bbmsc+bq5F mzS4WPAwA=
X-Developer-Key: i=nvraxn@posteo.uk; a=openpgp; fpr=BFBE06D874E59DFBC5E4EB88688DC681F94E204C
Content-Transfer-Encoding: 8bit

Currently, the specification has a very limited character set of valid
symbols. This does not reflect was libsepol (and by extension secilc as
well) accepts, as can be seen both in spec_char's definition[1], which
symbol is comprised of along with digit and alpha, and with some basic
demonstration (note cil-policy.cil refers to the example CIL minimum
viable policy provided by the SELinux notebook[2] such that the example
is not polluted with SID declarations, policy caps, and other fluff):

  carbon ~ # cat <<'EOF' >mytest.cil
  (filecon /[].@=/*-_$%+-!|&^:~`#{}'<>?, any ())
  EOF
  carbon ~ # secilc mytest.cil cil-policy.cil
  carbon ~ # echo $?
  0

As can be seen above, secilc is perfectly happy to accept a variety of
characters which are not valid in the specification. Whilst the above
example does NOT use valid filecon regex, which libsemanage will later
complain about, that does not matter for the purpose of demonstration:
a symbol pertains ONLY to what is valid in the language grammar as an
unquoted string, not what is valid for the filecon statement.

It should be noted as well that this patch drops the backslash symbol,
'\'. The libsepol definition of spec_char omits it and this can also be
seen in practice:

  carbon ~ # cat <<'EOF' >mytest.cil
  (filecon /\. any ())
  EOF
  carbon ~ # secilc mytest.cil cil-policy.cil
  Invalid token '\' at line 1 of mytest.cil
  Failure adding mytest.cil

As such, no consumers should be impacted by its removal from the spec.
It also does not seem like a grave omission, so it's probably best to
just drop it from the spec.

[1] https://github.com/SELinuxProject/selinux/blob/6be1ec3792c11040fd7a3ecb1135e54418eb0d57/libsepol/cil/src/cil_lexer.l#L48
[2] https://github.com/SELinuxProject/selinux-notebook/blob/9888b84b8e76c18c6141812d7ffd9b3e2fad6f9e/src/notebook-examples/cil-policy/cil-policy.cil

Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
---
 secilc/docs/cil_reference_guide.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_reference_guide.md
index bcd34b68..af883232 100644
--- a/secilc/docs/cil_reference_guide.md
+++ b/secilc/docs/cil_reference_guide.md
@@ -93,7 +93,7 @@ Definitions may be repeated many times throughout the policy. Duplicates will re
 Symbol Character Set
 --------------------
 
-Symbols (any string not enclosed in double quotes) must only contain alphanumeric `[a-z A-Z] [0-9]` characters plus the following special characters: `\.=/-_$%@+!|&^:`
+Symbols (any string not enclosed in double quotes) must only contain alphanumeric `[a-z A-Z] [0-9]` characters plus the following special characters: `` [].@=/*-_$%+-!|&^:~`#{}'<>?, ``
 
 However symbols are checked for any specific character set limitations, for example:
 
-- 
2.53.0

