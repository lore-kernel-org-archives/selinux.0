Received: from mail.spsk4.lublin.pl (mail.spsk4.lublin.pl [94.230.25.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C513C9AF
	for <selinux@vger.kernel.org>; Fri, 29 Mar 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.230.25.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750580; cv=none; b=O/xnu8me4AvtQMk7+k6FPtlxZqJCm+qjEUFbelPofrM5BTRaOIXA7GHm16qOA8neqXdLdj+KcaN/MLTqCMmtfu6zv2kuYU/xqgWXjm/gXnOxXuoWy5LinlYtC2m73HWQRMeMdr1nA24p14t83DwQ3aEnRCfIFKQj0xkmd2i1M0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750580; c=relaxed/simple;
	bh=q4rTwUPJuDETNQyVcOOIdY1HrVloy8b4sJypBic8xRo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XHo/uNls+FPnFk+gkvbQQge3CvPHl6TLDW0c3ltQiwYmnEt/S1KkV/IQc6KRpP3jOdilwi0P1Fc6XVFU938RuZJw6tWCfQ9UKmOhL9foW3QDfEtEqcILVtJ0OsNiZkYMOm/5jX/z2+noW5k5giqCWTgdKYi58lvxwW2s31qKLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spsk4.lublin.pl; spf=pass smtp.mailfrom=spsk4.lublin.pl; dkim=pass (2048-bit key) header.d=spsk4.lublin.pl header.i=@spsk4.lublin.pl header.b=ezj8aGTx; arc=none smtp.client-ip=94.230.25.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spsk4.lublin.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spsk4.lublin.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spsk4.lublin.pl header.i=@spsk4.lublin.pl header.b="ezj8aGTx"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.spsk4.lublin.pl (Postfix) with ESMTP id AF0A122A4D
	for <selinux@vger.kernel.org>; Fri, 29 Mar 2024 23:09:53 +0100 (CET)
Received: from mail.spsk4.lublin.pl ([127.0.0.1])
	by localhost (zimbra-mta.spsk4.lublin.pl [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9ppUJnt9tvSV for <selinux@vger.kernel.org>;
	Fri, 29 Mar 2024 23:09:53 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.spsk4.lublin.pl (Postfix) with ESMTP id 88B3A22ACE
	for <selinux@vger.kernel.org>; Fri, 29 Mar 2024 23:09:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.spsk4.lublin.pl 88B3A22ACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spsk4.lublin.pl;
	s=0B6D5DC2-FF57-11EB-9505-2F96557CE46E; t=1711750193;
	bh=q4rTwUPJuDETNQyVcOOIdY1HrVloy8b4sJypBic8xRo=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=ezj8aGTxvaOTokILTtpInvSOif+4pszCRZWE+ETL48fW6HaKT10OZvGStBpBEz4Sm
	 LH6j/p1YMpJpQe0sGsn+dV2qquH/YL/llhwxnHhwCZWlEsEgyvxeKEZgqhsKauzvk/
	 4UbXFb7am9Kt/VhVf8KOYGBjNyiis/UXgE0grWR+3nJ/Np3nQ7YleTyqme7w9HD+/A
	 QPDhVhIxISqP/itMxi0r0ELmg5WRKAWMKg6Si8693P3sl6irgwldrBG7lLhj93gQs/
	 2BYscF4pORKZMWh9qQCC+j6caUAfe+pbd/E3JYgzlDAlh7kSUIqDV4Gck+0f4HsiAw
	 hgql/wz3BHXOQ==
X-Virus-Scanned: amavisd-new at 
Received: from mail.spsk4.lublin.pl ([127.0.0.1])
	by localhost (zimbra-mta.spsk4.lublin.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SqFwYqDvNRDX for <selinux@vger.kernel.org>;
	Fri, 29 Mar 2024 23:09:53 +0100 (CET)
Received: from spsk4.lublin.pl (unknown [176.10.248.205])
	by mail.spsk4.lublin.pl (Postfix) with ESMTPSA id AB3F722A4D
	for <selinux@vger.kernel.org>; Fri, 29 Mar 2024 23:09:52 +0100 (CET)
Reply-To: recruitment@truvista.net
From: "Beckie Varnadore"<oddzial.onkologii@spsk4.lublin.pl>
To: selinux@vger.kernel.org
Subject: Re: Job Offer
Date: 30 Mar 2024 09:08:37 +1100
Message-ID: <20240330090837.A393C356452A8F39@spsk4.lublin.pl>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Truvista is currently hiring for a Data Entry/Excel position that=20
can be done remotely. No prior experience is necessary. The job=20
entails working only three days a week for a minimum of three to=20
four hours a day at your convenience. You can earn $1500 bi-
weekly.

If you're interested in this position, please respond to this=20
email with your full name and cell number or send your CV.

Best regards,

Beckie Varnadore
Human Resources Specialist - TruVista
