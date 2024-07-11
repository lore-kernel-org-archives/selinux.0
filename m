Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0082F46
	for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709596; cv=none; b=CL9zTT6/DmU0mUCho3YPIr8l6bx6YdbEzLbLeyXK8FTG7zO3ViOe0sXzyJs6rPO392xzbmUoE4//HeNxf91orDtJ6sxmbnBuG5ix3Po+gkL8Y8VCzya8ZvXy6ZbgAK+It/YYxC6e1nsf6eF87uNW3WGl4RM6UAGR4LEvl5j3MaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709596; c=relaxed/simple;
	bh=Gf8AHo97XAjG/UK5uiD2umYgK4U6FzsG6+qcaohXmxk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=M2yl1KrfKSxlQFZvWI+cPWp6AaEiEhLpCD8G3krk1sOmy9joQJemGmcDCWvAPnNSK0Ts0vIzA5WpDG8SvT18adbL1qaKHlWLFoJ/apUyIEFqM9rE7kQhuYi85NNuheT9ehvpYPr6hZIXrBvKsrusl+n6JlqFpJCHZ88UwZ1gA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxD9Nbvo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxD9Nbvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720709593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WAN7fxJ1mWoqg2jsx6Ft+g7b0kZ7Pl6tmJz/IbTlTa8=;
	b=UxD9Nbvo6k2BP5KhmYV9Y+09xIjVyBZdGjz6ACC6vliV07aO9JF1tW2kD3zu73edKj1R6p
	yw/b4VEJBF3tzgcYPHlFdLqTEsUAVh28SOEiWKs7tl3Q3Ax3+L8je827dgtI2gTHJSi6Uw
	bnH/NPpK0u7j6CItluVfO/G64db15Ns=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479--EumnzRfMSelKTAskJhiDA-1; Thu,
 11 Jul 2024 10:53:11 -0400
X-MC-Unique: -EumnzRfMSelKTAskJhiDA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 477F71955F0B
	for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 14:53:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.244])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91EA01955E89
	for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 14:53:09 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: SElinux store file context and ownership change
Date: Thu, 11 Jul 2024 16:15:03 +0200
Message-ID: <20240711145257.392771-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello,
I'm trying to address a known "issue" where SELinux context of files in
SELinux store gets changed on policy rebuild. This triggers some system
verification tools and unnecessarily raises concerns in users.
I created a patch using getfilecon and setfscreatecon, but am not sure
if this is the best approach since it will not fix a context that has
already been changed. Also, any files created as a result of execve
need to be addressed separately (e.g. file_contexts.bin), maybe using
selabel_lookup to get the proper label since that way sefcontext_compile
does not need to know the path to the SELinux store (only to sandbox).
I considered relabeling the whole sandbox before semanage_commit_sandbox,
but that seems wasteful.

Then there is a related issue where the rebuild is performed as a
non-root user, causing files in the policy store to change ownership.
\# capsh --user=testuser --caps="cap_dac_override+eip cap_setpcap+ep" --addamb=cap_dac_override -- -c "semodule -B"
This can actually cause issues in some scenarios (e.g. remote login failing).
Addressing this seems to require more drastic measures. My attempts to
use "chown" failed, even with the CAP_CHOWN capability and using 
seteuid/setegid does not seem safe. Any suggestions would be
appreciated.

Thank you.

Vit

