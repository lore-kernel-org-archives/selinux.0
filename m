Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2812FB12
	for <selinux@vger.kernel.org>; Tue, 14 May 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684227; cv=none; b=bAVgm7qIaAj/50faqJd2hRlfWPzcwlG5VItGpZQao/+tX2y0DaQP1Y98/i+ZP4V5xbMQl8ytnbOJvBOmejTVNuBeNuKY89WsXiin66qg6Gp467R/PeNOYI3WepaEoL183MNJvz3WynfPuMyfKcpc4/PVliM5BrduO5wMyGFJxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684227; c=relaxed/simple;
	bh=UmRQHMOBh1ao+uinKZLhCjz+tzj3jl8KP62Fv9Hysto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=gaZm447WcU+4oGAQg9/5KeCZ4TWpOTQ7fX0V+dqpYena4Ya8ywmc6BVJAM8jwyWI2vvxc2nTvOrhGOoyETjtmipwfihf1sb7M8h5V3YnYU61KieWJ03Z1dFTRj6v/XYTkdVkAw5OczHPiurr8vFcVUl8dfN5L2A2riQjyU1htd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgZn8vey; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgZn8vey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715684224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wm/kLhpgUcErf1kQOIGmSSf/GJq4n3CfD9g1B7+4oNE=;
	b=WgZn8veyTV5Lzb+M7utpSgnz2/OOUKG6X94A8TFdFeldrReDdHfhRBR9OHqt35wbaig+pS
	15OrEGp0COSl6dt0593+7Sbfj4lndcE3eFaUgR055R8UYqizdE3GjI0q93Ji/9Vf1YzybW
	gTKXvq2etfXzk7iQuFpyRD1Sr92N8SY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-0CIxMo3gP0CXFQ9tgjBmgQ-1; Tue,
 14 May 2024 06:57:03 -0400
X-MC-Unique: 0CIxMo3gP0CXFQ9tgjBmgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D70CA1C00049
	for <selinux@vger.kernel.org>; Tue, 14 May 2024 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8831C40C6EB7;
	Tue, 14 May 2024 10:57:01 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 1/4] sandbox: do not fail without xmodmap
Date: Tue, 14 May 2024 12:56:48 +0200
Message-ID: <20240514105651.225925-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 sandbox/sandbox | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index fe631a92cecd..c2ae4de69128 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -479,7 +479,10 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
 
                     xmodmapfile = self.__homedir + "/.xmodmap"
                     xd = open(xmodmapfile, "w")
-                    subprocess.Popen(["/usr/bin/xmodmap", "-pke"], stdout=xd).wait()
+                    try:
+                        subprocess.Popen(["/usr/bin/xmodmap", "-pke"], stdout=xd).wait()
+                    except:
+                        pass
                     xd.close()
 
                     self.__setup_sandboxrc(self.__options.wm)
-- 
2.45.0

