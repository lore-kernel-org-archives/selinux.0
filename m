Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06729444;
	Mon, 21 Apr 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745248696; cv=none; b=lattf37fAUkFuDtt6ZUOSzkGHRKsd/VtiIXQbeWRfyNMKPCyhMS7PKwCxCxiSmMeNFFagaCa/t5fjhbdalzyGy+B+wYXZbZpgJpk/E24LtL3l2/O6LCPxIEpDVaiQCcpt0Is3O14zo8eXMCXk8gdIoBnYv6ujkHXJqQIhucnSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745248696; c=relaxed/simple;
	bh=HTOJZsomxIroWF/4D2suaQ8hzQxUsmD875/TOV+FLaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prb1mgDNJIC4jjdY833sLHBgExlO4iPYfuZn3W2YGQeinK6xLfjQpEyzFxn6IGAEbLcUVBzmwpcif5Niyz/tTxO0w6m+KGyBI80Slonq6Z5Gk8pNneqW8kdSTOH/Om/R7bX5WIaj1uZVZR6HU5P68Spz2KVnLeP+o0uWbr06zcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfP0PuE1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfP0PuE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF327C4CEE4;
	Mon, 21 Apr 2025 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745248695;
	bh=HTOJZsomxIroWF/4D2suaQ8hzQxUsmD875/TOV+FLaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfP0PuE1cV0K7v1+e/VqmcmKkNHo5wMai4Z3P0FIW4fLTGbsN0LV3sO557RmgWWCe
	 EZa7bXDXZD0cBEpanNNw/x1aNb0NRNklywL30ZRxAypVP4ygoedmiTN4jrWgy3NbRa
	 GvKtvtLgxjsKxZeDQLEyZUzkmAZiE5GSK+e8xvKwxJDWHzw5kqx0HuYGwlimLapTrt
	 wsZstbyhWZOGPBua0efZHJ+/2ORayWhxV2BUV6mNg+7E/UsH9TwyMhmZ3IcCmtWnf/
	 /FK69n7qmnLRBP56yvsvg2xdNHJ6xynemHAojeRgBL7rtPczSdqU3HK8EwyAnD3L9L
	 cTIXSI5bZkqng==
Date: Mon, 21 Apr 2025 16:18:07 +0100
From: Simon Horman <horms@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
	surenb@google.com, omosnace@redhat.com, shuah@kernel.org,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	tweek@google.com, paul@paul-moore.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
	hridya@google.com, smoreland@google.com, ynaffit@google.com,
	kernel-team@android.com
Subject: Re: [PATCH RESEND v17 1/3] lsm, selinux: Add setup_report permission
 to binder
Message-ID: <20250421151807.GQ2789685@horms.kernel.org>
References: <20250417002005.2306284-1-dualli@chromium.org>
 <20250417002005.2306284-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417002005.2306284-2-dualli@chromium.org>

On Wed, Apr 16, 2025 at 05:20:02PM -0700, Li Li wrote:
> From: Thiébaud Weksteen <tweek@google.com>
> 
> Introduce a new permission "setup_report" to the "binder" class.
> This persmission controls the ability to set up the binder generic

nit: permission

    Flagged by checkpatch.pl --codespell

> netlink driver to report certain binder transactions.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> Signed-off-by: Li Li <dualli@google.com>

...
