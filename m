Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237A34B1B0
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028710; cv=none; b=W9hE+5Nnp6BHTfmycKyTKRwW86OfTjWiBnvWsk3Yjh0PUbR7WfF8s8LaTz9Ll43CUkGCQnv1FEa28p2r82oNvifNOnFj9yM/hTz4CAyfeQ8hIXIz/jP+u95aUEdxqTOolXV96KTqJJJkyWYj8T5/Fx5PNRCO0dUDW6H3JRo1abw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028710; c=relaxed/simple;
	bh=b0FQhVYiAlOKm0ibRI/5wMUOZES5FjzQ1PnPBeZUVzA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iaU32Ude25Xv/XH1Yw8lfXrGCa6v1ocquKHFc1c3po/MjSUFchjGMKrfwUjVYemzm5a1mk0SFSeLawtGsdpetqzQmTVef+RZm+NYyMDuZK4MpX+RJnX1pXKBS2UJ1w+N42wtdsl6Yggjf+wKPmsSVb6A6jSX5zzoHZjY6F7cJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q7FRoIu6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Megt6nJ/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q7FRoIu6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Megt6nJ/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C68B1400094
	for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 21:45:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 14 Oct 2026 21:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1792028707; x=1792115107; bh=zDFoGSqABzIftbq+//E3E
	VILVLZToUCGMg9u0mv3rJY=; b=Q7FRoIu69kXXq+CaeEsy/eSgOeB9O++qsoHar
	FrVVPO4gylOTc9vvRsDajoC2KPoIToE6Dqx+ex6zyEpMmeGalOhi1SBkKpjb6ZZj
	B3dZjN/8NVx/3QTyp/MV02u1wXJNWvQALXk5S2wsrYWn7N+nbR9MxszzIIWNtIr5
	f6KZeL0ujoRuEi/B0ECrrOngvjKBMcgBuYHTGfHsnrZmWBiVFUieEsMuFanV0k3A
	+ryu9oDU56wVBFniuc84/WUzuYrMFidY+iHS/1nKx9gkAjhs2XDM7ABh5saUrMUG
	Z5HD0RtVjhMY/aBqLDPkelfE8Jdzu0jz4murHQgMihaGyYOxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792028707; x=1792115107; bh=zDFoGSqABzIftbq+//E3EVILVLZToUCGMg9
	u0mv3rJY=; b=Megt6nJ/p3P9mwyugFgqsnu2BNKUK71/VNpS6K3jadErND3+YVJ
	pzHp0E6RZj9SMz7NbmpaE/CvK8hSXdIHfMuQs6CNKriYhBHJ6xJ7vCiHO454ljNe
	z4mk2K2IGU1xrcXt+v3mC/FXLeDRVPuWu4sCM1n2W2E0zs26D37vEaQSwKehmci2
	lhUT6KK8iYEcB8/7/MKH0IQwuS7fR0RXt+RLbtrUR3Gbrv7oBPBVCX1N64H5W2k+
	whnSwDyet4QatkrYGEt70BBoKUY280mJM0SiWdnA5u2JBbd5EgRLHtlu2aiqBh8+
	QyhW2biJkTdE2qee1muSS61BGqtgT96gKRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792028707; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+;
	rt=PHNlbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:k1wK2KCUwaMBq5tk5SmjgFqt0sJ4NPgUA4gDdYUlqSc3Zfj
	3g1jJdgKWCPnq2oiG7EUeRDvRvaY9oSA2gUCoTU1GzjuZDSYLjyckzHeTvVnjqPW
	K24az2WkVldh1v8HQhDVUh2wWRqbD6wsz0Sm0tRAQqqKNSv7aG2ZPvizpC6FFt66
	UGFZdM2nwBVBmZt6QHJKZSGDGKETeZuRU1V5l795qpqTu9xpC3Y+7UjnABCOSw+O
	Ks0PhgljGFGJa9T5frAjOA2rCoLbTzb3F+wF2l8TMpOXjXmfM0oAX2t2weNy6XJm
	wSomgojIy7p88cUVlkdpSZpc7sEbK/DqkCnhIVw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=8;
	hn=content-transfer-encoding,date,feedback-id,from,message-id,
	mime-version,subject,to;
Message-Instance: m=1; h=sha256:RkCPCwc8/I9ghOAfcW1TkBNzo/hqnDYx27J2zAbeRfI=:b0FQhVYiAlOKm0ibRI/5wMUOZES5FjzQ1PnPBeZUVzA=;
X-ME-Sender: <xms:IzDQajL0WpsFxhmPu-nJ1mkPNsiWVPSa_WMOZLtXhOX99W1Ukjd3Qw>
    <xme:IzDQauH51v0RRTV52KuMtQ7JgKywdj3EYwd-OJi9W5shF8wYYpun3fRmzDyazZRfF
    hSlYJHo-lE1rhubJNoDEbNqYpfv7swV1BIkXkL9fvMS65JSmbdZ-Sc>
X-ME-Received: <xmr:IzDQahX2li71xut8BfdRjjd7iij5LzaQ3YwbgDxNa7HFaVttrpZ8BmPdyKPdbQseVupGlBJBTyAIazCmFF-es9ku-KyA8j5ejiWx3mP9uysbLW9o9E74i6lYPFiOtrjI2ZfWjbHr_TbBXXHp>
X-ME-Proxy-Cause: dmFkZTGSAkV8BX8IxS1YOJ43wCivWUSxjjGOid8t48SfrlMOTsOMeNf+nIOOiowepMCfc6
    uLKWBxeiO8eybGVbTMCy0Fl92n7s/hnCvV1tLF46gqmfju72nkWe2rn0i3KefQq7L21+e6
    Wzvqm/NBm2KV4csHE2y2tqRkeYPqRP3SSv+OQsQLHPyJONQVfomziguChCTDxwoXMf/wWt
    q1oaFDoO95Jwx1yTmN3N/Y5WXcBzaqQHY+ZVQJdl/NHct9xda3Afgu4EPVhjN7pYtwbeNP
    R+BC/lwP8Q/5BVxN4izWLobeYsps+/U/w3aWFsUGVCWVIexVd4qQrllOPWRICcFiiewaSv
    OVAIX0VijRdyGALBUqEHp6U8GSh0QkC9uvhsUfK94tEugVMvJL4AlDUoWXjH661GOyOqfE
    mxgJM7ChdqIjG5+qWMtlyGy147U2PhnBZXhxKHZo3buHVs5CsddEGrI74vzmwg4pweyyhO
    bbXKAFJ6EwkRYmD9OpBx4A5nabSb+DTSUfUvr6hAdszY61XqsYfcd3fawElYOZibzctf6P
    vJ4jljg31uCbTg0d+Cbsg3l6fqQLZ2oVhCCuZkVt4L6APT7gLWMsak+GrGO8xl1C4O4GsY
    zBxb3TMd+4O5QD0eV19VOSiTPe/i0y4hj9S2xoSlegeFtaJWC2qpVtjkUw2w
X-ME-Proxy: <xmx:IzDQahgmL_EqCDbP6Jy0xyppWyi6pc0INkHq4Dv_1vCNFs14XybMnw>
    <xmx:IzDQaqS9kZyZ-3hyTAcDuExoJbnFr4S3Z5BFkCtMFVOL-WjdtjqcVw>
    <xmx:IzDQasEDSmerDJ4iwCl1rxZ8w6q5VGGb4toz8POXT23aw6e6cErVjQ>
    <xmx:IzDQaqkIzlwVyRybGEd4uI65xYMdauI6gMxpc-boYcEpkCIuedTRyw>
    <xmx:IzDQaoorGUD2ABrTN_higVgRHkqWwcWayRoAWqnBG0isLI3oUGACfEg8>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <selinux@vger.kernel.org>; Wed, 14 Oct 2026 21:45:06 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: selinux@vger.kernel.org
Subject: [PATCH 0/3] libselinux: sefcontext_compile.8 updates
Date: Wed, 14 Oct 2026 21:44:52 -0400
Message-ID: <20261015014457.877322-1-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed a few missing entries in sefcontext_compile.8.
They are included in the usage string.  These patches add
them to the documentation.

Todd Zullinger (3):
  libselinux: add -r option to sefcontext_compile.8
  libselinux: add -i option to sefcontext_compile.8
  libselinux: add -V option to sefcontext_compile.8

 libselinux/man/man8/sefcontext_compile.8 | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.56.0

