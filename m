Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D31F867B
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333130; cv=none; b=uolGJmTsVXFtmH2f4jgV91+Ue1BoTgHqACc+O88GK2nvaE0gs5oxgojdTO8RqfVofyZhY0wwz7xjDDMzrJUYQthPtTbM8ltRC7vR/rf7uUp1uxEarQzYSy84jN+8FsYq2TrNP4OYimQv+WXnuQtPnup9K0TvIkC2NVJnO0/oHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333130; c=relaxed/simple;
	bh=JRG6g8ElipN4/ko2ufdEgg7+1az0swozEZ7GGdL3S4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFwYOekq/ZKPpJysjNJFLRqmI43KRYPg2fW5uIyYiFajE/gaJXYnI9q5gSz80wdohG6bryQwPcmohCzTE+DliedII98ogW/fNQGB0E7RXhcWQZYyt3TYnPRPNUCxRV8FncFp5w8kZO1pORLVGNk6R1PdThXncWpFI4IWmN5ZJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rdmvrZDl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cxkVnG7K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdmvrZDl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxkVnG7K"
Date: Wed, 8 Jan 2025 11:45:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736333127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRG6g8ElipN4/ko2ufdEgg7+1az0swozEZ7GGdL3S4k=;
	b=rdmvrZDlWFhuJSwWehpwmuT/k9J6kd6fFiSoPNB18x5WHQt4yjNgN0fe7bo4hmv94I6FZ1
	8rGHpQmeqXTR26d3Z2dMMFl2QGUgKNryAWZgW6ukDwHaQCo+aT8E5KIuKdywpUSxiiRs/M
	+FxbBSJ/UZBI3Fc3HsXXigc1uwAAA2Peem4+a20Pi1SBFNExPaL3M5rBkE8z6VXftS+ke+
	9Dh/HKoKawUk2qn0O/2k+oCsvErqV9D6LxN9ogPf1dvr0etAHLhDsZtiZReyacYIbU2g3J
	oc7IfYXXz79diuJqhKHq0O/RnULUAn5+cQa9YWUZm9aS1NKn6cs/clR05z1XGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736333127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRG6g8ElipN4/ko2ufdEgg7+1az0swozEZ7GGdL3S4k=;
	b=cxkVnG7K4XwyXHtmb/yDjb6TrHXskRtzJxIFtM4AzZVtawN22S9AllohXSaiVQiugB1ry0
	KCfEoJeJNtENp/Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>
Cc: selinux@vger.kernel.org,
	Bram =?utf-8?B?Qm9ubsOp?= <brambonne@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: selinux: error: =?utf-8?B?4oCYTkVUTElO?=
 =?utf-8?B?S19ST1VURV9TT0NLRVRfX05MTVNH4oCZ?= undeclared
Message-ID: <20250108104525.PJL0eRAG@linutronix.de>
References: <20250108082855.PkG-_BaT@linutronix.de>
 <CA+zpnLc1PhF7zfWVCj3qezfvYYHbaOc-FyscWS9y74bXZw3rxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+zpnLc1PhF7zfWVCj3qezfvYYHbaOc-FyscWS9y74bXZw3rxQ@mail.gmail.com>

On 2025-01-08 21:31:15 [+1100], Thi=C3=A9baud Weksteen wrote:
> Thanks for the report. This is a known issue where the generated
> header is not cleaned properly:
> https://lore.kernel.org/selinux/20241127-selinux-clean-v2-1-a6e528c1ff93@=
linutronix.de/
>=20
> Could you try to remove security/selinux/av_permissions.h manually
> from your build directory and build again?

I used a "clean" build directory for this: as in

| make O=3D/dev/shm/build defconfig
| make O=3D/dev/shm/build security/selinux/nlmsgtab.o

and it occurred. But since you gave me the pointer, I had
av_permissions.h in my source directory which did not pop in "git
status" as it was ignored. Now that this is gone, it builds again.
I have no idea who this ended up in my source tree since I build out of
tree.

Anyway, thank you!

Sebastian
