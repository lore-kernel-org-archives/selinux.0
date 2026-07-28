Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679B2EEE90
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.104.30.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270855; cv=none; b=lr02AK6J11C0Xf7ry//Z5AOXtmphW5dIJ7LSZ6YlT0TP4cZe+j7Pq+sS422a0BmyqV6EOm+dtI1lV20wMyEkaloWFj9NdUvb6HtStBI9o9KzPOstiWoE1v9hCD1Y4kptmJ5pAa5HMmnRCfe+fZAGghSRzVInMSC++HudFtvDG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270855; c=relaxed/simple;
	bh=jNBaGO1/+YVuvmPu5c79lcCC+jX7VscrqKqlTQ1z9BQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VvTPB7K7+eTlq6hTxAfql+mZQED+S6jIQchzGrVUK4edy2Pb2uIgFm5A4ZY20qAU+h4zYceiRgyxTIVSJxWPzWU83lu50K/BBeJG0YDUsKpk5RlD+jxnvmgsb09oN9c/c5iw0d6KSScTourNDN+wz5ccu+lV9cEdPwcQRDP4g1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=m4x.org; spf=pass smtp.mailfrom=bounces.m4x.org; dkim=pass (4096-bit key) header.d=m4x.org header.i=@m4x.org header.b=O/wO2yYk; dkim=pass (4096-bit key) header.d=m4x.org header.i=@m4x.org header.b=NHrwR4nL; arc=none smtp.client-ip=129.104.30.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=m4x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounces.m4x.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=m4x.org header.i=@m4x.org header.b="O/wO2yYk";
	dkim=pass (4096-bit key) header.d=m4x.org header.i=@m4x.org header.b="NHrwR4nL"
Received: from localhost.localdomain (xdsl-188-155-163-252.adslplus.ch [188.155.163.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTPSA id C3A4B1A38B
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 22:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
	t=1785270422; bh=jNBaGO1/+YVuvmPu5c79lcCC+jX7VscrqKqlTQ1z9BQ=;
	h=From:To:Subject:Date:Message-ID:From;
	b=O/wO2yYkukN9xLAIy75RkIFa52dxk4vvknwRabtGOm1UmsRfFdIGscCDsX9DPuEYF
	 4AgKD2TKstbglxm1jKVZjV2Hx8SZzaWP7WY9RoNJGD986l/6MnFImJkF82h/uWYGkf
	 fszRozP0q0++xcCfsjQp9uRVb1FZ+zVjntmge52jYmbDCpLsRSTWRQWLs0AzsbTUGS
	 Z+C/OLs4GWH5E+GsPZPbOTkgEza74LAKCoGdMFWUpOQ0v5/SRUiFNH7Vus1NkXpPMt
	 RAIuiyDIMRvRVphPgEkpYK+/FnvbJfyn7IsOwVUYY5QYwin86Q4gDZ/rlMeyFuD/ZS
	 ut8cCniMqWCCwCHMYj8NKTu6n32GutiIYRgPne84z2ywEwmSx5AB/eMOc4X7d2QWAl
	 AX4f7cqrruLja34nJj6/K7XYiE1mf/WcIADjJRTS/TjKuRDm9gv72MRqgvkAR+PRax
	 Uu+Cptr3t9lA/w4VtzgZ20CX42Xul3Kq5UdFIj8KZolHLNu9aAuqSW/sl7yRvcwj2n
	 gvFMgWe5TOcRcyzWv+mgFrakYlHpY0919eBzjvmRAGwWB1XGiVs1Lj/B6UBVNoy2Sz
	 aXSZBja1eAUk7y7XvVj6/RddwRTa/3UrDnKN+WU2VluIZMzy2pBlkU5DfkY8MjuscU
	 5dV0/jYw/XRa7xDGQzMZsjxw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
	t=1785270421; bh=jNBaGO1/+YVuvmPu5c79lcCC+jX7VscrqKqlTQ1z9BQ=;
	h=From:To:Subject:Date:Message-ID:From;
	b=NHrwR4nLZYqQWqFTYFtJr3bjTIgoKTrJltvwdefIBzCCp1FOaimxeku2frDKHAG3y
	 +ONbH81hYdmH+P3tJONCDo1vJO3qA9tggIx0O4ci4je6Wk7IikbpJ5/0SWhxUQNtez
	 YE7lE2F8qvISp/8KGJHwpti+RFxNKIVD3c8aRTTVtZmvlWR3QRoig2SvIvsSVf6pz7
	 Wo4zF7JEZovrSW38HfFpMiCVWLfRM5RNQXb6MZJ1D0KJb2J/HOoerVMv5RRnKOTUhj
	 96/i9UQD5Pbs7mHIV5TWOi/1yfhUjdGF8qsIaNS8jknShugnwdS3odVJRcPuDQGlGP
	 sdtZMSODcbSNySd9GlMAKYmabr0seDfX+cJWsBwk4rSG7Et6sbpwVkCjVZgHrXw373
	 LeWP0ppUO25LEood3njaRjxHpXMTOsQ5nYFtGv+YJ3k3FCBY0EYskyTB/pw/Bb9JYs
	 c/K99GVUvw7RDaDdI2je4LRPF8JWpbp90zgAHuGzUw9y6/nFADjgQC6QkTLMlrHYsx
	 ccCXXfrsicKCLxRO//Bvi86lRecTjJ4Prh70VRXAuQZ/MJH4GDWL6BHMS0bL7WARCd
	 suFBhexn0GYezvsjhoQUysTWfDISGHFgcrtM85FDd+xA+FGG2cMoeJwJpJ3jXbnp2R
	 XRn2fNi5/Q+1iQnTgKbkfp0w=
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@vger.kernel.org
Subject: [PATCH 1/1] SECURITY.md: Nicolas Iooss is stepping down
Date: Tue, 28 Jul 2026 22:26:32 +0200
Message-ID: <20260728202632.4784-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 28 22:27:01 2026 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.037605, queueID=E6C531A4A2
X-Org-Mail: nicolas.iooss.2010@polytechnique.org

Since I am no longer able to spend much time working on SELinux
userspace tools and libraries, I would like to leave the maintainers
team.

Update the set of people receiving security reports.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 SECURITY.md | 2 --
 1 file changed, 2 deletions(-)

diff --git a/SECURITY.md b/SECURITY.md
index a1d02c4d093a..9ef2e4d9c08c 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -25,8 +25,6 @@ the issue before it is made public, but we will make every effort to address
 the issue as quickly as possible and shorten the disclosure window.
 
 * Petr Lautrbach, plautrba@redhat.com
-* Nicolas Iooss, nicolas.iooss@m4x.org
-  *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5EB
 * Jeffrey Vander Stoep, jeffv@google.com
 * Joshua Brindle, brindle@gmail.com
 * James Carter, jwcart2@gmail.com
-- 
2.48.1

