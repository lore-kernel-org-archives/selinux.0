Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C72BEFE4
	for <selinux@vger.kernel.org>; Wed, 25 Jun 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848096; cv=none; b=gevWhvvcUqtGsmKvZXJBZA+f6O5pCqZbcFRubXrB/LJQl+JI3DsPkjqDAVJ8XBc5dhNeDav4PFuZt4H8Np/h4TmZeqE5eupPSD2L+OjUjTGYyPMbIjnghf+30bcSBLkwCVBZEF/WtbkQPhm1H+znBUGFjaZOxKtTDd92iZcf20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848096; c=relaxed/simple;
	bh=pYL/Bvst8eoVcKFhNLAE3Hhwd8Vezw4iXk9ZCZMk0n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcTIsznD07eHVJ/wx9huMkuPFII8WSk5J1jK+0oATR4Kkf4JuAejqPM5Cr3KxpG67WO9xkMcNxGOwMSarwvBZyLKQ8WyVO1pZVYVKbgyTaDZkcSSLzg844vyOAnZNH8dZ95/pWVtFp/rHL/6dpYyD59dlhX3KCcm6v6cAbZffRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=FbJi/3ka; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mh1xPHdT; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="FbJi/3ka";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mh1xPHdT"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4075B7A0181;
	Wed, 25 Jun 2025 06:41:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 25 Jun 2025 06:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1750848091; x=
	1750934491; bh=KalR6zpeb4jjqukrlADcA/tYCOtlfAEuuNJSmrs2LuA=; b=F
	bJi/3kaRGdPc09hlIvsiiuU0hUEDTFL5PyIEAcbknBftDzImksh7eTR7AEWr4gPC
	w1LP+9Yu03PwOVM1jf2mDftPkLpCXRuibLQeOwefj/2Xy7lde06ZWoa/BhEYZtms
	ZelMEnYgMfMAuRyiFuldclyOkduzHgb02mNU1pj8iMiIfBpDxIHAABHPmjmAthVB
	yL8xZ5cjznFW4WFbKjSiEeGFnWuflqJxYd2tiUKEJfhTpVqEQaVSSfG2yMh7d4Rs
	28uyXlZjsBfIBxtAukXmIym23hVMLOPYS38520Vr/AecIgNMYndBnsYvlz0rtEK/
	wydRDU18/hA5Ap6YYWzCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1750848091; x=1750934491; bh=K
	alR6zpeb4jjqukrlADcA/tYCOtlfAEuuNJSmrs2LuA=; b=mh1xPHdTr5V0EwUnl
	bvQUItgI1xNF/A2Rp1yBMbm33eSnQ93nmZ3sb9HoBvlVEv8+PGXHMOipc8YnbfLo
	kkFUuf+XscBjMD6lNSOCtgKvZbdKsJfsPIoS89RJjfLkBmBvAIe6HTFtU6uu/Zsj
	des0pCjPaN+PeHGyP/GvQnUluNhaK9kPHEAIl+OEXCjT/OxUpJs/dm/2l+WI4Tcg
	eMbhLbIGY5vx+1nrYBFdQKvA5WIPp0wTe/hF+zPjYsUKPEIy42b7E4TWI/7Wu8gQ
	dM9cAUNLKL05nOKRcJ8Bc1YMkaK6ZqqS/nGI6vUGhrfE9Y58AYVSvMHsHs0opEuy
	fVAZQ==
X-ME-Sender: <xms:WtJbaPtcDSUbB1uUfXNePMXPv3C8Fb2M8kyLGaePIALUXtKV40APMw>
    <xme:WtJbaAc1lHFnuxVQ7Dnh-uw26v8PqU4cG_MBEmz1xTD52xxb2wfj3QUhvOTlOjEym
    2RB8MlPFyu6C5YXIQ>
X-ME-Received: <xmr:WtJbaCw2k2_qC5tFlqvae25MTD7jXVFoJd5ylMJOLcbt1icmnOoOc9iJRXrm0DaIxKknKMIsropU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeevjeetff
    dtleegffevhfehfeekfeeuveejgfejvdetleejfeekvdetffdtveduueenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopeekpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehjfigtrghrthdvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepuggsuhhrghgvnhgvrheslhhinhhugidrmhhitghrohhsohhfthdr
    tghomhdprhgtphhtthhopehnihgtohhlrghsrdhiohhoshhssehmgeigrdhorhhgpdhrtg
    hpthhtohepugifrghlshhhsehrvgguhhgrthdrtghomhdprhgtphhtthhopegvphgrrhhi
    shesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhgruhhtrhgsrggthhesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepshgushesthihtghhohdrnhhsrgdrghhovhdprhgtphht
    thhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WtJbaOMEzSEDbWVR9voMqx9igXqKscxZP1Mo4IeHa12fJZp4trXL3A>
    <xmx:WtJbaP_KNi622O-hwHRDTzdJNpvGaEhbAJbfH5k-DQyZ5Z4stjMTLA>
    <xmx:WtJbaOUksK0U76PiDqs64LP8wrkpxeJI22bW_lUzXtf9zXLQvZfKRQ>
    <xmx:WtJbaAcF30AsSoAGimUfqq99e-ewvcIfVJgqCXSekANOtk5V9zYRcg>
    <xmx:W9JbaDWxavf5ArXPMn_aFeVi-iH-1d94rtJ0qAE6x4Go4hN5-dEiTjn7>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 06:41:30 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id E523EB95194; Wed, 25 Jun 2025 12:41:28 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>,
	Nicolas Iooss <nicolas.iooss@m4x.org>,
	James Carter <jwcart2@gmail.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Dan Walsh <dwalsh@redhat.com>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	eparis@redhat.com
Subject: [PATCH 2/2] policycoreutils: use pkg-config for libsemanage
Date: Wed, 25 Jun 2025 12:41:03 +0200
Message-ID: <20250625104103.140498-2-hi@alyssa.is>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625104103.140498-1-hi@alyssa.is>
References: <87bjqebpre.fsf@redhat.com>
 <20250625104103.140498-1-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libaudit and libbz2 are only required to be in the linker path for
static builds.  For dynamic builds, they'll be discovered through ELF
metadata.  pkg-config knows how to do the right thing in both cases,
so just use it rather than listing libsemanage's dependencies
manually.

Fixes: da6cd3d8 ("Support static-only builds")
Closes: https://lore.kernel.org/r/87bjqebpre.fsf@redhat.com
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 policycoreutils/Makefile           | 3 ++-
 policycoreutils/semodule/Makefile  | 3 +--
 policycoreutils/setsebool/Makefile | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
index 7acd51dd..0f3d62f2 100644
--- a/policycoreutils/Makefile
+++ b/policycoreutils/Makefile
@@ -3,7 +3,8 @@ SUBDIRS = setfiles load_policy newrole run_init secon sestatus semodule setseboo
 PKG_CONFIG ?= pkg-config
 
 LIBSELINUX_LDLIBS := $(shell $(PKG_CONFIG) --libs libselinux)
-export LIBSELINUX_LDLIBS
+LIBSEMANAGE_LDLIBS := $(shell $(PKG_CONFIG) --libs libsemanage)
+export LIBSELINUX_LDLIBS LIBSEMANAGE_LDLIBS
 
 all install relabel clean indent:
 	@for subdir in $(SUBDIRS); do \
diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index 7c45831f..018ee2ca 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -7,12 +7,11 @@ MANDIR = $(PREFIX)/share/man
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I../../libselinux/include -I../../libsemanage/include
 override LDFLAGS+= -L../../libselinux/src     -L../../libsemanage/src
-override LDLIBS += -lsemanage -lsepol $(LIBSELINUX_LDLIBS)
+override LDLIBS += $(LIBSEMANAGE_LDLIBS) -lsepol $(LIBSELINUX_LDLIBS)
 SEMODULE_OBJS = semodule.o
 
 all: semodule genhomedircon
 
-semodule: LDLIBS += -laudit -lbz2
 semodule: $(SEMODULE_OBJS)
 
 genhomedircon:
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index 1d514846..87494c55 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -8,14 +8,13 @@ BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I../../libselinux/include -I../../libsemanage/include
 override LDFLAGS+= -L../../libselinux/src     -L../../libsemanage/src
-override LDLIBS += -lsemanage $(LIBSELINUX_LDLIBS)
+override LDLIBS += $(LIBSEMANAGE_LDLIBS) $(LIBSELINUX_LDLIBS)
 SETSEBOOL_OBJS = setsebool.o
 
 BASHCOMPLETIONS=setsebool-bash-completion.sh 
 
 all: setsebool
 
-setsebool: LDLIBS += -laudit -lbz2
 setsebool: $(SETSEBOOL_OBJS)
 
 install: all
-- 
2.49.0

