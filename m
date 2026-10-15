Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5625328B8
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077269; cv=none; b=c3y4sGfByLOxLO4AGmJ3tGSPZ0NcqT7HPfoCyxxYfD4WB0hrCAbXLpymLn6URMnB7eP0BJTvYytI4crUZjd8nvINnpAaS6nTeOoQclOH/A7mAvD3GhzURNsOodJpR5jH4BuQUohfksUw78wXxw0WlPYqsEeTloS3UxWMYRD3ex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077269; c=relaxed/simple;
	bh=FFVZQXsYGsAbeIVeWbBrZcT220xVFlFESl/a5lhGDQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPi/SVubQFuVuNkyAhDYGCAl2wLcbiUmVb2cEBiL1ZqkAbqPSlLllbIFLYBza/NSfdf7CHUv3VJyHijHvHLLsQ+9pXKrLJEAjbgoVuWzrCU/omA0NeXttREWKYOezVoVCgpeaoDX6kygLwZX5BWd1173fctPDU3p8RlovIGPQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ReRmAwo/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S1F+z0r8; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ReRmAwo/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S1F+z0r8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E6371D00112
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 11:14:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 11:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792077267; x=
	1792163667; bh=hVxe1qNiS4mGSz9mFrQbdC+o1fCoX3ggyodaaTdtVFk=; b=R
	eRmAwo/ctsyLtYXy43I78qinxyUJ+46jSRoHiU7NuNOd6fJR3hj5t7c19WccIuxb
	tgUeKmUlIeuoHE8TOZwfZ0as3Vh9pQhtzHqKkvpOWnqzZeJ9zUwo90VPhQ0ZMatx
	fcDwhD84q0k3Kjc9ZOpAfuDPZ0FOI6QTajUtp7AnzkeINQ4MzIQ2Xmp7AjMaLu0S
	EmWI7DBXizeonUOBxwlwElRYyIOAKmhZf5w7SJhBiAKljDYn/Eja7d/sThMZq+xR
	k/079ebGamA9MAdT4ktpNAPhJtJvPTjbUbjzFYRrjXXaP7ceMMPOmys3wUY3zysJ
	KbSKb8f70yTkwdUHX900w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792077267; x=1792163667; bh=hVxe1qNiS4mGSz9mFrQbdC+o1fCo
	X3ggyodaaTdtVFk=; b=S1F+z0r8077/3mWObOw4j0OOYf9XBx8oDURYqMn/tRPQ
	+YgxsMqY63R6yypWb9jDTdI6rumUNs4I9ThJBUxiv9nufGBBvqmIymatd68x/UX1
	t0S4BAANEP8z9D7VaYCxTenFV/Dz5c0ysSFGtlklCKLz8Q5WEA070qvGmCH5RcvA
	QSvQVs05rX8NmHvOdvSy1Qg5YYrZWwOYgnLxnY3xEDaTKRXru3m67xaNeYpYR8bG
	F/BsN5sArBZ8UA1rx211yG404e9vnk2l+qE4y1P/wblDQ9rIdud3PoDlvhod9UR7
	2jNw5FEiNUO1RK6JQq9OX3nfl843zJPwlrRzKYzN/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792077267; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+;
	rt=PHNlbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:nopH+1YgDyDX5wEWz3mfWpjCNK9Y6c7ygU+kqKQ128bPE+v
	8ea4dUVfvGJDG6ae9ujP2FMOee60ixjAev4lBsdjFjNCFRDo0L/HV1dsZKbjrNs7
	ucX4jEY9iYp4bAO+HJtKFe7QwRXZ44Zh9hOlq/qMJh2pr5vZ7a0XFlFMwichF+Am
	I6OjaPAFyxT8XISLhDqASCp94clKDM12oZzouz2mLPGKCG79LmLpzjZfKFljkQqq
	tDNJN2/IDdNKbVxvTXWFcW3gllqCkpDG9UdYBBDHUYRk7Yc9b+GRe4xhXYP1zfdA
	9fPATntkjRnCVRl30mZinMaZyOP0yekwzqM+Lwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SPcsjQzVKPr/fR45fiXixvl6F+I1C60cBEDoaCTXKcA=:FFVZQXsYGsAbeIVeWbBrZcT220xVFlFESl/a5lhGDQQ=;
X-ME-Sender: <xms:0-3Qah54xezN_glZWrnFRHB5g5Xc0vDe0oGZJ3ms9MbVvxKHZxfiyg>
    <xme:0-3Qal0tR6As-hMQvmkQt81xoriY8y5h2TTw-fR5e1zpZSj_HoZWDGFjD4Rlc9N4y
    yMP4FG4ONoyxD0d_ruAOeCHLLUf42DQfr3HraYGDUbe3dnJftcWedk>
X-ME-Received: <xmr:0-3QauFJ7iSXRatlCXJzLjHKHNnQFYXxj9qbNkJZel0MiyOZJLj4scArQFEreKXezW_5ql3GPOMBdfKJKUevzDzPL0zUS7cl6YvJQB-6Yo43rm9SX9d9Rlu9CoBppPniqcncZv7RyHu_U2Ss>
X-ME-Proxy-Cause: dmFkZTGvzYVLZxzBED0c/WpDmVurWCaMM6ep2gLBg1hhNFZvr6fTbGhlnNWkPSFsU+PAda
    ufZ7IroiJh01v82kzwapurO3ZXqAIJ10Hfi3EQ6+2MPyD9QM6pbYp/y0UUC49PSDTVi76/
    C1b6XKXcpf3UKKowKmlcp9skOXwi15Sy9CWplUq73Uqb1vDYsprRXjdgcqphhH5EfuV/2y
    T0GmRVHkrqu70dGKxBeUzc1XeSr1SMHIlVyYv5shaQSqx9ORInpy1rU0ksHB8g1aTz+3JM
    I7pXTe5afxOqq5q8xAhc+d3kuN6uJYGySEr5ap+/or0HHKH7GhUiVtR4cwcXs7C2YNrFLt
    FKCOYGIZgeDlEh+UskPqrYFRoCs/31UD/B9oCsX8lBawdDoZ7UB89fqU3W1b1rEbnGdbkt
    scE/Vri+3YJSpFuSaYPo4/17daGCPVDViXfLsRZodNOo/fGfiqoY1XvKsv5FFVRlhn3Ty/
    lkgMZy1HA6pXQo7hXtPbjG5SuMBtenJBNOPdkfTgky/ogokZvImj/EkFB01XuYZ0FcQlEG
    hYE8eyt2P22SUOKtE8YWD7EHmsNW8zEkmndve9JR9ojIJWmm9K9+bUsVugKqtQuN6T16yy
    q5fr7Yrs237ewF2LO80WgjUsOCvudq9gS8+7eVXFUtSqUkoknBPH50NPEUmQ
X-ME-Proxy: <xmx:0-3QavQbt3EVG4Ghph46umcHCvTNGFZWoCzBrsGTaWSBejPqWDJ9EA>
    <xmx:0-3QalAUKewLHJh2NS_1tV-4rbVcgEN-RGiM56qWh5-ZvMxWkK7Ppg>
    <xmx:0-3Qav1yKFGKcFN1o56xce6Gt6WBieKb4_P2AyGZJmKH-mzHbb0vSQ>
    <xmx:0-3QajVNw1sc8NuEZ-rAQNeCrv2IdiHbNMGzmBAuFUmwrOIw06bAiw>
    <xmx:0-3QamZQOtoN8dss2wGqIi5S2nK_UNDwmSor85XrLCAzo8s8RkQ_KCwF>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <selinux@vger.kernel.org>; Thu, 15 Oct 2026 11:14:26 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2 3/3] libselinux: add -V option to sefcontext_compile.8
Date: Thu, 15 Oct 2026 11:14:20 -0400
Message-ID: <20261015151422.1057210-4-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015014457.877322-1-tmz@pobox.com>
References: <20261015014457.877322-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -V option was added in 92306daf (libselinux: rework selabel_file(5)
database, 2024-11-05), but the man page was not updated accordingly.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 libselinux/man/man8/sefcontext_compile.8 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/man8/sefcontext_compile.8
index d5ad3f62..8649d04f 100644
--- a/libselinux/man/man8/sefcontext_compile.8
+++ b/libselinux/man/man8/sefcontext_compile.8
@@ -6,6 +6,7 @@ sefcontext_compile \- compile file context regular expression files
 .B sefcontext_compile
 .RB [ \-r ]
 .RB [ \-i ]
+.RB [ \-V ]
 .RB [ \-o
 .IR outputfile ]
 .RB [ \-p
@@ -61,6 +62,9 @@ architecture identifier.  Arch identifier format (PCRE2):
 .br
 .in
 e.g., "8-8-el" for x86_64.
+.TP
+.B \-V
+Print binary output format version and exit.
 
 .SH "RETURN VALUE"
 On error -1 is returned.  On success 0 is returned.
-- 
2.56.0

