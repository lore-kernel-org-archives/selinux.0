Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310189;
	b=JbVkFiHnyJk6dXugHMp7HvImVCpTYuaKCIc7HZxt6RDfFYj+ZSP8hEUt+oVbniGwmojz
	 OwrXqnTB/NLPlef7/26J0sAd1oMzL8Qf5GL8Xzocq4Kbm8HDJJcuyZgDHLy6STUHcB4Ji
	 z+IlKl47nQbFB5MDYoxu6YDU0G5i39gQprAYR+81YLjFcR0ufdfUHBgDRA3KsMu5ybu57
	 HyfGFFJT5VFJQx9rIDHd2wI14yLRYSEgn0Ro1fJQXcc68rI1DTbgFNrO8bRR5EpK2ju1r
	 xtZoahINkW/q81kE4qdWQDbPutKz0xG2Gv9BeYK+CNukktTZFRvkFDkz+IEBhKF7fvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310189;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xzO5GS7NPAGFMWWDILQyYg9dp9p89pFawt+I0DDrk9w=;
	b=j64WhZsppmfAJZl783/TfT6QuQMhJHtFetR+mB0tZbaQUkO8LLRek5yJp7KAoqhkq2Tv
	 JhSGKPemLl8hL7EszMjyHNuBScl+QF1Akr+MQ6jSO4PJn/ezyhe/163UoYzqVoK26c0N+
	 UpRQRNsOsVkihMyW4WywgUOhjhJBbiXIOYHoQuQ0OSIC0iOhBJyv4CYIpbS+IwFBjrgTo
	 KZNHtl0V+AC6DxqgCmjClTUD7fZEikaRku2Dadm8C0v5UZiPVqSQ7RvjdmHWfaeqktzxq
	 gl89TgivJQtlRhUdtXMgjyjuvHt2H4FLVeyDtmj0fCfaRjt/GYqNFkwCKT3OiYcbFJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=SnvFq7B0;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE5606A326
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFBE5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=SnvFq7B0
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794310187;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzO5GS7NPAGFMWWDILQyYg9dp9p89pFawt+I0DDrk9w=;
	b=SnvFq7B0sDl6TSfc9gAamrjbZc84pYkTk6bedOe61xnzp0nRGZQBWlJPKBY5u63RaxzLAe
	u9WXJ+NcJmtDLAbFxCNRtJ9feKO/YMXk2/QwdCYz89c1E6Im+KOHpBXrB373hlstn8kwpW
	+Wm/PIj3JXHOCzf1Ts6dymtB8CEXibdxZafmziCwgx36cIeNXH+BSzb1Wed4EXqgvpMRMj
	vv/Gl1CdtKRre3HOvQbzl/vM7ZW8QkDlklI2j9HnmA8vQehNSPko+J2Vc8ZVw/YEAd6ZO3
	eEg3CHGq/nR41elXKeZ+CxhlgQ5/zn4hKPMQXZV69HLaTQnARHe8y/WBxm2TtQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 5/8] libselinux/man: document seuser matching precedence
Date: Tue, 10 Nov 2026 12:29:27 +0100
Message-ID: <20261110112931.99557-4-cgoettsche@seltendoof.de>
In-Reply-To: <20261110112931.99557-1-cgoettsche@seltendoof.de>
References: <20261110112931.99557-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Describe in getseuserbyname(3) the order in which seusers entries are
matched (exact user, then group, then __default__) and the fallback to
the Linux username, which is disabled by REQUIRESEUSERS. Point
seusers(5) to it.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/getseuserbyname.3 | 33 ++++++++++++++++++++++++++-
 libselinux/man/man5/seusers.5         |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/libselinux/man/man3/getseuserbyname.3 b/libselinux/man/man3/getseuserbyname.3
index c0515dd9..92d305d0 100644
--- a/libselinux/man/man3/getseuserbyname.3
+++ b/libselinux/man/man3/getseuserbyname.3
@@ -18,6 +18,34 @@ then be passed to other libselinux functions such as
 and
 .BR \%get_default_context_with_level (3).
 
+.BR getseuserbyname ()
+reads the
+.BR seusers (5)
+mapping file and resolves
+.I linuxuser
+using the following order of precedence:
+.IP "1." 4
+an entry whose login name matches
+.I linuxuser
+exactly;
+.IP "2." 4
+otherwise the first matching group entry
+.RI ( %groupname ),
+tried in the order the entries appear in the file, for a group of which
+.I linuxuser
+is a member;
+.IP "3." 4
+otherwise the
+.B __default__
+entry, if one is present.
+.PP
+If none of these match, the Linux username is used directly as the SELinux user
+with no level.  This fallback is disabled when
+.B REQUIRESEUSERS=1
+is set in the SELinux configuration file (see
+.BR selinux_config (5)),
+in which case the lookup fails instead.
+
 The returned SELinux username and level should be freed by the caller
 using free.
 
@@ -45,4 +73,7 @@ The errors documented for the
 system call are also applicable here.
 .
 .SH "SEE ALSO"
-.BR selinux "(8)"
+.BR selinux (8),
+.BR seusers (5),
+.BR service_seusers (5),
+.BR selinux_config (5)
diff --git a/libselinux/man/man5/seusers.5 b/libselinux/man/man5/seusers.5
index 7fb341ca..049be6ea 100644
--- a/libselinux/man/man5/seusers.5
+++ b/libselinux/man/man5/seusers.5
@@ -16,6 +16,7 @@ will return the active policy path to this file. The default SELinux users mappi
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
 .sp
 .BR getseuserbyname "(3) reads this file to map a GNU/Linux user or group to an SELinux user. "
+See that page for the order in which entries are matched.
 .
 .SH "FILE FORMAT"
 Each line of the
-- 
2.55.0

