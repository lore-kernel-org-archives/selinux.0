Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45D2248B3;
	Sun, 18 Oct 2026 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343092; cv=none; b=o0vEMGLc4i/wQulW/898jXdA0kNREyvaNVHRY2YpT5glqxq94Rx5DgOZUEHbPEv26RKVmJkQMMWdCb4W0od9DzSUwpXr+cour5q+fL0gD0JCxpN4W+aIpeVV6Z7C5FUEUhOgJmCtBphJkGyOUpV7l9ir55dkSZvECjPxcJ7rRfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343092; c=relaxed/simple;
	bh=nS5hJiX6ZaWep8x6PbrSI4s7+PVQQGnVEYPkrnSr4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUNX/2WFa4X0p9vRTkBtSBpdUnTO/6rBsA44nTJS/YjNOK8JtGoYa9WkQ5IrT/f1QNnMk3NRZfBbE3q7e6DJRPN7BKJc9Ygvnovm+nEKKftM+81Z0N0tZZRohb4zH4tizP6KvCBMb4gpOmBx1yQUTwVBKZbMJrTEloum7uTj07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qf6ziHsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qf6ziHsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571B51F000C4;
	Sun, 18 Oct 2026 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792343091;
	bh=QrDNZk1T0buPEVwx6Gbdzq8svH15mdaErDpvluwUoGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qf6ziHsI84u29DZ7NCqI5YudXkdEdQqfoLJaj06OtxKkMUckX6cX/Q16qcW66Eqvd
	 TUUP1SCvdIMKV/1bSrKC4cr4QW/m7+JxMv3U3Prrmv7tZT+Vt2R7Q5hfNy3IcUwJA2
	 2eMvETIeYAtDmWIGvPXjhZJ/F1/4w5yoY39gCT2A=
Date: Sun, 18 Oct 2026 18:53:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>
Cc: Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <christian@brauner.io>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	SElinux list <selinux@vger.kernel.org>
Subject: Re: BUG: selinux-testsuite binder tests fail with
 CONFIG_ANDROID_BINDER_IPC_RUST=y
Message-ID: <2026101814-strut-endnote-a0b5@gregkh>
References: <CAAUqJDt1pXQ2KVBvMoMiDrzz8ishonqhQ0nnQLEppot4nmv9Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAUqJDt1pXQ2KVBvMoMiDrzz8ishonqhQ0nnQLEppot4nmv9Bw@mail.gmail.com>

On Sun, Oct 18, 2026 at 06:36:04PM +0200, Ondrej Mosnáček wrote:
> Hello Android binder maintainers,
> 
> Fedora Linux has recently enabled CONFIG_ANDROID_BINDER_IPC_RUST [1],
> which turns out to cause the binder tests of selinux-testsuite [2] to
> fail.
> 
> Minimal reproducer (no SELinux involved):
> # git clone https://github.com/SELinuxProject/selinux-testsuite
> # cd selinux-testsuite/tests/binder
> # make
> # ./init_binder.sh
> # setenforce 0   ### <-- may be needed if SELinux is enabled
> # ./manager -n &
> # sleep 1
> # ./service_provider -n &
> # sleep 1
> # ./client -n -c -r 3
> Client ioctl BINDER_WRITE_READ error: Invalid argument
> #
> 
> With only CONFIG_ANDROID_BINDER_IPC=y the last command succeeds.
> 
> The issue reproduces even on a kernel compiled from commit
> eafedbc7c050, so it seems to date back to the origin of the Rust
> implementation. I'm not sure if it's a bug in the new kernel code or
> some bug/wrong assumption in the testsuite code - can you please look
> into it?

Given that the "real" binder client works, perhaps the test is wrong and
should be fixed?

thanks,

greg k-h
