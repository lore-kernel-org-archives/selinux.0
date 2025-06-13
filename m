Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E587115689A
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829464; cv=none; b=vFd1TSfWzQ51L87feLv4fv5Wpw0txTE+CoqaXDLWSQa78bonONUS9wv65d8MNJx69iBELlCujQc3OhZ7sBm2lYg5oEZyA8YUq0N1jylSQXkseEMtLIpBhFZHzVEtgZoxeVzx7ro+4EwXfbEEtZ38OJ30HNHNUMpvg6RKTx3Tb4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829464; c=relaxed/simple;
	bh=/AeLJdydw/umPqHFx/t5uPiNcLLJuWDUtzCEqhnl1RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7BfQIy0lRr6w01SClyWSQ6niQZa8K98qh/bhQ6c+XTxksL3sH+xOHXjq737aMCl/OqanAy0sAPxsQ6RnO9pYLJhPXLeA7k1hEQJTqTvDtLnCMMlcgtadvNjAr+5B/uyXmjSYMj2MBvqieXxVpZn9SSMUjmd3wame/pkYZ3RTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYWeed75; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYWeed75"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d3900f90f6so229801485a.1
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749829461; x=1750434261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SgyI20N1EJS4N1O2haaj7hFb/nPW/rhYBsQWgW1f678=;
        b=JYWeed75GgYcEWcImfD6BbT/W4wWOqVOZV3FdlGTqc9SLG3+kWbMruP5y5fzlvUCKb
         wc3SYo6AYGTTCjy1Fxx4W8R5qNmTDXCoz1mB56sWhz4UQc7fv7IheWQruIHRzZkM8BKR
         BphNGK/COhTqfBpM2DUJFhiZ2Tsn6rZzw0Ub7XpqWUrAtkU0tuLhULMuaTCCzWwUjgOl
         v+I34X4LljyAx06Hi31xb3HfTcVImbqFabYfxsIKmFtkACJoXy0+iEkim+9ouuNZfZ2G
         2WQlK9TVPRKWbu0x6IKCACdRNZhD3TuxTSFCeDtilGKqsR4RmIwRJ6w4OmbTSkKhs+08
         +a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749829461; x=1750434261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgyI20N1EJS4N1O2haaj7hFb/nPW/rhYBsQWgW1f678=;
        b=eq7DjItY/NGVowRwPDZ8nVeWu9HQIv1U4phxMCZQAVQzklN1BvVDhIcrTDB/vhi0EU
         tY263UsI5aIL/xPo5/R7AjyGumCHSHhCMv5wQ5DJZv3bkCsvpNIf8TTn9UsLS+9Jl970
         bByNhsPtWEou6pLFJEoLqXiouNcTkbSi27zLzz7JGdOM6vITseNSqey1r2U6L85C0UnJ
         bnp8YfWDIKZy3NOwd/1brmvNYXYBpu7prM+D6qBqW7TGG4BmiwxBMdvuq7tmSFSvcQcy
         FyHIWH5GKYTgDJUm5a9jL4V6e7vGn9lYL3Oeas85r6+lUGtZ/ufxsBpDV3KqxK0duTnZ
         H6Ag==
X-Gm-Message-State: AOJu0YwZqCNLsqBtEKPWHWsSrlfO0tgbW7vwwZwqBMwXtx/hcjeRnDiJ
	iXBj5BeMg4cA6PyZdfC449fO2zlia7/z4a0KzTwQlEcMnB2pO8vsNUIXjUHc9w==
X-Gm-Gg: ASbGncvaA18zYGOpdHUl+aGytdw63RDWTZa2VIE70skFtDIH+Rwfo4IijdqiipebNFv
	yyxGqDrlN1ZWlvspubaz6fuqEVNiVJWZQFoIbKo9YHo2LW+2WNYNpbBQrQZebYNylFMjLUb8DRQ
	le21k4RgjtO5CDPVPl+t9uDtsFR/whx9gazVreKIWRG5+1+/Ai0iiw+QC/d8ymiI028XU7O98hr
	4JzDFleWW0osRgvUltWCuosrilL+VSqZSRDaaZsA+QgHVN8Drlu8AlF4fGCp53UzU7dz4I4bf9L
	KxASh3qe4q8O32lyt+mCqAx+gUFCTfaZOcD+JqePlgCxgOgXrUH5zM936zeGK1RALBehyoWEFMA
	iIVkxwLvq/sNQpgYextAWj03O+BolgOlcnjSXLF9MS7lxpNHPtORRHcBwYBY7v0uNhQ==
X-Google-Smtp-Source: AGHT+IGVm3OEiZvLEohaYYMZtuMcfyPVes6sLyK98+n+lUA4IK5HWY8NzKkyt8DsEDewkMUWIfv9aA==
X-Received: by 2002:a05:620a:bd5:b0:7c5:5fa0:4617 with SMTP id af79cd13be357-7d3bc4d2d10mr596501685a.40.1749829461320;
        Fri, 13 Jun 2025 08:44:21 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8df8f01sm186113785a.27.2025.06.13.08.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:44:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] README.md: update dependency from iptables to iptables-nft
Date: Fri, 13 Jun 2025 11:43:44 -0400
Message-ID: <20250613154343.25702-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Going forward, testers should install iptables-nft rather than iptables
when running the testsuite.

Link: https://lore.kernel.org/selinux/20250611183234.10255-2-stephen.smalley.work@gmail.com/
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index d24a3cc..f067eeb 100644
--- a/README.md
+++ b/README.md
@@ -51,7 +51,7 @@ similar dependencies):
 * libselinux-devel _(to build some of the test programs)_
 * net-tools _(for `ifconfig`, used by `capable_net/test`)_
 * netlabel\_tools _(to load NetLabel configuration during `inet_socket` tests)_
-* iptables _(to load the `iptables SECMARK` rules during `inet_socket` tests)_
+* iptables-nft _(to load the `iptables SECMARK` rules during `inet_socket` tests)_
 * lksctp-tools-devel _(to build the SCTP test programs)_
 * attr _(tools used by the overlayfs tests)_
 * libbpf-devel _(tools used by the bpf tests)_
@@ -78,7 +78,7 @@ following command (NOTE: On Fedora 32 and below you need to remove
 		net-tools \
 		netlabel_tools \
 		nftables \
-		iptables \
+		iptables-nft \
 		lksctp-tools-devel \
 		attr \
 		libbpf-devel \
-- 
2.49.0

