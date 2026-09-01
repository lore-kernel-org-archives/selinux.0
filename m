Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A942E43D
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277782; cv=none; b=oXaNJ9dBvE9VfEm3nukWqCx5BU+Hg7J26EUtCYs5Wzm+4BzjGVJNTMprL9l48lrQUZEK7/zIYri7zQcEcTJn+ShoC2+7VWtad0XhtRiH9gXBOItFJFVHhTU5buCJVydVnih9or/OSLpnzgv1TQxhMPSaeIaw/VnH0N5oHVRx38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277782; c=relaxed/simple;
	bh=x3a/mmV0r3tRAWb02wTKav6iJuGKkoVa4H67Z4CnqaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAhMD5sPTnmvQhM/yIwJFEyrxII7EuV7h5gkoImfu1Tp+B8UgkRElhGXQybA14T3182+RMtwZH6T0oU8Gh5AaPC6esJygK/8LTzRQlhX6CcJ0kx6plw5r1EU3Er02zub+51AftQHh6JEoGb7XJecS9ZreeSqHLiBym4vywPe57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2gt99N/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2gt99N/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e99ef0902so1123785a.2
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277780; x=1788882580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nLcPpZZWoLrwCUM4V615FJNOlWJsPdm+YUDpndaymcs=;
        b=R2gt99N/3TQAbLgTZk8ifnZo7yRiS9es6zQO6LHR5lcprMx+H+axgNNX8j34IYAa9B
         p+WOYyeVbl0ulr/if8BuU8f4Xl0bhDqAtdbMtOPiIHl0yTbdQq0/GN/ggq5KIKWAVIvJ
         3H708xKuV8H1rlCivj3HsP7mgnMSAFK+Tct2ManKcgMuhB0M2HZIqflgdK0WMpJETbKh
         JHOee26tjEHr0sdE15w9Do2PhJhIlrRTHmIPkW6aZbru6bs4QigMLYXAw71cGfHNrVPU
         1HeVTzio8Cv8MTBZIhz2UCV6PXoKpS+E8WlgbuXtwRssJ0a1mluXGgUHYj4mBsFWuYoc
         6I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277780; x=1788882580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLcPpZZWoLrwCUM4V615FJNOlWJsPdm+YUDpndaymcs=;
        b=H1IZx1+Xkzy2rXZII5UCQMOzNqqGjRcoIe/ezj2BQSDGhG4eKiJYl255iMREvadicW
         OTToKirbWfWlkjnCFJTX1ZQFF2PgrRXX90bf0OqCGWtQBa49ea5+jzguKJDHkGi7pzz0
         87IfHRi8DFN8ouqKG3jcstnAZ6kWPbsHxeUqUAlJCFfU/77wMxSJgUGIIQfoss7j85jN
         fhkKhOzjoVdX8bc4JFH/VpDKuq6ktMEmAg18UcD/7VA5acc5zrYYwhlE2QMUJ1shiZpW
         mqTmjkbRGgJ3M57wn6ooGA/Ws9LWXKr6n/3TDpr1Fdh/T5gtVZi528LtHLRa+p/ob9bB
         7yNA==
X-Gm-Message-State: AFuF++nUmMUphEPyWj6C52LWC7TBupqaykdldk0TGFvyUprZ8JP2ifIQ
	4yJHY96wHU/ZEA/ck2Iw3f635pYbgN/9rldu6NMssaFMSR1kkqqwzFO3c+yvNw==
X-Gm-Gg: AR+sD12gOxiBHWyioQKy2EfXsyHBXIoGDZIv1vfuEcl6vrSCdFrrpLDpuzAYerbBNcy
	ad1ogQ3ah3pdL4hNiNNt+dF23cIudGvg9FxaVOeKMV2Byg3Ccp0X/x6mM0HcHXdCmP09b0dP+ih
	4ldwa4vd2MguKdNbmAIrgk6s0ZbQtmIYKftTmo2qlCn1WQzQoWX9vevrJf2nz1/x1AacsLZbTIL
	F2KcYN+anwczUWwXInt2q1PsNwcZclTdg5G6qimN/mUEHuwR0uH7P81bDPYOUD6omXz2XijMOok
	OxOa8eBTigfj7yQoXaahErjXbW0SHFec341eGeCL+j9o/ekDoxj8u209xMYXZCzVlqXTpXJq6I4
	DS5xukw1OgiRULtiB9vL7LAZj2k6GQjyredPuwDzsTKyduI9SSy+dyX4DOFz9j6rYR2K0W3Sz6K
	cZhYCwLFpFgf5Ckjp3+5mr2TbqCd0SrxDxofDviiTvG7ErIV3kUO9F/PhgOTZk4KZaf/SXUSYuh
	DegxN3fcj9isuDx7eaEAcA8WJjSv+g3VCXakTkjg3fM1KxUtoO4LtpRVJxAYT6CCTdHF/CkDE8=
X-Received: by 2002:a05:620a:a28b:10b0:939:5ae7:2dad with SMTP id af79cd13be357-9395ae77995mr229003485a.38.1788277779585;
        Tue, 01 Sep 2026 08:49:39 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173db029sm1047209785a.35.2026.09.01.08.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:49:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/4] libselinux: add a configuration-root search list
Date: Tue,  1 Sep 2026 11:43:04 -0400
Message-ID: <20260901154307.41844-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is the first half of addressing
https://github.com/SELinuxProject/selinux/issues/33

It adds a configuration-root search list to libselinux so that it
searches an ordered list of configuration roots for each configuration
file. The list can be overridden at build time via
-DSELINUXFALLBACKDIRS=.  There is no change in behavior as long as the
files are found in their default locations under /etc/selinux; the
fallbacks are only used when those files are missing, e.g. upon a
factory reset.

The second half of this series will address libsemanage but is not
necessary to merge this half.

Stephen Smalley (4):
  libselinux: add a configuration-root search list
  libselinux: search for the binary policy across configuration roots
  libselinux: fall back through configuration roots
  libselinux: search file_contexts files across configuration roots

 libselinux/src/booleans.c         |   2 +-
 libselinux/src/get_context_list.c |   6 +-
 libselinux/src/get_default_type.c |   5 +-
 libselinux/src/init.c             |  12 +-
 libselinux/src/label_db.c         |   2 +-
 libselinux/src/label_file.c       |  50 +++++++--
 libselinux/src/label_media.c      |   2 +-
 libselinux/src/label_x.c          |   2 +-
 libselinux/src/load_policy.c      |  24 ++--
 libselinux/src/matchmediacon.c    |   2 +-
 libselinux/src/selinux_config.c   | 176 ++++++++++++++++++++++++++----
 libselinux/src/selinux_internal.h |  40 +++++++
 libselinux/src/seusers.c          |   4 +-
 13 files changed, 280 insertions(+), 47 deletions(-)

-- 
2.55.0

