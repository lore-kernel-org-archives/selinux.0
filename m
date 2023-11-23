Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2DF440F
	for <selinux@vger.kernel.org>; Thu, 23 Nov 2023 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O3GrmF+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E05C433C7;
	Thu, 23 Nov 2023 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700707890;
	bh=rRbIXqjq8DKBA6vW+7glleky65j8TQodsqrm6IeWtY0=;
	h=Date:From:To:Subject:From;
	b=O3GrmF+pij5RJ0DdRb5iv8rOkrGIaE0PIvRjXiefZCxHcx3XSNfqbJ77NXjFl+3kx
	 f0eCcQMKcfvyJmKjXBAzHiYhkK3OTQIB5j54UzYgAwLA/S11bbo+QMFK//m7OsFqEW
	 FEtcMoZyUp1bUAZ9/zhCcq+4vUupkAKwfZ4sndCg=
Date: Wed, 22 Nov 2023 21:51:29 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: selinux@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231122-prophetic-warping-trogon-12f52f@nitro>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to the new vger infrastructure. No action is
required on your part and there should be no change in how you interact with
this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
