Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501B12FB36
	for <selinux@vger.kernel.org>; Tue, 14 May 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684238; cv=none; b=RSC58XzMYq95CS7ukq4wDkf2Aulsbh4TZOS5Md9hxYw1ED1P9EMwgTeNLVzEpOtSRBFgeJvm+ZHb3/Nvt570aRw8Z+Ot2ZOQNF3u2RAfF/p2sW28inHxTNdVAX8/X0b9L8VrxeXCpz671gZqsr+60B8ApRrBxZEH7VVEstTvPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684238; c=relaxed/simple;
	bh=GES66brHB9LzP/L8k03xqKHZ6Uh70dcSMl0XK4azpHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Rv2HQpjf3RqXEhZcgPlQeHs5qVkex9DjOAI0pbpZwJgfOem9Xfw23daEqggXjg9sg0r2n1CtirV4u24NdwECpseiAoDitCYtC0ZNEA1fCnQulvLGC1Svbs+wnr3v0ETT4h7e9UYkeuuHfjEuazMXddKkZ2s4cOabv/KObsN1XdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKYaNFGb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKYaNFGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715684235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1E5OX98QIipxMgARRnovryNEY536IeF8a1yeU8kkt4=;
	b=iKYaNFGbD7IamRXunW0TfZKjMGJ1+MKY9wbcKDV5yydRHAfvW1EDlGqgzM6AntWX6+WWNO
	IQFT3k60JhJURyudLLgqqLdeoLbn4tGn4ljjSAo0xUi/fgpcNlVRPp4OuSm834RHo+/Ulr
	RJ/d1gpCfoDf/yQ54nYnrMCISbTdBb4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-LgQb8ewMN1WMQ2hwOjHK4Q-1; Tue, 14 May 2024 06:57:04 -0400
X-MC-Unique: LgQb8ewMN1WMQ2hwOjHK4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D020A8030B5
	for <selinux@vger.kernel.org>; Tue, 14 May 2024 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C57740C6CB7;
	Tue, 14 May 2024 10:57:02 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 2/4] sandbox: do not run window manager if it's not a session
Date: Tue, 14 May 2024 12:56:49 +0200
Message-ID: <20240514105651.225925-2-lautrbach@redhat.com>
In-Reply-To: <20240514105651.225925-1-lautrbach@redhat.com>
References: <20240514105651.225925-1-lautrbach@redhat.com>
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
 sandbox/sandbox | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index c2ae4de69128..1e96f93e4a92 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -285,15 +285,12 @@ class Sandbox:
             fd.write("""#! /bin/sh
 #TITLE: %s
 # /usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
-%s &
-WM_PID=$!
 if which dbus-run-session >/dev/null 2>&1; then
     dbus-run-session -- %s
 else
     dbus-launch --exit-with-session %s
 fi
-kill -TERM $WM_PID  2> /dev/null
-""" % (command, wm, command, command))
+""" % (command, command, command))
         fd.close()
         os.chmod(execfile, 0o700)
 
-- 
2.45.0

