Received: from 7.mo576.mail-out.ovh.net (7.mo576.mail-out.ovh.net [46.105.50.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AD525B
	for <selinux@vger.kernel.org>; Fri,  1 Mar 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.50.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312233; cv=none; b=tvR0QviSmb2xzudw/Be0AOBPwy0+R26qxWYsUagBFzbLDXJfShAL5FacwxLetMSMsjMMxYKGMZXg5PPV4IQMaLw0e+V7Hz0nOBTCcPtXUNbBQI3V2NcdNP8KDHhDvxQnMUcPL4DelOznrodp9oOxUm3lR6c254Lb+ttnb4WWO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312233; c=relaxed/simple;
	bh=wXmZRGg/9hfuPnptVMwypZQneyhiRBPwiPmTqzrXuz0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SR2RT8GeDfbVnVRTUcXpiYVPM9EEt4T4CEF/P1SgYJR3V0eovxH2ZWMOx3Fu9+V9kHI4xb8kcqvUAGz3buWajzcMDGsLI9N7nCrL3LesrJXYD7WvqnWb/KnLSyOVTUU93i/E9bK6y1V1GhnV7PetDcicN/DwZ1SIZxj3nb+FIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwillikers.com; spf=pass smtp.mailfrom=jwillikers.com; arc=none smtp.client-ip=46.105.50.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwillikers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwillikers.com
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.148.21])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4TmYX51RpGz1VlB
	for <selinux@vger.kernel.org>; Fri,  1 Mar 2024 16:32:05 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-p75b7 (unknown [10.110.168.195])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9DFCF1FD39;
	Fri,  1 Mar 2024 16:32:04 +0000 (UTC)
Received: from jwillikers.com ([37.59.142.96])
	by ghost-submission-6684bf9d7b-p75b7 with ESMTPSA
	id o1P0HAQD4mUOKQEAgadfFg
	(envelope-from <jordan@jwillikers.com>); Fri, 01 Mar 2024 16:32:04 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-96R001857ce7a5-a96d-4438-a7a6-313c0c9a81f0,
                    3A2481220FFA8572E7F2BD1705BD9E179A165549) smtp.auth=jordan@jwillikers.com
X-OVh-ClientIp:69.5.141.1
Message-ID: <d5120a64-04f3-444d-aaf8-3cfc6c1d9953@jwillikers.com>
Date: Fri, 1 Mar 2024 10:32:02 -0600
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: selinux@vger.kernel.org
Cc: jordan@jwillikers.com
From: Jordan Williams <jordan@jwillikers.com>
Subject: [PATCH] libselinux/src/Makefile: fix reallocarray strlcpy detection
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 217580158150933885
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrhedugdekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfvfevhffutgfgsehtkeertddtvdejnecuhfhrohhmpeflohhruggrnhcuhghilhhlihgrmhhsuceojhhorhgurghnsehjfihilhhlihhkvghrshdrtghomheqnecuggftrfgrthhtvghrnhepgfdtieeugfdtfeehheektefggefgkeejhfehtdegheeuieffudetgeeiiefggedunecukfhppeduvdejrddtrddtrddupdeiledrhedrudeguddruddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehjohhruggrnhesjhifihhllhhikhgvrhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht

Pass CFLAGS and LDFLAGS when checking for realocarray and strlcpy.
This brings things inline with the fixes for libsepol/src/Makefile.
This better supports cross-compiling scenarios.
There, flags like -sysroot need to included when running these checks.

Signed-off-by: Jordan Williams <jordan@jwillikers.com>

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index d3b981fc..3a9b5300 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -104,13 +104,13 @@ override CFLAGS += -I../include -D_GNU_SOURCE 
$(DISABLE_FLAGS) $(PCRE_CFLAGS)

  # check for strlcpy(3) availability
  H := \#
-ifeq (yes,$(shell printf '${H}include <string.h>\nint 
main(void){char*d,*s;strlcpy(d, s, 0);return 0;}' | $(CC) -x c -o 
/dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}include <string.h>\nint 
main(void){char*d,*s;strlcpy(d, s, 0);return 0;}' | $(CC) $(CFLAGS) 
$(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
  override CFLAGS += -DHAVE_STRLCPY
  endif

  # check for reallocarray(3) availability
  H := \#
-ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint 
main(void){reallocarray(NULL, 0, 0);return 0;}' | $(CC) -x c -o 
/dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint 
main(void){reallocarray(NULL, 0, 0);return 0;}' | $(CC) $(CFLAGS) 
$(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
  override CFLAGS += -DHAVE_REALLOCARRAY
  endif

-- 
2.44.0

